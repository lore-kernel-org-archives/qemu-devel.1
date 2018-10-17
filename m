Received: from eggs.gnu.org ([2001:4830:134:3::10]:44942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gCouL-00078B-BT
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 12:42:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gCouG-00041f-Jn
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 12:42:53 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 17 Oct 2018 18:41:53 +0200
Message-Id: <20181017164200.22344-3-kwolf@redhat.com>
In-Reply-To: <20181017164200.22344-1-kwolf@redhat.com>
References: <20181017164200.22344-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 2/9] block: Add auto-read-only option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org

If a management application builds the block graph node by node, the
protocol layer doesn't inherit its read-only option from the format
layer any more, so it must be set explicitly.

Backing files should work on read-only storage, but at the same time, a
block job like commit should be able to reopen them read-write if they
are on read-write storage. However, without option inheritance, reopen
only changes the read-only option for the root node (typically the
format layer), but not the protocol layer, so reopening fails (the
format layer wants to get write permissions, but the protocol layer is
still read-only).

A simple workaround for the problem in the management tool would be to
open the protocol layer always read-write and to make only the format
layer read-only for backing files. However, sometimes the file is
actually stored on read-only storage and we don't know whether the image
can be opened read-write (for example, for NBD it depends on the server
we're trying to connect to). This adds an option that makes QEMU try to
open the image read-write, but allows it to degrade to a read-only mode
without returning an error.

The documentation for this option is consciously phrased in a way that
allows QEMU to switch to a better model eventually: Instead of trying
when the image is first opened, making the read-only flag dynamic and
changing it automatically whenever the first BLK_PERM_WRITE user is
attached or the last one is detached would be much more useful
behaviour.

Unfortunately, this more useful behaviour is also a lot harder to
implement, and libvirt needs a solution now before it can switch to
-blockdev, so let's start with this easier approach for now.

Instead of adding a new auto-read-only option, turning the existing
read-only into an enum (with a bool alternate for compatibility) was
considered, but it complicated the implementation to the point that it
didn't seem to be worth it.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/block-core.json  |  7 +++++++
 include/block/block.h |  2 ++
 block.c               | 17 +++++++++++++++++
 block/vvfat.c         |  1 +
 4 files changed, 27 insertions(+)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index cfb37f8c1d..2ac4e69e68 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3651,6 +3651,12 @@
 #                 either generally or in certain configurations. In this=
 case,
 #                 the default value does not work and the option must be
 #                 specified explicitly.
+# @auto-read-only: if true and @read-only is false, QEMU may automatical=
ly
+#                  decide not to open the image read-write as requested,=
 but
+#                  fall back to read-only instead (and switch between th=
e modes
+#                  later), e.g. depending on whether the image file is w=
ritable
+#                  or whether a writing user is attached to the node
+#                  (default: false, since 3.1)
 # @detect-zeroes: detect and optimize zero writes (Since 2.1)
 #                 (default: off)
 # @force-share:   force share all permission on added nodes.
@@ -3666,6 +3672,7 @@
             '*discard': 'BlockdevDiscardOptions',
             '*cache': 'BlockdevCacheOptions',
             '*read-only': 'bool',
+            '*auto-read-only': 'bool',
             '*force-share': 'bool',
             '*detect-zeroes': 'BlockdevDetectZeroesOptions' },
   'discriminator': 'driver',
diff --git a/include/block/block.h b/include/block/block.h
index b189cf422e..580b3716c3 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -115,6 +115,7 @@ typedef struct HDGeometry {
                                       select an appropriate protocol dri=
ver,
                                       ignoring the format layer */
 #define BDRV_O_NO_IO       0x10000 /* don't initialize for I/O */
+#define BDRV_O_AUTO_RDONLY 0x20000 /* degrade to read-only if opening re=
ad-write fails */
=20
 #define BDRV_O_CACHE_MASK  (BDRV_O_NOCACHE | BDRV_O_NO_FLUSH)
=20
@@ -125,6 +126,7 @@ typedef struct HDGeometry {
 #define BDRV_OPT_CACHE_DIRECT   "cache.direct"
 #define BDRV_OPT_CACHE_NO_FLUSH "cache.no-flush"
 #define BDRV_OPT_READ_ONLY      "read-only"
+#define BDRV_OPT_AUTO_READ_ONLY "auto-read-only"
 #define BDRV_OPT_DISCARD        "discard"
 #define BDRV_OPT_FORCE_SHARE    "force-share"
=20
diff --git a/block.c b/block.c
index d7bd6d29b4..ed73522cc6 100644
--- a/block.c
+++ b/block.c
@@ -930,6 +930,7 @@ static void bdrv_inherited_options(int *child_flags, =
QDict *child_options,
=20
     /* Inherit the read-only option from the parent if it's not set */
     qdict_copy_default(child_options, parent_options, BDRV_OPT_READ_ONLY=
);
+    qdict_copy_default(child_options, parent_options, BDRV_OPT_AUTO_READ=
_ONLY);
=20
     /* Our block drivers take care to send flushes and respect unmap pol=
icy,
      * so we can default to enable both on lower layers regardless of th=
e
@@ -1053,6 +1054,7 @@ static void bdrv_backing_options(int *child_flags, =
QDict *child_options,
=20
     /* backing files always opened read-only */
     qdict_set_default_str(child_options, BDRV_OPT_READ_ONLY, "on");
+    qdict_set_default_str(child_options, BDRV_OPT_AUTO_READ_ONLY, "off")=
;
     flags &=3D ~BDRV_O_COPY_ON_READ;
=20
     /* snapshot=3Don is handled on the top layer */
@@ -1142,6 +1144,10 @@ static void update_flags_from_options(int *flags, =
QemuOpts *opts)
         *flags |=3D BDRV_O_RDWR;
     }
=20
+    assert(qemu_opt_find(opts, BDRV_OPT_AUTO_READ_ONLY));
+    if (qemu_opt_get_bool_del(opts, BDRV_OPT_AUTO_READ_ONLY, false)) {
+        *flags |=3D BDRV_O_AUTO_RDONLY;
+    }
 }
=20
 static void update_options_from_flags(QDict *options, int flags)
@@ -1156,6 +1162,10 @@ static void update_options_from_flags(QDict *optio=
ns, int flags)
     if (!qdict_haskey(options, BDRV_OPT_READ_ONLY)) {
         qdict_put_bool(options, BDRV_OPT_READ_ONLY, !(flags & BDRV_O_RDW=
R));
     }
+    if (!qdict_haskey(options, BDRV_OPT_AUTO_READ_ONLY)) {
+        qdict_put_bool(options, BDRV_OPT_AUTO_READ_ONLY,
+                       flags & BDRV_O_AUTO_RDONLY);
+    }
 }
=20
 static void bdrv_assign_node_name(BlockDriverState *bs,
@@ -1328,6 +1338,11 @@ QemuOptsList bdrv_runtime_opts =3D {
             .type =3D QEMU_OPT_BOOL,
             .help =3D "Node is opened in read-only mode",
         },
+        {
+            .name =3D BDRV_OPT_AUTO_READ_ONLY,
+            .type =3D QEMU_OPT_BOOL,
+            .help =3D "Node can become read-only if opening read-write f=
ails",
+        },
         {
             .name =3D "detect-zeroes",
             .type =3D QEMU_OPT_STRING,
@@ -2486,6 +2501,8 @@ BlockDriverState *bdrv_open_blockdev_ref(BlockdevRe=
f *ref, Error **errp)
         qdict_set_default_str(qdict, BDRV_OPT_CACHE_DIRECT, "off");
         qdict_set_default_str(qdict, BDRV_OPT_CACHE_NO_FLUSH, "off");
         qdict_set_default_str(qdict, BDRV_OPT_READ_ONLY, "off");
+        qdict_set_default_str(qdict, BDRV_OPT_AUTO_READ_ONLY, "off");
+
     }
=20
     bs =3D bdrv_open_inherit(NULL, reference, qdict, 0, NULL, NULL, errp=
);
diff --git a/block/vvfat.c b/block/vvfat.c
index f2e7d501cf..98ba5e2bac 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -3130,6 +3130,7 @@ static void vvfat_qcow_options(int *child_flags, QD=
ict *child_options,
                                int parent_flags, QDict *parent_options)
 {
     qdict_set_default_str(child_options, BDRV_OPT_READ_ONLY, "off");
+    qdict_set_default_str(child_options, BDRV_OPT_AUTO_READ_ONLY, "off")=
;
     qdict_set_default_str(child_options, BDRV_OPT_CACHE_NO_FLUSH, "on");
 }
=20
--=20
2.19.1
