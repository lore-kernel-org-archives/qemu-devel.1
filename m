Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 971CFC4727F
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 10:04:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C6282076E
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 10:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=blade-group.com header.i=@blade-group.com header.b="fby1aIrN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C6282076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=blade-group.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL1dO-0001Lf-2s
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 06:04:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38488)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antoine.damhet@blade-group.com>)
 id 1kL1Yz-0005s2-E1
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 05:59:49 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41982)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <antoine.damhet@blade-group.com>)
 id 1kL1Yw-0000ov-WC
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 05:59:48 -0400
Received: by mail-wr1-x443.google.com with SMTP id w5so20332910wrp.8
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2020 02:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blade-group.com; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=VeI4rJ+QRs2b+8OFtq6s9oel2aBDc63fJkYH4ntwSEs=;
 b=fby1aIrNzvU/cR1c5+6qaPdHVNmeE/LueEWms0xYJtByAW4kM66iExTRpPK9OIVoZH
 65Gy+FYQj+K+k7bY1JB7FIg8DfGcmiYcBZgwHDMh8VBa4espyv8km9SiLpk9DYZPnmVx
 S2y5U/UGERAyA4YXbjdqDQesCiz3AMJYWBiuqlzk+n89J2MsYySYXAf4bPZ34LAstcVS
 TFVpc7TQGvvhNKRsVY54hwmNzieLIVTiLFt8dTj+Uxl0TUrWTiLrgjVw04WaIhQEgP5y
 mnHn1uy5FI/nUIRADBGQRCbK2rNGgZqslX4rHDrPZ7/ZcGoBMXio7/nB2QRv4OYlUt15
 Xfkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=VeI4rJ+QRs2b+8OFtq6s9oel2aBDc63fJkYH4ntwSEs=;
 b=ALDnJIro/7phdtxdE6TMpMIiKT2Z+bZK4BrxdxJQlSdiCQ8657ZMDm1ZIM7MH/cuLR
 hyEOAKIlKcivQHzUzdTMlWhKE6yH+6AyZM/pu73xYc7Acj1iZ7AGt4JnRlflKdXBST1f
 OoTB5yJ9D/q1r09M7uOZxWrSD35IYn8hYk408ESNOagJqsbZB/7LC85hZZUyYMTYunma
 xAOmqzZwikN2mgJeFVX9Yvdj+5btoiCtmL2Ho12X8HXwcC88KfNpWyYSxarVLpdGVRqn
 E4Oa0LCWfwfppcnjell9x6mGQ2C1+PmyGanJL/8TtZTmNbmCjgdISXHnILxPI6XW3Iyd
 UWZg==
X-Gm-Message-State: AOAM530WSU20rVnBdGiQzli55CDNn/0KYdh5kRTPnemIURqa3JNinJ1z
 zHFvd0BnIVdhoGQ+XSmV2r8pLA==
X-Google-Smtp-Source: ABdhPJxnNlttSizOK3Cl+T7RCEuCxLtnwUHcLh184MrWGmtI6O7gzxcE+wyMA8M1Da35+VgVEpunZg==
X-Received: by 2002:a5d:634d:: with SMTP id b13mr10476497wrw.324.1600855184968; 
 Wed, 23 Sep 2020 02:59:44 -0700 (PDT)
Received: from localhost ([185.123.26.202])
 by smtp.gmail.com with ESMTPSA id o15sm7449021wmh.29.2020.09.23.02.59.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2020 02:59:43 -0700 (PDT)
Date: Wed, 23 Sep 2020 11:59:43 +0200
From: Antoine Damhet <antoine.damhet@blade-group.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH v2] target/i386: always create kvmclock device
Message-ID: <20200923095943.nxp32wqaqalbddmf@tartarus>
References: <20200922151934.899555-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="j64rnnc3jp4hhjoq"
Content-Disposition: inline
In-Reply-To: <20200922151934.899555-1-vkuznets@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=antoine.damhet@blade-group.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--j64rnnc3jp4hhjoq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

The patch doesn't apply cleanly to master but it works (patched ->
patched working, patched -> unpatched: old behavior, unpatched ->
patched: old behavior)

Thanks to everyone for the swift responses :)

On Tue, Sep 22, 2020 at 05:19:34PM +0200, Vitaly Kuznetsov wrote:
> QEMU's kvmclock device is only created when KVM PV feature bits for
> kvmclock (KVM_FEATURE_CLOCKSOURCE/KVM_FEATURE_CLOCKSOURCE2) are
> exposed to the guest. With 'kvm=3Doff' cpu flag the device is not
> created and we don't call KVM_GET_CLOCK/KVM_SET_CLOCK upon migration.
> It was reported that without these call at least Hyper-V TSC page
> clocksouce (which can be enabled independently) gets broken after
> migration.
>=20
> Switch to creating kvmclock QEMU device unconditionally, it seems
> to always make sense to call KVM_GET_CLOCK/KVM_SET_CLOCK on migration.
> Use KVM_CAP_ADJUST_CLOCK check instead of CPUID feature bits.
>=20
> Reported-by: Antoine Damhet <antoine.damhet@blade-group.com>
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>

Tested-by: Antoine Damhet <antoine.damhet@blade-group.com>

> ---
>  hw/i386/kvm/clock.c    | 7 +++++--
>  hw/i386/microvm.c      | 2 +-
>  hw/i386/pc.c           | 1 +
>  hw/i386/pc_piix.c      | 7 +++++--
>  hw/i386/pc_q35.c       | 5 ++++-
>  include/hw/i386/pc.h   | 3 +++
>  include/hw/kvm/clock.h | 4 ++--
>  target/i386/kvm.c      | 5 +++++
>  target/i386/kvm_i386.h | 1 +
>  9 files changed, 27 insertions(+), 8 deletions(-)
>=20
> diff --git a/hw/i386/kvm/clock.c b/hw/i386/kvm/clock.c
> index 64283358f91d..30cf53393ee1 100644
> --- a/hw/i386/kvm/clock.c
> +++ b/hw/i386/kvm/clock.c
> @@ -328,11 +328,14 @@ static const TypeInfo kvmclock_info =3D {
>  };
> =20
>  /* Note: Must be called after VCPU initialization. */
> -void kvmclock_create(void)
> +void kvmclock_create(bool create_always)
>  {
>      X86CPU *cpu =3D X86_CPU(first_cpu);
> =20
> -    if (kvm_enabled() &&
> +    if (!kvm_enabled() || !kvm_has_adjust_clock())
> +        return;
> +
> +    if (create_always ||
>          cpu->env.features[FEAT_KVM] & ((1ULL << KVM_FEATURE_CLOCKSOURCE)=
 |
>                                         (1ULL << KVM_FEATURE_CLOCKSOURCE2=
))) {
>          sysbus_create_simple(TYPE_KVM_CLOCK, -1, NULL);
> diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
> index 81d0888930d1..fd0b84109154 100644
> --- a/hw/i386/microvm.c
> +++ b/hw/i386/microvm.c
> @@ -119,7 +119,7 @@ static void microvm_devices_init(MicrovmMachineState =
*mms)
> =20
>      ioapic_init_gsi(gsi_state, "machine");
> =20
> -    kvmclock_create();
> +    kvmclock_create(true);
> =20
>      for (i =3D 0; i < VIRTIO_NUM_TRANSPORTS; i++) {
>          sysbus_create_simple("virtio-mmio",
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index d11daacc23cf..0e036ef9c15f 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1956,6 +1956,7 @@ static void pc_machine_class_init(ObjectClass *oc, =
void *data)
>      pcmc->acpi_data_size =3D 0x20000 + 0x8000;
>      pcmc->linuxboot_dma_enabled =3D true;
>      pcmc->pvh_enabled =3D true;
> +    pcmc->kvmclock_create_always =3D true;
>      assert(!mc->get_hotplug_handler);
>      mc->get_hotplug_handler =3D pc_get_hotplug_handler;
>      mc->hotplug_allowed =3D pc_hotplug_allowed;
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 32b1453e6a82..1a68338c737b 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -158,8 +158,8 @@ static void pc_init1(MachineState *machine,
> =20
>      x86_cpus_init(x86ms, pcmc->default_cpu_version);
> =20
> -    if (kvm_enabled() && pcmc->kvmclock_enabled) {
> -        kvmclock_create();
> +    if (pcmc->kvmclock_enabled) {
> +        kvmclock_create(pcmc->kvmclock_create_always);
>      }
> =20
>      if (pcmc->pci_enabled) {
> @@ -440,11 +440,14 @@ DEFINE_I440FX_MACHINE(v5_2, "pc-i440fx-5.2", NULL,
> =20
>  static void pc_i440fx_5_1_machine_options(MachineClass *m)
>  {
> +    PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
> +
>      pc_i440fx_5_2_machine_options(m);
>      m->alias =3D NULL;
>      m->is_default =3D false;
>      compat_props_add(m->compat_props, hw_compat_5_1, hw_compat_5_1_len);
>      compat_props_add(m->compat_props, pc_compat_5_1, pc_compat_5_1_len);
> +    pcmc->kvmclock_create_always =3D false;
>  }
> =20
>  DEFINE_I440FX_MACHINE(v5_1, "pc-i440fx-5.1", NULL,
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index 0cb9c18cd44d..0dd59bd765b1 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -185,7 +185,7 @@ static void pc_q35_init(MachineState *machine)
> =20
>      x86_cpus_init(x86ms, pcmc->default_cpu_version);
> =20
> -    kvmclock_create();
> +    kvmclock_create(pcmc->kvmclock_create_always);
> =20
>      /* pci enabled */
>      if (pcmc->pci_enabled) {
> @@ -366,10 +366,13 @@ DEFINE_Q35_MACHINE(v5_2, "pc-q35-5.2", NULL,
> =20
>  static void pc_q35_5_1_machine_options(MachineClass *m)
>  {
> +    PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
> +
>      pc_q35_5_2_machine_options(m);
>      m->alias =3D NULL;
>      compat_props_add(m->compat_props, hw_compat_5_1, hw_compat_5_1_len);
>      compat_props_add(m->compat_props, pc_compat_5_1, pc_compat_5_1_len);
> +    pcmc->kvmclock_create_always =3D false;
>  }
> =20
>  DEFINE_Q35_MACHINE(v5_1, "pc-q35-5.1", NULL,
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index fe52e165b27c..6b22671434b9 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -118,6 +118,9 @@ typedef struct PCMachineClass {
> =20
>      /* use PVH to load kernels that support this feature */
>      bool pvh_enabled;
> +
> +    /* create kvmclock device even when KVM PV features are not exposed =
*/
> +    bool kvmclock_create_always;
>  } PCMachineClass;
> =20
>  #define TYPE_PC_MACHINE "generic-pc-machine"
> diff --git a/include/hw/kvm/clock.h b/include/hw/kvm/clock.h
> index 81c66b230207..7994071c4fee 100644
> --- a/include/hw/kvm/clock.h
> +++ b/include/hw/kvm/clock.h
> @@ -15,11 +15,11 @@
> =20
>  #ifdef CONFIG_KVM
> =20
> -void kvmclock_create(void);
> +void kvmclock_create(bool create_always);
> =20
>  #else /* CONFIG_KVM */
> =20
> -static inline void kvmclock_create(void)
> +static inline void kvmclock_create(bool create_always)
>  {
>  }
> =20
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 4a8b3a41c1bc..20b31b65307b 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -143,6 +143,11 @@ bool kvm_has_adjust_clock_stable(void)
>      return (ret =3D=3D KVM_CLOCK_TSC_STABLE);
>  }
> =20
> +bool kvm_has_adjust_clock(void)
> +{
> +    return kvm_check_extension(kvm_state, KVM_CAP_ADJUST_CLOCK);
> +}
> +
>  bool kvm_has_exception_payload(void)
>  {
>      return has_exception_payload;
> diff --git a/target/i386/kvm_i386.h b/target/i386/kvm_i386.h
> index 064b8798a26c..0fce4e51d2d6 100644
> --- a/target/i386/kvm_i386.h
> +++ b/target/i386/kvm_i386.h
> @@ -34,6 +34,7 @@
> =20
>  bool kvm_allows_irq0_override(void);
>  bool kvm_has_smm(void);
> +bool kvm_has_adjust_clock(void);
>  bool kvm_has_adjust_clock_stable(void);
>  bool kvm_has_exception_payload(void);
>  void kvm_synchronize_all_tsc(void);
> --=20
> 2.25.4
>=20

--=20
Antoine 'xdbob' Damhet

--j64rnnc3jp4hhjoq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEArm1WbQx2GmOsfF83AmjLzzljz4FAl9rHIsACgkQ3AmjLzzl
jz5z1Af8DUwFNHvCEkSZwutfv36K0wKFUNr28pvptVSAgS4IZXwUiRbjLzBVubz9
q/RpO3JuCJKeKjTqDhYAvVU3oaH6e0Ctgdu7BczAer03IWWy8lYGkr+GRB1BNfQE
kDb7uXKQpvQdZtCqSYNwah6h6y3Ph2lbv1P7kpOVoFFfoy8zmqHXULlRownOxEeC
WCxUdHlALlA25dTlQfGgimejBsyFkFcgxzNChHsJiYhfmMf6q8cknoNiqmrS3Lji
AnUfXKqmWlDFa4Uus3bjo5E6mGJC4v6W158HGZCFKOUcMlcIwx3u4MaEt4V8k+L7
hjb92ytDWT8dpeLFVevFjqqrVhgLCw==
=RAsy
-----END PGP SIGNATURE-----

--j64rnnc3jp4hhjoq--

