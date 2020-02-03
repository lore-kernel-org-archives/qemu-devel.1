Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E64BAC33CAC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 11:44:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1A7D20658
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 11:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WbPPoDWt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1A7D20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iya9C-0003Gy-U1
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 06:44:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37831)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iya7P-0001uw-W3
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 06:42:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iya7O-0005HP-M2
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 06:42:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50171
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iya7O-0005H7-Hx
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 06:42:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580730138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zXydyNMSTCC/yf3cjarTtkF/nrZ4ZrNDBBM4L4QJyLA=;
 b=WbPPoDWt2Ca6B1oZlUVBHh8MtWd+g7jc2JnCo+AzZ9Qgv5MtCCLp94senHG4EwPRfdes/y
 AQyfrfyfgQuZAAH+IyAZ2F8c6iWVuCzpZwHUoq3I667GOKq3Zu7vS22COqlARr5gARC1w7
 AuJRUaX3MdEyi2Klp5k6udJcVQTcE0w=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-M_OViaNnOgClxo3uS_L1FQ-1; Mon, 03 Feb 2020 06:42:16 -0500
Received: by mail-wm1-f70.google.com with SMTP id d4so3907809wmd.7
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 03:42:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7I1IfdkBXtLkiqMPZg/YqwanXIsktJg+Exz5sWuafTE=;
 b=KSfKYD/ug+cnhE91xtV4t3yUrNbhtem0WZRo06wI4D5r9Fq2i5ct38jNTb5GOt0T4y
 mt8qkFcpQQ45JxNpvkW3bBJR4N6yc4EOVkAnGw6W73or0wREcMo7aJ/ZHdvrYKXNeFcB
 F0hChBtRN3f5deM2Lp0yO2NrDS/0TxOCAnb1cgg9PBy4K8ZHeTr4htDqsVkNa+BM5emG
 /mYtkeKZ32eAfL8CTUy/Tc6Pja2A0fVTNoFPC8B2hqqEqp4D/mKo+u07wC9tc3zoi3E9
 JxiflZCDRIiDJPCjZj5B8BZuonaFPk6Hr6c8DZKA4WpfSqTlnO6YA/BF9WIOzty7CY19
 hO/w==
X-Gm-Message-State: APjAAAXNmg5i36gKQ09YfQ0xsRsrTTLHoiX2ERmPkBTy7to5NyKqud9n
 Yf7ybZinn468eeTS9uQxzsG+MMljE2kr9nlZW+Wdafaaf8AMoG+nzjIsUY6c5XwmwX81ofVx85/
 yJmNgz+FaeKGhVFo=
X-Received: by 2002:a7b:c93a:: with SMTP id h26mr30291469wml.83.1580730135071; 
 Mon, 03 Feb 2020 03:42:15 -0800 (PST)
X-Google-Smtp-Source: APXvYqzSTL6+geAQe5aI3sJoCcU87/RLjM4eE1N3cxaewIHvWajFAJraO3cjVenlWAaTEe+TPGXk0Q==
X-Received: by 2002:a7b:c93a:: with SMTP id h26mr30291440wml.83.1580730134825; 
 Mon, 03 Feb 2020 03:42:14 -0800 (PST)
Received: from [192.168.1.35] (162.red-83-52-55.dynamicip.rima-tde.net.
 [83.52.55.162])
 by smtp.gmail.com with ESMTPSA id u14sm24766608wrm.51.2020.02.03.03.42.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Feb 2020 03:42:14 -0800 (PST)
Subject: Re: [PATCH v2 1/4] Add the NVMM vcpu API
To: Kamil Rytarowski <n54@gmx.com>, rth@twiddle.net, ehabkost@redhat.com,
 slp@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org,
 max@m00nbsd.net
References: <20200107124903.16505-1-n54@gmx.com>
 <20200128140945.929-1-n54@gmx.com> <20200128140945.929-2-n54@gmx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <36e595b7-e72e-e216-3fa8-dd7d8fd17f5c@redhat.com>
Date: Mon, 3 Feb 2020 12:42:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200128140945.929-2-n54@gmx.com>
Content-Language: en-US
X-MC-Unique: M_OViaNnOgClxo3uS_L1FQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/28/20 3:09 PM, Kamil Rytarowski wrote:
> From: Maxime Villard <max@m00nbsd.net>
>=20
> Adds support for the NetBSD Virtual Machine Monitor (NVMM) stubs and
> introduces the nvmm.h sysemu API for managing the vcpu scheduling and
> management.
>=20
> Signed-off-by: Maxime Villard <max@m00nbsd.net>
> Signed-off-by: Kamil Rytarowski <n54@gmx.com>
> Reviewed-by: Sergio Lopez <slp@redhat.com>
> ---
>   accel/stubs/Makefile.objs |  1 +
>   accel/stubs/nvmm-stub.c   | 43 +++++++++++++++++++++++++++++++++++++++
>   include/sysemu/nvmm.h     | 35 +++++++++++++++++++++++++++++++
>   3 files changed, 79 insertions(+)
>   create mode 100644 accel/stubs/nvmm-stub.c
>   create mode 100644 include/sysemu/nvmm.h
>=20
> diff --git a/accel/stubs/Makefile.objs b/accel/stubs/Makefile.objs
> index 3894caf95d..09f2d3e1dd 100644
> --- a/accel/stubs/Makefile.objs
> +++ b/accel/stubs/Makefile.objs
> @@ -1,5 +1,6 @@
>   obj-$(call lnot,$(CONFIG_HAX))  +=3D hax-stub.o
>   obj-$(call lnot,$(CONFIG_HVF))  +=3D hvf-stub.o
>   obj-$(call lnot,$(CONFIG_WHPX)) +=3D whpx-stub.o
> +obj-$(call lnot,$(CONFIG_NVMM)) +=3D nvmm-stub.o
>   obj-$(call lnot,$(CONFIG_KVM))  +=3D kvm-stub.o
>   obj-$(call lnot,$(CONFIG_TCG))  +=3D tcg-stub.o
> diff --git a/accel/stubs/nvmm-stub.c b/accel/stubs/nvmm-stub.c
> new file mode 100644
> index 0000000000..c2208b84a3
> --- /dev/null
> +++ b/accel/stubs/nvmm-stub.c
> @@ -0,0 +1,43 @@
> +/*
> + * Copyright (c) 2018-2019 Maxime Villard, All rights reserved.
> + *
> + * NetBSD Virtual Machine Monitor (NVMM) accelerator stub.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu-common.h"
> +#include "cpu.h"
> +#include "sysemu/nvmm.h"
> +
> +int nvmm_init_vcpu(CPUState *cpu)
> +{
> +    return -1;
> +}
> +
> +int nvmm_vcpu_exec(CPUState *cpu)
> +{
> +    return -1;
> +}
> +
> +void nvmm_destroy_vcpu(CPUState *cpu)
> +{
> +}
> +
> +void nvmm_cpu_synchronize_state(CPUState *cpu)
> +{
> +}
> +
> +void nvmm_cpu_synchronize_post_reset(CPUState *cpu)
> +{
> +}
> +
> +void nvmm_cpu_synchronize_post_init(CPUState *cpu)
> +{
> +}
> +
> +void nvmm_cpu_synchronize_pre_loadvm(CPUState *cpu)
> +{
> +}
> diff --git a/include/sysemu/nvmm.h b/include/sysemu/nvmm.h
> new file mode 100644
> index 0000000000..10496f3980
> --- /dev/null
> +++ b/include/sysemu/nvmm.h
> @@ -0,0 +1,35 @@
> +/*
> + * Copyright (c) 2018-2019 Maxime Villard, All rights reserved.
> + *
> + * NetBSD Virtual Machine Monitor (NVMM) accelerator support.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#ifndef QEMU_NVMM_H
> +#define QEMU_NVMM_H
> +
> +#include "config-host.h"
> +#include "qemu-common.h"
> +
> +int nvmm_init_vcpu(CPUState *);
> +int nvmm_vcpu_exec(CPUState *);
> +void nvmm_destroy_vcpu(CPUState *);
> +
> +void nvmm_cpu_synchronize_state(CPUState *);
> +void nvmm_cpu_synchronize_post_reset(CPUState *);
> +void nvmm_cpu_synchronize_post_init(CPUState *);
> +void nvmm_cpu_synchronize_pre_loadvm(CPUState *);
> +
> +#ifdef CONFIG_NVMM
> +
> +int nvmm_enabled(void);
> +
> +#else /* CONFIG_NVMM */
> +
> +#define nvmm_enabled() (0)
> +
> +#endif /* CONFIG_NVMM */
> +
> +#endif /* CONFIG_NVMM */
> --
> 2.24.1
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


