Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F63C33CA2
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 10:25:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7431D20721
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 10:25:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M3Iy32Or"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7431D20721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iprU2-0002VH-6E
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 05:25:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59474)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iprTI-0001s1-NO
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 05:24:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iprTH-0002kW-Bz
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 05:24:52 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55381
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iprTH-0002gR-78
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 05:24:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578651890;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9U3/EG21C2tfqsHu3qJMfdsi1C954KfRso4RHsOu99c=;
 b=M3Iy32OrpO6cgdpDhGRRpJqZEP28D8GfgdvmFL+vB40a+/zTPOMFmVzApdeUh+9K6mrJFP
 B+Usefe953Cxy8vY5e46CmxvTjsWOY8Iaz/5h/fMVCqpq6Z7B45/ZxTEpjgHLF0DlAwLX1
 5Dubr2h+sqQ0zvBs4owEeQrQn42xCQw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-CI16UhK7NbqAYzcOwm9G1g-1; Fri, 10 Jan 2020 05:24:48 -0500
Received: by mail-wm1-f71.google.com with SMTP id t16so579880wmt.4
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2020 02:24:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YkWvxsJ2SABp/lWqbkSDgTJ+bOcPq06kctyMB3xjxrI=;
 b=H6lFhrkc1wm0ZmikuQURG33niX1JhG43yX1fSQWY9R7IV73tMcdY3t5CXA4scCRHZg
 yzHAkzhmGQAckDJEZ2uOZicAGbzrf67VBDS8z3sGj/og1v6jdfHt/29IBET6jb8zJAku
 xFaBlYlsWNYkScTreQO3iuLSF1yfS50irqBRVGL/sM3w8UopUT3mQ8i/ojf9bBHBAiQ2
 j7jxTOW+Bu5mwNIY0zdpW1j6SMNqVbHyYQhJo00rnZSKQ8IRxXOgSmhADq9gRRXa81+b
 q+z+kP1qKxstUfFq8FrEzB0ALofYHTMdxGFgzvy05yWxm8RLUenVi34yd4W31rUDpdKX
 mmQA==
X-Gm-Message-State: APjAAAWKmt7W/bMD+LLjZT8M8s2QDXVtvJI1Jq53EF1uzT9PfWNMiU/J
 s0xFvlSblxMrP6AhmbHBvTYL+ho+HzNO0uU+i2nFYSVsLuV4UXhZvUxCE7+UmtYwoLRXrz2CZyw
 hONXmvLIekkjFj+Q=
X-Received: by 2002:a5d:6a88:: with SMTP id s8mr2594207wru.173.1578651887049; 
 Fri, 10 Jan 2020 02:24:47 -0800 (PST)
X-Google-Smtp-Source: APXvYqymdYOYGS7WbCV0aI3slV++jCdG+Uk9KSz5wIZZ2ZaAhz+QSfUqqEqzUHPjG8uxfgdxy3C/zQ==
X-Received: by 2002:a5d:6a88:: with SMTP id s8mr2594181wru.173.1578651886733; 
 Fri, 10 Jan 2020 02:24:46 -0800 (PST)
Received: from [10.101.1.81] ([176.12.107.132])
 by smtp.gmail.com with ESMTPSA id w20sm1675398wmk.34.2020.01.10.02.24.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jan 2020 02:24:46 -0800 (PST)
Subject: Re: [PATCH 3/5] ftgmac100: check RX and TX buffer alignment
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200107073423.30043-1-clg@kaod.org>
 <20200107073423.30043-4-clg@kaod.org>
 <1587acec-3d08-9dfa-0bcc-37140fd5e2ad@redhat.com>
 <ce0722d4-48ed-e7cd-2436-84d1ee24038f@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <60b09f95-ad05-b420-3900-4afbc95a372c@redhat.com>
Date: Fri, 10 Jan 2020 11:24:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <ce0722d4-48ed-e7cd-2436-84d1ee24038f@kaod.org>
Content-Language: en-US
X-MC-Unique: CI16UhK7NbqAYzcOwm9G1g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/7/20 9:36 AM, C=C3=A9dric Le Goater wrote:
> On 1/7/20 9:27 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 1/7/20 8:34 AM, C=C3=A9dric Le Goater wrote:
>>> These buffers should be aligned on 16 bytes.
>>>
>>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>>> ---
>>>  =C2=A0 hw/net/ftgmac100.c | 13 +++++++++++++
>>>  =C2=A0 1 file changed, 13 insertions(+)
>>>
>>> diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
>>> index 86ac25894a89..051f7b7af2d6 100644
>>> --- a/hw/net/ftgmac100.c
>>> +++ b/hw/net/ftgmac100.c
>>> @@ -198,6 +198,8 @@ typedef struct {
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 des3;
>>>  =C2=A0 } FTGMAC100Desc;
>>>  =C2=A0 +#define FTGMAC100_DESC_ALIGNMENT 16
>>> +
>>>  =C2=A0 /*
>>>  =C2=A0=C2=A0 * Specific RTL8211E MII Registers
>>>  =C2=A0=C2=A0 */
>>> @@ -722,6 +724,12 @@ static void ftgmac100_write(void *opaque, hwaddr a=
ddr,
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->itc =3D valu=
e;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case FTGMAC100_RXR_BADR: /* Ring buffer=
 address */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!QEMU_IS_ALIGNED(value,=
 FTGMAC100_DESC_ALIGNMENT)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qem=
u_log_mask(LOG_GUEST_ERROR, "%s: Bad RX buffer alignment 0x%"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 HWADDR_PRIx "\n", __func__, value);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=
urn;
>>
>> What is the hardware behavior?
>=20
> This is not documented :/

What happens if we don't return?

>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->rx_ring =3D =
value;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->rx_descripto=
r =3D s->rx_ring;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>> @@ -731,6 +739,11 @@ static void ftgmac100_write(void *opaque, hwaddr a=
ddr,
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case FTGMAC100_NPTXR_BADR: /* Tr=
ansmit buffer address */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!QEMU_IS_ALIGNED(value,=
 FTGMAC100_DESC_ALIGNMENT)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qem=
u_log_mask(LOG_GUEST_ERROR, "%s: Bad TX buffer alignment 0x%"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 HWADDR_PRIx "\n", __func__, value);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=
urn;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->tx_ring =3D =
value;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->tx_descripto=
r =3D s->tx_ring;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>>
>>
>=20


