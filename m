Received: from eggs.gnu.org ([2001:4830:134:3::10]:47284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gOgfd-00072j-BM
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 05:20:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gOgeS-0000pz-TL
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 05:19:33 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 19 Nov 2018 11:19:21 +0100
Message-Id: <20181119101921.31949-3-mreitz@redhat.com>
In-Reply-To: <20181119101921.31949-1-mreitz@redhat.com>
References: <20181119101921.31949-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH for-next? 2/2] qemu-img: Fix leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, qemu-stable@nongnu.org, Kevin Wolf <kwolf@redhat.com>

create_opts was leaked here.  This is not too bad since the process is
about to exit anyway, but relying on that does not make the code nicer
to read.

Fixes: d402b6a21a825a5c07aac9251990860723d49f5d
Reported-by: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qemu-img.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/qemu-img.c b/qemu-img.c
index a9a2470e1a..ad04f59565 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -263,6 +263,7 @@ static int print_block_option_help(const char *filename, const char *fmt)
         if (!proto_drv->create_opts) {
             error_report("Protocol driver '%s' does not support image creation",
                          proto_drv->format_name);
+            qemu_opts_free(create_opts);
             return 1;
         }
         create_opts = qemu_opts_append(create_opts, proto_drv->create_opts);
-- 
2.17.2
