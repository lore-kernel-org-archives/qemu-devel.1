Received: from eggs.gnu.org ([2001:4830:134:3::10]:36621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eRJpH-0001cp-Se
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 10:29:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eRJpF-0007kS-8z
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 10:29:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60598)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eRJpF-0007k4-0R
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 10:29:01 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 19 Dec 2017 16:28:54 +0100
Message-Id: <1513697336-2863-2-git-send-email-thuth@redhat.com>
In-Reply-To: <1513697336-2863-1-git-send-email-thuth@redhat.com>
References: <1513697336-2863-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 1/3] net: Remove the legacy "-net channel"
 parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, peter.maydell@linaro.org

It has never been documented, so hardly anybody knows about this
parameter, and it is marked as deprecated since QEMU v2.6.
Time to let it go now.

Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/net/slirp.h |  2 --
 net/net.c           |  7 -------
 net/slirp.c         | 34 ----------------------------------
 qemu-doc.texi       |  5 -----
 4 files changed, 48 deletions(-)

diff --git a/include/net/slirp.h b/include/net/slirp.h
index 64b795c..0c98e46 100644
--- a/include/net/slirp.h
+++ b/include/net/slirp.h
@@ -36,8 +36,6 @@ void hmp_hostfwd_remove(Monitor *mon, const QDict *qdict);
 
 int net_slirp_redir(const char *redir_str);
 
-int net_slirp_parse_legacy(QemuOptsList *opts_list, const char *optarg, int *ret);
-
 int net_slirp_smb(const char *exported_dir);
 
 void hmp_info_usernet(Monitor *mon, const QDict *qdict);
diff --git a/net/net.c b/net/net.c
index 39ef546..7425857 100644
--- a/net/net.c
+++ b/net/net.c
@@ -1565,13 +1565,6 @@ int net_init_clients(void)
 
 int net_client_parse(QemuOptsList *opts_list, const char *optarg)
 {
-#if defined(CONFIG_SLIRP)
-    int ret;
-    if (net_slirp_parse_legacy(opts_list, optarg, &ret)) {
-        return ret;
-    }
-#endif
-
     if (!qemu_opts_parse_noisily(opts_list, optarg, true)) {
         return -1;
     }
diff --git a/net/slirp.c b/net/slirp.c
index 318a26e..cb8ca23 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -956,37 +956,3 @@ int net_init_slirp(const Netdev *netdev, const char *name,
 
     return ret;
 }
-
-int net_slirp_parse_legacy(QemuOptsList *opts_list, const char *optarg, int *ret)
-{
-    if (strcmp(opts_list->name, "net") != 0 ||
-        strncmp(optarg, "channel,", strlen("channel,")) != 0) {
-        return 0;
-    }
-
-    error_report("The '-net channel' option is deprecated. "
-                 "Please use '-netdev user,guestfwd=...' instead.");
-
-    /* handle legacy -net channel,port:chr */
-    optarg += strlen("channel,");
-
-    if (QTAILQ_EMPTY(&slirp_stacks)) {
-        struct slirp_config_str *config;
-
-        config = g_malloc(sizeof(*config));
-        pstrcpy(config->str, sizeof(config->str), optarg);
-        config->flags = SLIRP_CFG_LEGACY;
-        config->next = slirp_configs;
-        slirp_configs = config;
-        *ret = 0;
-    } else {
-        Error *err = NULL;
-        *ret = slirp_guestfwd(QTAILQ_FIRST(&slirp_stacks), optarg, 1, &err);
-        if (*ret < 0) {
-            error_report_err(err);
-        }
-    }
-
-    return 1;
-}
-
diff --git a/qemu-doc.texi b/qemu-doc.texi
index f7317df..09680f9 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -2459,11 +2459,6 @@ The ``-smb /some/dir'' argument is now a synonym for setting
 the ``-netdev user,smb=/some/dir'' argument instead. The new
 syntax allows different settings to be provided per NIC.
 
-@subsection -net channel (since 2.6.0)
-
-The ``--net channel,ARGS'' argument is now a synonym for setting
-the ``-netdev user,guestfwd=ARGS'' argument instead.
-
 @subsection -net vlan (since 2.9.0)
 
 The ``-net vlan=NN'' argument is partially replaced with the
-- 
1.8.3.1
