Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3891C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 15:31:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6ECFF24659
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 15:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="asZL5Pbj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ECFF24659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idFZs-0000VY-FS
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 10:31:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50097)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1idElY-000128-W3
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:39:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1idElX-00024X-OS
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:39:32 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57424
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1idElV-00021y-Nd
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:39:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575643168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RP69OtuzYxTSyKvLcp5UASF1sVXDxIDngl0oaVjgERM=;
 b=asZL5PbjDW0SZslztGUy9YpddE06m8CjUrUZPbtUz68HrAwfYJPllbr3EZYiZ7v+k2Y4wR
 VeO0sgS64s1ZtNegt3qcez5GJbXiRebCxsUcV+giISPOw/cYu4iBjixt2ZjjY0Jwo8tymJ
 vtXhn3vN2TpWPd5pVk2t4kM8XNB+tyM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-gkZ2usC4Mey-k5YaKc1zBw-1; Fri, 06 Dec 2019 02:38:20 -0500
Received: by mail-wr1-f70.google.com with SMTP id b13so2751266wrx.22
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2019 23:38:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=x9rYdaFvRdcdkefM/bT1+floIfl942+giQ8adjauipM=;
 b=bHjdg5uE3mBwFtJaHqbbUr1q8QHGt58sk9vNkYHIvVqatOxkJMgNl4drbnCy5880db
 EiW+9cWFjBIe2ufTklE7Ed3TD8+H69+ixedYJg+GvUC9Pds/uMq6QtydoqzB01g/rvXM
 cH6Mhp2pJoWzmKMQXoyD2DnpE8D/QqIP2xB1aE/HD0aNtvAwdFE5YqNZ4OPbdBsVhbk5
 4onkaRCpcTduwq5kqUQfHe0Q59RqxflN67pX8ZQEnhQJVQhpeXnX+dztYYC2lA2Lqmb1
 lm/nnBeDHnI2T2zQJ1UH5fkfRV2ziH8YeZv41EKN6sM7hgAu0vX3QFj+3FAFR66+peMT
 n6Qw==
X-Gm-Message-State: APjAAAXG+dTG3KKitrAhRb96JPzVoDzfbBabeW74An4slQzENojUusSB
 yIl584KDmHQAp5zVv/2Z6SVbIP5oW7GUS/Y6zlJvIjyP5KlbeakZYMmh3i2fXeAS8z220p51Tlu
 EYVRIcMxhg4gJMZY=
X-Received: by 2002:a5d:66c3:: with SMTP id k3mr13331634wrw.370.1575617899434; 
 Thu, 05 Dec 2019 23:38:19 -0800 (PST)
X-Google-Smtp-Source: APXvYqxpsmHrzuEgm/iquYRWnPg6uGchmKgsGUlYDpiBaE6LUoajbfVZ8fbSWRCl9hAMAPj3ZFoNGw==
X-Received: by 2002:a5d:66c3:: with SMTP id k3mr13331614wrw.370.1575617899220; 
 Thu, 05 Dec 2019 23:38:19 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id h127sm2587482wme.31.2019.12.05.23.38.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Dec 2019 23:38:18 -0800 (PST)
Subject: Re: [PATCH v8 16/21] hw/tpm: rename Error ** parameter to more common
 errp
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20191205174635.18758-1-vsementsov@virtuozzo.com>
 <20191205174635.18758-17-vsementsov@virtuozzo.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9fa5e6be-b5d1-6d14-ccdd-a4c592bf64b1@redhat.com>
Date: Fri, 6 Dec 2019 08:38:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191205174635.18758-17-vsementsov@virtuozzo.com>
Content-Language: en-US
X-MC-Unique: gkZ2usC4Mey-k5YaKc1zBw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
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
Cc: armbru@redhat.com, Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/5/19 6:46 PM, Vladimir Sementsov-Ogievskiy wrote:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

> ---
>   hw/tpm/tpm_emulator.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
> index 22f9113432..10d587ed40 100644
> --- a/hw/tpm/tpm_emulator.c
> +++ b/hw/tpm/tpm_emulator.c
> @@ -155,7 +155,7 @@ static int tpm_emulator_unix_tx_bufs(TPMEmulator *tpm=
_emu,
>                                        const uint8_t *in, uint32_t in_len=
,
>                                        uint8_t *out, uint32_t out_len,
>                                        bool *selftest_done,
> -                                     Error **err)
> +                                     Error **errp)
>   {
>       ssize_t ret;
>       bool is_selftest =3D false;
> @@ -165,20 +165,20 @@ static int tpm_emulator_unix_tx_bufs(TPMEmulator *t=
pm_emu,
>           is_selftest =3D tpm_util_is_selftest(in, in_len);
>       }
>  =20
> -    ret =3D qio_channel_write_all(tpm_emu->data_ioc, (char *)in, in_len,=
 err);
> +    ret =3D qio_channel_write_all(tpm_emu->data_ioc, (char *)in, in_len,=
 errp);
>       if (ret !=3D 0) {
>           return -1;
>       }
>  =20
>       ret =3D qio_channel_read_all(tpm_emu->data_ioc, (char *)out,
> -              sizeof(struct tpm_resp_hdr), err);
> +              sizeof(struct tpm_resp_hdr), errp);
>       if (ret !=3D 0) {
>           return -1;
>       }
>  =20
>       ret =3D qio_channel_read_all(tpm_emu->data_ioc,
>                 (char *)out + sizeof(struct tpm_resp_hdr),
> -              tpm_cmd_get_size(out) - sizeof(struct tpm_resp_hdr), err);
> +              tpm_cmd_get_size(out) - sizeof(struct tpm_resp_hdr), errp)=
;
>       if (ret !=3D 0) {
>           return -1;
>       }
>=20


