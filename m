Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D485C4BA24
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 10:59:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F05B424699
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 10:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OjcykEGg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F05B424699
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7Gsx-0007aB-8H
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 05:59:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56646)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j7GsE-0006xw-Im
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 05:58:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j7GsD-0000EQ-3y
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 05:58:34 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:60678
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j7GsC-0000DN-NS
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 05:58:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582801111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UrdnczjsEWWNjtotmmqNLls3aVkmAt5pMu4j0pbKRrU=;
 b=OjcykEGgtJVPf6C+xVWUtf1xjUV5QpKCBZHmjEdRY/3CnVlNCu0l4etP4ZVpAmMAOZigLU
 8n50bxWjbXaolLs200CmwxDCy/jtE6TOKBK31v7nEbbbwCsSHCwEnytUaCgQIoVaWE39a2
 N6AdroQ3a1mNMXfaAZj9XTSq4QRVt5s=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-12DHRK4yNEW1zjjHrGxggw-1; Thu, 27 Feb 2020 05:58:29 -0500
X-MC-Unique: 12DHRK4yNEW1zjjHrGxggw-1
Received: by mail-wm1-f72.google.com with SMTP id r19so862380wmh.1
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 02:58:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QOFvF90OznVufott3/i8QcVk7EhMvYsLQ0aGYHPLWt4=;
 b=DqUUNGjUtAaBkyDK9fkZu/2LV47/ky1Sj+r4ZQ+WGjDWi9HUbJdvzqwVbbRPrGXLMy
 BvyA1LlIXeXnqnmXDQT8MBULzTZUTHE6qp/T64FxnoeB1IodYIjEMeP7nk0bE8VoMqHM
 N2/4ReQS+d/WRnxn5ZXYRzEguWxtagFPFrOR4ek1LKIMdOuu26SfOWH+lx9HJI+gLesS
 PWfAkNWdMwvuo4yDHI2Zs4dGtPpwVi9Co5e7fZSfCIfpfBRZZBrl20ZW5YbzRLVxt2Sh
 /DAcljMyj93Ffh+KVKnF4BtguNK2h0bd4ldyJBF9C4GyPd9+mxbnBx6xFKP+UjJVHbMk
 D8sg==
X-Gm-Message-State: APjAAAV+Tt19bPFavx8herVIQ/B0Ch6gMA6etcLFTRjSTrL8rtbI3vBe
 fb3dJNjQnadTkjGeH1O5PubpWBQGXoka9FnzMIcS5LrD9YRg7SGdsGQAmAqeuXZGw0Mrlik18W9
 +e35ERgpMngz10TY=
X-Received: by 2002:adf:fa43:: with SMTP id y3mr4177464wrr.404.1582801107947; 
 Thu, 27 Feb 2020 02:58:27 -0800 (PST)
X-Google-Smtp-Source: APXvYqy8D4Af/gGdi9Esy7boTnnbJ2NpgzJM1X6VpmLNdPUXGAWq45eGLMgYfp4oif33rWz31E6qEA==
X-Received: by 2002:adf:fa43:: with SMTP id y3mr4177440wrr.404.1582801107699; 
 Thu, 27 Feb 2020 02:58:27 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id s8sm7699090wrt.57.2020.02.27.02.58.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Feb 2020 02:58:26 -0800 (PST)
Subject: Re: [PATCH v1 2/4] accel/tcg: remove link between guest ram and TCG
 cache size
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200226181020.19592-1-alex.bennee@linaro.org>
 <20200226181020.19592-3-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <74b1fa34-59c1-f7de-cb91-10f1387087fc@redhat.com>
Date: Thu, 27 Feb 2020 11:58:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200226181020.19592-3-alex.bennee@linaro.org>
Content-Language: en-US
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 Richard Henderson <rth@twiddle.net>, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/26/20 7:10 PM, Alex Benn=C3=A9e wrote:
> Basing the TB cache size on the ram_size was always a little heuristic
> and was broken by a1b18df9a4 which caused ram_size not to be fully
> realised at the time we initialise the TCG translation cache.
>=20
> The current DEFAULT_CODE_GEN_BUFFER_SIZE may still be a little small
> but follow-up patches will address that.
>=20
> Fixes: a1b18df9a4
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Cc: Niek Linnenbank <nieklinnenbank@gmail.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> ---
>   accel/tcg/translate-all.c | 8 --------
>   1 file changed, 8 deletions(-)
>=20
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index 238b0e575bf..5b66af783b5 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -938,15 +938,7 @@ static inline size_t size_code_gen_buffer(size_t tb_=
size)
>   {
>       /* Size the buffer.  */
>       if (tb_size =3D=3D 0) {
> -#ifdef USE_STATIC_CODE_GEN_BUFFER
>           tb_size =3D DEFAULT_CODE_GEN_BUFFER_SIZE;
> -#else
> -        /* ??? Needs adjustments.  */
> -        /* ??? If we relax the requirement that CONFIG_USER_ONLY use the
> -           static buffer, we could size this on RESERVED_VA, on the text
> -           segment size of the executable, or continue to use the defaul=
t.  */
> -        tb_size =3D (unsigned long)(ram_size / 4);
> -#endif
>       }
>       if (tb_size < MIN_CODE_GEN_BUFFER_SIZE) {
>           tb_size =3D MIN_CODE_GEN_BUFFER_SIZE;
>=20

Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


