Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87F5C2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 12:17:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9259220730
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 12:17:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VCNH8Lpc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9259220730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyx9F-00037e-RN
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 07:17:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54694)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iyx5Z-0007pz-0A
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 07:13:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iyx5X-0006ih-Oj
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 07:13:56 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:35747
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iyx5X-0006hV-Ky
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 07:13:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580818435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bM2AUf6/agC3QuflAW1mxA/f4pWC9GxZmeEuTCCI+5c=;
 b=VCNH8LpchFiKSnnaSYnzeRi2Sohr9wGPvN7Edp3gAcCLnBB/Ik/oxeq5Rvjay+m9LhvyIO
 goG+rgJ3D9iFombhMN+El7t4sDRMwhBqU701ztuUsV7eea6IJNUhC7I7OKA0eAcvryCFCD
 gRVljeIJ30o7j/STkmH1ZZ/pQb7HNYo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-bfoSZbWROy6CWjusiVMUfw-1; Tue, 04 Feb 2020 07:13:53 -0500
Received: by mail-wr1-f71.google.com with SMTP id s13so10074081wrb.21
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2020 04:13:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QIF3Yi9//ahh9LDSvFZ7uu6Is+Gug4m3kf8x2yrnYno=;
 b=pBYQU9hReDDuKKR4+RBjhqazlOabFNst2KmgRz6OSw2ol1Pnenqdo1P37scRf/zNxc
 7x8/B8Rg1kGL3zPeq57K9uWcSHbPJGfGbHY5rP6XwQ0kldlX+jI9MCnoeI12/E7OwpEF
 H0QjXkKbh7PQcu02/fHxbU+SLLU6qwsD1Ct5NzO1iwQMSsztVpMv055UF2gtKzfl0vlV
 3MMS8pHyUjMyGuRQyPn/6UHLUfeN32+kzAThGQ3Zjh0aroloUSb912MkYyOfrzD+tv9R
 3qhY1Vc8L1MZzTZddBxSBe6oX4xnnPu9lNH7tNK22l0QiBOHSpbvPpnNE/kh1UpCsktR
 vrnw==
X-Gm-Message-State: APjAAAVyeGag0DerH+gBJO4i1Rf/xtjTdif2OukPPe4489aQWW9G1wFW
 Xcl2VweXlyMjLSlu0TzbS0IEvJNDXhln4F4J1z2VUP5AxF+ljnbtFFLbldAvuHh3rdob8PQ+rCG
 2j0UmkUKOyt8i6Zs=
X-Received: by 2002:adf:ecd0:: with SMTP id s16mr21559931wro.325.1580818432512; 
 Tue, 04 Feb 2020 04:13:52 -0800 (PST)
X-Google-Smtp-Source: APXvYqz+l6yPKjZHleHNOSxGlVYj+qo6dy+YppdWbhZVriKSX6IbFbnB1QZ61/blUpEvNuSEhYn3jw==
X-Received: by 2002:adf:ecd0:: with SMTP id s16mr21559906wro.325.1580818432283; 
 Tue, 04 Feb 2020 04:13:52 -0800 (PST)
Received: from [192.168.1.35] (162.red-83-52-55.dynamicip.rima-tde.net.
 [83.52.55.162])
 by smtp.gmail.com with ESMTPSA id b16sm3494953wmj.39.2020.02.04.04.13.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Feb 2020 04:13:51 -0800 (PST)
Subject: Re: [PATCH 2/3] m25p80: Improve command handling for Jedec and
 unsupported commands
To: Guenter Roeck <linux@roeck-us.net>,
 Alistair Francis <alistair@alistair23.me>
References: <20200203180904.2727-1-linux@roeck-us.net>
 <20200203180904.2727-2-linux@roeck-us.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <eb5762ed-4b3c-a00d-dc56-8ec2315fe331@redhat.com>
Date: Tue, 4 Feb 2020 13:13:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200203180904.2727-2-linux@roeck-us.net>
Content-Language: en-US
X-MC-Unique: bfoSZbWROy6CWjusiVMUfw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, Andrew Jeffery <andrew@aj.id.au>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Guenter,

On 2/3/20 7:09 PM, Guenter Roeck wrote:
> Always report 6 bytes of JEDEC data. Fill remaining data with 0.
>=20
> For unsupported commands, keep sending a value of 0 until the chip
> is deselected.

Two changes, I'd rather see 2 patches. If you happen to respin they are=20
welcome. As the split is trivial maybe a block maintainer is OK to do=20
it. Regardless the outcome:
Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

>=20
> Both changes avoid attempts to decode random commands. Up to now this
> happened if the reported Jedec data was shorter than 6 bytes but the
> host read 6 bytes, and with all unsupported commands.
>=20
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>   hw/block/m25p80.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
> index 63e050d7d3..aca75edcc1 100644
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
> @@ -1158,6 +1161,11 @@ static void decode_new_cmd(Flash *s, uint32_t valu=
e)
>           s->quad_enable =3D false;
>           break;
>       default:
> +        s->pos =3D 0;
> +        s->len =3D 1;
> +        s->state =3D STATE_READING_DATA;
> +        s->data_read_loop =3D true;
> +        s->data[0] =3D 0;
>           qemu_log_mask(LOG_GUEST_ERROR, "M25P80: Unknown cmd %x\n", valu=
e);
>           break;
>       }
>=20


