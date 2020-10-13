Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776D5C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 15:04:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA3CC248CD
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 15:04:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eG1/wyzN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA3CC248CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSLqz-0008LN-Mw
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 11:04:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48260)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cupertinomiranda@gmail.com>)
 id 1kSLqI-0007t5-Q7
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 11:03:58 -0400
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44]:39486)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cupertinomiranda@gmail.com>)
 id 1kSLqF-0006ce-O1
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 11:03:58 -0400
Received: by mail-yb1-xb44.google.com with SMTP id 67so16419270ybt.6
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 08:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=C1lIxdLSAJNZiDrZrteSbP8Votl5sLNkiRnUCw53idE=;
 b=eG1/wyzNoWVTSYQILLVqLAbA/PweOuNe1MDe0AXPUAOIgM5BTqkFdskH2C+KDvPuBF
 jaqoBmdylvcL/8gb/kY2UDJEgVFqvO/HayNbyfYwJ11vu1SPW8i2VRvtcrbljzCaqznd
 eApAzVJp/rQIEtv9VGqg5L0YW6C5/NroGoME1tuEptdbviqsIWhrl1vP9po0JAPv41QN
 HTNGWNW2oAs53dlKWv2Na7WHqJUR37B9vwueEwP4+6s+2OimBSec2U2E6RQDApJI6pa/
 LEskNWqiJAVnMWCfc2knvkx5FAlzGmkiOMofyN7B9OYY0p7Fml5UyhSPyDdtt4h5equ0
 ef7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=C1lIxdLSAJNZiDrZrteSbP8Votl5sLNkiRnUCw53idE=;
 b=oS3cWdOhAoovXbXH5WdPXqrRNaMvT3JamRfcp9iLoG8MXSfk+voifc/dxM/mdzlIED
 YokUvqdFxnaJ2DU9/wvumvADx+mYfyEH/1y/5tsJWY+E2ngKR1J5rdWjF7xRYk1mnvAi
 98k2UTN8rIANrS3e+OKzOKv8hmOyCtkLxCqHxE5yLO1UWj+InDhSuO9rjZo8fU60uvIf
 xFoEVI7re98O/WM1mjPK1f0znUAJ8CV5BLiRq0yAriVljug0Iv4Hiz6AIPmJBPqJFBRq
 KP23ZyRLmkl9FtKSSwWuuZ0OwDe1pA73sAa5z0Ou8tX5TdbFpe/Ynkzz3c7m8bx8dc6U
 y1kw==
X-Gm-Message-State: AOAM532t3T81eLNCPImLLP9y4wCsViRckHVr6+0uTTdQZYESPdB9J7KP
 lPDe4gS8bCiuDmK51UcYsef783accil1faTGijg=
X-Google-Smtp-Source: ABdhPJxctQQrHLm/m6EoHMGbpkIIA3Tqm8uhM3dimzVG6Cp4eYKaxwlc14gcl/+w21Vh5i3BiHwpFUrL9MMk4fkobNA=
X-Received: by 2002:a05:6902:50e:: with SMTP id
 x14mr341690ybs.273.1602601430798; 
 Tue, 13 Oct 2020 08:03:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200930204604.20663-1-cupertinomiranda@gmail.com>
 <20200930204604.20663-2-cupertinomiranda@gmail.com>
 <ec923290-b6a1-00ab-030b-21676a36dae3@amsat.org>
In-Reply-To: <ec923290-b6a1-00ab-030b-21676a36dae3@amsat.org>
From: Cupertino Miranda <cupertinomiranda@gmail.com>
Date: Tue, 13 Oct 2020 16:03:39 +0100
Message-ID: <CAHW_PjJwjRqJ7stiOfb15wgUncMOeBoEsDg_GtRzEi6WOW+0Pg@mail.gmail.com>
Subject: Re: [PATCH 01/14] arc: Add initial core cpu files
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b44;
 envelope-from=cupertinomiranda@gmail.com; helo=mail-yb1-xb44.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Claudiu Zissulescu <claziss@gmail.com>, qemu-devel@nongnu.org,
 Shahab Vahedi <shahab.vahedi@gmail.com>, Shahab Vahedi <shahab@synopsys.com>,
 Cupertino Miranda <cmiranda@synopsys.com>, linux-snps-arc@lists.infradead.org,
 Claudiu Zissulescu <claziss@synopsys.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Philippe,

Thank you for your time reviewing our patches.
My apologies for reacting to it so late. :-(

Once we decided to make this port we noticed that Michael Rolnik had
submitt a port for ARC700 to QEMU mailinglist.
As we tested it, we decided to use his directory structure, and for
that reason the most generic files as well, although significantly
changing everything else.

As a way to credit him for the initial work, we left his copyright
header in that file. Maybe that should instead mention him in the
commits, or in the cover letter instead. Please let me know of the
proper way.

Regarding "unsigned", some of these variables are used as "auxiliary
registers" and should at least be 32bit. Some others might perfectly
well be resized to "unsigned".We will certainly revisit these
definitions to make sure we use the proper types for the case.

Regards,
Cupertino



On Wed, Oct 7, 2020 at 5:09 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
> wrote:
>
> Hi Cupertino,
>
> On 9/30/20 10:45 PM, cupertinomiranda@gmail.com wrote:
> > From: Cupertino Miranda <cmiranda@synopsys.com>
> >
> > Signed-off-by: Cupertino Miranda <cmiranda@synopsys.com>
> > ---
> ...
>
> > diff --git a/target/arc/Makefile.objs b/target/arc/Makefile.objs
> > new file mode 100644
> > index 0000000000..7b2afd08e4
> > --- /dev/null
> > +++ b/target/arc/Makefile.objs
> > @@ -0,0 +1,34 @@
> > +#
> > +#  QEMU ARC CPU
> > +#
> > +#  Copyright (c) 2020
> > +#
> > +#  This library is free software; you can redistribute it and/or
> > +#  modify it under the terms of the GNU Lesser General Public
> > +#  License as published by the Free Software Foundation; either
> > +#  version 2.1 of the License, or (at your option) any later version.
> > +#
> > +#  This library is distributed in the hope that it will be useful,
> > +#  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > +#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> > +#  Lesser General Public License for more details.
> > +#
> > +#  You should have received a copy of the GNU Lesser General Public
> > +#  License along with this library; if not, see
> > +#  <http://www.gnu.org/licenses/lgpl-2.1.html>
> > +#
> > +
> > +obj-y   +=3D translate.o
> > +obj-y   +=3D helper.o
> > +obj-y   +=3D cpu.o
> > +obj-y   +=3D op_helper.o
> > +obj-y   +=3D gdbstub.o
> > +obj-y   +=3D decoder.o
> > +obj-y   +=3D regs.o
> > +obj-y   +=3D semfunc.o
> > +obj-y   +=3D semfunc-helper.o
> > +obj-y   +=3D mmu.o
> > +obj-y   +=3D mpu.o
> > +obj-y   +=3D timer.o
> > +obj-y   +=3D irq.o
> > +obj-y   +=3D cache.o
>
> We don't use Makefiles anymore, and you already provides meson.build.
>
> > diff --git a/target/arc/arc-common.h b/target/arc/arc-common.h
> > new file mode 100644
> > index 0000000000..8013e1d2ed
> > --- /dev/null
> > +++ b/target/arc/arc-common.h
> > @@ -0,0 +1,55 @@
> > +/*
> > + *  Common header file to be used by cpu and disassembler.
> > + *  Copyright (C) 2017 Free Software Foundation, Inc.
> > + *
> > + *  You should have received a copy of the GNU General Public License
> > + *  along with GAS or GDB; see the file COPYING3. If not, write to
> > + *  the Free Software Foundation, 51 Franklin Street - Fifth Floor, Bo=
ston,
> > + *  MA 02110-1301, USA.
> > + */
> > +
> > +#ifndef ARC_COMMON_H
> > +#define ARC_COMMON_H
> > +
> > +#include "qemu/osdep.h"
> ...
>
> Do not include "qemu/osdep.h" in headers.
>
> > +/*-*-indent-tabs-mode:nil;tab-width:4;indent-line-function:'insert-tab=
'-*-*/
> > +/* vim: set ts=3D4 sw=3D4 et: */
> > diff --git a/target/arc/cpu-qom.h b/target/arc/cpu-qom.h
> > new file mode 100644
> > index 0000000000..413b693558
> > --- /dev/null
> > +++ b/target/arc/cpu-qom.h
> > @@ -0,0 +1,53 @@
> > +/*
> > + * QEMU ARC CPU
> > + *
> > + * Copyright (c) 2016 Michael Rolnik
>
> ???
>
> > + *
> > + * This library is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU Lesser General Public
> > + * License as published by the Free Software Foundation; either
> > + * version 2.1 of the License, or (at your option) any later version.
> > + *
> > + * This library is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
> > + * Lesser General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU Lesser General Public
> > + * License along with this library; if not, see
> > + * <http://www.gnu.org/licenses/lgpl-2.1.html>
> > + */
> > +
> ...
>
> > diff --git a/target/arc/cpu.c b/target/arc/cpu.c
> > new file mode 100644
> > index 0000000000..bbcb371760
> > --- /dev/null
> > +++ b/target/arc/cpu.c
> > @@ -0,0 +1,468 @@
> > +/*
> > + * QEMU ARC CPU
> > + *
> > + * Copyright (c) 2020
>
> (c) Synopsys?
>
> > + *
> > + * This library is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU Lesser General Public
> > + * License as published by the Free Software Foundation; either
> > + * version 2.1 of the License, or (at your option) any later version.
> > + *
> > + * This library is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
> > + * Lesser General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU Lesser General Public
> > + * License along with this library; if not, see
> > + * http://www.gnu.org/licenses/lgpl-2.1.html
> > + */
> ...
>
> > +/*-*-indent-tabs-mode:nil;tab-width:4;indent-line-function:'insert-tab=
'-*-*/
> > +/* vim: set ts=3D4 sw=3D4 et: */
> > diff --git a/target/arc/cpu.h b/target/arc/cpu.h
> > new file mode 100644
> > index 0000000000..e8446366e5
> > --- /dev/null
> > +++ b/target/arc/cpu.h
> > @@ -0,0 +1,532 @@
> > + /*
> > +  * QEMU ARC CPU
> > +  *
> > +  * Copyright (c) 2020
>
> Again.
>
> > +  *
> > +  * This library is free software; you can redistribute it and/or
> > +  * modify it under the terms of the GNU Lesser General Public
> > +  * License as published by the Free Software Foundation; either
> > +  * version 2.1 of the License, or (at your option) any later version.
> > +  *
> > +  * This library is distributed in the hope that it will be useful,
> > +  * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > +  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
> > +  * Lesser General Public License for more details.
> > +  *
> > +  * You should have received a copy of the GNU Lesser General Public
> > +  * License along with this library; if not, see
> > +  * <http://www.gnu.org/licenses/lgpl-2.1.html>
> > +  */
> > +
> > +#ifndef CPU_ARC_H
> > +#define CPU_ARC_H
> > +
> ...
>
> > +
> > +/*
> > + * ArcCPU:
> > + * @env: #CPUMBState
> > + *
> > + * An ARC CPU.
> > + */
> > +struct ARCCPU {
> > +  /*< private >*/
> > +  CPUState parent_obj;
> > +
> > +  /*< public >*/
> > +
> > +  /* ARC Configuration Settings. */
> > +  struct {
> > +    uint32_t addr_size;
> > +    bool     aps_feature;
> > +    bool     byte_order;
> > +    bool     bitscan_option;
> > +    uint32_t br_bc_entries;
> > +    uint32_t br_pt_entries;
> > +    bool     br_bc_full_tag;
> > +    uint8_t  br_rs_entries;
> > +    uint32_t br_bc_tag_size;
> > +    uint8_t  br_tosq_entries;
> > +    uint8_t  br_fb_entries;
> > +    bool     code_density;
> > +    bool     code_protect;
> > +    uint8_t  dccm_mem_cycles;
> > +    bool     dccm_posedge;
> > +    uint8_t  dccm_mem_bancks;
> > +    uint8_t  dc_mem_cycles;
> > +    bool     dc_posedge;
> > +    bool     dmp_unaligned;
> > +    bool     ecc_exception;
> > +    uint32_t external_interrupts;
> > +    uint8_t  ecc_option;
> > +    bool     firq_option;
> > +    bool     fpu_dp_option;
> > +    bool     fpu_fma_option;
> > +    bool     fpu_div_option;
> > +    bool     has_actionpoints;
> > +    bool     has_fpu;
> > +    bool     has_interrupts;
> > +    bool     has_mmu;
> > +    bool     has_mpu;
> > +    bool     has_timer_0;
> > +    bool     has_timer_1;
> > +    bool     has_pct;
> > +    bool     has_rtt;
> > +    bool     has_smart;
> > +    uint32_t intvbase_preset;
> > +    uint32_t lpc_size;
> > +    uint8_t  mpu_num_regions;
> > +    uint8_t  mpy_option;
> > +    uint32_t mmu_page_size_sel0;
> > +    uint32_t mmu_page_size_sel1;
> > +    uint32_t mmu_pae_enabled;
> > +    uint32_t ntlb_num_entries;
> > +    uint32_t num_actionpoints;
> > +    uint32_t number_of_interrupts;
> > +    uint32_t number_of_levels;
> > +    uint32_t pct_counters;
> > +    uint32_t pct_interrupt;
> > +    uint32_t pc_size;
> > +    uint32_t rgf_num_regs;
>
> Maybe use 'unsigned' for numbers (various uses).
>
> > +    uint32_t rgf_banked_regs;
> > +    uint32_t rgf_num_banks;
> > +    bool     rtc_option;
> > +    uint32_t rtt_feature_level;
> > +    bool     stack_checking;
> > +    bool     swap_option;
> > +    uint32_t smar_stack_entries;
> > +    uint32_t smart_implementation;
> > +    uint32_t stlb_num_entries;
> > +    uint32_t slc_size;
> > +    uint32_t slc_line_size;
> > +    uint32_t slc_ways;
> > +    uint32_t slc_tag_banks;
> > +    uint32_t slc_tram_delay;
> > +    uint32_t slc_dbank_width;
> > +    uint32_t slc_data_banks;
> > +    uint32_t slc_dram_delay;
> > +    bool     slc_mem_bus_width;
> > +    uint32_t slc_ecc_option;
> > +    bool     slc_data_halfcycle_steal;
> > +    bool     slc_data_add_pre_pipeline;
> > +    bool     uaux_option;
> > +    uint32_t freq_hz; /* CPU frequency in hz, needed for timers. */
> > +  } cfg;
> > +
> [...]
> Regards,
>
> Phil.

