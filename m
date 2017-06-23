Received: from eggs.gnu.org ([2001:4830:134:3::10]:59293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dORLh-0000eu-5z
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:22:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dORLf-0007Vr-M7
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:22:21 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 23 Jun 2017 18:21:07 +0200
Message-Id: <1498234919-27316-10-git-send-email-kwolf@redhat.com>
In-Reply-To: <1498234919-27316-1-git-send-email-kwolf@redhat.com>
References: <1498234919-27316-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 09/61] doc: Document driver-specific -blockdev
 options
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

This documents the driver-specific options for the raw, qcow2 and file
block drivers for the man page. For everything else, we refer to the
QAPI documentation.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 qemu-options.hx | 115 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 114 insertions(+), 1 deletion(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index db20866..896ff17 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -614,7 +614,18 @@ STEXI
 @item -blockdev @var{option}[,@var{option}[,@var{option}[,...]]]
 @findex -blockdev
 
-Define a new block driver node.
+Define a new block driver node. Some of the options apply to all block drivers,
+other options are only accepted for a specific block driver. See below for a
+list of generic options and options for the most common block drivers.
+
+Options that expect a reference to another node (e.g. @code{file}) can be
+given in two ways. Either you specify the node name of an already existing node
+(file=@var{node-name}), or you define a new node inline, adding options
+for the referenced node after a dot (file.filename=@var{path},file.aio=native).
+
+A block driver node created with @option{-blockdev} can be used for a guest
+device by specifying its node name for the @code{drive} property in a
+@option{-device} argument that defines a block device.
 
 @table @option
 @item Valid options for any block driver node:
@@ -654,6 +665,108 @@ zero write commands. You may even choose "unmap" if @var{discard} is set
 to "unmap" to allow a zero write to be converted to an @code{unmap} operation.
 @end table
 
+@item Driver-specific options for @code{file}
+
+This is the protocol-level block driver for accessing regular files.
+
+@table @code
+@item filename
+The path to the image file in the local filesystem
+@item aio
+Specifies the AIO backend (threads/native, default: threads)
+@end table
+Example:
+@example
+-blockdev driver=file,node-name=disk,filename=disk.img
+@end example
+
+@item Driver-specific options for @code{raw}
+
+This is the image format block driver for raw images. It is usually
+stacked on top of a protocol level block driver such as @code{file}.
+
+@table @code
+@item file
+Reference to or definition of the data source block driver node
+(e.g. a @code{file} driver node)
+@end table
+Example 1:
+@example
+-blockdev driver=file,node-name=disk_file,filename=disk.img
+-blockdev driver=raw,node-name=disk,file=disk_file
+@end example
+Example 2:
+@example
+-blockdev driver=raw,node-name=disk,file.driver=file,file.filename=disk.img
+@end example
+
+@item Driver-specific options for @code{qcow2}
+
+This is the image format block driver for qcow2 images. It is usually
+stacked on top of a protocol level block driver such as @code{file}.
+
+@table @code
+@item file
+Reference to or definition of the data source block driver node
+(e.g. a @code{file} driver node)
+
+@item backing
+Reference to or definition of the backing file block device (default is taken
+from the image file). It is allowed to pass an empty string here in order to
+disable the default backing file.
+
+@item lazy-refcounts
+Whether to enable the lazy refcounts feature (on/off; default is taken from the
+image file)
+
+@item cache-size
+The maximum total size of the L2 table and refcount block caches in bytes
+(default: 1048576 bytes or 8 clusters, whichever is larger)
+
+@item l2-cache-size
+The maximum size of the L2 table cache in bytes
+(default: 4/5 of the total cache size)
+
+@item refcount-cache-size
+The maximum size of the refcount block cache in bytes
+(default: 1/5 of the total cache size)
+
+@item cache-clean-interval
+Clean unused entries in the L2 and refcount caches. The interval is in seconds.
+The default value is 0 and it disables this feature.
+
+@item pass-discard-request
+Whether discard requests to the qcow2 device should be forwarded to the data
+source (on/off; default: on if discard=unmap is specified, off otherwise)
+
+@item pass-discard-snapshot
+Whether discard requests for the data source should be issued when a snapshot
+operation (e.g. deleting a snapshot) frees clusters in the qcow2 file (on/off;
+default: on)
+
+@item pass-discard-other
+Whether discard requests for the data source should be issued on other
+occasions where a cluster gets freed (on/off; default: off)
+
+@item overlap-check
+Which overlap checks to perform for writes to the image
+(none/constant/cached/all; default: cached). For details or finer
+granularity control refer to the QAPI documentation of @code{blockdev-add}.
+@end table
+
+Example 1:
+@example
+-blockdev driver=file,node-name=my_file,filename=/tmp/disk.qcow2
+-blockdev driver=qcow2,node-name=hda,file=my_file,overlap-check=none,cache-size=16777216
+@end example
+Example 2:
+@example
+-blockdev driver=qcow2,node-name=disk,file.driver=http,file.filename=http://example.com/image.qcow2
+@end example
+
+@item Driver-specific options for other drivers
+Please refer to the QAPI documentation of the @code{blockdev-add} QMP command.
+
 @end table
 
 ETEXI
-- 
1.8.3.1
