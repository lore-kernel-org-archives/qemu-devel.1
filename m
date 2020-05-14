Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99325C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:21:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F0942065D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uutq3RVH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F0942065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZEkD-0002Xv-GG
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 10:21:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38478)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jZEct-0007bp-2y
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:14:19 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133]:35406)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jZEcr-0003nB-VS
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:14:18 -0400
Received: by mail-lf1-x133.google.com with SMTP id 82so1260364lfh.2
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 07:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=33o9ClpGyupXXLqwHgoHcaDQTUDIPIIMyTSVPvtJZEc=;
 b=uutq3RVH7zPbqHB6ai50O8n6vm0E4YiQuOFrZ015Z7ZsW0dRpxB0Qkwx6i6btwOoz/
 dohUpNvBgD0IJJVsmW5BS0yefyhRpx3vdASr0ZPPJUBuWLQ9W1KOJ2Uu/ORSZyeQPa8z
 hDQxeKWDH+Uq61I7Nx+I0PR32zRYQdM8TmWCBvpLvFvaIa8AqFk8616ZH5LmXpi7unkB
 0CGp/zXE+TTfud90p9L3Eqh60wi8D0qWBEWP5vedAym+n2Ub1k00JSy1vmKa5REh3Wan
 gNsZhDSbsJQbte3cPKXgjqtAX1FVWaSu3JXwTGPD7GaDwoqUUC237rvWP4r4VfEGQ/3o
 0SQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=33o9ClpGyupXXLqwHgoHcaDQTUDIPIIMyTSVPvtJZEc=;
 b=ivZMx6h8PHVmx0DaUqj/HEvdtKQ7D/nLdgjBaDaC3QoVUysYVxsGrDlzw3FA+uwItC
 QVQbhzxUbR+jxZGHDl8uLGLUMWAm1zfxZPruPkgX9cdYnrN/1xOhRkSjT9n1/wgA/T75
 pSFYhTMlhfudLNzv+Sze66BusfopEqrntSG+BD8nKTCjwtxg/07ykcojIHqM2sIOyK9h
 2J6cKKx7EPAvg6TtnOHgu8XXoUHebW5v2novkXZqkT4gv+LrLlxTcwbCXaM5EZtVSNZp
 IWv9Yxy6qGZPkgROWG7MRmGeaoknEjqq+j2qf0KF7lNYWRO2g0peT/eyN9Iq+mnSitCR
 GtAA==
X-Gm-Message-State: AOAM531kN4PuCE9fjGKFJcwp6D2lBIEbdCyIWLAT7ski61sx7UnzfLea
 3Ow+z89L+JgqXXre+1+poKeAaN49Ni0=
X-Google-Smtp-Source: ABdhPJzWf6900RpaZYQX05hB8+caMK794sMDo5X5rbFODM2Road1BHheEK/FtJ7pvRYxrn4YE6GABw==
X-Received: by 2002:a05:6512:1051:: with SMTP id
 c17mr3488951lfb.206.1589465656105; 
 Thu, 14 May 2020 07:14:16 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id f24sm1878522lfc.43.2020.05.14.07.14.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2020 07:14:15 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PULL v1 09/14] MAINTAINERS: Add myself as streams maintainer
Date: Thu, 14 May 2020 16:13:57 +0200
Message-Id: <20200514141402.12498-10-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514141402.12498-1-edgar.iglesias@gmail.com>
References: <20200514141402.12498-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x133.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 13
X-Spam_score: 1.3
X-Spam_bar: +
X-Spam_report: (1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FSL_HELO_FAKE=3.399, RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: edgar.iglesias@xilinx.com, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Since we're missing a maintainer, add myself.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20200506082513.18751-10-edgar.iglesias@gmail.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 005ee98a59..d11f3cb976 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2315,6 +2315,12 @@ F: net/slirp.c
 F: include/net/slirp.h
 T: git https://people.debian.org/~sthibault/qemu.git slirp
 
+Streams
+M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
+S: Maintained
+F: hw/core/stream.c
+F: include/hw/stream.h
+
 Stubs
 M: Paolo Bonzini <pbonzini@redhat.com>
 S: Maintained
-- 
2.20.1


