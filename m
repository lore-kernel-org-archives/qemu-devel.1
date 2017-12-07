Received: from eggs.gnu.org ([2001:4830:134:3::10]:34940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eN0VR-0000ps-4B
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 13:02:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eN0VP-0007n3-Ig
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 13:02:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54176)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eN0VP-0007ma-9P
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 13:02:43 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Thu,  7 Dec 2017 19:02:35 +0100
Message-Id: <1512669755-8409-3-git-send-email-thuth@redhat.com>
In-Reply-To: <1512669755-8409-1-git-send-email-thuth@redhat.com>
References: <1512669755-8409-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.12 2/2] net: Remove the deprecated -tftp,
 -bootp, -redir and -smb options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>

These options likely do not work as expected as soon as the user
tries to use more than one network interface at once. The parameters
have been marked as deprecated since QEMU v2.6, so users had plenty
of time to move their scripts to the new syntax. Time to remove the
old parameters now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/net/net.h   |  3 ---
 include/net/slirp.h |  4 ----
 net/slirp.c         | 58 -----------------------------------------------------
 os-posix.c          |  8 --------
 qemu-doc.texi       | 24 ----------------------
 qemu-options.hx     | 15 --------------
 vl.c                | 18 -----------------
 7 files changed, 130 deletions(-)

diff --git a/include/net/net.h b/include/net/net.h
index 1c55a93..670e03e 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -204,9 +204,6 @@ extern NICInfo nd_table[MAX_NICS];
 extern const char *host_net_devices[];
 
 /* from net.c */
-extern const char *legacy_tftp_prefix;
-extern const char *legacy_bootp_filename;
-
 int net_client_init(QemuOpts *opts, bool is_netdev, Error **errp);
 int net_client_parse(QemuOptsList *opts_list, const char *str);
 int net_init_clients(void);
diff --git a/include/net/slirp.h b/include/net/slirp.h
index 0c98e46..2c37fa0 100644
--- a/include/net/slirp.h
+++ b/include/net/slirp.h
@@ -34,10 +34,6 @@
 void hmp_hostfwd_add(Monitor *mon, const QDict *qdict);
 void hmp_hostfwd_remove(Monitor *mon, const QDict *qdict);
 
-int net_slirp_redir(const char *redir_str);
-
-int net_slirp_smb(const char *exported_dir);
-
 void hmp_info_usernet(Monitor *mon, const QDict *qdict);
 
 #endif
diff --git a/net/slirp.c b/net/slirp.c
index cb8ca23..4999a25 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -85,8 +85,6 @@ typedef struct SlirpState {
 } SlirpState;
 
 static struct slirp_config_str *slirp_configs;
-const char *legacy_tftp_prefix;
-const char *legacy_bootp_filename;
 static QTAILQ_HEAD(slirp_stacks, SlirpState) slirp_stacks =
     QTAILQ_HEAD_INITIALIZER(slirp_stacks);
 
@@ -96,8 +94,6 @@ static int slirp_guestfwd(SlirpState *s, const char *config_str,
                           int legacy_format, Error **errp);
 
 #ifndef _WIN32
-static const char *legacy_smb_export;
-
 static int slirp_smb(SlirpState *s, const char *exported_dir,
                      struct in_addr vserver_addr, Error **errp);
 static void slirp_smb_cleanup(SlirpState *s);
@@ -193,13 +189,6 @@ static int net_slirp_init(NetClientState *peer, const char *model,
         return -1;
     }
 
-    if (!tftp_export) {
-        tftp_export = legacy_tftp_prefix;
-    }
-    if (!bootfile) {
-        bootfile = legacy_bootp_filename;
-    }
-
     if (vnetwork) {
         if (get_str_sep(buf, sizeof(buf), &vnetwork, '/') < 0) {
             if (!inet_aton(vnetwork, &net)) {
@@ -386,9 +375,6 @@ static int net_slirp_init(NetClientState *peer, const char *model,
         }
     }
 #ifndef _WIN32
-    if (!smb_export) {
-        smb_export = legacy_smb_export;
-    }
     if (smb_export) {
         if (slirp_smb(s, smb_export, smbsrv, errp) < 0) {
             goto error;
@@ -586,28 +572,6 @@ void hmp_hostfwd_add(Monitor *mon, const QDict *qdict)
 
 }
 
-int net_slirp_redir(const char *redir_str)
-{
-    struct slirp_config_str *config;
-    Error *err = NULL;
-    int res;
-
-    if (QTAILQ_EMPTY(&slirp_stacks)) {
-        config = g_malloc(sizeof(*config));
-        pstrcpy(config->str, sizeof(config->str), redir_str);
-        config->flags = SLIRP_CFG_HOSTFWD | SLIRP_CFG_LEGACY;
-        config->next = slirp_configs;
-        slirp_configs = config;
-        return 0;
-    }
-
-    res = slirp_hostfwd(QTAILQ_FIRST(&slirp_stacks), redir_str, 1, &err);
-    if (res < 0) {
-        error_report_err(err);
-    }
-    return res;
-}
-
 #ifndef _WIN32
 
 /* automatic user mode samba server configuration */
@@ -723,28 +687,6 @@ static int slirp_smb(SlirpState* s, const char *exported_dir,
     return 0;
 }
 
-/* automatic user mode samba server configuration (legacy interface) */
-int net_slirp_smb(const char *exported_dir)
-{
-    struct in_addr vserver_addr = { .s_addr = 0 };
-
-    if (legacy_smb_export) {
-        fprintf(stderr, "-smb given twice\n");
-        return -1;
-    }
-    legacy_smb_export = exported_dir;
-    if (!QTAILQ_EMPTY(&slirp_stacks)) {
-        Error *err = NULL;
-        int res = slirp_smb(QTAILQ_FIRST(&slirp_stacks), exported_dir,
-                            vserver_addr, &err);
-        if (res < 0) {
-            error_report_err(err);
-        }
-        return res;
-    }
-    return 0;
-}
-
 #endif /* !defined(_WIN32) */
 
 struct GuestFwd {
diff --git a/os-posix.c b/os-posix.c
index b9c2343..a1fb6b5 100644
--- a/os-posix.c
+++ b/os-posix.c
@@ -134,14 +134,6 @@ void os_set_proc_name(const char *s)
 void os_parse_cmd_args(int index, const char *optarg)
 {
     switch (index) {
-#ifdef CONFIG_SLIRP
-    case QEMU_OPTION_smb:
-        error_report("The -smb option is deprecated. "
-                     "Please use '-netdev user,smb=...' instead.");
-        if (net_slirp_smb(optarg) < 0)
-            exit(1);
-        break;
-#endif
     case QEMU_OPTION_runas:
         user_pwd = getpwnam(optarg);
         if (!user_pwd) {
diff --git a/qemu-doc.texi b/qemu-doc.texi
index 982cab5..2068b91 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -2435,30 +2435,6 @@ synonym for setting
 ``-object tls-creds-x509,dir=/path/to/certs,id=tls0,verify-peer=yes''
 combined with ``-vnc tls-creds=tls0'
 
-@subsection -tftp (since 2.6.0)
-
-The ``-tftp /some/dir'' argument is now a synonym for setting
-the ``-netdev user,tftp=/some/dir' argument. The new syntax
-allows different settings to be provided per NIC.
-
-@subsection -bootp (since 2.6.0)
-
-The ``-bootp /some/file'' argument is now a synonym for setting
-the ``-netdev user,bootp=/some/file' argument. The new syntax
-allows different settings to be provided per NIC.
-
-@subsection -redir (since 2.6.0)
-
-The ``-redir ARGS'' argument is now a synonym for setting
-the ``-netdev user,hostfwd=ARGS'' argument instead. The new
-syntax allows different settings to be provided per NIC.
-
-@subsection -smb (since 2.6.0)
-
-The ``-smb /some/dir'' argument is now a synonym for setting
-the ``-netdev user,smb=/some/dir'' argument instead. The new
-syntax allows different settings to be provided per NIC.
-
 @subsection -net vlan (since 2.9.0)
 
 The ``-net vlan=NN'' argument is partially replaced with the
diff --git a/qemu-options.hx b/qemu-options.hx
index f11c4ac..9189b82 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1904,16 +1904,6 @@ STEXI
 @table @option
 ETEXI
 
-HXCOMM Legacy slirp options (now moved to -net user):
-#ifdef CONFIG_SLIRP
-DEF("tftp", HAS_ARG, QEMU_OPTION_tftp, "", QEMU_ARCH_ALL)
-DEF("bootp", HAS_ARG, QEMU_OPTION_bootp, "", QEMU_ARCH_ALL)
-DEF("redir", HAS_ARG, QEMU_OPTION_redir, "", QEMU_ARCH_ALL)
-#ifndef _WIN32
-DEF("smb", HAS_ARG, QEMU_OPTION_smb, "", QEMU_ARCH_ALL)
-#endif
-#endif
-
 DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
 #ifdef CONFIG_SLIRP
     "-netdev user,id=str[,ipv4[=on|off]][,net=addr[/mask]][,host=addr]\n"
@@ -2218,11 +2208,6 @@ qemu -net 'user,guestfwd=tcp:10.0.2.100:1234-cmd:netcat 10.10.1.1 4321'
 
 @end table
 
-Note: Legacy stand-alone options -tftp, -bootp, -smb and -redir are still
-processed and applied to -net user. Mixing them with the new configuration
-syntax gives undefined results. Their use for new applications is discouraged
-as they will be removed from future versions.
-
 @item -netdev tap,id=@var{id}[,fd=@var{h}][,ifname=@var{name}][,script=@var{file}][,downscript=@var{dfile}][,br=@var{bridge}][,helper=@var{helper}]
 @itemx -net tap[,vlan=@var{n}][,name=@var{name}][,fd=@var{h}][,ifname=@var{name}][,script=@var{file}][,downscript=@var{dfile}][,br=@var{bridge}][,helper=@var{helper}]
 Connect the host TAP network interface @var{name} to VLAN @var{n}.
diff --git a/vl.c b/vl.c
index 1ad1c04..e6a4653 100644
--- a/vl.c
+++ b/vl.c
@@ -3470,24 +3470,6 @@ int main(int argc, char **argv, char **envp)
                 }
                 break;
 #endif
-#ifdef CONFIG_SLIRP
-            case QEMU_OPTION_tftp:
-                error_report("The -tftp option is deprecated. "
-                             "Please use '-netdev user,tftp=...' instead.");
-                legacy_tftp_prefix = optarg;
-                break;
-            case QEMU_OPTION_bootp:
-                error_report("The -bootp option is deprecated. "
-                             "Please use '-netdev user,bootfile=...' instead.");
-                legacy_bootp_filename = optarg;
-                break;
-            case QEMU_OPTION_redir:
-                error_report("The -redir option is deprecated. "
-                             "Please use '-netdev user,hostfwd=...' instead.");
-                if (net_slirp_redir(optarg) < 0)
-                    exit(1);
-                break;
-#endif
             case QEMU_OPTION_bt:
                 add_device_config(DEV_BT, optarg);
                 break;
-- 
1.8.3.1
