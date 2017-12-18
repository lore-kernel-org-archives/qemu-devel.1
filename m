Received: from eggs.gnu.org ([2001:4830:134:3::10]:57305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1eQtIV-0003Bm-0z
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 06:09:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1eQtIO-0007Zx-IV
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 06:09:26 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:7306 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <den@openvz.org>) id 1eQtIO-0007Z5-1z
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 06:09:20 -0500
From: "Denis V. Lunev" <den@openvz.org>
Date: Mon, 18 Dec 2017 14:09:07 +0300
Message-Id: <1513595351-5899-2-git-send-email-den@openvz.org>
In-Reply-To: <1513595351-5899-1-git-send-email-den@openvz.org>
References: <1513595351-5899-1-git-send-email-den@openvz.org>
Subject: [Qemu-devel] [PATCH 1/5] docs/interop/prl-xml: description of
 Parallels Disk format
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Klim Kireev <klim.kireev@virtuozzo.com>, Edgar Kaziakhmedov <edgar.kaziakhmedov@virtuozzo.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>, Stefan Hajnoczi <stefanha@redhat.com>

From: Klim Kireev <klim.kireev@virtuozzo.com>

This patch adds main information about Parallels Disk
format, which consists of DiskDescriptor.xml and other files.

Signed-off-by: Edgar Kaziakhmedov <edgar.kaziakhmedov@virtuozzo.com>
Signed-off-by: Klim Kireev <klim.kireev@virtuozzo.com>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Stefan Hajnoczi <stefanha@redhat.com>
---
 docs/interop/prl-xml.txt | 155 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 155 insertions(+)
 create mode 100644 docs/interop/prl-xml.txt

diff --git a/docs/interop/prl-xml.txt b/docs/interop/prl-xml.txt
new file mode 100644
index 0000000..8ccb91a
--- /dev/null
+++ b/docs/interop/prl-xml.txt
@@ -0,0 +1,155 @@
+= License =
+
+Copyright (c) 2015 Denis Lunev
+Copyright (c) 2015 Vladimir Sementsov-Ogievskiy
+Copyright (c) 2016-2017 Klim Kireev
+Copyright (c) 2016-2017 Edgar Kaziakhmedov
+
+This work is licensed under the terms of the GNU GPL, version 2 or later.
+See the COPYING file in the top-level directory.
+
+This specification contains minimal information about Parallels Disk Format,
+which is enough to proper work with QEMU. Nevertheless, Parallels Cloud Server
+and Parallels Desktop are able to add some unspecified nodes to xml and use
+them, but they are for internal work and don't affect functionality. Also it
+uses auxiliary xml "Snapshot.xml", which allows to store optional snapshot
+information, but it doesn't influence open/read/write functionality. QEMU and
+other software should not use unspecified here fields and Snapshot.xml file
+and must leave them as is.
+
+= Parallels Disk Format =
+
+Parallels disk consists of two parts: the set of snapshots and the disk
+descriptor file, which stores information about all files and snapshots.
+
+== Definitions ==
+    Snapshot       a record of the contents captured at a particular time,
+                   capable of storing current state. A snapshot has UUID and
+                   parent UUID.
+
+ Snapshot image    an overlay representing the difference between this
+                   snapshot and some earlier snapshot
+
+    Overlay        an image storing the different sectors between two captured
+                   states.
+
+   Root image      snapshot image without parent, the root of snapshot tree.
+
+    Storage        a special conception of data, which consists of disk
+                   parameters and a list of images. One of this image is root,
+                   others are overlays. Images must be expandable (parallels
+                   image file), however root image could be expandable or
+                   plain. There may be more then one storage in the Parallels
+                   disk and it is defined as a split image.
+                   In this case every storage covers specific address
+                   space area of the disk and has its particular root image.
+                   Split images are not considered here and isn't supported
+                   in QEMU.
+
+  Description      DiskDescriptor.xml stores information about disk parameters,
+     file          snapshots, storages.
+
+     Top           The overlay between actual state and some previous snapshot.
+   Snapshot        It is not a snapshot in classical meaning.
+
+    Sector         a 512-byte data chunk.
+
+== Description file ==
+All information is placed in single XML section Parallels_disk_image.
+The section has only one attribute "Version", that must be 1.0.
+General structure of DiskDescriptor.xml:
+
+<Parallels_disk_image Version="1.0">
+    <Disk_Parameters>
+        ...
+    </Disk_Parameters>
+    <StorageData>
+        ...
+    </StorageData>
+    <Snapshots>
+        ...
+    </Snapshots>
+</Parallels_disk_image>
+
+== Disk_Parameters section ==
+The Disk_Parameters section describes the physical layout of the virtual disk
+and some general settings.
+
+The Disk_Parameters section MUST contain the following subsections:
+    * Disk_size - number of sectors in the disk,
+                  desired size of the disk
+    * Cylinders - number of the disk cylinders
+    * Heads     - number of the disk heads
+    * Sectors   - number of the disk sectors per cylinder
+                  (sector size is 512 bytes)
+                  Limitation: Product of the Heads, Sectors and Cylinders
+                  values MUST be equal to the value of the Disk_size parameter.
+    * Padding   - must be 0. Parallels Cloud Server and Parallels Desktop may
+                  use padding set to 1, however this case is not covered
+                  by this spec, QEMU and other software should not open
+                  such disks and should not create them.
+                  Attention: this field affects the read/write functionality.
+
+== StorageData section ==
+This section of the file describes root image and all snapshot images.
+
+The StorageData section consists of the Storage subsection, as shown below:
+<StorageData>
+    <Storage>
+        ...
+    </Storage>
+</StorageData>
+
+A Storage descriptor consists of the following subsections:
+    * Start     - start sector of the storage, equals to 0.
+    * End       - number of sectors in storage, equals to Disk_size.
+    * Blocksize - storage cluster size, number of sectors per one cluster.
+                  Cluster size for each "Compressed" (see below) image in
+                  parallels disk must be equal to this field. Note: cluster
+                  size for Parallels Expandable Image is in 'tracks' field of
+                  its header (see docs/interop/parallels.txt).
+    * Several Image subsections.
+
+Each Image section consists of the following subsections:
+    * GUID - image identifier, UUID in curly brackets.
+             For instance, {12345678-9abc-def1-2345-6789abcdef12}.
+    * Type - image type of the element. It can be:
+             "Plain" for plain disks.
+             "Compressed" for expanding disks.
+    * File - path to image file. Path can be relative to DiskDecriptor.xml or
+             absolute.
+
+== Snapshots section ==
+The Snapshots section describes the snapshot relations with the snapshot tree.
+
+The section contains the set of Shot subsections, as shown below:
+<Snapshots>
+    <TopGUID> ... </TopGUID> //Optional subsection
+    <Shot>
+        ...
+    </Shot>
+    <Shot>
+        ...
+    </Shot>
+    ...
+</Snapshots>
+
+Each Shot section contains the following subsections:
+    * GUID       - an image GUID.
+    * ParentGUID - GUID of the image of the parent snapshot.
+
+The software may traverse snapshots from child to parent using <ParentGUID>
+field as reference. ParentGUID of root snapshot is
+{00000000-0000-0000-0000-000000000000}. There should be only one one root
+snapshot. Top snapshot could be described via two ways: via TopGUID subsection
+in the Snapshots section or via predefined GUID
+{5fbaabe3-6958-40ff-92a7-860e329aab41} If TopGUID is defined, predefined GUID is
+interpreted as usual GUID. All snapshot images (except Top Snapshot) sould be
+opened read-only.
+There is another predefined GIUD,
+BackupID = {704718e1-2314-44c8-9087-d78ed36b0f4e}, which is used by original and
+some third-party software for backup, QEMU and other software may operate with
+images with GUID = BackupID as usual, however, it is not recommended to use this
+GUID for new disks. Top snapshot cannot have this GUID.
+
+NOTE: To address top snapshot QEMU supports only predefined GUID mode.
-- 
2.7.4
