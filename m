Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2817C2D0BF
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 12:03:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A06542073D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 12:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bc5izeAc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A06542073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieeEj-0003ML-Q0
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 07:03:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36826)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ieeCs-0002D3-Qg
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 07:01:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ieeCp-00054j-9m
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 07:01:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42185
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ieeCp-00053p-5f
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 07:01:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575979289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CnDnFTc8rbUbSRixxc0aaGPmX7ZO5BGWuh1rZcAXl3c=;
 b=bc5izeAcvcU/yjxNR3vQeo15BYKSsP7vNW/9ZQ25DdnunsQVLsOJDiwiAKwhUbWL8GjEcd
 JX+ASixViQFkJPgrrdTx20J8ZTJW2Ia+LcjocY1/pPtFSwwJvFAOQysIXzfFaCML1LyUwB
 u0CTDQVkCWgCMtkUndPYf7ThO68F4P4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-VkP8JvGJNfyLvQ3ku6gp5Q-1; Tue, 10 Dec 2019 07:01:20 -0500
Received: by mail-wr1-f70.google.com with SMTP id f17so8883376wrt.19
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2019 04:01:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UWb+cetemzs6Mp+rgASSipq6fZBDu1KEoZpansaFtQI=;
 b=ThMXY1kHBRhpXSqze/BQKdfnHmqEI7ut0UFzilV7GOmLcKmrZL7+m8fqjxVPOYeFps
 GcvrBrodWIB0z0CrNzL5Xzgu+SKK+WzcboY7xmqpisV0R5m9y+oQFaQrP7tvZMABNXkz
 A+XujH0IxwmLLWi53PqBZHNodGbEvMt3N6IhFHRMYVQ4HZzkpFFIssr3JctpM0577uAf
 onusGdvugwT4fibEfYIaoE70eYInPs3MTKu+ZdiM+6JOrqcIXFx48b/Y6c3/QApVyuFW
 qk2fCYXSMOBFaHaWWYgjNVFYfYEHzzeIZcgEw6hHnZqxjdrEOwYFq22d73rb/kLP0asK
 494Q==
X-Gm-Message-State: APjAAAVYUT5WpT/HklAhOz03UUizudxcw8EZotcwA8gHQTeVA2TreBw5
 Mbr2doEHcwpFU4mS59m5leA226phYlsJMXJLvef3XNfNsQwb1mHl75QNK+1Yd3ZKpS4UUzAClkv
 GARA6Ihog0lNMH1M=
X-Received: by 2002:a5d:538e:: with SMTP id d14mr2896587wrv.358.1575979279395; 
 Tue, 10 Dec 2019 04:01:19 -0800 (PST)
X-Google-Smtp-Source: APXvYqxxjEU9ohP8bAznw0YmlsL/RRuGX68c/tepXLPtdiFA3+p8EKVyt873Ou9VxyWnCHBdy0oDvw==
X-Received: by 2002:a5d:538e:: with SMTP id d14mr2896559wrv.358.1575979279100; 
 Tue, 10 Dec 2019 04:01:19 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id s16sm3008288wrn.78.2019.12.10.04.01.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Dec 2019 04:01:18 -0800 (PST)
Subject: Re: [PATCH v2 16/18] kvm: convert "-machine kvm_shadow_mem" to an
 accelerator property
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <1575903705-12925-1-git-send-email-pbonzini@redhat.com>
 <1575903705-12925-17-git-send-email-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c2c520f9-0bc9-6475-104f-95dc982cccae@redhat.com>
Date: Tue, 10 Dec 2019 13:01:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1575903705-12925-17-git-send-email-pbonzini@redhat.com>
Content-Language: en-US
X-MC-Unique: VkP8JvGJNfyLvQ3ku6gp5Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
>   accel/kvm/kvm-all.c | 43 +++++++++++++++++++++++++++++++++++++++++++
>   hw/core/machine.c   | 39 ---------------------------------------
>   include/hw/boards.h |  2 --
>   qemu-options.hx     |  6 +++---
>   target/i386/kvm.c   |  2 +-
>   vl.c                |  4 ++++
>   6 files changed, 51 insertions(+), 45 deletions(-)
>=20
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index ca00daa..f0b9294 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -41,6 +41,7 @@
>   #include "hw/irq.h"
>   #include "sysemu/sev.h"
>   #include "sysemu/balloon.h"
> +#include "qapi/visitor.h"
>  =20
>   #include "hw/boards.h"
>  =20
> @@ -92,6 +93,7 @@ struct KVMState
>       int max_nested_state_len;
>       int many_ioeventfds;
>       int intx_set_mask;
> +    int kvm_shadow_mem;
>       bool sync_mmu;
>       bool manual_dirty_log_protect;
>       /* The man page (and posix) say ioctl numbers are signed int, but
> @@ -2940,6 +2942,40 @@ static bool kvm_accel_has_memory(MachineState *ms,=
 AddressSpace *as,
>       return false;
>   }
>  =20
> +static void kvm_get_kvm_shadow_mem(Object *obj, Visitor *v,
> +                                   const char *name, void *opaque,
> +                                   Error **errp)
> +{
> +    KVMState *s =3D KVM_STATE(obj);
> +    int64_t value =3D s->kvm_shadow_mem;
> +
> +    visit_type_int(v, name, &value, errp);
> +}
> +
> +static void kvm_set_kvm_shadow_mem(Object *obj, Visitor *v,
> +                                   const char *name, void *opaque,
> +                                   Error **errp)
> +{
> +    KVMState *s =3D KVM_STATE(obj);
> +    Error *error =3D NULL;
> +    int64_t value;
> +
> +    visit_type_int(v, name, &value, &error);
> +    if (error) {
> +        error_propagate(errp, error);
> +        return;
> +    }
> +
> +    s->kvm_shadow_mem =3D value;
> +}
> +
> +static void kvm_accel_instance_init(Object *obj)
> +{
> +    KVMState *s =3D KVM_STATE(obj);
> +
> +    s->kvm_shadow_mem =3D -1;
> +}
> +
>   static void kvm_accel_class_init(ObjectClass *oc, void *data)
>   {
>       AccelClass *ac =3D ACCEL_CLASS(oc);
> @@ -2947,11 +2983,18 @@ static void kvm_accel_class_init(ObjectClass *oc,=
 void *data)
>       ac->init_machine =3D kvm_init;
>       ac->has_memory =3D kvm_accel_has_memory;
>       ac->allowed =3D &kvm_allowed;
> +
> +    object_class_property_add(oc, "kvm-shadow-mem", "int",
> +        kvm_get_kvm_shadow_mem, kvm_set_kvm_shadow_mem,
> +        NULL, NULL, &error_abort);
> +    object_class_property_set_description(oc, "kvm-shadow-mem",
> +        "KVM shadow MMU size", &error_abort);
>   }
>  =20
>   static const TypeInfo kvm_accel_type =3D {
>       .name =3D TYPE_KVM_ACCEL,
>       .parent =3D TYPE_ACCEL,
> +    .instance_init =3D kvm_accel_instance_init,
>       .class_init =3D kvm_accel_class_init,
>       .instance_size =3D sizeof(KVMState),
>   };
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index d7a0356..bfb5f6f 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -211,33 +211,6 @@ static void machine_set_kernel_irqchip(Object *obj, =
Visitor *v,
>       }
>   }
>  =20
> -static void machine_get_kvm_shadow_mem(Object *obj, Visitor *v,
> -                                       const char *name, void *opaque,
> -                                       Error **errp)
> -{
> -    MachineState *ms =3D MACHINE(obj);
> -    int64_t value =3D ms->kvm_shadow_mem;
> -
> -    visit_type_int(v, name, &value, errp);
> -}
> -
> -static void machine_set_kvm_shadow_mem(Object *obj, Visitor *v,
> -                                       const char *name, void *opaque,
> -                                       Error **errp)
> -{
> -    MachineState *ms =3D MACHINE(obj);
> -    Error *error =3D NULL;
> -    int64_t value;
> -
> -    visit_type_int(v, name, &value, &error);
> -    if (error) {
> -        error_propagate(errp, error);
> -        return;
> -    }
> -
> -    ms->kvm_shadow_mem =3D value;
> -}
> -
>   static char *machine_get_kernel(Object *obj, Error **errp)
>   {
>       MachineState *ms =3D MACHINE(obj);
> @@ -785,12 +758,6 @@ static void machine_class_init(ObjectClass *oc, void=
 *data)
>       object_class_property_set_description(oc, "kernel-irqchip",
>           "Configure KVM in-kernel irqchip", &error_abort);
>  =20
> -    object_class_property_add(oc, "kvm-shadow-mem", "int",
> -        machine_get_kvm_shadow_mem, machine_set_kvm_shadow_mem,
> -        NULL, NULL, &error_abort);
> -    object_class_property_set_description(oc, "kvm-shadow-mem",
> -        "KVM shadow MMU size", &error_abort);
> -
>       object_class_property_add_str(oc, "kernel",
>           machine_get_kernel, machine_set_kernel, &error_abort);
>       object_class_property_set_description(oc, "kernel",
> @@ -892,7 +859,6 @@ static void machine_initfn(Object *obj)
>  =20
>       ms->kernel_irqchip_allowed =3D true;
>       ms->kernel_irqchip_split =3D mc->default_kernel_irqchip_split;
> -    ms->kvm_shadow_mem =3D -1;
>       ms->dump_guest_core =3D true;
>       ms->mem_merge =3D true;
>       ms->enable_graphics =3D true;
> @@ -963,11 +929,6 @@ bool machine_kernel_irqchip_split(MachineState *mach=
ine)
>       return machine->kernel_irqchip_split;
>   }
>  =20
> -int machine_kvm_shadow_mem(MachineState *machine)
> -{
> -    return machine->kvm_shadow_mem;
> -}
> -
>   int machine_phandle_start(MachineState *machine)
>   {
>       return machine->phandle_start;
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index cdcf481..46119eb 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -66,7 +66,6 @@ bool machine_usb(MachineState *machine);
>   bool machine_kernel_irqchip_allowed(MachineState *machine);
>   bool machine_kernel_irqchip_required(MachineState *machine);
>   bool machine_kernel_irqchip_split(MachineState *machine);
> -int machine_kvm_shadow_mem(MachineState *machine);
>   int machine_phandle_start(MachineState *machine);
>   bool machine_dump_guest_core(MachineState *machine);
>   bool machine_mem_merge(MachineState *machine);
> @@ -278,7 +277,6 @@ struct MachineState {
>       bool kernel_irqchip_allowed;
>       bool kernel_irqchip_required;
>       bool kernel_irqchip_split;
> -    int kvm_shadow_mem;
>       char *dtb;
>       char *dumpdtb;
>       int phandle_start;
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 6f12b31..779c8af 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -34,7 +34,6 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
>       "                supported accelerators are kvm, xen, hax, hvf, whp=
x or tcg (default: tcg)\n"
>       "                kernel_irqchip=3Don|off|split controls accelerated=
 irqchip support (default=3Doff)\n"
>       "                vmport=3Don|off|auto controls emulation of vmport =
(default: auto)\n"
> -    "                kvm_shadow_mem=3Dsize of KVM shadow MMU in bytes\n"
>       "                dump-guest-core=3Don|off include guest memory in a=
 core dump (default=3Don)\n"
>       "                mem-merge=3Don|off controls memory merge support (=
default: on)\n"
>       "                aes-key-wrap=3Don|off controls support for AES key=
 wrapping (default=3Don)\n"
> @@ -74,8 +73,6 @@ Controls in-kernel irqchip support for the chosen accel=
erator when available.
>   Enables emulation of VMWare IO port, for vmmouse etc. auto says to sele=
ct the
>   value based on accel. For accel=3Dxen the default is off otherwise the =
default
>   is on.
> -@item kvm_shadow_mem=3Dsize
> -Defines the size of the KVM shadow MMU.
>   @item dump-guest-core=3Don|off
>   Include guest memory in a core dump. The default is on.
>   @item mem-merge=3Don|off
> @@ -118,6 +115,7 @@ DEF("accel", HAS_ARG, QEMU_OPTION_accel,
>       "-accel [accel=3D]accelerator[,prop[=3Dvalue][,...]]\n"
>       "                select accelerator (kvm, xen, hax, hvf, whpx or tc=
g; use 'help' for a list)\n"
>       "                igd-passthru=3Don|off (enable Xen integrated Intel=
 graphics passthrough, default=3Doff)\n"
> +    "                kvm-shadow-mem=3Dsize of KVM shadow MMU in bytes\n"
>       "                tb-size=3Dn (TCG translation block cache size)\n"
>       "                thread=3Dsingle|multi (enable multi-threaded TCG)\=
n", QEMU_ARCH_ALL)
>   STEXI
> @@ -131,6 +129,8 @@ fails to initialize.
>   @item igd-passthru=3Don|off
>   When Xen is in use, this option controls whether Intel integrated graph=
ics
>   devices can be passed through to the guest (default=3Doff)
> +@item kvm-shadow-mem=3Dsize
> +Defines the size of the KVM shadow MMU.
>   @item tb-size=3D@var{n}
>   Controls the size (in MiB) of the TCG translation block cache.
>   @item thread=3Dsingle|multi
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 1d10046..62ce681 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -2163,7 +2163,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>       }
>       qemu_register_reset(kvm_unpoison_all, NULL);
>  =20
> -    shadow_mem =3D machine_kvm_shadow_mem(ms);
> +    shadow_mem =3D object_property_get_int(OBJECT(s), "kvm-shadow-mem", =
&error_abort);
>       if (shadow_mem !=3D -1) {
>           shadow_mem /=3D 4096;
>           ret =3D kvm_vm_ioctl(s, KVM_SET_NR_MMU_PAGES, shadow_mem);
> diff --git a/vl.c b/vl.c
> index ee872f2..3678522 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -2639,6 +2639,10 @@ static int machine_set_property(void *opaque,
>           object_register_sugar_prop(ACCEL_CLASS_NAME("xen"), qom_name, v=
alue);
>           return 0;
>       }
> +    if (g_str_equal(qom_name, "kvm-shadow-mem")) {
> +        object_register_sugar_prop(ACCEL_CLASS_NAME("kvm"), qom_name, va=
lue);
> +        return 0;
> +    }
>  =20
>       return object_parse_property_opt(opaque, name, value, "type", errp)=
;
>   }
>=20

Nice.

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>


