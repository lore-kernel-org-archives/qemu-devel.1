Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC1EC49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 09:48:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58651206A4
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 09:48:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BE0Pz0VR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58651206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9nca-0005JW-Ey
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 05:48:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42315)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i9nb3-0004dG-W1
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 05:47:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i9nb2-0006IN-Eb
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 05:47:01 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:55954)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i9nb2-0006I5-6f
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 05:47:00 -0400
Received: by mail-wm1-x344.google.com with SMTP id g207so9313953wmg.5
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 02:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=3hg165N63dSF7Wpv1sPMgDN6eJKEV0AHd4fj2DEPUQE=;
 b=BE0Pz0VRBJUDFbAADisy/uFV+jYl2CkSM2R/mt8FerN0KiFRdS4Nqr/s2XAkvpzSXW
 bkjrlUdt+rW52KqVnqDkEX1riYSrJMvmWBPLsQawGkF4zQrKO+puOZ6zI8jLCYdIboCB
 3AbM9H11JASEut3OdUqgnPzMzE40V/REdKwMyt+EI6TgKshnGdJC1+tQK8nRdTnQaKbr
 kxr9tf8aQPJMY2s26YJDQHNpE/4h9PjJlfYLFILFx9VNLAHv+VYv6UYl00Q5nds9r3PB
 Pukt9NoCquFworDrgCFvtPK7pwuLVxfwfu6NbHVXsfmgR17sn1hBY7QDlJ3DmKXymqAG
 CFpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=3hg165N63dSF7Wpv1sPMgDN6eJKEV0AHd4fj2DEPUQE=;
 b=CpILYsaNuXWulmPTgD+4YBBQwq97yV/1YnUOPGmvFc5OlLKOzadmn1LbPfkYmxwter
 L8UkRyZvTlSkMRBZ2IVdrtd/or7czv6swjjoqpszcVRSSVDv9SvDkxaEVbjgbswNNBOq
 PSaHuuK6Uj8LoRWH4bTyTUuZY0KaCQzYrv+MnA9I6H5oipfvsZ8wWEsNUlD/3cyG9RCA
 MZTRJWpuVUXpoOnoNqdyzFxrT+xLsQaa3vwOnzd2B5fcnYybKX5oWqLFRdSSl0lGvkPs
 x2qN0Q5/4KCRPMdxHsJUx5zojOlDNA8WgNV2UkwW1pTP5KH47MOUdgRAl19OHwHodaHy
 3u4Q==
X-Gm-Message-State: APjAAAXpDoVhY8wngNyY1P1Yzinp1cwDdBkHqVCRFWnfNFh0AmcIeCTC
 AsPHIq8rd0CSVD+gfHaFeowjEQ==
X-Google-Smtp-Source: APXvYqx0xcuflP2RcwqJDQKlBlT/1TGqR47Xn0Kz4dG/MrUeZcYz41AWwc/xW4wNkO9jYzyVar29DA==
X-Received: by 2002:a1c:7618:: with SMTP id r24mr1367164wmc.133.1568627218781; 
 Mon, 16 Sep 2019 02:46:58 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g185sm25657031wme.10.2019.09.16.02.46.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2019 02:46:57 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 329BA1FF87;
 Mon, 16 Sep 2019 10:46:57 +0100 (BST)
References: <20190915211940.30427-1-f4bug@amsat.org>
 <20190915211940.30427-7-f4bug@amsat.org> <87o8zk1vi2.fsf@linaro.org>
 <77f96bda-d007-637a-7cc0-8b65790a6828@redhat.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
In-reply-to: <77f96bda-d007-637a-7cc0-8b65790a6828@redhat.com>
Date: Mon, 16 Sep 2019 10:46:57 +0100
Message-ID: <87muf41sku.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [PATCH v2 6/6] .travis.yml: Split enterprise vs.
 hobbyist acceptance test job
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 Thomas Huth <huth@tuxfamily.org>, Markus Armbruster <armbru@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, Kamil Rytarowski <kamil@netbsd.org>,
 =?utf-8?Q?Herv=C3=A9?= Poussineau <hpoussin@reactos.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-ppc@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 9/16/19 10:43 AM, Alex Benn=C3=A9e wrote:
>> Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:
>>
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>> ---
>>>  .travis.yml | 18 ++++++++++++++++--
>>>  1 file changed, 16 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/.travis.yml b/.travis.yml
>>> index 69a37f7387..753276eb33 100644
>>> --- a/.travis.yml
>>> +++ b/.travis.yml
>>> @@ -265,9 +265,23 @@ matrix:
>>>          - "3.6"
>>>
>>>
>>> -    # Acceptance (Functional) tests
>>> +    # Acceptance (Functional) tests [enterprise]
>>>      - env:
>>> -        - CONFIG=3D"--python=3D/usr/bin/python3 --target-list=3Dx86_64=
-softmmu,mips-softmmu,mips64el-softmmu,aarch64-softmmu,arm-softmmu,s390x-so=
ftmmu,alpha-softmmu,ppc-softmmu,ppc64-softmmu,m68k-softmmu"
>>> +        - CONFIG=3D"--python=3D/usr/bin/python3
>>> --target-list=3Dx86_64-softmmu,mips64el-softmmu,aarch64-softmmu,s390x-s=
oftmmu,ppc64-softmmu"
>>
>> You could use:
>>
>>   --target-list=3D${MAIN_SOFTMMU_TARGETS}
>>
>> and
>>
>>   --disable-user --target-list-exclude=3D${MAIN_SOFTMMU_TARGETS}
>
> I like the idea, but this variable is slighly different:
>
> MAIN_SOFTMMU_TARGETS=3D"aarch64-softmmu,arm-softmmu,i386-softmmu,mips-sof=
tmmu,mips64-softmmu,ppc64-softmmu,riscv64-softmmu,s390x-softmmu,x86_64-soft=
mmu"
>
> Are you suggesting we use MAIN_SOFTMMU_TARGETS for 'Enterprise'
> targets?

Broadly - I'm note sure how we want to make the distinction in QEMU. We
have targets which are actively maintained and represent current
architectures that people still ship software to run on. The other
targets are machines that are either esoteric designs that exist in
particular niches or of academic interest and the old architecture kept
alive out of a sense of nostalgia.

>
> As long as mips64-softmmu is present, I think we can remove mips-softmmu
> from MAIN_TARGETS. Maybe i386-softmmu can be removed too.

Well the MIPS targets are actively maintained although for 32 bit you
don't see many distros for them these days. There might be an argument
for demoting i386-softmmu as I'm guessing there isn't much 32 bit kvm in
the enterprise right now (although It would be unsurprising to be told
otherwise).

>
> That would give the following hobbyist list:
>
> i386-softmmu,mips-softmmu,alpha-softmmu,ppc-softmmu,m68k-softmmu

I'm not sure about the hobbyist moniker as pretty much any of these TCG
targets is more actively maintained than the x86 which is mostly all
about the HW virtualisation these days. Trouble is I can't think of
another name that doesn't sound condescending:

  HISTORICAL_SOFTMMU_TARGETS
  LEGACY_SOFTMMU_TARGETS
  FASTERTHANNATIVE_SOFTMMU_TARGETS
  ARCHIVISTS_SOFTMMU_TARGETS

? As ever naming things is hard....

>
> (I plan to add hppa-softmmu there too).
>
>>> +        - TEST_CMD=3D"make check-acceptance"
>>> +      after_failure:
>>> +        - cat tests/results/latest/job.log
>>> +      addons:
>>> +        apt:
>>> +          packages:
>>> +            - python3-pil
>>> +            - python3-pip
>>> +            - python3.5-venv
>>> +
>>> +
>>> +    # Acceptance (Functional) tests [hobbyist]
>>> +    - env:
>>> +        - CONFIG=3D"--python=3D/usr/bin/python3 --target-list=3Dmips-s=
oftmmu,arm-softmmu,alpha-softmmu,ppc-softmmu,m68k-softmmu"
>>>          - TEST_CMD=3D"make check-acceptance"
>>>        after_failure:
>>>          - cat tests/results/latest/job.log
>>
>>
>> --
>> Alex Benn=C3=A9e
>>


--
Alex Benn=C3=A9e

