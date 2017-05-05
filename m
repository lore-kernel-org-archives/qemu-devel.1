Received: from eggs.gnu.org ([2001:4830:134:3::10]:47229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d6aFR-0002WC-SK
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:14:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d6aFQ-0006ia-NH
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:14:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60654)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1d6aFQ-0006i4-Hz
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:14:04 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri,  5 May 2017 12:13:36 +0200
Message-Id: <20170505101337.4650-21-pbonzini@redhat.com>
In-Reply-To: <20170505101337.4650-1-pbonzini@redhat.com>
References: <20170505101337.4650-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 20/21] libvhost-user: replace vasprintf() to fix
 build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Felipe Franciosi <felipe@nutanix.com>

From: Felipe Franciosi <felipe@nutanix.com>

On gcc 3.4 and newer, simply using (void) in front of WUR functions is
not sufficient to ignore the return value. That prevents a build when
handling warnings as errors.

libvhost-user had a usage of (void)vasprintf() which triggered such a
condition. This fixes it by replacing this call with g_strdup_vprintf()
which aborts on OOM.

Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
Message-Id: <1488479153-21203-2-git-send-email-felipe@nutanix.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 contrib/libvhost-user/libvhost-user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
index af4faad60b..61e1657e41 100644
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
2.12.2
