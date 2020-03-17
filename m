Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49856C18E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 14:14:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 143BD2051A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 14:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cauJigdW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 143BD2051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jECzh-0006D6-7m
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 10:14:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52943)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jECyr-0005HM-Sz
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 10:14:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jECyq-0001hp-MU
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 10:14:05 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:35061)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jECyq-0001gH-Ih
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 10:14:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584454444;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+UBbZ9tWGjNN43eJbMmPxd6cZVaNwzYUMssw08TDUBA=;
 b=cauJigdW/VGHvhEs5SGMqNlBg/++cqVu5QPpGmkHCyfGxH9FGtahOGp7/rcyZSGxI+88M0
 engAsqg6PSlQFHVIdjWQdjFi3zMph+lvjs45H7rdUXDJT91UN0F0aW+RGa+Vr5DpKCc8Zx
 sOke7cBhLNP2KXs86ByoLdRCRcbE44g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-2b85kIidMXuzKPxun816nQ-1; Tue, 17 Mar 2020 10:14:02 -0400
X-MC-Unique: 2b85kIidMXuzKPxun816nQ-1
Received: by mail-wr1-f70.google.com with SMTP id s4so5336707wrb.19
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 07:14:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6leC9Z3btxw4uzyY0SvMMxSG88hUVvd55XNZE52mFTQ=;
 b=dFt2c3OyMuwg+zCTucfz18oI03Owkbppx68r2jgHmsUfSvfiOACXx+UhkbidWopHUw
 8uixvMj0DhwXToP4W57GfzVv/q1IelPzeepjBA11CcQqE+HmCUOHbBe5vfMdtG5+YuS/
 d+w4tDl7pbgWAA7fjI0fpXEyXg7r54O3/O3zmpHT5rGsk0QViUmKQR8LqiHi+fucBF/9
 tK7sglDlAWo6Yv33p/9DuvyzQtzDEdO6WE2OZUE+zGGVvVyvYviU8N6TFqucuLYEt3ut
 46CAb4NLNZC0dNFHbOhdkoq5WCY7Ngumz0DUnxuoBb5mX51NS9sxWBnOuEt0fBU/rgQm
 d3tQ==
X-Gm-Message-State: ANhLgQ3LLz6/wFmNBt8BUv/Waq4AzZ5ThpCB7xF+YQ1mOKqSFR5upxmI
 nRArZ5r1oulEozs/LZun6Pxj2Sxq8dtlONYrwlBSQz5WJwdCJdBWOLSrXhCT2rcJXcaniWE9WIu
 UBF/RxB2oycY9eGU=
X-Received: by 2002:a5d:63d2:: with SMTP id c18mr6271509wrw.163.1584454441445; 
 Tue, 17 Mar 2020 07:14:01 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuaW0sPCdO+wAc3KufETCkO+J3gQ7g58rcDtbhc3o9CR+3d8VkHlfMmUQM61Rfiih04pZsyKQ==
X-Received: by 2002:a5d:63d2:: with SMTP id c18mr6271497wrw.163.1584454441289; 
 Tue, 17 Mar 2020 07:14:01 -0700 (PDT)
Received: from [192.168.1.34] (96.red-83-59-163.dynamicip.rima-tde.net.
 [83.59.163.96])
 by smtp.gmail.com with ESMTPSA id r3sm3036366wrn.35.2020.03.17.07.14.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Mar 2020 07:14:00 -0700 (PDT)
Subject: Re: [PATCH v10 4/3] hw/sd/ssi-sd: fix error handling in ssi_sd_realize
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200313170517.22480-1-armbru@redhat.com>
 <20200317125741.15301-1-vsementsov@virtuozzo.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d340d29b-f99c-f192-c00d-c1af16a562e5@redhat.com>
Date: Tue, 17 Mar 2020 15:13:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200317125741.15301-1-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: alxndr@bu.edu, ashijeetacharya@gmail.com, paul.durrant@citrix.com,
 armbru@redhat.com, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/17/20 1:57 PM, Vladimir Sementsov-Ogievskiy wrote:
> It's wrong to use same err object as errp parameter for several
> function calls without intermediate checking for error: we'll crash if
> try to set err object twice. Fix that.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>=20
> Forgive me for sending this into your series, but seems it is very
> appropriate.
>=20
> It's rephrasing  of my
>   [PATCH v9 03/10] hw/sd/ssi-sd: fix error handling in ssi_sd_realize
> for partI series but but without use of ERRP_AUTO_PROPAGATE.
>=20
>   hw/sd/ssi-sd.c | 16 ++++++++++++++--
>   1 file changed, 14 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/sd/ssi-sd.c b/hw/sd/ssi-sd.c
> index 91db069212..829797b597 100644
> --- a/hw/sd/ssi-sd.c
> +++ b/hw/sd/ssi-sd.c
> @@ -255,13 +255,25 @@ static void ssi_sd_realize(SSISlave *d, Error **err=
p)
>       carddev =3D qdev_create(BUS(&s->sdbus), TYPE_SD_CARD);
>       if (dinfo) {
>           qdev_prop_set_drive(carddev, "drive", blk_by_legacy_dinfo(dinfo=
), &err);
> +        if (err) {
> +            goto fail;
> +        }
>       }
> +
>       object_property_set_bool(OBJECT(carddev), true, "spi", &err);
> +    if (err) {
> +        goto fail;
> +    }
> +
>       object_property_set_bool(OBJECT(carddev), true, "realized", &err);
>       if (err) {
> -        error_setg(errp, "failed to init SD card: %s", error_get_pretty(=
err));
> -        return;
> +        goto fail;
>       }
> +
> +    return;
> +
> +fail:
> +    error_propagate_prepend(errp, err, "failed to init SD card: ");
>   }
>  =20
>   static void ssi_sd_reset(DeviceState *dev)
>=20

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>


