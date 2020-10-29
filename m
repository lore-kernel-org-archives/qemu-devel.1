Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C3AC2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 09:38:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57D932076B
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 09:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TBaEF3W2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57D932076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY4Nd-0003ws-8B
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 05:38:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60326)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kY4KA-0006kS-UW
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 05:34:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52869)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kY4K9-0006fV-9N
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 05:34:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603964064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PNbQLcT2YAtJ+9yj7XsSRTYSXNgUiMYhENGCKNffe1M=;
 b=TBaEF3W24N8HnYzXwazKR6IK5HLc1jXe92UhCZwF3S4Ef+8jlx2hBqON5J8n6KTpH0FAU5
 Y4NwNWXs22DIQdRz9lDYR6Ufpsy5FurQOqgZ/P+OoVAy85lB13p06QMr4WRcoWZvlDV48B
 Fl0twnMEFWp2Lq3RzTMPLdG0redTrKM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-NR3hA535Mey0QFCaRTQa3w-1; Thu, 29 Oct 2020 05:34:20 -0400
X-MC-Unique: NR3hA535Mey0QFCaRTQa3w-1
Received: by mail-ej1-f72.google.com with SMTP id d12so927924ejr.19
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 02:34:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PNbQLcT2YAtJ+9yj7XsSRTYSXNgUiMYhENGCKNffe1M=;
 b=pkSOWZ5aQNrTCVO7dp+u7MkQvPIXUy+JX8QXjJcLNK+ywhV9xK23TsDxDRoiyMkYlJ
 17+xe2FUYt/TNa3Lcvr418FNgermdbRRoaZxxoEWUZ15CgCGs6PNMhFF1e+UknaXANQS
 4DdN8vgeivAcp6P4j86UMMFHzWrH496vlIWn73VQKM+rkbui+c4+Qaud0fjg8MKZOySJ
 XcqO9p1BAFZj6jQiTUHvb3Er4fFtY2OGIx457Sx+yC40b7HYW8nr9w1KIMwuLDQLUUzk
 MnKwc+2304Z0VDAW8XLTsPnPq7hdHxQ+j/9eqOOESRb8GXpCkDpfWq9unzwAFsxbD6jb
 ShYQ==
X-Gm-Message-State: AOAM533mC9OCxCces1ZZoBCFGl0Fs4pyY4knSTndRyHGuzU+g0Xp/TaK
 hr3RL6aLEXCo/2HGk/Kt8tLquu+lueVL06w4+LdvaR4Xx75GIdLXZElaZByPR4E0q5oZ0763ZAz
 YCW1ENhYIVYK48l8=
X-Received: by 2002:a17:906:8812:: with SMTP id
 zh18mr2051843ejb.361.1603964059318; 
 Thu, 29 Oct 2020 02:34:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJylYXJSyM7Qt+84sBHsnm4K50hjTWnBMggbpI3PBnzvC4zqNWBBz+oNBhmZhvPC27GOKQDA1A==
X-Received: by 2002:a17:906:8812:: with SMTP id
 zh18mr2051828ejb.361.1603964059155; 
 Thu, 29 Oct 2020 02:34:19 -0700 (PDT)
Received: from x1w.redhat.com (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id w22sm1143778edu.15.2020.10.29.02.34.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2020 02:34:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 v2 13/25] block/nvme: Use definitions instead of magic
 values in add_io_queue()
Date: Thu, 29 Oct 2020 10:32:54 +0100
Message-Id: <20201029093306.1063879-14-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201029093306.1063879-1-philmd@redhat.com>
References: <20201029093306.1063879-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 01:47:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Eric Auger <eric.auger@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Replace magic values by definitions, and simplifiy since the
number of queues will never reach 64K.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 6eaba4e7039..7285bd2e271 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -652,6 +652,7 @@ static bool nvme_add_io_queue(BlockDriverState *bs, Error **errp)
     NvmeCmd cmd;
     unsigned queue_size = NVME_QUEUE_SIZE;
 
+    assert(n <= UINT16_MAX);
     q = nvme_create_queue_pair(s, bdrv_get_aio_context(bs),
                                n, queue_size, errp);
     if (!q) {
@@ -660,8 +661,8 @@ static bool nvme_add_io_queue(BlockDriverState *bs, Error **errp)
     cmd = (NvmeCmd) {
         .opcode = NVME_ADM_CMD_CREATE_CQ,
         .dptr.prp1 = cpu_to_le64(q->cq.iova),
-        .cdw10 = cpu_to_le32(((queue_size - 1) << 16) | (n & 0xFFFF)),
-        .cdw11 = cpu_to_le32(0x3),
+        .cdw10 = cpu_to_le32(((queue_size - 1) << 16) | n),
+        .cdw11 = cpu_to_le32(NVME_CQ_IEN | NVME_CQ_PC),
     };
     if (nvme_cmd_sync(bs, s->queues[INDEX_ADMIN], &cmd)) {
         error_setg(errp, "Failed to create CQ io queue [%u]", n);
@@ -670,8 +671,8 @@ static bool nvme_add_io_queue(BlockDriverState *bs, Error **errp)
     cmd = (NvmeCmd) {
         .opcode = NVME_ADM_CMD_CREATE_SQ,
         .dptr.prp1 = cpu_to_le64(q->sq.iova),
-        .cdw10 = cpu_to_le32(((queue_size - 1) << 16) | (n & 0xFFFF)),
-        .cdw11 = cpu_to_le32(0x1 | (n << 16)),
+        .cdw10 = cpu_to_le32(((queue_size - 1) << 16) | n),
+        .cdw11 = cpu_to_le32(NVME_SQ_PC | (n << 16)),
     };
     if (nvme_cmd_sync(bs, s->queues[INDEX_ADMIN], &cmd)) {
         error_setg(errp, "Failed to create SQ io queue [%u]", n);
-- 
2.26.2


