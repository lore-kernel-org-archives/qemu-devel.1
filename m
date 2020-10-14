Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72724C43467
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 16:06:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE94E22247
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 16:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YWdzx0ul"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE94E22247
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSjHw-0001d1-Fv
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 12:06:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58386)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSjBK-0004dV-95
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 11:59:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24918)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSjBA-0000x1-Gf
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 11:59:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602691141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IaWnoSHk3gYww0GtxO3QwPtbarT6V9nMm5FHP0y80Lw=;
 b=YWdzx0ulpOzbtdmuh1rSfcF08o0gCdL4Y2RyJGUpn2omqNl8kqJtR0g7GmH6Uc8yRmduXO
 ag0VRh8yZiYdqMv9jaDPbeC2a6kKWWL2nPx7+Q0TBx6bxRYvW+4dBh3RaYQm8FEMVBGo/r
 tMAXEo2ZmUM+LCwzVqDL6MsrCNwmILM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-z81Y_vLOOUyK8mNOwX04kQ-1; Wed, 14 Oct 2020 11:58:59 -0400
X-MC-Unique: z81Y_vLOOUyK8mNOwX04kQ-1
Received: by mail-wr1-f72.google.com with SMTP id 33so1541704wrk.12
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 08:58:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IaWnoSHk3gYww0GtxO3QwPtbarT6V9nMm5FHP0y80Lw=;
 b=OqMO8/UwQpd0Cc8PaBDSR6YzbMc/gm61c5TXccLwLPyghOehnb9z55dPRIN4O1SRDG
 UqmNosWXPXyMDC732jfYPSReWw+TBBvtpzxeQIDPmLVmPSWnjAS/zNpDcWtaO6/3uS11
 GWp+ruM962w/0DBhz6vLAMIahvQXF1fpXGYuQ0o6iHcQTy2+Cdkm6uCw5Prm+opOkxhH
 OjgRyIWSHhZ0Lv8HXb8L9ZpvtlofuQS7lLcsvjV6CWXTZ9cYGgOACRS1ulDevlgfiwiT
 eLI1eIs5IoQ+7jaqKiijZXGcMbc31Q+fA0osoqQ7sQpcwEHrrql39fuDBiFjrNhpzfyc
 5B8Q==
X-Gm-Message-State: AOAM5322STNibxELKoLvrqVT7i52mgip/Ey/8bq0pnN7ut0B4SQSWj/Q
 ZT0PT43GRqiUpbX6nYYYc++6zWD2efh/dJIuzn1cZyoSfgQwyHSpn8NMr04xiKbWQRu0xmIqfiJ
 ZRgitV5YKb2RHrOs=
X-Received: by 2002:a05:600c:247:: with SMTP id 7mr101662wmj.7.1602691138017; 
 Wed, 14 Oct 2020 08:58:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzUb/GZ2L+BC8kA6ML62LH0sRSc955uVJLtoZrNm8wY5pELMs3TXDh/+XNcVTuuaLPHlxspUw==
X-Received: by 2002:a05:600c:247:: with SMTP id 7mr101648wmj.7.1602691137864; 
 Wed, 14 Oct 2020 08:58:57 -0700 (PDT)
Received: from x1w.redhat.com (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id y14sm53247wma.48.2020.10.14.08.58.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2020 08:58:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/15] block/nvme: Introduce Completion Queue definitions
Date: Wed, 14 Oct 2020 17:58:04 +0200
Message-Id: <20201014155810.102841-10-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201014155810.102841-1-philmd@redhat.com>
References: <20201014155810.102841-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 01:12:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Rename Submission Queue flags with 'Sq' and introduce
Completion Queue flag definitions.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/block/nvme.h | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/include/block/nvme.h b/include/block/nvme.h
index 65e68a82c89..079f884a2d3 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -491,6 +491,11 @@ typedef struct QEMU_PACKED NvmeCreateCq {
 #define NVME_CQ_FLAGS_PC(cq_flags)  (cq_flags & 0x1)
 #define NVME_CQ_FLAGS_IEN(cq_flags) ((cq_flags >> 1) & 0x1)
 
+enum NvmeFlagsCq {
+    NVME_CQ_PC          = 1,
+    NVME_CQ_IEN         = 2,
+};
+
 typedef struct QEMU_PACKED NvmeCreateSq {
     uint8_t     opcode;
     uint8_t     flags;
@@ -508,12 +513,12 @@ typedef struct QEMU_PACKED NvmeCreateSq {
 #define NVME_SQ_FLAGS_PC(sq_flags)      (sq_flags & 0x1)
 #define NVME_SQ_FLAGS_QPRIO(sq_flags)   ((sq_flags >> 1) & 0x3)
 
-enum NvmeQueueFlags {
-    NVME_Q_PC           = 1,
-    NVME_Q_PRIO_URGENT  = 0,
-    NVME_Q_PRIO_HIGH    = 1,
-    NVME_Q_PRIO_NORMAL  = 2,
-    NVME_Q_PRIO_LOW     = 3,
+enum NvmeFlagsSq {
+    NVME_SQ_PC          = 1,
+    NVME_SQ_PRIO_URGENT = 0,
+    NVME_SQ_PRIO_HIGH   = 1,
+    NVME_SQ_PRIO_NORMAL = 2,
+    NVME_SQ_PRIO_LOW    = 3,
 };
 
 typedef struct QEMU_PACKED NvmeIdentify {
-- 
2.26.2


