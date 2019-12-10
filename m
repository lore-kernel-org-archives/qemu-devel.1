Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1536C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 12:07:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8D8A20663
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 12:07:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eh2Xg94x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8D8A20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieeIT-00075y-LJ
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 07:07:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38081)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ieeH0-0005f4-Mc
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 07:05:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ieeGy-0002f4-QT
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 07:05:50 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52938
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ieeGy-0002Yj-Eo
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 07:05:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575979545;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pH06kxAA6/MFRQa8xQzBLaJRjuJw0dsx5yg1BHU2ac0=;
 b=eh2Xg94xef+5GjZO+8SVn0OZSCt+B1CdukXUay8hAqhOwenRIqM5Mb7bHoVuB1uL9+vwbz
 v3WCjXS+MXztWGU06vziE4/Y8u5nIQaIbVv6ieZIwVHQdBaTeWHvm88KaZ9v1kPQdFZKU3
 spb8zGmCBafDvOeM1vvTeX4iQstkA58=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-NuBzTdztMlaTdDNtsDnjew-1; Tue, 10 Dec 2019 07:05:44 -0500
Received: by mail-wr1-f71.google.com with SMTP id u12so8863653wrt.15
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2019 04:05:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cY5ICv2/WNfGIoyhYkBKtlW1CFBrO3U9rx2DuqOugpQ=;
 b=eH34Ye722LPWPfPSUjQTBTUwAm6GDoHsphWXBJxM8Sam/7goWWc8QpysU6KAdu/1mu
 lBOJL3zYoq08YB+lv/9kJlAjBIkre673c8B6NJe7aXklAo+LkRfXWLJsTnlDYVmS3PNB
 QakB3g3Ojs/CgYVfGfeaj6uSbStc2Iq6uiSU+FtvCutfCl5sGqZPYhc9rP8RLpjvu6An
 w/4zc41oHusKnXGBV+oOHiMAfoeG7FccKFNw/ZJ1kolXD+dTCZeDIDKsrfqDYr8Btiij
 Mvykd216tOQHursnsxOWLb5QcgY/tFEUJvgXDWYOOExzPQGshcA2RO5LHZ2bMMfu/qcG
 1eiA==
X-Gm-Message-State: APjAAAUbsH82q6hwSD4knOfe/YdhvmkzwJ2jtBCKgMnRiU1V2du6oN/D
 5KL8uriJ77JqClFsVrCKKV37AnhZ71LV9k5gWPZi3aIienOL9o9bR+n8tq9pGNshPr4Y2Q7KENP
 zNfHgxADNtH2jzuI=
X-Received: by 2002:a5d:5708:: with SMTP id a8mr3022726wrv.79.1575979543134;
 Tue, 10 Dec 2019 04:05:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqxLnSyDQq3tvGgR43UCVOc8yxqalm9X//pEn9zLYY0kxgGUDbY1EXXnux+pI6eLrgdajg7d7A==
X-Received: by 2002:a5d:5708:: with SMTP id a8mr3022685wrv.79.1575979542824;
 Tue, 10 Dec 2019 04:05:42 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id k11sm2769361wmc.20.2019.12.10.04.05.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Dec 2019 04:05:42 -0800 (PST)
Subject: Re: [PATCH v2 18/18] kvm: convert "-machine kernel_irqchip" to an
 accelerator property
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <1575903705-12925-1-git-send-email-pbonzini@redhat.com>
 <1575903705-12925-19-git-send-email-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <295b4845-5577-68af-8c00-598632ae0cad@redhat.com>
Date: Tue, 10 Dec 2019 13:05:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1575903705-12925-19-git-send-email-pbonzini@redhat.com>
Content-Language: en-US
X-MC-Unique: NuBzTdztMlaTdDNtsDnjew-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: thuth@redhat.com, elmarco@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/9/19 4:01 PM, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   accel/kvm/kvm-all.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++=
-----
>   hw/core/machine.c   | 61 ----------------------------------------------=
-------
>   include/hw/boards.h |  3 ---
>   qemu-options.hx     |  9 +++++---
>   vl.c                |  3 ++-
>   5 files changed, 62 insertions(+), 73 deletions(-)
>=20
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index c0a6351..b0adbb2 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -42,6 +42,8 @@
>   #include "sysemu/sev.h"
>   #include "sysemu/balloon.h"
>   #include "qapi/visitor.h"
> +#include "qapi/qapi-types-common.h"
> +#include "qapi/qapi-visit-common.h"
>  =20
>   #include "hw/boards.h"
>  =20
> @@ -94,6 +96,9 @@ struct KVMState
>       int many_ioeventfds;
>       int intx_set_mask;
>       int kvm_shadow_mem;
> +    bool kernel_irqchip_allowed;
> +    bool kernel_irqchip_required;
> +    bool kernel_irqchip_split;
>       bool sync_mmu;
>       bool manual_dirty_log_protect;
>       /* The man page (and posix) say ioctl numbers are signed int, but
> @@ -1780,7 +1785,7 @@ static void kvm_irqchip_create(KVMState *s)
>        * in-kernel irqchip for us */
>       ret =3D kvm_arch_irqchip_create(s);
>       if (ret =3D=3D 0) {
> -        if (kvm_kernel_irqchip_split()) {
> +        if (s->kernel_irqchip_split) {
>               perror("Split IRQ chip mode not supported.");
>               exit(1);
>           } else {
> @@ -2051,7 +2056,7 @@ static int kvm_init(MachineState *ms)
>           goto err;
>       }
>  =20
> -    if (machine_kernel_irqchip_allowed(ms)) {
> +    if (s->kernel_irqchip_allowed) {
>           kvm_irqchip_create(s);
>       }
>  =20
> @@ -2969,19 +2974,57 @@ static void kvm_set_kvm_shadow_mem(Object *obj, V=
isitor *v,
>       s->kvm_shadow_mem =3D value;
>   }
>  =20
> +static void kvm_set_kernel_irqchip(Object *obj, Visitor *v,
> +                                   const char *name, void *opaque,
> +                                   Error **errp)
> +{
> +    Error *err =3D NULL;
> +    KVMState *s =3D KVM_STATE(obj);
> +    OnOffSplit mode;
> +
> +    visit_type_OnOffSplit(v, name, &mode, &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    } else {
> +        switch (mode) {
> +        case ON_OFF_SPLIT_ON:
> +            s->kernel_irqchip_allowed =3D true;
> +            s->kernel_irqchip_required =3D true;
> +            s->kernel_irqchip_split =3D false;
> +            break;
> +        case ON_OFF_SPLIT_OFF:
> +            s->kernel_irqchip_allowed =3D false;
> +            s->kernel_irqchip_required =3D false;
> +            s->kernel_irqchip_split =3D false;
> +            break;
> +        case ON_OFF_SPLIT_SPLIT:
> +            s->kernel_irqchip_allowed =3D true;
> +            s->kernel_irqchip_required =3D true;
> +            s->kernel_irqchip_split =3D true;
> +            break;
> +        default:
> +            /* The value was checked in visit_type_OnOffSplit() above. I=
f

With recent style enforcement you now need to split this comment in 2 lines=
.

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

> +             * we get here, then something is wrong in QEMU.
> +             */
> +            abort();
> +        }
> +    }
> +}
> +
>   bool kvm_kernel_irqchip_allowed(void)
>   {
> -    return machine_kernel_irqchip_allowed(current_machine);
> +    return kvm_state->kernel_irqchip_allowed;
>   }
>  =20
>   bool kvm_kernel_irqchip_required(void)
>   {
> -    return machine_kernel_irqchip_required(current_machine);
> +    return kvm_state->kernel_irqchip_required;
>   }
>  =20
>   bool kvm_kernel_irqchip_split(void)
>   {
> -    return machine_kernel_irqchip_split(current_machine);
> +    return kvm_state->kernel_irqchip_split;
>   }
>  =20
>   static void kvm_accel_instance_init(Object *obj)
> @@ -2999,6 +3042,12 @@ static void kvm_accel_class_init(ObjectClass *oc, =
void *data)
>       ac->has_memory =3D kvm_accel_has_memory;
>       ac->allowed =3D &kvm_allowed;
>  =20
> +    object_class_property_add(oc, "kernel-irqchip", "on|off|split",
> +        NULL, kvm_set_kernel_irqchip,
> +        NULL, NULL, &error_abort);
> +    object_class_property_set_description(oc, "kernel-irqchip",
> +        "Configure KVM in-kernel irqchip", &error_abort);
> +
>       object_class_property_add(oc, "kvm-shadow-mem", "int",
>           kvm_get_kvm_shadow_mem, kvm_set_kvm_shadow_mem,
>           NULL, NULL, &error_abort);
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index bfb5f6f..c1cad2c 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -173,44 +173,6 @@ GlobalProperty hw_compat_2_1[] =3D {
>   };
>   const size_t hw_compat_2_1_len =3D G_N_ELEMENTS(hw_compat_2_1);
>  =20
> -static void machine_set_kernel_irqchip(Object *obj, Visitor *v,
> -                                       const char *name, void *opaque,
> -                                       Error **errp)
> -{
> -    Error *err =3D NULL;
> -    MachineState *ms =3D MACHINE(obj);
> -    OnOffSplit mode;
> -
> -    visit_type_OnOffSplit(v, name, &mode, &err);
> -    if (err) {
> -        error_propagate(errp, err);
> -        return;
> -    } else {
> -        switch (mode) {
> -        case ON_OFF_SPLIT_ON:
> -            ms->kernel_irqchip_allowed =3D true;
> -            ms->kernel_irqchip_required =3D true;
> -            ms->kernel_irqchip_split =3D false;
> -            break;
> -        case ON_OFF_SPLIT_OFF:
> -            ms->kernel_irqchip_allowed =3D false;
> -            ms->kernel_irqchip_required =3D false;
> -            ms->kernel_irqchip_split =3D false;
> -            break;
> -        case ON_OFF_SPLIT_SPLIT:
> -            ms->kernel_irqchip_allowed =3D true;
> -            ms->kernel_irqchip_required =3D true;
> -            ms->kernel_irqchip_split =3D true;
> -            break;
> -        default:
> -            /* The value was checked in visit_type_OnOffSplit() above. I=
f
> -             * we get here, then something is wrong in QEMU.
> -             */
> -            abort();
> -        }
> -    }
> -}
> -
>   static char *machine_get_kernel(Object *obj, Error **errp)
>   {
>       MachineState *ms =3D MACHINE(obj);
> @@ -752,12 +714,6 @@ static void machine_class_init(ObjectClass *oc, void=
 *data)
>       mc->numa_mem_align_shift =3D 23;
>       mc->numa_auto_assign_ram =3D numa_default_auto_assign_ram;
>  =20
> -    object_class_property_add(oc, "kernel-irqchip", "on|off|split",
> -        NULL, machine_set_kernel_irqchip,
> -        NULL, NULL, &error_abort);
> -    object_class_property_set_description(oc, "kernel-irqchip",
> -        "Configure KVM in-kernel irqchip", &error_abort);
> -
>       object_class_property_add_str(oc, "kernel",
>           machine_get_kernel, machine_set_kernel, &error_abort);
>       object_class_property_set_description(oc, "kernel",
> @@ -857,8 +813,6 @@ static void machine_initfn(Object *obj)
>       MachineState *ms =3D MACHINE(obj);
>       MachineClass *mc =3D MACHINE_GET_CLASS(obj);
>  =20
> -    ms->kernel_irqchip_allowed =3D true;
> -    ms->kernel_irqchip_split =3D mc->default_kernel_irqchip_split;
>       ms->dump_guest_core =3D true;
>       ms->mem_merge =3D true;
>       ms->enable_graphics =3D true;
> @@ -914,21 +868,6 @@ bool machine_usb(MachineState *machine)
>       return machine->usb;
>   }
>  =20
> -bool machine_kernel_irqchip_allowed(MachineState *machine)
> -{
> -    return machine->kernel_irqchip_allowed;
> -}
> -
> -bool machine_kernel_irqchip_required(MachineState *machine)
> -{
> -    return machine->kernel_irqchip_required;
> -}
> -
> -bool machine_kernel_irqchip_split(MachineState *machine)
> -{
> -    return machine->kernel_irqchip_split;
> -}
> -
>   int machine_phandle_start(MachineState *machine)
>   {
>       return machine->phandle_start;
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index 46119eb..b42fedd 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -63,9 +63,6 @@ extern MachineState *current_machine;
>  =20
>   void machine_run_board_init(MachineState *machine);
>   bool machine_usb(MachineState *machine);
> -bool machine_kernel_irqchip_allowed(MachineState *machine);
> -bool machine_kernel_irqchip_required(MachineState *machine);
> -bool machine_kernel_irqchip_split(MachineState *machine);
>   int machine_phandle_start(MachineState *machine);
>   bool machine_dump_guest_core(MachineState *machine);
>   bool machine_mem_merge(MachineState *machine);
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 779c8af..945fc4a 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -32,7 +32,6 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
>       "                selects emulated machine ('-machine help' for list=
)\n"
>       "                property accel=3Daccel1[:accel2[:...]] selects acc=
elerator\n"
>       "                supported accelerators are kvm, xen, hax, hvf, whp=
x or tcg (default: tcg)\n"
> -    "                kernel_irqchip=3Don|off|split controls accelerated =
irqchip support (default=3Doff)\n"
>       "                vmport=3Don|off|auto controls emulation of vmport =
(default: auto)\n"
>       "                dump-guest-core=3Don|off include guest memory in a=
 core dump (default=3Don)\n"
>       "                mem-merge=3Don|off controls memory merge support (=
default: on)\n"
> @@ -67,8 +66,6 @@ This is used to enable an accelerator. Depending on the=
 target architecture,
>   kvm, xen, hax, hvf, whpx or tcg can be available. By default, tcg is us=
ed. If there is
>   more than one accelerator specified, the next one is used if the previo=
us one
>   fails to initialize.
> -@item kernel_irqchip=3Don|off
> -Controls in-kernel irqchip support for the chosen accelerator when avail=
able.
>   @item vmport=3Don|off|auto
>   Enables emulation of VMWare IO port, for vmmouse etc. auto says to sele=
ct the
>   value based on accel. For accel=3Dxen the default is off otherwise the =
default
> @@ -115,6 +112,7 @@ DEF("accel", HAS_ARG, QEMU_OPTION_accel,
>       "-accel [accel=3D]accelerator[,prop[=3Dvalue][,...]]\n"
>       "                select accelerator (kvm, xen, hax, hvf, whpx or tc=
g; use 'help' for a list)\n"
>       "                igd-passthru=3Don|off (enable Xen integrated Intel=
 graphics passthrough, default=3Doff)\n"
> +    "                kernel-irqchip=3Don|off|split controls accelerated =
irqchip support (default=3Don)\n"
>       "                kvm-shadow-mem=3Dsize of KVM shadow MMU in bytes\n=
"
>       "                tb-size=3Dn (TCG translation block cache size)\n"
>       "                thread=3Dsingle|multi (enable multi-threaded TCG)\=
n", QEMU_ARCH_ALL)
> @@ -129,6 +127,11 @@ fails to initialize.
>   @item igd-passthru=3Don|off
>   When Xen is in use, this option controls whether Intel integrated graph=
ics
>   devices can be passed through to the guest (default=3Doff)
> +@item kernel-irqchip=3Don|off|split
> +Controls KVM in-kernel irqchip support.  The default is full acceleratio=
n of the
> +interrupt controllers.  On x86, split irqchip reduces the kernel attack
> +surface, at a performance cost for non-MSI interrupts.  Disabling the in=
-kernel
> +irqchip completely is not recommended except for debugging purposes.
>   @item kvm-shadow-mem=3Dsize
>   Defines the size of the KVM shadow MMU.
>   @item tb-size=3D@var{n}
> diff --git a/vl.c b/vl.c
> index 3678522..53e4ff6 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -2639,7 +2639,8 @@ static int machine_set_property(void *opaque,
>           object_register_sugar_prop(ACCEL_CLASS_NAME("xen"), qom_name, v=
alue);
>           return 0;
>       }
> -    if (g_str_equal(qom_name, "kvm-shadow-mem")) {
> +    if (g_str_equal(qom_name, "kvm-shadow-mem") ||
> +        g_str_equal(qom_name, "kernel-irqchip")) {
>           object_register_sugar_prop(ACCEL_CLASS_NAME("kvm"), qom_name, v=
alue);
>           return 0;
>       }
>=20


