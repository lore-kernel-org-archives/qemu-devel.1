Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF03DC2D0CE
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 00:15:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9BE124682
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 00:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZAEVfRoj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9BE124682
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ige3J-0004L6-PL
	for qemu-devel@archiver.kernel.org; Sun, 15 Dec 2019 19:15:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55368)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ige2D-0003iL-Au
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 19:14:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ige2A-0005jG-87
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 19:14:47 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32094
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ige29-0005fm-Mb
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 19:14:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576455284;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y0LLlI99L0EqdKViDjBQTUbG2sepIaYjbw6/dDJrf+k=;
 b=ZAEVfRojekbo7h8hrY4VFMxuj3N1pJeX4k9/PDW6x0IAAlwgKZaNSrhpAgyfRUZTh0NIl0
 enchKIL8btoaqPLMcGKMfD12iknB8vU7VQ645XRkAPpiQ4IkYb0zFCcLUKEdsCko1L04/e
 p+nkN5anL5EbY/V4XhNHYagtI1rw4Xk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-deo3HtMrNPevm1jet9rgfg-1; Sun, 15 Dec 2019 19:14:42 -0500
Received: by mail-wr1-f71.google.com with SMTP id h30so2806363wrh.5
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2019 16:14:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zEZZPFMofCKGRcBsQV1uHg9KBmUQ1xCItM4qKpPBjjc=;
 b=kqGPJR54yldbPVYiwlGxWoEfCV3lQpOofJL+RbnBCx9ZzOHfx6Ne4GH4FfH9Ywf/jM
 Exkdjtzm0BXGXPHZeO3asGU0voZ/u8RcFvrf0166TViNYgJ2NkRJSxhkkSzeCAZ4Q5uE
 E7t/Y1dTLrVpcCq7BpfVBiVU1YCs9UoXzcxKNsUq/uyIVTz5WfOv9kmTvwLM1a5uqZGH
 Om46ERotyU6P9PZjzbRy2Kj6k2ADjU8PR0b+2zQir6HaoW/Lg9lPknyQFjlkdNYRvMxW
 jLlvj5GBxSJMzr8APU2wzvUd31wWSLluyj5U4P6EDNRkctDFrDMB2tQ5GB6/77kWzt4+
 BaTQ==
X-Gm-Message-State: APjAAAVeJ6jPwzpHz/jX5+uqGmJJAKR2X23PTo7KveioYprvRnkPHMwi
 6pxprfLh+jneJwSSUZQJq58IeguwV+4OEJzP0LgmRVHGfuXSdop8UgiOBnOlJO5r5p2N/9LjB+s
 0V02fF0pEKmmbDbo=
X-Received: by 2002:adf:cf12:: with SMTP id o18mr27021283wrj.361.1576455281358; 
 Sun, 15 Dec 2019 16:14:41 -0800 (PST)
X-Google-Smtp-Source: APXvYqyYk4RmYalApSJ3DwLm+o40qGMGxHork5md7+VqHVjBveJneVn2r0T73qjiJQbh6KZwrtCWgA==
X-Received: by 2002:adf:cf12:: with SMTP id o18mr27021259wrj.361.1576455281040; 
 Sun, 15 Dec 2019 16:14:41 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id o15sm19963027wra.83.2019.12.15.16.14.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Dec 2019 16:14:40 -0800 (PST)
Subject: Re: [PATCH 09/10] arm: allwinner-h3: add SD/MMC host controller
To: Niek Linnenbank <nieklinnenbank@gmail.com>
References: <20191202210947.3603-1-nieklinnenbank@gmail.com>
 <20191202210947.3603-10-nieklinnenbank@gmail.com>
 <CAPan3WrRKnu5vFz=JvrnD8tewUk7SdwFVYx4xVL353AnfPDgHQ@mail.gmail.com>
 <6bee15d7-7d80-0709-ac90-ef2052b39329@redhat.com>
 <CAPan3WpiWahU85-ZgV4BMPU8mUTxsq2TPn-szOHkHc5+PHUqpw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <03a78f1d-e8fe-5a53-b061-d39de9ed7a9e@redhat.com>
Date: Mon, 16 Dec 2019 01:14:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAPan3WpiWahU85-ZgV4BMPU8mUTxsq2TPn-szOHkHc5+PHUqpw@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: deo3HtMrNPevm1jet9rgfg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: Beniamino Galvani <b.galvani@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/16/19 12:07 AM, Niek Linnenbank wrote:
>=20
>=20
> On Fri, Dec 13, 2019 at 12:56 AM Philippe Mathieu-Daud=C3=A9=20
> <philmd@redhat.com <mailto:philmd@redhat.com>> wrote:
>=20
>     Hi Niek,
>=20
>     On 12/11/19 11:34 PM, Niek Linnenbank wrote:
[...]
>      >=C2=A0 =C2=A0 =C2=A0+static uint32_t aw_h3_sdhost_process_desc(AwH3=
SDHostState *s,
>      >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 hwaddr desc_addr,
>      >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 TransferDescriptor
>     *desc,
>      >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool is_write,
>     uint32_t
>      >=C2=A0 =C2=A0 =C2=A0max_bytes)
>      >=C2=A0 =C2=A0 =C2=A0+{
>      >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 uint32_t num_done =3D 0;
>      >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 uint32_t num_bytes =3D max_bytes=
;
>      >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 uint8_t buf[1024];
>      >=C2=A0 =C2=A0 =C2=A0+
>      >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 /* Read descriptor */
>      >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 cpu_physical_memory_read(desc_ad=
dr, desc, sizeof(*desc));
>=20
>     Should we worry about endianess here?
>=20
>=20
> I tried to figure out what is expected, but the=20
> Allwinner_H3_Datasheet_V1.2.pdf does not
> explicitly mention endianness for any of its I/O devices. Currently it=20
> seems all devices are
> happy with using the same endianness as the CPUs. In the MemoryRegionOps=
=20
> has DEVICE_NATIVE_ENDIAN
> set to match the behavior seen.

OK.

[...]
>      >=C2=A0 =C2=A0 =C2=A0+static const MemoryRegionOps aw_h3_sdhost_ops =
=3D {
>      >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 .read =3D aw_h3_sdhost_read,
>      >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 .write =3D aw_h3_sdhost_write,
>      >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 .endianness =3D DEVICE_NATIVE_EN=
DIAN,
>=20
>     I haven't checked .valid accesses from the datasheet.
>=20
>     However due to:
>=20
>      =C2=A0 =C2=A0res =3D s->data_crc[((offset - REG_SD_DATA7_CRC) / size=
of(uint32_t))];
>=20
>     You seem to expect:
>=20
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .impl.min_access_size =3D =
4,
>=20
>     .impl.max_access_size unset is 8, which should works.
>=20
> It seems that all registers are aligned on at least 32-bit boundaries.=20
> And the section 5.3.5.1 mentions
> that the DMA descriptors must be stored in memory 32-bit aligned. So=20
> based on that information,

So you are describing ".valid.min_access_size =3D 4", which is the minimum=
=20
access size on the bus.
".impl.min_access_size" is different, it is what access sizes is ready=20
to handle your model.
Your model read/write handlers expect addresses aligned on 32-bit=20
boundary, this is why I suggested to use ".impl.min_access_size =3D 4". If=
=20
the guest were using a 16-bit access, your model would be buggy. If you=20
describe your implementation to accept minimum 32-bit and the guest is=20
allowed to use smaller accesses, QEMU will do a 32-bit access to the=20
device, and return the 16-bit part to the guest. This way your model is=20
safe. This is done by access_with_adjusted_size() in memory.c.
If you restrict with ".valid.min_access_size =3D 4", you might think we=20
don't need ".valid.min_access_size =3D 4" because all access from guest=20
will be at least 32-bit. However keep in mind someone might find this=20
device in another datasheet not limited to 32-bit, and let's say change=20
to ".valid.min_access_size =3D 2". Without ".impl.min_access_size =3D 4"=20
your model is buggy. So to be safe I'd use:

   .impl.min_access_size =3D 4,
   .valid.min_access_size =3D 4,


> I think 32-bit is a safe choice. I've verified this with Linux mainline=
=20
> and U-Boot drivers and both are still working.

Regards,

Phil.


