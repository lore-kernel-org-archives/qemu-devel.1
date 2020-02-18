Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62369C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 20:08:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30F7C22B48
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 20:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ADsTlu4V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30F7C22B48
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j49AT-00031u-Ci
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 15:08:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38986)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j499X-0002CH-D0
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 15:07:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j499U-0003rv-V5
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 15:07:30 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56785
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j499T-0003p5-Sf
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 15:07:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582056446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=imQEmwhGbbuDtVJHtCc17rDNhQZDMqNVR4B8mNPvFe8=;
 b=ADsTlu4VzBK+z3veMC8FE5Prd4IA8J2wmR7kpAeQyBa0GhwXd6IH/57qWYrk0vgQ797oq8
 TeXpz5CcOAUgN+SN29GBCa5atCq9H/cRO2lk21espWQvnIk/kI3rXNkitfGsS/HF7XUzmt
 hXqZcCSoWRUq44lihTGdMuStJkrRVs4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-Uir83PglOJOf5InGeOV-qw-1; Tue, 18 Feb 2020 15:07:21 -0500
Received: by mail-wr1-f72.google.com with SMTP id z15so11475531wrw.0
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 12:07:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fB3Wm4tuTuHZXMhhL/GvlweCikb9oi76N5t38wjItwQ=;
 b=oJvDJZy7APnQJjn9HMCsVrGv7XC9FAzBeYzh2DDy+IN8dYetxm4geLUmAbkeWaEc6l
 6rxZWpkZ1icUI1vJhLAfuriH7MxgF2QbHsP0afOSRBri86uOs2spW5+FTJqn08WxL5nl
 UOGTUclFyT0ffmBhYDVUDa9aI0nqL/OD6xRQqS2bbitDq7VIpzyerEbYh8BiyUwbxprh
 hdEpeZ+q3dFDTAjQdZ5pbblT6DOUyvcieV4RIuBP0i2m/rlx5E6el7XNjqRMKUnapO34
 10rctw9lqvEoODTovyLRASFgTFuaFCg4B9/YmZkesrex8N31wYSxFH6J4ejtK8trmOFl
 8fvg==
X-Gm-Message-State: APjAAAUVNLU3lgnyrxfTWf+3b8cNx+Et5VEOkpvA9JM2+9EZh8V6khc5
 ftgnzUOrFn68G4Bydko8T871hVIBSNY/jLy3ChKKVMU+H52FBO8C+l97RVj1QVUZIT8RJVVyjIY
 6f9crvmGhvBnha0Y=
X-Received: by 2002:adf:b605:: with SMTP id f5mr29414072wre.383.1582056440454; 
 Tue, 18 Feb 2020 12:07:20 -0800 (PST)
X-Google-Smtp-Source: APXvYqyPI+w3k02V1gsRQPOpAFrfSTNrgI0Lt+9d76EBZMw30h3gWZQNni8kwQ7kMtrlp7uVsuZg6A==
X-Received: by 2002:adf:b605:: with SMTP id f5mr29414039wre.383.1582056440142; 
 Tue, 18 Feb 2020 12:07:20 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id t12sm7294853wrq.97.2020.02.18.12.07.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Feb 2020 12:07:19 -0800 (PST)
Subject: Re: [PATCH] Avoid cpu_physical_memory_rw() with a constant is_write
 argument
To: Peter Maydell <peter.maydell@linaro.org>, Stefan Weil <sw@weilnetz.de>
References: <20200218132023.22936-1-philmd@redhat.com>
 <87e06de3-179b-54a1-3451-39a0a30b65f0@weilnetz.de>
 <CAFEAcA9Jr2Yi1K8_9MGUJYt8C=OcKbWDh1UJjTQG1EspLux3JQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <af34169f-fccc-da44-7b8e-1b38da4a203c@redhat.com>
Date: Tue, 18 Feb 2020 21:07:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9Jr2Yi1K8_9MGUJYt8C=OcKbWDh1UJjTQG1EspLux3JQ@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: Uir83PglOJOf5InGeOV-qw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Durrant <paul@xen.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 "open list:X86" <xen-devel@lists.xenproject.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/18/20 7:49 PM, Peter Maydell wrote:
> On Tue, 18 Feb 2020 at 17:57, Stefan Weil <sw@weilnetz.de> wrote:
>>
>> Am 18.02.20 um 14:20 schrieb Philippe Mathieu-Daud=C3=A9:
>>
>>> This commit was produced with the included Coccinelle script
>>> scripts/coccinelle/as-rw-const.patch.
>>>
>>> Inspired-by: Peter Maydell <peter.maydell@linaro.org>
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>> ---
>>> Based-on: <20200218112457.22712-1-peter.maydell@linaro.org>
>> [...]
>>> diff --git a/target/i386/hax-all.c b/target/i386/hax-all.c
>>> index a8b6e5aeb8..f5971ccc74 100644
>>> --- a/target/i386/hax-all.c
>>> +++ b/target/i386/hax-all.c
>>> @@ -376,8 +376,8 @@ static int hax_handle_fastmmio(CPUArchState *env, s=
truct hax_fastmmio *hft)
>>>            *  hft->direction =3D=3D 2: gpa =3D=3D> gpa2
>>>            */
>>>           uint64_t value;
>>> -        cpu_physical_memory_rw(hft->gpa, (uint8_t *) &value, hft->size=
, 0);
>>> -        cpu_physical_memory_rw(hft->gpa2, (uint8_t *) &value, hft->siz=
e, 1);
>>> +        cpu_physical_memory_read(hft->gpa, (uint8_t *)&value, hft->siz=
e);
>>> +        cpu_physical_memory_write(hft->gpa2, (uint8_t *)&value, hft->s=
ize);
>>
>>
>> Maybe those type casts could be removed, too. They are no longer needed
>> after your modification.
>=20
> I think that we should fix the inconsistency where these functions
> all take "uint8_t* buf":
>=20
>   - address_space_rw()
>   - address_space_read()
>   - address_space_write()
>   - address_space_write_rom()
>   - cpu_physical_memory_rw()
>   - cpu_memory_rw_debug()
>=20
> but these take void*:
>   - cpu_physical_memory_read()
>   - cpu_physical_memory_write()
>   - address_space_write_cached()
>   - address_space_read_cached_slow()
>   - address_space_write_cached_slow()
>   - pci_dma_read()
>   - pci_dma_write()
>   - pci_dma_rw()
>   - dma_memory_read()
>   - dma_memory_write()
>   - dma_memory_rw()
>   - dma_memory_rw_relaxed()

I don't understand well cpu_physical_memory*(). Aren't these obsolete?
They confuse me when using multi-core CPUs.

>=20
> Depending on which way we go we would either want to remove these
> casts, or not.
>=20
> I guess that we have more cases of 'void*', and that would
> certainly be the easier way to convert (otherwise we probably
> need to add a bunch of new casts to uint8_t* in various callsites),
> but I don't have a strong opinion. Paolo ?

I thought about it too but it is quite some work, and I'v to admit I=20
lost some faith with my previous chardev conversion. There Paolo/Daniel=20
agreed to follow the libc read()/write() prototypes.

>=20
> thanks
> -- PMM
>=20


