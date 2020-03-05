Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB9F2C3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 13:51:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93E232073B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 13:51:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JE1KE+CA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93E232073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9qug-0002Mg-QF
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 08:51:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55162)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j9qtr-0000ra-Ju
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 08:50:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j9qtq-0005m3-2n
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 08:50:55 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44707
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j9qtp-0005jw-Ub
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 08:50:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583416253;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xhvmeQKmopG5k0uJ4+vrfp077YnSr3H8/tT/qhAvNW0=;
 b=JE1KE+CA3DSlt4Gb8DgTZDAi63mlJjVZTLXL08m9+yuNEkVSUS+vhxSgL6LlB+novWyhvq
 OixqSZ4e5beDliBDpF4zYjzArBRIwGvy73AxgiQxUZHy/fDzj6mLoaPiAAwJV8zGpVq8Tz
 Y7rmxDwIoyUnD5ZdnqUeelpyWW8c8wg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-fpJOu053OD6XtmQ9HobX7w-1; Thu, 05 Mar 2020 08:50:51 -0500
X-MC-Unique: fpJOu053OD6XtmQ9HobX7w-1
Received: by mail-ed1-f69.google.com with SMTP id n12so4403475edq.13
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 05:50:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FczaLAHo70jYoiAcYCqrVkMcH+yLOT6+VLH7lNNudvc=;
 b=ufQRY1ttKj9MybsrlOja0LG4yuq6ywdx9g86f27g7yUkdjpzeGvtsCmVrFR74iiW46
 wCkqzgsJrIXBTIJBGVZF47hrU03arf2xsgPdWeR8vvKqSADJQpU+WteNai+gEkTJbaEi
 lT3ZvnFV0z0hejcUW7oRDwj2WLl+JLLqjdKpcMLrm26xoEUAiPfGxSDufCh+kaNlWgo+
 VkZgN7cKLzViz5pSMvmXfJXSlRvNpLjHpRT8oC1iEFCLGf6EDN5IXTYufaVb/YWEaLqf
 bjVfm9Jc8EgsGSvtQdxSuoD0U7XzC0EItPdc7BJ/LOh4Rt2XFtJo2CPdGVRgwF1LaKrq
 JnzQ==
X-Gm-Message-State: ANhLgQ1+i996k/9LP75tBNRPBNXmrbY4x2tGZzkEUUInjjyP6hZWpXRW
 RVTdTRfHmfnl7ct462EzXjM+/ksIef5B3mYUPziRol5V25JaeqOQXGsM9nC9hw7ZbRn18fEBn+X
 6MoNOxeiLE9qyadw=
X-Received: by 2002:a50:84a3:: with SMTP id 32mr8113765edq.328.1583416250141; 
 Thu, 05 Mar 2020 05:50:50 -0800 (PST)
X-Google-Smtp-Source: ADFU+vuK/GFGTtsRoyrNYmr651A3JJXoGHj9/o0si96xiVBAQyWd7uclfj+VRxW7ca8rIwvVRTRPJA==
X-Received: by 2002:a50:84a3:: with SMTP id 32mr8113740edq.328.1583416249885; 
 Thu, 05 Mar 2020 05:50:49 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id z13sm1064890edl.52.2020.03.05.05.50.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Mar 2020 05:50:49 -0800 (PST)
Subject: Re: [PATCH v2 2/9] hw/audio/fmopl: Move ENV_CURVE to .heap to save
 32KiB of .bss
To: Stefano Garzarella <sgarzare@redhat.com>
References: <20200305124525.14555-1-philmd@redhat.com>
 <20200305124525.14555-3-philmd@redhat.com>
 <20200305134403.sagzdlf5iyk2iufs@steredhat>
 <20200305134837.ucdb6blcguyfrh6d@steredhat>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <467b8f3a-7d11-8a10-009f-5e1affadea69@redhat.com>
Date: Thu, 5 Mar 2020 14:50:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200305134837.ucdb6blcguyfrh6d@steredhat>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-trivial@nongnu.org,
 Jason Wang <jasowang@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/5/20 2:48 PM, Stefano Garzarella wrote:
> On Thu, Mar 05, 2020 at 02:44:03PM +0100, Stefano Garzarella wrote:
>> On Thu, Mar 05, 2020 at 01:45:18PM +0100, Philippe Mathieu-Daud=C3=A9 wr=
ote:
>>> This buffer is only used by the adlib audio device. Move it to
>>> the .heap to release 32KiB of .bss (size reported on x86_64 host).
>>>
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>> ---
>>>   hw/audio/fmopl.c | 4 +++-
>>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/audio/fmopl.c b/hw/audio/fmopl.c
>>> index 173a7521f2..356d4dfbca 100644
>>> --- a/hw/audio/fmopl.c
>>> +++ b/hw/audio/fmopl.c
>>> @@ -186,7 +186,7 @@ static int32_t *VIB_TABLE;
>>>  =20
>>>   /* envelope output curve table */
>>>   /* attack + decay + OFF */
>>> -static int32_t ENV_CURVE[2*EG_ENT+1];
>>> +static int32_t *ENV_CURVE;
>>>  =20
>>>   /* multiple table */
>>>   #define ML 2
>>> @@ -1090,6 +1090,7 @@ FM_OPL *OPLCreate(int clock, int rate)
>>>   =09OPL->clock =3D clock;
>>>   =09OPL->rate  =3D rate;
>>>   =09OPL->max_ch =3D max_ch;
>>> +    ENV_CURVE =3D g_new(int32_t, 2 * EG_ENT + 1);
>=20
> Should we use g_new0() ?

No because the array is filled before being used. I can add a note about=20
this.

>=20
>>>   =09/* init grobal tables */
>>>   =09OPL_initialize(OPL);
>>>   =09/* reset chip */
>>> @@ -1127,6 +1128,7 @@ void OPLDestroy(FM_OPL *OPL)
>>>   #endif
>>>   =09OPL_UnLockTable();
>>>   =09free(OPL);
>>> +    g_free(ENV_CURVE);
>>
>> Just for curiosity, here the entire fmopl.c is indented with tabs.
>>
>> In this case, is it better to continue with the tabs or use spaces
>> for new changes?
>>
>> Anyway the changes LGTM:
>> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>=20


