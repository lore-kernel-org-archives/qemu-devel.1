Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9839C10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 17:06:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B44F42071C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 17:06:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X8LzMkT6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B44F42071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEc9V-0001ny-SD
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 13:06:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55637)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jEc85-0000bO-Sj
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 13:05:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jEc84-0003a7-Jk
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 13:05:17 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:32544)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jEc84-0003XA-FM
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 13:05:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584551115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yz6s7OGNS0gQr5dFC4tq6cQBkUuQsqMnzUOy8dyCtao=;
 b=X8LzMkT6JHMeXzi32tNciV5HmbfYlAEPEOWTWO02StvXxcvP+Vk+Kj7uN1tlxtbnTlhTM9
 9CBYly3wDBhgX0DEqyVIwGcIuDphDOfAw+HQasIEmQIx12cc8hPowuOlLD67jvnGOg1Lgc
 WFsXyOI9zdEcsuiCLNn5Oe4o8QeQWXY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-O7J0Ev_WOUWYkJPlrm7UxA-1; Wed, 18 Mar 2020 13:05:13 -0400
X-MC-Unique: O7J0Ev_WOUWYkJPlrm7UxA-1
Received: by mail-wm1-f69.google.com with SMTP id m4so1370114wmi.5
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2020 10:05:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FXEtm75uJowv1shWPJjciTkR89dWOBGDPaoW0Qe92Wg=;
 b=CIHT5kGdz/hZjm7m12ljDzOpeEBrw5W/JbIOucbftshY8ECvnVFXsTB1do1XkQzGMe
 9rsy65VwGQzZxQHDNdHI/LAmA2bfbUa/q0NqRRlE2ISWsgKOugQv0p7Uio9CfCXUzsaQ
 iUVFfr83zEebr2lB0HuBMn826L0Tp3C1/1jVK9gHJTnNAeJnyO4BvhvJTewRdFeY4EoX
 ubckMtpKS0+JoIMvep2/FOFp5HpPsOq8i799iSVGlTosxUgC9kk4OZReKX6xrRfjbmcM
 btfE4ohSN4xbpp+vxX+A63/PMmedf4cDERlAg2YZdGNjcwco7HRQcDRGlf4+4M3mwkjq
 SjAQ==
X-Gm-Message-State: ANhLgQ0WgOdzzaxeZG2MeVyFOf7JSaeNgaWDMlpAtBHaSe2Gs7Kh9TZ0
 gx7w2UN6W17CVYI0e7kLfL98DSOXV6Zm95bFLjav3kkO1g5dr/9v7obAoY8qDlz0Y3VZXZ636LU
 mPfNAJlzVIVNbB6g=
X-Received: by 2002:adf:fc8c:: with SMTP id g12mr6846003wrr.277.1584551112493; 
 Wed, 18 Mar 2020 10:05:12 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtGeRquTFXJVqJjjh3S07KP2PynRJnjCKm3QPGFxhynTx8kwTBg+V5x2hhCUfVdervLkr4TTw==
X-Received: by 2002:adf:fc8c:: with SMTP id g12mr6845982wrr.277.1584551112274; 
 Wed, 18 Mar 2020 10:05:12 -0700 (PDT)
Received: from [192.168.1.34] (96.red-83-59-163.dynamicip.rima-tde.net.
 [83.59.163.96])
 by smtp.gmail.com with ESMTPSA id o133sm2360650wme.35.2020.03.18.10.05.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Mar 2020 10:05:11 -0700 (PDT)
Subject: Re: [PATCH for-5.0] compat: disable edid on correct virtio-gpu device
To: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
References: <20200318093919.24942-1-cohuck@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d2cf4311-5f67-db16-5719-03bf770889f1@redhat.com>
Date: Wed, 18 Mar 2020 18:05:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200318093919.24942-1-cohuck@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/18/20 10:39 AM, Cornelia Huck wrote:
> Commit bb15791166c1 ("compat: disable edid on virtio-gpu base
> device") tried to disable 'edid' on the virtio-gpu base device.
> However, that device is not 'virtio-gpu', but 'virtio-gpu-device'.
> Fix it.
>=20
> Fixes: bb15791166c1 ("compat: disable edid on virtio-gpu base device")
> Reported-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
> Tested-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>=20
> Sorry about my testing failure on the original patch, and thanks
> to Luk=C3=A1=C5=A1 for finding this.
>=20
> ---
>   hw/core/machine.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 9e8c06036faf..fa9f50db186e 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -53,7 +53,7 @@ GlobalProperty hw_compat_4_0[] =3D {
>       { "secondary-vga",  "edid", "false" },
>       { "bochs-display",  "edid", "false" },
>       { "virtio-vga",     "edid", "false" },
> -    { "virtio-gpu",     "edid", "false" },
> +    { "virtio-gpu-device", "edid", "false" },
>       { "virtio-device", "use-started", "false" },
>       { "virtio-balloon-device", "qemu-4-0-config-size", "true" },
>       { "pl031", "migrate-tick-offset", "false" },
>=20


