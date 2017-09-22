Received: from eggs.gnu.org ([2001:4830:134:3::10]:41311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lyan@suse.com>) id 1dvWrX-0004z1-3Z
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 18:56:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lyan@suse.com>) id 1dvWrU-0006kw-1P
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 18:55:59 -0400
From: Liang Yan <lyan@suse.com>
Date: Fri, 22 Sep 2017 18:55:33 -0400
Message-Id: <20170922225533.1928-1-lyan@suse.com>
Subject: [Qemu-devel] [PATCH] chardev/baum: fix baum that releases brlapi
 twice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: samuel.thibault@ens-lyon.org, pbonzini@redhat.com, marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

Error process of baum_chr_open needs to set brlapi null, so it won't
get released twice in char_braille_finalize, which will cause
"/usr/bin/qemu-system-x86_64: double free or corruption (!prev)"

Signed-off-by: Liang Yan <lyan@suse.com>
---
 chardev/baum.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/chardev/baum.c b/chardev/baum.c
index 302dd9666c..67fd783a59 100644
--- a/chardev/baum.c
+++ b/chardev/baum.c
@@ -643,6 +643,7 @@ static void baum_chr_open(Chardev *chr,
         error_setg(errp, "brlapi__openConnection: %s",
                    brlapi_strerror(brlapi_error_location()));
         g_free(handle);
+        baum->brlapi = NULL;
         return;
     }
     baum->deferred_init = 0;
-- 
2.14.1
