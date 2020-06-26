Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA62C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 21:00:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 147D82070A
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 21:00:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 147D82070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jovSX-0000nB-9v
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 17:00:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38552)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jovRk-0000IP-8q; Fri, 26 Jun 2020 16:59:40 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:52965)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jovRh-00020v-KJ; Fri, 26 Jun 2020 16:59:40 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.275405|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.0239574-0.00820966-0.967833;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03306; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=9; RT=9; SR=0; TI=SMTPD_---.Ht1zpuE_1593205165; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.Ht1zpuE_1593205165)
 by smtp.aliyun-inc.com(10.147.41.120);
 Sat, 27 Jun 2020 04:59:26 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH 0/6] target/riscv: NaN-boxing for multiple precison
Date: Sat, 27 Jun 2020 04:59:11 +0800
Message-Id: <20200626205917.4545-1-zhiwei_liu@c-sky.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=121.197.200.217;
 envelope-from=zhiwei_liu@c-sky.com; helo=smtp2200-217.mail.aliyun.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 16:59:26
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, UNPARSEABLE_RELAY=0.001 autolearn=_AUTOLEARN
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
Cc: richard.henderson@linaro.org, wxy194768@alibaba-inc.com,
 wenmeng_zhang@c-sky.com, Alistair.Francis@wdc.com, palmer@dabbelt.com,
 LIU Zhiwei <zhiwei_liu@c-sky.com>, ianjiang.ict@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Multiple precison shoule be supported by NaN-boxing. That means, we should
flush not valid NaN-boxing input to canonical NaN before effective
calculation and we should NaN-boxing the result after the effective
calculation.

In this patch set, split the implementation to three steps for compute,
sign-injection, and some covert insns, which are check_nanboxed,
effective calculation and gen_nanbox_fpr.

Check_nanboxed checks the inputs and flushes not valid inputs to cancical NaN.
Effective calculation is direct calculation on fp32 values.
Gen_nanbox_fpr does the NaN-boxing, writing the 1s to upper 32 bits.

LIU Zhiwei (6):
  target/riscv: move gen_nanbox_fpr to translate.c
  target/riscv: NaN-boxing compute, sign-injection and convert
    instructions.
  target/riscv: Check for LEGAL NaN-boxing
  target/riscv: check before allocating TCG temps
  target/riscv: Flush not valid NaN-boxing input to canonical NaN
  target/riscv: clean up fmv.w.x

 target/riscv/insn_trans/trans_rvd.inc.c |  16 +-
 target/riscv/insn_trans/trans_rvf.inc.c | 317 +++++++++++++++++++-----
 target/riscv/translate.c                |  43 ++++
 3 files changed, 306 insertions(+), 70 deletions(-)

-- 
2.23.0


