Received: from eggs.gnu.org ([2001:4830:134:3::10]:54414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cxVC5-000054-Dt
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 05:01:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cxVBz-0002DE-HD
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 05:01:05 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3029
	helo=dggrg01-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cxVBy-0002Bd-Bp
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 05:00:59 -0400
From: "Longpeng(Mike)" <longpeng2@huawei.com>
Date: Mon, 10 Apr 2017 17:00:40 +0800
Message-ID: <1491814840-63048-1-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH for-2.10 12/19] socket: add af_alg family
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: berrange@redhat.com, kraxel@redhat.com, pbonzini@redhat.com, eblake@redhat.com, armbru@redhat.com
Cc: xuquan8@huawei.com, arei.gonglei@huawei.com, qemu-devel@nongnu.org, "Longpeng(Mike)" <longpeng2@huawei.com>

The AF_ALG socket family is the userspace interface for linux
crypto API, this patch adds af_alg family support. It'll be used
by afalg-backend crypto later.

Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
---
 configure              | 21 ++++++++++++
 include/qemu/sockets.h |  6 ++++
 qapi-schema.json       | 21 +++++++++++-
 util/qemu-sockets.c    | 91 ++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 138 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index 4b3b5cd..970c9bc 100755
--- a/configure
+++ b/configure
@@ -4737,6 +4737,23 @@ if compile_prog "" "" ; then
     have_af_vsock=yes
 fi
 
+##########################################
+# check for usable AF_ALG environment
+hava_af_alg=no
+cat > $TMPC << EOF
+#include <errno.h>
+#include <sys/types.h>
+#include <sys/socket.h>
+int main(void) {
+    int sock;
+    sock = socket(AF_ALG, SOCK_SEQPACKET, 0);
+    return sock;
+}
+EOF
+if compile_prog "" "" ; then
+    have_af_alg=yes
+fi
+
 #################################################
 # Sparc implicitly links with --relax, which is
 # incompatible with -r, so --no-relax should be
@@ -5767,6 +5784,10 @@ if test "$have_af_vsock" = "yes" ; then
   echo "CONFIG_AF_VSOCK=y" >> $config_host_mak
 fi
 
+if test "$have_af_alg" = "yes" ; then
+  echo "CONFIG_AF_ALG=y" >> $config_host_mak
+fi
+
 if test "$have_sysmacros" = "yes" ; then
   echo "CONFIG_SYSMACROS=y" >> $config_host_mak
 fi
diff --git a/include/qemu/sockets.h b/include/qemu/sockets.h
index 7842f6d..0a4a003 100644
--- a/include/qemu/sockets.h
+++ b/include/qemu/sockets.h
@@ -51,6 +51,12 @@ int socket_listen(SocketAddress *addr, Error **errp);
 void socket_listen_cleanup(int fd, Error **errp);
 int socket_dgram(SocketAddress *remote, SocketAddress *local, Error **errp);
 
+#ifdef CONFIG_AF_ALG
+#define SALG_TYPE_LEN_MAX 14
+#define SALG_NAME_LEN_MAX 64
+int socket_bind(SocketAddress *addr, Error **errp);
+#endif
+
 /* Old, ipv4 only bits.  Don't use for new code. */
 int parse_host_port(struct sockaddr_in *saddr, const char *str);
 int socket_init(void);
diff --git a/qapi-schema.json b/qapi-schema.json
index 250e4dc..0cb06d3 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -1516,12 +1516,14 @@
 #
 # @vsock: vsock family (since 2.8)
 #
+# @afalg: af_alg family (since 2.10)
+#
 # @unknown: otherwise
 #
 # Since: 2.1
 ##
 { 'enum': 'NetworkAddressFamily',
-  'data': [ 'ipv4', 'ipv6', 'unix', 'vsock', 'unknown' ] }
+  'data': [ 'ipv4', 'ipv6', 'unix', 'vsock', 'afalg', 'unknown' ] }
 
 ##
 # @VncBasicInfo:
@@ -4119,6 +4121,22 @@
     'port': 'str' } }
 
 ##
+# @AfalgSocketAddress:
+#
+# Captures a socket address in the af_alg namespace.
+#
+# @type: type of the crypto algogrithms
+#
+# @name: name of the crypto algogrithms
+#
+# Since: 2.10
+##
+{ 'struct': 'AfalgSocketAddress',
+  'data': {
+    'type': 'str',
+    'name': 'str' }}
+
+##
 # @SocketAddress:
 #
 # Captures the address of a socket, which could also be a named file descriptor
@@ -4130,6 +4148,7 @@
     'inet': 'InetSocketAddress',
     'unix': 'UnixSocketAddress',
     'vsock': 'VsockSocketAddress',
+    'afalg': 'AfalgSocketAddress',
     'fd': 'String' } }
 
 ##
diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index 21442c3..258e419 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -1151,6 +1151,97 @@ void socket_listen_cleanup(int fd, Error **errp)
     qapi_free_SocketAddress(addr);
 }
 
+#ifdef CONFIG_AF_ALG
+
+#include <linux/if_alg.h>
+
+static bool afalg_parse_bind_saddr(const AfalgSocketAddress *saddr,
+                                   struct sockaddr_alg *alg,
+                                   Error **errp)
+{
+    memset(alg, 0, sizeof(*alg));
+    alg->salg_family = AF_ALG;
+
+    if (qemu_strnlen(saddr->type, SALG_TYPE_LEN_MAX) == SALG_TYPE_LEN_MAX) {
+        error_setg(errp, "Afalg type(%s) is larger than 14 bytes",
+                   saddr->type);
+        return false;
+    }
+
+    if (qemu_strnlen(saddr->name, SALG_NAME_LEN_MAX) == SALG_NAME_LEN_MAX) {
+        error_setg(errp, "Afalg name(%s) is larger than 64 bytes",
+                   saddr->name);
+        return false;
+    }
+
+    pstrcpy((char *)alg->salg_type, SALG_TYPE_LEN_MAX, saddr->type);
+    pstrcpy((char *)alg->salg_name, SALG_NAME_LEN_MAX, saddr->name);
+
+    return true;
+}
+
+static int afalg_bind_saddr(const AfalgSocketAddress *saddr,
+                            Error **errp)
+{
+    struct sockaddr_alg alg;
+    int sbind;
+
+    if (!afalg_parse_bind_saddr(saddr, &alg, errp)) {
+        return -1;
+    }
+
+    sbind = qemu_socket(AF_ALG, SOCK_SEQPACKET, 0);
+    if (sbind < 0) {
+        error_setg_errno(errp, errno, "Failed to create socket");
+        return -1;
+    }
+
+    if (bind(sbind, (const struct sockaddr *)&alg, sizeof(alg)) != 0) {
+        error_setg_errno(errp, errno, "Failed to bind socket");
+        closesocket(sbind);
+        return -1;
+    }
+
+    return sbind;
+}
+
+/*
+ * Due to af_alg family doesn't support listen(), so we should
+ * use socket_bind() instead of socket_listen(). However, for
+ * other families, we should always use socket_listen().
+ */
+int socket_bind(SocketAddress *addr, Error **errp)
+{
+    int fd;
+
+    switch (addr->type) {
+    case SOCKET_ADDRESS_KIND_AFALG:
+        fd = afalg_bind_saddr(addr->u.afalg.data, errp);
+        break;
+
+    default:
+        abort();
+    }
+
+    return fd;
+}
+
+#else
+
+static void afalg_unsupported(Error **errp)
+{
+    error_setg(errp, "socket family AF_ALG unsupported");
+}
+
+static int afalg_bind_saddr(AfalgSocketAddress *vaddr,
+                            Error **errp)
+{
+    afalg_unsupported(errp);
+    return -1;
+}
+
+#endif
+
 int socket_dgram(SocketAddress *remote, SocketAddress *local, Error **errp)
 {
     int fd;
-- 
1.8.3.1
