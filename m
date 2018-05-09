Received: from eggs.gnu.org ([2001:4830:134:3::10]:39223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fGWCT-0008Sh-Iz
	for qemu-devel@nongnu.org; Wed, 09 May 2018 17:00:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fGWCT-0002A9-1D
	for qemu-devel@nongnu.org; Wed, 09 May 2018 17:00:37 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Wed,  9 May 2018 23:00:17 +0200
Message-Id: <20180509210023.20283-2-mreitz@redhat.com>
In-Reply-To: <20180509210023.20283-1-mreitz@redhat.com>
References: <20180509210023.20283-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/7] qemu-img: Amendment support implies
 create_opts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>

Instead of checking whether a driver has a non-NULL create_opts we
should check whether it supports image amendment in the first place.  If
it does, it must have create_opts.

On the other hand, if it does not have create_opts (so it does not
support amendment either), the error message "does not support any
options" is a bit useless.  Stating clearly that the driver has no
amendment support whatsoever is probably better.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 qemu-img.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 62b29e7feb..f38aa51166 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3740,13 +3740,16 @@ static int img_amend(int argc, char **argv)
         goto out;
     }
 
-    if (!bs->drv->create_opts) {
-        error_report("Format driver '%s' does not support any options to amend",
+    if (!bs->drv->bdrv_amend_options) {
+        error_report("Format driver '%s' does not support option amendment",
                      fmt);
         ret = -1;
         goto out;
     }
 
+    /* Every driver supporting amendment must have create_opts */
+    assert(bs->drv->create_opts);
+
     create_opts = qemu_opts_append(create_opts, bs->drv->create_opts);
     opts = qemu_opts_create(create_opts, NULL, 0, &error_abort);
     qemu_opts_do_parse(opts, options, NULL, &err);
-- 
2.14.3
