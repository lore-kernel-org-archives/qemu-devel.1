Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C76E1C2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 09:42:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E14F52076B
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 09:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QvZbEF6A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E14F52076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY4SE-0001le-QD
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 05:42:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60302)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kY4K6-0006ZF-MW
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 05:34:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30323)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kY4K2-0006eG-2N
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 05:34:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603964057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rby//ZoQW9S03FtYoV9vfiisbCFRimYXfnLqhWXSPDA=;
 b=QvZbEF6AivVKlTdq0lWq2MyLyR9lZmYTivWIABVIw+O0sllezRjj0uVg9BedgNAfsxAMVq
 8yE1WH+0N2iKO4u3j5v5deH1luIwdFxl92EHauYZMxxhC68PZb+vx3Uw3UFpDehgC7joQC
 X1YSBktOF3StWAMjKLBEWwUZUj/IYjY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-2v8EEPDBO5OsEcIVlkowgw-1; Thu, 29 Oct 2020 05:34:15 -0400
X-MC-Unique: 2v8EEPDBO5OsEcIVlkowgw-1
Received: by mail-ej1-f71.google.com with SMTP id x12so919111eju.22
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 02:34:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rby//ZoQW9S03FtYoV9vfiisbCFRimYXfnLqhWXSPDA=;
 b=Jq7f9rYwhBObgPNJ2MVfXh/X88nXvdCGdg3tLs7XQUIChW3rAaFKn0iE0uzUnatdAJ
 MT2y2HZ3+4EQ63BUljb3Ko34sw1LBuIdNPXkim7fRePr8Z88AnSD0zXjc1khtd8xoEJm
 d+a2yIYpcvs0pxkMx/0fDcmAsGNRIEiYXAeRmOpO2ZMJ4i+yqE9QSz2IKq2jsIWO2uyJ
 XrAZX5meKfYkjpXSwcVLTNEoBvvEd+OceawdV0HyKYTm4HJSP4G6oaELaBs+DOKODca0
 258rBgflUNxMmmARuIMVTueBPDAWx4fbCRJmozASky6z38HhgVmcu2iEbdZjk7fyt5Kj
 POfA==
X-Gm-Message-State: AOAM5300EQNA+6lY3JlPI+5BJMW+RJoaVBN8Xk8aqwEszKhft1Ot1uL/
 Ky3iIJVU+HpjIPVrlTI5stR6TBogcMtcwRGkC0W1ietfXSgDaZMOZI+0nNRjfx/mcpziklpL/la
 mh0xlu1Filyg5ApI=
X-Received: by 2002:aa7:db07:: with SMTP id t7mr3066317eds.161.1603964053891; 
 Thu, 29 Oct 2020 02:34:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyJ0kdNF1Qc1dmy/i0wEBvojqnfi6haarp1JXLZ5a3wlyMNBoVkGSKDdNY5Kfbi2K2Yo5WUEw==
X-Received: by 2002:aa7:db07:: with SMTP id t7mr3066301eds.161.1603964053749; 
 Thu, 29 Oct 2020 02:34:13 -0700 (PDT)
Received: from x1w.redhat.com (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id j3sm1186945edh.25.2020.10.29.02.34.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2020 02:34:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 v2 12/25] block/nvme: Introduce Completion Queue
 definitions
Date: Thu, 29 Oct 2020 10:32:53 +0100
Message-Id: <20201029093306.1063879-13-philmd@redhat.com>
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

Rename Submission Queue flags with 'Sq' to differentiate
submission queue flags from command queue flags, and introduce
Completion Queue flag definitions.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/block/nvme.h | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/include/block/nvme.h b/include/block/nvme.h
index 65e68a82c89..c7ab9449125 100644
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
@@ -508,12 +513,13 @@ typedef struct QEMU_PACKED NvmeCreateSq {
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
+
+    NVME_SQ_PRIO_URGENT = 0,
+    NVME_SQ_PRIO_HIGH   = 1,
+    NVME_SQ_PRIO_NORMAL = 2,
+    NVME_SQ_PRIO_LOW    = 3,
 };
 
 typedef struct QEMU_PACKED NvmeIdentify {
-- 
2.26.2


