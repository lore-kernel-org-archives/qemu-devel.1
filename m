Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBDCBECDE27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 06:37:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C52F3207FC
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 06:37:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C52F3207FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7wFZ-0000IQ-D6
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 02:37:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38372)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1i7wDU-0006xF-VQ
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 02:35:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1i7wDT-0007mT-Od
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 02:35:00 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:38070)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1i7wDT-0007j0-3d; Wed, 11 Sep 2019 02:34:59 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.05097853|-1; CH=green;
 DM=CONTINUE|CONTINUE|true|0.224129-0.0563248-0.719546; FP=0|0|0|0|0|-1|-1|-1;
 HT=e02c03310; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS; RN=11; RT=11; SR=0;
 TI=SMTPD_---.FSRFoMa_1568183689; 
Received: from localhost(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.FSRFoMa_1568183689)
 by smtp.aliyun-inc.com(10.147.42.197);
 Wed, 11 Sep 2019 14:34:49 +0800
From: liuzhiwei <zhiwei_liu@c-sky.com>
To: Alistair.Francis@wdc.com, palmer@sifive.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, riku.voipio@iki.fi, laurent@vivier.eu,
 wenmeng_zhang@c-sky.com
Date: Wed, 11 Sep 2019 14:25:24 +0800
Message-Id: <1568183141-67641-1-git-send-email-zhiwei_liu@c-sky.com>
X-Mailer: git-send-email 2.7.4
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 121.197.200.217
Subject: [Qemu-devel] [PATCH v2 00/17] RISC-V: support vector extension
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
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, wxy194768@alibaba-inc.com,
 liuzhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Features:
  * support specification riscv-v-spec-0.7.1(https://content.riscv.org/wp-content/uploads/2019/06/17.40-Vector_RISCV-20190611-Vectors.pdf).
  * support basic vector extension.                                                
  * support Zvlsseg.                                                               
  * support Zvamo.                                                                 
  * not support Zvediv as it is changing.
  * fixed VLEN 128bit.
  * fixed SLEN 128bit.
  * ELEN support 8bit, 16bit, 32bit, 64bit.

Todo:
  * support VLEN configure from qemu command line.
  * move check code from execution-time to translation-time

Changelog:
V2
  * use float16_compare{_quiet}
  * only use GETPC() in outer most helper
  * add ctx.ext_v Property


LIU Zhiwei (17):
  RISC-V: add vfp field in CPURISCVState
  RISC-V: turn on vector extension from command line by cfg.ext_v
    Property
  RISC-V: support vector extension csr
  RISC-V: add vector extension configure instruction
  RISC-V: add vector extension load and store instructions
  RISC-V: add vector extension fault-only-first implementation
  RISC-V: add vector extension atomic instructions
  RISC-V: add vector extension integer instructions part1,
    add/sub/adc/sbc
  RISC-V: add vector extension integer instructions part2, bit/shift
  RISC-V: add vector extension integer instructions part3, cmp/min/max
  RISC-V: add vector extension integer instructions part4, mul/div/merge
  RISC-V: add vector extension fixed point instructions
  RISC-V: add vector extension float instruction part1, add/sub/mul/div
  RISC-V: add vector extension float instructions part2,
    sqrt/cmp/cvt/others
  RISC-V: add vector extension reduction instructions
  RISC-V: add vector extension mask instructions
  RISC-V: add vector extension premutation instructions

 linux-user/riscv/cpu_loop.c             |     7 +
 target/riscv/Makefile.objs              |     2 +-
 target/riscv/cpu.c                      |     6 +-
 target/riscv/cpu.h                      |    30 +
 target/riscv/cpu_bits.h                 |    15 +
 target/riscv/cpu_helper.c               |     7 +
 target/riscv/csr.c                      |    65 +-
 target/riscv/helper.h                   |   358 +
 target/riscv/insn32.decode              |   373 +
 target/riscv/insn_trans/trans_rvv.inc.c |   490 +
 target/riscv/translate.c                |     1 +
 target/riscv/vector_helper.c            | 25701 ++++++++++++++++++++++++++++++
 12 files changed, 27049 insertions(+), 6 deletions(-)
 create mode 100644 target/riscv/insn_trans/trans_rvv.inc.c
 create mode 100644 target/riscv/vector_helper.c

-- 
2.7.4


