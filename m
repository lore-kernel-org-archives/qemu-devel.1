Received: from eggs.gnu.org ([2001:4830:134:3::10]:38985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1frW1k-0002T3-4E
	for qemu-devel@nongnu.org; Sun, 19 Aug 2018 18:18:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1frW1f-0003Pz-MQ
	for qemu-devel@nongnu.org; Sun, 19 Aug 2018 18:18:27 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:58527)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1frW1f-0003Pc-EJ
	for qemu-devel@nongnu.org; Sun, 19 Aug 2018 18:18:23 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon, 20 Aug 2018 00:17:07 +0200
Message-Id: <20180819221707.20693-7-laurent@vivier.eu>
In-Reply-To: <20180819221707.20693-1-laurent@vivier.eu>
References: <20180819221707.20693-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 6/6] linux-user: add QEMU_IFLA_INFO_KIND nested
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
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20180814161904.12216-4-laurent@vivier.eu>
---
 linux-user/syscall.c | 48 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index da1fcaf4ca..424296d1a1 100644
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
@@ -2315,6 +2329,34 @@ static abi_long host_to_target_slave_data_bridge_nlattr(struct nlattr *nlattr,
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
@@ -2349,6 +2391,12 @@ static abi_long host_to_target_data_linkinfo_nlattr(struct nlattr *nlattr,
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
