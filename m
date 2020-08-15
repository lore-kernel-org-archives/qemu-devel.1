Return-Path: <SRS0=PlQC=BZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97791C433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 15:23:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 624E22312E
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 15:23:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Wf9jQrrL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 624E22312E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6y1Y-0002nK-JN
	for qemu-devel@archiver.kernel.org; Sat, 15 Aug 2020 11:23:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33676)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@163.com>)
 id 1k6y0I-0000uN-NW; Sat, 15 Aug 2020 11:21:55 -0400
Received: from m12-15.163.com ([220.181.12.15]:36704)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liq3ea@163.com>)
 id 1k6y0E-0002d3-BW; Sat, 15 Aug 2020 11:21:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id; bh=DYWgwGOWxvXXl+rLYR
 ibBTA/Wz/8JdXJEH+FKv6wEmE=; b=Wf9jQrrLNt3k+YsDifALtID9/g3ZUzf70d
 zbeETqOrSEhhp+WIPnE0jS42uB/h8cQ1vXMWyc26HGD9e2x19K6zy9Z+e1IJwP1D
 IzVJXbgaA8i70ARHKfowIPFsbRUfjOWnokI3FIMsSwRm4rmTE4klOZYe4O61a0dF
 MVW+RW2/0=
Received: from localhost.localdomain (unknown [115.204.244.155])
 by smtp1 (Coremail) with SMTP id GdxpCgA3w4MF7zdfSkGDAA--.134S4;
 Sat, 15 Aug 2020 22:19:53 +0800 (CST)
From: Li Qiang <liq3ea@163.com>
To: hare@suse.com,
	pbonzini@redhat.com,
	fam@euphon.net
Subject: [PATCH 0/2] Fix the assert failure in scsi_dma_complete
Date: Sat, 15 Aug 2020 07:19:38 -0700
Message-Id: <20200815141940.44025-1-liq3ea@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: GdxpCgA3w4MF7zdfSkGDAA--.134S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7XF4rWr47GF4DJrWrurWrGrg_yoW3trc_G3
 s7Xw1kJwnxZry5KF109rs8ArWxJFZrta4qvr4IqrsrC34Syr1xG3yDC3s5Crn3Za1DCFn7
 G395ZrZ3Ars5XjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU1fgA3UUUUU==
X-Originating-IP: [115.204.244.155]
X-CM-SenderInfo: 5oltjvrd6rljoofrz/xtbBoQqBbVQHLOqJwgAAsZ
Received-SPF: pass client-ip=220.181.12.15; envelope-from=liq3ea@163.com;
 helo=m12-15.163.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/15 03:52:36
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

This is the LP#1878263:

-->https://bugs.launchpad.net/qemu/+bug/1878263

To solve this we will consider the 'iov_count=0' is an error.
In the first patch, I uses -1 to indicate an error and in the second
patch I consider 'iov_count=0' is an error.

Li Qiang (2):
  hw: megasas: return -1 when 'megasas_map_sgl' fails
  hw: megasas: consider 'iov_count=0' is an error in megasas_map_sgl

 hw/scsi/megasas.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.17.1


