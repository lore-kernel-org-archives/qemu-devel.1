Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC102ECE58C
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 18:52:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8F552067B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 18:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UeLJoTc6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8F552067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK5S6-0002jz-PF
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 14:52:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33220)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iK5RJ-0001qj-J5
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 14:51:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iK5RI-0007n6-Hn
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 14:51:29 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:35251)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iK5RI-0007mZ-B0
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 14:51:28 -0400
Received: by mail-wm1-x341.google.com with SMTP id y21so17774041wmi.0
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 11:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=kOgzEhvEx7VbtBEPUxjCgRyG1aUtnsAAH51e6/uoo+8=;
 b=UeLJoTc6k3Vh9fibd7W6220Z3oMGYzsn6FFX57FXSLS1ge1wgxgqalmK05tHBevQTJ
 8JZ1tToaDbsigp/6HpOuMjfEs+UUqjEIKsODi2vODQGIMi7F50Y9drL5qYT446JxDKl1
 85u/HbX6Wx6UFiKMas1IzTGrPafXt9at2VMB04fuKJ0pBfA0gwPKYRkKC86rq29041oI
 II5y3hntDwAADSAxGt/z+XrohqTDWLrOwKB/0SFoQCL2Uw3o5O/RzNNgilAuq5j4RX5/
 2E2kcEysJuuR6BpbdkNBcIVt/cLYI5hwG+G+XbV6UtLtUx+3ENsnXsxcVnBFvwC7dHZW
 11jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=kOgzEhvEx7VbtBEPUxjCgRyG1aUtnsAAH51e6/uoo+8=;
 b=AnmVjyHB17bX4fLd6jN2I7DxUD2tuXnmSEl9VrbhNN20CWDPtPgD7xhUDvVEVVbRU/
 rFfrCvViESZiY/RApHJ/CYEPtAUqdlx46fkE6owF3kKbFlvqlWxVgmH4T/5ZyeirlNv8
 waoB3qlB4LxfSZcGAfw7EPi3mlqeBLzA6rUhb63o8Gr0pHc3JL8JeTczJjUqMO1fjxTE
 z5+EkbGK+ix/K8BHMJPb6ILS6aa+bdKfVTV/UlNZN9yV0qfRZKmT4DbVCld6h9tUZLpl
 y9zVIQaCulROHV9Wz1M6i+w8dkhd3cEVzZH2YwVRlgJEXJPORSK643N5sI+VYa8/M/n4
 KeSg==
X-Gm-Message-State: APjAAAUVB/ikUzSxSygFZ/VTfaiNegFBX9ddsRC7I9gj8Jv+OH7dSB7j
 BRVD773t4hEdJ0tNPdaGDpRN0Q==
X-Google-Smtp-Source: APXvYqyUAdDeWA7oiO0IzUzEVWvmP0es43axCRxsPb87LkJQkaS2ncIL25yI7EXYkjiBNKltkmV6Qg==
X-Received: by 2002:a7b:c444:: with SMTP id l4mr16359828wmi.49.1571079086980; 
 Mon, 14 Oct 2019 11:51:26 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 5sm18806219wrk.86.2019.10.14.11.51.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 11:51:26 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A50EA1FF87;
 Mon, 14 Oct 2019 19:51:25 +0100 (BST)
References: <20191011155546.14342-1-richard.henderson@linaro.org>
 <20191011155546.14342-15-richard.henderson@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-arm@nongnu.org
Subject: Re: [PATCH v6 14/20] target/arm: Hoist store to cs_base in
 cpu_get_tb_cpu_state
In-reply-to: <20191011155546.14342-15-richard.henderson@linaro.org>
Date: Mon, 14 Oct 2019 19:51:25 +0100
Message-ID: <87blujma8i.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: laurent.desnogues@gmail.com, peter.maydell@linaro.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> By performing this store early, we avoid having to save and restore
> the register holding the address around any function calls.

Been peeking at the assembly again ;-)

>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 3f7d3f257d..37424e3d4d 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -11225,6 +11225,7 @@ void cpu_get_tb_cpu_state(CPUARMState *env, targe=
t_ulong *pc,
>  {
>      uint32_t flags, pstate_for_ss;
>
> +    *cs_base =3D 0;
>      flags =3D rebuild_hflags_internal(env);
>
>      if (is_a64(env)) {
> @@ -11298,7 +11299,6 @@ void cpu_get_tb_cpu_state(CPUARMState *env, targe=
t_ulong *pc,
>      }
>
>      *pflags =3D flags;
> -    *cs_base =3D 0;
>  }
>
>  #ifdef TARGET_AARCH64


--
Alex Benn=C3=A9e

