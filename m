Return-Path: <SRS0=SOuJ=D7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92DAFC388F9
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 00:48:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01BAB2087D
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 00:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bfIzdXXh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01BAB2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kW7j4-0002sm-MJ
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 20:48:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60482)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kW7iU-0002T4-8e
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 20:47:30 -0400
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142]:42880)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kW7iS-0002tc-4X
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 20:47:29 -0400
Received: by mail-il1-x142.google.com with SMTP id c11so39413iln.9
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2020 17:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=PsLN24la19FWOBJLnST5AROEPKp/lhAcnopciRi1lkw=;
 b=bfIzdXXhz+SI1jjpMonUMieds5fM8Dil9UWFyInr6oZ30Z+N3ZVQMur1EL9f7yk9Dp
 NilIYycWBmnzKQidO3JdbCGShb21RanpHCzc5+mkZ68f/p7aNY1iShPrA98PeLoGDnx5
 pYL9Zq4pVpIoVvFqyBE0nYp1W2h3Tc/lz3P6OOH84v6lVrv0fkpHOkogOv8R/x/6x+DB
 R6E3Me9Fdn21EWO0uGUakPygmVpW81iqIDvWcGRISRCOnH0VWSB0G6A1WtvJEn4FIjk1
 D1hARfNg76JjH+vfIpU5uRLTH1MQUo5L1YqAcqFCZdyh8tgK5RUpYPNmIE442QKPjmCu
 9BOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=PsLN24la19FWOBJLnST5AROEPKp/lhAcnopciRi1lkw=;
 b=A6gFYPqqLAq9E3xBTp5sErOuZoWYAmEv+IdQxcNACKuhk0im6azcXMtpkey/iBmsQN
 7WPv0uu+T4f3HcYXF1ulbbKRmtH8r66z9CRkb51AuKIH4l8h9K9ggUXO0on26IV6MZAi
 mKnSPUAqGpOnnNRHPtd7uidGhdNMtSjX5QvB1gwGA7LgpYEW+mB2Qn+lT153YMWUETEJ
 5+2MK/A8/hkuYWcUmnTRpFsotCFXG6ul4fMiUAgVaNx0yHcMKu7wOZd/19xKA7HvAXHW
 W8x/JMu2oBrILvUurEWoXEwZlT9E9Vnni98GuHRUkCqW7gWEw/0hXKbG4cqc15KgJlWY
 X13A==
X-Gm-Message-State: AOAM531OGXcSTb2R3vNxIbfyhwZ0kAevQG65X+Jr0fq6SAt6/BEhuseS
 S0SkozF5zFBUCAyP5053hPUd94wfMMPMMi4i4zw=
X-Google-Smtp-Source: ABdhPJziR7wCylGGxE9Ao4r2+rBcf7BIcpiVzc3h7+yLvIiVwQV3139xxXET94d1XyhqyHtlHK4TvpwUQ7hRck/HqAA=
X-Received: by 2002:a92:5eda:: with SMTP id f87mr3983660ilg.131.1603500446963; 
 Fri, 23 Oct 2020 17:47:26 -0700 (PDT)
MIME-Version: 1.0
References: <20201021170842.25762-1-alex.bennee@linaro.org>
 <20201021170842.25762-5-alex.bennee@linaro.org>
In-Reply-To: <20201021170842.25762-5-alex.bennee@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 23 Oct 2020 17:35:39 -0700
Message-ID: <CAKmqyKPw1Bmt06WBuXQV4bOJkFtYK7B7ZvWVHPR=QN4EU0t64Q@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] hw/core: implement a guest-loader to support
 static hypervisor guests
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::142;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x142.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
Cc: julien@xen.org, Masami Hiramatsu <masami.hiramatsu@linaro.org>,
 andre.przywara@arm.com, stefano.stabellini@linaro.org,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>, stefano.stabellini@xilinx.com,
 stratos-dev@op-lists.linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 21, 2020 at 10:09 AM Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
>
> Hypervisors, especially type-1 ones, need the firmware/bootcode to put
> their initial guest somewhere in memory and pass the information to it
> via platform data. The guest-loader is modelled after the generic
> loader for exactly this sort of purpose:

guest as in Hypervisor guest and QEMU guest is a little confusing, but
I can't think of a better name

>
>   $QEMU $ARGS  -kernel ~/xen.git/xen/xen \
>     -append "dom0_mem=3D1G,max:1G loglvl=3Dall guest_loglvl=3Dall" \
>     -device guest-loader,addr=3D0x42000000,kernel=3DImage,bootargs=3D"roo=
t=3D/dev/sda2 ro console=3Dhvc0 earlyprintk=3Dxen" \
>     -device guest-loader,addr=3D0x47000000,initrd=3Drootfs.cpio

This seems fine to me.

Do you mind writing some documentation though? The generic-loader
documentation should be a good place to start.

>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  hw/core/guest-loader.h |  34 ++++++++++
>  hw/core/guest-loader.c | 140 +++++++++++++++++++++++++++++++++++++++++
>  hw/core/meson.build    |   2 +
>  3 files changed, 176 insertions(+)
>  create mode 100644 hw/core/guest-loader.h
>  create mode 100644 hw/core/guest-loader.c
>
> diff --git a/hw/core/guest-loader.h b/hw/core/guest-loader.h
> new file mode 100644
> index 0000000000..07f4b4884b
> --- /dev/null
> +++ b/hw/core/guest-loader.h
> @@ -0,0 +1,34 @@
> +/*
> + * Guest Loader
> + *
> + * Copyright (C) 2020 Linaro
> + * Written by Alex Benn=C3=A9e <alex.bennee@linaro.org>
> + * (based on the generic-loader by Li Guang <lig.fnst@cn.fujitsu.com>)
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#ifndef GUEST_LOADER_H
> +#define GUEST_LOADER_H
> +
> +#include "hw/qdev-core.h"
> +#include "qom/object.h"
> +
> +struct GuestLoaderState {
> +    /* <private> */
> +    DeviceState parent_obj;
> +
> +    /* <public> */
> +    uint64_t addr;
> +    char *kernel;
> +    char *args;
> +    char *initrd;
> +};
> +
> +#define TYPE_GUEST_LOADER "guest-loader"
> +OBJECT_DECLARE_SIMPLE_TYPE(GuestLoaderState, GUEST_LOADER)
> +
> +#endif
> diff --git a/hw/core/guest-loader.c b/hw/core/guest-loader.c
> new file mode 100644
> index 0000000000..1ce39842be
> --- /dev/null
> +++ b/hw/core/guest-loader.c
> @@ -0,0 +1,140 @@
> +/*
> + * Guest Loader
> + *
> + * Copyright (C) 2020 Linaro
> + * Written by Alex Benn=C3=A9e <alex.bennee@linaro.org>
> + * (based on the generic-loader by Li Guang <lig.fnst@cn.fujitsu.com>)
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +/*
> + * Much like the generic-loader this is treated as a special device
> + * inside QEMU. However unlike the generic-loader this device is used
> + * to load guest images for hypervisors. As part of that process the
> + * hypervisor needs to have platform information passed to it by the
> + * lower levels of the stack (e.g. firmware/bootloader). If you boot
> + * the hypervisor directly you use the guest-loader to load the Dom0
> + * or equivalent guest images in the right place in the same way a
> + * boot loader would.
> + *
> + * This is only relevant for full system emulation.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/core/cpu.h"
> +#include "hw/sysbus.h"
> +#include "sysemu/dma.h"
> +#include "hw/loader.h"
> +#include "hw/qdev-properties.h"
> +#include "qapi/error.h"
> +#include "qemu/module.h"
> +#include "guest-loader.h"
> +#include "sysemu/device_tree.h"
> +#include "hw/boards.h"
> +
> +/*
> + * Insert some FDT nodes for the loaded blob.
> + */
> +static void loader_insert_platform_data(GuestLoaderState *s, int size, E=
rror **errp)
> +{
> +    MachineState *machine =3D MACHINE(qdev_get_machine());
> +    void *fdt =3D machine->fdt;
> +    g_autofree char *node =3D g_strdup_printf("/chosen/module@%#08lx", s=
->addr);
> +    uint64_t reg_attr[2] =3D {cpu_to_be64(s->addr), cpu_to_be64(size)};
> +
> +    if (!fdt) {
> +        error_setg(errp, "Cannot modify FDT fields if the machine has no=
ne");
> +        return;
> +    }
> +
> +    qemu_fdt_add_subnode(fdt, node);
> +    qemu_fdt_setprop(fdt, node, "reg", &reg_attr, sizeof(reg_attr));
> +
> +    if (s->kernel) {
> +        const char *compat[2] =3D { "multiboot,module", "multiboot,kerne=
l" };
> +        if (qemu_fdt_setprop_string_array
> +            (fdt, node, "compatible", (char **) &compat, ARRAY_SIZE(comp=
at)) < 0) {
> +            error_setg(errp, "couldn't set %s/compatible", node);
> +            return;
> +        }
> +        if (s->args) {
> +            if (qemu_fdt_setprop_string(fdt, node, "bootargs", s->args) =
< 0) {
> +                error_setg(errp, "couldn't set %s/bootargs", node);
> +            }
> +        }
> +    } else if (s->initrd) {
> +        const char * compat[2] =3D { "multiboot,module", "multiboot,ramd=
isk" };
> +        if (qemu_fdt_setprop_string_array
> +            (fdt, node, "compatible", (char **) &compat, ARRAY_SIZE(comp=
at)) < 0) {

The ( bracket should be on the previous line right?

Alistair

> +            error_setg(errp, "couldn't set %s/compatible", node);
> +            return;
> +        }
> +    }
> +}
> +
> +static void guest_loader_realize(DeviceState *dev, Error **errp)
> +{
> +    GuestLoaderState *s =3D GUEST_LOADER(dev);
> +    char *file =3D s->kernel ? s->kernel : s->initrd;
> +    int size =3D 0;
> +
> +    /* Perform some error checking on the user's options */
> +    if (s->kernel && s->initrd) {
> +        error_setg(errp, "Cannot specify a kernel and initrd in the same=
 stanza");
> +        return;
> +    } else if (!s->kernel && !s->initrd)  {
> +        error_setg(errp, "Need to specify a kernel or initrd image");
> +        return;
> +    } else if (!s->addr) {
> +        error_setg(errp, "Need to specify the address of guest blob");
> +        return;
> +    } else if (s->args && !s->kernel) {
> +        error_setg(errp, "Boot args only relevant to kernel blobs");
> +    }
> +
> +    /* Default to the maximum size being the machine's ram size */
> +    size =3D load_image_targphys_as(file, s->addr, ram_size, NULL);
> +    if (size < 0) {
> +        error_setg(errp, "Cannot load specified image %s", file);
> +        return;
> +    }
> +
> +    /* Now the image is loaded we need to update the platform data */
> +    loader_insert_platform_data(s, size, errp);
> +}
> +
> +static Property guest_loader_props[] =3D {
> +    DEFINE_PROP_UINT64("addr", GuestLoaderState, addr, 0),
> +    DEFINE_PROP_STRING("kernel", GuestLoaderState, kernel),
> +    DEFINE_PROP_STRING("bootargs", GuestLoaderState, args),
> +    DEFINE_PROP_STRING("initrd", GuestLoaderState, initrd),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void guest_loader_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +
> +    dc->realize =3D guest_loader_realize;
> +    device_class_set_props(dc, guest_loader_props);
> +    dc->desc =3D "Guest Loader";
> +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> +}
> +
> +static TypeInfo guest_loader_info =3D {
> +    .name =3D TYPE_GUEST_LOADER,
> +    .parent =3D TYPE_DEVICE,
> +    .instance_size =3D sizeof(GuestLoaderState),
> +    .class_init =3D guest_loader_class_init,
> +};
> +
> +static void guest_loader_register_type(void)
> +{
> +    type_register_static(&guest_loader_info);
> +}
> +
> +type_init(guest_loader_register_type)
> diff --git a/hw/core/meson.build b/hw/core/meson.build
> index 4a744f3b5e..27a69fc578 100644
> --- a/hw/core/meson.build
> +++ b/hw/core/meson.build
> @@ -37,6 +37,8 @@ softmmu_ss.add(files(
>    'clock-vmstate.c',
>  ))
>
> +softmmu_ss.add(when: 'CONFIG_TCG', if_true: files('guest-loader.c'))
> +
>  specific_ss.add(when: 'CONFIG_SOFTMMU', if_true: files(
>    'machine-qmp-cmds.c',
>    'numa.c',
> --
> 2.20.1
>
>

