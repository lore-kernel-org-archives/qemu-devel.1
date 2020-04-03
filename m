Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C3FAC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 18:05:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4391F206F5
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 18:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KSnSI2DP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4391F206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKQhD-0005Ij-Bj
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 14:05:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41362)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jKQcI-0000qB-AX
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 14:00:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jKQcF-0001W2-Iq
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 14:00:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26589
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jKQcF-0001V3-Bj
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 14:00:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585936827;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W6oxgDkJY3B5R6SJ7RKuzLx01/NRQbNElJcSa+tE1QE=;
 b=KSnSI2DPDWSiV/nQqtuT7gJnf3qxJng2qlH6MH90Yj/d3r2pngIzP4M6NHyhztCiYOoBZ6
 HXVooADrYJVaoj+g+Wz8BzQr0L32ZHUBh2QCwnRywbLI1Zim0x33H0azMhe0YYh+MMrclc
 97xxe+OC20G5dTlXTP0sbJusuDISto4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-JfJcjM1lMHmFir-w4eKURA-1; Fri, 03 Apr 2020 14:00:23 -0400
X-MC-Unique: JfJcjM1lMHmFir-w4eKURA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C5BE118C43CF;
 Fri,  3 Apr 2020 18:00:21 +0000 (UTC)
Received: from blue.redhat.com (ovpn-113-246.phx2.redhat.com [10.3.113.246])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A52125C1B0;
 Fri,  3 Apr 2020 17:59:59 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 7/7] qemu-img: Deprecate use of -b without -F
Date: Fri,  3 Apr 2020 12:58:59 -0500
Message-Id: <20200403175859.863248-8-eblake@redhat.com>
In-Reply-To: <20200403175859.863248-1-eblake@redhat.com>
References: <20200403175859.863248-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: kwolf@redhat.com, pkrempa@redhat.com, qemu-block@nongnu.org,
 kchamart@redhat.com, libvir-list@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Creating an image that requires format probing of the backing image is
inherently unsafe (we've had several CVEs over the years based on
probes leaking information to the guest on a subsequent boot, although
these days tools like libvirt are aware of the issue enough to prevent
the worst effects).  However, if our probing algorithm ever changes,
or if other tools like libvirt determine a different probe result than
we do, then subsequent use of that backing file under a different
format will present corrupted data to the guest.  Start a deprecation
clock so that future qemu-img can refuse to create unsafe backing
chains that would rely on probing.  Most warnings are intentionally
emitted from bdrv_img_create() in the block layer, but qemu-img
convert uses bdrv_create() which cannot emit its own warning without
causing spurious warnings on other code paths.  In the end, all
command-line image creation or backing file rewriting now performs a
check.

However, there is one time where probing is safe: if we probe raw,
then it is safe to record that implicitly in the image (but we still
warn, as it's better to teach the user to supply -F always than to
make them guess when it is safe).

iotest 114 specifically wants to create an unsafe image for later
amendment rather than defaulting to our new default of recording a
probed format, so it needs an update.  While touching it, expand it to
cover all of the various warnings enabled by this patch.  iotest 290
also shows a change to qcow messages; note that the fact that we now
make a probed format of 'raw' explicit now results in a double
warning, but no one should be creating new qcow images so it is not
worth cleaning up.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 docs/system/deprecated.rst | 20 ++++++++++++++++++++
 block.c                    | 21 ++++++++++++++++++++-
 qemu-img.c                 |  9 ++++++++-
 tests/qemu-iotests/114     | 12 ++++++++++++
 tests/qemu-iotests/114.out |  9 +++++++++
 tests/qemu-iotests/290.out |  5 ++++-
 6 files changed, 73 insertions(+), 3 deletions(-)

diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
index aac6be58917a..8abfd436820a 100644
--- a/docs/system/deprecated.rst
+++ b/docs/system/deprecated.rst
@@ -429,6 +429,26 @@ image).  Rather, any changes to the backing chain shou=
ld be performed
 with ``qemu-img rebase -u`` either before or after the remaining
 changes being performed by amend, as appropriate.

+qemu-img backing file without format (since 5.0.0)
+''''''''''''''''''''''''''''''''''''''''''''''''''
+
+The use of ``qemu-img create``, ``qemu-img rebase``, or ``qemu-img
+convert`` to create or modify an image that depends on a backing file
+now recommends that an explicit backing format be provided.  This is
+for safety: if QEMU probes a different format than what you thought,
+the data presented to the guest will be corrupt; similarly, presenting
+a raw image to a guest allows a potential security exploit if a future
+probe sees a non-raw image based on guest writes.
+
+To avoid the warning message, or even future refusal to create an
+unsafe image, you must pass ``-o backing_fmt=3D`` (or the shorthand
+``-F`` during create) to specify the intended backing format.  You may
+use ``qemu-img rebase -u`` to retroactively add a backing format to an
+existing image.  However, be aware that there are already potential
+security risks to blindly using ``qemu-img info`` to probe the format
+of an untrusted backing image, when deciding what format to add into
+an existing image.
+
 ``qemu-img convert -n -o`` (since 4.2.0)
 ''''''''''''''''''''''''''''''''''''''''

diff --git a/block.c b/block.c
index 70cc6123dd91..61871965eee4 100644
--- a/block.c
+++ b/block.c
@@ -6072,6 +6072,20 @@ void bdrv_img_create(const char *filename, const cha=
r *fmt,
                               "Could not open backing image to determine s=
ize.\n");
             goto out;
         } else {
+            if (!backing_fmt) {
+                warn_report("Deprecated use of backing file without explic=
it "
+                            "backing format (detected format of %s)",
+                            bs->drv->format_name);
+                if (bs->drv =3D=3D &bdrv_raw) {
+                    /*
+                     * A probe of raw is always correct, so in this one
+                     * case, we can write that into the image.
+                     */
+                    backing_fmt =3D bs->drv->format_name;
+                    qemu_opt_set(opts, BLOCK_OPT_BACKING_FMT, backing_fmt,
+                                 NULL);
+                }
+            }
             if (size =3D=3D -1) {
                 /* Opened BS, have no size */
                 size =3D bdrv_getlength(bs);
@@ -6085,7 +6099,12 @@ void bdrv_img_create(const char *filename, const cha=
r *fmt,
             }
             bdrv_unref(bs);
         }
-    } /* (backing_file && !(flags & BDRV_O_NO_BACKING)) */
+        /* (backing_file && !(flags & BDRV_O_NO_BACKING)) */
+    } else if (backing_file && !backing_fmt) {
+        warn_report("Deprecated use of unopened backing file without "
+                    "explicit backing format, use of this image requires "
+                    "potentially unsafe format probing");
+    }

     if (size =3D=3D -1) {
         error_setg(errp, "Image creation needs a size parameter");
diff --git a/qemu-img.c b/qemu-img.c
index cb8fa5a0ee8b..fec89da4e18f 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -2414,6 +2414,13 @@ static int img_convert(int argc, char **argv)
         goto out;
     }

+    if (out_baseimg_param) {
+        if (!qemu_opt_get(opts, BLOCK_OPT_BACKING_FMT)) {
+            warn_report("Deprecated use of backing file without explicit "
+                        "backing format");
+        }
+    }
+
     /* Check if compression is supported */
     if (s.compressed) {
         bool encryption =3D
@@ -3644,7 +3651,7 @@ static int img_rebase(int argc, char **argv)
      * doesn't change when we switch the backing file.
      */
     if (out_baseimg && *out_baseimg) {
-        ret =3D bdrv_change_backing_file(bs, out_baseimg, out_basefmt, fal=
se);
+        ret =3D bdrv_change_backing_file(bs, out_baseimg, out_basefmt, tru=
e);
     } else {
         ret =3D bdrv_change_backing_file(bs, NULL, NULL, false);
     }
diff --git a/tests/qemu-iotests/114 b/tests/qemu-iotests/114
index 26104fff6c67..e65bd4f983e0 100755
--- a/tests/qemu-iotests/114
+++ b/tests/qemu-iotests/114
@@ -42,9 +42,16 @@ _unsupported_proto vxhs
 # qcow2.py does not work too well with external data files
 _unsupported_imgopts data_file

+# Intentionally specify backing file without backing format; demonstrate
+# the difference in warning messages when backing file could be probed.
+# Note that only a raw probe result will affect the resulting image.
+truncate --size=3D64M "$TEST_IMG.orig"
+_make_test_img -b "$TEST_IMG.orig" 64M

 TEST_IMG=3D"$TEST_IMG.base" _make_test_img 64M
+$QEMU_IMG convert -O qcow2 -B "$TEST_IMG.orig" "$TEST_IMG.orig" "$TEST_IMG=
"
 _make_test_img -b "$TEST_IMG.base" 64M
+_make_test_img -u -b "$TEST_IMG.base" 64M

 # Set an invalid backing file format
 $PYTHON qcow2.py "$TEST_IMG" add-header-ext 0xE2792ACA "foo"
@@ -55,6 +62,11 @@ _img_info
 $QEMU_IO -c "open $TEST_IMG" -c "read 0 4k" 2>&1 | _filter_qemu_io | _filt=
er_testdir
 $QEMU_IO -c "open -o backing.driver=3D$IMGFMT $TEST_IMG" -c "read 0 4k" | =
_filter_qemu_io

+# Rebase the image, to show that omitting backing format triggers a warnin=
g,
+# but probing now lets us use the backing file.
+$QEMU_IMG rebase -u -b "$TEST_IMG.base" "$TEST_IMG"
+$QEMU_IO -c "open $TEST_IMG" -c "read 0 4k" 2>&1 | _filter_qemu_io | _filt=
er_testdir
+
 # success, all done
 echo '*** done'
 rm -f $seq.full
diff --git a/tests/qemu-iotests/114.out b/tests/qemu-iotests/114.out
index 67adef37a4f6..7c15dd53b0b5 100644
--- a/tests/qemu-iotests/114.out
+++ b/tests/qemu-iotests/114.out
@@ -1,5 +1,11 @@
 QA output created by 114
+qemu-img: warning: Deprecated use of backing file without explicit backing=
 format (detected format of raw)
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 backing_file=
=3DTEST_DIR/t.IMGFMT.orig backing_fmt=3Draw
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D67108864
+qemu-img: warning: Deprecated use of backing file without explicit backing=
 format
+qemu-img: warning: Deprecated use of backing file without explicit backing=
 format (detected format of IMGFMT)
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 backing_file=
=3DTEST_DIR/t.IMGFMT.base
+qemu-img: warning: Deprecated use of unopened backing file without explici=
t backing format, use of this image requires potentially unsafe format prob=
ing
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 backing_file=
=3DTEST_DIR/t.IMGFMT.base
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
@@ -11,4 +17,7 @@ qemu-io: can't open device TEST_DIR/t.qcow2: Could not op=
en backing file: Unknow
 no file open, try 'help open'
 read 4096/4096 bytes at offset 0
 4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+qemu-img: warning: Deprecated use of backing file without explicit backing=
 format, use of this image requires potentially unsafe format probing
+read 4096/4096 bytes at offset 0
+4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 *** done
diff --git a/tests/qemu-iotests/290.out b/tests/qemu-iotests/290.out
index 5b4ae3196d04..f80a5d982726 100644
--- a/tests/qemu-iotests/290.out
+++ b/tests/qemu-iotests/290.out
@@ -2,6 +2,7 @@ QA output created by 290

 =3D=3D qcow backed by qcow =3D=3D
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D134217728
+qemu-img: warning: Deprecated use of backing file without explicit backing=
 format (detected format of IMGFMT)
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 backing_file=
=3DTEST_DIR/t.IMGFMT.base
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
@@ -26,7 +27,9 @@ cluster_size: 512
 backing file: TEST_DIR/t.IMGFMT.base

 =3D=3D qcow backed by raw =3D=3D
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 backing_file=
=3DTEST_DIR/t.IMGFMT.base
+qemu-img: warning: Deprecated use of backing file without explicit backing=
 format (detected format of raw)
+qemu-img: TEST_DIR/t.IMGFMT: IMGFMT cannot store backing format; an explic=
it backing format of raw is unsafe
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 backing_file=
=3DTEST_DIR/t.IMGFMT.base backing_fmt=3Draw
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
 virtual size: 128 MiB (134217728 bytes)
--=20
2.26.0.rc2


