Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 717A4C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 15:30:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FF9320715
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 15:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XwJ9KA9Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FF9320715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYAtD-0007rY-BH
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 10:30:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42801)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iYAsS-0007ON-Fo
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 10:29:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iYAsP-0005rF-Jf
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 10:29:42 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25800
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iYAsP-0005qp-5E
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 10:29:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574436580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kSvg/RF60s+r2GOKgNbXixaade2fGb2BxljRnH+nRYM=;
 b=XwJ9KA9ZYMoCkXtL6ekbXakx2QJ9qN96iijUyUmJ2lK6NQC5jw9N5xeVaIvLkswTSJHMru
 mtcM4bW4y8eUSMuiiAQ8mgnbsA14fGiKo8nnoQ83ifzPT+OVf+0CXtT6EnvCdfhdNcGhH0
 VQ3XWKpfr2Hv8H6BiqJdD6UB5DxGkHw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-BYDnm2dKPrCW0cH2elhBxA-1; Fri, 22 Nov 2019 10:29:38 -0500
Received: by mail-wr1-f69.google.com with SMTP id e3so4022977wrs.17
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2019 07:29:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kTz1tcLFeoh3C1lLKTE/sZLjZ6WZyHhnKDTyOHhDREw=;
 b=pwfMOVCbm2XymcXuDeR5MVesTstd0Hm5+ufC3FLcW699ys38NHuPxn1A5AH3NeyYZT
 //KpnazmhrxQ4Rzj1uUoH/eVwHpQxRhHUhTh5YmzNqoFXJp4fFzOZKYu96IZlLD57TRY
 ykv5aC690925agJ2AwjBvH5NgFIRt8vNZSGkPMpBQCR+90yo+iX4uXkKS71SVx7hroCA
 2xlADoHopanWWHGoKmPzcQqwAHOtCJXXCfcLvAX3v1gg+U+sIUHQW5QLkIxdtimbMnFw
 gy3LtQnEV6DUL9b/PgzOfdUzBYWV2hR7YV3B0htchFBnPhEhr6PP/CC8JeWy4Z8pdadY
 hlAg==
X-Gm-Message-State: APjAAAWy1Wl//mHqufw4W8RH+6Pk30pZ45wS9gTsXQOeVfcKVMsaqiHJ
 uYvGR46M32MBFOBmViC5vdimJ9GgXv+JGlTlobCFKZzRH57062w95yLZ+b5IVYuxxggFKlodXKh
 ICua+Km678FdFPjE=
X-Received: by 2002:a05:600c:2257:: with SMTP id
 a23mr17736965wmm.143.1574436577409; 
 Fri, 22 Nov 2019 07:29:37 -0800 (PST)
X-Google-Smtp-Source: APXvYqz98KB9+pe6N02vJWKESXwsCKei/JuQz7knBS442SQ1L5vBmW9Rw08G+RZ+EjClB60T8JXU+Q==
X-Received: by 2002:a05:600c:2257:: with SMTP id
 a23mr17736947wmm.143.1574436577090; 
 Fri, 22 Nov 2019 07:29:37 -0800 (PST)
Received: from [192.168.1.35] (131.red-88-21-102.staticip.rima-tde.net.
 [88.21.102.131])
 by smtp.gmail.com with ESMTPSA id 76sm4081711wma.0.2019.11.22.07.29.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Nov 2019 07:29:36 -0800 (PST)
Subject: Re: [PATCH v2 4/5] MAINTAINERS: Adjust maintainership for R4000
 systems
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
References: <1573652826-23987-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1573652826-23987-5-git-send-email-aleksandar.markovic@rt-rk.com>
 <78b81f32-0eb0-6d51-6ecc-9c8045be3896@redhat.com>
 <CAL1e-=iWZszvg7pY=iL6j0bUch+gF5nhuk+XbGFkipkhzCHHug@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a9ace386-33b5-b712-8ebe-25f1b8251771@redhat.com>
Date: Fri, 22 Nov 2019 16:29:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAL1e-=iWZszvg7pY=iL6j0bUch+gF5nhuk+XbGFkipkhzCHHug@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: BYDnm2dKPrCW0cH2elhBxA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/22/19 3:14 PM, Aleksandar Markovic wrote:
> On Fri, Nov 22, 2019 at 2:58 PM Philippe Mathieu-Daud=C3=A9
> <philmd@redhat.com> wrote:
>>
>> Hi Aleksandar,
>>
>> On 11/13/19 2:47 PM, Aleksandar Markovic wrote:
>>> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>>>
>>> Change the maintainership for R4000 systems to improve its quality.
>>>
>>> Acked-by: Aurelien Jarno <aurelien@aurel32.net>
>>> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
>>> ---
>>>    MAINTAINERS | 5 +++--
>>>    1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 6afec32..ba9ca98 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -971,8 +971,9 @@ F: hw/mips/mips_mipssim.c
>>>    F: hw/net/mipsnet.c
>>>
>>>    R4000
>>> -M: Aurelien Jarno <aurelien@aurel32.net>
>>> -R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
>>> +M: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
>>
>> Commit 0c10962a033 from Herv=C3=A9 was part of a bigger refactor series,=
 so I
>> don't think he is interested.
>>
>>> +R: Aurelien Jarno <aurelien@aurel32.net>
>>> +R: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>>    S: Maintained
>>>    F: hw/mips/mips_r4k.c
>>
>> Now back to this board, I am having hard time to understand what it
>> models. IIUC it predates the Malta board, and was trying to model a
>> board able to run the first MIPS cpu when the port was added in 2005
>> (see commit 6af0bf9c7c3a).
>> The Malta board was added 1 year later (commit 5856de800df) and models a
>> real hardware.
>>
>> As Aurelien acked to step down maintaining it, it seems the perfect
>> timing to start its deprecation process. I'll prepare a patch for 5.0
>> (unless someone is really using it and willing to maintain it).
>>
>=20
> Philippe, hi.
>=20
> Herve told me a while ago that he does care about R4000 being
> supported, as it is closely related to Jazz machines, so please
> don't start any deprecation process.

I think what Herv=C3=A9 meant to say is he cares about the R4000 CPU=20
(implementing the MIPSIII architecture). The Magnum and Pica boards=20
indeed use a R4000 CPU. I also personally care about this CPU, and don't=20
want it to disappear.

Here we are talking about the some Frankenstein board. QEMU aims to=20
model real hardware, with the exception of the 'Virt' boards that have=20
specifications. Here I can't find any. I am not against Herv=C3=A9=20
maintaining this file if he has some interest in it, but I think there=20
are confusion and we are talking about 2 different topics.

> Herve is the most familiar of all of us with R4000, and, for that
> reason, my suggestion is to keep the patch as it is. Let me know
> if you have any objections.
>=20
> One alternative approach would be to merge "R4000" and
> "Jazz" sections. But, let's leave it for future as an option,
> if nobody objects.
>=20
> Yours,
> Aleksandar
>=20
>> Regards,
>>
>> Phil.
>>
>>
>=20


