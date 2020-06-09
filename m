Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F06C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 20:58:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DFFE20734
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 20:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DbH9RubC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DFFE20734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jilKS-0002E2-Kp
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 16:58:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36414)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jilF0-0001qq-IJ
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 16:53:02 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46807
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jilEz-0005dZ-D5
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 16:53:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591735980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fp46CHSLKGKWkUBAgicrH6jIF36/amsY7o6T2XaaBiQ=;
 b=DbH9RubCndeXdinIHASKEsxCJ6WnhV+6Jl+S3uvGLjQkoDPQZdEVGPv+qTxyvu+43kcnsn
 AowhNxwzxi8r8AEZibkW2/Pu+U8RswvCpCtslruLb7hWX6kAOcNgV0g9S1Af5VosZ7Rtxg
 54jLubZJl9apVyLF5T9/ewNt6wTk3XA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-8uIUbHaCM3mSl36h7M9iFA-1; Tue, 09 Jun 2020 16:52:58 -0400
X-MC-Unique: 8uIUbHaCM3mSl36h7M9iFA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5597019200C1;
 Tue,  9 Jun 2020 20:52:57 +0000 (UTC)
Received: from blue.redhat.com (ovpn-113-22.phx2.redhat.com [10.3.113.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EA32A6116D;
 Tue,  9 Jun 2020 20:52:56 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 15/15] iotests: Fix 291 across more file systems
Date: Tue,  9 Jun 2020 15:52:45 -0500
Message-Id: <20200609205245.3548257-16-eblake@redhat.com>
In-Reply-To: <20200609205245.3548257-1-eblake@redhat.com>
References: <20200609205245.3548257-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 16:46:48
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Depending on the granularity of holes and amount of metadata consumed
by a file, the 'disk size:' number of 'qemu-img info' is not reliable.
Adjust our test to use a different set of filters to avoid spurious
failures.

Reported-by: Kevin Wolf <kwolf@redhat.com>
Fixes: cf2d1203dc
Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20200608195629.3299649-1-eblake@redhat.com>
Acked-by: Kevin Wolf <kwolf@redhat.com>
[eblake: fix merge conflict]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/291     | 4 ++--
 tests/qemu-iotests/291.out | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/qemu-iotests/291 b/tests/qemu-iotests/291
index e0cffc7cb119..404f8521f74a 100755
--- a/tests/qemu-iotests/291
+++ b/tests/qemu-iotests/291
@@ -79,7 +79,7 @@ echo

 # Only bitmaps from the active layer are copied
 $QEMU_IMG convert --bitmaps -O qcow2 "$TEST_IMG.orig" "$TEST_IMG"
-$QEMU_IMG info "$TEST_IMG" | _filter_img_info --format-specific
+_img_info --format-specific
 # But we can also merge in bitmaps from other layers.  This test is a bit
 # contrived to cover more code paths, in reality, you could merge directly
 # into b0 without going through tmp
@@ -89,7 +89,7 @@ $QEMU_IMG bitmap --add --merge b0 -b "$TEST_IMG.base" -F $IMGFMT \
 $QEMU_IMG bitmap --merge tmp -f $IMGFMT "$TEST_IMG" b0
 $QEMU_IMG bitmap --remove --image-opts \
     driver=$IMGFMT,file.driver=file,file.filename="$TEST_IMG" tmp
-$QEMU_IMG info "$TEST_IMG" | _filter_img_info --format-specific
+_img_info --format-specific
 echo "Check resulting qcow2 header extensions:"
 $PYTHON qcow2.py "$TEST_IMG" dump-header-exts

diff --git a/tests/qemu-iotests/291.out b/tests/qemu-iotests/291.out
index ccfcdc5e35ce..08bfaaaa6b7d 100644
--- a/tests/qemu-iotests/291.out
+++ b/tests/qemu-iotests/291.out
@@ -43,7 +43,7 @@ qemu-img: Format driver 'raw' does not support bitmaps
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
 virtual size: 10 MiB (10485760 bytes)
-disk size: 4.39 MiB
+cluster_size: 65536
 Format specific information:
     compat: 1.1
     compression type: zlib
@@ -63,7 +63,7 @@ Format specific information:
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
 virtual size: 10 MiB (10485760 bytes)
-disk size: 4.48 MiB
+cluster_size: 65536
 Format specific information:
     compat: 1.1
     compression type: zlib
-- 
2.27.0


