Received: from eggs.gnu.org ([2001:4830:134:3::10]:34999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f3MV5-0002b5-D3
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 10:01:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f3MUw-0004Du-0D
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 10:01:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40932)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1f3MUv-0004D6-RJ
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 10:01:17 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue,  3 Apr 2018 11:01:07 -0300
Message-Id: <20180403140107.26125-3-ehabkost@redhat.com>
In-Reply-To: <20180403140107.26125-1-ehabkost@redhat.com>
References: <20180403140107.26125-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 2/2] sev/i386: fix memory leak in
 sev_guest_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Greg Kurz <groug@kaod.org>

From: Greg Kurz <groug@kaod.org>

The string returned by object_property_get_str() is dynamically allocated.

Fixes: d8575c6c0242b
Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <152231462116.69730.14119625999092384450.stgit@bahia.lan>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/sev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 019d84cef2..c01167143f 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -748,9 +748,11 @@ sev_guest_init(const char *id)
     if (s->sev_fd < 0) {
         error_report("%s: Failed to open %s '%s'", __func__,
                      devname, strerror(errno));
-        goto err;
     }
     g_free(devname);
+    if (s->sev_fd < 0) {
+        goto err;
+    }
 
     ret = sev_platform_ioctl(s->sev_fd, SEV_PLATFORM_STATUS, &status,
                              &fw_error);
-- 
2.14.3
