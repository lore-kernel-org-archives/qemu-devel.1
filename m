Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B5E3C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 11:05:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A01120756
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 11:05:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pt/i637D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A01120756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKg7B-0001WP-HC
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 07:05:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33396)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kKftE-00025J-L2
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 06:51:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49198)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kKftA-0000py-Eo
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 06:51:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600771871;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vT4MYAgtIArZ0D5OmwTyZcngHUN5T9zEu9FtMyIEaOM=;
 b=Pt/i637Dyl1tXhesirIV2ILoIsx3cqrNs8TcZrG3igxHyjRXtIFgo6q+wGNygMZjrnx/5n
 xhWRQMkEMIMg/8wJeRBLfrMJJHdCSd2Vj4qHjGQG62DGAy7v3sIqWyTuUKWFR1VaRgNf5M
 GCtRt4NGRMBvg0lKwuTFOYLlyKV4uu4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-YetIuk_IN8m1E0HETSZ-aQ-1; Tue, 22 Sep 2020 06:51:08 -0400
X-MC-Unique: YetIuk_IN8m1E0HETSZ-aQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7448B8030AC;
 Tue, 22 Sep 2020 10:51:07 +0000 (UTC)
Received: from localhost (ovpn-114-26.ams2.redhat.com [10.36.114.26])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7354D1002D41;
 Tue, 22 Sep 2020 10:51:03 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 19/20] iotests: Enable fuse for many tests
Date: Tue, 22 Sep 2020 12:49:31 +0200
Message-Id: <20200922104932.46384-20-mreitz@redhat.com>
In-Reply-To: <20200922104932.46384-1-mreitz@redhat.com>
References: <20200922104932.46384-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 00:31:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Many tests (that do not support generic protocols) can run just fine
with FUSE-exported images, so allow them to.  Note that this is no
attempt at being definitely complete.  There are some tests that might
be modified to run on FUSE, but this patch still skips them.  This patch
only tries to pick the rather low-hanging fruits.

Note that 221 and 250 only pass when .lseek is correctly implemented,
which is only possible with a libfuse that is 3.8 or newer.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/025 | 2 +-
 tests/qemu-iotests/026 | 2 +-
 tests/qemu-iotests/028 | 2 +-
 tests/qemu-iotests/031 | 2 +-
 tests/qemu-iotests/034 | 2 +-
 tests/qemu-iotests/036 | 2 +-
 tests/qemu-iotests/037 | 2 +-
 tests/qemu-iotests/038 | 2 +-
 tests/qemu-iotests/039 | 2 +-
 tests/qemu-iotests/046 | 2 +-
 tests/qemu-iotests/050 | 2 +-
 tests/qemu-iotests/054 | 2 +-
 tests/qemu-iotests/060 | 2 +-
 tests/qemu-iotests/071 | 2 +-
 tests/qemu-iotests/079 | 2 +-
 tests/qemu-iotests/080 | 2 +-
 tests/qemu-iotests/089 | 2 +-
 tests/qemu-iotests/090 | 2 +-
 tests/qemu-iotests/091 | 2 +-
 tests/qemu-iotests/095 | 2 +-
 tests/qemu-iotests/097 | 2 +-
 tests/qemu-iotests/098 | 2 +-
 tests/qemu-iotests/102 | 2 +-
 tests/qemu-iotests/103 | 2 +-
 tests/qemu-iotests/106 | 2 +-
 tests/qemu-iotests/107 | 2 +-
 tests/qemu-iotests/108 | 2 +-
 tests/qemu-iotests/111 | 2 +-
 tests/qemu-iotests/112 | 2 +-
 tests/qemu-iotests/115 | 2 +-
 tests/qemu-iotests/117 | 2 +-
 tests/qemu-iotests/120 | 2 +-
 tests/qemu-iotests/121 | 2 +-
 tests/qemu-iotests/127 | 2 +-
 tests/qemu-iotests/133 | 2 +-
 tests/qemu-iotests/137 | 2 +-
 tests/qemu-iotests/138 | 2 +-
 tests/qemu-iotests/140 | 2 +-
 tests/qemu-iotests/154 | 2 +-
 tests/qemu-iotests/161 | 2 +-
 tests/qemu-iotests/171 | 2 +-
 tests/qemu-iotests/175 | 2 +-
 tests/qemu-iotests/176 | 2 +-
 tests/qemu-iotests/177 | 2 +-
 tests/qemu-iotests/179 | 2 +-
 tests/qemu-iotests/183 | 2 +-
 tests/qemu-iotests/186 | 2 +-
 tests/qemu-iotests/187 | 2 +-
 tests/qemu-iotests/191 | 2 +-
 tests/qemu-iotests/195 | 2 +-
 tests/qemu-iotests/200 | 2 +-
 tests/qemu-iotests/204 | 2 +-
 tests/qemu-iotests/214 | 2 +-
 tests/qemu-iotests/217 | 2 +-
 tests/qemu-iotests/220 | 2 +-
 tests/qemu-iotests/221 | 2 +-
 tests/qemu-iotests/229 | 2 +-
 tests/qemu-iotests/247 | 2 +-
 tests/qemu-iotests/249 | 2 +-
 tests/qemu-iotests/250 | 2 +-
 tests/qemu-iotests/252 | 2 +-
 tests/qemu-iotests/265 | 2 +-
 tests/qemu-iotests/268 | 2 +-
 tests/qemu-iotests/272 | 2 +-
 tests/qemu-iotests/273 | 2 +-
 tests/qemu-iotests/279 | 2 +-
 tests/qemu-iotests/286 | 2 +-
 tests/qemu-iotests/287 | 2 +-
 tests/qemu-iotests/289 | 2 +-
 tests/qemu-iotests/290 | 2 +-
 tests/qemu-iotests/291 | 2 +-
 tests/qemu-iotests/292 | 2 +-
 tests/qemu-iotests/293 | 2 +-
 tests/qemu-iotests/294 | 2 +-
 tests/qemu-iotests/305 | 2 +-
 75 files changed, 75 insertions(+), 75 deletions(-)

diff --git a/tests/qemu-iotests/025 b/tests/qemu-iotests/025
index e05d833452..1569d912f4 100755
--- a/tests/qemu-iotests/025
+++ b/tests/qemu-iotests/025
@@ -38,7 +38,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.pattern
 
 _supported_fmt raw qcow2 qed luks
-_supported_proto file sheepdog rbd nfs
+_supported_proto file sheepdog rbd nfs fuse
 
 echo "=== Creating image"
 echo
diff --git a/tests/qemu-iotests/026 b/tests/qemu-iotests/026
index b9713eb591..9ecc5880b1 100755
--- a/tests/qemu-iotests/026
+++ b/tests/qemu-iotests/026
@@ -41,7 +41,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # Currently only qcow2 supports rebasing
 _supported_fmt qcow2
-_supported_proto file
+_supported_proto file fuse
 _default_cache_mode writethrough
 _supported_cache_modes writethrough none
 # The refcount table tests expect a certain minimum width for refcount entries
diff --git a/tests/qemu-iotests/028 b/tests/qemu-iotests/028
index 864dc4a4e2..57d34aae99 100755
--- a/tests/qemu-iotests/028
+++ b/tests/qemu-iotests/028
@@ -46,7 +46,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # Any format supporting backing files except vmdk and qcow which do not support
 # smaller backing files.
 _supported_fmt qcow2 qed
-_supported_proto file
+_supported_proto file fuse
 _supported_os Linux
 
 # Choose a size that is not necessarily a cluster size multiple for image
diff --git a/tests/qemu-iotests/031 b/tests/qemu-iotests/031
index 646ecd593f..2bcbc5886e 100755
--- a/tests/qemu-iotests/031
+++ b/tests/qemu-iotests/031
@@ -39,7 +39,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # This tests qcow2-specific low-level functionality
 _supported_fmt qcow2
-_supported_proto file
+_supported_proto file fuse
 # We want to test compat=0.10, which does not support external data
 # files or refcount widths other than 16
 _unsupported_imgopts data_file 'refcount_bits=\([^1]\|.\([^6]\|$\)\)'
diff --git a/tests/qemu-iotests/034 b/tests/qemu-iotests/034
index ac2d687c71..08f7aea6d5 100755
--- a/tests/qemu-iotests/034
+++ b/tests/qemu-iotests/034
@@ -37,7 +37,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
 
 _supported_fmt qcow qcow2 vmdk qed
-_supported_proto file
+_supported_proto file fuse
 _supported_os Linux
 _unsupported_imgopts "subformat=monolithicFlat" \
                      "subformat=twoGbMaxExtentFlat" \
diff --git a/tests/qemu-iotests/036 b/tests/qemu-iotests/036
index cf522de7a1..6b82638080 100755
--- a/tests/qemu-iotests/036
+++ b/tests/qemu-iotests/036
@@ -42,7 +42,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # This tests qcow2-specific low-level functionality
 _supported_fmt qcow2
-_supported_proto file
+_supported_proto file fuse
 # Only qcow2v3 and later supports feature bits;
 # qcow2.py does not support external data files;
 # this test requires a cluster size large enough for the feature table
diff --git a/tests/qemu-iotests/037 b/tests/qemu-iotests/037
index e1187ac24a..bb893c43dc 100755
--- a/tests/qemu-iotests/037
+++ b/tests/qemu-iotests/037
@@ -37,7 +37,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
 
 _supported_fmt qcow qcow2 vmdk qed
-_supported_proto file
+_supported_proto file fuse
 _unsupported_imgopts "subformat=monolithicFlat" \
                      "subformat=twoGbMaxExtentFlat" \
                      "subformat=twoGbMaxExtentSparse" \
diff --git a/tests/qemu-iotests/038 b/tests/qemu-iotests/038
index a253231f5b..30f1f73c25 100755
--- a/tests/qemu-iotests/038
+++ b/tests/qemu-iotests/038
@@ -37,7 +37,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
 
 _supported_fmt qcow2 qed
-_supported_proto file
+_supported_proto file fuse
 _supported_os Linux
 
 CLUSTER_SIZE=2M
diff --git a/tests/qemu-iotests/039 b/tests/qemu-iotests/039
index 42f6503138..ad3867c3fc 100755
--- a/tests/qemu-iotests/039
+++ b/tests/qemu-iotests/039
@@ -40,7 +40,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
 
 _supported_fmt qcow2
-_supported_proto file
+_supported_proto file fuse
 _supported_os Linux
 _default_cache_mode writethrough
 _supported_cache_modes writethrough
diff --git a/tests/qemu-iotests/046 b/tests/qemu-iotests/046
index 40a9f30087..ed6fae3529 100755
--- a/tests/qemu-iotests/046
+++ b/tests/qemu-iotests/046
@@ -37,7 +37,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
 
 _supported_fmt qcow2
-_supported_proto file
+_supported_proto file fuse
 # data_file does not support compressed clusters
 _unsupported_imgopts data_file
 
diff --git a/tests/qemu-iotests/050 b/tests/qemu-iotests/050
index 4b0a390c43..741bdb610e 100755
--- a/tests/qemu-iotests/050
+++ b/tests/qemu-iotests/050
@@ -39,7 +39,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
 
 _supported_fmt qcow2 qed
-_supported_proto file
+_supported_proto file fuse
 
 echo
 echo "== Creating images =="
diff --git a/tests/qemu-iotests/054 b/tests/qemu-iotests/054
index a8905b60d0..40922db2b1 100755
--- a/tests/qemu-iotests/054
+++ b/tests/qemu-iotests/054
@@ -37,7 +37,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
 
 _supported_fmt qcow2
-_supported_proto file
+_supported_proto file fuse
 
 echo
 echo "creating too large image (1 EB)"
diff --git a/tests/qemu-iotests/060 b/tests/qemu-iotests/060
index 94c0d5accc..4b81d1aa51 100755
--- a/tests/qemu-iotests/060
+++ b/tests/qemu-iotests/060
@@ -46,7 +46,7 @@ _filter_io_error()
 
 # This tests qcow2-specific low-level functionality
 _supported_fmt qcow2
-_supported_proto file
+_supported_proto file fuse
 _supported_os Linux
 # These tests only work for compat=1.1 images without an external
 # data file with refcount_bits=16
diff --git a/tests/qemu-iotests/071 b/tests/qemu-iotests/071
index 18fe9054b0..49faae6684 100755
--- a/tests/qemu-iotests/071
+++ b/tests/qemu-iotests/071
@@ -37,7 +37,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
 
 _supported_fmt qcow2
-_supported_proto file
+_supported_proto file fuse
 _require_drivers blkdebug blkverify
 # blkdebug can only inject errors on bs->file, not on the data_file,
 # so thie test does not work with external data files
diff --git a/tests/qemu-iotests/079 b/tests/qemu-iotests/079
index 3642b51feb..0f0d94a2ac 100755
--- a/tests/qemu-iotests/079
+++ b/tests/qemu-iotests/079
@@ -37,7 +37,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
 
 _supported_fmt qcow2
-_supported_proto file nfs
+_supported_proto file nfs fuse
 
 # Some containers (e.g. non-x86 on Travis) do not allow large files
 _require_large_file 4G
diff --git a/tests/qemu-iotests/080 b/tests/qemu-iotests/080
index 7588c63b6c..bda8617c38 100755
--- a/tests/qemu-iotests/080
+++ b/tests/qemu-iotests/080
@@ -38,7 +38,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
 
 _supported_fmt qcow2
-_supported_proto file
+_supported_proto file fuse
 _supported_os Linux
 # - Internal snapshots are (currently) impossible with refcount_bits=1,
 #   and generally impossible with external data files
diff --git a/tests/qemu-iotests/089 b/tests/qemu-iotests/089
index 03a2ccf1e8..f0929b64c0 100755
--- a/tests/qemu-iotests/089
+++ b/tests/qemu-iotests/089
@@ -37,7 +37,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
 
 _supported_fmt qcow2
-_supported_proto file
+_supported_proto file fuse
 # Because anything other than 16 would change the output of qemu_io -c info
 _unsupported_imgopts 'refcount_bits=\([^1]\|.\([^6]\|$\)\)'
 
diff --git a/tests/qemu-iotests/090 b/tests/qemu-iotests/090
index 1246e4f910..87e872ebf4 100755
--- a/tests/qemu-iotests/090
+++ b/tests/qemu-iotests/090
@@ -37,7 +37,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
 
 _supported_fmt qcow2
-_supported_proto file nfs
+_supported_proto file nfs fuse
 # External data files do not support compressed clusters
 _unsupported_imgopts data_file
 
diff --git a/tests/qemu-iotests/091 b/tests/qemu-iotests/091
index 8a4ce5b7e2..8dee168bf6 100755
--- a/tests/qemu-iotests/091
+++ b/tests/qemu-iotests/091
@@ -44,7 +44,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.qemu
 
 _supported_fmt qcow2
-_supported_proto file
+_supported_proto file fuse
 _supported_os Linux
 _supported_cache_modes writethrough none writeback
 _default_cache_mode none writeback
diff --git a/tests/qemu-iotests/095 b/tests/qemu-iotests/095
index 77a5f0f3f5..7604ae6966 100755
--- a/tests/qemu-iotests/095
+++ b/tests/qemu-iotests/095
@@ -44,7 +44,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.qemu
 
 _supported_fmt qcow2
-_supported_proto file
+_supported_proto file fuse
 
 size_smaller=5M
 size_larger=100M
diff --git a/tests/qemu-iotests/097 b/tests/qemu-iotests/097
index d910a8b107..1837d4e8e0 100755
--- a/tests/qemu-iotests/097
+++ b/tests/qemu-iotests/097
@@ -41,7 +41,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # Any format supporting backing files and bdrv_make_empty
 _supported_fmt qcow qcow2
-_supported_proto file
+_supported_proto file fuse
 _supported_os Linux
 
 
diff --git a/tests/qemu-iotests/098 b/tests/qemu-iotests/098
index f2ccdd7909..a35ce7205e 100755
--- a/tests/qemu-iotests/098
+++ b/tests/qemu-iotests/098
@@ -39,7 +39,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.pattern
 
 _supported_fmt qcow2
-_supported_proto file
+_supported_proto file fuse
 # The code path we want to test here only works for compat=1.1 images;
 # blkdebug can only inject errors on bs->file, so external data files
 # do not work with this test
diff --git a/tests/qemu-iotests/102 b/tests/qemu-iotests/102
index b898df436f..2cc3efd1ed 100755
--- a/tests/qemu-iotests/102
+++ b/tests/qemu-iotests/102
@@ -39,7 +39,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.qemu
 
 _supported_fmt qcow2
-_supported_proto file
+_supported_proto file fuse
 
 IMG_SIZE=64K
 
diff --git a/tests/qemu-iotests/103 b/tests/qemu-iotests/103
index 8c1ebe0443..220481db4c 100755
--- a/tests/qemu-iotests/103
+++ b/tests/qemu-iotests/103
@@ -37,7 +37,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
 
 _supported_fmt qcow2
-_supported_proto file nfs
+_supported_proto file nfs fuse
 # Internal snapshots are (currently) impossible with refcount_bits=1,
 # and generally impossible with external data files
 _unsupported_imgopts 'refcount_bits=1[^0-9]' data_file
diff --git a/tests/qemu-iotests/106 b/tests/qemu-iotests/106
index a20659d443..20ad7bd5a2 100755
--- a/tests/qemu-iotests/106
+++ b/tests/qemu-iotests/106
@@ -37,7 +37,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
 
 _supported_fmt raw
-_supported_proto file
+_supported_proto file fuse
 _supported_os Linux
 
 # in kB
diff --git a/tests/qemu-iotests/107 b/tests/qemu-iotests/107
index 268ba27688..d24829ccf9 100755
--- a/tests/qemu-iotests/107
+++ b/tests/qemu-iotests/107
@@ -37,7 +37,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
 
 _supported_fmt qcow2
-_supported_proto file nfs
+_supported_proto file nfs fuse
 
 
 IMG_SIZE=64K
diff --git a/tests/qemu-iotests/108 b/tests/qemu-iotests/108
index 5f7076fba4..ba67748bdf 100755
--- a/tests/qemu-iotests/108
+++ b/tests/qemu-iotests/108
@@ -39,7 +39,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # This tests qcow2-specific low-level functionality
 _supported_fmt qcow2
-_supported_proto file
+_supported_proto file fuse
 _supported_os Linux
 # This test directly modifies a refblock so it relies on refcount_bits being 16;
 # and the low-level modification it performs are not tuned for external data
diff --git a/tests/qemu-iotests/111 b/tests/qemu-iotests/111
index 3b43d1bd83..bd839a39f4 100755
--- a/tests/qemu-iotests/111
+++ b/tests/qemu-iotests/111
@@ -38,7 +38,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
 
 _supported_fmt qed qcow qcow2 vmdk
-_supported_proto file
+_supported_proto file fuse
 _unsupported_imgopts "subformat=monolithicFlat" "subformat=twoGbMaxExtentFlat"
 
 _make_test_img -b "$TEST_IMG.inexistent"
diff --git a/tests/qemu-iotests/112 b/tests/qemu-iotests/112
index 20ff5c224a..6e413f5651 100755
--- a/tests/qemu-iotests/112
+++ b/tests/qemu-iotests/112
@@ -38,7 +38,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # This tests qcow2-specific low-level functionality
 _supported_fmt qcow2
-_supported_proto file
+_supported_proto file fuse
 # This test will set refcount_bits on its own which would conflict with the
 # manual setting; compat will be overridden as well;
 # and external data files do not work well with our refcount testing
diff --git a/tests/qemu-iotests/115 b/tests/qemu-iotests/115
index d254b18342..7f53987d1b 100755
--- a/tests/qemu-iotests/115
+++ b/tests/qemu-iotests/115
@@ -37,7 +37,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
 
 _supported_fmt qcow2
-_supported_proto file
+_supported_proto file fuse
 # This test relies on refcounts being 64 bits wide (which does not work with
 # compat=0.10)
 _unsupported_imgopts 'refcount_bits=\([^6]\|.\([^4]\|$\)\)' 'compat=0.10'
diff --git a/tests/qemu-iotests/117 b/tests/qemu-iotests/117
index f37b34f8b1..9039555ac4 100755
--- a/tests/qemu-iotests/117
+++ b/tests/qemu-iotests/117
@@ -39,7 +39,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.qemu
 
 _supported_fmt qcow2
-_supported_proto file
+_supported_proto file fuse
 
 _make_test_img 64k
 
diff --git a/tests/qemu-iotests/120 b/tests/qemu-iotests/120
index 2931a7550f..45c55c1c01 100755
--- a/tests/qemu-iotests/120
+++ b/tests/qemu-iotests/120
@@ -38,7 +38,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
 
 _supported_fmt generic
-_supported_proto file
+_supported_proto file fuse
 _unsupported_fmt luks
 _require_drivers raw
 
diff --git a/tests/qemu-iotests/121 b/tests/qemu-iotests/121
index 90ea0db737..8357ce089a 100755
--- a/tests/qemu-iotests/121
+++ b/tests/qemu-iotests/121
@@ -37,7 +37,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
 
 _supported_fmt qcow2
-_supported_proto file
+_supported_proto file fuse
 _supported_os Linux
 # Refcount structures are used much differently with external data
 # files
diff --git a/tests/qemu-iotests/127 b/tests/qemu-iotests/127
index e2ac2f5536..77fdfd0205 100755
--- a/tests/qemu-iotests/127
+++ b/tests/qemu-iotests/127
@@ -41,7 +41,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.qemu
 
 _supported_fmt qcow2
-_supported_proto file
+_supported_proto file fuse
 
 _require_devices virtio-scsi scsi-hd
 
diff --git a/tests/qemu-iotests/133 b/tests/qemu-iotests/133
index 4070fd9457..bc82d8ebd7 100755
--- a/tests/qemu-iotests/133
+++ b/tests/qemu-iotests/133
@@ -37,7 +37,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
 
 _supported_fmt qcow2
-_supported_proto file
+_supported_proto file fuse
 
 TEST_IMG="$TEST_IMG.base" _make_test_img 64M
 _make_test_img -b "$TEST_IMG.base" -F $IMGFMT
diff --git a/tests/qemu-iotests/137 b/tests/qemu-iotests/137
index 7ae86892f7..de555a91c9 100755
--- a/tests/qemu-iotests/137
+++ b/tests/qemu-iotests/137
@@ -38,7 +38,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.qemu
 
 _supported_fmt qcow2
-_supported_proto file
+_supported_proto file fuse
 _supported_os Linux
 # We are going to use lazy-refcounts
 _unsupported_imgopts 'compat=0.10'
diff --git a/tests/qemu-iotests/138 b/tests/qemu-iotests/138
index 1d5b0bed6d..e87a64eb89 100755
--- a/tests/qemu-iotests/138
+++ b/tests/qemu-iotests/138
@@ -38,7 +38,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # This tests qcow2-specific low-level functionality
 _supported_fmt qcow2
-_supported_proto file
+_supported_proto file fuse
 _supported_os Linux
 # With an external data file, data clusters are not refcounted
 # (so qemu-img check would not do much);
diff --git a/tests/qemu-iotests/140 b/tests/qemu-iotests/140
index 443751455e..97b6e55810 100755
--- a/tests/qemu-iotests/140
+++ b/tests/qemu-iotests/140
@@ -44,7 +44,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.qemu
 
 _supported_fmt generic
-_supported_proto file
+_supported_proto file fuse
 _supported_os Linux
 
 _make_test_img 64k
diff --git a/tests/qemu-iotests/154 b/tests/qemu-iotests/154
index 7f1c0d9bd9..34a1c051b6 100755
--- a/tests/qemu-iotests/154
+++ b/tests/qemu-iotests/154
@@ -37,7 +37,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
 
 _supported_fmt qcow2
-_supported_proto file
+_supported_proto file fuse
 _supported_os Linux
 
 CLUSTER_SIZE=4k
diff --git a/tests/qemu-iotests/161 b/tests/qemu-iotests/161
index bbf7dbbc5c..4fb7d0cbf0 100755
--- a/tests/qemu-iotests/161
+++ b/tests/qemu-iotests/161
@@ -42,7 +42,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # Any format implementing BlockDriver.bdrv_change_backing_file
 _supported_fmt qcow2 qed
-_supported_proto file
+_supported_proto file fuse
 _supported_os Linux
 
 IMG_SIZE=1M
diff --git a/tests/qemu-iotests/171 b/tests/qemu-iotests/171
index 341064a1c6..f3582edb10 100755
--- a/tests/qemu-iotests/171
+++ b/tests/qemu-iotests/171
@@ -38,7 +38,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
 
 _supported_fmt raw
-_supported_proto file
+_supported_proto file fuse
 _supported_os Linux
 
 
diff --git a/tests/qemu-iotests/175 b/tests/qemu-iotests/175
index c3c2aed653..21a77a2bf5 100755
--- a/tests/qemu-iotests/175
+++ b/tests/qemu-iotests/175
@@ -71,7 +71,7 @@ EOF
 . ./common.filter
 
 _supported_fmt raw
-_supported_proto file
+_supported_proto file fuse
 _supported_os Linux
 
 _default_cache_mode none
diff --git a/tests/qemu-iotests/176 b/tests/qemu-iotests/176
index 2565ff12ee..5ce3b27069 100755
--- a/tests/qemu-iotests/176
+++ b/tests/qemu-iotests/176
@@ -45,7 +45,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # This test is specific to qcow2
 _supported_fmt qcow2
-_supported_proto file
+_supported_proto file fuse
 _supported_os Linux
 # Persistent dirty bitmaps require compat=1.1;
 # Internal snapshots forbid using an external data file
diff --git a/tests/qemu-iotests/177 b/tests/qemu-iotests/177
index 5d4a77a6ab..595bfd4236 100755
--- a/tests/qemu-iotests/177
+++ b/tests/qemu-iotests/177
@@ -40,7 +40,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # tests specific to compat=1.1.
 
 _supported_fmt qcow2
-_supported_proto file
+_supported_proto file fuse
 
 CLUSTER_SIZE=1M
 size=128M
diff --git a/tests/qemu-iotests/179 b/tests/qemu-iotests/179
index 11a20cb1bf..7ada04c641 100755
--- a/tests/qemu-iotests/179
+++ b/tests/qemu-iotests/179
@@ -38,7 +38,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
 
 _supported_fmt qcow2
-_supported_proto file
+_supported_proto file fuse
 _supported_os Linux
 
 # v2 images can't mark clusters as zero
diff --git a/tests/qemu-iotests/183 b/tests/qemu-iotests/183
index acdbefa310..d889a3b19c 100755
--- a/tests/qemu-iotests/183
+++ b/tests/qemu-iotests/183
@@ -44,7 +44,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_os Linux FreeBSD NetBSD
 _supported_fmt qcow2 raw qed quorum
-_supported_proto file
+_supported_proto file fuse
 
 size=64M
 _make_test_img $size
diff --git a/tests/qemu-iotests/186 b/tests/qemu-iotests/186
index 3ea0442d44..0db25b0e68 100755
--- a/tests/qemu-iotests/186
+++ b/tests/qemu-iotests/186
@@ -37,7 +37,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
 
 _supported_fmt qcow2
-_supported_proto file
+_supported_proto file fuse
 _require_drivers null-co
 
 if [ "$QEMU_DEFAULT_MACHINE" != "pc" ]; then
diff --git a/tests/qemu-iotests/187 b/tests/qemu-iotests/187
index c6e1dc57a0..f262d83e3a 100755
--- a/tests/qemu-iotests/187
+++ b/tests/qemu-iotests/187
@@ -39,7 +39,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
 
 _supported_fmt qcow2
-_supported_proto file
+_supported_proto file fuse
 
 size=64M
 _make_test_img $size
diff --git a/tests/qemu-iotests/191 b/tests/qemu-iotests/191
index d17462e1e4..95a891350d 100755
--- a/tests/qemu-iotests/191
+++ b/tests/qemu-iotests/191
@@ -42,7 +42,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.qemu
 
 _supported_fmt qcow2
-_supported_proto file
+_supported_proto file fuse
 # An external data file would change the query-named-block-nodes output
 _unsupported_imgopts data_file
 
diff --git a/tests/qemu-iotests/195 b/tests/qemu-iotests/195
index 2351d55fe1..967af5b7b5 100755
--- a/tests/qemu-iotests/195
+++ b/tests/qemu-iotests/195
@@ -38,7 +38,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
 
 _supported_fmt qcow2
-_supported_proto file
+_supported_proto file fuse
 
 do_run_qemu()
 {
diff --git a/tests/qemu-iotests/200 b/tests/qemu-iotests/200
index a7aabbd032..046539154f 100755
--- a/tests/qemu-iotests/200
+++ b/tests/qemu-iotests/200
@@ -42,7 +42,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.qemu
 
 _supported_fmt qcow2 qed
-_supported_proto file
+_supported_proto file fuse
 
 BACKING_IMG="$TEST_IMG.base"
 
diff --git a/tests/qemu-iotests/204 b/tests/qemu-iotests/204
index 6770fa9b96..536bb8b534 100755
--- a/tests/qemu-iotests/204
+++ b/tests/qemu-iotests/204
@@ -37,7 +37,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
 
 _supported_fmt qcow2
-_supported_proto file
+_supported_proto file fuse
 # This test assumes that discard leaves zero clusters; see test 177 for
 # other tests that also work in older images
 _unsupported_imgopts 'compat=0.10'
diff --git a/tests/qemu-iotests/214 b/tests/qemu-iotests/214
index af677d90b8..75ae7a14b5 100755
--- a/tests/qemu-iotests/214
+++ b/tests/qemu-iotests/214
@@ -35,7 +35,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
 
 _supported_fmt qcow2
-_supported_proto file
+_supported_proto file fuse
 
 # Repairing the corrupted image requires qemu-img check to store a
 # refcount up to 3, which requires at least two refcount bits.
diff --git a/tests/qemu-iotests/217 b/tests/qemu-iotests/217
index d89116ccad..7385342498 100755
--- a/tests/qemu-iotests/217
+++ b/tests/qemu-iotests/217
@@ -36,7 +36,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # This test is specific to qcow2
 _supported_fmt qcow2
-_supported_proto file
+_supported_proto file fuse
 
 # This test needs clusters with at least a refcount of 2 so that
 # OFLAG_COPIED is not set.  refcount_bits=1 is therefore unsupported.
diff --git a/tests/qemu-iotests/220 b/tests/qemu-iotests/220
index a9259b7127..9ba3b3fdcb 100755
--- a/tests/qemu-iotests/220
+++ b/tests/qemu-iotests/220
@@ -35,7 +35,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.pattern
 
 _supported_fmt qcow2
-_supported_proto file
+_supported_proto file fuse
 _supported_os Linux
 # To use a different refcount width but 16 bits we need compat=1.1,
 # and external data files do not support compressed clusters.
diff --git a/tests/qemu-iotests/221 b/tests/qemu-iotests/221
index 0e9096fec7..ca62b3baa1 100755
--- a/tests/qemu-iotests/221
+++ b/tests/qemu-iotests/221
@@ -35,7 +35,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
 
 _supported_fmt raw
-_supported_proto file
+_supported_proto file fuse
 _supported_os Linux
 
 _default_cache_mode writeback
diff --git a/tests/qemu-iotests/229 b/tests/qemu-iotests/229
index 5f759fa587..273ac2472d 100755
--- a/tests/qemu-iotests/229
+++ b/tests/qemu-iotests/229
@@ -44,7 +44,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # Needs backing file and backing format support
 _supported_fmt qcow2 qed
-_supported_proto file
+_supported_proto file fuse
 _supported_os Linux
 # blkdebug can only inject errors on bs->file, so external data files
 # do not work with this test
diff --git a/tests/qemu-iotests/247 b/tests/qemu-iotests/247
index 87e37b39e2..6cf2679750 100755
--- a/tests/qemu-iotests/247
+++ b/tests/qemu-iotests/247
@@ -41,7 +41,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # Requires backing files and .bdrv_change_backing_file support
 _supported_fmt qcow2 qed
-_supported_proto file
+_supported_proto file fuse
 
 size=128M
 
diff --git a/tests/qemu-iotests/249 b/tests/qemu-iotests/249
index a9aa9303eb..29453b8c90 100755
--- a/tests/qemu-iotests/249
+++ b/tests/qemu-iotests/249
@@ -42,7 +42,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # Any format implementing BlockDriver.bdrv_change_backing_file
 _supported_fmt qcow2 qed
-_supported_proto file
+_supported_proto file fuse
 _supported_os Linux
 
 IMG_SIZE=1M
diff --git a/tests/qemu-iotests/250 b/tests/qemu-iotests/250
index 9bb6b94d74..3df275c76b 100755
--- a/tests/qemu-iotests/250
+++ b/tests/qemu-iotests/250
@@ -37,7 +37,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
 
 _supported_fmt qcow2
-_supported_proto file
+_supported_proto file fuse
 _supported_os Linux
 # This test does not make much sense with external data files
 _unsupported_imgopts data_file
diff --git a/tests/qemu-iotests/252 b/tests/qemu-iotests/252
index 6662f4c9de..1d74afff99 100755
--- a/tests/qemu-iotests/252
+++ b/tests/qemu-iotests/252
@@ -42,7 +42,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # zero cluster support
 _supported_fmt qcow2
 _unsupported_imgopts 'compat=0.10'
-_supported_proto file
+_supported_proto file fuse
 _supported_os Linux
 
 CLUSTER_SIZE=65536
diff --git a/tests/qemu-iotests/265 b/tests/qemu-iotests/265
index 00f2ec769e..0e800fb524 100755
--- a/tests/qemu-iotests/265
+++ b/tests/qemu-iotests/265
@@ -35,7 +35,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # qcow2-specific test
 _supported_fmt qcow2
-_supported_proto file
+_supported_proto file fuse
 _supported_os Linux
 
 echo '--- Writing to the image ---'
diff --git a/tests/qemu-iotests/268 b/tests/qemu-iotests/268
index 78c3f4db3a..ddf4312284 100755
--- a/tests/qemu-iotests/268
+++ b/tests/qemu-iotests/268
@@ -38,7 +38,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
 
 _supported_fmt qcow2
-_supported_proto file
+_supported_proto file fuse
 
 echo
 echo "== Required alignment larger than cluster size =="
diff --git a/tests/qemu-iotests/272 b/tests/qemu-iotests/272
index c2f782d47b..de475bf6f0 100755
--- a/tests/qemu-iotests/272
+++ b/tests/qemu-iotests/272
@@ -35,7 +35,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # This is a qcow2 regression test
 _supported_fmt qcow2
-_supported_proto file
+_supported_proto file fuse
 
 # External data files do not support compression;
 # We need an exact cluster size (2M) and refcount width (2) so we can
diff --git a/tests/qemu-iotests/273 b/tests/qemu-iotests/273
index 41ffbf39c4..79b4ab4b05 100755
--- a/tests/qemu-iotests/273
+++ b/tests/qemu-iotests/273
@@ -35,7 +35,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # This is a qcow2 regression test
 _supported_fmt qcow2
-_supported_proto file
+_supported_proto file fuse
 _supported_os Linux
 # External data files would add nodes to the block graph, so it would
 # not match the reference output
diff --git a/tests/qemu-iotests/279 b/tests/qemu-iotests/279
index 5515d4ed01..2a6315cf17 100755
--- a/tests/qemu-iotests/279
+++ b/tests/qemu-iotests/279
@@ -36,7 +36,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # Backing files are required...
 _supported_fmt qcow qcow2 vmdk qed
-_supported_proto file
+_supported_proto file fuse
 _supported_os Linux
 _unsupported_imgopts "subformat=monolithicFlat" \
                      "subformat=twoGbMaxExtentFlat" \
diff --git a/tests/qemu-iotests/286 b/tests/qemu-iotests/286
index f14445ba4a..f64e0eccea 100755
--- a/tests/qemu-iotests/286
+++ b/tests/qemu-iotests/286
@@ -35,7 +35,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.qemu
 
 _supported_fmt qcow2
-_supported_proto file
+_supported_proto file fuse
 # Internal snapshots are (currently) impossible with refcount_bits=1,
 # and generally impossible with external data files
 _unsupported_imgopts 'refcount_bits=1[^0-9]' data_file
diff --git a/tests/qemu-iotests/287 b/tests/qemu-iotests/287
index 036cc09e82..3bb383fd4b 100755
--- a/tests/qemu-iotests/287
+++ b/tests/qemu-iotests/287
@@ -32,7 +32,7 @@ status=1	# failure is the default!
 
 # This tests qocw2-specific low-level functionality
 _supported_fmt qcow2
-_supported_proto file
+_supported_proto file fuse
 _supported_os Linux
 _unsupported_imgopts 'compat=0.10' data_file
 
diff --git a/tests/qemu-iotests/289 b/tests/qemu-iotests/289
index 1c11d4030e..fe69bde1eb 100755
--- a/tests/qemu-iotests/289
+++ b/tests/qemu-iotests/289
@@ -38,7 +38,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.pattern
 
 _supported_fmt qcow2
-_supported_proto file
+_supported_proto file fuse
 # This is a v3-exclusive test;
 # As for data_file, error paths often very much depend on whether
 # there is an external data file or not; so we create one exactly when
diff --git a/tests/qemu-iotests/290 b/tests/qemu-iotests/290
index 01ee14dcfb..35c38d4f80 100755
--- a/tests/qemu-iotests/290
+++ b/tests/qemu-iotests/290
@@ -38,7 +38,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
 
 _supported_fmt qcow2
-_supported_proto file
+_supported_proto file fuse
 _supported_os Linux
 _unsupported_imgopts 'compat=0.10' refcount_bits data_file
 
diff --git a/tests/qemu-iotests/291 b/tests/qemu-iotests/291
index 1e0bb76959..34ad5f0c30 100755
--- a/tests/qemu-iotests/291
+++ b/tests/qemu-iotests/291
@@ -36,7 +36,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.nbd
 
 _supported_fmt qcow2
-_supported_proto file
+_supported_proto file fuse
 _supported_os Linux
 _require_command QEMU_NBD
 # compat=0.10 does not support bitmaps
diff --git a/tests/qemu-iotests/292 b/tests/qemu-iotests/292
index 83ab19231d..3ae2772e3b 100755
--- a/tests/qemu-iotests/292
+++ b/tests/qemu-iotests/292
@@ -38,7 +38,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
 
 _supported_fmt qcow2
-_supported_proto file
+_supported_proto file fuse
 _supported_os Linux
 # We need qemu-img map to show the file where the data is allocated,
 # but with an external data file, it will show that instead of the
diff --git a/tests/qemu-iotests/293 b/tests/qemu-iotests/293
index f86fe3b413..3363bf07f0 100755
--- a/tests/qemu-iotests/293
+++ b/tests/qemu-iotests/293
@@ -38,7 +38,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
 
 _supported_fmt qcow2 luks
-_supported_proto file #TODO
+_supported_proto file fuse #TODO
 _require_working_luks
 
 QEMU_IO_OPTIONS=$QEMU_IO_OPTIONS_NO_FMT
diff --git a/tests/qemu-iotests/294 b/tests/qemu-iotests/294
index 9c95ed8c9a..87da35db49 100755
--- a/tests/qemu-iotests/294
+++ b/tests/qemu-iotests/294
@@ -34,7 +34,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
 
 _supported_fmt luks
-_supported_proto file #TODO
+_supported_proto file fuse #TODO
 
 QEMU_IO_OPTIONS=$QEMU_IO_OPTIONS_NO_FMT
 
diff --git a/tests/qemu-iotests/305 b/tests/qemu-iotests/305
index 768818af4a..5a415eb2a4 100755
--- a/tests/qemu-iotests/305
+++ b/tests/qemu-iotests/305
@@ -38,7 +38,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
 
 _supported_fmt qcow2
-_supported_proto file
+_supported_proto file fuse
 _supported_os Linux
 _unsupported_imgopts cluster_size refcount_bits extended_l2 compat=0.10 data_file
 
-- 
2.26.2


