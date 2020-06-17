Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0015C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 10:38:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C61920FC3
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 10:38:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eEXqnlDs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C61920FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlVSn-0008E8-QU
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 06:38:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57318)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jlVS9-0007nK-OB
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 06:37:57 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:53759)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jlVS7-0001Ew-RG
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 06:37:57 -0400
Received: by mail-wm1-x344.google.com with SMTP id l26so1359028wme.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 03:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=z/jXuXn+Ev4tlXgEwJWKLIpjzfZWXXJMnb+TdLTT5TQ=;
 b=eEXqnlDsz3UmkwxwepZAODoAiTF5dDC7aBsPrvH7Bt5wEFoD2QWuf2r599GWWXJe7W
 olN5exIhwWsm/OgXlaLgSLzjPQt08TlbSdKpdd6+6XjJCHLPvFLoxTwNY8tLLkYsbGwF
 EjDuOanEIgg6wnZ9sSiLnktkHvgF9+FxnrYJJKg/LJASoa1HoCavDBKzGQFx/0QAwfoD
 VzoxxTpikO/9Xzlwq4dT+bA6+X4S1M33NHgGTlpuO2vZp3HQVC/OaEhQNsZkY52mSuXf
 Vnxc32XnqzcmYMcCp9puAcbQcA2Tjux5QJlHkIy6eir5KxTT+JYEZGDBVuQVaZ/d6JOK
 1AFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=z/jXuXn+Ev4tlXgEwJWKLIpjzfZWXXJMnb+TdLTT5TQ=;
 b=bOOfl6pgd87gkBUO2pCJ/Oh3j7VkzFc0SOcVDYFubzegLtJ3VU1c6H09fSZIFtm4bs
 8rxGDZ+HJtPkZBlCdD5cLdNfR2rB0qYZvYNSenXvwgX43NLgQtLsU1XIR3ePtHCPvvzY
 vvTP5BM26WsiWLmNh8BJf5oYbxcuU+smehHH2F/7y2Ss8Vq0/K66Za70UP8sbaEb0oEC
 CzmO5NapLDnK9MSJYY2/G3+prd58IBThtzRxCvTRWRnOZNgfoBofzE+33GDiK6YcDmft
 aRttugMvAjiFiN2E9xMC962NCpVUXWyQNipamUw7+7nEhi0SisSOwIiQUCJE0nNUrg56
 vOKA==
X-Gm-Message-State: AOAM530B329eInhtEBB5IVB2SN73smkJGnEiZU7Ig4xjyMDuqDCtSYQq
 Lc1poVEVVOOMLhv1pJ+fMgDJlQ==
X-Google-Smtp-Source: ABdhPJxQn+jEnHLvB8Sz0OMOA5rcwpU5WUY8NqeLy3apQiNwYA6NmKEDes7Rv2Ym0Twv5z9d4FS7Mg==
X-Received: by 2002:a1c:9943:: with SMTP id b64mr7960650wme.102.1592390274096; 
 Wed, 17 Jun 2020 03:37:54 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c70sm7548290wme.32.2020.06.17.03.37.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 03:37:51 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DE7881FF7E;
 Wed, 17 Jun 2020 11:37:43 +0100 (BST)
References: <20200617043757.1623337-1-richard.henderson@linaro.org>
 <20200617043757.1623337-2-richard.henderson@linaro.org>
User-agent: mu4e 1.5.3; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v3 1/5] fpu/softfloat: Silence 'bitwise negation of
 boolean expression' warning
In-reply-to: <20200617043757.1623337-2-richard.henderson@linaro.org>
Date: Wed, 17 Jun 2020 11:37:43 +0100
Message-ID: <87pn9yx9jc.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>
> When building with clang version 10.0.0-4ubuntu1, we get:
>
>     CC      lm32-softmmu/fpu/softfloat.o
>   fpu/softfloat.c:3365:13: error: bitwise negation of a boolean expressio=
n; did you mean logical negation? [-Werror,-Wbool-operation]
>       absZ &=3D ~ ( ( ( roundBits ^ 0x40 ) =3D=3D 0 ) & roundNearestEven =
);
>               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
>   fpu/softfloat.c:3423:18: error: bitwise negation of a boolean expressio=
n; did you mean logical negation? [-Werror,-Wbool-operation]
>           absZ0 &=3D ~ ( ( (uint64_t) ( absZ1<<1 ) =3D=3D 0 ) & roundNear=
estEven );
>                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~
>
>   ...
>
>   fpu/softfloat.c:4273:18: error: bitwise negation of a boolean expressio=
n; did you mean logical negation? [-Werror,-Wbool-operation]
>           zSig1 &=3D ~ ( ( zSig2 + zSig2 =3D=3D 0 ) & roundNearestEven );
>                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Fix by rewriting the fishy bitwise AND of two bools as an int.
>
> Suggested-by: Eric Blake <eblake@redhat.com>
> Buglink: https://bugs.launchpad.net/bugs/1881004
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Message-Id: <20200528155420.9802-1-philmd@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

