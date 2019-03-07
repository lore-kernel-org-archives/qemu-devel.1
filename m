Received: from eggs.gnu.org ([209.51.188.92]:55628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1h1wDP-0005Nw-EZ
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 11:49:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1h1wDN-0003BQ-Vl
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 11:49:51 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu,  7 Mar 2019 16:49:41 +0000
Message-Id: <20190307164941.3322-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3] file-posix: add drop-cache=on|off option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>, Daniel Berrange <berrange@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Neil Skrypuch <neil@tembosocial.com>, Stefano Garzarella <sgarzare@redhat.com>

Commit dd577a26ff03b6829721b1ffbbf9e7c411b72378 ("block/file-posix:
implement bdrv_co_invalidate_cache() on Linux") introduced page cache
invalidation so that cache.direct=3Doff live migration is safe on Linux.

The invalidation takes a significant amount of time when the file is
large and present in the page cache.  Normally this is not the case for
cross-host live migration but it can happen when migrating between QEMU
processes on the same host.

On same-host migration we don't need to invalidate pages for correctness
anyway, so an option to skip page cache invalidation is useful.  I
investigated optimizing invalidation and detecting same-host migration,
but both are hard to achieve so a user-visible option will suffice.

As a bonus this option means that the cache invalidation feature will
now be detectable by libvirt via QMP schema introspection.

Suggested-by: Neil Skrypuch <neil@tembosocial.com>
Tested-by: Neil Skrypuch <neil@tembosocial.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
v3:
 * This option is now conditional on CONFIG_LINUX and *can* be used for
   libvirt feature detection after all [eblake/armbru]
v2:
 * Remove outdated comment about libvirt feature detection [danpb]
---
 qapi/block-core.json |  6 ++++++
 block/file-posix.c   | 16 ++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 2b8afbb924..13cf01e308 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2807,6 +2807,10 @@
 # @locking:     whether to enable file locking. If set to 'auto', only e=
nable
 #               when Open File Descriptor (OFD) locking API is available
 #               (default: auto, since 2.10)
+# @drop-cache:  invalidate page cache during live migration.  This preve=
nts
+#               stale data on the migration destination with cache.direc=
t=3Doff.
+#               Currently only supported on Linux hosts.
+#               (default: on, since: 4.0)
 # @x-check-cache-dropped: whether to check that page cache was dropped o=
n live
 #                         migration.  May cause noticeable delays if the=
 image
 #                         file is large, do not use in production.
@@ -2819,6 +2823,8 @@
             '*pr-manager': 'str',
             '*locking': 'OnOffAuto',
             '*aio': 'BlockdevAioOptions',
+	    '*drop-cache': {'type': 'bool',
+	                    'if': 'defined(CONFIG_LINUX)'},
             '*x-check-cache-dropped': 'bool' } }
=20
 ##
diff --git a/block/file-posix.c b/block/file-posix.c
index ba6ab62a38..936dea8096 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -154,6 +154,7 @@ typedef struct BDRVRawState {
     bool page_cache_inconsistent:1;
     bool has_fallocate;
     bool needs_alignment;
+    bool drop_cache;
     bool check_cache_dropped;
=20
     PRManager *pr_mgr;
@@ -162,6 +163,7 @@ typedef struct BDRVRawState {
 typedef struct BDRVRawReopenState {
     int fd;
     int open_flags;
+    bool drop_cache;
     bool check_cache_dropped;
 } BDRVRawReopenState;
=20
@@ -422,6 +424,13 @@ static QemuOptsList raw_runtime_opts =3D {
             .type =3D QEMU_OPT_STRING,
             .help =3D "id of persistent reservation manager object (defa=
ult: none)",
         },
+#if defined(__linux__)
+        {
+            .name =3D "drop-cache",
+            .type =3D QEMU_OPT_BOOL,
+            .help =3D "invalidate page cache during live migration (defa=
ult: on)",
+        },
+#endif
         {
             .name =3D "x-check-cache-dropped",
             .type =3D QEMU_OPT_BOOL,
@@ -511,6 +520,7 @@ static int raw_open_common(BlockDriverState *bs, QDic=
t *options,
         }
     }
=20
+    s->drop_cache =3D qemu_opt_get_bool(opts, "drop-cache", true);
     s->check_cache_dropped =3D qemu_opt_get_bool(opts, "x-check-cache-dr=
opped",
                                                false);
=20
@@ -869,6 +879,7 @@ static int raw_reopen_prepare(BDRVReopenState *state,
         goto out;
     }
=20
+    rs->drop_cache =3D qemu_opt_get_bool_del(opts, "drop-cache", true);
     rs->check_cache_dropped =3D
         qemu_opt_get_bool_del(opts, "x-check-cache-dropped", false);
=20
@@ -946,6 +957,7 @@ static void raw_reopen_commit(BDRVReopenState *state)
     BDRVRawState *s =3D state->bs->opaque;
     Error *local_err =3D NULL;
=20
+    s->drop_cache =3D rs->drop_cache;
     s->check_cache_dropped =3D rs->check_cache_dropped;
     s->open_flags =3D rs->open_flags;
=20
@@ -2531,6 +2543,10 @@ static void coroutine_fn raw_co_invalidate_cache(B=
lockDriverState *bs,
         return;
     }
=20
+    if (!s->drop_cache) {
+        return;
+    }
+
     if (s->open_flags & O_DIRECT) {
         return; /* No host kernel page cache */
     }
--=20
2.20.1
