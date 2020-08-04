Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A51C433E1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 16:25:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00E542070A
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 16:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I047+7DP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00E542070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2zkt-0002hS-9I
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 12:25:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49368)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k2zk9-0001oG-SW
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 12:24:49 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51954)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k2zk8-0008Tk-4M
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 12:24:49 -0400
Received: by mail-wm1-x343.google.com with SMTP id p14so3240679wmg.1
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2020 09:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=/6IVhOzHRf2lPByqwM3rJ8Ofvrl4uVAq5QraRE0p+ok=;
 b=I047+7DPhzJtBnVC9lHcc60e685cncUTTXhsQIVcAdKPQiVjHad+El/bKiYdpk99q8
 X2D5psJB4kXKNd/Ec5ITLGlrI+1XOmjJkXym0ClY7MPp+FYSB9FFBLDuPk74vC+8lTPc
 rOJgYW5xMlTw5Rqo+FIuV6PDu3Kykw+tWZftUPbAI9WXfzHlOuvRGDhzrcfGHpfRzXPe
 YHO+rO81Y2EWMzWDljIrTvf7Ix/MhphcumYmPgP4+vY5yvUN6Hrbhw3Z+xnkfI6KnGDa
 Cu/Gv4mv0d2UGo3raMUezGAoUXM0H2hfuZ4RxVcSPGrhuIiEKT4LCBLF51mszSF8Rs6y
 +npA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=/6IVhOzHRf2lPByqwM3rJ8Ofvrl4uVAq5QraRE0p+ok=;
 b=Kkps9JFoR1/qBN2y+jEs7k4LRWwIqXG5Qp9kG+p+Oib5hGWj+x46jOwsp1k80TBXs8
 VXSviSLqIUF87ZjsUud0cSr6fGkEBIatx0BLW2SD40kUDSOhzjpoaZHprc5xP9EU8Y6x
 zA23YhyKRAwkaX+EEhH8XD86EIyLxTMc+/dY0w4nFd8pOrxjwYR5fWbKjynMnPPYVqAh
 8tJQdz1zMC5DJvWHl1d4+wGZAzEaLQ2cbaSDI8rtq5lmVSuleABGFeR7oy6LS+tsGE2l
 9tpi37/HulSwJmwrosFaSr6dRC3hDZtBlLHGG2Pqeym3RbMyvuwMDq16gufuN5Wyp9v0
 m/Hw==
X-Gm-Message-State: AOAM532C/m8seVG83bzdqfcnwWq4hP0HFDpvFxPWH+EcLqklz/ubbIlw
 f+JMq6cCx2Mi7mRCCE5eE9W3ig==
X-Google-Smtp-Source: ABdhPJyj2bs+HCr2x1LekGOaJ6e9wQb2UvN4K7N3h7C+OXHM+/EHlS7vRPh7W8mqQ5TNbdsD+bD2Ng==
X-Received: by 2002:a7b:c76e:: with SMTP id x14mr4696905wmk.176.1596558285395; 
 Tue, 04 Aug 2020 09:24:45 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id j5sm5134153wmb.12.2020.08.04.09.24.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2020 09:24:44 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6B3281FF7E;
 Tue,  4 Aug 2020 17:24:43 +0100 (BST)
References: <20200730141326.8260-1-thuth@redhat.com>
 <20200730141326.8260-5-thuth@redhat.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v2 4/4] gitlab-ci: Fix Avocado cache usage
In-reply-to: <20200730141326.8260-5-thuth@redhat.com>
Date: Tue, 04 Aug 2020 17:24:43 +0100
Message-ID: <877dueml9w.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Thomas Huth <thuth@redhat.com> writes:

> In commit 6957fd98dc ("gitlab: add avocado asset caching") we
> tried to save the Avocado cache (as in commit c1073e44b4 with
> Travis-CI) however it doesn't work as expected. For some reason
> Avocado uses /root/avocado_cache/ which we can not select later.
>
> Manually generate a Avocado config to force the use of the
> current job's directory.
>
> This patch is based on an earlier version from Philippe Mathieu-Daud=C3=
=A9.

Maybe add a Based-on: <msgid>?

>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  .gitlab-ci.yml | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)
>
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index e96bcd50f8..9820066379 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -47,11 +47,24 @@ include:
>      - find . -type f -exec touch {} +
>      - make $MAKE_CHECK_ARGS
>=20=20
> -.post_acceptance_template: &post_acceptance
> +.acceptance_template: &acceptance_definition
> +  cache:
> +    key: "${CI_JOB_NAME}-cache"
> +    paths:
> +      - ${CI_PROJECT_DIR}/avocado-cache
> +    policy: pull-push
> +  before_script:
> +    - mkdir -p ~/.config/avocado
> +    - echo "[datadir.paths]" > ~/.config/avocado/avocado.conf
> +    - echo "cache_dirs =3D ['${CI_PROJECT_DIR}/avocado-cache']"
> +           >> ~/.config/avocado/avocado.conf

I was hoping there was a neater way to do this with the multiline
commands but whatever:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

