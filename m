Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553AEC352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 17:04:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22EAC21783
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 17:04:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SSdZByPK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22EAC21783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFLZm-0008F4-VG
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 13:04:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57955)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iFLNv-0002Xd-Ft
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 12:52:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iFLNu-0000Qi-ED
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 12:52:23 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28924
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iFLNu-0000Pl-BN
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 12:52:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1569948741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=8vY03vUNYugTK0I45WPqKgTjk9zlGLUN/pHsCB+DEos=;
 b=SSdZByPKDfp1SnGdjamOBSQErjAsPq0FKSeUVvvXtWixAtLWNPq80qdC8/g6XrLBeQooVo
 jK2a/gL+WNIJjFx8yCNngh8DHccfD1yRhY6XRWwdvJV0tCdYPqrRjaYzI2fx6Sx9uUIS09
 ItZSoJQzxo6XuxlvvdLpoZEhVNex6Ec=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-kuIAqlBxMt6WhAckCAlN8g-1; Tue, 01 Oct 2019 12:52:19 -0400
Received: by mail-wr1-f70.google.com with SMTP id i10so6256266wrb.20
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2019 09:52:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7R8AChBGzESU8O+Og5pPPtyBK2Gb47GnMAuxv09fWjs=;
 b=AANtrNIbob195DWD53+qztWi2GMAMmKVOr/wNcxT0mHaKK7+4KaVHlscBpN5z3R4v9
 oKN9HSt2l6jr65ZJn5T/ySdhuJ5tdEj28Q0/LeKnu5d5uKpmJ0ENgzghejiCIlEQjKoc
 g8lLxbmcbj4AykgBXAr8OKgTuNgn5CENlS4zQ34f1jmnGnSfqnWTDFixC5l4bEjRU4De
 x/rFt5vMxefatwFf8xvkxJ/acVj/15IfVb/B7AihBgbiY2g/qYJ05U31l5P2E3c9a4hi
 FDgQJJOYCK0wsGj8Rvu7rNOnPOk4vQoSovPouU5KgKBhKHOTU3PhMcPXRLhtvb30KsPZ
 ttPw==
X-Gm-Message-State: APjAAAUdeHmMKxGavpxLC6YYRX86RR6n2Av7zx1hCYuB3557uhFbCA+l
 1SlceAzQx1UNNgQIv9GPT5+9ORzsP6RBZOd1ZsC5wMhdwcpRSmbWjhI2KAps+OuLMwxweF/CKNC
 T4HvuHLybed6cmFM=
X-Received: by 2002:a1c:cf05:: with SMTP id f5mr4525324wmg.131.1569948737645; 
 Tue, 01 Oct 2019 09:52:17 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwhzXzo/vsqBtWopihaY9TWJ0OAf6onEGckHadJlYaiLfwyYhVXbuiS24bd8lhJLOOJguRxkg==
X-Received: by 2002:a1c:cf05:: with SMTP id f5mr4525305wmg.131.1569948737364; 
 Tue, 01 Oct 2019 09:52:17 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:b903:6d6f:a447:e464?
 ([2001:b07:6468:f312:b903:6d6f:a447:e464])
 by smtp.gmail.com with ESMTPSA id i1sm5034601wmb.19.2019.10.01.09.52.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Oct 2019 09:52:16 -0700 (PDT)
Subject: Re: [PATCH 1/8] ide: fix leak from qemu_allocate_irqs
To: Peter Maydell <peter.maydell@linaro.org>
References: <1569936988-635-1-git-send-email-pbonzini@redhat.com>
 <1569936988-635-2-git-send-email-pbonzini@redhat.com>
 <CAFEAcA-o6DS4JUHGnm4M=nD78U4esN5Jj7F5cuJaA8U1YBrTbQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <0afcb999-e8ba-8212-47f4-8980f35502a3@redhat.com>
Date: Tue, 1 Oct 2019 18:52:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-o6DS4JUHGnm4M=nD78U4esN5Jj7F5cuJaA8U1YBrTbQ@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: kuIAqlBxMt6WhAckCAlN8g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 01/10/19 17:58, Peter Maydell wrote:
> On Tue, 1 Oct 2019 at 14:38, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> The array returned by qemu_allocate_irqs is malloced, free it.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>  hw/ide/cmd646.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/hw/ide/cmd646.c b/hw/ide/cmd646.c
>> index f3ccd11..19984d2 100644
>> --- a/hw/ide/cmd646.c
>> +++ b/hw/ide/cmd646.c
>> @@ -300,6 +300,7 @@ static void pci_cmd646_ide_realize(PCIDevice *dev, E=
rror **errp)
>>          d->bmdma[i].bus =3D &d->bus[i];
>>          ide_register_restart_cb(&d->bus[i]);
>>      }
>> +    g_free(irq);
>>
>>      vmstate_register(DEVICE(dev), 0, &vmstate_ide_pci, d);
>>      qemu_register_reset(cmd646_reset, d);
>> --
>> 1.8.3.1
>=20
> It's a bit weird to be calling qemu_allocate_irqs() here in the
> first place -- usually you'd just have a qemu_irq irqs[2] array
> in the device state struct, qemu_allocate_irq(irq[i], ...) and
> pass irq[i] to the ide_init2() function to tell it what
> qemu_irq to use. Or else you'd keep the pointer to the
> allocated irqs array in the device state struct, so as
> to be able to free it on any theoretical hot-unplug your
> device might support. Calling qemu_allocate_irqs() and then
> immediately freeing the array means that there are now
> two actual qemu_irqs floating around which are supposed
> to be owned by this device but which it has no way to
> get hold of any more. This is only not a leak because
> the cmd646 doesn't support hot-unplug.
>=20
> (Hot take version : we should be getting rid of qemu_allocate_irqs()
> entirely: it is essentially a "pre-QOM" API and there are better
> ways to phrase code that's currently calling it.)

Yes, I agree, and it's why I didn't mind doing the quick fix that gets
rid of the boot-serial-test leak the easy way.

Paolo


