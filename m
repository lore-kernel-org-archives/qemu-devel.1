Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1085C33CAC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 18:37:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F50B214AF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 18:37:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ToVtm+RE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F50B214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izm20-0007AV-QT
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 13:37:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35141)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1izm0q-0005dN-LG
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 13:36:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1izm0p-0002JP-Il
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 13:36:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36962
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1izm0p-0002IR-BK
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 13:36:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581014184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mo9yRQw1REoBA/MyFi8tTI1bRXGJ3OlE8vgJmMfM5a0=;
 b=ToVtm+REfTaN6Ut0rvWX6i2pDQfq4BS6D3nZ0GnaSUfGwhKDzGqfcuuLmnzv4laQU8FknP
 +jCRqVXI8GlvAtmTB0r6IYIo3mrAG5ls4V4xJ+nWHdYmbs0zQCVCDfg3ac7X7G4zcQUGey
 K7XHL5aPRAH54jynDzSr+62+9kER/Ds=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-AmVarzChPv2UPPFc8OdqJw-1; Thu, 06 Feb 2020 13:36:20 -0500
Received: by mail-wr1-f71.google.com with SMTP id t3so3893444wrm.23
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 10:36:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=d2CB3VjmYgy2Vv4LniaDWxlOYqVJgHczX0WcYY9SVVI=;
 b=SE8vX0fSzQy+nEiY/Jc/3os5t8g4QEHFN39Kc2QEDv2uuiwmB+0nzRt+RAtz9vUmsp
 M3h5l5sBYQXgSnUStxa/VQERDDiGloEZvzGZSj6bgrh4xiQxMb7GN8ORV5cQ/ZXWRV4i
 HiSWuUigg3c3dmqVi9k0vwr5lvCePihyw2qQog97P5UtrcxJnY0vp01fLFTBEwJIONb0
 E5N37CVRISWhs/lvF7apA7jlj9+NjjSEOwPk2blrjY0dn/hxCPEFFJEG73YOuCr9X1Gm
 3x6dV+FRavgcDXXpdkPETCKQ3kisVN0iDchUz9juusSMQp6F7ISD7ygUTzvGQ/iK+eK4
 7Asw==
X-Gm-Message-State: APjAAAUIW98XoAdIR43ZMvPu88Q9vWsDc7MJfn3M1/nGawM8FoJOcV33
 NPpbP5e0XvXmnZ1KUHxp+AREg7NC24HuOu5BpwouhwQ/OxiqwZqxQkPg5YseH4PltAzU7DVUOj8
 C9dV/XqaAEu0hH6E=
X-Received: by 2002:a5d:6708:: with SMTP id o8mr5403129wru.296.1581014179635; 
 Thu, 06 Feb 2020 10:36:19 -0800 (PST)
X-Google-Smtp-Source: APXvYqyurCrMueg881uyh0F3O/o3buJvQRPn8BB71aqpfjiCewVBs5YjglBdnUGqP4vt+8eR2/ZmHA==
X-Received: by 2002:a5d:6708:: with SMTP id o8mr5403104wru.296.1581014179444; 
 Thu, 06 Feb 2020 10:36:19 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id s8sm159400wrt.57.2020.02.06.10.36.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2020 10:36:19 -0800 (PST)
Subject: Re: [PATCH v2 2/4] m25p80: Improve command handling for Jedec commands
To: Guenter Roeck <linux@roeck-us.net>,
 Alistair Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>
References: <20200206183219.3756-1-linux@roeck-us.net>
 <20200206183219.3756-2-linux@roeck-us.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a2755daa-6cf9-4858-4b0e-d160efc2fc8a@redhat.com>
Date: Thu, 6 Feb 2020 19:36:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200206183219.3756-2-linux@roeck-us.net>
Content-Language: en-US
X-MC-Unique: AmVarzChPv2UPPFc8OdqJw-1
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Andrew Jeffery <andrew@aj.id.au>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/6/20 7:32 PM, Guenter Roeck wrote:
> When requesting JEDEC data using the JEDEC_READ command, the Linux kernel
> always requests 6 bytes. The current implementation only returns three
> bytes, and interprets the remaining three bytes as new commands.
> While this does not matter most of the time, it is at the very least
> confusing. To avoid the problem, always report up to 6 bytes of JEDEC
> data. Fill remaining data with 0.
>=20
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: Split patch into two parts; improved decription
>=20
>   hw/block/m25p80.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
> index 5ff8d270c4..53bf63856f 100644
> --- a/hw/block/m25p80.c
> +++ b/hw/block/m25p80.c
> @@ -1040,8 +1040,11 @@ static void decode_new_cmd(Flash *s, uint32_t valu=
e)
>           for (i =3D 0; i < s->pi->id_len; i++) {
>               s->data[i] =3D s->pi->id[i];
>           }
> +        for (; i < SPI_NOR_MAX_ID_LEN; i++) {
> +            s->data[i] =3D 0;
> +        }
>  =20
> -        s->len =3D s->pi->id_len;
> +        s->len =3D SPI_NOR_MAX_ID_LEN;
>           s->pos =3D 0;
>           s->state =3D STATE_READING_DATA;
>           break;
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


