Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F43C4BA24
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 02:41:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B39252467F
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 02:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dqHaIgYp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B39252467F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j797Y-0006ve-UG
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 21:41:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33705)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j795W-0005Tb-VM
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 21:39:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j795V-0001Ew-Fv
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 21:39:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48979
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j795V-0001C2-9n
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 21:39:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582771184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kdFbn075HIedi6OAGvkIWRsQc4pyllyl73woeuwOZIQ=;
 b=dqHaIgYpe2tg0hgqLDRF1t/ep9qoF6VoXbGollXHoiRxy08XTBYGOUXBtfJDZnOm77Kk3k
 RT621sd4lF9c60cfz+7k5e/2l8dOIsIPabRxnvjE+GtIfd1EvJDiI0ZMZnwhxD0LKSaawJ
 kRD7MMui8Ey9cVIakhu5kwQ6g32RVac=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-r56n7odcMgWOL7X-O7KAuw-1; Wed, 26 Feb 2020 21:39:39 -0500
X-MC-Unique: r56n7odcMgWOL7X-O7KAuw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 417AE1005512;
 Thu, 27 Feb 2020 02:39:38 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-57.phx2.redhat.com [10.3.116.57])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B18181CB;
 Thu, 27 Feb 2020 02:39:37 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/3] qemu-img: Deprecate use of -b without -F
Date: Wed, 26 Feb 2020 20:39:28 -0600
Message-Id: <20200227023928.1021959-4-eblake@redhat.com>
In-Reply-To: <20200227023928.1021959-1-eblake@redhat.com>
References: <20200227023928.1021959-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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

However, there is one time where probing is safe: if we probe raw,
then it is safe to record that implicitly in the image (but we still
warn, as it's better to teach the user to supply -F always than to
make them guess when it is safe).

iotest 114 specifically wants to create an unsafe image for later
amendment rather than defaulting to our new default of recording a
probed format, so it needs an update.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 qemu-deprecated.texi       | 15 +++++++++++++++
 block.c                    | 21 ++++++++++++++++++++-
 qemu-img.c                 |  8 +++++++-
 tests/qemu-iotests/114     |  4 ++--
 tests/qemu-iotests/114.out |  1 +
 5 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index 66eca3a1dede..f99b49addccc 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -309,6 +309,21 @@ The above, converted to the current supported format:

 @section Related binaries

+@subsection qemu-img backing file without format (since 5.0.0)
+
+The use of @command{qemu-img create}, @command{qemu-img rebase},
+@command{qemu-img convert}, or @command{qemu-img ament} to create or
+modify an image that depends on a backing file now recommends that an
+explicit backing format be provided.  This is for safety - if qemu
+probes a different format than what you thought, the data presented to
+the guest will be corrupt; similarly, presenting a raw image to a
+guest allows the guest a potential security exploit if a future probe
+sees non-raw.  To avoid warning messages, or even future refusal to
+create an unsafe image, you must pass @option{-o backing_fmt=3D} (or
+shorthand @option{-F}) to specify the intended backing format.  You
+may use @command{qemu-img rebase -u} to retroactively add a backing
+format to an existing image.
+
 @subsection qemu-img convert -n -o (since 4.2.0)

 All options specified in @option{-o} are image creation options, so
diff --git a/block.c b/block.c
index 10c2a34e7c00..9907cf1e3c78 100644
--- a/block.c
+++ b/block.c
@@ -6009,6 +6009,20 @@ void bdrv_img_create(const char *filename, const cha=
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
@@ -6022,7 +6036,12 @@ void bdrv_img_create(const char *filename, const cha=
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
2.25.1


