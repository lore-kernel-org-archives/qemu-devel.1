Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C23C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 15:02:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4316E2133F
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 15:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JRl+lWaB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4316E2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK1rk-0001rM-Oc
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 11:02:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55128)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <e.emanuelegiuseppe@gmail.com>) id 1iK1qH-00011e-4P
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 11:01:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <e.emanuelegiuseppe@gmail.com>) id 1iK1qF-0004lQ-R0
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 11:01:00 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:32861)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <e.emanuelegiuseppe@gmail.com>)
 id 1iK1qF-0004kp-KX
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 11:00:59 -0400
Received: by mail-ed1-x542.google.com with SMTP id c4so15112266edl.0
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 08:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=zsOCbUJDOxK0WKzh2Z7E1a9bPP3ZprAAA2M7jnZG4Sg=;
 b=JRl+lWaBQbVmdvN3UcE/1Vucc9eijqD26G+LgH77SnurLESN8zj8g9ZdEJlKZ5VXzX
 r/pCI9Ga2qWrHwzFx1N1QzhG8Ocryd4Rjrq6TN3FK+fRMAmUgKNQUb5IPp/EASk+c+LE
 sLXLW5yAIi4GDXuBJEzuhSXE1UL7qcUbf6p0SyFOBAysMt2JIUJ+r63t0DLvBITNe/YR
 AYc1qKb6HEJEdSmyNc40fA0c3hr1tgoRPGCHIhrTAClwqaVycYqouwjL1GqfbJl5WKZk
 VQCt8QVaWDEPKjQKBJUxR9eOJxoJJR9RrUJL5OJslUoaXgWdkpk+kzcfnc1Qf1keg22m
 0L0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=zsOCbUJDOxK0WKzh2Z7E1a9bPP3ZprAAA2M7jnZG4Sg=;
 b=d0zpWjD98QB2UWynxYJeu4zYLQOQnPnFm/ZTYFj2zRX2lQ7b70vXVzRR2/hQLqv7ks
 1xC9S2SFlrvC5eKoJoSjXm0OoPLImaU0/RbeOJvUNv6kijlQbBxcoweSWf5JbtIINfnQ
 E0+LEbRdOdnIrS4fF1ePQvAGRN73atqf0FtOQdFrb9+78BFmZQa0t4sOKwMEiVW3lbqP
 YivfGNBeXF5sxowlHWDeFvUOBnwbo3c2bpdi8l3D7ZmDi98yYGOZDFj0n2zVN0Bvq2Bf
 lJXkZCMH6img9uWAUsPXE/YDAj5fEDjI968V2oa4opahfz1LcHVYzQW4z6+uU5O34F2S
 0IdQ==
X-Gm-Message-State: APjAAAWIhtBy+belNqPn1s6yHS4iP3oDxK6zgSEq9fM46PLPTVdKDdob
 hXegTbf0HnQ5dzfhhl0+PPQ4ORCVTkQ=
X-Google-Smtp-Source: APXvYqwCj4jr5hvuETDNq31PhcYGlnON+taMJeIKI4VstFntai89ZsRexyUphMcRxIsucNj/I6GMNQ==
X-Received: by 2002:aa7:d045:: with SMTP id n5mr28577091edo.24.1571065257970; 
 Mon, 14 Oct 2019 08:00:57 -0700 (PDT)
Received: from [192.168.8.101] ([194.230.155.172])
 by smtp.gmail.com with ESMTPSA id h58sm3214925edb.43.2019.10.14.08.00.56
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 14 Oct 2019 08:00:57 -0700 (PDT)
Subject: Re: [PATCH v1 1/5] contrib/gitdm: add more entries individuals and
 academics
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20191014135905.24364-1-alex.bennee@linaro.org>
 <20191014135905.24364-2-alex.bennee@linaro.org>
 <a18c0078-dcb2-f55e-55eb-8328bc465bca@gmail.com> <87wod7ml6i.fsf@linaro.org>
From: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Message-ID: <8d3e46b4-5028-8abc-e0ab-0b9fba3c894f@gmail.com>
Date: Mon, 14 Oct 2019 17:00:55 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <87wod7ml6i.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::542
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 14/10/2019 16:55, Alex Bennée wrote:
> Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com> writes:
>
>> Hello Alex,
>>
>> I confirm my email address, I worked on qemu during the 2018 Google
>> Summer of Code.
> Is that an Acked-by: then?

Yes, sorry.

Acked-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>

>> Thanks,
>> Emanuele
>>
>> On 14/10/2019 15:59, Alex Bennée wrote:
>>> Again this is guess work based on public websites. Please confirm.
>>>
>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>> Cc: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
>>> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
>>> Cc: "Kővágó, Zoltán" <dirty.ice.hu@gmail.com>
>>> Cc: Li Qiang <liq3ea@gmail.com>
>>> Cc: Li Qiang <liq3ea@163.com>
>>> ---
>>>    contrib/gitdm/group-map-academics   | 3 +++
>>>    contrib/gitdm/group-map-individuals | 4 ++++
>>>    2 files changed, 7 insertions(+)
>>>
>>> diff --git a/contrib/gitdm/group-map-academics b/contrib/gitdm/group-map-academics
>>> index 08f9d81d13..5cbb9d84c8 100644
>>> --- a/contrib/gitdm/group-map-academics
>>> +++ b/contrib/gitdm/group-map-academics
>>> @@ -12,3 +12,6 @@ ispras.ru
>>>    # Columbia University
>>>    cs.columbia.edu
>>>    cota@braap.org
>>> +
>>> +# University of Paderborn
>>> +uni-paderborn.de
>>> diff --git a/contrib/gitdm/group-map-individuals b/contrib/gitdm/group-map-individuals
>>> index 1c84717438..301071b98b 100644
>>> --- a/contrib/gitdm/group-map-individuals
>>> +++ b/contrib/gitdm/group-map-individuals
>>> @@ -14,3 +14,7 @@ noring@nocrew.org
>>>    samuel.thibault@ens-lyon.org
>>>    aurelien@aurel32.net
>>>    balaton@eik.bme.hu
>>> +e.emanuelegiuseppe@gmail.com
>>> +dirty.ice.hu@gmail.com
>>> +liq3ea@163.com
>>> +liq3ea@gmail.com
>
> --
> Alex Bennée

