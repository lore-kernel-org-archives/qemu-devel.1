Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9CFEC2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 22:14:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4D8B20702
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 22:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dXH1MRRm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4D8B20702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwvbi-00005u-TT
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 17:14:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46142)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iwvb8-0007xm-Q0
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 17:14:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iwvb7-0004Rm-Cc
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 17:14:10 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55517
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iwvb7-0004Pf-9Y
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 17:14:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580336048;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Orkb16fzFt+j8LRSI2l+x3fXuu8vaiTa5Sl14qGMEAU=;
 b=dXH1MRRmcEgqHXySwlXagtxEPp6VAOlidyGNiFb95gmiY962ycayP/Hsw0l061lYnVsVhA
 zkZZzlH2LIBfrxgACmU8F2AS9wppAaXqvvFDkJMLgrG7dI7eb/p3s2wzNNRC2dbeNbzztS
 zN9QVNlISi/XCDfJwNZfaeC7Jo1uizc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-94-XfYNuScDNKuVRmPoMZL3WA-1; Wed, 29 Jan 2020 17:14:06 -0500
Received: by mail-wr1-f69.google.com with SMTP id y7so689048wrm.3
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 14:14:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=V95vDayRoYJudj08dD6qnS3E+E6e/23z05vYjRc/ESY=;
 b=XWOTnJoMLWe0+87DfIJ2y5jabkPNT9oJWakREbov8ZJvcG4GA17lsY7ELeUD9OX2+J
 mD0TYkOwpyGZgOBrpE5ZO2lPoMgw+JlWvBpjvLG5NUU+I/D8hKT2/nHtWgAoj2V+XgJ9
 qB57HG02V2cRb0l56Nj8zTFXfkZtcfngylwgJn63VaNVVzDOsQ9bGByLJj69fUIfZwlc
 U8NyOxgVHPnPNrVN7VMREBAFGk1zCytxwuXAheOilYmCZI1YqapzHH0Sy0WwzHj1xRdX
 dvwaahZgLn6ygnQDNelsqydlkaoDi8svjEaEMjJO878URdqi/9VqnDPSo/zvmh4Aeh5O
 BC0Q==
X-Gm-Message-State: APjAAAUAT7CcrmABSN2lyY6y9irL32+29bVGDF7A6DIWfH3w+NDpxCMN
 A1gv0n4ejrRbDnsm2s7zExmsOmGHn/wVdkjuqq25DTOTqe5kZpQHEdIPYltD6ECKXKHPFC3I2Ag
 0UOEMMLkPu1FWWU8=
X-Received: by 2002:a05:600c:cd:: with SMTP id
 u13mr1333183wmm.24.1580336041903; 
 Wed, 29 Jan 2020 14:14:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqwwu454lGtIW+yLCvB9ZtcoMDdALZU13ybLWplCL68F56CgpKffFI4zKOsx07IUmwY7C2LMrw==
X-Received: by 2002:a05:600c:cd:: with SMTP id
 u13mr1333157wmm.24.1580336041562; 
 Wed, 29 Jan 2020 14:14:01 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id a6sm4668650wrm.69.2020.01.29.14.14.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jan 2020 14:14:00 -0800 (PST)
Subject: Re: [PATCH] qemu-deprecated: Remove text about Python 2
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Thomas Huth <thuth@redhat.com>
References: <20200109095116.18201-1-thuth@redhat.com>
 <CAL1e-=jnAMtpNNHO1rqG-63K_5uM-QfVYoMcj0NZeHwKCWG4uQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <af4485d4-1706-c464-2320-dff3b5f29fd7@redhat.com>
Date: Wed, 29 Jan 2020 23:13:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAL1e-=jnAMtpNNHO1rqG-63K_5uM-QfVYoMcj0NZeHwKCWG4uQ@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: XfYNuScDNKuVRmPoMZL3WA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 John Snow <jsnow@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Aleksandar,

On 1/9/20 1:49 PM, Aleksandar Markovic wrote:
>=20
>=20
> On Thursday, January 9, 2020, Thomas Huth <thuth@redhat.com=20
> <mailto:thuth@redhat.com>> wrote:
>=20
>     Python 2 support has been removed, so we should now also remove
>     the announcement text for the deprecation.
>=20
>     Signed-off-by: Thomas Huth <thuth@redhat.com <mailto:thuth@redhat.com=
>>
>     ---
>      =C2=A0qemu-deprecated.texi | 8 --------
>      =C2=A01 file changed, 8 deletions(-)
>=20
>=20
> Reviewed by: Aleksandar Markovic <amarkovic@wavecomp.com=20
> <mailto:amarkovic@wavecomp.com>>

I use pwclient to collect patchwork patches, this one is:
https://patchwork.kernel.org/patch/11325373/
Your comment is listed, but your tag is ignored... I am not sure why.

John used:
Content-Transfer-Encoding: 7bit

You:
Content-Transfer-Encoding: quoted-printable

This might be why? I have no clue.

>=20
>     diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
>     index 7033e531de..8b23e98474 100644
>     --- a/qemu-deprecated.texi
>     +++ b/qemu-deprecated.texi
>     @@ -341,14 +341,6 @@ they have no effect when used with @option{-n}
>     to skip image creation.
>      =C2=A0Silently ignored options can be confusing, so this combination=
 of
>      =C2=A0options will be made an error in future versions.
>=20
>     -@section Build system
>     -
>     -@subsection Python 2 support (since 4.1.0)
>     -
>     -In the future, QEMU will require Python 3 to be available at
>     -build time.=C2=A0 Support for Python 2 in scripts shipped with QEMU
>     -is deprecated.
>     -
>      =C2=A0@section Backwards compatibility
>=20
>      =C2=A0@subsection Runnability guarantee of CPU models (since 4.1.0)
>     --=20
>     2.18.1
>=20
>=20


