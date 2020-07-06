Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2294BC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 20:43:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E014F20663
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 20:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="htj+Zcfz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E014F20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsXxT-0000Cn-6O
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 16:43:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52622)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jsXuT-00038P-9z
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 16:40:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55154
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jsXuQ-0002VF-6H
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 16:40:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594068013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lJvFO5Pb/vWMhSFo8+5u9ofTXO9NYGyp5FgW59rhl2k=;
 b=htj+Zcfzm/tIAY6JxnxLWvcNtCutPfALMoPcjG+0U2N1hesPnsISBKYg84nsKCvfTdkyJX
 U1dGiMSsNBDA+byE4L6IDEdRprQr3mWqRkF1hT+HVq2vzSh+NUGhlIBmEnY3t+pk2BWfuX
 gC3GYtAETYS0rIrPLDQIdDfu/YSmeMI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-SVhZTrjxOTyjZpVIy4Awkg-1; Mon, 06 Jul 2020 16:40:09 -0400
X-MC-Unique: SVhZTrjxOTyjZpVIy4Awkg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6108E8015F5;
 Mon,  6 Jul 2020 20:40:08 +0000 (UTC)
Received: from blue.redhat.com (ovpn-113-97.phx2.redhat.com [10.3.113.97])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 15B617B400;
 Mon,  6 Jul 2020 20:40:07 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 01/10] qemu-img: Flush stdout before before potential
 stderr messages
Date: Mon,  6 Jul 2020 15:39:45 -0500
Message-Id: <20200706203954.341758-2-eblake@redhat.com>
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
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 01:22:37
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

During 'qemu-img create ... 2>&1', if --quiet is not in force, we can
end up with buffered I/O in stdout that was produced before failure,
but which appears in output after failure.  This is confusing; the fix
is to flush stdout prior to attempting anything that might produce an
error message.  Several iotests demonstrate the resulting ordering
change now that the merged outputs now reflect chronology.  (An even
better fix would be to avoid printf from within block.c altogether,
but that's much more invasive...)

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block.c                    | 1 +
 tests/qemu-iotests/049.out | 8 ++++----
 tests/qemu-iotests/054.out | 2 +-
 tests/qemu-iotests/079.out | 2 +-
 tests/qemu-iotests/112.out | 4 ++--
 tests/qemu-iotests/259.out | 2 +-
 6 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/block.c b/block.c
index 6dbcb7e083ea..a568196ba250 100644
--- a/block.c
+++ b/block.c
@@ -6186,6 +6186,7 @@ void bdrv_img_create(const char *filename, const char *fmt,
         printf("Formatting '%s', fmt=%s ", filename, fmt);
         qemu_opts_print(opts, " ");
         puts("");
+        fflush(stdout);
     }

     ret = bdrv_create(drv, filename, opts, &local_err);
diff --git a/tests/qemu-iotests/049.out b/tests/qemu-iotests/049.out
index c54ae21b868a..22f395246b37 100644
--- a/tests/qemu-iotests/049.out
+++ b/tests/qemu-iotests/049.out
@@ -167,12 +167,12 @@ qemu-img create -f qcow2 -o compat=1.1 TEST_DIR/t.qcow2 64M
 Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 compat=1.1 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib

 qemu-img create -f qcow2 -o compat=0.42 TEST_DIR/t.qcow2 64M
-qemu-img: TEST_DIR/t.qcow2: Invalid parameter '0.42'
 Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 compat=0.42 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+qemu-img: TEST_DIR/t.qcow2: Invalid parameter '0.42'

 qemu-img create -f qcow2 -o compat=foobar TEST_DIR/t.qcow2 64M
-qemu-img: TEST_DIR/t.qcow2: Invalid parameter 'foobar'
 Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 compat=foobar cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+qemu-img: TEST_DIR/t.qcow2: Invalid parameter 'foobar'

 == Check preallocation option ==

@@ -183,8 +183,8 @@ qemu-img create -f qcow2 -o preallocation=metadata TEST_DIR/t.qcow2 64M
 Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=65536 preallocation=metadata lazy_refcounts=off refcount_bits=16 compression_type=zlib

 qemu-img create -f qcow2 -o preallocation=1234 TEST_DIR/t.qcow2 64M
-qemu-img: TEST_DIR/t.qcow2: Invalid parameter '1234'
 Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=65536 preallocation=1234 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+qemu-img: TEST_DIR/t.qcow2: Invalid parameter '1234'

 == Check encryption option ==

@@ -206,7 +206,7 @@ qemu-img create -f qcow2 -o compat=0.10,lazy_refcounts=off TEST_DIR/t.qcow2 64M
 Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 compat=0.10 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib

 qemu-img create -f qcow2 -o compat=0.10,lazy_refcounts=on TEST_DIR/t.qcow2 64M
-qemu-img: TEST_DIR/t.qcow2: Lazy refcounts only supported with compatibility level 1.1 and above (use version=v3 or greater)
 Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 compat=0.10 cluster_size=65536 lazy_refcounts=on refcount_bits=16 compression_type=zlib
+qemu-img: TEST_DIR/t.qcow2: Lazy refcounts only supported with compatibility level 1.1 and above (use version=v3 or greater)

 *** done
diff --git a/tests/qemu-iotests/054.out b/tests/qemu-iotests/054.out
index e6ec430edd47..71f18bb98760 100644
--- a/tests/qemu-iotests/054.out
+++ b/tests/qemu-iotests/054.out
@@ -1,8 +1,8 @@
 QA output created by 054

 creating too large image (1 EB)
-qemu-img: TEST_DIR/t.IMGFMT: The image size is too large for file format 'IMGFMT' (try using a larger cluster size)
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1152921504606846976
+qemu-img: TEST_DIR/t.IMGFMT: The image size is too large for file format 'IMGFMT' (try using a larger cluster size)

 creating too large image (1 EB) using qcow2.py
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=4294967296
diff --git a/tests/qemu-iotests/079.out b/tests/qemu-iotests/079.out
index aab922fb369b..f65a9ca84fea 100644
--- a/tests/qemu-iotests/079.out
+++ b/tests/qemu-iotests/079.out
@@ -9,6 +9,6 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=4294967296 preallocation=metadat
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=4294967296 preallocation=metadata
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=4294967296 preallocation=metadata
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=4294967296 preallocation=metadata
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=4294967296 preallocation=metadata
 qemu-img: TEST_DIR/t.IMGFMT: Cluster size must be a power of two between 512 and 2048k
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=4294967296 preallocation=metadata
 *** done
diff --git a/tests/qemu-iotests/112.out b/tests/qemu-iotests/112.out
index ae0318cabea6..5e77e38a7a13 100644
--- a/tests/qemu-iotests/112.out
+++ b/tests/qemu-iotests/112.out
@@ -2,7 +2,6 @@ QA output created by 112

 === refcount_bits limits ===

-qemu-img: TEST_DIR/t.IMGFMT: Refcount width must be a power of two and may not exceed 64 bits
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 qemu-img: TEST_DIR/t.IMGFMT: Refcount width must be a power of two and may not exceed 64 bits
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 refcount_bits=-1
@@ -10,6 +9,7 @@ qemu-img: TEST_DIR/t.IMGFMT: Refcount width must be a power of two and may not e
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 qemu-img: TEST_DIR/t.IMGFMT: Refcount width must be a power of two and may not exceed 64 bits
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
+qemu-img: TEST_DIR/t.IMGFMT: Refcount width must be a power of two and may not exceed 64 bits
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 refcount bits: 1
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
@@ -21,10 +21,10 @@ refcount bits: 16

 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 refcount bits: 16
-qemu-img: TEST_DIR/t.IMGFMT: Different refcount widths than 16 bits require compatibility level 1.1 or above (use version=v3 or greater)
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 qemu-img: TEST_DIR/t.IMGFMT: Different refcount widths than 16 bits require compatibility level 1.1 or above (use version=v3 or greater)
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
+qemu-img: TEST_DIR/t.IMGFMT: Different refcount widths than 16 bits require compatibility level 1.1 or above (use version=v3 or greater)

 === Snapshot limit on refcount_bits=1 ===

diff --git a/tests/qemu-iotests/259.out b/tests/qemu-iotests/259.out
index ffed19c2a0af..e27b9ff38d75 100644
--- a/tests/qemu-iotests/259.out
+++ b/tests/qemu-iotests/259.out
@@ -9,6 +9,6 @@ virtual size: 64 MiB (67108864 bytes)
 disk size: unavailable

 --- Testing creation for which the node would need to grow ---
-qemu-img: TEST_DIR/t.IMGFMT: Could not resize image: Image format driver does not support resize
 Formatting 'TEST_DIR/t.IMGFMT', fmt=qcow2 size=67108864 preallocation=metadata
+qemu-img: TEST_DIR/t.IMGFMT: Could not resize image: Image format driver does not support resize
 *** done
-- 
2.27.0


