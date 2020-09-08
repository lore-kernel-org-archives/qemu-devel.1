Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8EE1C43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 21:21:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 771332087C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 21:21:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7cybMrJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 771332087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFl3K-0008EU-Lp
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 17:21:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60276)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kFl2m-0007nE-Sp
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 17:20:48 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:40498)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kFl2k-0005mr-TK
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 17:20:48 -0400
Received: by mail-wr1-x443.google.com with SMTP id j2so682072wrx.7
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 14:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=6HzjEfV4diqvO+Bsdgpv8ylBszvivBpTxBmgBaJz+U0=;
 b=K7cybMrJ+CNmx6HfO4CsGSgegdJd4w5XUEE7PcZgp3wikpAGyWjIOYWu3pfx5NdCrG
 EMfOSlJWvEffR7xy7SSiH4F/cGvXm80uPlhSaqVzyTkjkpCuG6B8r2mqVZz0+rLL2pg+
 3WqViogBJZMLVQnNCxdYpwVsJm1STwr0LpYpAvPI1y2yq+a6jWSbBFFUdENStQYlcCQK
 ByFxy9YFXpzaZskXEb+3kfDip7Yp+96yI/RF8YRFbYkdi1etevK+1Xq6+Gn6Iq4GlLtc
 mSBeIU/RSJJ1SvcKzWSg0tJY+jPYR8INoeqB3TGuz5/aWqqrTASFOPD4lxRBbP7fG/fV
 2tPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6HzjEfV4diqvO+Bsdgpv8ylBszvivBpTxBmgBaJz+U0=;
 b=R6lq9Kb0lPMAWXT+iEUWVtRq/tL7FaqJTDLJIhFibeJUr9dEs6/TZKnA5AZKelaq6x
 a+WUxxluS2n+CnzwknJIs10ezRdTTfAlgfBxkm92Niwx5Icit5V+Krxs3rDkQSVnCjoi
 Xd9VA7VwIOx1kfGaxFV8jv6Nz5G34SnUlbzMOd1EnXqFMku8DOsbPcY1jnRdY1a6aix3
 vKvRSlUxIQ3Whgm8xJu2qIhb67zoHwHUKJAEyG4BEW2lUzm9DaPD2aCD0LHNY2hcAskI
 9PgzDQDflv48q92l5lijk47IY93voRv+TvIKcDN1iMSOyDnfCw+TyEwXgfKScVBBxl07
 Se/w==
X-Gm-Message-State: AOAM530iwDe1+dbQmfI04DxQBInh6FFkqlIwMGhOFepAAIX3OLIbUf17
 +Hpm6F7P2/AjwzqyKLFpKOwn0cYhJVU=
X-Google-Smtp-Source: ABdhPJyASCRXEgk+xe+icD+h+r6RDNtu2PzWjaXarCAoJdBm3wKXt9RiP7a8Ay3tVo96YGZOJGwTOA==
X-Received: by 2002:adf:df87:: with SMTP id z7mr409464wrl.239.1599600044887;
 Tue, 08 Sep 2020 14:20:44 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id 189sm859820wmb.3.2020.09.08.14.20.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Sep 2020 14:20:44 -0700 (PDT)
Subject: Re: [PATCH 19/20] hw/rx: Add CQ-FRK-RX62N target
To: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
References: <20200827123859.81793-1-ysato@users.sourceforge.jp>
 <20200827123859.81793-20-ysato@users.sourceforge.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f82bc93c-09e3-7e8b-1809-af1337911e3c@amsat.org>
Date: Tue, 8 Sep 2020 23:20:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200827123859.81793-20-ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-1.626,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/27/20 2:38 PM, Yoshinori Sato wrote:
> It most popular RX target board in Japan.
> 
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  default-configs/rx-softmmu.mak |  1 +
>  hw/rx/cq-frk-rx62n.c           | 94 ++++++++++++++++++++++++++++++++++
>  hw/rx/Kconfig                  |  3 ++
>  hw/rx/meson.build              |  1 +
>  4 files changed, 99 insertions(+)
>  create mode 100644 hw/rx/cq-frk-rx62n.c
> 
> diff --git a/default-configs/rx-softmmu.mak b/default-configs/rx-softmmu.mak
> index ea8731d67b..dbbaee8809 100644
> --- a/default-configs/rx-softmmu.mak
> +++ b/default-configs/rx-softmmu.mak
> @@ -2,3 +2,4 @@
>  
>  CONFIG_RX_GDBSIM=y
>  CONFIG_TKDN_RX62N=y
> +CONFIG_FRK_RX62N=y
> diff --git a/hw/rx/cq-frk-rx62n.c b/hw/rx/cq-frk-rx62n.c
> new file mode 100644
> index 0000000000..a1cd9cb2ad
> --- /dev/null
> +++ b/hw/rx/cq-frk-rx62n.c
> @@ -0,0 +1,94 @@
> +/*
> + * CQ publishing CQ-FRK-RX62N
> + *
> + * Copyright (c) 2020 Yoshinori Sato
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/cutils.h"
> +#include "qapi/error.h"
> +#include "qemu-common.h"
> +#include "cpu.h"
> +#include "hw/hw.h"
> +#include "hw/sysbus.h"
> +#include "hw/loader.h"
> +#include "hw/rx/loader.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/rx/rx62n.h"
> +#include "sysemu/sysemu.h"
> +#include "sysemu/qtest.h"
> +#include "sysemu/device_tree.h"
> +#include "hw/boards.h"
> +
> +typedef struct {
> +    /*< private >*/
> +    MachineState parent_obj;
> +    /*< public >*/
> +    RX62NState mcu;
> +} FRK_RX62NMachineState;

CODING_STYLE.rst suggests CamelCase: FrkRx62nMachineState.

Otherwise patch is good.

> +
> +#define TYPE_FRK_RX62N_MACHINE MACHINE_TYPE_NAME("cq-frk-rx62n")
> +
> +#define FRK_RX62N_MACHINE(obj) \
> +    OBJECT_CHECK(FRK_RX62NMachineState, (obj), TYPE_FRK_RX62N_MACHINE)
> +
> +static void frk_rx62n_init(MachineState *machine)
> +{
> +    FRK_RX62NMachineState *s = FRK_RX62N_MACHINE(machine);
> +    RX62NClass *rx62nc;
> +    MemoryRegion *sysmem = get_system_memory();
> +
> +    /* Initialize MCU */
> +    object_initialize_child(OBJECT(machine), "mcu",
> +                            &s->mcu, TYPE_R5F562N7_MCU);
> +    rx62nc = RX62N_MCU_GET_CLASS(&s->mcu);
> +    object_property_set_link(OBJECT(&s->mcu), "main-bus", OBJECT(sysmem),
> +                             &error_abort);
> +    object_property_set_uint(OBJECT(&s->mcu), "xtal-frequency-hz",
> +                             12 * 1000 * 1000, &error_abort);
> +    if (bios_name) {
> +        if (!load_bios(bios_name, rx62nc->rom_flash_size, &error_abort)) {
> +            exit(0);
> +        }
> +    } else if (!qtest_enabled()) {
> +        error_report("No bios specified");
> +        exit(1);
> +    }
> +    qdev_realize(DEVICE(&s->mcu), NULL, &error_abort);
> +}
> +
> +static void frk_rx62n_class_init(ObjectClass *oc, void *data)
> +{
> +    MachineClass *mc = MACHINE_CLASS(oc);
> +
> +    mc->desc = "CQ publishing CQ-FRK-RX62N";
> +    mc->init = frk_rx62n_init;
> +    mc->is_default = 0;
> +    mc->default_cpu_type = TYPE_RX62N_CPU;
> +}
> +
> +static const TypeInfo frk_rx62n_type = {
> +    .name = MACHINE_TYPE_NAME("cq-frk-rx62n"),
> +    .parent = TYPE_MACHINE,
> +    .instance_size  = sizeof(FRK_RX62NMachineState),
> +    .class_init = frk_rx62n_class_init,
> +};
> +
> +static void frk_rx62n_machine_init(void)
> +{
> +    type_register_static(&frk_rx62n_type);
> +}
> +
> +type_init(frk_rx62n_machine_init)
> diff --git a/hw/rx/Kconfig b/hw/rx/Kconfig
> index 0ef20d0c3c..ab2c472510 100644
> --- a/hw/rx/Kconfig
> +++ b/hw/rx/Kconfig
> @@ -17,3 +17,6 @@ config TKDN_RX62N
>      select RX62N_MCU
>      select FITLOADER
>  
> +config FRK_RX62N
> +    bool
> +    select RX62N_MCU
> diff --git a/hw/rx/meson.build b/hw/rx/meson.build
> index 0a741e091c..0f26f1fcb2 100644
> --- a/hw/rx/meson.build
> +++ b/hw/rx/meson.build
> @@ -2,6 +2,7 @@ rx_ss = ss.source_set()
>  rx_ss.add(files('loader.c'))
>  rx_ss.add(when: 'CONFIG_RX_GDBSIM', if_true: files('rx-gdbsim.c'))
>  rx_ss.add(when: 'CONFIG_TKDN_RX62N', if_true: files('tkdn-rx62n.c'))
> +rx_ss.add(when: 'CONFIG_FRK_RX62N', if_true: files('cq-frk-rx62n.c'))
>  rx_ss.add(when: 'CONFIG_RX62N_MCU', if_true: files('rx62n.c', 'rx62n-cpg.c'))
>  
>  hw_arch += {'rx': rx_ss}
> 


