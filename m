Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C98ADC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 20:47:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 804B920663
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 20:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P8qVp3gE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 804B920663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsY1F-0005yc-Py
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 16:47:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52900)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jsXuj-0003h8-3i
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 16:40:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59592
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jsXug-0002jN-EX
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 16:40:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594068029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BxLYtjC4zk8oVli+ohS/V7D5FC/f31tbO+7sxdMg44g=;
 b=P8qVp3gEZTM/dxsf8pQCjelwVu0qOGXdjbuAkA+uM2eDAEMcOjDt7AaIZIx4n724DgLPhj
 ctESipKuM01QH/RZ/nq3RLbz9ukqb8dfobmhydsfWAvLLippEdH0p2LGeI/Q31k4KkSQHC
 6SPMCvBa8s2KM14oudbnJ1M7ulMgtmE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-zFYJxkXUNQ2KK-xtypEPFQ-1; Mon, 06 Jul 2020 16:40:27 -0400
X-MC-Unique: zFYJxkXUNQ2KK-xtypEPFQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F04E739340;
 Mon,  6 Jul 2020 20:40:26 +0000 (UTC)
Received: from blue.redhat.com (ovpn-113-97.phx2.redhat.com [10.3.113.97])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5DFE97B400;
 Mon,  6 Jul 2020 20:40:26 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 10/10] qemu-img: Deprecate use of -b without -F
Date: Mon,  6 Jul 2020 15:39:54 -0500
Message-Id: <20200706203954.341758-11-eblake@redhat.com>
In-Reply-To: <20200706203954.341758-1-eblake@redhat.com>
References: <20200706203954.341758-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 15:29:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
potentially unsafe (we've had several CVEs over the years based on
probes leaking information to the guest on a subsequent boot, although
these days tools like libvirt are aware of the issue enough to prevent
the worst effects).  For example, if our probing algorithm ever
changes, or if other tools like libvirt determine a different probe
result than we do, then subsequent use of that backing file under a
different format will present corrupted data to the guest.
Fortunately, the worst effects occur only when the backing image is
originally raw, and we at least prevent commit into a probed raw
backing file that would change its probed type.

Still, it is worth starting a deprecation clock so that future
qemu-img can refuse to create backing chains that would rely on
probing, to encourage clients to avoid unsafe practices.  Most
warnings are intentionally emitted from bdrv_img_create() in the block
layer, but qemu-img convert uses bdrv_create() which cannot emit its
own warning without causing spurious warnings on other code paths.  In
the end, all command-line image creation or backing file rewriting now
performs a check.

Furthermore, if we probe a backing file as non-raw, then it is safe to
explicitly record that result (rather than relying on future probes);
only where we probe a raw image do we care about further warnings to
the user when using such an image (for example, commits into a
probed-raw backing file are prevented), to help them improve their
tooling.  But whether or not we make the probe results explicit, we
still warn the user to remind them to upgrade their workflow to supply
-F always.

iotest 114 specifically wants to create an unsafe image for later
amendment rather than defaulting to our new default of recording a
probed format, so it needs an update.  While touching it, expand it to
cover all of the various warnings enabled by this patch.  iotest 293
also shows a change to qcow messages.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 docs/system/deprecated.rst | 20 ++++++++++++++++++++
 block.c                    | 27 ++++++++++++++++++++++++++-
 qemu-img.c                 |  9 ++++++++-
 tests/qemu-iotests/114     | 12 ++++++++++++
 tests/qemu-iotests/114.out |  9 +++++++++
 tests/qemu-iotests/293.out |  4 +++-
 6 files changed, 78 insertions(+), 3 deletions(-)

diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
index b312ad27aa04..ca994e3ef53a 100644
--- a/docs/system/deprecated.rst
+++ b/docs/system/deprecated.rst
@@ -430,6 +430,26 @@ image).  Rather, any changes to the backing chain should be performed
 with ``qemu-img rebase -u`` either before or after the remaining
 changes being performed by amend, as appropriate.

+qemu-img backing file without format (since 5.1)
+''''''''''''''''''''''''''''''''''''''''''''''''
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
+unsafe image, you must pass ``-o backing_fmt=`` (or the shorthand
+``-F`` during create) to specify the intended backing format.  You may
+use ``qemu-img rebase -u`` to retroactively add a backing format to an
+existing image.  However, be aware that there are already potential
+security risks to blindly using ``qemu-img info`` to probe the format
+of an untrusted backing image, when deciding what format to add into
+an existing image.
+
 Backwards compatibility
 -----------------------

diff --git a/block.c b/block.c
index 5cfd10f6b45e..aad3b3635e6b 100644
--- a/block.c
+++ b/block.c
@@ -6161,6 +6161,26 @@ void bdrv_img_create(const char *filename, const char *fmt,
             error_append_hint(&local_err, "Could not open backing image.\n");
             goto out;
         } else {
+            if (!backing_fmt) {
+                warn_report("Deprecated use of backing file without explicit "
+                            "backing format (detected format of %s)",
+                            bs->drv->format_name);
+                if (bs->drv != &bdrv_raw) {
+                    /*
+                     * A probe of raw deserves the most attention:
+                     * leaving the backing format out of the image
+                     * will ensure bs->probed is set (ensuring we
+                     * don't accidentally commit into the backing
+                     * file), and allow more spots to warn the users
+                     * to fix their toolchain when opening this image
+                     * later.  For other images, we can safely record
+                     * the format that we probed.
+                     */
+                    backing_fmt = bs->drv->format_name;
+                    qemu_opt_set(opts, BLOCK_OPT_BACKING_FMT, backing_fmt,
+                                 NULL);
+                }
+            }
             if (size == -1) {
                 /* Opened BS, have no size */
                 size = bdrv_getlength(bs);
@@ -6174,7 +6194,12 @@ void bdrv_img_create(const char *filename, const char *fmt,
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

     if (size == -1) {
         error_setg(errp, "Image creation needs a size parameter");
diff --git a/qemu-img.c b/qemu-img.c
index 71a919d73676..a1a09aa51535 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -2523,6 +2523,13 @@ static int img_convert(int argc, char **argv)
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
         bool encryption =
@@ -3807,7 +3814,7 @@ static int img_rebase(int argc, char **argv)
      * doesn't change when we switch the backing file.
      */
     if (out_baseimg && *out_baseimg) {
-        ret = bdrv_change_backing_file(bs, out_baseimg, out_basefmt, false);
+        ret = bdrv_change_backing_file(bs, out_baseimg, out_basefmt, true);
     } else {
         ret = bdrv_change_backing_file(bs, NULL, NULL, false);
     }
diff --git a/tests/qemu-iotests/114 b/tests/qemu-iotests/114
index 26104fff6c67..143683381334 100755
--- a/tests/qemu-iotests/114
+++ b/tests/qemu-iotests/114
@@ -42,9 +42,16 @@ _unsupported_proto vxhs
 # qcow2.py does not work too well with external data files
 _unsupported_imgopts data_file

+# Intentionally specify backing file without backing format; demonstrate
+# the difference in warning messages when backing file could be probed.
+# Note that only a non-raw probe result will affect the resulting image.
+truncate --size=64M "$TEST_IMG.orig"
+_make_test_img -b "$TEST_IMG.orig" 64M

 TEST_IMG="$TEST_IMG.base" _make_test_img 64M
+$QEMU_IMG convert -O qcow2 -B "$TEST_IMG.orig" "$TEST_IMG.orig" "$TEST_IMG"
 _make_test_img -b "$TEST_IMG.base" 64M
+_make_test_img -u -b "$TEST_IMG.base" 64M

 # Set an invalid backing file format
 $PYTHON qcow2.py "$TEST_IMG" add-header-ext 0xE2792ACA "foo"
@@ -55,6 +62,11 @@ _img_info
 $QEMU_IO -c "open $TEST_IMG" -c "read 0 4k" 2>&1 | _filter_qemu_io | _filter_testdir
 $QEMU_IO -c "open -o backing.driver=$IMGFMT $TEST_IMG" -c "read 0 4k" | _filter_qemu_io

+# Rebase the image, to show that omitting backing format triggers a warning,
+# but probing now lets us use the backing file.
+$QEMU_IMG rebase -u -b "$TEST_IMG.base" "$TEST_IMG"
+$QEMU_IO -c "open $TEST_IMG" -c "read 0 4k" 2>&1 | _filter_qemu_io | _filter_testdir
+
 # success, all done
 echo '*** done'
 rm -f $seq.full
diff --git a/tests/qemu-iotests/114.out b/tests/qemu-iotests/114.out
index 67adef37a4f6..0a37d20c82a9 100644
--- a/tests/qemu-iotests/114.out
+++ b/tests/qemu-iotests/114.out
@@ -1,5 +1,11 @@
 QA output created by 114
+qemu-img: warning: Deprecated use of backing file without explicit backing format (detected format of raw)
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.orig
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=67108864
+qemu-img: warning: Deprecated use of backing file without explicit backing format
+qemu-img: warning: Deprecated use of backing file without explicit backing format (detected format of IMGFMT)
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
+qemu-img: warning: Deprecated use of unopened backing file without explicit backing format, use of this image requires potentially unsafe format probing
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.base
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
@@ -11,4 +17,7 @@ qemu-io: can't open device TEST_DIR/t.qcow2: Could not open backing file: Unknow
 no file open, try 'help open'
 read 4096/4096 bytes at offset 0
 4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+qemu-img: warning: Deprecated use of backing file without explicit backing format, use of this image requires potentially unsafe format probing
+read 4096/4096 bytes at offset 0
+4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 *** done
diff --git a/tests/qemu-iotests/293.out b/tests/qemu-iotests/293.out
index 3c612903f862..8bed89a67fbb 100644
--- a/tests/qemu-iotests/293.out
+++ b/tests/qemu-iotests/293.out
@@ -2,7 +2,8 @@ QA output created by 293

 == qcow backed by qcow ==
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=33554432
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=33554432 backing_file=TEST_DIR/t.IMGFMT.base
+qemu-img: warning: Deprecated use of backing file without explicit backing format (detected format of IMGFMT)
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=33554432 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
 virtual size: 32 MiB (33554432 bytes)
@@ -35,6 +36,7 @@ cluster_size: 512
 backing file: TEST_DIR/t.IMGFMT.base

 == qcow backed by raw ==
+qemu-img: warning: Deprecated use of backing file without explicit backing format (detected format of raw)
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=33554432 backing_file=TEST_DIR/t.IMGFMT.base
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
-- 
2.27.0


