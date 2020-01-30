Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B26C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 22:18:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A4812082E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 22:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OS7V1ZCi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A4812082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixI8P-0007DX-LN
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 17:18:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43360)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ixI7B-0006LT-Kd
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 17:16:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ixI7A-00083o-H3
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 17:16:45 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56546
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ixI7A-00081i-DP
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 17:16:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580422603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0VYp8Vwrnws+BCkjgdtPHL+9TaFuNbHiVruCnfLGOk8=;
 b=OS7V1ZCi8XlEhii/kjvIDFgt8X/SanvcbUY5OsvJokjO/6EtOkQy+viFwlcrTIGOvASTHu
 sMJVzRzqciA1I7/Fu8D+RL2lpfKWbRsXlaDaohagj7+YAxhMdk6CobLdTZipzFfkskKPH3
 dhJVC+izLbJOcpQLAIkIkHF0Wg1Eks0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-06pA6NPRPemCxlF4IjBuBw-1; Thu, 30 Jan 2020 17:16:33 -0500
Received: by mail-wr1-f72.google.com with SMTP id w6so2345833wrm.16
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 14:16:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=aH7bLoi5Ya3LW8Bh8gNO2GEkMHuhNUBJ0pX3+B82MMY=;
 b=eJkJgXQdyEoK2kQ/i+Ox+JUMjtjYgGyPhrV0WH1tYQj7a+PnVGDmgultxFB8JQZetb
 ye1j/RWcP9lmwAH2QFbY2x0gNnQKGL9I+GG5bx/yrOXCNYyuRA1K+z5nhfXFtHDtNkfR
 c1snQBYqufMObAyawedak/TpaB+GdhdNaUOqYltwaUd0gtHbQ5UiMbSXjAmG78ZtVlR3
 KMkaHYevfMC25NIdDKxFUQPm8qOh9cZ33kenA9KoeA0ghuXcUVYsy3opTdY3Eu5hYQ0L
 n22mWSCfSFoPbOQ55FD2L5emdmamjWgA0o3dsLrjqGeFdBWmxQKW4rz8Wbwkw0qXy9vQ
 Ujqg==
X-Gm-Message-State: APjAAAUx3NYFf0x9eH6vZAHUgXkmMST6a5PCfXwPjnorYgkJKiIyyk1i
 CDhilH0+3vRDOqclEytyTDBXG8QaM5mfF/Z230edgfOy2xbAO0yKj+cQjdVVTidVCGqwua5jZf0
 8qwAQixARWM8Xc5o=
X-Received: by 2002:a5d:56ca:: with SMTP id m10mr8122107wrw.313.1580422592293; 
 Thu, 30 Jan 2020 14:16:32 -0800 (PST)
X-Google-Smtp-Source: APXvYqz95jB9ML5t8xhs3TbUl4JcJSv/fTcWY7fwHh2pImc+wP4Nmb+yq7OMzKSJU644Ejo6o3MgKw==
X-Received: by 2002:a5d:56ca:: with SMTP id m10mr8122091wrw.313.1580422592043; 
 Thu, 30 Jan 2020 14:16:32 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id a5sm8122747wmb.37.2020.01.30.14.16.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jan 2020 14:16:31 -0800 (PST)
Subject: Re: [PATCH] python: Treat None-return of greeting cmd
To: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>,
 qemu-devel@nongnu.org
References: <20200120071202.30646-1-ldoktor@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a9c347a1-6ee5-af0c-c1e5-6b5883fbd787@redhat.com>
Date: Thu, 30 Jan 2020 23:16:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200120071202.30646-1-ldoktor@redhat.com>
Content-Language: en-US
X-MC-Unique: 06pA6NPRPemCxlF4IjBuBw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: ehabkost@redhat.com, crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/20/20 8:12 AM, Luk=C3=A1=C5=A1 Doktor wrote:
> In case qemu process dies the "monitor.cmd" returns None which gets
> passed to the "__negotiate_capabilities" and leads to unhandled
> exception. Let's only check the resp in case it has a value.
>=20
> Signed-off-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
> ---
>   python/qemu/qmp.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/python/qemu/qmp.py b/python/qemu/qmp.py
> index 5c8cf6a056..a3e5de718a 100644
> --- a/python/qemu/qmp.py
> +++ b/python/qemu/qmp.py
> @@ -73,7 +73,7 @@ class QEMUMonitorProtocol(object):
>               raise QMPConnectError
>           # Greeting seems ok, negotiate capabilities
>           resp =3D self.cmd('qmp_capabilities')
> -        if "return" in resp:
> +        if resp and "return" in resp:
>               return greeting
>           raise QMPCapabilitiesError
>  =20
>=20

Thanks, applied to my python-next tree:
https://gitlab.com/philmd/qemu/commits/python-next


