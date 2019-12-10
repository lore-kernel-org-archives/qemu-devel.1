Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28BB4C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 12:05:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D571920836
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 12:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M2okRH6l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D571920836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieeH6-0005Ma-9S
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 07:05:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37327)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ieeEL-0003Ct-SZ
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 07:03:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ieeEK-0006Xd-2z
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 07:03:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24903
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ieeEJ-0006XR-Uo
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 07:03:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575979383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ej1cdd1/2ywnJqbbosqKTJd3QuKXRmJNCa1lj7lJqwc=;
 b=M2okRH6leblZHUj4Suou38CY6s0QGigHae0nwYOebi85tgq2EksbyOAuR96x4Pa+0yYUG9
 bSQMEmNJbInjuKaBBqnsciUZwdFaW6WPYxfnGSe/HH3bh6wNHEqqCiRWu8aYKtsjtZQSPC
 k6uuyPIWssqotoBiqeegHFfTl/eTwjE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-I9-__mq0OMGK56e8eVnX5Q-1; Tue, 10 Dec 2019 07:02:59 -0500
Received: by mail-wr1-f69.google.com with SMTP id r2so8858670wrp.7
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2019 04:02:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Q/92MHNYSrImkYBzVjq219u37Spket10BC1Q9Cli2ik=;
 b=FdGTUdb+HjZbWqfuqDbYyZus9wdykAqLN3uMwlZN9SP6NY1pcD7CFhjepjUWGAe4gN
 DofT2U5q+8hJTSefGtDKcrGyyfMOVYpfQbx1KfTPuPtoQBDIObBsU/qjJy+TV5bZbR+N
 KclRFvlIAjCD6bnalxBD6mQpH2WIji/2yD/mxnX1myt8htPhj9JSnnL8hrt0GZwSKO+6
 AVOMaZ7Y6i+z5uVAWzXVlY26X4Lg2tHrdT0ltbg4za2nwQisQC5OLvVuUuEn20WpPwtb
 rGWnHMppiopQAmakyY+hrx7vEWQt6tVHB3kZ+FyQeua6A1eladZVoRkCj6/8U+XHhLP0
 CJpQ==
X-Gm-Message-State: APjAAAWRQMqV8S+9PRuHtLk96AeoQO3mjpQsd0nk5AFKALV2eif3QpCP
 3fVli0zKqCjWgAPDd8B5MvR9T8TF1DYcymNkPtOuZLH2TAQ7HeltFMAjRB+AJUJpkxXNqGuOyT5
 IrQxhhB7gnPPpgAk=
X-Received: by 2002:a05:6000:1052:: with SMTP id
 c18mr2866123wrx.268.1575979378200; 
 Tue, 10 Dec 2019 04:02:58 -0800 (PST)
X-Google-Smtp-Source: APXvYqz9mAelTnNOfipbUYURVsw69dsESAWKUsLiBBvOGFCtcfMR1FNeiexie1L5boUTE9ge2d3H5A==
X-Received: by 2002:a05:6000:1052:: with SMTP id
 c18mr2866093wrx.268.1575979377903; 
 Tue, 10 Dec 2019 04:02:57 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id n10sm3011845wrt.14.2019.12.10.04.02.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Dec 2019 04:02:57 -0800 (PST)
Subject: Re: [PATCH v2 17/18] kvm: introduce kvm_kernel_irqchip_* functions
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <1575903705-12925-1-git-send-email-pbonzini@redhat.com>
 <1575903705-12925-18-git-send-email-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e2aa550a-1012-092d-aa1c-816f5e7a4b6c@redhat.com>
Date: Tue, 10 Dec 2019 13:02:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1575903705-12925-18-git-send-email-pbonzini@redhat.com>
Content-Language: en-US
X-MC-Unique: I9-__mq0OMGK56e8eVnX5Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: thuth@redhat.com, elmarco@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/9/19 4:01 PM, Paolo Bonzini wrote:
> The KVMState struct is opaque, so provide accessors for the fields
> that will be moved from current_machine to the accelerator.  For now
> they just forward to the machine object, but this will change.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

> ---
>   accel/kvm/kvm-all.c  | 23 +++++++++++++++++++----
>   hw/ppc/e500.c        |  4 ++--
>   hw/ppc/spapr_irq.c   | 10 +++++-----
>   include/sysemu/kvm.h |  7 +++++--
>   target/arm/kvm.c     |  8 ++++----
>   target/i386/kvm.c    |  4 ++--
>   target/mips/kvm.c    |  2 +-
>   target/ppc/kvm.c     |  2 +-
>   target/s390x/kvm.c   |  2 +-
>   9 files changed, 40 insertions(+), 22 deletions(-)
>=20
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index f0b9294..c0a6351 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -1760,7 +1760,7 @@ void kvm_irqchip_set_qemuirq_gsi(KVMState *s, qemu_=
irq irq, int gsi)
>       g_hash_table_insert(s->gsimap, irq, GINT_TO_POINTER(gsi));
>   }
>  =20
> -static void kvm_irqchip_create(MachineState *machine, KVMState *s)
> +static void kvm_irqchip_create(KVMState *s)
>   {
>       int ret;
>  =20
> @@ -1778,9 +1778,9 @@ static void kvm_irqchip_create(MachineState *machin=
e, KVMState *s)
>  =20
>       /* First probe and see if there's a arch-specific hook to create th=
e
>        * in-kernel irqchip for us */
> -    ret =3D kvm_arch_irqchip_create(machine, s);
> +    ret =3D kvm_arch_irqchip_create(s);
>       if (ret =3D=3D 0) {
> -        if (machine_kernel_irqchip_split(machine)) {
> +        if (kvm_kernel_irqchip_split()) {
>               perror("Split IRQ chip mode not supported.");
>               exit(1);
>           } else {
> @@ -2052,7 +2052,7 @@ static int kvm_init(MachineState *ms)
>       }
>  =20
>       if (machine_kernel_irqchip_allowed(ms)) {
> -        kvm_irqchip_create(ms, s);
> +        kvm_irqchip_create(s);
>       }
>  =20
>       if (kvm_eventfds_allowed) {
> @@ -2969,6 +2969,21 @@ static void kvm_set_kvm_shadow_mem(Object *obj, Vi=
sitor *v,
>       s->kvm_shadow_mem =3D value;
>   }
>  =20
> +bool kvm_kernel_irqchip_allowed(void)
> +{
> +    return machine_kernel_irqchip_allowed(current_machine);
> +}
> +
> +bool kvm_kernel_irqchip_required(void)
> +{
> +    return machine_kernel_irqchip_required(current_machine);
> +}
> +
> +bool kvm_kernel_irqchip_split(void)
> +{
> +    return machine_kernel_irqchip_split(current_machine);
> +}
> +
>   static void kvm_accel_instance_init(Object *obj)
>   {
>       KVMState *s =3D KVM_STATE(obj);
> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
> index 91cd4c2..928efaa 100644
> --- a/hw/ppc/e500.c
> +++ b/hw/ppc/e500.c
> @@ -801,10 +801,10 @@ static DeviceState *ppce500_init_mpic(PPCE500Machin=
eState *pms,
>       if (kvm_enabled()) {
>           Error *err =3D NULL;
>  =20
> -        if (machine_kernel_irqchip_allowed(machine)) {
> +        if (kvm_kernel_irqchip_allowed()) {
>               dev =3D ppce500_init_mpic_kvm(pmc, irqs, &err);
>           }
> -        if (machine_kernel_irqchip_required(machine) && !dev) {
> +        if (kvm_kernel_irqchip_required() && !dev) {
>               error_reportf_err(err,
>                                 "kernel_irqchip requested but unavailable=
: ");
>               exit(1);
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index d6bb7fd..c3f8870 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -77,9 +77,9 @@ int spapr_irq_init_kvm(int (*fn)(SpaprInterruptControll=
er *, Error **),
>       MachineState *machine =3D MACHINE(qdev_get_machine());
>       Error *local_err =3D NULL;
>  =20
> -    if (kvm_enabled() && machine_kernel_irqchip_allowed(machine)) {
> +    if (kvm_enabled() && kvm_kernel_irqchip_allowed()) {
>           if (fn(intc, &local_err) < 0) {
> -            if (machine_kernel_irqchip_required(machine)) {
> +            if (kvm_kernel_irqchip_required()) {
>                   error_prepend(&local_err,
>                                 "kernel_irqchip requested but unavailable=
: ");
>                   error_propagate(errp, local_err);
> @@ -184,7 +184,7 @@ static int spapr_irq_check(SpaprMachineState *spapr, =
Error **errp)
>        */
>       if (kvm_enabled() &&
>           spapr->irq =3D=3D &spapr_irq_dual &&
> -        machine_kernel_irqchip_required(machine) &&
> +        kvm_kernel_irqchip_required() &&
>           xics_kvm_has_broken_disconnect(spapr)) {
>           error_setg(errp, "KVM is too old to support ic-mode=3Ddual,kern=
el-irqchip=3Don");
>           return -1;
> @@ -290,12 +290,12 @@ void spapr_irq_init(SpaprMachineState *spapr, Error=
 **errp)
>       MachineState *machine =3D MACHINE(spapr);
>       SpaprMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
>  =20
> -    if (machine_kernel_irqchip_split(machine)) {
> +    if (kvm_enabled() && kvm_kernel_irqchip_split()) {
>           error_setg(errp, "kernel_irqchip split mode not supported on ps=
eries");
>           return;
>       }
>  =20
> -    if (!kvm_enabled() && machine_kernel_irqchip_required(machine)) {
> +    if (!kvm_enabled() && kvm_kernel_irqchip_required()) {
>           error_setg(errp,
>                      "kernel_irqchip requested but only available with KV=
M");
>           return;
> diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
> index 9fe233b..aaf2a50 100644
> --- a/include/sysemu/kvm.h
> +++ b/include/sysemu/kvm.h
> @@ -519,10 +519,13 @@ void kvm_pc_gsi_handler(void *opaque, int n, int le=
vel);
>   void kvm_pc_setup_irq_routing(bool pci_enabled);
>   void kvm_init_irq_routing(KVMState *s);
>  =20
> +bool kvm_kernel_irqchip_allowed(void);
> +bool kvm_kernel_irqchip_required(void);
> +bool kvm_kernel_irqchip_split(void);
> +
>   /**
>    * kvm_arch_irqchip_create:
>    * @KVMState: The KVMState pointer
> - * @MachineState: The MachineState pointer
>    *
>    * Allow architectures to create an in-kernel irq chip themselves.
>    *
> @@ -530,7 +533,7 @@ void kvm_init_irq_routing(KVMState *s);
>    *            0: irq chip was not created
>    *          > 0: irq chip was created
>    */
> -int kvm_arch_irqchip_create(MachineState *ms, KVMState *s);
> +int kvm_arch_irqchip_create(KVMState *s);
>  =20
>   /**
>    * kvm_set_one_reg - set a register value in KVM via KVM_SET_ONE_REG io=
ctl
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 5b82cef..b87b59a 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -741,11 +741,11 @@ void kvm_arch_init_irq_routing(KVMState *s)
>   {
>   }
>  =20
> -int kvm_arch_irqchip_create(MachineState *ms, KVMState *s)
> +int kvm_arch_irqchip_create(KVMState *s)
>   {
> -     if (machine_kernel_irqchip_split(ms)) {
> -         perror("-machine kernel_irqchip=3Dsplit is not supported on ARM=
.");
> -         exit(1);
> +    if (kvm_kernel_irqchip_split()) {
> +        perror("-machine kernel_irqchip=3Dsplit is not supported on ARM.=
");
> +        exit(1);
>       }
>  =20
>       /* If we can create the VGIC using the newer device control API, we
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 62ce681..ef63f3a 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -4494,10 +4494,10 @@ void kvm_arch_init_irq_routing(KVMState *s)
>       }
>   }
>  =20
> -int kvm_arch_irqchip_create(MachineState *ms, KVMState *s)
> +int kvm_arch_irqchip_create(KVMState *s)
>   {
>       int ret;
> -    if (machine_kernel_irqchip_split(ms)) {
> +    if (kvm_kernel_irqchip_split()) {
>           ret =3D kvm_vm_enable_cap(s, KVM_CAP_SPLIT_IRQCHIP, 0, 24);
>           if (ret) {
>               error_report("Could not enable split irqchip mode: %s",
> diff --git a/target/mips/kvm.c b/target/mips/kvm.c
> index 578bc14..de3e26e 100644
> --- a/target/mips/kvm.c
> +++ b/target/mips/kvm.c
> @@ -57,7 +57,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>       return 0;
>   }
>  =20
> -int kvm_arch_irqchip_create(MachineState *ms, KVMState *s)
> +int kvm_arch_irqchip_create(KVMState *s)
>   {
>       return 0;
>   }
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index c77f984..461dc6d 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -152,7 +152,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>       return 0;
>   }
>  =20
> -int kvm_arch_irqchip_create(MachineState *ms, KVMState *s)
> +int kvm_arch_irqchip_create(KVMState *s)
>   {
>       return 0;
>   }
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index 0c9d14b..f3a742b 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -374,7 +374,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>       return 0;
>   }
>  =20
> -int kvm_arch_irqchip_create(MachineState *ms, KVMState *s)
> +int kvm_arch_irqchip_create(KVMState *s)
>   {
>       return 0;
>   }
>=20


