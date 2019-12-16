Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3656C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 15:15:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D9EF20409
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 15:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YKWpQCS5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D9EF20409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55291 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igs5T-0002kA-Jk
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 10:15:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52965)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1igs4c-0001aH-Ny
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 10:14:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1igs4b-0004Oq-Bs
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 10:14:14 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:37903)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1igs4b-0004N4-4I
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 10:14:13 -0500
Received: by mail-ot1-x341.google.com with SMTP id h20so9599469otn.5
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 07:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hcPF0Wp6AEwCHVAM39VUCb0pgGQ7HDSvkvxVAmJmL30=;
 b=YKWpQCS5Q+0IwhiJNjMyx1PDn8ePF6L6JE8d7WNq9HvJzsMn6LE9T55Ko/VKPRXWNy
 uR5apWZ3kzy/BU2z7iFFyjAVO/fzTSuZUGzChpJwvGdnhN5kWQZ7/fsZFI6CVa+JZWuI
 OVtF/5yIXAebQPNohZO6eHmQBIwKo4JeBHFBFpdJmlptu57Fi+cXxE3o9XPNYkaSpZ2s
 MuFrATi/h/vLje4phVHSnAG7Fp9W5uj22mhOf/o7R8xsWOVw35Carau24CPJFSsyuFfC
 2dFsSBPmCET1AX9YkpbOGl+3iu8QmJhk6jL36T4goaEqR2pbusuTxgtOe+rdEtfzWIVA
 PksQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hcPF0Wp6AEwCHVAM39VUCb0pgGQ7HDSvkvxVAmJmL30=;
 b=PgohZflSCZ6reQbi+a+bKpfHV4JNZwz+HCEWmDparP6UH+BlZ4x3F4d5IsHTAYwITV
 aCaka5YB6H7GW6k0lEsVOHJH5Sz3SSwmSBQOwaRWa+liaaUUgNVF/tAtRPkwvoTFfaQW
 lGiZbIH4JOVBRyYsTd0Ef/DvLfkYnIrsAnsgA75lHz0g2PKKGcEVDM1w0HJjPfsA4vjR
 tAQSSRoE5/OAhSFxIaNHF/n0JWbOpf9AR5csWbZ3XiO1Fq9+EZWUz5NlUDL7j6ROaMWk
 Rt85IKvk09SIW4AkLawacsSfLMvHedCI/8dMq3tk8DUAaB+5/Ny/LeLjqT83Emqa7s5I
 9XDQ==
X-Gm-Message-State: APjAAAVLYkWtvXJDu9Ql6VuJiAUIR62PIEqmRewvWPzPPueeb8ZBCuaS
 w+HbB8MVAfr9G/87ezC4aEOWqc6XjMgo/hb1jEVLVw==
X-Google-Smtp-Source: APXvYqy6v02O7Jw0i7l5EZivPalXSzw9o8ddDZVmMl6Hqot8eaePEC8Ew+WGs+QK8is/usZC5BuM2qENKXp4iX3MKW4=
X-Received: by 2002:a05:6830:2001:: with SMTP id
 e1mr30757996otp.97.1576509251530; 
 Mon, 16 Dec 2019 07:14:11 -0800 (PST)
MIME-Version: 1.0
References: <20191212173320.11610-1-drjones@redhat.com>
 <20191212173320.11610-4-drjones@redhat.com>
In-Reply-To: <20191212173320.11610-4-drjones@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Dec 2019 15:14:00 +0000
Message-ID: <CAFEAcA_u94O8WYLgB8DF=pu-3V7LrNWpiQFV5mDYeeqLj1Ee2Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/5] target/arm/kvm: Implement virtual time
 adjustment
To: Andrew Jones <drjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: bijan.mottahedeh@oracle.com, Marc Zyngier <maz@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Heyi Guo <guoheyi@huawei.com>, msys.mizuma@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 12 Dec 2019 at 17:33, Andrew Jones <drjones@redhat.com> wrote:
>
> When a VM is stopped (guest is paused) guest virtual time
> should stop counting. Otherwise, when the VM is resumed it
> will experience time jumps and its kernel may report soft
> lockups. Not counting virtual time while the VM is stopped
> has the side effect of making the guest's time appear to lag
> when compared with real time, and even with time derived from
> the physical counter. For this reason, this change, which is
> enabled by default, comes with a KVM CPU feature allowing it
> to be disabled, restoring legacy behavior.
>
> This patch only provides the implementation of the virtual
> time adjustment. A subsequent patch will provide the CPU
> property allowing the change to be enabled and disabled.
>
> Reported-by: Bijan Mottahedeh <bijan.mottahedeh@oracle.com>
> Signed-off-by: Andrew Jones <drjones@redhat.com>
> ---
>  target/arm/cpu.h     |  9 +++++++++
>  target/arm/kvm.c     | 48 ++++++++++++++++++++++++++++++++++++++++++++
>  target/arm/kvm32.c   |  3 +++
>  target/arm/kvm64.c   |  3 +++
>  target/arm/kvm_arm.h | 23 +++++++++++++++++++++
>  5 files changed, 86 insertions(+)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 83a809d4bac4..a79ea74125b3 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -821,6 +821,15 @@ struct ARMCPU {
>      /* KVM init features for this CPU */
>      uint32_t kvm_init_features[7];
>
> +    /* KVM CPU features */
> +    bool kvm_adjvtime;
> +
> +    /* VCPU virtual counter value used with kvm_adjvtime */
> +    uint64_t kvm_vtime;

How does this new state interact with migration ?

> +
> +    /* True if the run state is, or transitioning from, RUN_STATE_PAUSED */
> +    bool runstate_paused;
> +
>      /* Uniprocessor system with MP extensions */
>      bool mp_is_up;
>
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 5b82cefef608..a55fe7d7aefd 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -348,6 +348,24 @@ void kvm_arm_register_device(MemoryRegion *mr, uint64_t devid, uint64_t group,
>      memory_region_ref(kd->mr);
>  }
>
> +void kvm_arm_vm_state_change(void *opaque, int running, RunState state)
> +{
> +    CPUState *cs = opaque;
> +    ARMCPU *cpu = ARM_CPU(cs);
> +
> +    if (running) {
> +        if (cpu->kvm_adjvtime && cpu->runstate_paused) {
> +            kvm_arm_set_virtual_time(cs, cpu->kvm_vtime);
> +        }
> +        cpu->runstate_paused = false;
> +    } else if (state == RUN_STATE_PAUSED) {
> +        cpu->runstate_paused = true;
> +        if (cpu->kvm_adjvtime) {
> +            kvm_arm_get_virtual_time(cs, &cpu->kvm_vtime);
> +        }
> +    }
> +}

How does this interact with the usual register sync to/from
KVM (ie kvm_arch_get_registers(), which I think will do a
GET_ONE_REG read of the TIMER_CNT register the way it does
any other sysreg, inside write_kvmstate_to_list(), plus
kvm_arch_set_registers() which does the write back to the
kernel in write_list_to_kvmstate()) ? Presumably we want this
version to take precedence by the set_virtual_time call
happening after the kvm_arch_set_registers, but is this
guaranteed ?

thanks
-- PMM

