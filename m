Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A9FC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 10:42:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D4A0207FC
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 10:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N+2wvuQn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D4A0207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmETm-0002Le-Ap
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 06:42:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58322)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jmERd-0008FL-W7
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 06:40:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26442
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jmERb-0000w2-2i
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 06:40:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592563222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j4s80g9xP/gHFPG8l8zC2Sq3SL96+Ry0KRdDn9AR2nM=;
 b=N+2wvuQnvF1S/PNRfFwQZDuhky1/sHjb701i9wAXiE/4+nK5+YCyEPlhZV5TcCjA0OX+qo
 RLgti1Gfp9PVGf4ZPNNXR9zwqNYRhTIqqV9I9xUlVSvyqsPewF7yB4ECJ2y1S33oa2L1nQ
 r17XJfmejrgFvHIVbQa3k3bCwmN2gdA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-80-F7AWET8LMLCaLqeoIIXGZg-1; Fri, 19 Jun 2020 06:40:18 -0400
X-MC-Unique: F7AWET8LMLCaLqeoIIXGZg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0CA9F801503;
 Fri, 19 Jun 2020 10:40:17 +0000 (UTC)
Received: from localhost (ovpn-113-28.ams2.redhat.com [10.36.113.28])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A0D0660BE1;
 Fri, 19 Jun 2020 10:40:16 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 1/2] qcow2: Force preallocation with data-file-raw
Date: Fri, 19 Jun 2020 12:40:11 +0200
Message-Id: <20200619104012.235977-2-mreitz@redhat.com>
In-Reply-To: <20200619104012.235977-1-mreitz@redhat.com>
References: <20200619104012.235977-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 05:19:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Setting the qcow2 data-file-raw bit means that you can ignore the
qcow2 metadata when reading from the external data file.  It does not
mean that you have to ignore it, though.  Therefore, the data read must
be the same regardless of whether you interpret the metadata or whether
you ignore it, and thus the L1/L2 tables must all be present and give a
1:1 mapping.

This patch changes 244's output: First, the qcow2 file is larger right
after creation, because of metadata preallocation.  Second, the qemu-img
map output changes: Everything that was not explicitly discarded or
zeroed is now a data area.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.c              | 22 ++++++++++++++++++++++
 tests/qemu-iotests/244.out |  9 ++++-----
 2 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 0cd2e6757e..2a588d8091 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3460,6 +3460,28 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
         ret = -EINVAL;
         goto out;
     }
+    if (qcow2_opts->data_file_raw &&
+        qcow2_opts->preallocation == PREALLOC_MODE_OFF)
+    {
+        /*
+         * data-file-raw means that "the external data file can be
+         * read as a consistent standalone raw image without looking
+         * at the qcow2 metadata."  It does not say that the metadata
+         * must be ignored, though (and the qcow2 driver in fact does
+         * not ignore it), so the L1/L2 tables must be present and
+         * give a 1:1 mapping, so you get the same result regardless
+         * of whether you look at the metadata or whether you ignore
+         * it.
+         */
+        qcow2_opts->preallocation = PREALLOC_MODE_METADATA;
+
+        /*
+         * Cannot use preallocation with backing files, but giving a
+         * backing file when specifying data_file_raw is an error
+         * anyway.
+         */
+        assert(!qcow2_opts->has_backing_file);
+    }
 
     if (qcow2_opts->data_file) {
         if (version < 3) {
diff --git a/tests/qemu-iotests/244.out b/tests/qemu-iotests/244.out
index dbab7359a9..24f02363dd 100644
--- a/tests/qemu-iotests/244.out
+++ b/tests/qemu-iotests/244.out
@@ -83,7 +83,7 @@ qcow2 file size after I/O: 327680
 === Standalone image with external data file (valid raw) ===
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 data_file=TEST_DIR/t.IMGFMT.data data_file_raw=on
-qcow2 file size before I/O: 196616
+qcow2 file size before I/O: 327680
 
 wrote 4194304/4194304 bytes at offset 1048576
 4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -93,11 +93,10 @@ wrote 3145728/3145728 bytes at offset 3145728
 3 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 No errors were found on the image.
 
-[{ "start": 0, "length": 1048576, "depth": 0, "zero": true, "data": false},
-{ "start": 1048576, "length": 1048576, "depth": 0, "zero": false, "data": true, "offset": 1048576},
+[{ "start": 0, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": 0},
 { "start": 2097152, "length": 2097152, "depth": 0, "zero": true, "data": false},
-{ "start": 4194304, "length": 1048576, "depth": 0, "zero": true, "data": false, "offset": 4194304},
-{ "start": 5242880, "length": 61865984, "depth": 0, "zero": true, "data": false}]
+{ "start": 4194304, "length": 2097152, "depth": 0, "zero": true, "data": false, "offset": 4194304},
+{ "start": 6291456, "length": 60817408, "depth": 0, "zero": false, "data": true, "offset": 6291456}]
 
 read 1048576/1048576 bytes at offset 0
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-- 
2.26.2


