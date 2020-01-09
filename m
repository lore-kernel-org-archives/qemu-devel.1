Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F155EC282DD
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 19:16:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA1F0206ED
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 19:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Zdt/HR4W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA1F0206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipdIL-00054z-BX
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 14:16:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39312)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1ipdGC-0003WT-SH
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 14:14:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1ipdGB-0007Jj-GO
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 14:14:24 -0500
Received: from fanzine.igalia.com ([178.60.130.6]:58343)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1ipdG9-0006BB-G7; Thu, 09 Jan 2020 14:14:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=DhiaKh5w5AEQ3dxJRd+rhkGo4UZ0bhFyz01VRRPy1lk=; 
 b=Zdt/HR4WjCUD9VjfGQ7GcEirsC/4nwoejewd5T5Hb9T45YfHviBfkwmakAl99FhSOJ6MQ1Yqr6Xu+iMSaTX8j+yM7N629Iu7BadBVdv6PDRiwmd8Rs4+u3EIvteCHwEiLSECyYLNOYmztWk4y3ZZZ2OMU4tyaeYZxtSGPRuTiGChdjt3UU8ZNkyeHXXx4rXWjZpaA8wnLHpIZmGv47Yh7j/r7mfNHmwaSSAV7T1VbTnAIdjk/sS4F+g5XeolDTOopVxNgoMaKxgaHQv21ukfe7eIRc89bmA53CHI8+vptbhUCxKPD3IIET00VSto4uJ069C9oS7cFJ+DbJkqd3Ee9A==;
Received: from [213.99.255.143] (helo=perseus.local)
 by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1ipdFp-0006Mi-Q1; Thu, 09 Jan 2020 20:14:02 +0100
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1ipdF0-0005R0-L2; Thu, 09 Jan 2020 20:13:10 +0100
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/4] qcow2: Require that the virtual size is a multiple of
 the sector size
Date: Thu,  9 Jan 2020 20:12:59 +0100
Message-Id: <6a1cfcbb533b487bac96e1d2282ebf210954d27a.1578596897.git.berto@igalia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1578596897.git.berto@igalia.com>
References: <cover.1578596897.git.berto@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
 timestamps) [generic] [fuzzy]
X-Received-From: 178.60.130.6
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Nir Soffer <nsoffer@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The qcow2 header specifies the virtual size of the image in bytes, but
BlockDriverState stores it as a number of 512-byte sectors.

If the user tries to create an image with a size that is not a
multiple of the sector size then this is fixed on creation by
silently rounding the image size up (see commit c2eb918e32).
qcow2_co_truncate() is more strict and returns an error instead.

However when an image is opened the virtual size is rounded down,
which means that trying to access the last few advertised bytes will
result in an error. As seen above QEMU cannot create such images and
there's no good use case that would require us to try to handle them
so let's just treat them as unsupported.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2.c              | 7 +++++++
 docs/interop/qcow2.txt     | 3 ++-
 tests/qemu-iotests/080     | 8 ++++++++
 tests/qemu-iotests/080.out | 5 +++++
 4 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 7fbaac8457..87ca2832f0 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1326,6 +1326,13 @@ static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
         goto fail;
     }
 
+    if (!QEMU_IS_ALIGNED(header.size, BDRV_SECTOR_SIZE)) {
+        error_setg(errp, "Virtual size is not a multiple of %u",
+                   (unsigned) BDRV_SECTOR_SIZE);
+        ret = -EINVAL;
+        goto fail;
+    }
+
     if (header.header_length > sizeof(header)) {
         s->unknown_header_fields_size = header.header_length - sizeof(header);
         s->unknown_header_fields = g_malloc(s->unknown_header_fields_size);
diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
index af5711e533..891f5662d8 100644
--- a/docs/interop/qcow2.txt
+++ b/docs/interop/qcow2.txt
@@ -40,7 +40,8 @@ The first cluster of a qcow2 image contains the file header:
                     with larger cluster sizes.
 
          24 - 31:   size
-                    Virtual disk size in bytes.
+                    Virtual disk size in bytes. qemu can only handle
+                    sizes that are a multiple of 512 bytes.
 
                     Note: qemu has an implementation limit of 32 MB as
                     the maximum L1 table size.  With a 2 MB cluster
diff --git a/tests/qemu-iotests/080 b/tests/qemu-iotests/080
index 4bcb5021e8..6f136d616f 100755
--- a/tests/qemu-iotests/080
+++ b/tests/qemu-iotests/080
@@ -48,6 +48,7 @@ header_size=104
 
 offset_backing_file_offset=8
 offset_backing_file_size=16
+offset_virtual_size=24
 offset_l1_size=36
 offset_l1_table_offset=40
 offset_refcount_table_offset=48
@@ -197,6 +198,13 @@ poke_file "$TEST_IMG" "$offset_snap1_l1_size" "\x10\x00\x00\x00"
 { $QEMU_IMG snapshot -d test $TEST_IMG; } 2>&1 | _filter_testdir
 _check_test_img
 
+echo
+echo "== Image size not a multiple of the sector size =="
+_make_test_img 64k
+echo "Modifying virtual size to 65535 bytes"
+poke_file "$TEST_IMG" "$offset_virtual_size" "\x00\x00\x00\x00\x00\x00\xff\xff"
+{ $QEMU_IMG info $TEST_IMG; } 2>&1 | _filter_testdir | _filter_imgfmt
+
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/080.out b/tests/qemu-iotests/080.out
index 45ab01db8e..aadc817339 100644
--- a/tests/qemu-iotests/080.out
+++ b/tests/qemu-iotests/080.out
@@ -104,4 +104,9 @@ Data may be corrupted, or further writes to the image may corrupt it.
 
 3 leaked clusters were found on the image.
 This means waste of disk space, but no harm to data.
+
+== Image size not a multiple of the sector size ==
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=65536
+Modifying virtual size to 65535 bytes
+qemu-img: Could not open 'TEST_DIR/t.IMGFMT': Virtual size is not a multiple of 512
 *** done
-- 
2.20.1


