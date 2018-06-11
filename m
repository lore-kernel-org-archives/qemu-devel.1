Received: from eggs.gnu.org ([2001:4830:134:3::10]:39208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <morecache@gmail.com>) id 1fSJ4x-0006eP-MO
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 05:25:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <morecache@gmail.com>) id 1fSJ4u-0008K2-FT
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 05:25:35 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:39318)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <morecache@gmail.com>) id 1fSJ4u-0008Jk-Ai
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 05:25:32 -0400
Received: by mail-pf0-x242.google.com with SMTP id r11-v6so9918593pfl.6
	for <qemu-devel@nongnu.org>; Mon, 11 Jun 2018 02:25:32 -0700 (PDT)
Sender: Lin Ma <morecache@gmail.com>
From: Lin Ma <lma@suse.com>
Date: Mon, 11 Jun 2018 17:23:05 +0800
Message-Id: <20180611092305.2542-1-lma@suse.com>
Subject: [Qemu-devel]  [PATCH v3] net: Fix a potential segfault
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
 net/net.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/net.c b/net/net.c
index efb9eaf779..2a3133990c 100644
--- a/net/net.c
+++ b/net/net.c
@@ -1093,7 +1093,9 @@ static int net_client_init(QemuOpts *opts, bool is_netdev, Error **errp)
     int ret = -1;
     Visitor *v = opts_visitor_new(opts);
 
-    if (is_netdev && is_help_option(qemu_opt_get(opts, "type"))) {
+    const char *type = qemu_opt_get(opts, "type");
+
+    if (is_netdev && type && is_help_option(type)) {
         show_netdevs();
         exit(0);
     } else {
-- 
2.16.2
