Received: from eggs.gnu.org ([209.51.188.92]:37713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gmPxn-0004sk-8A
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 16:21:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gmPwI-0000GA-VH
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 16:20:04 -0500
From: Eric Blake <eblake@redhat.com>
Date: Wed, 23 Jan 2019 15:19:53 -0600
Message-Id: <20190123211953.28578-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] qemu-nbd: Deprecate qemu-nbd --partition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: vsementsov@virtuozzo.com, qemu-block@nongnu.org, rjones@redhat.com, thuth@redhat.com, "reviewer:Incompatible changes" <libvir-list@redhat.com>

The existing qemu-nbd --partition code claims to handle logical
partitions up to 8, since its introduction in 2008 (commit 7a5ca86).
However, the implementation is bogus (actual MBR logical partitions
form a sort of linked list, with one partition per extended table
entry, rather than four logical partitions in a single extended
table), making the code unlikely to work for anything beyond -P5 on
actual guest images. What's more, the code does not support GPT
partitions, which are becoming more popular, and maintaining device
subsetting in both NBD and the raw device is unnecessary maintenance
burden.  And nbdkit has just added code to properly handle an
arbitrary number of MBR partitions, along with its existing code
for handling GPT partitions.

Note that obtaining the offsets of a partition can be learned by
using 'qemu-nbd -c /dev/nbd0 file.qcow2 && sfdisk --dump /dev/nbd0',
but by the time you've done that, you might as well just mount
/dev/nbd0p1 that the kernel creates for you.

Start the clock on the deprecation cycle, with an example of how
to write device subsetting without using -P.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 qemu-deprecated.texi | 27 +++++++++++++++++++++++++++
 qemu-nbd.texi        |  6 ++++--
 qemu-nbd.c           |  2 ++
 3 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index 219206a836f..12f8b30943f 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -175,3 +175,30 @@ The above, converted to the current supported format=
:
 @subsubsection "irq": "" (since 3.0.0)

 The ``irq'' property is obsoleted.
+
+@section Related binaries
+
+@subsection qemu-nbd --partition (since 4.0.0)
+
+The ``qemu-nbd --partition $digit'' code (also spelled @option{-P})
+can only handle MBR partitions, and does not correctly handle logical
+partitions beyond partition 5.  If you know the relative position of
+the partition (perhaps by using @code{sfdisk} or similar, either in
+the guest or when mapping the entire device through /dev/nbd0 in the
+host), you can achieve the effect of exporting just that subset of the
+disk by use of the @option{--image-opts} option with a raw blockdev
+using the @code{offset} and @code{size} parameters layered on top of
+any other existing blockdev.
+
+For example, if partition 1 is 100MiB starting at 1MiB, the old command
+
+@example{qemu-nbd -P 1 -f qcow2 file.qcow2}
+
+can be rewritten as:
+
+@example{qemu-nbd --image-opts driver=3Draw,offset=3D1M,size=3D100M,file=
.driver=3Dqcow2,file.backing.driver=3Dfile,file.backing.filename=3Dfile.q=
cow2}
+
+Alternatively, the @code{nbdkit} project provides a more powerful
+partition filter on top of its nbd plugin, which can be used to select
+an arbitrary MBR or GPT partition on top of any other full-image NBD
+export.
diff --git a/qemu-nbd.texi b/qemu-nbd.texi
index 386bece4680..d0c51828149 100644
--- a/qemu-nbd.texi
+++ b/qemu-nbd.texi
@@ -56,8 +56,10 @@ auto-detecting.
 @item -r, --read-only
 Export the disk as read-only.
 @item -P, --partition=3D@var{num}
-Only expose MBR partition @var{num}.  Understands physical partitions
-1-4 and logical partitions 5-8.
+Deprecated: Only expose MBR partition @var{num}.  Understands physical
+partitions 1-4 and logical partition 5. New code should instead use
+@option{--image-opts} with the raw driver wrapping a subset of the
+original image.
 @item -B, --bitmap=3D@var{name}
 If @var{filename} has a qcow2 persistent bitmap @var{name}, expose
 that bitmap via the ``qemu:dirty-bitmap:@var{name}'' context
diff --git a/qemu-nbd.c b/qemu-nbd.c
index 1f7b2a03f5d..00c07fd27ea 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -787,6 +787,8 @@ int main(int argc, char **argv)
             flags &=3D ~BDRV_O_RDWR;
             break;
         case 'P':
+            warn_report("The '-P' option is deprecated; use --image-opts=
 with "
+                        "a raw device wrapper for subset exports instead=
");
             if (qemu_strtoi(optarg, NULL, 0, &partition) < 0 ||
                 partition < 1 || partition > 8) {
                 error_report("Invalid partition '%s'", optarg);
--=20
2.20.1
