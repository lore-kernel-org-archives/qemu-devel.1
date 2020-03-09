Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08CEAC10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 13:11:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84A8924654
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 13:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zpJOoVdp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84A8924654
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBIBV-0007DA-Ir
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 09:11:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37836)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jBIAl-0006O3-MV
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 09:10:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jBIAk-0003FX-Kd
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 09:10:19 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:42826)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jBIAk-0003ER-FR
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 09:10:18 -0400
Received: by mail-ot1-x341.google.com with SMTP id 66so9421383otd.9
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 06:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=9zliDx7aCLMb1lENxXSmv9CK/doIX6UYfnvb3yYb7wE=;
 b=zpJOoVdpQ9kPHMHgMRvuScwpAWQzU68pPxFxldtNk41SjAek+sjKkeP/iwmt2mVoXG
 9lQOxP+7SErhzmOmtqkA73bxje83eykNHIDX9pXufa4Z9l5OQ53xrcwubSOhR5gMJnvu
 C3Hbw6DFzV5hsGNgtAR+HqvBd25MDqtyZjVjRoySuFbL7DcnxtNTW7yXZKkROQ0kedyd
 0vdYnJhPzcDqOL98U3qhY0CITTWWBXV0uFeVSbUG36O5wCWE42UKZ+W+kpdhe/nQI6Q8
 0dj/enf0MaHvyf4L48T0Uo1Zmp2xxcGQavSwyvAkVqrYSrFu6zAAXs+jAFS/shPBeEje
 /Xjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=9zliDx7aCLMb1lENxXSmv9CK/doIX6UYfnvb3yYb7wE=;
 b=tZT+XVB1OI7ql0grjoiRrIA1bGz7HaMrpgN1r6ftI+DBNp2nA6dMDjD0wyptNlNc0O
 bfRViMrJTMBbMNjrkMUq+6iDObE98itsxtRCTqQzo3QldP6S2iKF/eE5LBVxYPAbBkir
 +R5yr1jcJM/LfuaXk3LiqjN39eufWMRpBIIO2b/G3xd4M5Pi5sBN4olPGthRjo+efAxn
 lJNvCvfZiQDoERPUfTd7HgdRSVigDyjl4PAoZgErcpYpeKu25U42tL+ThYLcjN/CjmbP
 LoHrAsYxSaC/BMf+Pf9VQBsy0WILxglTqStu3S/miG6abakzFff9qL9ymzBW5+GeEzin
 p0Gg==
X-Gm-Message-State: ANhLgQ3OaGauZPyp0ijTKf0tBq0JdSuhSqIGKd1KHccOeF4eBpGKMCB2
 CV87k8dPT08M5v3NHiLYa5OkPaMIOAGSgy/VEyUUHg==
X-Google-Smtp-Source: ADFU+vtpsAVjF3lahxFyC3B4Y2LlloXKYruSIhFC6ddxG9HfVpQSUH3aw7meiInAXy7OB6961SAPEkkAlTQn4qHJWZs=
X-Received: by 2002:a9d:1920:: with SMTP id j32mr4331538ota.221.1583759417703; 
 Mon, 09 Mar 2020 06:10:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200309121103.20234-1-philmd@redhat.com>
 <20200309121103.20234-3-philmd@redhat.com>
In-Reply-To: <20200309121103.20234-3-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Mar 2020 13:10:06 +0000
Message-ID: <CAFEAcA9LcTUmBuzsHmOSPKOfiyfPy0+gPhKpQdd91EV76HapxA@mail.gmail.com>
Subject: Re: [PATCH 2/2] cpu: Assert a vCPU is created before resetting it
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, Michael Walle <michael@walle.cc>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 9 Mar 2020 at 12:11, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
>
> cpu_reset() might modify architecture-specific fields allocated
> by qemu_init_vcpu(). To avoid bugs similar to the one fixed in
> commit 00d0f7cb66 when introducing new architectures, assert a
> vCPU is created before resetting it.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/core/cpu.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/core/cpu.c b/hw/core/cpu.c
> index fe65ca62ac..09e49f8d6a 100644
> --- a/hw/core/cpu.c
> +++ b/hw/core/cpu.c
> @@ -251,6 +251,7 @@ void cpu_reset(CPUState *cpu)
>  {
>      CPUClass *klass =3D CPU_GET_CLASS(cpu);
>
> +    assert(cpu->created);
>      if (klass->reset !=3D NULL) {
>          (*klass->reset)(cpu);
>      }

This will conflict with the change to use DeviceClass::reset.

Ideally we should do an equivalent assert in the DeviceClass
(and flush out all the bugs where we forgot to realize the
device before using it).

thanks
-- PMM

