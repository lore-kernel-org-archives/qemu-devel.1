Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C832AC31E58
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 14:11:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99D9E206B7
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 14:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mAMyh2Ig"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99D9E206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47866 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcsLd-0004tL-L5
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 10:11:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39048)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hcsIu-0002a2-Qe
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:08:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hcsIt-0007ty-P7
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:08:12 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:34499)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hcsIt-0007jQ-IX
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:08:11 -0400
Received: by mail-wm1-x341.google.com with SMTP id w9so57774wmd.1
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 07:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=gPEuPGeUwtUqNcdCuz0VLL0YLEkYJRFFXJ8vEkCNYgY=;
 b=mAMyh2IgR9BK0WxXD/8PWgqcFnT7yCzNQPvhtePSJ+epMvMJiS4qiI/KDKWR4kGWUh
 sxm6c2GAWnS9LHEW5UcozAwWSsd9KMvbGg5ZL4CxBuexSGia0fj7ljt+B/3WIfDZPzHT
 +yrYOMF8tI5N9tfmMesjwxAeuJASwrIZAPNYaFBOmYWa7A4c8tTgcFICbf3eF6yTBsV8
 YzGrKXz4YL+GgofLUxf6A+SJkZFrBkM1perPankAQasw2ZPYEZoNijLieFnUywOaNpdF
 W9ahom5mgxpZvpbaopncT5gdcn1kXt9wzMsN0dtR+9DKleFnaPk8AZ4dFRZ7FRAx5kDx
 4OHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=gPEuPGeUwtUqNcdCuz0VLL0YLEkYJRFFXJ8vEkCNYgY=;
 b=pwDQO3/OBcAIva3S7hOF4NVVIHrutPzm0CAKKM7D/z6KppqFoO0aiQjljzyc9kVZKO
 fNEQnvnpNvsC7QqoSRoej3U6t7WfhsDQBo4qza5tSUq8UHaSrlQq2c80GPugDHAmPEjt
 PQ7E6/zf8iReovsUwDcRGIPRfH+BXDY2r69x354avoOjOE9ue0hnvQGU4oJFq8M5BzCO
 OGPdrExeKNOFC/hieDruUo0RtWAijnzXS3TmVSDkVAA8bceiRASTjlE7yW3E3iHpMmqF
 dw7hdA3dtMYcZx4M6X+TIg0Fmp49yU2Im2GdLLU5fOyp4/SFrLIE/AYusiGKUWgcajqH
 JJYw==
X-Gm-Message-State: APjAAAUU0pooAYYeOuffadHmoGwKmRfFtpz9MGP3OdBeVkYPX6/l05RW
 7iW65IgnA8lW1WC+9Wp5CEa2Fg==
X-Google-Smtp-Source: APXvYqwn3ywu3wdpMx74z8g2mfgg0EcAT8rI4sJmtyG1Kv+Me2W9eFbbr/xwY7O6dQpc9Aauv4LwSw==
X-Received: by 2002:a1c:f712:: with SMTP id v18mr20509588wmh.143.1560780479701; 
 Mon, 17 Jun 2019 07:07:59 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id o13sm23733433wra.92.2019.06.17.07.07.59
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 17 Jun 2019 07:07:59 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BCDC51FF87;
 Mon, 17 Jun 2019 15:07:58 +0100 (BST)
References: <20190615154352.26824-1-philmd@redhat.com>
 <20190615154352.26824-10-philmd@redhat.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-arm@nongnu.org
In-reply-to: <20190615154352.26824-10-philmd@redhat.com>
Date: Mon, 17 Jun 2019 15:07:58 +0100
Message-ID: <87tvco9uf5.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 09/23] target/arm: Move code
 around
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> To ease the review of the next commit, move the
> write_v7m_exception() function around.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/helper.c | 40 ++++++++++++++++++++--------------------
>  1 file changed, 20 insertions(+), 20 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index a829086c6d..b4fd9b42d7 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -7923,26 +7923,6 @@ void write_v7m_control_spsel(CPUARMState *env, boo=
l new_spsel)
>      write_v7m_control_spsel_for_secstate(env, new_spsel, env->v7m.secure=
);
>  }
>
> -void write_v7m_exception(CPUARMState *env, uint32_t new_exc)
> -{
> -    /*
> -     * Write a new value to v7m.exception, thus transitioning into or out
> -     * of Handler mode; this may result in a change of active stack poin=
ter.
> -     */
> -    bool new_is_psp, old_is_psp =3D v7m_using_psp(env);
> -    uint32_t tmp;
> -
> -    env->v7m.exception =3D new_exc;
> -
> -    new_is_psp =3D v7m_using_psp(env);
> -
> -    if (old_is_psp !=3D new_is_psp) {
> -        tmp =3D env->v7m.other_sp;
> -        env->v7m.other_sp =3D env->regs[13];
> -        env->regs[13] =3D tmp;
> -    }
> -}
> -
>  /* Switch M profile security state between NS and S */
>  void switch_v7m_security_state(CPUARMState *env, bool new_secstate)
>  {
> @@ -9247,6 +9227,26 @@ static bool do_v7m_function_return(ARMCPU *cpu)
>      return true;
>  }
>
> +void write_v7m_exception(CPUARMState *env, uint32_t new_exc)
> +{
> +    /*
> +     * Write a new value to v7m.exception, thus transitioning into or out
> +     * of Handler mode; this may result in a change of active stack poin=
ter.
> +     */
> +    bool new_is_psp, old_is_psp =3D v7m_using_psp(env);
> +    uint32_t tmp;
> +
> +    env->v7m.exception =3D new_exc;
> +
> +    new_is_psp =3D v7m_using_psp(env);
> +
> +    if (old_is_psp !=3D new_is_psp) {
> +        tmp =3D env->v7m.other_sp;
> +        env->v7m.other_sp =3D env->regs[13];
> +        env->regs[13] =3D tmp;
> +    }
> +}
> +
>  void arm_log_exception(int idx)
>  {
>      if (qemu_loglevel_mask(CPU_LOG_INT)) {


--
Alex Benn=C3=A9e

