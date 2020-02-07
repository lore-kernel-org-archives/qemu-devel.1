Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C34CEC35247
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 00:22:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D76F2064C
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 00:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="caExLLc/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D76F2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izrPY-0004Dk-Lb
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 19:22:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58141)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1izrOb-0003FC-9U
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 19:21:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1izrOa-00008P-3i
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 19:21:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49986
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1izrOa-00007j-0D
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 19:21:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581034879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s3Q4FUv0JvyibRsw6iAxeHyN5xi5kNpFADNMc7DiO3c=;
 b=caExLLc/AgYOizaH0sZ6RpfCzGYUgU9vK6FVR40WRhw54XPaXeSJy64pKUDIWiFh5SrU+6
 Y4JxZBDd/Tr+YBg+AqLh/d/VM6kbW5+12CB0EZSusz0IIIqH5mjMzey53fHfRvKPu0v0vQ
 U+fs6pz/N8ZI23Mdf18yhLlwwfTEtmc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-eXLK7SBlNZqesa9f4FwAJQ-1; Thu, 06 Feb 2020 19:21:17 -0500
Received: by mail-wr1-f71.google.com with SMTP id s13so330453wru.7
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 16:21:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lLkZD4wBLDRhGKRYrPoACT34vqZqYhy2O17uqclLv0c=;
 b=DmWrOmO4e8OXWyNbXIZsk9290uusy1jStscAVBF20DYb60idQmerAN8EHdU+V8lhKS
 epYTc4NALVcf6Rt3Y7RwDOnTLhsE2mybYznokx3olo+1oil3pBznu+z1WRkSHjZ0Dosg
 Asr7V3ItHcKGEFdIi4h4WCqGClpzriG1WbTe8QAVMdckY1M8JYvJavrNxIk4JH1xNdsr
 U8SFoISz+irjYLDhr0C2s0I2WgDBOu4Xcm9uwxBj/kJgaGNJEyLsnD4RMv0yP5sYMtGU
 Tkp13S7/c2x+uP+5enyQhbvAf9nBQpKxHiIvg+9Z+XMx+lnj8vvXVARcRFhiY3rYjdE/
 tTuQ==
X-Gm-Message-State: APjAAAVYUWT14OluJyFmn1ZwoAYsgS1IgVnsmnncKp23o/rWY7fRTH6c
 IpjZ5FT9hTOuiLGcyqYfLWci34hzG2NkONudUoy1rFg720oSe/iXUahwDgg6S9LsTbNUBzvhoKs
 MRkGiLXzZ6meI8lg=
X-Received: by 2002:a7b:c3d1:: with SMTP id t17mr442451wmj.27.1581034875068;
 Thu, 06 Feb 2020 16:21:15 -0800 (PST)
X-Google-Smtp-Source: APXvYqxUHVMRMyUnKwj4ohZBkRPjRK5fe7aVq9u0WkTm5q2hrPaEyooRrEMZ+akFXpL/AKQABQbF1g==
X-Received: by 2002:a7b:c3d1:: with SMTP id t17mr442396wmj.27.1581034874696;
 Thu, 06 Feb 2020 16:21:14 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id v17sm1123352wrt.91.2020.02.06.16.21.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2020 16:21:14 -0800 (PST)
Subject: Re: [PATCH v2 3/4] m25p80: Improve command handling for unsupported
 commands
To: Guenter Roeck <linux@roeck-us.net>,
 Alistair Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>
References: <20200206183219.3756-1-linux@roeck-us.net>
 <20200206183219.3756-3-linux@roeck-us.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ad276d31-ae72-3349-86cc-6339ec250c74@redhat.com>
Date: Fri, 7 Feb 2020 01:21:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200206183219.3756-3-linux@roeck-us.net>
Content-Language: en-US
X-MC-Unique: eXLK7SBlNZqesa9f4FwAJQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Andrew Jeffery <andrew@aj.id.au>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/6/20 7:32 PM, Guenter Roeck wrote:
> Whenever an unsupported command is encountered, the current code
> interprets each transferred byte as new command. Most of the time, those
> 'commands' are interpreted as new unknown commands. However, in rare
> cases, it may be that for example address or length information
> passed with the original command is by itself a valid command.
> If that happens, the state machine may get completely confused and,
> worst case, start writing data into the flash or even erase it.
>=20
> To avoid the problem, transition into STATE_READING_DATA and keep
> sending a value of 0 until the chip is deselected after encountering
> an unsupported command.
>=20
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: Split patch into two parts; improved description.
>=20
>   hw/block/m25p80.c | 5 +++++
>   1 file changed, 5 insertions(+)
>=20
> diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
> index 53bf63856f..8227088441 100644
> --- a/hw/block/m25p80.c
> +++ b/hw/block/m25p80.c
> @@ -1161,6 +1161,11 @@ static void decode_new_cmd(Flash *s, uint32_t valu=
e)
>           s->quad_enable =3D false;
>           break;
>       default:
> +        s->pos =3D 0;
> +        s->len =3D 1;
> +        s->state =3D STATE_READING_DATA;
> +        s->data_read_loop =3D true;
> +        s->data[0] =3D 0;

Maybe self-explicit using:

            s->data[0] =3D NOP;

Matter of taste probably, but I find this order easier to review:

            s->state =3D STATE_READING_DATA;
            s->data_read_loop =3D true;
            s->pos =3D 0;
            s->data[0] =3D NOP;
            s->len =3D 1;

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>           qemu_log_mask(LOG_GUEST_ERROR, "M25P80: Unknown cmd %x\n", valu=
e);
>           break;
>       }
>=20


