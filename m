Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88524C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 14:47:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5021E2166E
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 14:47:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5021E2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1Aqz-0006Vc-MA
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 10:47:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52222)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1i1AkY-00086n-Ow
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 10:41:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1i1AkV-0008Lh-45
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 10:41:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51692)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1i1AkN-0008Bz-VG; Fri, 23 Aug 2019 10:41:00 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6051A30A7B83;
 Fri, 23 Aug 2019 14:40:59 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-234.phx2.redhat.com [10.3.116.234])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E0F6960126;
 Fri, 23 Aug 2019 14:40:58 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: libguestfs@redhat.com
Date: Fri, 23 Aug 2019 09:40:54 -0500
Message-Id: <20190823144054.27420-4-eblake@redhat.com>
In-Reply-To: <20190823144054.27420-1-eblake@redhat.com>
References: <25ead363-4f37-5450-b985-1876374e314d@redhat.com>
 <20190823144054.27420-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Fri, 23 Aug 2019 14:40:59 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [nbdkit PATCH 3/3] plugins: Add .can_fast_zero hook
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, nbd@other.debian.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Allow plugins to affect the handling of the new NBD_CMD_FLAG_FAST_ZERO
flag, then update affected plugins.  In particular, in-memory plugins
are always fast; the full plugin is better served by omitting .zero
and relying on .pwrite fallback; nbd takes advantage of libnbd
extensions proposed in parallel to pass through support; and
v2 language bindings expose the choice to their scripts.

The testsuite is updated thanks to the sh plugin to cover this.  In
turn, the sh plugin has to be a bit smarter about handling missing
can_fast_zero to get decent fallback support from nbdkit.

Plugins untouched by this patch either do not support .zero with flags
(including v1 plugins; these are all okay with the default behavior of
advertising but always failing fast zeroes), or are too difficult to
analyze in this patch (so not advertising is easier than having to
decide - in particular, the file plugin is tricky, since BLKZEROOUT is
not reliably fast).  The nozero filter can be used to adjust fast zero
settings for a plugin that has not yet updated.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 docs/nbdkit-plugin.pod          |  74 +++++++++++++++----
 plugins/sh/nbdkit-sh-plugin.pod |  13 +++-
 server/plugins.c                |  25 +++++--
 include/nbdkit-plugin.h         |   2 +
 plugins/data/data.c             |  14 +++-
 plugins/full/full.c             |  12 ++--
 plugins/memory/memory.c         |  14 +++-
 plugins/nbd/nbd.c               |  28 +++++++-
 plugins/null/null.c             |   8 +++
 plugins/ocaml/ocaml.c           |  25 +++++++
 plugins/sh/sh.c                 |  39 +++++++---
 plugins/ocaml/NBDKit.ml         |  10 ++-
 plugins/ocaml/NBDKit.mli        |   2 +
 plugins/rust/src/lib.rs         |   3 +
 tests/test-eflags.sh            | 122 ++++++++++++++++++++++++++++----
 15 files changed, 332 insertions(+), 59 deletions(-)

diff --git a/docs/nbdkit-plugin.pod b/docs/nbdkit-plugin.pod
index bc3d9749..f3793e7a 100644
--- a/docs/nbdkit-plugin.pod
+++ b/docs/nbdkit-plugin.pod
@@ -609,19 +609,47 @@ C<.trim> callback has been defined.

 This is called during the option negotiation phase to find out if the
 plugin wants the C<.zero> callback to be utilized.  Support for
-writing zeroes is still advertised to the client (unless the nbdkit
-filter nozero is also used), so returning false merely serves as a way
-to avoid complicating the C<.zero> callback to have to fail with
-C<ENOTSUP> or C<EOPNOTSUPP> on the connections where it will never be
-more efficient than using C<.pwrite> up front.
+writing zeroes is still advertised to the client (unless the
+L<nbdkit-nozero-filter(1)> is also used), so returning false merely
+serves as a way to avoid complicating the C<.zero> callback to have to
+fail with C<ENOTSUP> or C<EOPNOTSUPP> on the connections where it will
+never be more efficient than using C<.pwrite> up front.

 If there is an error, C<.can_zero> should call C<nbdkit_error> with an
 error message and return C<-1>.

-This callback is not required.  If omitted, then nbdkit always tries
-C<.zero> first if it is present, and gracefully falls back to
-C<.pwrite> if C<.zero> was absent or failed with C<ENOTSUP> or
-C<EOPNOTSUPP>.
+This callback is not required.  If omitted, then for a normal zero
+request, nbdkit always tries C<.zero> first if it is present, and
+gracefully falls back to C<.pwrite> if C<.zero> was absent or failed
+with C<ENOTSUP> or C<EOPNOTSUPP>.
+
+=3Dhead2 C<.can_fast_zero>
+
+ int can_fast_zero (void *handle);
+
+This is called during the option negotiation phase to find out if the
+plugin wants to advertise support for fast zero requests.  If this
+support is not advertised, a client cannot attempt fast zero requests,
+and has no way to tell if writing zeroes offers any speedups compared
+to using C<.pwrite> (other than compressed network traffic).  If
+support is advertised, then C<.zero> will have
+C<NBDKIT_FLAG_FAST_ZERO> set when the client has requested a fast
+zero, in which case the plugin must fail with C<ENOTSUP> or
+C<EOPNOTSUPP> up front if the request would not offer any benefits
+over C<.pwrite>.  Advertising support for fast zero requests does not
+require that writing zeroes be fast, only that the result (whether
+success or failure) is fast, so this should be advertised when
+feasible.
+
+If there is an error, C<.can_fast_zero> should call C<nbdkit_error>
+with an error message and return C<-1>.
+
+This callback is not required.  If omitted, then nbdkit returns true
+if C<.zero> is absent or C<.can_zero> returns false (in those cases,
+nbdkit fails all fast zero requests, as its fallback to C<.pwrite> is
+not inherently faster), otherwise false (since it cannot be determined
+in advance if the plugin's C<.zero> will properly honor the semantics
+of C<NBDKIT_FLAG_FAST_ZERO>).

 =3Dhead2 C<.can_extents>

@@ -804,15 +832,25 @@ bytes of zeroes at C<offset> in the backing store.

 This function will not be called if C<.can_zero> returned false.  On
 input, the parameter C<flags> may include C<NBDKIT_FLAG_MAY_TRIM>
-unconditionally, and C<NBDKIT_FLAG_FUA> based on the result of
-C<.can_fua>.
+unconditionally, C<NBDKIT_FLAG_FUA> based on the result of
+C<.can_fua>, and C<NBDKIT_FLAG_FAST_ZERO> based on the result of
+C<.can_fast_zero>.

 If C<NBDKIT_FLAG_MAY_TRIM> is requested, the operation can punch a
 hole instead of writing actual zero bytes, but only if subsequent
-reads from the hole read as zeroes.  If this callback is omitted, or
-if it fails with C<ENOTSUP> or C<EOPNOTSUPP> (whether by
-C<nbdkit_set_error> or C<errno>), then C<.pwrite> will be used
-instead.
+reads from the hole read as zeroes.
+
+If C<NBDKIT_FLAG_FAST_ZERO> is requested, the plugin must decide up
+front if the implementation is likely to be faster than a
+corresponding C<.pwrite>; if not, then it must immediately fail with
+C<ENOTSUP> or C<EOPNOTSUPP> (whether by C<nbdkit_set_error> or
+C<errno>) and preferably without modifying the exported image.  It is
+acceptable to always fail a fast zero request (as a fast failure is
+better than attempting the write only to find out after the fact that
+it was not fast after all).  Note that on Linux, support for
+C<ioctl(BLKZEROOUT)> is insufficient for determining whether a zero
+request to a block device will be fast (because the kernel will
+perform a slow fallback when needed).

 The callback must write the whole C<count> bytes if it can.  The NBD
 protocol doesn't allow partial writes (instead, these would be
@@ -823,6 +861,11 @@ If there is an error, C<.zero> should call C<nbdkit_=
error> with an
 error message, and C<nbdkit_set_error> to record an appropriate error
 (unless C<errno> is sufficient), then return C<-1>.

+If this callback is omitted, or if it fails with C<ENOTSUP> or
+C<EOPNOTSUPP> (whether by C<nbdkit_set_error> or C<errno>), then
+C<.pwrite> will be used as an automatic fallback except when the
+client requested a fast zero.
+
 =3Dhead2 C<.extents>

  int extents (void *handle, uint32_t count, uint64_t offset,
@@ -1221,6 +1264,7 @@ and then users will be able to run it like this:
 =3Dhead1 SEE ALSO

 L<nbdkit(1)>,
+L<nbdkit-nozero-filter(3)>,
 L<nbdkit-filter(3)>.

 Standard plugins provided by nbdkit:
diff --git a/plugins/sh/nbdkit-sh-plugin.pod b/plugins/sh/nbdkit-sh-plugi=
n.pod
index 9e9a133e..adb8a0db 100644
--- a/plugins/sh/nbdkit-sh-plugin.pod
+++ b/plugins/sh/nbdkit-sh-plugin.pod
@@ -289,7 +289,10 @@ The script should exit with code C<0> for true or co=
de C<3> for false.

 =3Ditem C<is_rotational>

+=3Ditem C<can_fast_zero>
+
  /path/to/script is_rotational <handle>
+ /path/to/script can_fast_zero <handle>

 The script should exit with code C<0> for true or code C<3> for false.

@@ -361,12 +364,18 @@ also provide a C<can_trim> method which exits with =
code C<0> (true).
  /path/to/script zero <handle> <count> <offset> <flags>

 The C<flags> parameter can be an empty string or a comma-separated
-list of the flags: C<"fua"> and C<"may_trim"> (eg. C<"">, C<"fua">,
-C<"fua,may_trim"> are all possible values).
+list of the flags: C<"fua">, C<"may_trim">, and C<"fast"> (eg. C<"">,
+C<"fua">, C<"fua,may_trim,fast"> are some of the 8 possible values).

 Unlike in other languages, if you provide a C<zero> method you B<must>
 also provide a C<can_zero> method which exits with code C<0> (true).

+To trigger a fallback to <pwrite> on a normal zero request, or to
+respond quickly to the C<"fast"> flag that a specific zero request is
+no faster than a corresponding write, the script must output
+C<ENOTSUP> or C<EOPNOTSUPP> to stderr (possibly followed by a
+description of the problem) before exiting with code C<1> (failure).
+
 =3Ditem C<extents>

  /path/to/script extents <handle> <count> <offset> <flags>
diff --git a/server/plugins.c b/server/plugins.c
index c6dcf408..84329cf4 100644
--- a/server/plugins.c
+++ b/server/plugins.c
@@ -404,11 +404,25 @@ plugin_can_zero (struct backend *b, struct connecti=
on *conn)
 static int
 plugin_can_fast_zero (struct backend *b, struct connection *conn)
 {
+  struct backend_plugin *p =3D container_of (b, struct backend_plugin, b=
ackend);
+  int r;
+
   assert (connection_get_handle (conn, 0));

   debug ("can_fast_zero");

-  return 0; /* Upcoming patch will actually add support. */
+  if (p->plugin.can_fast_zero)
+    return p->plugin.can_fast_zero (connection_get_handle (conn, 0));
+  /* Advertise support for fast zeroes if no .zero or .can_zero is
+   * false: in those cases, we fail fast instead of using .pwrite.
+   * This also works when v1 plugin has only ._zero_old.
+   */
+  if (p->plugin.zero =3D=3D NULL)
+    return 1;
+  r =3D plugin_can_zero (b, conn);
+  if (r =3D=3D -1)
+    return -1;
+  return !r;
 }

 static int
@@ -656,15 +670,18 @@ plugin_zero (struct backend *b, struct connection *=
conn,
   }

   if (can_zero) {
-    /* if (!can_fast_zero) */
-    flags &=3D ~NBDKIT_FLAG_FAST_ZERO;
     errno =3D 0;
     if (p->plugin.zero)
       r =3D p->plugin.zero (connection_get_handle (conn, 0), count, offs=
et,
                           flags);
-    else if (p->plugin._zero_old)
+    else if (p->plugin._zero_old) {
+      if (fast_zero) {
+        *err =3D EOPNOTSUPP;
+        return -1;
+      }
       r =3D p->plugin._zero_old (connection_get_handle (conn, 0), count,=
 offset,
                                may_trim);
+    }
     else
       emulate =3D true;
     if (r =3D=3D -1)
diff --git a/include/nbdkit-plugin.h b/include/nbdkit-plugin.h
index 632df867..45ae7053 100644
--- a/include/nbdkit-plugin.h
+++ b/include/nbdkit-plugin.h
@@ -132,6 +132,8 @@ struct nbdkit_plugin {
   int (*cache) (void *handle, uint32_t count, uint64_t offset, uint32_t =
flags);

   int (*thread_model) (void);
+
+  int (*can_fast_zero) (void *handle);
 };

 extern void nbdkit_set_error (int err);
diff --git a/plugins/data/data.c b/plugins/data/data.c
index 14fb8997..9004a487 100644
--- a/plugins/data/data.c
+++ b/plugins/data/data.c
@@ -349,6 +349,13 @@ data_can_cache (void *handle)
   return NBDKIT_CACHE_NATIVE;
 }

+/* Fast zero. */
+static int
+data_can_fast_zero (void *handle)
+{
+  return 1;
+}
+
 /* Read data. */
 static int
 data_pread (void *handle, void *buf, uint32_t count, uint64_t offset,
@@ -375,8 +382,10 @@ data_pwrite (void *handle, const void *buf, uint32_t=
 count, uint64_t offset,
 static int
 data_zero (void *handle, uint32_t count, uint64_t offset, uint32_t flags=
)
 {
-  /* Flushing, and thus FUA flag, is a no-op */
-  assert ((flags & ~(NBDKIT_FLAG_FUA | NBDKIT_FLAG_MAY_TRIM)) =3D=3D 0);
+  /* Flushing, and thus FUA flag, is a no-op. Assume that
+   * sparse_array_zero generally beats writes, so FAST_ZERO is a no-op. =
*/
+  assert ((flags & ~(NBDKIT_FLAG_FUA | NBDKIT_FLAG_MAY_TRIM |
+                     NBDKIT_FLAG_FAST_ZERO)) =3D=3D 0);
   ACQUIRE_LOCK_FOR_CURRENT_SCOPE (&lock);
   sparse_array_zero (sa, count, offset);
   return 0;
@@ -423,6 +432,7 @@ static struct nbdkit_plugin plugin =3D {
   .can_multi_conn    =3D data_can_multi_conn,
   .can_fua           =3D data_can_fua,
   .can_cache         =3D data_can_cache,
+  .can_fast_zero     =3D data_can_fast_zero,
   .pread             =3D data_pread,
   .pwrite            =3D data_pwrite,
   .zero              =3D data_zero,
diff --git a/plugins/full/full.c b/plugins/full/full.c
index 9cfbcfcd..0b69a8c9 100644
--- a/plugins/full/full.c
+++ b/plugins/full/full.c
@@ -129,13 +129,10 @@ full_pwrite (void *handle, const void *buf, uint32_=
t count, uint64_t offset,
   return -1;
 }

-/* Write zeroes. */
-static int
-full_zero (void *handle, uint32_t count, uint64_t offset, uint32_t flags=
)
-{
-  errno =3D ENOSPC;
-  return -1;
-}
+/* Omitting full_zero is intentional: that way, nbdkit defaults to
+ * permitting fast zeroes which respond with ENOTSUP, while normal
+ * zeroes fall back to pwrite and respond with ENOSPC.
+ */

 /* Trim. */
 static int
@@ -172,7 +169,6 @@ static struct nbdkit_plugin plugin =3D {
   .can_cache         =3D full_can_cache,
   .pread             =3D full_pread,
   .pwrite            =3D full_pwrite,
-  .zero              =3D full_zero,
   .trim              =3D full_trim,
   .extents           =3D full_extents,
   /* In this plugin, errno is preserved properly along error return
diff --git a/plugins/memory/memory.c b/plugins/memory/memory.c
index 09162ea2..e831a7b5 100644
--- a/plugins/memory/memory.c
+++ b/plugins/memory/memory.c
@@ -147,6 +147,13 @@ memory_can_cache (void *handle)
   return NBDKIT_CACHE_NATIVE;
 }

+/* Fast zero. */
+static int
+memory_can_fast_zero (void *handle)
+{
+  return 1;
+}
+
 /* Read data. */
 static int
 memory_pread (void *handle, void *buf, uint32_t count, uint64_t offset,
@@ -173,8 +180,10 @@ memory_pwrite (void *handle, const void *buf, uint32=
_t count, uint64_t offset,
 static int
 memory_zero (void *handle, uint32_t count, uint64_t offset, uint32_t fla=
gs)
 {
-  /* Flushing, and thus FUA flag, is a no-op */
-  assert ((flags & ~(NBDKIT_FLAG_FUA | NBDKIT_FLAG_MAY_TRIM)) =3D=3D 0);
+  /* Flushing, and thus FUA flag, is a no-op. Assume that
+   * sparse_array_zero generally beats writes, so FAST_ZERO is a no-op. =
*/
+  assert ((flags & ~(NBDKIT_FLAG_FUA | NBDKIT_FLAG_MAY_TRIM |
+                     NBDKIT_FLAG_FAST_ZERO)) =3D=3D 0);
   ACQUIRE_LOCK_FOR_CURRENT_SCOPE (&lock);
   sparse_array_zero (sa, count, offset);
   return 0;
@@ -221,6 +230,7 @@ static struct nbdkit_plugin plugin =3D {
   .can_fua           =3D memory_can_fua,
   .can_multi_conn    =3D memory_can_multi_conn,
   .can_cache         =3D memory_can_cache,
+  .can_fast_zero     =3D memory_can_fast_zero,
   .pread             =3D memory_pread,
   .pwrite            =3D memory_pwrite,
   .zero              =3D memory_zero,
diff --git a/plugins/nbd/nbd.c b/plugins/nbd/nbd.c
index 09c8891e..cddcfde2 100644
--- a/plugins/nbd/nbd.c
+++ b/plugins/nbd/nbd.c
@@ -633,6 +633,24 @@ nbdplug_can_zero (void *handle)
   return i;
 }

+static int
+nbdplug_can_fast_zero (void *handle)
+{
+#if LIBNBD_HAVE_NBD_CAN_FAST_ZERO
+  struct handle *h =3D handle;
+  int i =3D nbd_can_fast_zero (h->nbd);
+
+  if (i =3D=3D -1) {
+    nbdkit_error ("failure to check fast zero flag: %s", nbd_get_error (=
));
+    return -1;
+  }
+  return i;
+#else
+  /* libnbd 0.9.8 lacks fast zero support */
+  return 0;
+#endif
+}
+
 static int
 nbdplug_can_fua (void *handle)
 {
@@ -724,12 +742,19 @@ nbdplug_zero (void *handle, uint32_t count, uint64_=
t offset, uint32_t flags)
   struct transaction s;
   uint32_t f =3D 0;

-  assert (!(flags & ~(NBDKIT_FLAG_FUA | NBDKIT_FLAG_MAY_TRIM)));
+  assert (!(flags & ~(NBDKIT_FLAG_FUA | NBDKIT_FLAG_MAY_TRIM |
+                      NBDKIT_FLAG_FAST_ZERO)));

   if (!(flags & NBDKIT_FLAG_MAY_TRIM))
     f |=3D LIBNBD_CMD_FLAG_NO_HOLE;
   if (flags & NBDKIT_FLAG_FUA)
     f |=3D LIBNBD_CMD_FLAG_FUA;
+#if LIBNBD_HAVE_NBD_CAN_FAST_ZERO
+  if (flags & NBDKIT_FLAG_FAST_ZERO)
+    f |=3D LIBNBD_CMD_FLAG_FAST_ZERO;
+#else
+  assert (!(flags & NBDKIT_FLAG_FAST_ZERO));
+#endif
   nbdplug_prepare (&s);
   nbdplug_register (h, &s, nbd_aio_zero (h->nbd, count, offset, s.cb, f)=
);
   return nbdplug_reply (h, &s);
@@ -831,6 +856,7 @@ static struct nbdkit_plugin plugin =3D {
   .is_rotational      =3D nbdplug_is_rotational,
   .can_trim           =3D nbdplug_can_trim,
   .can_zero           =3D nbdplug_can_zero,
+  .can_fast_zero      =3D nbdplug_can_fast_zero,
   .can_fua            =3D nbdplug_can_fua,
   .can_multi_conn     =3D nbdplug_can_multi_conn,
   .can_extents        =3D nbdplug_can_extents,
diff --git a/plugins/null/null.c b/plugins/null/null.c
index 647624ba..559cb815 100644
--- a/plugins/null/null.c
+++ b/plugins/null/null.c
@@ -100,6 +100,13 @@ null_can_cache (void *handle)
   return NBDKIT_CACHE_NATIVE;
 }

+/* Fast zero. */
+static int
+null_can_fast_zero (void *handle)
+{
+  return 1;
+}
+
 /* Read data. */
 static int
 null_pread (void *handle, void *buf, uint32_t count, uint64_t offset,
@@ -167,6 +174,7 @@ static struct nbdkit_plugin plugin =3D {
   .get_size          =3D null_get_size,
   .can_multi_conn    =3D null_can_multi_conn,
   .can_cache         =3D null_can_cache,
+  .can_fast_zero     =3D null_can_fast_zero,
   .pread             =3D null_pread,
   .pwrite            =3D null_pwrite,
   .zero              =3D null_zero,
diff --git a/plugins/ocaml/ocaml.c b/plugins/ocaml/ocaml.c
index 144a449e..a655f9ca 100644
--- a/plugins/ocaml/ocaml.c
+++ b/plugins/ocaml/ocaml.c
@@ -134,6 +134,8 @@ static value cache_fn;

 static value thread_model_fn;

+static value can_fast_zero_fn;
+
 /*----------------------------------------------------------------------=
*/
 /* Wrapper functions that translate calls from C (ie. nbdkit) to OCaml. =
*/

@@ -705,6 +707,25 @@ thread_model_wrapper (void)
   CAMLreturnT (int, Int_val (rv));
 }

+static int
+can_fast_zero_wrapper (void *h)
+{
+  CAMLparam0 ();
+  CAMLlocal1 (rv);
+
+  caml_leave_blocking_section ();
+
+  rv =3D caml_callback_exn (can_fast_zero_fn, *(value *) h);
+  if (Is_exception_result (rv)) {
+    nbdkit_error ("%s", caml_format_exception (Extract_exception (rv)));
+    caml_enter_blocking_section ();
+    CAMLreturnT (int, -1);
+  }
+
+  caml_enter_blocking_section ();
+  CAMLreturnT (int, Bool_val (rv));
+}
+
 /*----------------------------------------------------------------------=
*/
 /* set_* functions called from OCaml code at load time to initialize
  * fields in the plugin struct.
@@ -792,6 +813,8 @@ SET(cache)

 SET(thread_model)

+SET(can_fast_zero)
+
 #undef SET

 static void
@@ -836,6 +859,8 @@ remove_roots (void)

   REMOVE (thread_model);

+  REMOVE (can_fast_zero);
+
 #undef REMOVE
 }

diff --git a/plugins/sh/sh.c b/plugins/sh/sh.c
index c73b08b7..d5db8b59 100644
--- a/plugins/sh/sh.c
+++ b/plugins/sh/sh.c
@@ -478,6 +478,9 @@ flags_string (uint32_t flags, char *buf, size_t len)

   if (flags & NBDKIT_FLAG_REQ_ONE)
     flag_append ("req_one", &comma, &buf, &len);
+
+  if (flags & NBDKIT_FLAG_FAST_ZERO)
+    flag_append("fast", &comma, &buf, &len);
 }

 static void
@@ -536,7 +539,7 @@ sh_pwrite (void *handle, const void *buf, uint32_t co=
unt, uint64_t offset,

 /* Common code for handling all boolean methods like can_write etc. */
 static int
-boolean_method (void *handle, const char *method_name)
+boolean_method (void *handle, const char *method_name, int def)
 {
   char *h =3D handle;
   const char *args[] =3D { script, method_name, h, NULL };
@@ -546,8 +549,8 @@ boolean_method (void *handle, const char *method_name=
)
     return 1;
   case RET_FALSE:               /* false */
     return 0;
-  case MISSING:                 /* missing =3D> assume false */
-    return 0;
+  case MISSING:                 /* missing =3D> caller chooses default *=
/
+    return def;
   case ERROR:                   /* error cases */
     return -1;
   default: abort ();
@@ -557,37 +560,37 @@ boolean_method (void *handle, const char *method_na=
me)
 static int
 sh_can_write (void *handle)
 {
-  return boolean_method (handle, "can_write");
+  return boolean_method (handle, "can_write", 0);
 }

 static int
 sh_can_flush (void *handle)
 {
-  return boolean_method (handle, "can_flush");
+  return boolean_method (handle, "can_flush", 0);
 }

 static int
 sh_is_rotational (void *handle)
 {
-  return boolean_method (handle, "is_rotational");
+  return boolean_method (handle, "is_rotational", 0);
 }

 static int
 sh_can_trim (void *handle)
 {
-  return boolean_method (handle, "can_trim");
+  return boolean_method (handle, "can_trim", 0);
 }

 static int
 sh_can_zero (void *handle)
 {
-  return boolean_method (handle, "can_zero");
+  return boolean_method (handle, "can_zero", 0);
 }

 static int
 sh_can_extents (void *handle)
 {
-  return boolean_method (handle, "can_extents");
+  return boolean_method (handle, "can_extents", 0);
 }

 /* Not a boolean method, the method prints "none", "emulate" or "native"=
. */
@@ -646,7 +649,7 @@ sh_can_fua (void *handle)
 static int
 sh_can_multi_conn (void *handle)
 {
-  return boolean_method (handle, "can_multi_conn");
+  return boolean_method (handle, "can_multi_conn", 0);
 }

 /* Not a boolean method, the method prints "none", "emulate" or "native"=
. */
@@ -696,6 +699,21 @@ sh_can_cache (void *handle)
   }
 }

+static int
+sh_can_fast_zero (void *handle)
+{
+  int r =3D boolean_method (handle, "can_fast_zero", 2);
+  if (r < 2)
+    return r;
+  /* We need to duplicate the logic of plugins.c: if can_fast_zero is
+   * missing, we advertise fast fail support when can_zero is false.
+   */
+  r =3D sh_can_zero (handle);
+  if (r =3D=3D -1)
+    return -1;
+  return !r;
+}
+
 static int
 sh_flush (void *handle, uint32_t flags)
 {
@@ -962,6 +980,7 @@ static struct nbdkit_plugin plugin =3D {
   .can_fua           =3D sh_can_fua,
   .can_multi_conn    =3D sh_can_multi_conn,
   .can_cache         =3D sh_can_cache,
+  .can_fast_zero     =3D sh_can_fast_zero,

   .pread             =3D sh_pread,
   .pwrite            =3D sh_pwrite,
diff --git a/plugins/ocaml/NBDKit.ml b/plugins/ocaml/NBDKit.ml
index e54a7705..7002ac03 100644
--- a/plugins/ocaml/NBDKit.ml
+++ b/plugins/ocaml/NBDKit.ml
@@ -96,6 +96,8 @@ type 'a plugin =3D {
   cache : ('a -> int32 -> int64 -> flags -> unit) option;

   thread_model : (unit -> thread_model) option;
+
+  can_fast_zero : ('a -> bool) option;
 }

 let default_callbacks =3D {
@@ -141,6 +143,8 @@ let default_callbacks =3D {
   cache =3D None;

   thread_model =3D None;
+
+  can_fast_zero =3D None;
 }

 external set_name : string -> unit =3D "ocaml_nbdkit_set_name" "noalloc"
@@ -186,6 +190,8 @@ external set_cache : ('a -> int32 -> int64 -> flags -=
> unit) -> unit =3D "ocaml_nb

 external set_thread_model : (unit -> thread_model) -> unit =3D "ocaml_nb=
dkit_set_thread_model"

+external set_can_fast_zero : ('a -> bool) -> unit =3D "ocaml_nbdkit_set_=
can_fast_zero"
+
 let may f =3D function None -> () | Some a -> f a

 let register_plugin plugin =3D
@@ -249,7 +255,9 @@ let register_plugin plugin =3D
   may set_can_cache plugin.can_cache;
   may set_cache plugin.cache;

-  may set_thread_model plugin.thread_model
+  may set_thread_model plugin.thread_model;
+
+  may set_can_fast_zero plugin.can_fast_zero

 external _set_error : int -> unit =3D "ocaml_nbdkit_set_error" "noalloc"

diff --git a/plugins/ocaml/NBDKit.mli b/plugins/ocaml/NBDKit.mli
index 778250ef..06648b7f 100644
--- a/plugins/ocaml/NBDKit.mli
+++ b/plugins/ocaml/NBDKit.mli
@@ -101,6 +101,8 @@ type 'a plugin =3D {
   cache : ('a -> int32 -> int64 -> flags -> unit) option;

   thread_model : (unit -> thread_model) option;
+
+  can_fast_zero : ('a -> bool) option;
 }
 (** The plugin fields and callbacks.  ['a] is the handle type. *)

diff --git a/plugins/rust/src/lib.rs b/plugins/rust/src/lib.rs
index 53619dd9..313b4ca6 100644
--- a/plugins/rust/src/lib.rs
+++ b/plugins/rust/src/lib.rs
@@ -105,6 +105,8 @@ pub struct Plugin {
                                  flags: u32) -> c_int>,

     pub thread_model: Option<extern fn () -> ThreadModel>,
+
+    pub can_fast_zero: Option<extern fn (h: *mut c_void) -> c_int>,
 }

 #[repr(C)]
@@ -163,6 +165,7 @@ impl Plugin {
             can_cache: None,
             cache: None,
             thread_model: None,
+            can_fast_zero: None,
         }
     }
 }
diff --git a/tests/test-eflags.sh b/tests/test-eflags.sh
index f5cd43ed..9b3a6a3a 100755
--- a/tests/test-eflags.sh
+++ b/tests/test-eflags.sh
@@ -68,6 +68,7 @@ SEND_DF=3D$((           1 <<  7 ))
 CAN_MULTI_CONN=3D$((    1 <<  8 ))
 SEND_RESIZE=3D$((       1 <<  9 ))
 SEND_CACHE=3D$((        1 << 10 ))
+SEND_FAST_ZERO=3D$((    1 << 11 ))

 do_nbdkit ()
 {
@@ -133,8 +134,8 @@ EOF
 #----------------------------------------------------------------------
 # can_write=3Dtrue
 #
-# NBD_FLAG_SEND_WRITE_ZEROES is set on writable connections
-# even when can_zero returns false, because nbdkit reckons it
+# NBD_FLAG_SEND_WRITE_ZEROES and NBD_FLAG_SEND_FAST_ZERO are set on writ=
able
+# connections even when can_zero returns false, because nbdkit reckons i=
t
 # can emulate zeroing using pwrite.

 do_nbdkit <<'EOF'
@@ -145,8 +146,8 @@ case "$1" in
 esac
 EOF

-[ $eflags -eq $(( HAS_FLAGS|SEND_WRITE_ZEROES|SEND_DF )) ] ||
-    fail "$LINENO: expected HAS_FLAGS|SEND_WRITE_ZEROES|SEND_DF"
+[ $eflags -eq $(( HAS_FLAGS|SEND_WRITE_ZEROES|SEND_DF|SEND_FAST_ZERO )) =
] ||
+    fail "$LINENO: expected HAS_FLAGS|SEND_WRITE_ZEROES|SEND_DF|SEND_FAS=
T_ZERO"

 #----------------------------------------------------------------------
 # --filter=3Dnozero
@@ -255,8 +256,8 @@ case "$1" in
 esac
 EOF

-[ $eflags -eq $(( HAS_FLAGS|SEND_TRIM|SEND_WRITE_ZEROES|SEND_DF )) ] ||
-    fail "$LINENO: expected HAS_FLAGS|SEND_TRIM|SEND_WRITE_ZEROES|SEND_D=
F"
+[ $eflags -eq $(( HAS_FLAGS|SEND_TRIM|SEND_WRITE_ZEROES|SEND_DF|SEND_FAS=
T_ZERO )) ] ||
+    fail "$LINENO: expected HAS_FLAGS|SEND_TRIM|SEND_WRITE_ZEROES|SEND_D=
F|SEND_FAST_ZERO"

 #----------------------------------------------------------------------
 # can_write=3Dtrue
@@ -271,8 +272,8 @@ case "$1" in
 esac
 EOF

-[ $eflags -eq $(( HAS_FLAGS|ROTATIONAL|SEND_WRITE_ZEROES|SEND_DF )) ] ||
-    fail "$LINENO: expected HAS_FLAGS|ROTATIONAL|SEND_WRITE_ZEROES|SEND_=
DF"
+[ $eflags -eq $(( HAS_FLAGS|ROTATIONAL|SEND_WRITE_ZEROES|SEND_DF|SEND_FA=
ST_ZERO )) ] ||
+    fail "$LINENO: expected HAS_FLAGS|ROTATIONAL|SEND_WRITE_ZEROES|SEND_=
DF|SEND_FAST_ZERO"

 #----------------------------------------------------------------------
 # -r
@@ -304,8 +305,8 @@ case "$1" in
 esac
 EOF

-[ $eflags -eq $(( HAS_FLAGS|SEND_FUA|SEND_WRITE_ZEROES|SEND_DF )) ] ||
-    fail "$LINENO: expected HAS_FLAGS|SEND_FUA|SEND_WRITE_ZEROES|SEND_DF=
"
+[ $eflags -eq $(( HAS_FLAGS|SEND_FUA|SEND_WRITE_ZEROES|SEND_DF|SEND_FAST=
_ZERO )) ] ||
+    fail "$LINENO: expected HAS_FLAGS|SEND_FUA|SEND_WRITE_ZEROES|SEND_DF=
|SEND_FAST_ZERO"

 #----------------------------------------------------------------------
 # -r
@@ -341,8 +342,8 @@ case "$1" in
 esac
 EOF

-[ $eflags -eq $(( HAS_FLAGS|SEND_FLUSH|SEND_FUA|SEND_WRITE_ZEROES|SEND_D=
F )) ] ||
-    fail "$LINENO: expected HAS_FLAGS|SEND_FLUSH|SEND_FUA|SEND_WRITE_ZER=
OES|SEND_DF"
+[ $eflags -eq $(( HAS_FLAGS|SEND_FLUSH|SEND_FUA|SEND_WRITE_ZEROES|SEND_D=
F|SEND_FAST_ZERO )) ] ||
+    fail "$LINENO: expected HAS_FLAGS|SEND_FLUSH|SEND_FUA|SEND_WRITE_ZER=
OES|SEND_DF|SEND_FAST_ZERO"

 #----------------------------------------------------------------------
 # can_write=3Dtrue
@@ -361,8 +362,8 @@ case "$1" in
 esac
 EOF

-[ $eflags -eq $(( HAS_FLAGS|SEND_FLUSH|SEND_WRITE_ZEROES|SEND_DF )) ] ||
-    fail "$LINENO: expected HAS_FLAGS|SEND_FLUSH|SEND_WRITE_ZEROES|SEND_=
DF"
+[ $eflags -eq $(( HAS_FLAGS|SEND_FLUSH|SEND_WRITE_ZEROES|SEND_DF|SEND_FA=
ST_ZERO )) ] ||
+    fail "$LINENO: expected HAS_FLAGS|SEND_FLUSH|SEND_WRITE_ZEROES|SEND_=
DF|SEND_FAST_ZERO"

 #----------------------------------------------------------------------
 # -r
@@ -448,3 +449,96 @@ EOF

 [ $eflags -eq $(( HAS_FLAGS|READ_ONLY|SEND_DF )) ] ||
     fail "$LINENO: expected HAS_FLAGS|READ_ONLY|SEND_DF"
+
+#----------------------------------------------------------------------
+# -r
+# can_fast_zero=3Dtrue
+#
+# Fast zero support isn't advertised without regular zero support
+
+do_nbdkit -r <<'EOF'
+case "$1" in
+     get_size) echo 1M ;;
+     can_fast_zero) exit 0 ;;
+     *) exit 2 ;;
+esac
+EOF
+
+[ $eflags -eq $(( HAS_FLAGS|READ_ONLY|SEND_DF )) ] ||
+    fail "$LINENO: expected HAS_FLAGS|READ_ONLY|SEND_DF"
+
+#----------------------------------------------------------------------
+# --filter=3Dnozero
+# can_write=3Dtrue
+# can_fast_zero=3Dtrue
+#
+# Fast zero support isn't advertised without regular zero support
+
+do_nbdkit --filter=3Dnozero <<'EOF'
+case "$1" in
+     get_size) echo 1M ;;
+     can_write) exit 0 ;;
+     can_fast_zero) exit 0 ;;
+     *) exit 2 ;;
+esac
+EOF
+
+[ $eflags -eq $(( HAS_FLAGS|SEND_DF )) ] ||
+    fail "$LINENO: expected HAS_FLAGS|SEND_DF"
+
+#----------------------------------------------------------------------
+# can_write=3Dtrue
+# can_zero=3Dtrue
+#
+# Fast zero support is omitted for a plugin that has .zero but did not o=
pt in
+
+do_nbdkit -r <<'EOF'
+case "$1" in
+     get_size) echo 1M ;;
+     can_write) exit 0 ;;
+     can_zero) exit 0 ;;
+     *) exit 2 ;;
+esac
+EOF
+
+[ $eflags -eq $(( HAS_FLAGS|READ_ONLY|SEND_DF )) ] ||
+    fail "$LINENO: expected HAS_FLAGS|READ_ONLY|SEND_DF"
+
+#----------------------------------------------------------------------
+# can_write=3Dtrue
+# can_zero=3Dtrue
+# can_fast_zero=3Dfalse
+#
+# Fast zero support is omitted if the plugin says so
+
+do_nbdkit -r <<'EOF'
+case "$1" in
+     get_size) echo 1M ;;
+     can_write) exit 0 ;;
+     can_zero) exit 0 ;;
+     can_fast_zero) exit 3 ;;
+     *) exit 2 ;;
+esac
+EOF
+
+[ $eflags -eq $(( HAS_FLAGS|READ_ONLY|SEND_DF )) ] ||
+    fail "$LINENO: expected HAS_FLAGS|READ_ONLY|SEND_DF"
+
+#----------------------------------------------------------------------
+# can_write=3Dtrue
+# can_zero=3Dfalse
+# can_fast_zero=3Dfalse
+#
+# Fast zero support is omitted if the plugin says so
+
+do_nbdkit -r <<'EOF'
+case "$1" in
+     get_size) echo 1M ;;
+     can_write) exit 0 ;;
+     can_fast_zero) exit 3 ;;
+     *) exit 2 ;;
+esac
+EOF
+
+[ $eflags -eq $(( HAS_FLAGS|READ_ONLY|SEND_DF )) ] ||
+    fail "$LINENO: expected HAS_FLAGS|READ_ONLY|SEND_DF"
--=20
2.21.0


