Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BBC9C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 15:38:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC53A20578
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 15:38:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LHQZPPo0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC53A20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBKTm-0006lI-2u
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 11:38:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37727)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jBKMe-0005kN-Lj
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:30:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jBKMc-0001dk-FE
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:30:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49692
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jBKMZ-0001VC-Dk
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:30:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583767839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iTeCDE/9MCbqa9s+51QJ++GgmQ1hHlz5hPFba+dvFt8=;
 b=LHQZPPo0bYtzIDMm4sxPhKGSvgMgjHZaCQk3a31uYBP5aG39rEZoa1qATZAEgec5IOvPEz
 XW+frxDFMdLIAjeVNinYrShEb7WJQ+AxR5VR/HLOwFXiTmFH6qO3KxQBAlKQc2Uzt9+e4E
 hY5gDtCGPBlCyncyOI6x/THeAnkNJWg=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-UdQRurAEOlOx8DS2ziwk0Q-1; Mon, 09 Mar 2020 11:30:35 -0400
X-MC-Unique: UdQRurAEOlOx8DS2ziwk0Q-1
Received: by mail-ed1-f71.google.com with SMTP id a32so8186225edf.17
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 08:30:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qVhpe5hMLG4rzQPr30+5xgFoEb3+rFH1q64WjBoWnAw=;
 b=rms3XytNPk5T7YTuetNWPBx8/j39R8Nm4m2ncQqYsZN5Um0S8zsbY3cHU4/ySMqXx/
 7Jzk57YbkMeKumd4Uel3um2eZntkU3SBx6GerF3P0kR23lSTipR2972sR28TdR0kkNoN
 8+mRA/+1J4CIb28Jv1YK3rVKjwpBrOEfXv3W92uieiE9LJ1UA17LQgteS+PCA7AIeMr8
 gUUkAj57x3QuNaJF26u03XjitYPGlWW49SwnLS/DSG1DEV0raR2hNLRQdp+d1dmpL2C6
 eb5OADYlTbRHScejBFnuiYJAjAekiBg7CP0iKalxarkqTAm3orbSTWL+vxfAS2vweX5B
 pZZg==
X-Gm-Message-State: ANhLgQ3T3AZMOBtMX5WAd+o/UN4DgPS38Piw1ax7mKtYf2iglZ9Jo5rO
 9Axx6qdrT6KkRQLjzUsCJZYPA01BHRDULvHFGDwAfiCAg7mzS+rsVX6AtdrKEx0EZemXDWqXs13
 ktjgtNwRl+kkLSC8=
X-Received: by 2002:a17:906:e094:: with SMTP id
 gh20mr15383145ejb.230.1583767833953; 
 Mon, 09 Mar 2020 08:30:33 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvUXP9h1qa4fUJnDdTd+xMOOonXQYV3iJRvswRALnW4LdLuwa437zisdfz5k5ojv7il6ByNWw==
X-Received: by 2002:a17:906:e094:: with SMTP id
 gh20mr15383110ejb.230.1583767833712; 
 Mon, 09 Mar 2020 08:30:33 -0700 (PDT)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id m3sm861910ejj.22.2020.03.09.08.30.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2020 08:30:32 -0700 (PDT)
Subject: Re: [PATCH 2/2] cpu: Assert a vCPU is created before resetting it
To: Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
References: <20200309121103.20234-1-philmd@redhat.com>
 <20200309121103.20234-3-philmd@redhat.com>
 <CAFEAcA9LcTUmBuzsHmOSPKOfiyfPy0+gPhKpQdd91EV76HapxA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <630fc27e-6a37-b31c-a0f8-5d850fd42e2a@redhat.com>
Date: Mon, 9 Mar 2020 16:30:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9LcTUmBuzsHmOSPKOfiyfPy0+gPhKpQdd91EV76HapxA@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, Michael Walle <michael@walle.cc>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/9/20 2:10 PM, Peter Maydell wrote:
> On Mon, 9 Mar 2020 at 12:11, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om> wrote:
>>
>> cpu_reset() might modify architecture-specific fields allocated
>> by qemu_init_vcpu(). To avoid bugs similar to the one fixed in
>> commit 00d0f7cb66 when introducing new architectures, assert a
>> vCPU is created before resetting it.
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>>   hw/core/cpu.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/hw/core/cpu.c b/hw/core/cpu.c
>> index fe65ca62ac..09e49f8d6a 100644
>> --- a/hw/core/cpu.c
>> +++ b/hw/core/cpu.c
>> @@ -251,6 +251,7 @@ void cpu_reset(CPUState *cpu)
>>   {
>>       CPUClass *klass =3D CPU_GET_CLASS(cpu);
>>
>> +    assert(cpu->created);
>>       if (klass->reset !=3D NULL) {
>>           (*klass->reset)(cpu);
>>       }
>=20
> This will conflict with the change to use DeviceClass::reset.
>=20
> Ideally we should do an equivalent assert in the DeviceClass
> (and flush out all the bugs where we forgot to realize the
> device before using it).

OK (I should have sent as RFC probably).

Anyway this fails the ppc64le/s390x linux-user tests on Travis-CI:

qemu-ppc64le: hw/core/cpu.c:254: cpu_reset: Assertion `cpu->created' failed=
.

qemu-s390x: hw/core/cpu.c:254: cpu_reset: Assertion `cpu->created' failed.

>=20
> thanks
> -- PMM
>=20


