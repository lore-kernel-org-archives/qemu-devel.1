Received: from eggs.gnu.org ([2001:4830:134:3::10]:47033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eijcb-0008Nz-3R
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 11:28:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eijca-00026g-4W
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 11:27:57 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Mon,  5 Feb 2018 17:27:45 +0100
Message-Id: <20180205162745.23650-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH] qemu-img: Make resize error message more
 general
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

The issue:

  $ qemu-img resize -f qcow2 foo.qcow2
  qemu-img: Expecting one image file name
  Try 'qemu-img --help' for more information

So we gave an image file name, but we omitted the length.  qemu-img
thinks the last argument is always the size and removes it immediately
from argv (by decrementing argc), and tries to verify that it is a valid
size only at a later point.

So we do not actually know whether that last argument we called "size"
is indeed a size or whether the user instead forgot to specify that size
but did give a file name.

Therefore, the error message should be more general.

Bug: https://bugzilla.redhat.com/show_bug.cgi?id=1523458
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qemu-img.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qemu-img.c b/qemu-img.c
index 68b375f998..2753b63514 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3468,7 +3468,7 @@ static int img_resize(int argc, char **argv)
         }
     }
     if (optind != argc - 1) {
-        error_exit("Expecting one image file name");
+        error_exit("Expecting image file name and size");
     }
     filename = argv[optind++];
 
-- 
2.14.3
