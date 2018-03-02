Received: from eggs.gnu.org ([2001:4830:134:3::10]:53208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1erpqp-0001za-83
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 13:56:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1erpqo-0003Pd-Fx
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 13:56:15 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  2 Mar 2018 19:54:44 +0100
Message-Id: <20180302185448.6314-34-kwolf@redhat.com>
In-Reply-To: <20180302185448.6314-1-kwolf@redhat.com>
References: <20180302185448.6314-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 33/37] qemu-img: Make resize error message more
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Max Reitz <mreitz@redhat.com>

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
Message-id: 20180205162745.23650-1-mreitz@redhat.com
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qemu-img.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qemu-img.c b/qemu-img.c
index 56edc15218..aa99fd32e9 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3469,7 +3469,7 @@ static int img_resize(int argc, char **argv)
         }
     }
     if (optind != argc - 1) {
-        error_exit("Expecting one image file name");
+        error_exit("Expecting image file name and size");
     }
     filename = argv[optind++];
 
-- 
2.13.6
