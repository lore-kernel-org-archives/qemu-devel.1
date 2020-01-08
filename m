Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54BFBC33CA1
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 17:51:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29DB02067D
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 17:51:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="fM/DwPbW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29DB02067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipFUg-0006qo-RD
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 12:51:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48341)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1ipFTM-0005Si-11
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 12:50:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1ipFTK-000165-OV
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 12:50:23 -0500
Received: from fanzine.igalia.com ([178.60.130.6]:55163)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1ipFTK-0000YS-2Y; Wed, 08 Jan 2020 12:50:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=WHZ4UJ9Q3KqOEAfitcpL3sAcFDRvjYEeqxAs3TRiPiU=; 
 b=fM/DwPbWsNkZVRSwyNvyEOcVzh0NyoORD9BOH7Jc0EFTYEXnEZPznd62tonmB2Juci95IM0+fqi2EmPuzK5MvEaiKGUTnorkRkEEOlPMHf8Yei0Xv1RnAsNJipkJN9rcqlq33d0i6URQlyMVsybfcRLUenmiDrKMrMyqd3h5yAc957xFXC+eD1gtGx39m4nPvk1ah8c4TJP1cmmA07AuYASe6e9jdGDpQuPSXVJvgPCWvsp76T381UIm7bAkWdjxdDTVBNWTfa+HJcRvM3txDzIlUtM9NenvvCzVGvda8B7LonNoq/ueIu2VNSK3PRUV45SYUz05iMw/Yu2aKaEbjg==;
Received: from [213.99.255.143] (helo=perseus.local)
 by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1ipFT1-0001HP-PO; Wed, 08 Jan 2020 18:50:03 +0100
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1ipFSD-0000DZ-Aw; Wed, 08 Jan 2020 18:49:13 +0100
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/3] qcow2: Require that the virtual size is a multiple of the
 sector size
Date: Wed,  8 Jan 2020 18:49:08 +0100
Message-Id: <4a27dc359f8211700662949bdecdd992f8918c12.1578505678.git.berto@igalia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1578505678.git.berto@igalia.com>
References: <cover.1578505678.git.berto@igalia.com>
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
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
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
 tests/qemu-iotests/080     | 7 +++++++
 tests/qemu-iotests/080.out | 4 ++++
 4 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 7fbaac8457..92474849db 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1326,6 +1326,13 @@ static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
         goto fail;
     }
 
+    if (header.size % BDRV_SECTOR_SIZE) {
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
index 4bcb5021e8..2563b2c052 100755
--- a/tests/qemu-iotests/080
+++ b/tests/qemu-iotests/080
@@ -48,6 +48,7 @@ header_size=104
 
 offset_backing_file_offset=8
 offset_backing_file_size=16
+offset_virtual_size=24
 offset_l1_size=36
 offset_l1_table_offset=40
 offset_refcount_table_offset=48
@@ -197,6 +198,12 @@ poke_file "$TEST_IMG" "$offset_snap1_l1_size" "\x10\x00\x00\x00"
 { $QEMU_IMG snapshot -d test $TEST_IMG; } 2>&1 | _filter_testdir
 _check_test_img
 
+echo
+echo "== Image size not a multiple of the sector size =="
+_make_test_img 64k
+poke_file "$TEST_IMG" "$offset_virtual_size" "\x00\x00\x00\x00\x00\x00\xff\xff"
+{ $QEMU_IO -c "write 65530 1" $TEST_IMG; } 2>&1 | _filter_qemu_io | _filter_testdir
+
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/080.out b/tests/qemu-iotests/080.out
index 45ab01db8e..e1c969e2ba 100644
--- a/tests/qemu-iotests/080.out
+++ b/tests/qemu-iotests/080.out
@@ -104,4 +104,8 @@ Data may be corrupted, or further writes to the image may corrupt it.
 
 3 leaked clusters were found on the image.
 This means waste of disk space, but no harm to data.
+
+== Image size not a multiple of the sector size ==
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=65536
+qemu-io: can't open device TEST_DIR/t.qcow2: Virtual size is not a multiple of 512
 *** done
-- 
2.20.1


