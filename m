Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28BC8C4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 04:10:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59ADE208C3
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 04:10:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tGyHcqbs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59ADE208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ0mk-0002Oc-DG
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 00:10:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58968)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kQ0lH-0001Uc-Cb
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 00:09:07 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:38062)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kQ0lF-0007O5-6O
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 00:09:07 -0400
Received: by mail-wm1-x343.google.com with SMTP id v12so827500wmh.3
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 21:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=TT1TUmO44LCjCtXHOLpqxj04IhS53zSYbviDkOeqULc=;
 b=tGyHcqbsEBWk5HfIgcuftuRyR9ohP58hdlDMFS0c2TRdEwDRuDlgFnI7tHDIJ9MKBj
 FwzfkPWsrYgmD8OK5YS3jgEUDzbLeTa2R6MO8ltvKHRVgpu+kIjm1NvSFNjYRA5AYGCX
 /R/o4IKSaxpxP8USV8WC04gK8m9NPc5SYjhNhu7wsJsX3Rj78c7q8IDA18bN6s0HHxlj
 MP0kFqwfJod8xbxXtIQL1ohGtO0eixK8s3IfQ4MyasJClhH1ib5sQ3M+/TZF0nqsNHua
 uBMTL3Buh8xfRQ9EncmZ4Apk/Psy0ZZFuU7YFFFhIFBqSN5e7YuWELAPiCDFd2QqdKPp
 sa4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TT1TUmO44LCjCtXHOLpqxj04IhS53zSYbviDkOeqULc=;
 b=MtEvq7FZSjez+e2FdFZvJFAYYYuedY66ifR/QsQpK7dgQr9A7H0u+O9KERwhDQvuC7
 LTeU3y+EPoCw/m8s15IjphdcHY2eTbSNeGjjNB6NGwJDj8Ve8MnJbrIY45I5UrfBhleQ
 ERDOjGzSU1VsOCBcLBsfeA+Wf5B1AYFUeLjSh4PSGekwm0I0L5kRXgwKszN9q/GMIyfb
 Fa9vuK0KyZCLK0k6c4kC81BAnmnFogRSRimictMCQj4G1AJLksOv0gR/v8C1hXvWEtWk
 a4Ecg0jbJ/jQeQwZimhMeLkCzw7yINUVFcpsZKmdd7mqzKaZOdEcxt0876WS5uGk2erw
 O44w==
X-Gm-Message-State: AOAM530YhdiYlXMUBEgTuLTHbSrgvdwX/9mTsjc6860tPyiUxJTWqWSq
 VlLjfPR39OGPw0fnbyERcww=
X-Google-Smtp-Source: ABdhPJzBCXa3qbFu/pUK8rbFs83y9ZK2zy09kxcEqpqRao4H/HMbp3ROoYlfAoZDMSwV1HyibYcYaQ==
X-Received: by 2002:a1c:2108:: with SMTP id h8mr1000918wmh.63.1602043740560;
 Tue, 06 Oct 2020 21:09:00 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id 4sm1019486wrn.48.2020.10.06.21.08.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Oct 2020 21:08:59 -0700 (PDT)
Subject: Re: [PATCH 01/14] arc: Add initial core cpu files
To: cupertinomiranda@gmail.com, qemu-devel@nongnu.org
References: <20200930204604.20663-1-cupertinomiranda@gmail.com>
 <20200930204604.20663-2-cupertinomiranda@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ec923290-b6a1-00ab-030b-21676a36dae3@amsat.org>
Date: Wed, 7 Oct 2020 06:08:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200930204604.20663-2-cupertinomiranda@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.248,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Claudiu Zissulescu <claziss@gmail.com>,
 Shahab Vahedi <shahab.vahedi@gmail.com>, Shahab Vahedi <shahab@synopsys.com>,
 Cupertino Miranda <cmiranda@synopsys.com>, linux-snps-arc@lists.infradead.org,
 Claudiu Zissulescu <claziss@synopsys.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Cupertino,

On 9/30/20 10:45 PM, cupertinomiranda@gmail.com wrote:
> From: Cupertino Miranda <cmiranda@synopsys.com>
> 
> Signed-off-by: Cupertino Miranda <cmiranda@synopsys.com>
> ---
...

> diff --git a/target/arc/Makefile.objs b/target/arc/Makefile.objs
> new file mode 100644
> index 0000000000..7b2afd08e4
> --- /dev/null
> +++ b/target/arc/Makefile.objs
> @@ -0,0 +1,34 @@
> +#
> +#  QEMU ARC CPU
> +#
> +#  Copyright (c) 2020
> +#
> +#  This library is free software; you can redistribute it and/or
> +#  modify it under the terms of the GNU Lesser General Public
> +#  License as published by the Free Software Foundation; either
> +#  version 2.1 of the License, or (at your option) any later version.
> +#
> +#  This library is distributed in the hope that it will be useful,
> +#  but WITHOUT ANY WARRANTY; without even the implied warranty of
> +#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> +#  Lesser General Public License for more details.
> +#
> +#  You should have received a copy of the GNU Lesser General Public
> +#  License along with this library; if not, see
> +#  <http://www.gnu.org/licenses/lgpl-2.1.html>
> +#
> +
> +obj-y   += translate.o
> +obj-y   += helper.o
> +obj-y   += cpu.o
> +obj-y   += op_helper.o
> +obj-y   += gdbstub.o
> +obj-y   += decoder.o
> +obj-y   += regs.o
> +obj-y   += semfunc.o
> +obj-y   += semfunc-helper.o
> +obj-y   += mmu.o
> +obj-y   += mpu.o
> +obj-y   += timer.o
> +obj-y   += irq.o
> +obj-y   += cache.o

We don't use Makefiles anymore, and you already provides meson.build.

> diff --git a/target/arc/arc-common.h b/target/arc/arc-common.h
> new file mode 100644
> index 0000000000..8013e1d2ed
> --- /dev/null
> +++ b/target/arc/arc-common.h
> @@ -0,0 +1,55 @@
> +/*
> + *  Common header file to be used by cpu and disassembler.
> + *  Copyright (C) 2017 Free Software Foundation, Inc.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with GAS or GDB; see the file COPYING3. If not, write to
> + *  the Free Software Foundation, 51 Franklin Street - Fifth Floor, Boston,
> + *  MA 02110-1301, USA.
> + */
> +
> +#ifndef ARC_COMMON_H
> +#define ARC_COMMON_H
> +
> +#include "qemu/osdep.h"
...

Do not include "qemu/osdep.h" in headers.

> +/*-*-indent-tabs-mode:nil;tab-width:4;indent-line-function:'insert-tab'-*-*/
> +/* vim: set ts=4 sw=4 et: */
> diff --git a/target/arc/cpu-qom.h b/target/arc/cpu-qom.h
> new file mode 100644
> index 0000000000..413b693558
> --- /dev/null
> +++ b/target/arc/cpu-qom.h
> @@ -0,0 +1,53 @@
> +/*
> + * QEMU ARC CPU
> + *
> + * Copyright (c) 2016 Michael Rolnik

???

> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2.1 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see
> + * <http://www.gnu.org/licenses/lgpl-2.1.html>
> + */
> +
...

> diff --git a/target/arc/cpu.c b/target/arc/cpu.c
> new file mode 100644
> index 0000000000..bbcb371760
> --- /dev/null
> +++ b/target/arc/cpu.c
> @@ -0,0 +1,468 @@
> +/*
> + * QEMU ARC CPU
> + *
> + * Copyright (c) 2020

(c) Synopsys?

> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2.1 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see
> + * http://www.gnu.org/licenses/lgpl-2.1.html
> + */
...

> +/*-*-indent-tabs-mode:nil;tab-width:4;indent-line-function:'insert-tab'-*-*/
> +/* vim: set ts=4 sw=4 et: */
> diff --git a/target/arc/cpu.h b/target/arc/cpu.h
> new file mode 100644
> index 0000000000..e8446366e5
> --- /dev/null
> +++ b/target/arc/cpu.h
> @@ -0,0 +1,532 @@
> + /*
> +  * QEMU ARC CPU
> +  *
> +  * Copyright (c) 2020

Again.

> +  *
> +  * This library is free software; you can redistribute it and/or
> +  * modify it under the terms of the GNU Lesser General Public
> +  * License as published by the Free Software Foundation; either
> +  * version 2.1 of the License, or (at your option) any later version.
> +  *
> +  * This library is distributed in the hope that it will be useful,
> +  * but WITHOUT ANY WARRANTY; without even the implied warranty of
> +  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
> +  * Lesser General Public License for more details.
> +  *
> +  * You should have received a copy of the GNU Lesser General Public
> +  * License along with this library; if not, see
> +  * <http://www.gnu.org/licenses/lgpl-2.1.html>
> +  */
> +
> +#ifndef CPU_ARC_H
> +#define CPU_ARC_H
> +
...

> +
> +/*
> + * ArcCPU:
> + * @env: #CPUMBState
> + *
> + * An ARC CPU.
> + */
> +struct ARCCPU {
> +  /*< private >*/
> +  CPUState parent_obj;
> +
> +  /*< public >*/
> +
> +  /* ARC Configuration Settings. */
> +  struct {
> +    uint32_t addr_size;
> +    bool     aps_feature;
> +    bool     byte_order;
> +    bool     bitscan_option;
> +    uint32_t br_bc_entries;
> +    uint32_t br_pt_entries;
> +    bool     br_bc_full_tag;
> +    uint8_t  br_rs_entries;
> +    uint32_t br_bc_tag_size;
> +    uint8_t  br_tosq_entries;
> +    uint8_t  br_fb_entries;
> +    bool     code_density;
> +    bool     code_protect;
> +    uint8_t  dccm_mem_cycles;
> +    bool     dccm_posedge;
> +    uint8_t  dccm_mem_bancks;
> +    uint8_t  dc_mem_cycles;
> +    bool     dc_posedge;
> +    bool     dmp_unaligned;
> +    bool     ecc_exception;
> +    uint32_t external_interrupts;
> +    uint8_t  ecc_option;
> +    bool     firq_option;
> +    bool     fpu_dp_option;
> +    bool     fpu_fma_option;
> +    bool     fpu_div_option;
> +    bool     has_actionpoints;
> +    bool     has_fpu;
> +    bool     has_interrupts;
> +    bool     has_mmu;
> +    bool     has_mpu;
> +    bool     has_timer_0;
> +    bool     has_timer_1;
> +    bool     has_pct;
> +    bool     has_rtt;
> +    bool     has_smart;
> +    uint32_t intvbase_preset;
> +    uint32_t lpc_size;
> +    uint8_t  mpu_num_regions;
> +    uint8_t  mpy_option;
> +    uint32_t mmu_page_size_sel0;
> +    uint32_t mmu_page_size_sel1;
> +    uint32_t mmu_pae_enabled;
> +    uint32_t ntlb_num_entries;
> +    uint32_t num_actionpoints;
> +    uint32_t number_of_interrupts;
> +    uint32_t number_of_levels;
> +    uint32_t pct_counters;
> +    uint32_t pct_interrupt;
> +    uint32_t pc_size;
> +    uint32_t rgf_num_regs;

Maybe use 'unsigned' for numbers (various uses).

> +    uint32_t rgf_banked_regs;
> +    uint32_t rgf_num_banks;
> +    bool     rtc_option;
> +    uint32_t rtt_feature_level;
> +    bool     stack_checking;
> +    bool     swap_option;
> +    uint32_t smar_stack_entries;
> +    uint32_t smart_implementation;
> +    uint32_t stlb_num_entries;
> +    uint32_t slc_size;
> +    uint32_t slc_line_size;
> +    uint32_t slc_ways;
> +    uint32_t slc_tag_banks;
> +    uint32_t slc_tram_delay;
> +    uint32_t slc_dbank_width;
> +    uint32_t slc_data_banks;
> +    uint32_t slc_dram_delay;
> +    bool     slc_mem_bus_width;
> +    uint32_t slc_ecc_option;
> +    bool     slc_data_halfcycle_steal;
> +    bool     slc_data_add_pre_pipeline;
> +    bool     uaux_option;
> +    uint32_t freq_hz; /* CPU frequency in hz, needed for timers. */
> +  } cfg;
> +
[...]
Regards,

Phil.

