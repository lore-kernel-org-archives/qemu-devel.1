Return-Path: <SRS0=bgql=3H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E4F2C33CB1
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 10:10:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 618142468D
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 10:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yz3WTSlk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 618142468D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isl3Y-00035z-GQ
	for qemu-devel@archiver.kernel.org; Sat, 18 Jan 2020 05:10:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46152)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1isl2o-0002Of-DA
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 05:09:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1isl2n-0006Ca-1G
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 05:09:30 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:22987
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1isl2m-0006AZ-UK
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 05:09:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579342168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ALmFK4GN1R3f8ivCPsaZjbKvNERv/UXgwN1V0eQdo9U=;
 b=Yz3WTSlkCZ0k/rAiwMjj+uoAyXxfdoPcfK0z55gb2I6QqWJHcWmqvaKCgZOiV90MFRubrk
 g8j9ko6mcbgTM1GO0c+ub5gtFBsbMnHwnn67B8wD8xgbYwBv1GcxHRf4tQwefka2lwGvhY
 YZt7NoaVEMSGepW4lGhG7z3PyoGXa9A=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-HcyQJcXvOyKHHU9r289VQQ-1; Sat, 18 Jan 2020 05:09:25 -0500
Received: by mail-wr1-f70.google.com with SMTP id z10so11522934wrt.21
 for <qemu-devel@nongnu.org>; Sat, 18 Jan 2020 02:09:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=U1Sxext4Y1Dh1E+fQ3V/TgeW7exJ8+wkF1SkhDeB9Co=;
 b=BuogyPWBO1RxWDOhL4/hz5gp/UVikuMTrrYYzBkMFBt72QCC0yIMCyF5/PKJjZ7rvu
 dtHpcWRLuTQ6GMew5ECPv0lwZihXBCfK3el27GI/DOJvFzB2RTwNRl6pFt5F1CDMJJnc
 Ee8YToKzc23lj2WXXEIZUi8dvC4s8jCV86xywfeqTXu4K6gorri9YGlznGGIXnjgra3x
 n2LKx3y7aGHW+RY/9Y17d34fazFYXrOCsZ22YwI6v+0WRW84CUaQRc1FNAFuIqPoBtsO
 8dJGSNPeP0zSLr1KBvGJ4igX82Qh2wkkSvvkorgf8XEcO9oTYpt1I4hOc6ufrE3yuPus
 tSyA==
X-Gm-Message-State: APjAAAW8OhRO10XrvbhenrzuRrvVpzD/lKIk3NQqJ9FXg5pcLVTHyGGR
 FtkHoUUKexcBM088nlCuocot+rvn/Fb0idBZWiPElwK+kZWs8RNc/WPsZSGvPNNyUQvcg1z0ypI
 uF5DztAZO3jwrjcE=
X-Received: by 2002:a1c:1f51:: with SMTP id f78mr8943670wmf.60.1579342164467; 
 Sat, 18 Jan 2020 02:09:24 -0800 (PST)
X-Google-Smtp-Source: APXvYqw+UNYu5PBC0fFkwbTA6OX3+XYODHPGXlMMUt5k21OsDUHDebPYkgyQFznTzMN3BTu/hAW6uw==
X-Received: by 2002:a1c:1f51:: with SMTP id f78mr8943637wmf.60.1579342164183; 
 Sat, 18 Jan 2020 02:09:24 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id q19sm12616717wmc.12.2020.01.18.02.09.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Jan 2020 02:09:23 -0800 (PST)
Subject: Re: [PATCH] scripts/git.orderfile: Display decodetree before C source
To: qemu-devel@nongnu.org
References: <20191230082856.30556-1-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <4bf7c585-fe7f-c574-d706-2317e6bcbceb@redhat.com>
Date: Sat, 18 Jan 2020 11:09:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191230082856.30556-1-philmd@redhat.com>
Content-Language: en-US
X-MC-Unique: HcyQJcXvOyKHHU9r289VQQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: David Hildenbrand <david@redhat.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Stafford Horne <shorne@gmail.com>, Sven Schnelle <svens@stackframe.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing qemu-trivial@

On 12/30/19 9:28 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> To avoid scrolling each instruction when reviewing tcg
> helpers written for the decodetree script, display the
> .decode files (similar to header declarations) before
> the C source (implementation of previous declarations).
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>   scripts/git.orderfile | 3 +++
>   1 file changed, 3 insertions(+)
>=20
> diff --git a/scripts/git.orderfile b/scripts/git.orderfile
> index e89790941c..1f747b583a 100644
> --- a/scripts/git.orderfile
> +++ b/scripts/git.orderfile
> @@ -25,5 +25,8 @@ qga/*.json
>   # headers
>   *.h
>  =20
> +# decoding tree specification
> +*.decode
> +
>   # code
>   *.c
>=20


