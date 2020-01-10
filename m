Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90AFBC33CA2
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 10:03:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5875F20721
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 10:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7Y72Csl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5875F20721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipr91-0002lM-Al
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 05:03:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40513)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1ipr4l-0007NN-Bn
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 04:59:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1ipr4k-0003ze-2k
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 04:59:31 -0500
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:40044)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1ipr4j-0003po-N9; Fri, 10 Jan 2020 04:59:29 -0500
Received: by mail-lj1-x242.google.com with SMTP id u1so1501976ljk.7;
 Fri, 10 Jan 2020 01:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=7JlzPibRcf0IgPM6L/pRPXmRhZqX6hDwJe/LfcYdab8=;
 b=K7Y72Csly7MWqJMzL3CkWbTrMW2/2vhNHffTGbrtgJOr8gPUiGjGjQdP0tTmzV3E0W
 A927SweuQJqAzR2mrjN7uAfYmNhfWOTwNpnxNCla+S+3hAUTSd1bghy3J3Eq+Oj5Tc/t
 dFHrgnGrdy96RqRknK4r6Q+9U1A11UenbliYexZsT/0+Mfpb+4xyhxTpjMzkoSNuxSsI
 iZItbxMB3wNzTmJZBVg5WdFOJrTD67BRpKMjl5DQWe+KYfrC0XnUt0itnkYHzFox2ZJ8
 Rxn8L0arRJ8E4EkbpshAsBDkmctDgCjcyd/XMuk6qEKmIDMx3+2eZ8/473mN98+V/Fla
 8SNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=7JlzPibRcf0IgPM6L/pRPXmRhZqX6hDwJe/LfcYdab8=;
 b=Y5sv/9WXJkP1ndUbV31fPZyzbwiuzOkc8D82LT94vSyp4MnP5bRUMT30QySqlJfFeH
 L6nhubomYP0feXyO4SJ1yhEjNdlP75v7Jv0cGQ44MABcYMGc+rlfqtLtJjORkT06mEeK
 XvtT6lY0FgFWUW0gB1Lqbl+qA4zviDLYff2lNjlni7lhwy3kHIRW5XLkxh2CYp4GWVum
 kNu5XegHAtHT67g+Ls9dC5Bgoa0Zr3mrVCXzUBsVOfvSO20ebrio3d1UqiO7ZV1hm3Kv
 tzFDIcDtm1EMfKqSBYI/huVQFKXWGCvjE0+8SPJVJuTOUo4ZIHLzJWub3IVu+mK3CwOg
 WhRg==
X-Gm-Message-State: APjAAAV5/pFt6p5sy9BaGmw3IrYsShVEAfOPyEXhc6sGhP98wj3Qgg4d
 5r8TQ0/Unw+3kE4UvJNALlyMoCfy70oi/cmTRE0=
X-Google-Smtp-Source: APXvYqxzu0M/AnGftTw+RYkbJmDaeTygSU9qN8VejwFvlXKqWRamkOK0VDxcEWbRXKmYV/ncIV+w7yjo5nHIp/WwRtA=
X-Received: by 2002:a2e:3a13:: with SMTP id h19mr2127868lja.16.1578650367261; 
 Fri, 10 Jan 2020 01:59:27 -0800 (PST)
MIME-Version: 1.0
References: <20200109152133.23649-1-philmd@redhat.com>
 <20200109152133.23649-2-philmd@redhat.com>
In-Reply-To: <20200109152133.23649-2-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 10 Jan 2020 17:59:00 +0800
Message-ID: <CAKmqyKPe-K5omNe2wJC-vb35YQ2iiH4yJUTDgydDna+7ONnvuw@mail.gmail.com>
Subject: Re: [PATCH 01/15] target/arm/kvm: Use CPUState::kvm_state in
 kvm_arm_pmu_supported()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::242
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

On Thu, Jan 9, 2020 at 11:22 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> KVMState is already accessible via CPUState::kvm_state, use it.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/arm/kvm.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index b87b59a02a..8d82889150 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -181,9 +181,7 @@ void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu)
>
>  bool kvm_arm_pmu_supported(CPUState *cpu)
>  {
> -    KVMState *s =3D KVM_STATE(current_machine->accelerator);
> -
> -    return kvm_check_extension(s, KVM_CAP_ARM_PMU_V3);
> +    return kvm_check_extension(cpu->kvm_state, KVM_CAP_ARM_PMU_V3);
>  }
>
>  int kvm_arm_get_max_vm_ipa_size(MachineState *ms)
> --
> 2.21.1
>
>

