Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45EF6C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 10:23:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FDC3218AC
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 10:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D+C9O2Mz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FDC3218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihWUk-0006ii-6n
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 05:23:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39052)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ihWTt-0005ln-P0
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 05:23:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ihWTr-0007FC-QO
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 05:23:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44378
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ihWTr-0007AO-MY
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 05:22:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576664578;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cXxkLuAPk7h/79LrlTPz3Lq+iVKhj6zC9LVXFOliBfA=;
 b=D+C9O2MzWffDL5VF1sNg5rDj5D8wNKPaDjskexEcF9Fp9kTxypEkT9JwiZ0lWqI1osaZ5Q
 tix2ZyfdgkNqmLqHtVbPZ9514Qw7g5QfW25KEIjjkSsMWzS9UkhIsFOIlK6v/DaTONcm6g
 mdVtfOZfMY4tAyPAmS9NLjWogbtCS10=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-LHh2GVCfNgOyotT7-rEA0Q-1; Wed, 18 Dec 2019 05:22:56 -0500
Received: by mail-wm1-f70.google.com with SMTP id b131so288657wmd.9
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 02:22:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=21mfIMHBAT7U6xxsVx3L46a3fn7/m2C1a/m77gUaPpk=;
 b=dxGkZvUV3JitU7CZxN1XfMJGu5LIeOtmDK1SXUCzyo02EzCvNvex0TRRTlzqgZFRn7
 BN+H7E3OcBqRddzRwBm/4dpeLjKVIp5jzZhJOT104LkWqrW9FHb7c+i6IQURCXyPF2c3
 Wko/p6o/vFdhDlkbcxsl4eX/dSWyK/8SYwAT6LV/OVPuN8qBWfGB2qJoGSnwG30+vHNV
 QadqW/sXZ2RLaFQGK44PnW5wT+5A9RJ56GbKYNhGVjvFvJNLAtT70h1F22GiFpQJx/h6
 ZJZY9ToKTWr8mjZVhNSVfofnskuS5wcgjYJLhHKr6fP57ymjl99GHJBKIBolA3SOd7ZB
 VbNQ==
X-Gm-Message-State: APjAAAVdmRCvhl0HIB84rR+Xmhcn3ARl91ngZLFfmfsQYW4PK+4UPnXl
 rjs6d/dwrsYIS8qnMo2VoR7sONPEB2I8Uy2uf4iNL4ScBV/5mKTWPDSV/thHEq9DBGNO2vEk0oS
 uju/tqZd/CWM5Ir8=
X-Received: by 2002:a1c:3803:: with SMTP id f3mr2415950wma.134.1576664575960; 
 Wed, 18 Dec 2019 02:22:55 -0800 (PST)
X-Google-Smtp-Source: APXvYqw5LGGsrumjmrTsb6970lo+QTIsUtkse8oTu9qkw7HKModLQtxZa1oH9bX7NIL2JVlKY9kE/A==
X-Received: by 2002:a1c:3803:: with SMTP id f3mr2415911wma.134.1576664575563; 
 Wed, 18 Dec 2019 02:22:55 -0800 (PST)
Received: from [192.168.23.166] (40.red-88-21-19.staticip.rima-tde.net.
 [88.21.19.40])
 by smtp.gmail.com with ESMTPSA id m3sm2049924wrs.53.2019.12.18.02.22.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2019 02:22:55 -0800 (PST)
Subject: Re: [PATCH 1/6] audio/audio: Add missing fall through comment
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <20191217173425.5082-1-philmd@redhat.com>
 <20191217173425.5082-2-philmd@redhat.com>
 <CAL1e-=gP7TqZ1VDR1dTGMqHYwAxEJYPHdEZ0XQr4L=g=uLFMcA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b0346891-73ff-0691-e83d-b39c5e45dc04@redhat.com>
Date: Wed, 18 Dec 2019 11:22:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAL1e-=gP7TqZ1VDR1dTGMqHYwAxEJYPHdEZ0XQr4L=g=uLFMcA@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: LHh2GVCfNgOyotT7-rEA0Q-1
X-Mimecast-Spam-Score: 0
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
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 =?UTF-8?B?S8WRdsOhZ8OzLCBab2x0w6Fu?= <dirty.ice.hu@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/18/19 9:02 AM, Aleksandar Markovic wrote:
>=20
>=20
> On Tuesday, December 17, 2019, Philippe Mathieu-Daud=C3=A9 <philmd@redhat=
.com=20
> <mailto:philmd@redhat.com>> wrote:
>=20
>     GCC9 is confused by this comment when building with
>     CFLAG -Wimplicit-fallthrough=3D2:
>=20
>=20
> Gcc is not confused whatsoever.

It is right! I'll update the description :)

>=20
>      =C2=A0 audio/audio.c: In function =E2=80=98audio_pcm_init_info=E2=80=
=99:
>      =C2=A0 audio/audio.c:306:14: error: this statement may fall through
>     [-Werror=3Dimplicit-fallthrough=3D]
>      =C2=A0 =C2=A0 306 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sign =3D 1;
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0~~~~~=
^~~
>      =C2=A0 audio/audio.c:307:5: note: here
>      =C2=A0 =C2=A0 307 |=C2=A0 =C2=A0 =C2=A0case AUDIO_FORMAT_U8:
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0^~~~
>      =C2=A0 cc1: all warnings being treated as errors
>=20
>     Add the missing fall through comment, similarly to e46349414.
>=20
>     Fixes: 2b9cce8c8c
>     Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com
>     <mailto:philmd@redhat.com>>
>     ---
>     Cc: Gerd Hoffmann <kraxel@redhat.com <mailto:kraxel@redhat.com>>
>     Cc: "K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n" <dirty.ice.hu@gmail.com
>     <mailto:dirty.ice.hu@gmail.com>>
>     ---
>      =C2=A0audio/audio.c | 1 +
>      =C2=A01 file changed, 1 insertion(+)
>=20
>     diff --git a/audio/audio.c b/audio/audio.c
>     index 56fae55047..57daf3f620 100644
>     --- a/audio/audio.c
>     +++ b/audio/audio.c
>     @@ -304,6 +304,7 @@ void audio_pcm_init_info (struct audio_pcm_info
>     *info, struct audsettings *as)
>      =C2=A0 =C2=A0 =C2=A0switch (as->fmt) {
>      =C2=A0 =C2=A0 =C2=A0case AUDIO_FORMAT_S8:
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sign =3D 1;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* fall through */
>      =C2=A0 =C2=A0 =C2=A0case AUDIO_FORMAT_U8:
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mul =3D 1;
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;
>     --=20
>     2.21.0
>=20
>=20


