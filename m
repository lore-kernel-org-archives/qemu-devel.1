Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FDCBC43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 15:07:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0879D206D7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 15:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uqmwW+fR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0879D206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igryW-0007De-UO
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 10:07:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51068)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1igrxn-0006WO-K0
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 10:07:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1igrxm-0004FG-22
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 10:07:11 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:47003)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1igrxl-0004F1-J1
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 10:07:10 -0500
Received: by mail-ot1-x343.google.com with SMTP id g18so9526962otj.13
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 07:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=M4gc9ntqhanedepx8Ouedw0ub+Hoa52EfUirIvEEHhg=;
 b=uqmwW+fREXSpfQGpaTkBbzzz0spe3Wj17FrZZ8ZAQUPSWnhi/67ccNcfbfi6nArTTk
 H0cyJsj+ixBGwFheiXnfYzxvnuL9YB4B3MlhZwjlANvnfg61Es2S+nt/aQyMMcd59Tq6
 0xe4cOdnZ41yELMo0iYh7Me1dgHOdZNpg7rm5WmuEn25fkUKKCxPUBSNb7z2pHQ6Ksbi
 uwA52PmjtCSFou3/RYG3AP7c5GvcMDoT9i7Jjha1pnWycze642HZVi47ZHaPU42EQyxs
 JXPr16yIwNqpYBiBr+/EIjM6bShrFBppEzR7DxrBcrJiCuP6eIvdR8XDsA7Cw4Iv2JYA
 oNhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=M4gc9ntqhanedepx8Ouedw0ub+Hoa52EfUirIvEEHhg=;
 b=it6L3l4m+TAuU8HNHMQeLST5uD+0agvpam0TLA2P54x7Pag1Nu60dde6Lk09sy9zZv
 6QzzFOlFdyh0jfyMG9AsuLMDQfSSzwWPBceuVHg3z61ScZx7tU/h3EAa3k99MSwMO+AC
 SN/lFelebMzy+aMjkU0BYPtURwvBbxlr0FjWhPbc9Iv49yO48onLhmQSl/3basoMp3qH
 qc/7zff0+Gbebft9XG9u0QXGAi43zosXg27qEyCFRlZqu8S+L6QJzhW9u7OxH8xNTYwb
 YoU5Lbne3Rf5TH8Klqke8xYpIt2gMJURQOZo20St2YgNQQ++t2D+f7joxTH5LcYYLC6y
 W5rw==
X-Gm-Message-State: APjAAAV/YId3tXXo+NaG14gjO8VdpiHL+/CXAD3PLqfMJV3z+odteZ3C
 jB3YwiRAiR7chc6kEB25GTxnZMvdRy0Xib7PvBX6npO5n48=
X-Google-Smtp-Source: APXvYqyfeMPpiv04dgODSyI8HlmcgHy/V11GbI9vyMjfEEYcvB0sKMdEOJFgmqTnZMmRcXdfaSdYpm+4cyvnon7nzNQ=
X-Received: by 2002:a05:6830:4a4:: with SMTP id
 l4mr32723896otd.91.1576508828697; 
 Mon, 16 Dec 2019 07:07:08 -0800 (PST)
MIME-Version: 1.0
References: <20191212173320.11610-1-drjones@redhat.com>
 <20191212173320.11610-6-drjones@redhat.com>
In-Reply-To: <20191212173320.11610-6-drjones@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Dec 2019 15:06:57 +0000
Message-ID: <CAFEAcA8=FcrT8dRMDzxu14J-gv5LEDuNBNpD5yo9j3waV7u8iw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 5/5] target/arm/cpu: Add the kvm-no-adjvtime CPU
 property
To: Andrew Jones <drjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
> kvm-no-adjvtime is a KVM specific CPU property and a first of its kind.
> To accommodate it we also add kvm_arm_add_vcpu_properties() and a
> KVM specific CPU properties description to the CPU features document.
>
> Signed-off-by: Andrew Jones <drjones@redhat.com>
> ---
>  docs/arm-cpu-features.rst | 31 ++++++++++++++++++++++++++++++-
>  hw/arm/virt.c             |  8 ++++++++
>  include/hw/arm/virt.h     |  1 +
>  target/arm/cpu.c          |  2 ++
>  target/arm/cpu64.c        |  1 +
>  target/arm/kvm.c          | 28 ++++++++++++++++++++++++++++
>  target/arm/kvm_arm.h      | 11 +++++++++++
>  target/arm/monitor.c      |  1 +
>  tests/arm-cpu-features.c  |  4 ++++
>  9 files changed, 86 insertions(+), 1 deletion(-)
>
> diff --git a/docs/arm-cpu-features.rst b/docs/arm-cpu-features.rst
> index 1b367e22e16e..641ec9cb8f4a 100644
> --- a/docs/arm-cpu-features.rst
> +++ b/docs/arm-cpu-features.rst
> @@ -31,7 +31,9 @@ supporting the feature or only supporting the feature under certain
>  configurations.  For example, the `aarch64` CPU feature, which, when
>  disabled, enables the optional AArch32 CPU feature, is only supported
>  when using the KVM accelerator and when running on a host CPU type that
> -supports the feature.
> +supports the feature.  While `aarch64` currently only works with KVM,
> +it could work with TCG.  CPU features that are specific to KVM are
> +prefixed with "kvm-" and are described in "KVM VCPU Features".
>
>  CPU Feature Probing
>  ===================
> @@ -171,6 +173,33 @@ disabling many SVE vector lengths would be quite verbose, the `sve<N>` CPU
>  properties have special semantics (see "SVE CPU Property Parsing
>  Semantics").
>
> +KVM VCPU Features
> +=================
> +
> +KVM VCPU features are CPU features that are specific to KVM, such as
> +paravirt features or features that enable CPU virtualization extensions.
> +The features' CPU properties are only available when KVM is enabled and
> +are named with the prefix "kvm-".  KVM VCPU features may be probed,
> +enabled, and disabled in the same way as other CPU features.  Below is the
> +list of KVM VCPU features and their descriptions.
> +
> +  kvm-no-adjvtime          When disabled, each time the VM transitions
> +                           back to running state from the paused state the
> +                           VCPU's vitual counter is updated to ensure the

"virtual"

> +                           stopped time is not counted.  This avoids time
> +                           jumps surprising guest OSes and applications,
> +                           as long as they use the virtual counter for
> +                           timekeeping, but has the side effect of the
> +                           virtual and physical counters diverging.  All
> +                           timekeeping based on the virtual counter will
> +                           appear to lag behind any timekeeping that does
> +                           not subtract VM stopped time.  The guest may
> +                           resynchronize its virtual counter with other
> +                           time sources as needed.  Enabling this KVM VCPU
> +                           feature provides the legacy behavior, which is
> +                           to also count stopped time with the virtual
> +                           counter.

This phrasing reads a bit confusingly to me. What I would usually expect
is that you get
  name-of-option              Description of what the option does.

But here we have
  name-of-option              Long description of the default behaviour,
                              taking many lines and several sentences.
                              Brief note at the end that enabling this
                              feature gives the opposite effect.

Especially since the default-behaviour description isn't prefaced
with "By default" or similar, it's quite easy to start reading the
text assuming it's defining what the option is going to do, only
to get to the end and realise that it's defining what the option
is *not* going to do...

Incidentally, if I understand things correctly, for TCG the
behaviour is (and has always been) that VM-stopped time is
not counted, because we run the emulated versions of these counters
off QEMU_CLOCK_VIRTUAL. So having the KVM default be the same as
the TCG default is nicely consistent.

thanks
-- PMM

