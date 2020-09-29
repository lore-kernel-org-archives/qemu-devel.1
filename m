Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD676C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 19:27:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28EB520774
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 19:27:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="P1cgQDzk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28EB520774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNLHV-0001Zp-2w
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 15:27:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44214)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1kNKxy-0005bK-04
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 15:07:10 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029]:39026)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1kNKxw-0002BT-Bh
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 15:07:09 -0400
Received: by mail-pj1-x1029.google.com with SMTP id v14so3176084pjd.4
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 12:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=2Aif9d1F/IPk9jawUAnM+54T7hc3c2YfAvxLfCtf8uE=;
 b=P1cgQDzkiXS1T1wWm/A9CUU9/KdyGPNPd81pJZJMNAZp2jLEwz/na+ItqYXOv6e9wQ
 qCk6Ipwno4A7B7cu9CqhvDCGOQnwznhiD/SqEe9NNkkcttmIeTHpR0hMlYaCcO19LzbU
 QlXn6JXdn4NmC3XR2NoWzTPmayfxq+rxYeykQoS0RuVEgM6aVKD0nJQhsj2Y9I/TtK5G
 X29VE6mLXVH45xUgx0+P9/NO6LWzf2eo6hIthjUm00CmE0Kt+/o6v82Vj7Vk0U/H7GX4
 KtrL60tVKRPjwvy4hp2nkt/umRPBZN5FvxOVLV7O0irzIVanBerD6x7jgz+eXsTWMn/o
 2iHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=2Aif9d1F/IPk9jawUAnM+54T7hc3c2YfAvxLfCtf8uE=;
 b=iNZOZRBDT3JheVtc0t4zhIBvhd07bStlH+OmaNkZ/Z7qhIwNEUGrLQS2m5Bk0O/6tA
 25Qt6kEhTxXbzatiJmvQfgNkW3MUsoPmXlIvbNuK3XZpzk07T9la0I6tf1k18z2wNIc8
 8F6qjm8E3bkQgtuSFyf1fV5TiLjA/SVBYjHsHBqHvG43/+lSyKhQk2MMpiKRt27/hhOT
 AAZuLCYPwnvFlBo3oWkzspuDiT+3MHdI1iVETNXMjN3Lj+2P5vWOnxVORzZfJZmHI08p
 nk3JpILh05+12/Lq87+l68fUi9DHLJR7FeOkSyhJ3+HMx1OAJdCXWQ7P9Cv8ywFsYa3A
 /RnA==
X-Gm-Message-State: AOAM531wvhPz+ce0s8JhCB45vbK/Pzbv4pmC67sz1ZT2jsQiKNxHplDi
 bqefgxoy0h/LHIg1/8uFdyXKZORBxAaZ1g==
X-Google-Smtp-Source: ABdhPJyNcXObmrOnRkAZcqA/5yj0TYV0++U2aqGAVS1pcnaVPUQWW2HZIHzH7Q2Z1n4cAf9YwAhXrQ==
X-Received: by 2002:a17:90a:1690:: with SMTP id
 o16mr5170879pja.148.1601406426712; 
 Tue, 29 Sep 2020 12:07:06 -0700 (PDT)
Received: from localhost.localdomain (122-116-72-36.HINET-IP.hinet.net.
 [122.116.72.36])
 by smtp.gmail.com with ESMTPSA id v8sm6003950pgg.58.2020.09.29.12.07.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 12:07:06 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v5 31/68] target/riscv: rvv-1.0: iota instruction
Date: Wed, 30 Sep 2020 03:04:06 +0800
Message-Id: <20200929190448.31116-32-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929190448.31116-1-frank.chang@sifive.com>
References: <20200929190448.31116-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=frank.chang@sifive.com; helo=mail-pj1-x1029.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Frank Chang <frank.chang@sifive.com>

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/insn32.decode | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 0fed7c9e56..33b4612a69 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -607,7 +607,7 @@ vfirst_m        010000 . ..... 10001 010 ..... 1010111 @r2_vm
 vmsbf_m         010100 . ..... 00001 010 ..... 1010111 @r2_vm
 vmsif_m         010100 . ..... 00011 010 ..... 1010111 @r2_vm
 vmsof_m         010100 . ..... 00010 010 ..... 1010111 @r2_vm
-viota_m         010110 . ..... 10000 010 ..... 1010111 @r2_vm
+viota_m         010100 . ..... 10000 010 ..... 1010111 @r2_vm
 vid_v           010110 . 00000 10001 010 ..... 1010111 @r1_vm
 vext_x_v        001100 1 ..... ..... 010 ..... 1010111 @r
 vmv_s_x         001101 1 00000 ..... 110 ..... 1010111 @r2
-- 
2.17.1


