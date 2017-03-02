Received: from eggs.gnu.org ([2001:4830:134:3::10]:36636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1cjVQQ-0005CJ-VH
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 13:26:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1cjVQM-0005St-8g
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 13:26:03 -0500
Received: from 206-15-90-246.static.twtelecom.net ([206.15.90.246]:13749
	helo=felipe-franciosi.localdomain)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1cjVQM-0005SS-20
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 13:25:58 -0500
From: Felipe Franciosi <felipe@nutanix.com>
Date: Thu,  2 Mar 2017 10:25:50 -0800
Message-Id: <1488479153-21203-2-git-send-email-felipe@nutanix.com>
In-Reply-To: <1488479153-21203-1-git-send-email-felipe@nutanix.com>
References: <1488479153-21203-1-git-send-email-felipe@nutanix.com>
Subject: [Qemu-devel] [PATCH v5 1/4] libvhost-user: replace vasprintf() to
 fix build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Marc-Andre Lureau <marcandre.lureau@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Daniel P. Berrange" <berrange@redhat.com>, Felipe Franciosi <felipe@nutanix.com>

On gcc 3.4 and newer, simply using (void) in front of WUR functions is
not sufficient to ignore the return value. That prevents a build when
handling warnings as errors.

libvhost-user had a usage of (void)vasprintf() which triggered such a
condition. This fixes it by replacing this call with g_strdup_vprintf()
which aborts on OOM.

Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
---
 contrib/libvhost-user/libvhost-user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
index af4faad..61e1657 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -81,7 +81,7 @@ vu_panic(VuDev *dev, const char *msg, ...)
     va_list ap;
 
     va_start(ap, msg);
-    (void)vasprintf(&buf, msg, ap);
+    buf = g_strdup_vprintf(msg, ap);
     va_end(ap);
 
     dev->broken = true;
-- 
1.9.4
