Return-Path: <SRS0=PlQC=BZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D95C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 15:25:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9282523A78
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 15:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="dMWk640t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9282523A78
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6y3a-0005t4-Ra
	for qemu-devel@archiver.kernel.org; Sat, 15 Aug 2020 11:25:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33862)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@163.com>)
 id 1k6y0X-00010p-Oc; Sat, 15 Aug 2020 11:22:09 -0400
Received: from m12-16.163.com ([220.181.12.16]:33856)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liq3ea@163.com>)
 id 1k6y0S-0002gv-3U; Sat, 15 Aug 2020 11:22:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id; bh=q3vzNOSRd+lMhnoEh3
 YEXZ1Y413ZtAnFXeZsmgnFmVo=; b=dMWk640tgwuJlwFyl7xRPbQObRHRkQOuxQ
 fbf9mCzkLvXRPPN3hEMRKC6ZX6cR5WDm2RKlYZ8mon++O392gj1ffEMR5i6L2krd
 Q7ylYRZbXdHflFWxvGGYvDhgzDTnQqA0So7/xkLrmKNlXiPj42KKh761YQFprY1t
 HrMnlyxAc=
Received: from localhost.localdomain (unknown [115.204.244.155])
 by smtp1 (Coremail) with SMTP id GdxpCgA3w4MF7zdfSkGDAA--.134S6;
 Sat, 15 Aug 2020 22:20:06 +0800 (CST)
From: Li Qiang <liq3ea@163.com>
To: hare@suse.com,
	pbonzini@redhat.com,
	fam@euphon.net
Subject: [PATCH 2/2] hw: megasas: consider 'iov_count=0' is an error in
 megasas_map_sgl
Date: Sat, 15 Aug 2020 07:19:40 -0700
Message-Id: <20200815141940.44025-3-liq3ea@163.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200815141940.44025-1-liq3ea@163.com>
References: <20200815141940.44025-1-liq3ea@163.com>
X-CM-TRANSID: GdxpCgA3w4MF7zdfSkGDAA--.134S6
X-Coremail-Antispam: 1Uf129KBjvdXoW7XF4rWr47GF4DJrWrurWrGrg_yoWkCwc_Cw
 1kX397XF4qqr4IgrySkrsxAr1IgwnFvFyDArsaq3srAw1xta4xKa1DZ340van3J39ruFn8
 GrZaqrZxArs8ZjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8leHDUUUUU==
X-Originating-IP: [115.204.244.155]
X-CM-SenderInfo: 5oltjvrd6rljoofrz/xtbBoRaBbVQHLOqKKQAAst
Received-SPF: pass client-ip=220.181.12.16; envelope-from=liq3ea@163.com;
 helo=m12-16.163.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/15 04:08:01
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Li Qiang <liq3ea@163.com>, liq3ea@gmail.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently in 'megasas_map_sgl' when 'iov_count=0' will just return
success however the 'cmd' doens't contain any iov. This will cause
the assert in 'scsi_dma_complete' failed. This is because in
'dma_blk_cb' the 'dbs->sg_cur_index == dbs->sg->nsg' will be true
and just call 'dma_complete'. However now there is no aiocb returned.

This fixes the LP#1878263:

-->https://bugs.launchpad.net/qemu/+bug/1878263

Reported-by: Alexander Bulekov <alxndr@bu.edu>
Signed-off-by: Li Qiang <liq3ea@163.com>
---
 hw/scsi/megasas.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
index d6c9680c36..9562c58a2d 100644
--- a/hw/scsi/megasas.c
+++ b/hw/scsi/megasas.c
@@ -278,7 +278,7 @@ static int megasas_map_sgl(MegasasState *s, MegasasCmd *cmd, union mfi_sgl *sgl)
 
     cmd->flags = le16_to_cpu(cmd->frame->header.flags);
     iov_count = cmd->frame->header.sge_count;
-    if (iov_count > MEGASAS_MAX_SGE) {
+    if (!iov_count || iov_count > MEGASAS_MAX_SGE) {
         trace_megasas_iovec_sgl_overflow(cmd->index, iov_count,
                                          MEGASAS_MAX_SGE);
         return -1;
-- 
2.17.1


