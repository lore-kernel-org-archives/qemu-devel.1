Received: from eggs.gnu.org ([209.51.188.92]:38759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gk9ft-00016t-Go
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 10:33:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gk9fs-0005TZ-Lh
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 10:33:45 -0500
From: Eric Blake <eblake@redhat.com>
Date: Thu, 17 Jan 2019 09:33:19 -0600
Message-Id: <20190117153321.29749-2-eblake@redhat.com>
In-Reply-To: <20190117153321.29749-1-eblake@redhat.com>
References: <20190117153321.29749-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/3] block: Expose protocol-specific data to
 'qemu-img info'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, vsementsov@virtuozzo.com, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

'qemu-img info' is useful for showing additional information
about an image - but sometimes the interesting information is
specific to the protocol rather than to the format layer.  Set
the groundwork for showing this information; further patches
will then enable specific pieces of information.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 qapi/block-core.json | 6 +++++-
 block/qapi.c         | 7 +++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 91685be6c29..f28d5f5fc76 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -152,6 +152,9 @@
 # @format-specific: structure supplying additional format-specific
 # information (since 1.7)
 #
+# @protocol-specific: structure supplying additional protocol-specific
+# information (since 4.0)
+#
 # Since: 1.3
 #
 ##
@@ -162,7 +165,8 @@
            '*backing-filename': 'str', '*full-backing-filename': 'str',
            '*backing-filename-format': 'str', '*snapshots': ['SnapshotIn=
fo'],
            '*backing-image': 'ImageInfo',
-           '*format-specific': 'ImageInfoSpecific' } }
+           '*format-specific': 'ImageInfoSpecific',
+           '*protocol-specific': 'ImageInfoSpecific' } }

 ##
 # @ImageCheck:
diff --git a/block/qapi.c b/block/qapi.c
index c66f949db83..a8d104ba8ce 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -284,6 +284,9 @@ void bdrv_query_image_info(BlockDriverState *bs,
     }
     info->format_specific     =3D bdrv_get_specific_info(bs);
     info->has_format_specific =3D info->format_specific !=3D NULL;
+    info->protocol_specific =3D
+        bs->file ? bdrv_get_specific_info(bs->file->bs) : NULL;
+    info->has_protocol_specific =3D info->protocol_specific !=3D NULL;

     backing_filename =3D bs->backing_file;
     if (backing_filename[0] !=3D '\0') {
@@ -870,4 +873,8 @@ void bdrv_image_info_dump(fprintf_function func_fprin=
tf, void *f,
         func_fprintf(f, "Format specific information:\n");
         bdrv_image_info_specific_dump(func_fprintf, f, info->format_spec=
ific);
     }
+    if (info->has_protocol_specific) {
+        func_fprintf(f, "Protocol specific information:\n");
+        bdrv_image_info_specific_dump(func_fprintf, f, info->protocol_sp=
ecific);
+    }
 }
--=20
2.20.1
