Return-Path: <SRS0=sqIQ=4K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E40C35666
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Feb 2020 11:25:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A20C4206EF
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Feb 2020 11:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JOOrAbCr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A20C4206EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5Su4-0005q9-RL
	for qemu-devel@archiver.kernel.org; Sat, 22 Feb 2020 06:25:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54659)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j5St5-0004Sl-Jc
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 06:24:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j5St4-00064P-2J
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 06:23:59 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23196
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j5St3-000647-Um
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 06:23:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582370637;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vCrcHhLOyzF/iIqGIrHe59+p7hnPHHv1cJ4iPcEuHh8=;
 b=JOOrAbCrNYSP+OuN15RohsKfZQqzyZEZSd1UwdHh95ZWGmMhBilj91t0S2HSPemsyVeK4z
 y+rzDbjFMykQcRCFuSFZRQnJmrwWipiuB16GyKindVUhwsKwEoW2E3xEMYUDcRJBXY1RjM
 tpIAH4tXL3YeI8HChwspEy5hvVq4TvM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-dzsRSBz0O_mtymBWl5L6bA-1; Sat, 22 Feb 2020 06:23:51 -0500
X-MC-Unique: dzsRSBz0O_mtymBWl5L6bA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8D9BC1005510;
 Sat, 22 Feb 2020 11:23:50 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-90.phx2.redhat.com [10.3.116.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0803484BCC;
 Sat, 22 Feb 2020 11:23:49 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/3] qemu-img: Deprecate use of -b without -F
Date: Sat, 22 Feb 2020 05:23:41 -0600
Message-Id: <20200222112341.4170045-4-eblake@redhat.com>
In-Reply-To: <20200222112341.4170045-1-eblake@redhat.com>
References: <20200222112341.4170045-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: libvir-list@redhat.com, Kevin Wolf <kwolf@redhat.com>, pkrempa@redhat.com,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Creating an image that requires format probing of the backing image is
inherently unsafe (we've had several CVEs over the years based on
probes leaking information to the guest on a subsequent boot).  If our
probing algorithm ever changes, or if other tools like libvirt
determine a different probe result than we do, then subsequent use of
that backing file under a different format will present corrupted data
to the guest.  Start a deprecation clock so that future qemu-img can
refuse to create unsafe backing chains that would rely on probing.

However, there is one time where probing is safe: when we first create
an image, no guest has yet used the new image, so as long as we record
what we probed, all future uses of the image will see the same data -
so the code now records the probe results as if the user had passed
-F.  When this happens, it is unconditionally safe to record a probe
of 'raw', but any other probe is still worth warning the user in case
our probe differed from their expectations.  Similarly, if the backing
file name uses the json: psuedo-protocol, the backing name includes
the format.

iotest 114 specifically wants to create an unsafe image for later
amendment rather than defaulting to our new default of recording a
probed format, so it needs an update.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block.c                    | 17 ++++++++++++++++-
 qemu-deprecated.texi       | 12 ++++++++++++
 qemu-img.c                 |  8 +++++++-
 tests/qemu-iotests/114     |  4 ++--
 tests/qemu-iotests/114.out |  1 +
 5 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/block.c b/block.c
index 695decbfd7b7..6595683ac52a 100644
--- a/block.c
+++ b/block.c
@@ -6013,6 +6013,15 @@ void bdrv_img_create(const char *filename, const cha=
r *fmt,
                               "Could not open backing image to determine s=
ize.\n");
             goto out;
         } else {
+            if (!backing_fmt && !strstart(backing_file, "json:", NULL)) {
+                backing_fmt =3D bs->drv->format_name;
+                qemu_opt_set(opts, BLOCK_OPT_BACKING_FMT, backing_fmt, NUL=
L);
+                if (bs->drv !=3D &bdrv_raw) {
+                    warn_report("Deprecated use of non-raw backing file "
+                                "without explicit backing format, using "
+                                "detected format of %s", backing_fmt);
+                }
+            }
             if (size =3D=3D -1) {
                 /* Opened BS, have no size */
                 size =3D bdrv_getlength(bs);
@@ -6026,7 +6035,13 @@ void bdrv_img_create(const char *filename, const cha=
r *fmt,
             }
             bdrv_unref(bs);
         }
-    } /* (backing_file && !(flags & BDRV_O_NO_BACKING)) */
+        /* (backing_file && !(flags & BDRV_O_NO_BACKING)) */
+    } else if (backing_file && !backing_fmt &&
+               !strstart(backing_file, "json:", NULL)) {
+        warn_report("Deprecated use of unopened backing file without "
+                    "explicit backing format, use of this image requires "
+                    "potentially unsafe format probing");
+    }

     if (size =3D=3D -1) {
         error_setg(errp, "Image creation needs a size parameter");
diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index 0671c26c806e..9228bcecd138 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -318,6 +318,18 @@ The above, converted to the current supported format:

 @section Related binaries

+@subsection qemu-img backing file without format (since 5.0.0)
+
+The use of @command{qemu-img create} or @command{qemu-img rebase} to
+modify an image that depends on a backing file now recommends that an
+explicit backing format be provided.  This is for safety - if qemu
+probes a different format than what you thought, the data presented to
+the guest will be corrupt; similarly, presenting a raw image to a
+guest allows the guest a potential security exploit if a future probe
+sees non-raw.  To avoid warning messages, or even future refusal to
+create an unsafe image, you must pass @option{-F} to specify the
+intended backing format.
+
 @subsection qemu-img convert -n -o (since 4.2.0)

 All options specified in @option{-o} are image creation options, so
diff --git a/qemu-img.c b/qemu-img.c
index b9375427404d..e75ec1bdb555 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3637,7 +3637,13 @@ static int img_rebase(int argc, char **argv)
      * doesn't change when we switch the backing file.
      */
     if (out_baseimg && *out_baseimg) {
-        ret =3D bdrv_change_backing_file(bs, out_baseimg, out_basefmt, fal=
se);
+        if (blk_new_backing && !out_basefmt) {
+            out_basefmt =3D blk_bs(blk_new_backing)->drv->format_name;
+            warn_report("Deprecated use of backing file "
+                        "without explicit backing format, using "
+                        "detected format of %s", out_basefmt);
+        }
+        ret =3D bdrv_change_backing_file(bs, out_baseimg, out_basefmt, tru=
e);
     } else {
         ret =3D bdrv_change_backing_file(bs, NULL, NULL, false);
     }
diff --git a/tests/qemu-iotests/114 b/tests/qemu-iotests/114
index 26104fff6c67..727e06e283a5 100755
--- a/tests/qemu-iotests/114
+++ b/tests/qemu-iotests/114
@@ -42,9 +42,9 @@ _unsupported_proto vxhs
 # qcow2.py does not work too well with external data files
 _unsupported_imgopts data_file

-
+# Intentionally specify backing file without backing format
 TEST_IMG=3D"$TEST_IMG.base" _make_test_img 64M
-_make_test_img -b "$TEST_IMG.base" 64M
+_make_test_img -u -b "$TEST_IMG.base" 64M

 # Set an invalid backing file format
 $PYTHON qcow2.py "$TEST_IMG" add-header-ext 0xE2792ACA "foo"
diff --git a/tests/qemu-iotests/114.out b/tests/qemu-iotests/114.out
index 67adef37a4f6..81d5a8e0ad03 100644
--- a/tests/qemu-iotests/114.out
+++ b/tests/qemu-iotests/114.out
@@ -1,5 +1,6 @@
 QA output created by 114
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D67108864
+qemu-img: warning: Deprecated use of unopened backing file without explici=
t backing format, use of this image requires potentially unsafe format prob=
ing
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 backing_file=
=3DTEST_DIR/t.IMGFMT.base
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
--=20
2.24.1


