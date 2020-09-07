Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 558B3C43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 11:36:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A84E420C09
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 11:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RKUVVGiF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A84E420C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFFRs-0006r9-Ib
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 07:36:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60110)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kFF3I-0004JB-KH
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 07:11:12 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:22478
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kFF3G-0008Kp-11
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 07:11:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599477069;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jZmxFjs+bpGsnSx6M/37FBiQP8l/oHoYbq9G1/MvBJ4=;
 b=RKUVVGiFP0i+ePETNCyJuvAVsqYSu0O+LNHvl0/98A2HPob1eOF9SWfBiUS/BM01OGtiVI
 v1ZZM3lE2k6lnChGvn9+AcNJBFuQ/MLCNj3Wmd0qZzSplBCU75JWaUIYucp+0W5UJCFTQh
 HmENZJ+a+hK4Im9X0LdT9SOH/hGbFaw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-556-zdQFwS7mOUaY8pHgFOsm1g-1; Mon, 07 Sep 2020 07:11:07 -0400
X-MC-Unique: zdQFwS7mOUaY8pHgFOsm1g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4C65980EF84;
 Mon,  7 Sep 2020 11:11:06 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-154.ams2.redhat.com
 [10.36.114.154])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4D6299CBA;
 Mon,  7 Sep 2020 11:11:05 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 63/64] block/nvme: Use generic NvmeBar structure
Date: Mon,  7 Sep 2020 13:09:35 +0200
Message-Id: <20200907110936.261684-64-kwolf@redhat.com>
In-Reply-To: <20200907110936.261684-1-kwolf@redhat.com>
References: <20200907110936.261684-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 03:05:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Commit f3c507adcd7 ("NVMe: Initial commit for new storage interface")
introduced the NvmeBar structure. Unfortunately in commit bdd6a90a9e5
("block: Add VFIO based NVMe driver") we duplicated it.

Apparently in commit a3d9a352d48 ("block: Move NVMe constants to
a separate header") we tried to unify headers but forgot to remove
the structure declared in the block/nvme.c source file.

Do it now, and remove the structure size check which is redundant
with the header check added in commit 74e18435c0e ("hw/block/nvme:
Align I/O BAR to 4 KiB").

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200904124130.583838-3-philmd@redhat.com>
Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
Reviewed-by: Fam Zheng <fam@euphon.net>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/nvme.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index c9c3fc02fe..a216cc407f 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -83,28 +83,10 @@ typedef struct {
 
 /* Memory mapped registers */
 typedef volatile struct {
-    struct {
-        uint64_t cap;
-        uint32_t vs;
-        uint32_t intms;
-        uint32_t intmc;
-        uint32_t cc;
-        uint32_t reserved0;
-        uint32_t csts;
-        uint32_t nssr;
-        uint32_t aqa;
-        uint64_t asq;
-        uint64_t acq;
-        uint32_t cmbloc;
-        uint32_t cmbsz;
-        uint8_t  reserved1[0xec0];
-        uint8_t  cmd_set_specfic[0x100];
-    } ctrl;
+    NvmeBar ctrl;
     uint32_t doorbells[];
 } NVMeRegs;
 
-QEMU_BUILD_BUG_ON(offsetof(NVMeRegs, doorbells) != 0x1000);
-
 #define INDEX_ADMIN     0
 #define INDEX_IO(n)     (1 + n)
 
-- 
2.25.4


