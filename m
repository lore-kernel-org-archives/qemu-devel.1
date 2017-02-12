Received: from eggs.gnu.org ([2001:4830:134:3::10]:46597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ccj40-0003Ll-N9
	for qemu-devel@nongnu.org; Sat, 11 Feb 2017 20:34:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ccj3z-0006gA-Qd
	for qemu-devel@nongnu.org; Sat, 11 Feb 2017 20:34:52 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Sun, 12 Feb 2017 02:34:21 +0100
Message-Id: <20170212013440.5919-3-mreitz@redhat.com>
In-Reply-To: <20170212013440.5919-1-mreitz@redhat.com>
References: <20170212013440.5919-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 02/21] qemu-img: Improve commit invalid base
 message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

When trying to invoke qemu-img commit with a base image file name that
is not part of the top image's backing chain, the user receives a rather
plain "Base not found" error message. This is not really helpful because
it does not explain what "not found" means, potentially leaving the user
wondering why qemu cannot find a file despite it clearly existing in the
file system.

Improve the error message by clarifying that "not found" means "not
found in the top image's backing chain".

Reported-by: Ala Hino <ahino@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20161201020508.24417-1-mreitz@redhat.com
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qemu-img.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/qemu-img.c b/qemu-img.c
index 74e3362653..933876cfe1 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -912,7 +912,9 @@ static int img_commit(int argc, char **argv)
     if (base) {
         base_bs = bdrv_find_backing_image(bs, base);
         if (!base_bs) {
-            error_setg(&local_err, QERR_BASE_NOT_FOUND, base);
+            error_setg(&local_err,
+                       "Did not find '%s' in the backing chain of '%s'",
+                       base, filename);
             goto done;
         }
     } else {
-- 
2.11.0
