Received: from eggs.gnu.org ([2001:4830:134:3::10]:45014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <morecache@gmail.com>) id 1fSGwr-0001Fn-2x
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 03:09:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <morecache@gmail.com>) id 1fSGwl-0003RE-It
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 03:09:05 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:46315)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <morecache@gmail.com>) id 1fSGwl-0003QW-Bu
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 03:08:59 -0400
Received: by mail-pf0-x244.google.com with SMTP id q1-v6so9720095pff.13
	for <qemu-devel@nongnu.org>; Mon, 11 Jun 2018 00:08:59 -0700 (PDT)
Sender: Lin Ma <morecache@gmail.com>
From: Lin Ma <lma@suse.com>
Date: Mon, 11 Jun 2018 15:06:09 +0800
Message-Id: <20180611070609.9482-1-lma@suse.com>
Subject: [Qemu-devel]  [PATCH v2] net: Fix a potential segfault
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, jasowang@redhat.com, Lin Ma <lma@suse.com>

If user forgets to provide any backend types for '-netdev' in qemu CLI,
It triggers seg fault.

e.g.

Expected:
$ qemu -netdev id=net0
qemu-system-x86_64: Parameter 'type' is missing

Actual:
$ qemu -netdev id=net0
Segmentation fault (core dumped)

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
