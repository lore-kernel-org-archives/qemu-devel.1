Received: from eggs.gnu.org ([2001:4830:134:3::10]:52774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fSNm6-0004Fw-3a
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 10:26:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fSNm3-0001ZO-QZ
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 10:26:26 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 11 Jun 2018 16:25:46 +0200
Message-Id: <20180611142611.6609-5-mreitz@redhat.com>
In-Reply-To: <20180611142611.6609-1-mreitz@redhat.com>
References: <20180611142611.6609-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 04/29] qemu-img: Amendment support implies
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
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

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
Message-id: 20180509210023.20283-2-mreitz@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qemu-img.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 75f1610aa0..0be11b3852 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3789,13 +3789,16 @@ static int img_amend(int argc, char **argv)
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
2.17.1
