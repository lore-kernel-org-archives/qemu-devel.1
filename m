Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B07C33CA9
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 02:01:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE97F20CC7
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 02:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="usT/kVCS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE97F20CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irBWc-0003wT-BO
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 21:01:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46945)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1irBU9-0001Un-Kx
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 20:59:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1irBU8-000050-Bm
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 20:59:13 -0500
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:38787)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1irBU8-0008Ty-40; Mon, 13 Jan 2020 20:59:12 -0500
Received: by mail-lf1-x143.google.com with SMTP id r14so8483311lfm.5;
 Mon, 13 Jan 2020 17:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=G2QO+CSZjAl2honZM+PyUNevyOI6yY7VpogO/MBbalQ=;
 b=usT/kVCSExlmyNayfhnZNh7UGeTN5yPzMauPArjgNBy8lEn5OCcgmURhvQHpa3z2Lw
 PYZs4+CNpGKRRYg3XyiBLZfpmmQhhRl5zlfAvs2zqhOLQQXq+9BIeqbPIrvmUitT+Oo0
 XJSvvFmKvnuiHhZjCMzh9VrZ/zPxJGwjwmbIC/62TZveVFJAH1ChQyJy3T6QZVswdRaZ
 2SkJGTf9Z3AHXUj80Huqke95TdoD6FXSHoX8ILFX8WpOtMk8Y20rBiH7qJgxDchGe7Ky
 hjmdW8Uztw5PMjOnW5yLaxvgClrt5Hd37DqV+xuFDKeX7SLUJsw7IfQGO8t99d0/42J1
 xISA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=G2QO+CSZjAl2honZM+PyUNevyOI6yY7VpogO/MBbalQ=;
 b=k/hsVXm0DeREXNvZ9klT5Sr8JBJBDW6aEllKNGcTrD537NfATdIEA0aqbUOiaYl+ia
 HykDoRG6QVEvZh1Pr6MXIhrwdQtR+yvgTJE9IsQIk36Ax9lMN1FWuRZOO6GM15dS00PI
 vSvnbtOd22HXkw7xI929ftBjvdV796EJx0IHqutCIHQ8+DDysXts+Z6xuYYC8N73mVjR
 A6S8rPFE92zWLI1lX8+u74a0vPVVZ6qDZc9Ht1E/JEwyxLMfUVHFv3iLGp3jo1MqQVpW
 DEY3HxZLGbkFzAmxGBtoxpm4IkiNCnSvjU8GygdJXcCzRDQahuQR8tYcjuyH4/V9UvNm
 pxaw==
X-Gm-Message-State: APjAAAULg5rW8Kzy4d77Wqzn/t/xYgZCFEsvmB/5zsyFV/w4C+Ax/jy+
 R1Vm9A4TKI2FCEeipX+k8prq+oLImGsDx1vlCDM=
X-Google-Smtp-Source: APXvYqyMolQ56ECk030qpcJ/Xxdzh/HLaowZNX6TD9VxXE+Er2v4KavgYxo6zpWl1cEbUIC1zNZmMfu1nMvoWuL8tsU=
X-Received: by 2002:a19:e30b:: with SMTP id a11mr243834lfh.48.1578967150070;
 Mon, 13 Jan 2020 17:59:10 -0800 (PST)
MIME-Version: 1.0
References: <20200109152133.23649-1-philmd@redhat.com>
 <20200109152133.23649-14-philmd@redhat.com>
In-Reply-To: <20200109152133.23649-14-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 14 Jan 2020 11:58:43 +1000
Message-ID: <CAKmqyKNQbbuxz9jnwa5A8FiXofU9jSwMSHp1LpXmrrAQyM_ddA@mail.gmail.com>
Subject: Re: [PATCH 13/15] accel: Replace current_machine->accelerator by
 current_accel() method
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::143
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "open list:Overall" <kvm@vger.kernel.org>, Juan Quintela <quintela@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 "open list:New World" <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <rth@twiddle.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jan 10, 2020 at 1:38 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> As we want to remove the global current_machine,
> replace 'current_machine->accelerator' by current_accel().
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  accel/kvm/kvm-all.c | 4 ++--
>  accel/tcg/tcg-all.c | 2 +-
>  memory.c            | 2 +-
>  target/arm/kvm64.c  | 4 ++--
>  target/i386/kvm.c   | 2 +-
>  target/ppc/kvm.c    | 2 +-
>  vl.c                | 2 +-
>  7 files changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index b2f1a5bcb5..be1980f250 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -164,7 +164,7 @@ static NotifierList kvm_irqchip_change_notifiers =3D
>
>  int kvm_get_max_memslots(void)
>  {
> -    KVMState *s =3D KVM_STATE(current_machine->accelerator);
> +    KVMState *s =3D KVM_STATE(current_accel());
>
>      return s->nr_slots;
>  }
> @@ -1847,7 +1847,7 @@ static int kvm_max_vcpu_id(KVMState *s)
>
>  bool kvm_vcpu_id_is_valid(int vcpu_id)
>  {
> -    KVMState *s =3D KVM_STATE(current_machine->accelerator);
> +    KVMState *s =3D KVM_STATE(current_accel());
>      return vcpu_id >=3D 0 && vcpu_id < kvm_max_vcpu_id(s);
>  }
>
> diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
> index 1dc384c8d2..1802ce02f6 100644
> --- a/accel/tcg/tcg-all.c
> +++ b/accel/tcg/tcg-all.c
> @@ -124,7 +124,7 @@ static void tcg_accel_instance_init(Object *obj)
>
>  static int tcg_init(MachineState *ms)
>  {
> -    TCGState *s =3D TCG_STATE(current_machine->accelerator);
> +    TCGState *s =3D TCG_STATE(current_accel());
>
>      tcg_exec_init(s->tb_size * 1024 * 1024);
>      cpu_interrupt_handler =3D tcg_handle_interrupt;
> diff --git a/memory.c b/memory.c
> index 57e38b1f50..60e8993499 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -3106,7 +3106,7 @@ void mtree_info(bool flatview, bool dispatch_tree, =
bool owner)
>          };
>          GArray *fv_address_spaces;
>          GHashTable *views =3D g_hash_table_new(g_direct_hash, g_direct_e=
qual);
> -        AccelClass *ac =3D ACCEL_GET_CLASS(current_machine->accelerator)=
;
> +        AccelClass *ac =3D ACCEL_GET_CLASS(current_accel());
>
>          if (ac->has_memory) {
>              fvi.ac =3D ac;
> diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
> index 876184b8fe..f677877a1e 100644
> --- a/target/arm/kvm64.c
> +++ b/target/arm/kvm64.c
> @@ -613,14 +613,14 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatur=
es *ahcf)
>
>  bool kvm_arm_aarch32_supported(CPUState *cpu)
>  {
> -    KVMState *s =3D KVM_STATE(current_machine->accelerator);
> +    KVMState *s =3D KVM_STATE(current_accel());
>
>      return kvm_check_extension(s, KVM_CAP_ARM_EL1_32BIT);
>  }
>
>  bool kvm_arm_sve_supported(CPUState *cpu)
>  {
> -    KVMState *s =3D KVM_STATE(current_machine->accelerator);
> +    KVMState *s =3D KVM_STATE(current_accel());
>
>      return kvm_check_extension(s, KVM_CAP_ARM_SVE);
>  }
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 0b511906e3..2ed15814dc 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -147,7 +147,7 @@ bool kvm_allows_irq0_override(void)
>
>  static bool kvm_x2apic_api_set_flags(uint64_t flags)
>  {
> -    KVMState *s =3D KVM_STATE(current_machine->accelerator);
> +    KVMState *s =3D KVM_STATE(current_accel());
>
>      return !kvm_vm_enable_cap(s, KVM_CAP_X2APIC_API, 0, flags);
>  }
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index d1c334f0e3..2d011308e0 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -258,7 +258,7 @@ static void kvm_get_smmu_info(struct kvm_ppc_smmu_inf=
o *info, Error **errp)
>
>  struct ppc_radix_page_info *kvm_get_radix_page_info(void)
>  {
> -    KVMState *s =3D KVM_STATE(current_machine->accelerator);
> +    KVMState *s =3D KVM_STATE(current_accel());
>      struct ppc_radix_page_info *radix_page_info;
>      struct kvm_ppc_rmmu_info rmmu_info;
>      int i;
> diff --git a/vl.c b/vl.c
> index 86474a55c9..3ff3548183 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -2804,7 +2804,7 @@ static void configure_accelerators(const char *prog=
name)
>      }
>
>      if (init_failed) {
> -        AccelClass *ac =3D ACCEL_GET_CLASS(current_machine->accelerator)=
;
> +        AccelClass *ac =3D ACCEL_GET_CLASS(current_accel());
>          error_report("falling back to %s", ac->name);
>      }
>
> --
> 2.21.1
>
>

