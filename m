Received: from eggs.gnu.org ([2001:4830:134:3::10]:33856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d42Uw-0004ez-Qj
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 05:47:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d42Us-0001Sx-9r
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 05:47:34 -0400
Received: from [59.151.112.132] (port=49865 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d42Ur-0001QD-TZ
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 05:47:30 -0400
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Fri, 28 Apr 2017 17:47:12 +0800
Message-ID: <1493372840-24551-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
In-Reply-To: <1493372840-24551-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
References: <1493372840-24551-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH V3 02/10] net/tap.c: Add tap_get_vnet_hdr_len
 and tap_get_using_vnet_hdr function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>
Cc: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, weifuqiang <weifuqiang@huawei.com>, "eddie
	. dong" <eddie.dong@intel.com>, bian naimeng <biannm@cn.fujitsu.com>, Li Zhijian <lizhijian@cn.fujitsu.com>

Make tap backend support get_vnet_hdr_len.

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
---
 net/tap-win32.c | 12 ++++++++++++
 net/tap.c       | 20 ++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/net/tap-win32.c b/net/tap-win32.c
index 662f9b6..337e8ea 100644
--- a/net/tap-win32.c
+++ b/net/tap-win32.c
@@ -729,6 +729,11 @@ static void tap_using_vnet_hdr(NetClientState *nc, bool using_vnet_hdr)
 {
 }
 
+static void tap_get_using_vnet_hdr(NetClientState *nc)
+{
+    return false;
+}
+
 static void tap_set_offload(NetClientState *nc, int csum, int tso4,
                      int tso6, int ecn, int ufo)
 {
@@ -744,6 +749,11 @@ static bool tap_has_vnet_hdr_len(NetClientState *nc, int len)
     return false;
 }
 
+static int tap_get_vnet_hdr_len(NetClientState *nc)
+{
+    return 0;
+}
+
 static void tap_set_vnet_hdr_len(NetClientState *nc, int len)
 {
     abort();
@@ -757,7 +767,9 @@ static NetClientInfo net_tap_win32_info = {
     .has_ufo = tap_has_ufo,
     .has_vnet_hdr = tap_has_vnet_hdr,
     .has_vnet_hdr_len = tap_has_vnet_hdr_len,
+    .get_vnet_hdr_len = tap_get_vnet_hdr_len,
     .using_vnet_hdr = tap_using_vnet_hdr,
+    .get_using_vnet_hdr = tap_get_using_vnet_hdr,
     .set_offload = tap_set_offload,
     .set_vnet_hdr_len = tap_set_vnet_hdr_len,
 };
diff --git a/net/tap.c b/net/tap.c
index 979e622..214c83d 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -246,6 +246,15 @@ static bool tap_has_vnet_hdr_len(NetClientState *nc, int len)
     return !!tap_probe_vnet_hdr_len(s->fd, len);
 }
 
+static int tap_get_vnet_hdr_len(NetClientState *nc)
+{
+    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+
+    assert(nc->info->type == NET_CLIENT_DRIVER_TAP);
+
+    return s->host_vnet_hdr_len;
+}
+
 static void tap_set_vnet_hdr_len(NetClientState *nc, int len)
 {
     TAPState *s = DO_UPCAST(TAPState, nc, nc);
@@ -268,6 +277,15 @@ static void tap_using_vnet_hdr(NetClientState *nc, bool using_vnet_hdr)
     s->using_vnet_hdr = using_vnet_hdr;
 }
 
+static bool tap_get_using_vnet_hdr(NetClientState *nc)
+{
+    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+
+    assert(nc->info->type == NET_CLIENT_DRIVER_TAP);
+
+    return s->using_vnet_hdr;
+}
+
 static int tap_set_vnet_le(NetClientState *nc, bool is_le)
 {
     TAPState *s = DO_UPCAST(TAPState, nc, nc);
@@ -354,7 +372,9 @@ static NetClientInfo net_tap_info = {
     .has_ufo = tap_has_ufo,
     .has_vnet_hdr = tap_has_vnet_hdr,
     .has_vnet_hdr_len = tap_has_vnet_hdr_len,
+    .get_vnet_hdr_len = tap_get_vnet_hdr_len,
     .using_vnet_hdr = tap_using_vnet_hdr,
+    .get_using_vnet_hdr = tap_get_using_vnet_hdr,
     .set_offload = tap_set_offload,
     .set_vnet_hdr_len = tap_set_vnet_hdr_len,
     .set_vnet_le = tap_set_vnet_le,
-- 
2.7.4
