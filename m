Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D5C2C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 16:35:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3369520692
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 16:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ox06IR1i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3369520692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXpQs-0003Ph-6n
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 11:35:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60676)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iXpPY-0002rl-Hq
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 11:34:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iXpPW-0003MM-LF
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 11:34:27 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41836
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iXpPW-0003M6-Hs
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 11:34:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574354065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N+ziACe92S7Dz27GKtoh+aKNMOQv49VtWVAUKXA0tlU=;
 b=Ox06IR1ipdZAUKoSUbyp1oGZYkc2qWPBECm8E711qsiurrsq2a9IHn3tu+SBOzBQlwck5s
 h26KUshWQtzUchotnbUxfxL4l0M1QfDU5BQaHGJPdzKxW2XVW14bLY6My/tGOzVZU8qDmJ
 4fE1ObfU+ON07LBk3QE5IEoo94GoxDA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-2t9yfV_DNqmiplIpJ11T1g-1; Thu, 21 Nov 2019 11:34:24 -0500
Received: by mail-wm1-f69.google.com with SMTP id g13so4410540wme.0
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 08:34:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7UBG/fF0d2aaQQK5Nor+C1oyiW6gVKvtprtAflswiK8=;
 b=jURRzbL9RMKBFvGxKqhFpLGZKc0S7jNyE6XzN2s+7ipYkQ/SIvWgPLD17PutaNH8SJ
 aC63WSbkYIl0k65C85qfQMSB3iNSDAwHv2NAqrybm36yOZ+OyOKXY2DmBPCtvohJ9yzf
 Wrfmg6TNGYVO5EDNahdUU4/rBkUuitRiqsF6mtKEXRQzit+tK+p73OqGcwxffYqK3wXj
 U3Ft433tS6xHkwj9vyyiJomWAckvJwfijpO1JIzF2NTvBmP1VwkC+a0C31ojV9Q7G/g+
 RSXO+n8+3cM9tr+Vxp9RzLge91w2Bi5QgInGgOnMRUhaUfjmFpFNgyn4P5dAp4av1SEE
 GhCQ==
X-Gm-Message-State: APjAAAW6knw/ikkFr//dA5q6xyLTJgizJOwTQktUr4OllBM/XC7PI6uT
 fcrtGheckm9E7WhoJx5AKQwoCnicA0z1iJ8Qbc3pFUesNphXxa7T+K96r6W+LqVaZpi/BaRAenV
 tnzSG16+V0TbPGJ4=
X-Received: by 2002:a5d:4b08:: with SMTP id v8mr11207265wrq.338.1574354063098; 
 Thu, 21 Nov 2019 08:34:23 -0800 (PST)
X-Google-Smtp-Source: APXvYqyBjOFbN6bSsbmJ8SlKqCHz+P5ejw9KX1EU8TWYuohUPpRvyfRdamMTpkxbCbBZYeuztu7VlA==
X-Received: by 2002:a5d:4b08:: with SMTP id v8mr11207245wrq.338.1574354062932; 
 Thu, 21 Nov 2019 08:34:22 -0800 (PST)
Received: from [192.168.1.35] (131.red-88-21-102.staticip.rima-tde.net.
 [88.21.102.131])
 by smtp.gmail.com with ESMTPSA id s9sm158855wmj.22.2019.11.21.08.34.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Nov 2019 08:34:22 -0800 (PST)
Subject: Re: [PATCH v2] linux-user/strace: Add missing signal strings
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
References: <20191120145555.GA15154@ls3530.fritz.box>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <373cddd6-d448-a130-bc01-20fb1272b5f6@redhat.com>
Date: Thu, 21 Nov 2019 17:34:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191120145555.GA15154@ls3530.fritz.box>
Content-Language: en-US
X-MC-Unique: 2t9yfV_DNqmiplIpJ11T1g-1
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/20/19 3:55 PM, Helge Deller wrote:
> Add the textual representations of some missing target signals.
>=20
> Signed-off-by: Helge Deller <deller@gmx.de>
>=20
> diff --git a/linux-user/strace.c b/linux-user/strace.c
> index 3d4d684450..de43238fa4 100644
> --- a/linux-user/strace.c
> +++ b/linux-user/strace.c
> @@ -146,6 +146,19 @@ print_signal(abi_ulong arg, int last)
>       case TARGET_SIGSTOP: signal_name =3D "SIGSTOP"; break;
>       case TARGET_SIGTTIN: signal_name =3D "SIGTTIN"; break;
>       case TARGET_SIGTTOU: signal_name =3D "SIGTTOU"; break;
> +    case TARGET_SIGIO: signal_name =3D "SIGIO"; break;
> +    case TARGET_SIGBUS: signal_name =3D "SIGBUS"; break;
> +    case TARGET_SIGPWR: signal_name =3D "SIGPWR"; break;
> +    case TARGET_SIGURG: signal_name =3D "SIGURG"; break;
> +    case TARGET_SIGSYS: signal_name =3D "SIGSYS"; break;
> +    case TARGET_SIGTRAP: signal_name =3D "SIGTRAP"; break;
> +    case TARGET_SIGXCPU: signal_name =3D "SIGXCPU"; break;
> +    case TARGET_SIGPROF: signal_name =3D "SIGPROF"; break;
> +    case TARGET_SIGTSTP: signal_name =3D "SIGTSTP"; break;
> +    case TARGET_SIGXFSZ: signal_name =3D "SIGXFSZ"; break;
> +    case TARGET_SIGWINCH: signal_name =3D "SIGWINCH"; break;
> +    case TARGET_SIGVTALRM: signal_name =3D "SIGVTALRM"; break;
> +    case TARGET_SIGSTKFLT: signal_name =3D "SIGSTKFLT"; break;
>       }
>       if (signal_name =3D=3D NULL) {
>           print_raw_param("%ld", arg, last);
>=20

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>


