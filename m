Received: from eggs.gnu.org ([2001:4830:134:3::10]:34978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f3MV1-0002YR-E8
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 10:01:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f3MUt-0004CE-T8
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 10:01:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43382)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1f3MUt-0004BE-OG
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 10:01:15 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue,  3 Apr 2018 11:01:06 -0300
Message-Id: <20180403140107.26125-2-ehabkost@redhat.com>
In-Reply-To: <20180403140107.26125-1-ehabkost@redhat.com>
References: <20180403140107.26125-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 1/2] exec: fix memory leak in
 find_max_supported_pagesize()
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

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <152231458624.69730.1752893648612848392.stgit@bahia.lan>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 exec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/exec.c b/exec.c
index c09bd93df3..02b1efebb7 100644
--- a/exec.c
+++ b/exec.c
@@ -1495,6 +1495,7 @@ static int find_max_supported_pagesize(Object *obj, void *opaque)
         mem_path = object_property_get_str(obj, "mem-path", NULL);
         if (mem_path) {
             long hpsize = qemu_mempath_getpagesize(mem_path);
+            g_free(mem_path);
             if (hpsize < *hpsize_min) {
                 *hpsize_min = hpsize;
             }
-- 
2.14.3
