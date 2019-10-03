Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C57C32792
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 23:49:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0F242133F
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 23:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QOcjLYgr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0F242133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGAqf-0003og-ME
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 19:49:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56323)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iGASj-0006Qz-Sh
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 19:24:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iGASg-0004AC-AX
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 19:24:44 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26352
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iGASg-00048U-2A
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 19:24:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1570145081;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wki6/h0rYHJ1VluFFFgwSUQEH1GEWfy/N8CY+kJiJCU=;
 b=QOcjLYgrJtDNDOgPkfx1zfse2P1xbWKYZWCGEVNl+xe0bZANoVZBSAntlPu6ATm12nFg0x
 xj/JomzSr+nOxD6BI2I9YSV12C2Wr6FSpDaeUKs2loHLXfx/yl7MFNVYLV4JYosAfHJkbD
 /k1CP1WrVm5x5dQqfeROwdNohPeKRek=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-RXPDFZEtOFifTie4g2-08Q-1; Thu, 03 Oct 2019 19:24:39 -0400
Received: by mail-wr1-f72.google.com with SMTP id k4so1673298wru.1
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2019 16:24:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xnT5eQjNQBARaF6UDq3kKyCElJIjEQvAj4d/TAmzogM=;
 b=CgUKs6E+Nzo/1psll+4/qnD00tCBolx1HL6ts9ewmNkynv+Zml/HuSFwXfnFIxr2O1
 FV5bklXAczcz7IMrD7LDrDkdGJOqyFe4PwUqw1HKS9m0WVSBbhBqFVSDnn76ijIcwv+J
 Sid1n1aLuM/KlxwCWQErdjmbB9rszxT7juXIKOTnA+MKzu1PvXLEWusKK6hZObw68sVe
 tbZshEmTbO5RgKXhACYQ+dB6AIzk+I8BES8YtzmzaO4lyOnpQ0wBJ7eLgMDpOgWascik
 zLRH15e2v/g8BCwG6e64ku5DwzTI6Nz1YKjH+6hvMN837BCjIn7eK9CbeU7/s4aiaM1H
 wfFg==
X-Gm-Message-State: APjAAAUZaCVqVWAzxKVM2byszZlTQrgayCaq2oBj39gBC/Nz4H+ev6yd
 nU6lSU9Xy/uuMLCXMF5KoubkgYCIRTW4J1X8hfxUKXdcz4MZiaK6zCqrI7PpODoqO3JB+ZIP5qV
 FEy1GXQFIuYY5DGc=
X-Received: by 2002:adf:8b13:: with SMTP id n19mr9547887wra.203.1570145078422; 
 Thu, 03 Oct 2019 16:24:38 -0700 (PDT)
X-Google-Smtp-Source: APXvYqytqQfonwi9TyRypBVBtTOHAKUeH9u3olvVwiF+onGSKJs8xrcnjgrJBKUgF9tWtJyxSHX7mg==
X-Received: by 2002:adf:8b13:: with SMTP id n19mr9547869wra.203.1570145078220; 
 Thu, 03 Oct 2019 16:24:38 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id o22sm9901551wra.96.2019.10.03.16.24.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Oct 2019 16:24:37 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH v2 01/15] target/arm/arm-semi: Capture errno
 in softmmu version of set_swi_errno()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20190916141544.17540-1-peter.maydell@linaro.org>
 <20190916141544.17540-2-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a10f43ac-82e8-7600-94d3-513feafaf325@redhat.com>
Date: Fri, 4 Oct 2019 01:24:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190916141544.17540-2-peter.maydell@linaro.org>
Content-Language: en-US
X-MC-Unique: RXPDFZEtOFifTie4g2-08Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/16/19 4:15 PM, Peter Maydell wrote:
> The set_swi_errno() function is called to capture the errno
> from a host system call, so that we can return -1 from the
> semihosting function and later allow the guest to get a more
> specific error code with the SYS_ERRNO function. It comes in
> two versions, one for user-only and one for softmmu. We forgot
> to capture the errno in the softmmu version; fix the error.
>=20
> (Semihosting calls directed to gdb are unaffected because
> they go through a different code path that captures the
> error return from the gdbstub call in arm_semi_cb() or
> arm_semi_flen_cb().)
>=20

Fixes: 8e71621f784
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> NB that a later commit will put in some cleanup of TaskState
> that will let us reduce the duplication between the two
> implementations of this function.
> ---
>   target/arm/arm-semi.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
> index 90423a35deb..03e60105c05 100644
> --- a/target/arm/arm-semi.c
> +++ b/target/arm/arm-semi.c
> @@ -114,8 +114,13 @@ static inline uint32_t set_swi_errno(TaskState *ts, =
uint32_t code)
>       return code;
>   }
>   #else
> +static target_ulong syscall_err;
> +
>   static inline uint32_t set_swi_errno(CPUARMState *env, uint32_t code)
>   {
> +    if (code =3D=3D (uint32_t)-1) {
> +        syscall_err =3D errno;
> +    }
>       return code;
>   }
>  =20
> @@ -124,10 +129,6 @@ static inline uint32_t set_swi_errno(CPUARMState *en=
v, uint32_t code)
>  =20
>   static target_ulong arm_semi_syscall_len;
>  =20
> -#if !defined(CONFIG_USER_ONLY)
> -static target_ulong syscall_err;
> -#endif
> -
>   static void arm_semi_cb(CPUState *cs, target_ulong ret, target_ulong er=
r)
>   {
>       ARMCPU *cpu =3D ARM_CPU(cs);
>=20


