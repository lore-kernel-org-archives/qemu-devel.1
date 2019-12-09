Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1EE9C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 16:04:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89B862077B
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 16:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MeGRWJOj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89B862077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieLWp-0000B2-LD
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 11:04:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57990)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ieLSn-0004BA-G5
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 11:00:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ieLSi-0002Lu-Ds
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 11:00:45 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41441)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ieLSi-0002Jp-5f
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 11:00:40 -0500
Received: by mail-wr1-x443.google.com with SMTP id c9so16797760wrw.8
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2019 08:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=cJ5tC38qdbylHz6Ukz5CSrO7+ZUQTXXN8j03HEEov2s=;
 b=MeGRWJOj200Uu7rHuzwpplBuRH7Q9GvxIWKTOfljP1sayybMS7xowlhEGv1E6wQR56
 avcwuJPNe/nOIS81trv4ake8nDeXYXsi/xeYkAfp+Gy3Uq85PmRaaeDUx/jIBde37bV4
 CWECw69ZSYk8H5S4jHFHlYQMtvqFbLuM+oUCNkgKE0jGNzvDrtBo7BOB8U0OpaqEBwN0
 YzJyxCwks+WT72XBvYxK5OH/PRWIekLROUPOl2m7D8hvAM3VgaIAP6+sdlXviLZUYOQN
 u3HNkgJM9njUcDU+qpOVxxH1DthYsHKtdtMOZyYpNUllXa3vqS0vZkaEkM9/nUHPCzep
 0R8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=cJ5tC38qdbylHz6Ukz5CSrO7+ZUQTXXN8j03HEEov2s=;
 b=QobLsP9YbxPo3LHGAeGkrFyh6m8g36wQ71rH7Z1fz7El1vsqKuBhRFXvWvJUQ9CzVT
 QY+EFGa8AETBTMLf9tGLVI5/QSUjPANQUO4kzXXwcHG9oW/HuvsEhez1VjLqBHoJVuzV
 DwhzJsM87h0kQAx/guq6d6bXQoyce2n7B6DplmCHmM2x+epKCeG7UVNaKISGqASCvV5v
 y4jROrL9XEjlYT8hDuKEndmG8M0yOw1cdwgFbM0ChJnlO5H0+wosi7Sc5OokOmJbs+3q
 lasXCcGMEmi1mKIUm4yVlumiXTnaB6wx4lqD9y/VslJkKGpM4ZdiaCsc+BQelBYjMJih
 IpHQ==
X-Gm-Message-State: APjAAAWJc3+ijfFpYwQtZ1x5sJH+eEImKWHDxxwGp1W7hpO/c+9XcQOE
 K9MPsX0cBKMKxmfFRi+e4Fnuuw==
X-Google-Smtp-Source: APXvYqwxwVDnpCx4in1YK2Qeeh7X/ju/e/aZVEZPADcS/++kleEZ3Hc2tZ/JEw2cJwQ5w6ShvXU/aQ==
X-Received: by 2002:a05:6000:1248:: with SMTP id
 j8mr2921073wrx.44.1575907238651; 
 Mon, 09 Dec 2019 08:00:38 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v22sm63170wml.11.2019.12.09.08.00.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2019 08:00:37 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 86D401FF87;
 Mon,  9 Dec 2019 16:00:36 +0000 (GMT)
References: <20191209134552.27733-1-philmd@redhat.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH] target/arm: Display helpful message when hflags mismatch
In-reply-to: <20191209134552.27733-1-philmd@redhat.com>
Date: Mon, 09 Dec 2019 16:00:36 +0000
Message-ID: <87d0cx32vv.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> Instead of crashing in a confuse way, give some hint to the user
> about why we aborted. He might report the issue without having
> to use a debugger.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  target/arm/helper.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 0bf8f53d4b..6bfb62672b 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -11348,6 +11348,20 @@ void HELPER(rebuild_hflags_a64)(CPUARMState *env=
, int el)
>      env->hflags =3D rebuild_hflags_a64(env, el, fp_el, mmu_idx);
>  }
>=20=20
> +static inline void assert_hflags_rebuild_correctly(CPUARMState *env)
> +{
> +#ifdef CONFIG_DEBUG_TCG
> +    uint32_t env_flags_current =3D env->hflags;
> +    uint32_t env_flags_rebuilt =3D rebuild_hflags_internal(env);
> +
> +    if (unlikely(env_flags_current !=3D env_flags_rebuilt)) {
> +        fprintf(stderr, "TCG hflags mismatch (current:0x%08x rebuilt:0x%=
08x)\n",
> +                env_flags_current, env_flags_rebuilt);
> +        abort();
> +    }
> +#endif
> +}
> +
>  void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
>                            target_ulong *cs_base, uint32_t *pflags)
>  {
> @@ -11355,9 +11369,7 @@ void cpu_get_tb_cpu_state(CPUARMState *env, targe=
t_ulong *pc,
>      uint32_t pstate_for_ss;
>=20=20
>      *cs_base =3D 0;
> -#ifdef CONFIG_DEBUG_TCG
> -    assert(flags =3D=3D rebuild_hflags_internal(env));
> -#endif
> +    assert_hflags_rebuild_correctly(env);

I'm trying to recall why we don't just use:

  g_assert_cmphex(flags, =3D, rebuild_hflags_internal(env))

I think it came up in one of the reviews.

>=20=20
>      if (FIELD_EX32(flags, TBFLAG_ANY, AARCH64_STATE)) {
>          *pc =3D env->pc;


--=20
Alex Benn=C3=A9e

