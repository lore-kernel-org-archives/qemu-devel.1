Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31098C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 14:56:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC3E622CE3
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 14:56:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC3E622CE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1AzW-000864-UO
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 10:56:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52223)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1i1AkY-00087E-MD
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 10:41:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1i1AkV-0008M1-Cf
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 10:41:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53276)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1i1AkN-0008Af-Tu; Fri, 23 Aug 2019 10:41:00 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C8FB18D5BBB;
 Fri, 23 Aug 2019 14:40:58 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-234.phx2.redhat.com [10.3.116.234])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 583FA60126;
 Fri, 23 Aug 2019 14:40:58 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: libguestfs@redhat.com
Date: Fri, 23 Aug 2019 09:40:53 -0500
Message-Id: <20190823144054.27420-3-eblake@redhat.com>
In-Reply-To: <20190823144054.27420-1-eblake@redhat.com>
References: <25ead363-4f37-5450-b985-1876374e314d@redhat.com>
 <20190823144054.27420-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.69]); Fri, 23 Aug 2019 14:40:58 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [nbdkit PATCH 2/3] filters: Add .can_fast_zero hook
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

Allow filters to affect the handling of the new NBD_CMD_FLAG_FAST_ZERO
flag, then update affected filters.  In particular, the log filter
logs the state of the new flag (requires a tweak to expected output in
test-fua.sh), the delay filter gains a bool parameter delay-fast-zero,
several filters reject all fast requests because of local writes or
splitting a single client request into multiple plugin requests, and
the nozero filter gains additional modes for controlling fast zero
advertisement and support:

    zeromode=E2=86=92   none  emulate  notrim  plugin
=E2=86=93fastzeromode                          (new)
---------------------------------------------
default          0      2        4      4
none             0      1        1      1
slow             0      2        2      2
ignore           0      3        3      3

0 - no zero advertised, thus no fast zero advertised
1 - fast zero not advertised
2 - fast zero advertised, but fast zero requests fail with
    ENOTSUP (ie. a fast zero was not possible)
3 - fast zero advertised, but fast zero requests are treated
    the same as normal requests (ignoring the fast zero flag,
    aids testing at the probable cost of spec non-compliance)
4 - fast zero advertisement/reaction is up to the plugin

Mode none/default remains the default for back-compat, and mode
plugin/default has no semantic change compared to omitting the nozero
filter from the command line.

Filters untouched by this patch are fine inheriting whatever fast-zero
behavior the underlying plugin uses.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 docs/nbdkit-filter.pod                  | 27 +++++++----
 filters/delay/nbdkit-delay-filter.pod   | 15 +++++-
 filters/log/nbdkit-log-filter.pod       |  2 +-
 filters/nozero/nbdkit-nozero-filter.pod | 41 +++++++++++++---
 server/filters.c                        | 15 +++++-
 include/nbdkit-filter.h                 |  3 ++
 filters/blocksize/blocksize.c           | 12 +++++
 filters/cache/cache.c                   | 20 ++++++++
 filters/cow/cow.c                       | 20 ++++++++
 filters/delay/delay.c                   | 28 ++++++++++-
 filters/log/log.c                       | 16 ++++---
 filters/nozero/nozero.c                 | 62 +++++++++++++++++++++++--
 filters/truncate/truncate.c             | 15 ++++++
 tests/test-fua.sh                       |  4 +-
 14 files changed, 248 insertions(+), 32 deletions(-)

diff --git a/docs/nbdkit-filter.pod b/docs/nbdkit-filter.pod
index 6e2bea61..ebce8961 100644
--- a/docs/nbdkit-filter.pod
+++ b/docs/nbdkit-filter.pod
@@ -361,6 +361,8 @@ calls.

 =3Dhead2 C<.can_zero>

+=3Dhead2 C<.can_fast_zero>
+
 =3Dhead2 C<.can_extents>

 =3Dhead2 C<.can_fua>
@@ -380,6 +382,8 @@ calls.
                   void *handle);
  int (*can_zero) (struct nbdkit_next_ops *next_ops, void *nxdata,
                   void *handle);
+ int (*can_fast_zero) (struct nbdkit_next_ops *next_ops, void *nxdata,
+                       void *handle);
  int (*can_extents) (struct nbdkit_next_ops *next_ops, void *nxdata,
                      void *handle);
  int (*can_fua) (struct nbdkit_next_ops *next_ops, void *nxdata,
@@ -517,22 +521,25 @@ turn, the filter should not call C<next_ops-E<gt>ze=
ro> if
 C<next_ops-E<gt>can_zero> did not return true.

 On input, the parameter C<flags> may include C<NBDKIT_FLAG_MAY_TRIM>
-unconditionally, and C<NBDKIT_FLAG_FUA> based on the result of
-C<.can_fua>.  In turn, the filter may pass C<NBDKIT_FLAG_MAY_TRIM>
-unconditionally, but should only pass C<NBDKIT_FLAG_FUA> on to
-C<next_ops-E<gt>zero> if C<next_ops-E<gt>can_fua> returned a positive
-value.
+unconditionally, C<NBDKIT_FLAG_FUA> based on the result of
+C<.can_fua>, and C<NBDKIT_FLAG_FAST_ZERO> based on the result of
+C<.can_fast_zero>.  In turn, the filter may pass
+C<NBDKIT_FLAG_MAY_TRIM> unconditionally, but should only pass
+C<NBDKIT_FLAG_FUA> or C<NBDKIT_FLAG_FAST_ZERO> on to
+C<next_ops-E<gt>zero> if the corresponding C<next_ops-E<gt>can_fua> or
+C<next_ops-E<gt>can_fast_zero> returned a positive value.

 Note that unlike the plugin C<.zero> which is permitted to fail with
 C<ENOTSUP> or C<EOPNOTSUPP> to force a fallback to C<.pwrite>, the
-function C<next_ops-E<gt>zero> will never fail with C<err> set to
-C<ENOTSUP> or C<EOPNOTSUPP> because the fallback has already taken
-place.
+function C<next_ops-E<gt>zero> will not fail with C<err> set to
+C<ENOTSUP> or C<EOPNOTSUPP> unless C<NBDKIT_FLAG_FAST_ZERO> was used,
+because otherwise the fallback has already taken place.

 If there is an error, C<.zero> should call C<nbdkit_error> with an
 error message B<and> return -1 with C<err> set to the positive errno
-value to return to the client.  The filter should never fail with
-C<ENOTSUP> or C<EOPNOTSUPP> (while plugins have automatic fallback to
+value to return to the client.  The filter should not fail with
+C<ENOTSUP> or C<EOPNOTSUPP> unless C<flags> includes
+C<NBDKIT_FLAG_FAST_ZERO> (while plugins have automatic fallback to
 C<.pwrite>, filters do not).

 =3Dhead2 C<.extents>
diff --git a/filters/delay/nbdkit-delay-filter.pod b/filters/delay/nbdkit=
-delay-filter.pod
index 730cea4c..0a9c77f7 100644
--- a/filters/delay/nbdkit-delay-filter.pod
+++ b/filters/delay/nbdkit-delay-filter.pod
@@ -12,6 +12,7 @@ nbdkit-delay-filter - nbdkit delay filter
           delay-read=3D(SECS|NNms) delay-write=3D(SECS|NNms)
           delay-zero=3D(SECS|NNms) delay-trim=3D(SECS|NNms)
           delay-extents=3D(SECS|NNms) delay-cache=3D(SECS|NNms)
+          delay-fast-zero=3DBOOL

 =3Dhead1 DESCRIPTION

@@ -56,7 +57,8 @@ Delay write operations by C<SECS> seconds or C<NN> mill=
iseconds.

 =3Ditem B<delay-zero=3D>NNB<ms>

-Delay zero operations by C<SECS> seconds or C<NN> milliseconds.
+Delay zero operations by C<SECS> seconds or C<NN> milliseconds.  See
+also B<delay-fast-zero>.

 =3Ditem B<delay-trim=3D>SECS

@@ -85,6 +87,17 @@ milliseconds.
 Delay write, zero and trim operations by C<SECS> seconds or C<NN>
 milliseconds.

+=3Ditem B<delay-fast-zero=3D>BOOL
+
+The NBD specification documents an extension called fast zero, in
+which the client may request that a server should reply with
+C<ENOTSUP> as soon as possible if the zero operation offers no real
+speedup over a corresponding write.  By default, this parameter is
+true, and fast zero requests are serviced by the plugin after the same
+delay as any other zero request; but setting this parameter to false
+instantly fails a fast zero response without waiting for or consulting
+the plugin.
+
 =3Dback

 =3Dhead1 SEE ALSO
diff --git a/filters/log/nbdkit-log-filter.pod b/filters/log/nbdkit-log-f=
ilter.pod
index 9e102bc0..5d9625a1 100644
--- a/filters/log/nbdkit-log-filter.pod
+++ b/filters/log/nbdkit-log-filter.pod
@@ -55,7 +55,7 @@ on the connection).
 An example logging session of a client that performs a single
 successful read is:

- 2018-01-27 20:38:22.959984 connection=3D1 Connect size=3D0x400 write=3D=
1 flush=3D1 rotational=3D0 trim=3D0 zero=3D1 fua=3D1
+ 2018-01-27 20:38:22.959984 connection=3D1 Connect size=3D0x400 write=3D=
1 flush=3D1 rotational=3D0 trim=3D0 zero=3D1 fua=3D1 extents=3D1 cache=3D=
0 fast_zero=3D0
  2018-01-27 20:38:23.001720 connection=3D1 Read id=3D1 offset=3D0x0 coun=
t=3D0x100 ...
  2018-01-27 20:38:23.001995 connection=3D1 ...Read id=3D1 return=3D0 (Su=
ccess)
  2018-01-27 20:38:23.044259 connection=3D1 Disconnect transactions=3D1
diff --git a/filters/nozero/nbdkit-nozero-filter.pod b/filters/nozero/nbd=
kit-nozero-filter.pod
index 144b8230..4fc7dc63 100644
--- a/filters/nozero/nbdkit-nozero-filter.pod
+++ b/filters/nozero/nbdkit-nozero-filter.pod
@@ -4,7 +4,8 @@ nbdkit-nozero-filter - nbdkit nozero filter

 =3Dhead1 SYNOPSIS

- nbdkit --filter=3Dnozero plugin [zeromode=3DMODE] [plugin-args...]
+ nbdkit --filter=3Dnozero plugin [plugin-args...] \
+   [zeromode=3DMODE] [fastzeromode=3DMODE]

 =3Dhead1 DESCRIPTION

@@ -18,7 +19,7 @@ testing client or server fallbacks.

 =3Dover 4

-=3Ditem B<zeromode=3Dnone|emulate|notrim>
+=3Ditem B<zeromode=3Dnone|emulate|notrim|plugin>

 Optional, controls which mode the filter will use.  Mode B<none>
 (default) means that zero support is not advertised to the
@@ -29,8 +30,30 @@ efficient way to write zeros. Since nbdkit E<ge> 1.13.=
4, mode
 B<notrim> means that zero requests are forwarded on to the plugin,
 except that the plugin will never see the NBDKIT_MAY_TRIM flag, to
 determine if the client permitting trimming during zero operations
-makes a difference (it is an error to request this mode if the plugin
-does not support the C<zero> callback).
+makes a difference.  Since nbdkit E<ge> 1.13.9, mode B<plugin> leaves
+normal zero requests up to the plugin, useful when combined with
+C<fastzeromode> for experimenting with the effects of fast zero
+requests.  It is an error to request B<notrim> or B<plugin> if the
+plugin does not support the C<zero> callback.
+
+=3Ditem B<fastzeromode=3Dnone|slow|ignore|default>
+
+Optional since nbdkit E<ge> 1.13.9, controls whether fast zeroes are
+advertised to the client, and if so, how the filter will react to a
+client fast zero request.  Mode B<none> avoids advertising fast zero
+support.  Mode B<slow> advertises fast zero support unconditionally,
+but treats all fast zero requests as an immediate C<ENOTSUP> failure
+rather than performing a fallback.  Mode B<ignore> advertises fast
+zero support, but treats all client fast zero requests as if the flag
+had not been used (this behavior is typically contrary to the NBD
+specification, but can be useful for comparison against the actual
+fast zero implementation to see if fast zeroes make a difference).
+Mode B<default> is selected by default; when paired with
+C<zeromode=3Demulate>, fast zeroes are advertised but fast zero requests
+always fail (similar to C<slow>); when paired with C<zeromode=3Dnotrim>
+or C<zeromode=3Dplugin>, fast zero support is left to the plugin
+(although in the latter case, the nozero filter could be omitted for
+the same behavior).

 =3Dback

@@ -42,11 +65,17 @@ explicitly rather than with C<NBD_CMD_WRITE_ZEROES>:
  nbdkit --filter=3Dnozero file disk.img

 Serve the file F<disk.img>, allowing the client to take advantage of
-less network traffic via C<NBD_CMD_WRITE_ZEROES>, but still forcing
-the data to be written explicitly rather than punching any holes:
+less network traffic via C<NBD_CMD_WRITE_ZEROES>, but fail any fast
+zero requests up front and force all other zero requests to write data
+explicitly rather than punching any holes:

  nbdkit --filter=3Dnozero file zeromode=3Demulate disk.img

+Serve the file F<disk.img>, but do not advertise fast zero support to
+the client even if the plugin supports it:
+
+ nbdkit --filter=3Dnozero file zeromode=3Dplugin fastzeromode=3Dnone dis=
k.img
+
 =3Dhead1 SEE ALSO

 L<nbdkit(1)>,
diff --git a/server/filters.c b/server/filters.c
index 0dd2393e..f2de5e4e 100644
--- a/server/filters.c
+++ b/server/filters.c
@@ -314,6 +314,13 @@ next_can_zero (void *nxdata)
   return b_conn->b->can_zero (b_conn->b, b_conn->conn);
 }

+static int
+next_can_fast_zero (void *nxdata)
+{
+  struct b_conn *b_conn =3D nxdata;
+  return b_conn->b->can_fast_zero (b_conn->b, b_conn->conn);
+}
+
 static int
 next_can_extents (void *nxdata)
 {
@@ -445,6 +452,7 @@ static struct nbdkit_next_ops next_ops =3D {
   .is_rotational =3D next_is_rotational,
   .can_trim =3D next_can_trim,
   .can_zero =3D next_can_zero,
+  .can_fast_zero =3D next_can_fast_zero,
   .can_extents =3D next_can_extents,
   .can_fua =3D next_can_fua,
   .can_multi_conn =3D next_can_multi_conn,
@@ -593,9 +601,14 @@ static int
 filter_can_fast_zero (struct backend *b, struct connection *conn)
 {
   struct backend_filter *f =3D container_of (b, struct backend_filter, b=
ackend);
+  void *handle =3D connection_get_handle (conn, f->backend.i);
+  struct b_conn nxdata =3D { .b =3D f->backend.next, .conn =3D conn };

   debug ("%s: can_fast_zero", f->name);
-  return 0; /* Next patch will query or pass through */
+  if (f->filter.can_fast_zero)
+    return f->filter.can_fast_zero (&next_ops, &nxdata, handle);
+  else
+    return f->backend.next->can_fast_zero (f->backend.next, conn);
 }

 static int
diff --git a/include/nbdkit-filter.h b/include/nbdkit-filter.h
index 94f17789..d11cf881 100644
--- a/include/nbdkit-filter.h
+++ b/include/nbdkit-filter.h
@@ -71,6 +71,7 @@ struct nbdkit_next_ops {
   int (*is_rotational) (void *nxdata);
   int (*can_trim) (void *nxdata);
   int (*can_zero) (void *nxdata);
+  int (*can_fast_zero) (void *nxdata);
   int (*can_extents) (void *nxdata);
   int (*can_fua) (void *nxdata);
   int (*can_multi_conn) (void *nxdata);
@@ -139,6 +140,8 @@ struct nbdkit_filter {
                    void *handle);
   int (*can_zero) (struct nbdkit_next_ops *next_ops, void *nxdata,
                    void *handle);
+  int (*can_fast_zero) (struct nbdkit_next_ops *next_ops, void *nxdata,
+                        void *handle);
   int (*can_extents) (struct nbdkit_next_ops *next_ops, void *nxdata,
                       void *handle);
   int (*can_fua) (struct nbdkit_next_ops *next_ops, void *nxdata,
diff --git a/filters/blocksize/blocksize.c b/filters/blocksize/blocksize.=
c
index 0978887f..47638c74 100644
--- a/filters/blocksize/blocksize.c
+++ b/filters/blocksize/blocksize.c
@@ -307,6 +307,18 @@ blocksize_zero (struct nbdkit_next_ops *next_ops, vo=
id *nxdata,
   uint32_t drop;
   bool need_flush =3D false;

+  if (flags & NBDKIT_FLAG_FAST_ZERO) {
+    /* If we have to split the transaction, an ENOTSUP fast failure in
+     * a later call would be unnecessarily delayed behind earlier
+     * calls; it's easier to just declare that anything that can't be
+     * done in one call to the plugin is not fast.
+     */
+    if ((offs | count) & (minblock - 1) || count > maxlen) {
+      *err =3D ENOTSUP;
+      return -1;
+    }
+  }
+
   if ((flags & NBDKIT_FLAG_FUA) &&
       next_ops->can_fua (nxdata) =3D=3D NBDKIT_FUA_EMULATE) {
     flags &=3D ~NBDKIT_FLAG_FUA;
diff --git a/filters/cache/cache.c b/filters/cache/cache.c
index b5dbccd2..7c1d6c4f 100644
--- a/filters/cache/cache.c
+++ b/filters/cache/cache.c
@@ -250,6 +250,17 @@ cache_can_cache (struct nbdkit_next_ops *next_ops, v=
oid *nxdata, void *handle)
   return NBDKIT_CACHE_NATIVE;
 }

+/* Override the plugin's .can_fast_zero, because our .zero is not fast *=
/
+static int
+cache_can_fast_zero (struct nbdkit_next_ops *next_ops, void *nxdata,
+                     void *handle)
+{
+  /* It is better to advertise support even when we always reject fast
+   * zero attempts.
+   */
+  return 1;
+}
+
 /* Read data. */
 static int
 cache_pread (struct nbdkit_next_ops *next_ops, void *nxdata,
@@ -418,6 +429,14 @@ cache_zero (struct nbdkit_next_ops *next_ops, void *=
nxdata,
   int r;
   bool need_flush =3D false;

+  /* We are purposefully avoiding next_ops->zero, so a zero request is
+   * never faster than plain writes.
+   */
+  if (flags & NBDKIT_FLAG_FAST_ZERO) {
+    *err =3D ENOTSUP;
+    return -1;
+  }
+
   block =3D malloc (blksize);
   if (block =3D=3D NULL) {
     *err =3D errno;
@@ -624,6 +643,7 @@ static struct nbdkit_filter filter =3D {
   .prepare           =3D cache_prepare,
   .get_size          =3D cache_get_size,
   .can_cache         =3D cache_can_cache,
+  .can_fast_zero     =3D cache_can_fast_zero,
   .pread             =3D cache_pread,
   .pwrite            =3D cache_pwrite,
   .zero              =3D cache_zero,
diff --git a/filters/cow/cow.c b/filters/cow/cow.c
index 9d91d432..a5c1f978 100644
--- a/filters/cow/cow.c
+++ b/filters/cow/cow.c
@@ -179,6 +179,17 @@ cow_can_cache (struct nbdkit_next_ops *next_ops, voi=
d *nxdata, void *handle)
   return NBDKIT_FUA_NATIVE;
 }

+/* Override the plugin's .can_fast_zero, because our .zero is not fast *=
/
+static int
+cow_can_fast_zero (struct nbdkit_next_ops *next_ops, void *nxdata,
+                   void *handle)
+{
+  /* It is better to advertise support even when we always reject fast
+   * zero attempts.
+   */
+  return 1;
+}
+
 static int cow_flush (struct nbdkit_next_ops *next_ops, void *nxdata, vo=
id *handle, uint32_t flags, int *err);

 /* Read data. */
@@ -340,6 +351,14 @@ cow_zero (struct nbdkit_next_ops *next_ops, void *nx=
data,
   uint64_t blknum, blkoffs;
   int r;

+  /* We are purposefully avoiding next_ops->zero, so a zero request is
+   * never faster than plain writes.
+   */
+  if (flags & NBDKIT_FLAG_FAST_ZERO) {
+    *err =3D ENOTSUP;
+    return -1;
+  }
+
   block =3D malloc (BLKSIZE);
   if (block =3D=3D NULL) {
     *err =3D errno;
@@ -496,6 +515,7 @@ static struct nbdkit_filter filter =3D {
   .can_extents       =3D cow_can_extents,
   .can_fua           =3D cow_can_fua,
   .can_cache         =3D cow_can_cache,
+  .can_fast_zero     =3D cow_can_fast_zero,
   .pread             =3D cow_pread,
   .pwrite            =3D cow_pwrite,
   .zero              =3D cow_zero,
diff --git a/filters/delay/delay.c b/filters/delay/delay.c
index c92a12d7..207d101e 100644
--- a/filters/delay/delay.c
+++ b/filters/delay/delay.c
@@ -37,6 +37,8 @@
 #include <stdlib.h>
 #include <stdint.h>
 #include <string.h>
+#include <stdbool.h>
+#include <errno.h>

 #include <nbdkit-filter.h>

@@ -46,6 +48,7 @@ static int delay_zero_ms =3D 0;   /* zero delay (millis=
econds) */
 static int delay_trim_ms =3D 0;   /* trim delay (milliseconds) */
 static int delay_extents_ms =3D 0;/* extents delay (milliseconds) */
 static int delay_cache_ms =3D 0;  /* cache delay (milliseconds) */
+static int delay_fast_zero =3D 1; /* whether delaying zero includes fast=
 zero */

 static int
 parse_delay (const char *key, const char *value)
@@ -182,6 +185,12 @@ delay_config (nbdkit_next_config *next, void *nxdata=
,
       return -1;
     return 0;
   }
+  else if (strcmp (key, "delay-fast-zero") =3D=3D 0) {
+    delay_fast_zero =3D nbdkit_parse_bool (value);
+    if (delay_fast_zero < 0)
+      return -1;
+    return 0;
+  }
   else
     return next (nxdata, key, value);
 }
@@ -194,7 +203,19 @@ delay_config (nbdkit_next_config *next, void *nxdata=
,
   "delay-trim=3D<NN>[ms]            Trim delay in seconds/milliseconds.\=
n" \
   "delay-extents=3D<NN>[ms]         Extents delay in seconds/millisecond=
s.\n" \
   "delay-cache=3D<NN>[ms]           Cache delay in seconds/milliseconds.=
\n" \
-  "wdelay=3D<NN>[ms]                Write, zero and trim delay in secs/m=
secs."
+  "wdelay=3D<NN>[ms]                Write, zero and trim delay in secs/m=
secs.\n" \
+  "delay-fast-zero=3D<BOOL>         Delay fast zero requests (default tr=
ue).\n"
+
+/* Override the plugin's .can_fast_zero if needed */
+static int
+delay_can_fast_zero (struct nbdkit_next_ops *next_ops, void *nxdata,
+                     void *handle)
+{
+  /* Advertise if we are handling fast zero requests locally */
+  if (delay_zero_ms && !delay_fast_zero)
+    return 1;
+  return next_ops->can_fast_zero (nxdata);
+}

 /* Read data. */
 static int
@@ -225,6 +246,10 @@ delay_zero (struct nbdkit_next_ops *next_ops, void *=
nxdata,
             void *handle, uint32_t count, uint64_t offset, uint32_t flag=
s,
             int *err)
 {
+  if ((flags & NBDKIT_FLAG_FAST_ZERO) && delay_zero_ms && !delay_fast_ze=
ro) {
+    *err =3D ENOTSUP;
+    return -1;
+  }
   if (zero_delay (err) =3D=3D -1)
     return -1;
   return next_ops->zero (nxdata, count, offset, flags, err);
@@ -269,6 +294,7 @@ static struct nbdkit_filter filter =3D {
   .version           =3D PACKAGE_VERSION,
   .config            =3D delay_config,
   .config_help       =3D delay_config_help,
+  .can_fast_zero     =3D delay_can_fast_zero,
   .pread             =3D delay_pread,
   .pwrite            =3D delay_pwrite,
   .zero              =3D delay_zero,
diff --git a/filters/log/log.c b/filters/log/log.c
index 7cf741e1..95667c61 100644
--- a/filters/log/log.c
+++ b/filters/log/log.c
@@ -260,14 +260,15 @@ log_prepare (struct nbdkit_next_ops *next_ops, void=
 *nxdata, void *handle)
   int F =3D next_ops->can_fua (nxdata);
   int e =3D next_ops->can_extents (nxdata);
   int c =3D next_ops->can_cache (nxdata);
+  int Z =3D next_ops->can_fast_zero (nxdata);

   if (size < 0 || w < 0 || f < 0 || r < 0 || t < 0 || z < 0 || F < 0 ||
-      e < 0 || c < 0)
+      e < 0 || c < 0 || Z < 0)
     return -1;

   output (h, "Connect", 0, "size=3D0x%" PRIx64 " write=3D%d flush=3D%d "
-          "rotational=3D%d trim=3D%d zero=3D%d fua=3D%d extents=3D%d cac=
he=3D%d",
-          size, w, f, r, t, z, F, e, c);
+          "rotational=3D%d trim=3D%d zero=3D%d fua=3D%d extents=3D%d cac=
he=3D%d "
+          "fast_zero=3D%d", size, w, f, r, t, z, F, e, c, Z);
   return 0;
 }

@@ -360,10 +361,13 @@ log_zero (struct nbdkit_next_ops *next_ops, void *n=
xdata,
   uint64_t id =3D get_id (h);
   int r;

-  assert (!(flags & ~(NBDKIT_FLAG_FUA | NBDKIT_FLAG_MAY_TRIM)));
-  output (h, "Zero", id, "offset=3D0x%" PRIx64 " count=3D0x%x trim=3D%d =
fua=3D%d ...",
+  assert (!(flags & ~(NBDKIT_FLAG_FUA | NBDKIT_FLAG_MAY_TRIM |
+                      NBDKIT_FLAG_FAST_ZERO)));
+  output (h, "Zero", id,
+          "offset=3D0x%" PRIx64 " count=3D0x%x trim=3D%d fua=3D%d fast=3D=
%d...",
           offs, count, !!(flags & NBDKIT_FLAG_MAY_TRIM),
-          !!(flags & NBDKIT_FLAG_FUA));
+          !!(flags & NBDKIT_FLAG_FUA),
+          !!(flags & NBDKIT_FLAG_FAST_ZERO));
   r =3D next_ops->zero (nxdata, count, offs, flags, err);
   output_return (h, "...Zero", id, r, err);
   return r;
diff --git a/filters/nozero/nozero.c b/filters/nozero/nozero.c
index 964cce9f..e54f7c62 100644
--- a/filters/nozero/nozero.c
+++ b/filters/nozero/nozero.c
@@ -38,6 +38,7 @@
 #include <string.h>
 #include <stdbool.h>
 #include <assert.h>
+#include <errno.h>

 #include <nbdkit-filter.h>

@@ -49,8 +50,16 @@ static enum ZeroMode {
   NONE,
   EMULATE,
   NOTRIM,
+  PLUGIN,
 } zeromode;

+static enum FastZeroMode {
+  DEFAULT,
+  SLOW,
+  IGNORE,
+  NOFAST,
+} fastzeromode;
+
 static int
 nozero_config (nbdkit_next_config *next, void *nxdata,
                const char *key, const char *value)
@@ -60,17 +69,35 @@ nozero_config (nbdkit_next_config *next, void *nxdata=
,
       zeromode =3D EMULATE;
     else if (strcmp (value, "notrim") =3D=3D 0)
       zeromode =3D NOTRIM;
+    else if (strcmp (value, "plugin") =3D=3D 0)
+      zeromode =3D PLUGIN;
     else if (strcmp (value, "none") !=3D 0) {
       nbdkit_error ("unknown zeromode '%s'", value);
       return -1;
     }
     return 0;
   }
+
+  if (strcmp (key, "fastzeromode") =3D=3D 0) {
+    if (strcmp (value, "none") =3D=3D 0)
+      fastzeromode =3D NOFAST;
+    else if (strcmp (value, "ignore") =3D=3D 0)
+      fastzeromode =3D IGNORE;
+    else if (strcmp (value, "slow") =3D=3D 0)
+      fastzeromode =3D SLOW;
+    else if (strcmp (value, "default") !=3D 0) {
+      nbdkit_error ("unknown fastzeromode '%s'", value);
+      return -1;
+    }
+    return 0;
+  }
+
   return next (nxdata, key, value);
 }

 #define nozero_config_help \
-  "zeromode=3D<MODE>      Either 'none' (default), 'emulate', or 'notrim=
'.\n" \
+  "zeromode=3D<MODE>      One of 'none' (default), 'emulate', 'notrim', =
'plugin'.\n" \
+  "fastzeromode=3D<MODE>  One of 'default', 'none', 'slow', 'ignore'.\n"

 /* Check that desired mode is supported by plugin. */
 static int
@@ -78,12 +105,13 @@ nozero_prepare (struct nbdkit_next_ops *next_ops, vo=
id *nxdata, void *handle)
 {
   int r;

-  if (zeromode =3D=3D NOTRIM) {
+  if (zeromode =3D=3D NOTRIM || zeromode =3D=3D PLUGIN) {
     r =3D next_ops->can_zero (nxdata);
     if (r =3D=3D -1)
       return -1;
     if (!r) {
-      nbdkit_error ("zeromode 'notrim' requires plugin zero support");
+      nbdkit_error ("zeromode '%s' requires plugin zero support",
+                    zeromode =3D=3D NOTRIM ? "notrim" : "plugin");
       return -1;
     }
   }
@@ -94,9 +122,22 @@ nozero_prepare (struct nbdkit_next_ops *next_ops, voi=
d *nxdata, void *handle)
 static int
 nozero_can_zero (struct nbdkit_next_ops *next_ops, void *nxdata, void *h=
andle)
 {
+  /* For NOTRIM and PLUGIN modes, we've already verified next_ops->can_z=
ero */
   return zeromode !=3D NONE;
 }

+/* Advertise desired FAST_ZERO mode. */
+static int
+nozero_can_fast_zero (struct nbdkit_next_ops *next_ops, void *nxdata,
+                      void *handle)
+{
+  if (zeromode =3D=3D NONE)
+    return 0;
+  if (zeromode !=3D EMULATE && fastzeromode =3D=3D DEFAULT)
+    return next_ops->can_fast_zero (nxdata);
+  return fastzeromode !=3D NOFAST;
+}
+
 static int
 nozero_zero (struct nbdkit_next_ops *next_ops, void *nxdata,
              void *handle, uint32_t count, uint64_t offs, uint32_t flags=
,
@@ -106,9 +147,21 @@ nozero_zero (struct nbdkit_next_ops *next_ops, void =
*nxdata,
   bool need_flush =3D false;

   assert (zeromode !=3D NONE);
-  flags &=3D ~NBDKIT_FLAG_MAY_TRIM;
+  if (flags & NBDKIT_FLAG_FAST_ZERO) {
+    assert (fastzeromode !=3D NOFAST);
+    if (fastzeromode =3D=3D SLOW ||
+        (fastzeromode =3D=3D DEFAULT && zeromode =3D=3D EMULATE)) {
+      *err =3D ENOTSUP;
+      return -1;
+    }
+    if (fastzeromode =3D=3D IGNORE)
+      flags &=3D ~NBDKIT_FLAG_FAST_ZERO;
+  }

   if (zeromode =3D=3D NOTRIM)
+    flags &=3D ~NBDKIT_FLAG_MAY_TRIM;
+
+  if (zeromode !=3D EMULATE)
     return next_ops->zero (nxdata, count, offs, flags, err);

   if (flags & NBDKIT_FLAG_FUA) {
@@ -144,6 +197,7 @@ static struct nbdkit_filter filter =3D {
   .config_help       =3D nozero_config_help,
   .prepare           =3D nozero_prepare,
   .can_zero          =3D nozero_can_zero,
+  .can_fast_zero     =3D nozero_can_fast_zero,
   .zero              =3D nozero_zero,
 };

diff --git a/filters/truncate/truncate.c b/filters/truncate/truncate.c
index 93d8f074..47d70b31 100644
--- a/filters/truncate/truncate.c
+++ b/filters/truncate/truncate.c
@@ -201,6 +201,14 @@ truncate_get_size (struct nbdkit_next_ops *next_ops,=
 void *nxdata,
   return h->size;
 }

+/* Override the plugin's .can_fast_zero, because zeroing a tail is fast.=
 */
+static int
+truncate_can_fast_zero (struct nbdkit_next_ops *next_ops, void *nxdata,
+                        void *handle)
+{
+  return 1;
+}
+
 /* Read data. */
 static int
 truncate_pread (struct nbdkit_next_ops *next_ops, void *nxdata,
@@ -297,6 +305,12 @@ truncate_zero (struct nbdkit_next_ops *next_ops, voi=
d *nxdata,
       n =3D count;
     else
       n =3D h->real_size - offset;
+    if (flags & NBDKIT_FLAG_FAST_ZERO &&
+        next_ops->can_fast_zero (nxdata) <=3D 0) {
+      /* TODO: Cache per connection? */
+      *err =3D ENOTSUP;
+      return -1;
+    }
     return next_ops->zero (nxdata, n, offset, flags, err);
   }
   return 0;
@@ -392,6 +406,7 @@ static struct nbdkit_filter filter =3D {
   .close             =3D truncate_close,
   .prepare           =3D truncate_prepare,
   .get_size          =3D truncate_get_size,
+  .can_fast_zero     =3D truncate_can_fast_zero,
   .pread             =3D truncate_pread,
   .pwrite            =3D truncate_pwrite,
   .trim              =3D truncate_trim,
diff --git a/tests/test-fua.sh b/tests/test-fua.sh
index c0d82db7..1c869e96 100755
--- a/tests/test-fua.sh
+++ b/tests/test-fua.sh
@@ -106,14 +106,14 @@ test $(grep -c 'connection=3D1 Flush' fua1.log) -lt=
 \
 # all earlier parts of the transaction do not have fua
 flush1=3D$(grep -c 'connection=3D1 Flush' fua2.log || :)
 flush2=3D$(grep -c 'connection=3D2 Flush' fua2.log || :)
-fua=3D$(grep -c 'connection=3D2.*fua=3D1 \.' fua2.log || :)
+fua=3D$(grep -c 'connection=3D2.*fua=3D1 .*\.' fua2.log || :)
 test $(( $flush2 - $flush1 + $fua )) =3D 2

 # Test 3: every part of split has fua, and no flushes are added
 flush1=3D$(grep -c 'connection=3D1 Flush' fua3.log || :)
 flush2=3D$(grep -c 'connection=3D2 Flush' fua3.log || :)
 test $flush1 =3D $flush2
-test $(grep -c 'connection=3D2.*fua=3D1 \.' fua3.log) =3D 32
+test $(grep -c 'connection=3D2.*fua=3D1 .*\.' fua3.log) =3D 32

 # Test 4: flush is no-op, and every transaction has fua
 if grep 'fua=3D0' fua4.log; then
--=20
2.21.0


