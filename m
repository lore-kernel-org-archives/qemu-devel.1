Received: from eggs.gnu.org ([2001:4830:134:3::10]:43209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fTezh-0000d4-I4
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 23:01:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fTezd-0002WW-4s
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 23:01:45 -0400
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 15 Jun 2018 11:01:21 +0800
Message-Id: <1529031683-27458-3-git-send-email-jasowang@redhat.com>
In-Reply-To: <1529031683-27458-1-git-send-email-jasowang@redhat.com>
References: <1529031683-27458-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 2/4] net: Fix a potential segfault
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: Lin Ma <lma@suse.com>, qemu-stable@nongnu.org, Jason Wang <jasowang@redhat.com>

From: Lin Ma <lma@suse.com>

If user forgets to provide any backend types for '-netdev' in qemu CLI,
It triggers seg fault.

e.g.

Expected:
$ qemu -netdev id=net0
qemu-system-x86_64: Parameter 'type' is missing

Actual:
$ qemu -netdev id=net0
Segmentation fault (core dumped)

Fixes: 547203ead4327 ("net: List available netdevs with "-netdev help")
Reviewed-by: Thomas Huth <thuth@redhat.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Lin Ma <lma@suse.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/net.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/net.c b/net/net.c
index efb9eaf..2a31339 100644
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
2.7.4
