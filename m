Received: from eggs.gnu.org ([209.51.188.92]:58192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hDxy5-00016g-Hl
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 17:07:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hDxy1-0006Ud-J0
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 17:07:43 -0400
From: John Snow <jsnow@redhat.com>
Date: Tue,  9 Apr 2019 17:06:55 -0400
Message-Id: <20190409210655.777-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH] qemu-img: fix .hx and .texi disparity
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>

It turns out that having options listed in three places continues to be
a bad idea. I'm still toying with the idea of an improved infrastructure
here, but in the meantime, another bandaid.

There are three locations:
(1) .hx file, formatted as texi
(2) .hx file, formatted as human readable.
(3) .texi file, as section headers, formatted as texi.

You can compare the two summaries within the .hx file like so:

Human-readable command summaries:
`./qemu-img --help | grep 'Command syntax' -A14`
Detokenized texi command summaries:
`grep "@item" qemu-img-cmds.hx | sed -E 's|@var\{([^\}]*?)\}|\1|g'`

You can compare the two separate texi summaries like so:

Texi command summaries:
`grep "@item" qemu-img-cmds.hx"`
Texi command headers:
grep -E "@item.*@var" qemu-img.texi | tail -14

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qemu-img.texi    | 4 ++--
 qemu-img-cmds.hx | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/qemu-img.texi b/qemu-img.texi
index 3b6710a580..724f244ba1 100644
--- a/qemu-img.texi
+++ b/qemu-img.texi
@@ -197,7 +197,7 @@ Command description:
 
 @table @option
 
-@item amend [--object @var{objectdef}] [--image-opts] [-p] [-p] [-f @var{fmt}] [-t @var{cache}] -o @var{options} @var{filename}
+@item amend [--object @var{objectdef}] [--image-opts] [-p] [-q] [-f @var{fmt}] [-t @var{cache}] -o @var{options} @var{filename}
 
 Amends the image format specific @var{options} for the image file
 @var{filename}. Not all file formats support this operation.
@@ -424,7 +424,7 @@ To enumerate information about each disk image in the above chain, starting from
 qemu-img info --backing-chain snap2.qcow2
 @end example
 
-@item map [-f @var{fmt}] [--output=@var{ofmt}] @var{filename}
+@item map [--object @var{objectdef}] [--image-opts] [-f @var{fmt}] [--output=@var{ofmt}] [-U] @var{filename}
 
 Dump the metadata of image @var{filename} and its backing file chain.
 In particular, this commands dumps the allocation state of every sector
diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
index 1526f327a5..4b47f7495d 100644
--- a/qemu-img-cmds.hx
+++ b/qemu-img-cmds.hx
@@ -46,7 +46,7 @@ ETEXI
 DEF("convert", img_convert,
     "convert [--object objectdef] [--image-opts] [--target-image-opts] [-U] [-C] [-c] [-p] [-q] [-n] [-f fmt] [-t cache] [-T src_cache] [-O output_fmt] [-B backing_file] [-o options] [-l snapshot_param] [-S sparse_size] [-m num_coroutines] [-W] filename [filename2 [...]] output_filename")
 STEXI
-@item convert [--object @var{objectdef}] [--image-opts] [--target-image-opts] [-U] [-c] [-p] [-q] [-n] [-f @var{fmt}] [-t @var{cache}] [-T @var{src_cache}] [-O @var{output_fmt}] [-B @var{backing_file}] [-o @var{options}] [-l @var{snapshot_param}] [-S @var{sparse_size}] [-m @var{num_coroutines}] [-W] @var{filename} [@var{filename2} [...]] @var{output_filename}
+@item convert [--object @var{objectdef}] [--image-opts] [--target-image-opts] [-U] [-C] [-c] [-p] [-q] [-n] [-f @var{fmt}] [-t @var{cache}] [-T @var{src_cache}] [-O @var{output_fmt}] [-B @var{backing_file}] [-o @var{options}] [-l @var{snapshot_param}] [-S @var{sparse_size}] [-m @var{num_coroutines}] [-W] @var{filename} [@var{filename2} [...]] @var{output_filename}
 ETEXI
 
 DEF("create", img_create,
-- 
2.17.2
