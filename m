Received: from eggs.gnu.org ([2001:4830:134:3::10]:51817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1frqlM-0002x6-2U
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 16:26:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1frqlF-00032E-EH
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 16:26:55 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:46756)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1frqlC-0002og-OG
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 16:26:47 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon, 20 Aug 2018 22:26:04 +0200
Message-Id: <20180820202604.14218-8-laurent@vivier.eu>
In-Reply-To: <20180820202604.14218-1-laurent@vivier.eu>
References: <20180820202604.14218-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 7/7] linux-user: add QEMU_IFLA_INFO_KIND nested
 type for tun
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>, Aurelien Jarno <aurelien@aurel32.net>, Riku Voipio <riku.voipio@iki.fi>, Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20180820171557.7734-5-laurent@vivier.eu>
---
 linux-user/syscall.c | 48 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index c0840107c9..202aa777ad 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -501,6 +501,20 @@ enum {
     QEMU___IFLA_BRPORT_MAX
 };
 
+enum {
+    QEMU_IFLA_TUN_UNSPEC,
+    QEMU_IFLA_TUN_OWNER,
+    QEMU_IFLA_TUN_GROUP,
+    QEMU_IFLA_TUN_TYPE,
+    QEMU_IFLA_TUN_PI,
+    QEMU_IFLA_TUN_VNET_HDR,
+    QEMU_IFLA_TUN_PERSIST,
+    QEMU_IFLA_TUN_MULTI_QUEUE,
+    QEMU_IFLA_TUN_NUM_QUEUES,
+    QEMU_IFLA_TUN_NUM_DISABLED_QUEUES,
+    QEMU___IFLA_TUN_MAX,
+};
+
 enum {
     QEMU_IFLA_INFO_UNSPEC,
     QEMU_IFLA_INFO_KIND,
@@ -2349,6 +2363,34 @@ static abi_long host_to_target_slave_data_bridge_nlattr(struct nlattr *nlattr,
     return 0;
 }
 
+static abi_long host_to_target_data_tun_nlattr(struct nlattr *nlattr,
+                                                  void *context)
+{
+    uint32_t *u32;
+
+    switch (nlattr->nla_type) {
+    /* uint8_t */
+    case QEMU_IFLA_TUN_TYPE:
+    case QEMU_IFLA_TUN_PI:
+    case QEMU_IFLA_TUN_VNET_HDR:
+    case QEMU_IFLA_TUN_PERSIST:
+    case QEMU_IFLA_TUN_MULTI_QUEUE:
+        break;
+    /* uint32_t */
+    case QEMU_IFLA_TUN_NUM_QUEUES:
+    case QEMU_IFLA_TUN_NUM_DISABLED_QUEUES:
+    case QEMU_IFLA_TUN_OWNER:
+    case QEMU_IFLA_TUN_GROUP:
+        u32 = NLA_DATA(nlattr);
+        *u32 = tswap32(*u32);
+        break;
+    default:
+        gemu_log("Unknown QEMU_IFLA_TUN type %d\n", nlattr->nla_type);
+        break;
+    }
+    return 0;
+}
+
 struct linkinfo_context {
     int len;
     char *name;
@@ -2383,6 +2425,12 @@ static abi_long host_to_target_data_linkinfo_nlattr(struct nlattr *nlattr,
                                                   nlattr->nla_len,
                                                   NULL,
                                              host_to_target_data_bridge_nlattr);
+        } else if (strncmp(li_context->name, "tun",
+                    li_context->len) == 0) {
+            return host_to_target_for_each_nlattr(NLA_DATA(nlattr),
+                                                  nlattr->nla_len,
+                                                  NULL,
+                                                host_to_target_data_tun_nlattr);
         } else {
             gemu_log("Unknown QEMU_IFLA_INFO_KIND %s\n", li_context->name);
         }
-- 
2.17.1
