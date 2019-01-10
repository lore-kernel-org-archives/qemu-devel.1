Received: from eggs.gnu.org ([209.51.188.92]:56529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghfrH-00059O-HI
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 14:19:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghfrG-0008WK-N3
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 14:19:15 -0500
From: Eric Blake <eblake@redhat.com>
Date: Thu, 10 Jan 2019 13:18:56 -0600
Message-Id: <20190110191901.5082-3-eblake@redhat.com>
In-Reply-To: <20190110191901.5082-1-eblake@redhat.com>
References: <20190110191901.5082-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 2/6] block: Take advantage of QemuOpt
 default integers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: lbloch@janustech.com, armbru@redhat.com, kwolf@redhat.com, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, "Denis V. Lunev" <den@openvz.org>, Max Reitz <mreitz@redhat.com>, Stefan Weil <sw@weilnetz.de>, Jeff Cody <jcody@redhat.com>

Instead of defining an integer to a default string value (where we
have to be careful how we spelled the integer because of the use of
stringify), populate a default integer value instead.

Drop a useless stringify(0); a missing default is just as easy to
interpret as 0 as an explicit string 0.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/parallels.c | 2 +-
 block/qcow2.c     | 2 +-
 block/qed.c       | 2 +-
 block/vdi.c       | 2 +-
 block/vhdx.c      | 3 +--
 5 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index cc9445879d7..a7593310332 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -96,7 +96,7 @@ static QemuOptsList parallels_create_opts =3D {
             .name =3D BLOCK_OPT_CLUSTER_SIZE,
             .type =3D QEMU_OPT_SIZE,
             .help =3D "Parallels image cluster size",
-            .def_value_str =3D stringify(DEFAULT_CLUSTER_SIZE),
+            .def_value_int =3D DEFAULT_CLUSTER_SIZE,
         },
         { /* end of list */ }
     }
diff --git a/block/qcow2.c b/block/qcow2.c
index 4897abae5e8..c9b76a9ea93 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -4892,7 +4892,7 @@ static QemuOptsList qcow2_create_opts =3D {
             .name =3D BLOCK_OPT_CLUSTER_SIZE,
             .type =3D QEMU_OPT_SIZE,
             .help =3D "qcow2 cluster size",
-            .def_value_str =3D stringify(DEFAULT_CLUSTER_SIZE)
+            .def_value_int =3D DEFAULT_CLUSTER_SIZE,
         },
         {
             .name =3D BLOCK_OPT_PREALLOC,
diff --git a/block/qed.c b/block/qed.c
index 9377c0b7ad8..9db36c39066 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -1651,7 +1651,7 @@ static QemuOptsList qed_create_opts =3D {
             .name =3D BLOCK_OPT_CLUSTER_SIZE,
             .type =3D QEMU_OPT_SIZE,
             .help =3D "Cluster size (in bytes)",
-            .def_value_str =3D stringify(QED_DEFAULT_CLUSTER_SIZE)
+            .def_value_int =3D QED_DEFAULT_CLUSTER_SIZE,
         },
         {
             .name =3D BLOCK_OPT_TABLE_SIZE,
diff --git a/block/vdi.c b/block/vdi.c
index 2380daa583e..65659c9b179 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -985,7 +985,7 @@ static QemuOptsList vdi_create_opts =3D {
             .name =3D BLOCK_OPT_CLUSTER_SIZE,
             .type =3D QEMU_OPT_SIZE,
             .help =3D "VDI cluster (block) size",
-            .def_value_str =3D stringify(DEFAULT_CLUSTER_SIZE)
+            .def_value_int =3D DEFAULT_CLUSTER_SIZE,
         },
 #endif
 #if defined(CONFIG_VDI_STATIC_IMAGE)
diff --git a/block/vhdx.c b/block/vhdx.c
index b785aef4b7b..54bf6805fc6 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -2085,13 +2085,12 @@ static QemuOptsList vhdx_create_opts =3D {
        {
            .name =3D VHDX_BLOCK_OPT_LOG_SIZE,
            .type =3D QEMU_OPT_SIZE,
-           .def_value_str =3D stringify(DEFAULT_LOG_SIZE),
+           .def_value_int =3D DEFAULT_LOG_SIZE,
            .help =3D "Log size; min 1MB."
        },
        {
            .name =3D VHDX_BLOCK_OPT_BLOCK_SIZE,
            .type =3D QEMU_OPT_SIZE,
-           .def_value_str =3D stringify(0),
            .help =3D "Block Size; min 1MB, max 256MB. " \
                    "0 means auto-calculate based on image size."
        },
--=20
2.20.1
