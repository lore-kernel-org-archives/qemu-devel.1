Return-Path: <SRS0=VgCP=2F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E34B1C43603
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2019 05:57:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A59EB21D7E
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2019 05:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fDZvI5sn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A59EB21D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igMuU-0006HT-R4
	for qemu-devel@archiver.kernel.org; Sun, 15 Dec 2019 00:57:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46551)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1igMtn-0005qK-88
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 00:57:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1igMtm-0002Q9-5i
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 00:56:59 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50283
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1igMtm-0002PV-21
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 00:56:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576389417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xlLVVKkDNPwTlTzTUsJIeVKkOglUqTl2iVNln7ThTVQ=;
 b=fDZvI5snOsw5LiNcJCOZRlxfG/wAp9DMrgjC/8Z9ENBNYIzejmdygTbyFYQojRNEeWoXjq
 SEPbB4Ue5XiBmKq1pcr4WnC8rcfHVUd5DD6W1xnXheZ0WrVU8E/n2+YjLXQCUk/Bg12vKm
 G+2mfFV3i3MwVq3h3+pWurUynwyyQMw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-EJTbpx5lO-iu7tyCbwVb3g-1; Sun, 15 Dec 2019 00:56:55 -0500
Received: by mail-wr1-f71.google.com with SMTP id c17so1822173wrp.10
 for <qemu-devel@nongnu.org>; Sat, 14 Dec 2019 21:56:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cFLzqQWsRW+oV3nKAzwJi/+4nGszpVC2JF1L5JQ8VAg=;
 b=mEDnE/7sJABtIprC8cng8W1ruxqTTsQLeZu76yD2VSU3pqE2jJYP02E54hGLxqdPBy
 ubU43nVb3dcX/kmJDSHofBJnGqQc0C8fs/atp62dbWrnj3fpzTs5cHwlEm2PsuaTvE0U
 IzDfSOHpgb2TIx9hv5eQa0s/JZspjRYWbQrbdHaZtd6hEu+w+7eFDZvJFzrKz1zmQhGd
 Jk434QqVuNOUB6NUAxSiuum6mjq47oiixCqGlFH7VryO1XWtAMkCQnMtGi27Mi9bmkI4
 1KwWj+whEb01uk0yuhUfTiLbGQIxaXLsfwaWcg9L8ndDB82yKaaEifyb9F8O1UTzBNXw
 h05A==
X-Gm-Message-State: APjAAAU7xo5bgIJor5FrartFVAYPhmWM3bhG1iYVLBPoFNlaZWeT0MGm
 Cmc965LEE+ZvH9rxrn2DDQJhAZO8fxY/AKVC7ePctCIow5J23BwrKCz21eNXjFoNE7AsCOwxtu9
 rt8GQJYIjZN5Y1/U=
X-Received: by 2002:a1c:dcd5:: with SMTP id t204mr24530810wmg.34.1576389414594; 
 Sat, 14 Dec 2019 21:56:54 -0800 (PST)
X-Google-Smtp-Source: APXvYqweKY9bm5kINDPCDrzKEY6ZsO8DfxejIiK4BqOQs3cIyX7pjVZnQv6DvtqvfSfH57TVFCkJ4g==
X-Received: by 2002:a1c:dcd5:: with SMTP id t204mr24530788wmg.34.1576389414287; 
 Sat, 14 Dec 2019 21:56:54 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id f12sm16746150wmf.28.2019.12.14.21.56.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Dec 2019 21:56:53 -0800 (PST)
Subject: Re: [PATCH v4 29/37] RFC: mips/cps: fix setting saar property
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20191120152442.26657-1-marcandre.lureau@redhat.com>
 <20191120152442.26657-30-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <41a2531e-b887-6f72-fd51-a7e1d5688670@redhat.com>
Date: Sun, 15 Dec 2019 06:56:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191120152442.26657-30-marcandre.lureau@redhat.com>
Content-Language: en-US
X-MC-Unique: EJTbpx5lO-iu7tyCbwVb3g-1
X-Mimecast-Spam-Score: 0
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
Cc: peter.maydell@linaro.org, Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/20/19 4:24 PM, Marc-Andr=C3=A9 Lureau wrote:
> There is no "saar" property. Note: I haven't been able to test this
> code. Help welcome.
>=20
> May fix commit 043715d1e0fbb3e3411be3f898c5b77b7f90327a ("target/mips:
> Update ITU to utilize SAARI and SAAR CP0 registers")
>=20
> Cc: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/mips/cps.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/mips/cps.c b/hw/mips/cps.c
> index 1660f86908..c49868d5da 100644
> --- a/hw/mips/cps.c
> +++ b/hw/mips/cps.c
> @@ -106,7 +106,7 @@ static void mips_cps_realize(DeviceState *dev, Error =
**errp)
>           object_property_set_bool(OBJECT(&s->itu), saar_present, "saar-p=
resent",
>                                    &err);
>           if (saar_present) {
> -            qdev_prop_set_ptr(DEVICE(&s->itu), "saar", (void *)&env->CP0=
_SAAR);
> +            s->itu.saar =3D &env->CP0_SAAR;

Hmmm this could be what the author of 043715d1e wanted to do indeed.

Since this feature is incomplete (see comments in previous versions of=20
this series:
   $ git grep saarp
   hw/mips/cps.c:98:    saar_present =3D (bool)env->saarp;
   target/mips/cpu.h:1103:    int saarp;
and I don't know how to test this, I'll defer to Aleksandar regarding=20
this patch.

>           }
>           object_property_set_bool(OBJECT(&s->itu), true, "realized", &er=
r);
>           if (err !=3D NULL) {
>=20


