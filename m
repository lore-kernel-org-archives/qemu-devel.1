Received: from eggs.gnu.org ([2001:4830:134:3::10]:54104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dAoPH-0002RB-Vl
	for qemu-devel@nongnu.org; Tue, 16 May 2017 22:09:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dAoPH-00060z-0W
	for qemu-devel@nongnu.org; Tue, 16 May 2017 22:09:43 -0400
Received: from [59.151.112.132] (port=61592 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dAoPG-0005z7-AO
	for qemu-devel@nongnu.org; Tue, 16 May 2017 22:09:42 -0400
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Wed, 17 May 2017 10:09:39 +0800
Message-ID: <1494986980-11277-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
In-Reply-To: <1494986980-11277-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
References: <1494986980-11277-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH V3 2/3] net/filter-mirror.c: Rename
 filter_mirror_send() and fix codestyle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>
Cc: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Eric Blake <eblake@redhat.com>

Because filter_mirror_receive_iov() and filter_redirector_receive_iov()
both use the filter_mirror_send() to send packet, so I change
filter_mirror_send() to filter_send() that looks more common.
And fix some codestyle.

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
---
 net/filter-mirror.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/net/filter-mirror.c b/net/filter-mirror.c
index fd0322f..8b1b069 100644
--- a/net/filter-mirror.c
+++ b/net/filter-mirror.c
@@ -43,9 +43,9 @@ typedef struct MirrorState {
     SocketReadState rs;
 } MirrorState;
 
-static int filter_mirror_send(CharBackend *chr_out,
-                              const struct iovec *iov,
-                              int iovcnt)
+static int filter_send(CharBackend *chr_out,
+                       const struct iovec *iov,
+                       int iovcnt)
 {
     int ret = 0;
     ssize_t size = 0;
@@ -141,9 +141,9 @@ static ssize_t filter_mirror_receive_iov(NetFilterState *nf,
     MirrorState *s = FILTER_MIRROR(nf);
     int ret;
 
-    ret = filter_mirror_send(&s->chr_out, iov, iovcnt);
+    ret = filter_send(&s->chr_out, iov, iovcnt);
     if (ret) {
-        error_report("filter_mirror_send failed(%s)", strerror(-ret));
+        error_report("filter mirror send failed(%s)", strerror(-ret));
     }
 
     /*
@@ -164,9 +164,9 @@ static ssize_t filter_redirector_receive_iov(NetFilterState *nf,
     int ret;
 
     if (qemu_chr_fe_get_driver(&s->chr_out)) {
-        ret = filter_mirror_send(&s->chr_out, iov, iovcnt);
+        ret = filter_send(&s->chr_out, iov, iovcnt);
         if (ret) {
-            error_report("filter_mirror_send failed(%s)", strerror(-ret));
+            error_report("filter redirector send failed(%s)", strerror(-ret));
         }
         return iov_size(iov, iovcnt);
     } else {
@@ -286,8 +286,9 @@ static char *filter_redirector_get_indev(Object *obj, Error **errp)
     return g_strdup(s->indev);
 }
 
-static void
-filter_redirector_set_indev(Object *obj, const char *value, Error **errp)
+static void filter_redirector_set_indev(Object *obj,
+                                        const char *value,
+                                        Error **errp)
 {
     MirrorState *s = FILTER_REDIRECTOR(obj);
 
@@ -302,8 +303,9 @@ static char *filter_mirror_get_outdev(Object *obj, Error **errp)
     return g_strdup(s->outdev);
 }
 
-static void
-filter_mirror_set_outdev(Object *obj, const char *value, Error **errp)
+static void filter_mirror_set_outdev(Object *obj,
+                                     const char *value,
+                                     Error **errp)
 {
     MirrorState *s = FILTER_MIRROR(obj);
 
@@ -323,8 +325,9 @@ static char *filter_redirector_get_outdev(Object *obj, Error **errp)
     return g_strdup(s->outdev);
 }
 
-static void
-filter_redirector_set_outdev(Object *obj, const char *value, Error **errp)
+static void filter_redirector_set_outdev(Object *obj,
+                                         const char *value,
+                                         Error **errp)
 {
     MirrorState *s = FILTER_REDIRECTOR(obj);
 
-- 
2.7.4
