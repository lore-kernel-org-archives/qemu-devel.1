Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E0A4C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 07:44:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38373207D3
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 07:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="St6CGtnW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38373207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh71n-0002W9-E2
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 03:44:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54904)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jh6yx-0004RK-1M
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 03:41:39 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:34771)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jh6yt-0005y8-4e
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 03:41:38 -0400
Received: by mail-wr1-x441.google.com with SMTP id r7so8685469wro.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 00:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=lBzdeQV27AZslQPSHqs9qNu78G53MiLjUuBc/kQjs2o=;
 b=St6CGtnW3WOv3aFhCHG7p7UM74g1mItJhFafnxOy70LCbjdMay8Karw/rFiYN/UyUO
 9oSA9Tb8tsaShBx3qe+YM36wfLPqLJPTyRnYHTG3D2+Y/2dyQDbG6XKDyDfQBiG+1ZG+
 +qqhn4Z6T1KyrxcUZt5VPmByVcM/a38XOzQ1FprLK6YrSuag8x7eX1G+sE+oE8bPmmx7
 B6mE9IlngEeqi5/LWOV+Vf42qvRIEWx4kl2xvT5cLDFLxKEBVzgTMQdqW/pf1GWnxTLQ
 Hqm4YOoHYALYjigDgVto04f3i5G51y3VUEgx0aaba9wWgvq1Vrlicgl5t2YnU7x/OJqY
 u/uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=lBzdeQV27AZslQPSHqs9qNu78G53MiLjUuBc/kQjs2o=;
 b=bkqOO+TFyPdAdaH7sFe/YLzo44uDXD4PObInKzK/4EkSLEXVCTysnKvq+oBI6a35b8
 T5PUuy5Yb15Quo9qqEAkFS7DyXxaxh9ay0ljAaQvLSJP7obNT5Lx5xZ/d6dVbT91qRQy
 Z2YRKMWpZ/ifY9gE280NPNsRX8w0ptrKsB//X4hMBfOipkaBT/10pO8akKOyFzKMt///
 9ibTtcxbfz8MdeNY1Kuv5CunA1APFTl2puuPvqLoDURsZiDae3+ij+pDNd7NwCzonaKv
 VCeRRP25/32GSXTFNWHPmXBR61NZx/6y2BqsZO4VsoLUzcnD++6qiWtYD/Db7ZhzE2iZ
 KigQ==
X-Gm-Message-State: AOAM5322491lAboKavcnz5+UuZH9YwCihyRIzzg+PfRTWcGdH66UX3wO
 Gv3wGgxfvKniO1BaQ61rjlsgFG5SY3A=
X-Google-Smtp-Source: ABdhPJw6vP40VgWRhaBTLDhB5DIcxpzSRFuFir6yvDfiHz7F1eC3xHJ1BjYen+ZROw3xDmo5F4kqrA==
X-Received: by 2002:a5d:6a89:: with SMTP id s9mr8076938wru.15.1591342892813;
 Fri, 05 Jun 2020 00:41:32 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id r11sm11497297wre.25.2020.06.05.00.41.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 00:41:31 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A74CB1FF7E;
 Fri,  5 Jun 2020 08:41:30 +0100 (BST)
References: <20200604231716.11354-1-pbonzini@redhat.com>
User-agent: mu4e 1.5.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] docker: update Ubuntu to 20.04
In-reply-to: <20200604231716.11354-1-pbonzini@redhat.com>
Date: Fri, 05 Jun 2020 08:41:30 +0100
Message-ID: <87wo4m3qol.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Paolo Bonzini <pbonzini@redhat.com> writes:

> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  tests/docker/dockerfiles/ubuntu.docker | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/docker/dockerfiles/ubuntu.docker b/tests/docker/docker=
files/ubuntu.docker
> index eeb3b22bf2..43872417de 100644
> --- a/tests/docker/dockerfiles/ubuntu.docker
> +++ b/tests/docker/dockerfiles/ubuntu.docker
> @@ -9,7 +9,7 @@
>  # system won't pick up that it has changed.
>  #
>=20=20
> -FROM ubuntu:19.04
> +FROM ubuntu:20.04
>  ENV PACKAGES flex bison \
>      ccache \
>      clang \

Queued to next/various-fixes, thanks.

--=20
Alex Benn=C3=A9e

