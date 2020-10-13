Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B25C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 07:03:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E931720797
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 07:03:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E931720797
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSELc-0001NU-Us
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 03:03:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33042)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kSEBo-0005bb-Lf; Tue, 13 Oct 2020 02:53:40 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:53711)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kSEBm-0000Hq-Nr; Tue, 13 Oct 2020 02:53:40 -0400
Received: from localhost.localdomain ([82.252.141.186]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N8onW-1kNOJL2eYg-015qZR; Tue, 13 Oct 2020 08:53:21 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 06/15] vmdk: fix maybe uninitialized warnings
Date: Tue, 13 Oct 2020 08:53:04 +0200
Message-Id: <20201013065313.7349-7-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201013065313.7349-1-laurent@vivier.eu>
References: <20201013065313.7349-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:go/gI0UABVpjGWntfaRHl3a5hQIzFcI0Bx6KnnlQvmAePDyTE9X
 VqdLTbm4jbfcYvf/c6JIaVK3RO45xuGsivpDMEZla0dq//T+LX2nXQvmBDY1rJgs3322WDE
 6YI4jZn+drpSiflXu/3MNgo2HYMyKp3+5NQuJQF3Gdu5zGKhbUQ2ClvWS+97iNu74mqKGCw
 D5hwuyIyR4a3cbXCIL8nQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wLwde721jGA=:cn8rt9+G0ESHofOWkrqLqP
 0dFQnEtbKBPc5uxbD2UBiF8I8/12AgVOSCqfkINyGo2+kPLAV/MPUyKv2bnqf7GDrlvaNJpXX
 6WShT33eiUTs3VzH3HF/XSVzIkDykYsmqaxQOTQvkLygMRf4gig1E7d8SPqINqkER7ANoT3Yr
 MPzoiV1O1VuFLo19SHqT+iodT6FBy/5E2/vRqZWy5CkCdYRLT5sKgj28hzmKu0WCtC98PHK+D
 lPtW+uuq2FyDZ1iHTAEgLjkmDuKebSVD79pk3p7UQjmQCeMzxuGRneYm2nSWj2p8w2EfwAPOc
 XBEHoEeShHT3aHqNlGGqJxIOW7DY+m6qcv12OIkEqY7nVdx4Ly1gFBlmSsDtPocuKOZRy2PJB
 Fy3QKQe1H1DrAp3Se0iBj9XZGmWmHyY5vlk4dlp7ituXGIb6I/wYZSz8gvKVoIcZG0SMgLNrv
 PLdDzU6xESiQ8OCYC7RKjx5il4oeCWgM7ata492/Zpv5Uh9U7UKXMS3DQy8PeNgPDgCAvf5D3
 K1G1CaZ+Peg7ZQoq+0xrJFpi978F/ZUsqwOm3ENSWIUrpphhC1Y9m2mfk/fCl4X1FMbigEfo7
 BLDNhCMhS0SNTmcpjk+q3bbIJs2DQ0j21SJ4I/TFMECmBXTo8XYEjny9WNcNJmvQN5q+Ip0O8
 yz2bQBODhokIF3WjM9VB9z+18AEr16iduJ+tuy7IQ8LYT35ybqQ4JK5XLmcWuI4S3g7sS/MDv
 PnYCdu59F0yD+EbGcfpKzH6MolQJe3zfF+TlF+GLc6HpHhLVR3d00k9jd1hX+a/0hn+Ip5JRw
 u1goK3cGlYdNdBMDW79vV8Ai7DYIma/GHTGFzMI9yihIfoUKtmYbfkEavyZEPyELUIJrv0d
Received-SPF: none client-ip=212.227.126.135; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 02:53:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>,
 Fam Zheng <fam@euphon.net>, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Christian Borntraeger <borntraeger@de.ibm.com>

Fedora 32 gcc 10 seems to give false positives:

Compiling C object libblock.fa.p/block_vmdk.c.o
../block/vmdk.c: In function ‘vmdk_parse_extents’:
../block/vmdk.c:587:5: error: ‘extent’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
  587 |     g_free(extent->l1_table);
      |     ^~~~~~~~~~~~~~~~~~~~~~~~
../block/vmdk.c:754:17: note: ‘extent’ was declared here
  754 |     VmdkExtent *extent;
      |                 ^~~~~~
../block/vmdk.c:620:11: error: ‘extent’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
  620 |     ret = vmdk_init_tables(bs, extent, errp);
      |           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../block/vmdk.c:598:17: note: ‘extent’ was declared here
  598 |     VmdkExtent *extent;
      |                 ^~~~~~
../block/vmdk.c:1178:39: error: ‘extent’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
 1178 |             extent->flat_start_offset = flat_offset << 9;
      |             ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~
../block/vmdk.c: In function ‘vmdk_open_vmdk4’:
../block/vmdk.c:581:22: error: ‘extent’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
  581 |     extent->l2_cache =
      |     ~~~~~~~~~~~~~~~~~^
  582 |         g_malloc(extent->entry_size * extent->l2_size * L2_CACHE_SIZE);
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../block/vmdk.c:872:17: note: ‘extent’ was declared here
  872 |     VmdkExtent *extent;
      |                 ^~~~~~
../block/vmdk.c: In function ‘vmdk_open’:
../block/vmdk.c:620:11: error: ‘extent’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
  620 |     ret = vmdk_init_tables(bs, extent, errp);
      |           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../block/vmdk.c:598:17: note: ‘extent’ was declared here
  598 |     VmdkExtent *extent;
      |                 ^~~~~~
cc1: all warnings being treated as errors
make: *** [Makefile.ninja:884: libblock.fa.p/block_vmdk.c.o] Error 1

fix them by assigning a default value.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Fam Zheng <fam@euphon.net>
Message-Id: <20200930155859.303148-2-borntraeger@de.ibm.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 block/vmdk.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/vmdk.c b/block/vmdk.c
index 8ec62c7ab798..a00dc00eb47a 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -595,7 +595,7 @@ static int vmdk_open_vmfs_sparse(BlockDriverState *bs,
     int ret;
     uint32_t magic;
     VMDK3Header header;
-    VmdkExtent *extent;
+    VmdkExtent *extent = NULL;
 
     ret = bdrv_pread(file, sizeof(magic), &header, sizeof(header));
     if (ret < 0) {
@@ -751,7 +751,7 @@ static int vmdk_open_se_sparse(BlockDriverState *bs,
     int ret;
     VMDKSESparseConstHeader const_header;
     VMDKSESparseVolatileHeader volatile_header;
-    VmdkExtent *extent;
+    VmdkExtent *extent = NULL;
 
     ret = bdrv_apply_auto_read_only(bs,
             "No write support for seSparse images available", errp);
@@ -869,7 +869,7 @@ static int vmdk_open_vmdk4(BlockDriverState *bs,
     uint32_t magic;
     uint32_t l1_size, l1_entry_sectors;
     VMDK4Header header;
-    VmdkExtent *extent;
+    VmdkExtent *extent = NULL;
     BDRVVmdkState *s = bs->opaque;
     int64_t l1_backup_offset = 0;
     bool compressed;
@@ -1088,7 +1088,7 @@ static int vmdk_parse_extents(const char *desc, BlockDriverState *bs,
     BdrvChild *extent_file;
     BdrvChildRole extent_role;
     BDRVVmdkState *s = bs->opaque;
-    VmdkExtent *extent;
+    VmdkExtent *extent = NULL;
     char extent_opt_prefix[32];
     Error *local_err = NULL;
 
-- 
2.26.2


