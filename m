Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C13BC43215
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 21:25:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C46C20715
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 21:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ffblgbnj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C46C20715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVMcD-0005tp-8B
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 16:25:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47872)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iVMao-00051J-Tv
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 16:23:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iVMal-0001Dq-K4
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 16:23:52 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52383
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iVMal-0001DD-Fv
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 16:23:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573766630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0eHq0mz4mC866HwNq98KkGr4PEGPxv48Ee9tDYk4AWY=;
 b=ffblgbnjq2r/wUa6er+r4kSrEIkjp0+fAyS71U7RTc1k9Hfm3iUYZxOkPs40046M0lTQ2U
 6e6c1WeAv1EwIAtxPSL9xSWOgabIeNrGP2aa8Z3YwX53H7y8ZUcEQsMvSzMT1ly3VzSuk5
 boAzjBnglSQOTIQA9E1PvByi9CsNnDY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-LhGSZQvAN_el08-gJJ8jHw-1; Thu, 14 Nov 2019 16:23:46 -0500
Received: by mail-wm1-f69.google.com with SMTP id l184so5036927wmf.6
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2019 13:23:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bqtmwZd47Ou10AgipkGQ2+PY/FRsQ/Hq0sL9a94Udlc=;
 b=nsl9Iy3QawJizlnap7dsgajbgH5AqtfZhcDZEcUshNI5ZI4fHcTkGzkXc59VS5eW2x
 HwTCToQPH8DXOvlQ9+WhlJlOlZqyMiJ4wFJgHX3e28qmPEk7xrFIXEpAfIW6PFvOcLx8
 8DUqoEb3O3JIDswbvabOhtuVRi+LUonZ0YkRLjPGu3zd5efRR/BCw43SqiYmlsdqQIXr
 vJpcnI5Ec1Ic0/cok5PVwTVaJD0bZNio5EOyT9bgKBG174kPlypvTqeRN0vaV2zlwYVv
 KS4iRgChHP39BOKZxZ3XvGLJHgAtSODiRMaS1vX1+mx6i+5ov8qOu3URbXv73K+Njf6K
 oboQ==
X-Gm-Message-State: APjAAAX5VShCxb9McwkE849MrBTbsPriXEoouSPEjc2RTLoMat6BHImA
 9vQoQE3nKmd38O5acWZxu5NBlwOusQwPYPV41jFBBRpkIvYDzAN5pDkEi6mQOh6kUjB/dHNzUQh
 xlB8JgtDmYkg1z1c=
X-Received: by 2002:a05:600c:3cf:: with SMTP id
 z15mr10551746wmd.76.1573766625758; 
 Thu, 14 Nov 2019 13:23:45 -0800 (PST)
X-Google-Smtp-Source: APXvYqxDvWVEmJeGVq+TntCm/Sn6vYZhFjQKlhCjpcpf6aGjwJQzy9VBc9IwfBph7fFMonSg5DHVfw==
X-Received: by 2002:a05:600c:3cf:: with SMTP id
 z15mr10551709wmd.76.1573766625501; 
 Thu, 14 Nov 2019 13:23:45 -0800 (PST)
Received: from [192.168.1.35] (170.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.170])
 by smtp.gmail.com with ESMTPSA id p14sm8947400wrq.72.2019.11.14.13.23.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2019 13:23:44 -0800 (PST)
Subject: Re: [PATCH v2 3/5] MAINTAINERS: Adjust maintainership for Malta board
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 qemu-devel@nongnu.org, Paul Burton <pburton@wavecomp.com>
References: <1573652826-23987-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1573652826-23987-4-git-send-email-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b2bdb632-7f17-85e5-5c8c-079316fe38bd@redhat.com>
Date: Thu, 14 Nov 2019 22:23:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1573652826-23987-4-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
X-MC-Unique: LhGSZQvAN_el08-gJJ8jHw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: peter.maydell@linaro.org, aleksandar.rikalo@rt-rk.com, hpoussin@reactos.org,
 amarkovic@wavecomp.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+Paul Burton

On 11/13/19 2:47 PM, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>=20
> Change the maintainership for Malta board to improve its quality.
>=20
> Acked-by: Aurelien Jarno <aurelien@aurel32.net>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>   MAINTAINERS | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3bf2144..6afec32 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -955,8 +955,9 @@ F: hw/display/jazz_led.c
>   F: hw/dma/rc4030.c
>  =20
>   Malta
> -M: Aurelien Jarno <aurelien@aurel32.net>
 > +R: Aurelien Jarno <aurelien@aurel32.net>

Aurelien, do you want to stay co-maintainer with this one?
Else, thanks for staying listed as designated reviewer :)

> -R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
> +M: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

I'm happy to continue Aurelien work with this board :)
Similarly to the Fuloong board, I mostly use the Malta as a hobby, so=20
I'll use my personal email.

Paul, do you mind being co-maintainer or at least listed as designated=20
reviewer here?

> +R: Herv=C3=A9 Poussineau <hpoussin@reactos.org>

I don't see commits from Herv=C3=A9 with this board, so he is probably not=
=20
interested.

>   S: Maintained

Until Paul is interested in co-maintenance, let's change this board=20
status to 'Odd Fixes'.

>   F: hw/mips/mips_malta.c
>   F: hw/mips/gt64xxx_pci.c


