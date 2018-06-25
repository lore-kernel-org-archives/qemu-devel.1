Received: from eggs.gnu.org ([2001:4830:134:3::10]:56182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ptoscano@redhat.com>) id 1fXVYz-0002yM-UI
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 13:46:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ptoscano@redhat.com>) id 1fXVYv-0004EU-Ft
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 13:46:05 -0400
From: Pino Toscano <ptoscano@redhat.com>
Date: Mon, 25 Jun 2018 19:45:45 +0200
Message-Id: <20180625174545.26989-1-ptoscano@redhat.com>
Subject: [Qemu-devel] [PATCH v5] ssh: switch from libssh2 to libssh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: rjones@redhat.com, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com, ptoscano@redhat.com

Rewrite the implementation of the ssh block driver to use libssh instead
of libssh2.  The libssh library has various advantages over libssh2:
- easier API for authentication (for example for using ssh-agent)
- easier API for known_hosts handling
- supports newer types of keys in known_hosts

Kerberos authentication can be enabled once the libssh bug for it [1] is
fixed.

The development version of libssh (i.e. the future 0.8.x) supports
fsync, so reuse the build time check for this.

[1] https://red.libssh.org/issues/242

Signed-off-by: Pino Toscano <ptoscano@redhat.com>
---

Changes from v4:
- fix wrong usages of error_setg/session_error_setg/sftp_error_setg
- fix few return code checks
- remove now-unused parameters in few internal functions
- allow authentication with "none" method
- switch to unsigned int for the port number
- enable TCP_NODELAY on the socket
- fix one reference error message in iotest 207

Changes from v3:
- fix socket cleanup in connect_to_ssh()
- add comments about the socket cleanup
- improve the error reporting (closer to what was with libssh2)
- improve EOF detection on sftp_read()

Changes from v2:
- used again an own fd
- fixed co_yield() implementation

Changes from v1:
- fixed jumbo packets writing
- fixed missing 'err' assignment
- fixed commit message

 block/Makefile.objs        |   6 +-
 block/ssh.c                | 566 ++++++++++++++++++-------------------
 configure                  |  65 +++--
 tests/qemu-iotests/207.out |   2 +-
 4 files changed, 307 insertions(+), 332 deletions(-)

diff --git a/block/Makefile.objs b/block/Makefile.objs
index 899bfb5e2c..9c3b3bfb99 100644
--- a/block/Makefile.objs
+++ b/block/Makefile.objs
@@ -21,7 +21,7 @@ block-obj-$(CONFIG_CURL) += curl.o
 block-obj-$(CONFIG_RBD) += rbd.o
 block-obj-$(CONFIG_GLUSTERFS) += gluster.o
 block-obj-$(CONFIG_VXHS) += vxhs.o
-block-obj-$(CONFIG_LIBSSH2) += ssh.o
+block-obj-$(CONFIG_LIBSSH) += ssh.o
 block-obj-y += accounting.o dirty-bitmap.o
 block-obj-y += write-threshold.o
 block-obj-y += backup.o
@@ -42,8 +42,8 @@ rbd.o-libs         := $(RBD_LIBS)
 gluster.o-cflags   := $(GLUSTERFS_CFLAGS)
 gluster.o-libs     := $(GLUSTERFS_LIBS)
 vxhs.o-libs        := $(VXHS_LIBS)
-ssh.o-cflags       := $(LIBSSH2_CFLAGS)
-ssh.o-libs         := $(LIBSSH2_LIBS)
+ssh.o-cflags       := $(LIBSSH_CFLAGS)
+ssh.o-libs         := $(LIBSSH_LIBS)
 block-obj-$(if $(CONFIG_BZIP2),m,n) += dmg-bz2.o
 dmg-bz2.o-libs     := $(BZIP2_LIBS)
 qcow.o-libs        := -lz
diff --git a/block/ssh.c b/block/ssh.c
index da7bbf73e2..787245230a 100644
--- a/block/ssh.c
+++ b/block/ssh.c
@@ -24,8 +24,8 @@
 
 #include "qemu/osdep.h"
 
-#include <libssh2.h>
-#include <libssh2_sftp.h>
+#include <libssh/libssh.h>
+#include <libssh/sftp.h>
 
 #include "block/block_int.h"
 #include "block/qdict.h"
@@ -45,14 +45,12 @@
 /* DEBUG_SSH=1 enables the DPRINTF (debugging printf) statements in
  * this block driver code.
  *
- * TRACE_LIBSSH2=<bitmask> enables tracing in libssh2 itself.  Note
- * that this requires that libssh2 was specially compiled with the
- * `./configure --enable-debug' option, so most likely you will have
- * to compile it yourself.  The meaning of <bitmask> is described
- * here: http://www.libssh2.org/libssh2_trace.html
+ * TRACE_LIBSSH=<level> enables tracing in libssh itself.
+ * The meaning of <level> is described here:
+ * http://api.libssh.org/master/group__libssh__log.html
  */
 #define DEBUG_SSH     0
-#define TRACE_LIBSSH2 0 /* or try: LIBSSH2_TRACE_SFTP */
+#define TRACE_LIBSSH  0 /* see: SSH_LOG_* */
 
 #define DPRINTF(fmt, ...)                           \
     do {                                            \
@@ -68,18 +66,14 @@ typedef struct BDRVSSHState {
 
     /* SSH connection. */
     int sock;                         /* socket */
-    LIBSSH2_SESSION *session;         /* ssh session */
-    LIBSSH2_SFTP *sftp;               /* sftp session */
-    LIBSSH2_SFTP_HANDLE *sftp_handle; /* sftp remote file handle */
+    ssh_session session;              /* ssh session */
+    sftp_session sftp;                /* sftp session */
+    sftp_file sftp_handle;            /* sftp remote file handle */
 
-    /* See ssh_seek() function below. */
-    int64_t offset;
-    bool offset_op_read;
-
-    /* File attributes at open.  We try to keep the .filesize field
+    /* File attributes at open.  We try to keep the .size field
      * updated if it changes (eg by writing at the end of the file).
      */
-    LIBSSH2_SFTP_ATTRIBUTES attrs;
+    sftp_attributes attrs;
 
     InetSocketAddress *inet;
 
@@ -91,27 +85,25 @@ static void ssh_state_init(BDRVSSHState *s)
 {
     memset(s, 0, sizeof *s);
     s->sock = -1;
-    s->offset = -1;
     qemu_co_mutex_init(&s->lock);
 }
 
 static void ssh_state_free(BDRVSSHState *s)
 {
+    if (s->attrs) {
+        sftp_attributes_free(s->attrs);
+    }
     if (s->sftp_handle) {
-        libssh2_sftp_close(s->sftp_handle);
+        sftp_close(s->sftp_handle);
     }
     if (s->sftp) {
-        libssh2_sftp_shutdown(s->sftp);
+        sftp_free(s->sftp);
     }
     if (s->session) {
-        libssh2_session_disconnect(s->session,
-                                   "from qemu ssh client: "
-                                   "user closed the connection");
-        libssh2_session_free(s->session);
-    }
-    if (s->sock >= 0) {
-        close(s->sock);
+        ssh_disconnect(s->session);
+        ssh_free(s->session);
     }
+    /* s->sock is owned by the ssh_session, which frees it. */
 }
 
 static void GCC_FMT_ATTR(3, 4)
@@ -125,13 +117,13 @@ session_error_setg(Error **errp, BDRVSSHState *s, const char *fs, ...)
     va_end(args);
 
     if (s->session) {
-        char *ssh_err;
+        const char *ssh_err;
         int ssh_err_code;
 
-        /* This is not an errno.  See <libssh2.h>. */
-        ssh_err_code = libssh2_session_last_error(s->session,
-                                                  &ssh_err, NULL, 0);
-        error_setg(errp, "%s: %s (libssh2 error code: %d)",
+        /* This is not an errno.  See <libssh/libssh.h>. */
+        ssh_err = ssh_get_error(s->session);
+        ssh_err_code = ssh_get_error_code(s->session);
+        error_setg(errp, "%s: %s (libssh error code: %d)",
                    msg, ssh_err, ssh_err_code);
     } else {
         error_setg(errp, "%s", msg);
@@ -150,18 +142,18 @@ sftp_error_setg(Error **errp, BDRVSSHState *s, const char *fs, ...)
     va_end(args);
 
     if (s->sftp) {
-        char *ssh_err;
+        const char *ssh_err;
         int ssh_err_code;
-        unsigned long sftp_err_code;
+        int sftp_err_code;
 
-        /* This is not an errno.  See <libssh2.h>. */
-        ssh_err_code = libssh2_session_last_error(s->session,
-                                                  &ssh_err, NULL, 0);
-        /* See <libssh2_sftp.h>. */
-        sftp_err_code = libssh2_sftp_last_error((s)->sftp);
+        /* This is not an errno.  See <libssh/libssh.h>. */
+        ssh_err = ssh_get_error(s->session);
+        ssh_err_code = ssh_get_error_code(s->session);
+        /* See <libssh/sftp.h>. */
+        sftp_err_code = sftp_get_error(s->sftp);
 
         error_setg(errp,
-                   "%s: %s (libssh2 error code: %d, sftp error code: %lu)",
+                   "%s: %s (libssh error code: %d, sftp error code: %d)",
                    msg, ssh_err, ssh_err_code, sftp_err_code);
     } else {
         error_setg(errp, "%s", msg);
@@ -178,17 +170,17 @@ sftp_error_report(BDRVSSHState *s, const char *fs, ...)
     error_vprintf(fs, args);
 
     if ((s)->sftp) {
-        char *ssh_err;
+        const char *ssh_err;
         int ssh_err_code;
-        unsigned long sftp_err_code;
+        int sftp_err_code;
 
-        /* This is not an errno.  See <libssh2.h>. */
-        ssh_err_code = libssh2_session_last_error(s->session,
-                                                  &ssh_err, NULL, 0);
-        /* See <libssh2_sftp.h>. */
-        sftp_err_code = libssh2_sftp_last_error((s)->sftp);
+        /* This is not an errno.  See <libssh/libssh.h>. */
+        ssh_err = ssh_get_error(s->session);
+        ssh_err_code = ssh_get_error_code(s->session);
+        /* See <libssh/sftp.h>. */
+        sftp_err_code = sftp_get_error(s->sftp);
 
-        error_printf(": %s (libssh2 error code: %d, sftp error code: %lu)",
+        error_printf(": %s (libssh error code: %d, sftp error code: %d)",
                      ssh_err, ssh_err_code, sftp_err_code);
     }
 
@@ -292,71 +284,41 @@ static void ssh_parse_filename(const char *filename, QDict *options,
     parse_uri(filename, options, errp);
 }
 
-static int check_host_key_knownhosts(BDRVSSHState *s,
-                                     const char *host, int port, Error **errp)
+static int check_host_key_knownhosts(BDRVSSHState *s, Error **errp)
 {
-    const char *home;
-    char *knh_file = NULL;
-    LIBSSH2_KNOWNHOSTS *knh = NULL;
-    struct libssh2_knownhost *found;
-    int ret, r;
-    const char *hostkey;
-    size_t len;
-    int type;
+    int ret;
+    int state;
 
-    hostkey = libssh2_session_hostkey(s->session, &len, &type);
-    if (!hostkey) {
-        ret = -EINVAL;
-        session_error_setg(errp, s, "failed to read remote host key");
-        goto out;
-    }
+    state = ssh_is_server_known(s->session);
 
-    knh = libssh2_knownhost_init(s->session);
-    if (!knh) {
-        ret = -EINVAL;
-        session_error_setg(errp, s,
-                           "failed to initialize known hosts support");
-        goto out;
-    }
-
-    home = getenv("HOME");
-    if (home) {
-        knh_file = g_strdup_printf("%s/.ssh/known_hosts", home);
-    } else {
-        knh_file = g_strdup_printf("/root/.ssh/known_hosts");
-    }
-
-    /* Read all known hosts from OpenSSH-style known_hosts file. */
-    libssh2_knownhost_readfile(knh, knh_file, LIBSSH2_KNOWNHOST_FILE_OPENSSH);
-
-    r = libssh2_knownhost_checkp(knh, host, port, hostkey, len,
-                                 LIBSSH2_KNOWNHOST_TYPE_PLAIN|
-                                 LIBSSH2_KNOWNHOST_KEYENC_RAW,
-                                 &found);
-    switch (r) {
-    case LIBSSH2_KNOWNHOST_CHECK_MATCH:
+    switch (state) {
+    case SSH_SERVER_KNOWN_OK:
         /* OK */
-        DPRINTF("host key OK: %s", found->key);
         break;
-    case LIBSSH2_KNOWNHOST_CHECK_MISMATCH:
+    case SSH_SERVER_KNOWN_CHANGED:
         ret = -EINVAL;
-        session_error_setg(errp, s,
-                      "host key does not match the one in known_hosts"
-                      " (found key %s)", found->key);
+        error_setg(errp, "host key does not match the one in known_hosts");
         goto out;
-    case LIBSSH2_KNOWNHOST_CHECK_NOTFOUND:
+    case SSH_SERVER_FOUND_OTHER:
         ret = -EINVAL;
-        session_error_setg(errp, s, "no host key was found in known_hosts");
+        error_setg(errp,
+                   "host key for this server not found, another type exists");
         goto out;
-    case LIBSSH2_KNOWNHOST_CHECK_FAILURE:
+    case SSH_SERVER_FILE_NOT_FOUND:
+        ret = -ENOENT;
+        error_setg(errp, "known_hosts file not found");
+        goto out;
+    case SSH_SERVER_NOT_KNOWN:
+        ret = -EINVAL;
+        error_setg(errp, "no host key was found in known_hosts");
+        goto out;
+    case SSH_SERVER_ERROR:
         ret = -EINVAL;
-        session_error_setg(errp, s,
-                      "failure matching the host key with known_hosts");
+        error_setg(errp, "server error");
         goto out;
     default:
         ret = -EINVAL;
-        session_error_setg(errp, s, "unknown error matching the host key"
-                      " with known_hosts (%d)", r);
+        error_setg(errp, "error while checking for known server");
         goto out;
     }
 
@@ -364,10 +326,6 @@ static int check_host_key_knownhosts(BDRVSSHState *s,
     ret = 0;
 
  out:
-    if (knh != NULL) {
-        libssh2_knownhost_free(knh);
-    }
-    g_free(knh_file);
     return ret;
 }
 
@@ -411,18 +369,30 @@ static int compare_fingerprint(const unsigned char *fingerprint, size_t len,
 
 static int
 check_host_key_hash(BDRVSSHState *s, const char *hash,
-                    int hash_type, size_t fingerprint_len, Error **errp)
+                    enum ssh_publickey_hash_type type, Error **errp)
 {
-    const char *fingerprint;
+    int r;
+    ssh_key pubkey;
+    unsigned char *server_hash;
+    size_t server_hash_len;
 
-    fingerprint = libssh2_hostkey_hash(s->session, hash_type);
-    if (!fingerprint) {
+    r = ssh_get_publickey(s->session, &pubkey);
+    if (r != SSH_OK) {
         session_error_setg(errp, s, "failed to read remote host key");
         return -EINVAL;
     }
 
-    if(compare_fingerprint((unsigned char *) fingerprint, fingerprint_len,
-                           hash) != 0) {
+    r = ssh_get_publickey_hash(pubkey, type, &server_hash, &server_hash_len);
+    ssh_key_free(pubkey);
+    if (r != 0) {
+        session_error_setg(errp, s,
+                           "failed reading the hash of the server SSH key");
+        return -EINVAL;
+    }
+
+    r = compare_fingerprint(server_hash, server_hash_len, hash);
+    ssh_clean_pubkey_hash(&server_hash);
+    if (r != 0) {
         error_setg(errp, "remote host key does not match host_key_check '%s'",
                    hash);
         return -EPERM;
@@ -431,8 +401,7 @@ check_host_key_hash(BDRVSSHState *s, const char *hash,
     return 0;
 }
 
-static int check_host_key(BDRVSSHState *s, const char *host, int port,
-                          SshHostKeyCheck *hkc, Error **errp)
+static int check_host_key(BDRVSSHState *s, SshHostKeyCheck *hkc, Error **errp)
 {
     SshHostKeyCheckMode mode;
 
@@ -448,15 +417,15 @@ static int check_host_key(BDRVSSHState *s, const char *host, int port,
     case SSH_HOST_KEY_CHECK_MODE_HASH:
         if (hkc->u.hash.type == SSH_HOST_KEY_CHECK_HASH_TYPE_MD5) {
             return check_host_key_hash(s, hkc->u.hash.hash,
-                                       LIBSSH2_HOSTKEY_HASH_MD5, 16, errp);
+                                       SSH_PUBLICKEY_HASH_MD5, errp);
         } else if (hkc->u.hash.type == SSH_HOST_KEY_CHECK_HASH_TYPE_SHA1) {
             return check_host_key_hash(s, hkc->u.hash.hash,
-                                       LIBSSH2_HOSTKEY_HASH_SHA1, 20, errp);
+                                       SSH_PUBLICKEY_HASH_SHA1, errp);
         }
         g_assert_not_reached();
         break;
     case SSH_HOST_KEY_CHECK_MODE_KNOWN_HOSTS:
-        return check_host_key_knownhosts(s, host, port, errp);
+        return check_host_key_knownhosts(s, errp);
     default:
         g_assert_not_reached();
     }
@@ -464,60 +433,41 @@ static int check_host_key(BDRVSSHState *s, const char *host, int port,
     return -EINVAL;
 }
 
-static int authenticate(BDRVSSHState *s, const char *user, Error **errp)
+static int authenticate(BDRVSSHState *s, Error **errp)
 {
     int r, ret;
-    const char *userauthlist;
-    LIBSSH2_AGENT *agent = NULL;
-    struct libssh2_agent_publickey *identity;
-    struct libssh2_agent_publickey *prev_identity = NULL;
+    int method;
 
-    userauthlist = libssh2_userauth_list(s->session, user, strlen(user));
-    if (strstr(userauthlist, "publickey") == NULL) {
+    /* Try to authenticate with the "none" method. */
+    r = ssh_userauth_none(s->session, NULL);
+    if (r == SSH_AUTH_ERROR) {
         ret = -EPERM;
-        error_setg(errp,
-                "remote server does not support \"publickey\" authentication");
+        session_error_setg(errp, s, "failed to authenticate using none "
+                                    "authentication");
         goto out;
-    }
-
-    /* Connect to ssh-agent and try each identity in turn. */
-    agent = libssh2_agent_init(s->session);
-    if (!agent) {
-        ret = -EINVAL;
-        session_error_setg(errp, s, "failed to initialize ssh-agent support");
-        goto out;
-    }
-    if (libssh2_agent_connect(agent)) {
-        ret = -ECONNREFUSED;
-        session_error_setg(errp, s, "failed to connect to ssh-agent");
-        goto out;
-    }
-    if (libssh2_agent_list_identities(agent)) {
-        ret = -EINVAL;
-        session_error_setg(errp, s,
-                           "failed requesting identities from ssh-agent");
+    } else if (r == SSH_AUTH_SUCCESS) {
+        /* Authenticated! */
+        ret = 0;
         goto out;
     }
 
-    for(;;) {
-        r = libssh2_agent_get_identity(agent, &identity, prev_identity);
-        if (r == 1) {           /* end of list */
-            break;
-        }
-        if (r < 0) {
+    method = ssh_userauth_list(s->session, NULL);
+
+    /* Try to authenticate with publickey, using the ssh-agent
+     * if available.
+     */
+    if (method & SSH_AUTH_METHOD_PUBLICKEY) {
+        r = ssh_userauth_publickey_auto(s->session, NULL, NULL);
+        if (r == SSH_AUTH_ERROR) {
             ret = -EINVAL;
-            session_error_setg(errp, s,
-                               "failed to obtain identity from ssh-agent");
+            session_error_setg(errp, s, "failed to authenticate using "
+                                        "publickey authentication");
             goto out;
-        }
-        r = libssh2_agent_userauth(agent, user, identity);
-        if (r == 0) {
+        } else if (r == SSH_AUTH_SUCCESS) {
             /* Authenticated! */
             ret = 0;
             goto out;
         }
-        /* Failed to authenticate with this identity, try the next one. */
-        prev_identity = identity;
     }
 
     ret = -EPERM;
@@ -525,13 +475,6 @@ static int authenticate(BDRVSSHState *s, const char *user, Error **errp)
                "and the identities held by your ssh-agent");
 
  out:
-    if (agent != NULL) {
-        /* Note: libssh2 implementation implicitly calls
-         * libssh2_agent_disconnect if necessary.
-         */
-        libssh2_agent_free(agent);
-    }
-
     return ret;
 }
 
@@ -651,7 +594,8 @@ static int connect_to_ssh(BDRVSSHState *s, BlockdevOptionsSsh *opts,
 {
     int r, ret;
     const char *user;
-    long port = 0;
+    unsigned int port = 0;
+    int new_sock = -1;
 
     if (opts->has_user) {
         user = opts->user;
@@ -668,54 +612,117 @@ static int connect_to_ssh(BDRVSSHState *s, BlockdevOptionsSsh *opts,
     s->inet = opts->server;
     opts->server = NULL;
 
-    if (qemu_strtol(s->inet->port, NULL, 10, &port) < 0) {
+    if (qemu_strtoui(s->inet->port, NULL, 10, &port) < 0) {
         error_setg(errp, "Use only numeric port value");
         ret = -EINVAL;
         goto err;
     }
 
     /* Open the socket and connect. */
-    s->sock = inet_connect_saddr(s->inet, errp);
-    if (s->sock < 0) {
+    new_sock = inet_connect_saddr(s->inet, errp);
+    if (new_sock < 0) {
         ret = -EIO;
         goto err;
     }
 
+    /* Try to disable the Nagle algorithm on TCP sockets to reduce latency,
+     * but do not fail if it cannot be disabled.
+     */
+    r = socket_set_nodelay(new_sock);
+    if (r < 0) {
+        warn_report("setting NODELAY for the ssh server %s failed: %m",
+                    s->inet->host);
+    }
+
     /* Create SSH session. */
-    s->session = libssh2_session_init();
+    s->session = ssh_new();
     if (!s->session) {
         ret = -EINVAL;
-        session_error_setg(errp, s, "failed to initialize libssh2 session");
+        session_error_setg(errp, s, "failed to initialize libssh session");
         goto err;
     }
 
-#if TRACE_LIBSSH2 != 0
-    libssh2_trace(s->session, TRACE_LIBSSH2);
-#endif
+    /* Make sure we are in blocking mode during the connection and
+     * authentication phases.
+     */
+    ssh_set_blocking(s->session, 1);
 
-    r = libssh2_session_handshake(s->session, s->sock);
-    if (r != 0) {
+    r = ssh_options_set(s->session, SSH_OPTIONS_USER, user);
+    if (r < 0) {
+        ret = -EINVAL;
+        session_error_setg(errp, s,
+                           "failed to set the user in the libssh session");
+        goto err;
+    }
+
+    r = ssh_options_set(s->session, SSH_OPTIONS_HOST, s->inet->host);
+    if (r < 0) {
+        ret = -EINVAL;
+        session_error_setg(errp, s,
+                           "failed to set the host in the libssh session");
+        goto err;
+    }
+
+    if (port > 0) {
+        r = ssh_options_set(s->session, SSH_OPTIONS_PORT, &port);
+        if (r < 0) {
+            ret = -EINVAL;
+            session_error_setg(errp, s,
+                               "failed to set the port in the libssh session");
+            goto err;
+        }
+    }
+
+    /* Read ~/.ssh/config. */
+    r = ssh_options_parse_config(s->session, NULL);
+    if (r < 0) {
+        ret = -EINVAL;
+        session_error_setg(errp, s, "failed to parse ~/.ssh/config");
+        goto err;
+    }
+
+    r = ssh_options_set(s->session, SSH_OPTIONS_FD, &new_sock);
+    if (r < 0) {
+        ret = -EINVAL;
+        session_error_setg(errp, s,
+                           "failed to set the socket in the libssh session");
+        goto err;
+    }
+    /* libssh took ownership of the socket. */
+    s->sock = new_sock;
+    new_sock = -1;
+
+    /* Connect. */
+    r = ssh_connect(s->session);
+    if (r != SSH_OK) {
         ret = -EINVAL;
         session_error_setg(errp, s, "failed to establish SSH session");
         goto err;
     }
 
     /* Check the remote host's key against known_hosts. */
-    ret = check_host_key(s, s->inet->host, port, opts->host_key_check, errp);
+    ret = check_host_key(s, opts->host_key_check, errp);
     if (ret < 0) {
         goto err;
     }
 
     /* Authenticate. */
-    ret = authenticate(s, user, errp);
+    ret = authenticate(s, errp);
     if (ret < 0) {
         goto err;
     }
 
     /* Start SFTP. */
-    s->sftp = libssh2_sftp_init(s->session);
+    s->sftp = sftp_new(s->session);
     if (!s->sftp) {
-        session_error_setg(errp, s, "failed to initialize sftp handle");
+        session_error_setg(errp, s, "failed to create sftp handle");
+        ret = -EINVAL;
+        goto err;
+    }
+
+    r = sftp_init(s->sftp);
+    if (r < 0) {
+        sftp_error_setg(errp, s, "failed to initialize sftp handle");
         ret = -EINVAL;
         goto err;
     }
@@ -723,17 +730,19 @@ static int connect_to_ssh(BDRVSSHState *s, BlockdevOptionsSsh *opts,
     /* Open the remote file. */
     DPRINTF("opening file %s flags=0x%x creat_mode=0%o",
             opts->path, ssh_flags, creat_mode);
-    s->sftp_handle = libssh2_sftp_open(s->sftp, opts->path, ssh_flags,
-                                       creat_mode);
+    s->sftp_handle = sftp_open(s->sftp, opts->path, ssh_flags, creat_mode);
     if (!s->sftp_handle) {
-        session_error_setg(errp, s, "failed to open remote file '%s'",
-                           opts->path);
+        sftp_error_setg(errp, s, "failed to open remote file '%s'",
+                        opts->path);
         ret = -EINVAL;
         goto err;
     }
 
-    r = libssh2_sftp_fstat(s->sftp_handle, &s->attrs);
-    if (r < 0) {
+    /* Make sure the SFTP file is handled in blocking mode. */
+    sftp_file_set_blocking(s->sftp_handle);
+
+    s->attrs = sftp_fstat(s->sftp_handle);
+    if (!s->attrs) {
         sftp_error_setg(errp, s, "failed to read file attributes");
         return -EINVAL;
     }
@@ -741,21 +750,26 @@ static int connect_to_ssh(BDRVSSHState *s, BlockdevOptionsSsh *opts,
     return 0;
 
  err:
+    if (s->attrs) {
+        sftp_attributes_free(s->attrs);
+    }
+    s->attrs = NULL;
     if (s->sftp_handle) {
-        libssh2_sftp_close(s->sftp_handle);
+        sftp_close(s->sftp_handle);
     }
     s->sftp_handle = NULL;
     if (s->sftp) {
-        libssh2_sftp_shutdown(s->sftp);
+        sftp_free(s->sftp);
     }
     s->sftp = NULL;
     if (s->session) {
-        libssh2_session_disconnect(s->session,
-                                   "from qemu ssh client: "
-                                   "error opening connection");
-        libssh2_session_free(s->session);
+        ssh_disconnect(s->session);
+        ssh_free(s->session);
     }
     s->session = NULL;
+    if (new_sock >= 0) {
+        close(new_sock);
+    }
 
     return ret;
 }
@@ -770,9 +784,11 @@ static int ssh_file_open(BlockDriverState *bs, QDict *options, int bdrv_flags,
 
     ssh_state_init(s);
 
-    ssh_flags = LIBSSH2_FXF_READ;
+    ssh_flags = 0;
     if (bdrv_flags & BDRV_O_RDWR) {
-        ssh_flags |= LIBSSH2_FXF_WRITE;
+        ssh_flags |= O_RDWR;
+    } else {
+        ssh_flags |= O_RDONLY;
     }
 
     opts = ssh_parse_options(options, errp);
@@ -787,16 +803,13 @@ static int ssh_file_open(BlockDriverState *bs, QDict *options, int bdrv_flags,
     }
 
     /* Go non-blocking. */
-    libssh2_session_set_blocking(s->session, 0);
+    ssh_set_blocking(s->session, 0);
 
     qapi_free_BlockdevOptionsSsh(opts);
 
     return 0;
 
  err:
-    if (s->sock >= 0) {
-        close(s->sock);
-    }
     s->sock = -1;
 
     qapi_free_BlockdevOptionsSsh(opts);
@@ -809,25 +822,25 @@ static int ssh_grow_file(BDRVSSHState *s, int64_t offset, Error **errp)
 {
     ssize_t ret;
     char c[1] = { '\0' };
-    int was_blocking = libssh2_session_get_blocking(s->session);
+    int was_blocking = ssh_is_blocking(s->session);
 
     /* offset must be strictly greater than the current size so we do
      * not overwrite anything */
-    assert(offset > 0 && offset > s->attrs.filesize);
+    assert(offset > 0 && offset > s->attrs->size);
 
-    libssh2_session_set_blocking(s->session, 1);
+    ssh_set_blocking(s->session, 1);
 
-    libssh2_sftp_seek64(s->sftp_handle, offset - 1);
-    ret = libssh2_sftp_write(s->sftp_handle, c, 1);
+    sftp_seek64(s->sftp_handle, offset - 1);
+    ret = sftp_write(s->sftp_handle, c, 1);
 
-    libssh2_session_set_blocking(s->session, was_blocking);
+    ssh_set_blocking(s->session, was_blocking);
 
     if (ret < 0) {
         sftp_error_setg(errp, s, "Failed to grow file");
         return -EIO;
     }
 
-    s->attrs.filesize = offset;
+    s->attrs->size = offset;
     return 0;
 }
 
@@ -855,8 +868,7 @@ static int ssh_co_create(BlockdevCreateOptions *options, Error **errp)
     ssh_state_init(&s);
 
     ret = connect_to_ssh(&s, opts->location,
-                         LIBSSH2_FXF_READ|LIBSSH2_FXF_WRITE|
-                         LIBSSH2_FXF_CREAT|LIBSSH2_FXF_TRUNC,
+                         O_RDWR | O_CREAT | O_TRUNC,
                          0644, errp);
     if (ret < 0) {
         goto fail;
@@ -925,10 +937,8 @@ static int ssh_has_zero_init(BlockDriverState *bs)
     /* Assume false, unless we can positively prove it's true. */
     int has_zero_init = 0;
 
-    if (s->attrs.flags & LIBSSH2_SFTP_ATTR_PERMISSIONS) {
-        if (s->attrs.permissions & LIBSSH2_SFTP_S_IFREG) {
-            has_zero_init = 1;
-        }
+    if (s->attrs->type == SSH_FILEXFER_TYPE_REGULAR) {
+        has_zero_init = 1;
     }
 
     return has_zero_init;
@@ -965,12 +975,12 @@ static coroutine_fn void co_yield(BDRVSSHState *s, BlockDriverState *bs)
         .co = qemu_coroutine_self()
     };
 
-    r = libssh2_session_block_directions(s->session);
+    r = ssh_get_poll_flags(s->session);
 
-    if (r & LIBSSH2_SESSION_BLOCK_INBOUND) {
+    if (r & SSH_READ_PENDING) {
         rd_handler = restart_coroutine;
     }
-    if (r & LIBSSH2_SESSION_BLOCK_OUTBOUND) {
+    if (r & SSH_WRITE_PENDING) {
         wr_handler = restart_coroutine;
     }
 
@@ -983,33 +993,6 @@ static coroutine_fn void co_yield(BDRVSSHState *s, BlockDriverState *bs)
     DPRINTF("s->sock=%d - back", s->sock);
 }
 
-/* SFTP has a function `libssh2_sftp_seek64' which seeks to a position
- * in the remote file.  Notice that it just updates a field in the
- * sftp_handle structure, so there is no network traffic and it cannot
- * fail.
- *
- * However, `libssh2_sftp_seek64' does have a catastrophic effect on
- * performance since it causes the handle to throw away all in-flight
- * reads and buffered readahead data.  Therefore this function tries
- * to be intelligent about when to call the underlying libssh2 function.
- */
-#define SSH_SEEK_WRITE 0
-#define SSH_SEEK_READ  1
-#define SSH_SEEK_FORCE 2
-
-static void ssh_seek(BDRVSSHState *s, int64_t offset, int flags)
-{
-    bool op_read = (flags & SSH_SEEK_READ) != 0;
-    bool force = (flags & SSH_SEEK_FORCE) != 0;
-
-    if (force || op_read != s->offset_op_read || offset != s->offset) {
-        DPRINTF("seeking to offset=%" PRIi64, offset);
-        libssh2_sftp_seek64(s->sftp_handle, offset);
-        s->offset = offset;
-        s->offset_op_read = op_read;
-    }
-}
-
 static coroutine_fn int ssh_read(BDRVSSHState *s, BlockDriverState *bs,
                                  int64_t offset, size_t size,
                                  QEMUIOVector *qiov)
@@ -1021,7 +1004,7 @@ static coroutine_fn int ssh_read(BDRVSSHState *s, BlockDriverState *bs,
 
     DPRINTF("offset=%" PRIi64 " size=%zu", offset, size);
 
-    ssh_seek(s, offset, SSH_SEEK_READ);
+    sftp_seek64(s->sftp_handle, offset);
 
     /* This keeps track of the current iovec element ('i'), where we
      * will write to next ('buf'), and the end of the current iovec
@@ -1031,35 +1014,34 @@ static coroutine_fn int ssh_read(BDRVSSHState *s, BlockDriverState *bs,
     buf = i->iov_base;
     end_of_vec = i->iov_base + i->iov_len;
 
-    /* libssh2 has a hard-coded limit of 2000 bytes per request,
-     * although it will also do readahead behind our backs.  Therefore
-     * we may have to do repeated reads here until we have read 'size'
-     * bytes.
-     */
     for (got = 0; got < size; ) {
     again:
-        DPRINTF("sftp_read buf=%p size=%zu", buf, end_of_vec - buf);
-        r = libssh2_sftp_read(s->sftp_handle, buf, end_of_vec - buf);
-        DPRINTF("sftp_read returned %zd", r);
+        DPRINTF("sftp_read buf=%p size=%zu (actual size=%zu)",
+                buf, end_of_vec - buf, MIN(end_of_vec - buf, 16384));
+        /* The size of SFTP packets is limited to 32K bytes, so limit
+         * the amount of data requested to 16K, as libssh currently
+         * does not handle multiple requests on its own:
+         * https://red.libssh.org/issues/58
+         */
+        r = sftp_read(s->sftp_handle, buf, MIN(end_of_vec - buf, 16384));
+        DPRINTF("sftp_read returned %zd/%d", r, sftp_get_error(s->sftp));
 
-        if (r == LIBSSH2_ERROR_EAGAIN || r == LIBSSH2_ERROR_TIMEOUT) {
+        if (r == SSH_AGAIN) {
             co_yield(s, bs);
             goto again;
         }
-        if (r < 0) {
-            sftp_error_report(s, "read failed");
-            s->offset = -1;
-            return -EIO;
-        }
-        if (r == 0) {
+        if (r == SSH_EOF || (r == 0 && sftp_get_error(s->sftp) == SSH_FX_EOF)) {
             /* EOF: Short read so pad the buffer with zeroes and return it. */
             qemu_iovec_memset(qiov, got, 0, size - got);
             return 0;
         }
+        if (r <= 0) {
+            sftp_error_report(s, "read failed");
+            return -EIO;
+        }
 
         got += r;
         buf += r;
-        s->offset += r;
         if (buf >= end_of_vec && got < size) {
             i++;
             buf = i->iov_base;
@@ -1096,7 +1078,7 @@ static int ssh_write(BDRVSSHState *s, BlockDriverState *bs,
 
     DPRINTF("offset=%" PRIi64 " size=%zu", offset, size);
 
-    ssh_seek(s, offset, SSH_SEEK_WRITE);
+    sftp_seek64(s->sftp_handle, offset);
 
     /* This keeps track of the current iovec element ('i'), where we
      * will read from next ('buf'), and the end of the current iovec
@@ -1108,45 +1090,35 @@ static int ssh_write(BDRVSSHState *s, BlockDriverState *bs,
 
     for (written = 0; written < size; ) {
     again:
-        DPRINTF("sftp_write buf=%p size=%zu", buf, end_of_vec - buf);
-        r = libssh2_sftp_write(s->sftp_handle, buf, end_of_vec - buf);
-        DPRINTF("sftp_write returned %zd", r);
+        DPRINTF("sftp_write buf=%p size=%zu (actual size=%zu)",
+                buf, end_of_vec - buf, MIN(end_of_vec - buf, 131072));
+        /* Avoid too large data packets, as libssh currently does not
+         * handle multiple requests on its own:
+         * https://red.libssh.org/issues/58
+         */
+        r = sftp_write(s->sftp_handle, buf, MIN(end_of_vec - buf, 131072));
+        DPRINTF("sftp_write returned %zd/%d", r, sftp_get_error(s->sftp));
 
-        if (r == LIBSSH2_ERROR_EAGAIN || r == LIBSSH2_ERROR_TIMEOUT) {
+        if (r == SSH_AGAIN) {
             co_yield(s, bs);
             goto again;
         }
         if (r < 0) {
             sftp_error_report(s, "write failed");
-            s->offset = -1;
             return -EIO;
         }
-        /* The libssh2 API is very unclear about this.  A comment in
-         * the code says "nothing was acked, and no EAGAIN was
-         * received!" which apparently means that no data got sent
-         * out, and the underlying channel didn't return any EAGAIN
-         * indication.  I think this is a bug in either libssh2 or
-         * OpenSSH (server-side).  In any case, forcing a seek (to
-         * discard libssh2 internal buffers), and then trying again
-         * works for me.
-         */
-        if (r == 0) {
-            ssh_seek(s, offset + written, SSH_SEEK_WRITE|SSH_SEEK_FORCE);
-            co_yield(s, bs);
-            goto again;
-        }
 
         written += r;
         buf += r;
-        s->offset += r;
         if (buf >= end_of_vec && written < size) {
             i++;
             buf = i->iov_base;
             end_of_vec = i->iov_base + i->iov_len;
         }
 
-        if (offset + written > s->attrs.filesize)
-            s->attrs.filesize = offset + written;
+        if (offset + written > s->attrs->size) {
+            s->attrs->size = offset + written;
+        }
     }
 
     return 0;
@@ -1181,24 +1153,24 @@ static void unsafe_flush_warning(BDRVSSHState *s, const char *what)
     }
 }
 
-#ifdef HAS_LIBSSH2_SFTP_FSYNC
+#ifdef HAS_LIBSSH_SFTP_FSYNC
 
 static coroutine_fn int ssh_flush(BDRVSSHState *s, BlockDriverState *bs)
 {
     int r;
 
     DPRINTF("fsync");
+
+    if (!sftp_extension_supported(s->sftp, "fsync@openssh.com", "1")) {
+        unsafe_flush_warning(s, "OpenSSH >= 6.3");
+        return 0;
+    }
  again:
-    r = libssh2_sftp_fsync(s->sftp_handle);
-    if (r == LIBSSH2_ERROR_EAGAIN || r == LIBSSH2_ERROR_TIMEOUT) {
+    r = sftp_fsync(s->sftp_handle);
+    if (r == SSH_AGAIN) {
         co_yield(s, bs);
         goto again;
     }
-    if (r == LIBSSH2_ERROR_SFTP_PROTOCOL &&
-        libssh2_sftp_last_error(s->sftp) == LIBSSH2_FX_OP_UNSUPPORTED) {
-        unsafe_flush_warning(s, "OpenSSH >= 6.3");
-        return 0;
-    }
     if (r < 0) {
         sftp_error_report(s, "fsync failed");
         return -EIO;
@@ -1219,25 +1191,25 @@ static coroutine_fn int ssh_co_flush(BlockDriverState *bs)
     return ret;
 }
 
-#else /* !HAS_LIBSSH2_SFTP_FSYNC */
+#else /* !HAS_LIBSSH_SFTP_FSYNC */
 
 static coroutine_fn int ssh_co_flush(BlockDriverState *bs)
 {
     BDRVSSHState *s = bs->opaque;
 
-    unsafe_flush_warning(s, "libssh2 >= 1.4.4");
+    unsafe_flush_warning(s, "libssh >= 0.8.0");
     return 0;
 }
 
-#endif /* !HAS_LIBSSH2_SFTP_FSYNC */
+#endif /* !HAS_LIBSSH_SFTP_FSYNC */
 
 static int64_t ssh_getlength(BlockDriverState *bs)
 {
     BDRVSSHState *s = bs->opaque;
     int64_t length;
 
-    /* Note we cannot make a libssh2 call here. */
-    length = (int64_t) s->attrs.filesize;
+    /* Note we cannot make a libssh call here. */
+    length = (int64_t) s->attrs->size;
     DPRINTF("length=%" PRIi64, length);
 
     return length;
@@ -1254,12 +1226,12 @@ static int ssh_truncate(BlockDriverState *bs, int64_t offset,
         return -ENOTSUP;
     }
 
-    if (offset < s->attrs.filesize) {
+    if (offset < s->attrs->size) {
         error_setg(errp, "ssh driver does not support shrinking files");
         return -ENOTSUP;
     }
 
-    if (offset == s->attrs.filesize) {
+    if (offset == s->attrs->size) {
         return 0;
     }
 
@@ -1288,12 +1260,16 @@ static void bdrv_ssh_init(void)
 {
     int r;
 
-    r = libssh2_init(0);
+    r = ssh_init();
     if (r != 0) {
-        fprintf(stderr, "libssh2 initialization failed, %d\n", r);
+        fprintf(stderr, "libssh initialization failed, %d\n", r);
         exit(EXIT_FAILURE);
     }
 
+#if TRACE_LIBSSH != 0
+    ssh_set_log_level(TRACE_LIBSSH);
+#endif
+
     bdrv_register(&bdrv_ssh);
 }
 
diff --git a/configure b/configure
index 4d12cfbe3f..9d24fa9087 100755
--- a/configure
+++ b/configure
@@ -447,7 +447,7 @@ gcrypt_kdf="no"
 vte=""
 virglrenderer=""
 tpm="yes"
-libssh2=""
+libssh=""
 live_block_migration="yes"
 numa=""
 tcmalloc="no"
@@ -1357,9 +1357,9 @@ for opt do
   ;;
   --enable-tpm) tpm="yes"
   ;;
-  --disable-libssh2) libssh2="no"
+  --disable-libssh) libssh="no"
   ;;
-  --enable-libssh2) libssh2="yes"
+  --enable-libssh) libssh="yes"
   ;;
   --disable-live-block-migration) live_block_migration="no"
   ;;
@@ -1669,7 +1669,7 @@ disabled with --disable-FEATURE, default is enabled if available:
   coroutine-pool  coroutine freelist (better performance)
   glusterfs       GlusterFS backend
   tpm             TPM support
-  libssh2         ssh block device support
+  libssh          ssh block device support
   numa            libnuma support
   libxml2         for Parallels image format
   tcmalloc        tcmalloc support
@@ -3665,43 +3665,42 @@ EOF
 fi
 
 ##########################################
-# libssh2 probe
-min_libssh2_version=1.2.8
-if test "$libssh2" != "no" ; then
-  if $pkg_config --atleast-version=$min_libssh2_version libssh2; then
-    libssh2_cflags=$($pkg_config libssh2 --cflags)
-    libssh2_libs=$($pkg_config libssh2 --libs)
-    libssh2=yes
+# libssh probe
+if test "$libssh" != "no" ; then
+  if $pkg_config --exists libssh; then
+    libssh_cflags=$($pkg_config libssh --cflags)
+    libssh_libs=$($pkg_config libssh --libs)
+    libssh=yes
   else
-    if test "$libssh2" = "yes" ; then
-      error_exit "libssh2 >= $min_libssh2_version required for --enable-libssh2"
+    if test "$libssh" = "yes" ; then
+      error_exit "libssh required for --enable-libssh"
     fi
-    libssh2=no
+    libssh=no
   fi
 fi
 
 ##########################################
-# libssh2_sftp_fsync probe
+# libssh sftp_fsync probe
 
-if test "$libssh2" = "yes"; then
+if test "$libssh" = "yes"; then
   cat > $TMPC <<EOF
 #include <stdio.h>
-#include <libssh2.h>
-#include <libssh2_sftp.h>
+#include <libssh/libssh.h>
+#include <libssh/sftp.h>
 int main(void) {
-    LIBSSH2_SESSION *session;
-    LIBSSH2_SFTP *sftp;
-    LIBSSH2_SFTP_HANDLE *sftp_handle;
-    session = libssh2_session_init ();
-    sftp = libssh2_sftp_init (session);
-    sftp_handle = libssh2_sftp_open (sftp, "/", 0, 0);
-    libssh2_sftp_fsync (sftp_handle);
+    ssh_session session;
+    sftp_session sftp;
+    sftp_file sftp_handle;
+    session = ssh_new();
+    sftp = sftp_new(session);
+    sftp_handle = sftp_open(sftp, "/", 0, 0);
+    sftp_fsync(sftp_handle);
     return 0;
 }
 EOF
-  # libssh2_cflags/libssh2_libs defined in previous test.
-  if compile_prog "$libssh2_cflags" "$libssh2_libs" ; then
-    QEMU_CFLAGS="-DHAS_LIBSSH2_SFTP_FSYNC $QEMU_CFLAGS"
+  # libssh_cflags/libssh_libs defined in previous test.
+  if compile_prog "$libssh_cflags" "$libssh_libs" ; then
+    QEMU_CFLAGS="-DHAS_LIBSSH_SFTP_FSYNC $QEMU_CFLAGS"
   fi
 fi
 
@@ -5956,7 +5955,7 @@ echo "GlusterFS support $glusterfs"
 echo "gcov              $gcov_tool"
 echo "gcov enabled      $gcov"
 echo "TPM support       $tpm"
-echo "libssh2 support   $libssh2"
+echo "libssh support    $libssh"
 echo "TPM passthrough   $tpm_passthrough"
 echo "TPM emulator      $tpm_emulator"
 echo "QOM debugging     $qom_cast_debug"
@@ -6604,10 +6603,10 @@ if test "$glusterfs_zerofill" = "yes" ; then
   echo "CONFIG_GLUSTERFS_ZEROFILL=y" >> $config_host_mak
 fi
 
-if test "$libssh2" = "yes" ; then
-  echo "CONFIG_LIBSSH2=m" >> $config_host_mak
-  echo "LIBSSH2_CFLAGS=$libssh2_cflags" >> $config_host_mak
-  echo "LIBSSH2_LIBS=$libssh2_libs" >> $config_host_mak
+if test "$libssh" = "yes" ; then
+  echo "CONFIG_LIBSSH=m" >> $config_host_mak
+  echo "LIBSSH_CFLAGS=$libssh_cflags" >> $config_host_mak
+  echo "LIBSSH_LIBS=$libssh_libs" >> $config_host_mak
 fi
 
 if test "$live_block_migration" = "yes" ; then
diff --git a/tests/qemu-iotests/207.out b/tests/qemu-iotests/207.out
index 078b7e63cb..566a4f35e6 100644
--- a/tests/qemu-iotests/207.out
+++ b/tests/qemu-iotests/207.out
@@ -68,7 +68,7 @@ virtual size: 4.0M (4194304 bytes)
 
 {'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'ssh', 'location': {'path': '/this/is/not/an/existing/path', 'host-key-check': {'mode': 'none'}, 'server': {'host': '127.0.0.1', 'port': '22'}}, 'size': 4194304}}}
 {u'return': {}}
-Job failed: failed to open remote file '/this/is/not/an/existing/path': Failed opening remote file (libssh2 error code: -31)
+Job failed: failed to open remote file '/this/is/not/an/existing/path': SFTP server: No such file (libssh error code: 1, sftp error code: 2)
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
 {u'return': {}}
 
-- 
2.17.1
