Received: from eggs.gnu.org ([2001:4830:134:3::10]:34957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <morecache@gmail.com>) id 1fSFok-0001Ym-Sd
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 01:56:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <morecache@gmail.com>) id 1fSFoh-00074K-Si
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 01:56:38 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:36085)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <morecache@gmail.com>) id 1fSFoh-00073l-Mp
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 01:56:35 -0400
Received: by mail-pg0-x241.google.com with SMTP id m5-v6so9207766pgd.3
	for <qemu-devel@nongnu.org>; Sun, 10 Jun 2018 22:56:35 -0700 (PDT)
Sender: Lin Ma <morecache@gmail.com>
From: Lin Ma <lma@suse.com>
Date: Mon, 11 Jun 2018 13:53:52 +0800
Message-Id: <20180611055352.8097-1-lma@suse.com>
Subject: [Qemu-devel]  [PATCH] net: Fix a potential segfault
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jasowang@redhat.com, thuth@redhat.com, Lin Ma <lma@suse.com>

Signed-off-by: Lin Ma <lma@suse.com>
---
 net/net.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/net.c b/net/net.c
index efb9eaf779..f89790be4a 100644
--- a/net/net.c
+++ b/net/net.c
@@ -1093,9 +1093,12 @@ static int net_client_init(QemuOpts *opts, bool is_netdev, Error **errp)
     int ret = -1;
     Visitor *v = opts_visitor_new(opts);
 
-    if (is_netdev && is_help_option(qemu_opt_get(opts, "type"))) {
-        show_netdevs();
-        exit(0);
+    if (is_netdev) {
+        const char *type = qemu_opt_get(opts, "type");
+        if (type && is_help_option(type)) {
+            show_netdevs();
+            exit(0);
+        }
     } else {
         /* Parse convenience option format ip6-net=fec0::0[/64] */
         const char *ip6_net = qemu_opt_get(opts, "ipv6-net");
-- 
2.16.2
