Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F22F2C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 16:14:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4DF02071A
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 16:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dZUEmD7b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4DF02071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlEEb-0000YI-49
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 12:14:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58354)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jlEDj-00086G-Mb
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 12:13:55 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40245)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jlEDh-0005OT-SF
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 12:13:55 -0400
Received: by mail-wr1-x444.google.com with SMTP id h5so21416071wrc.7
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 09:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=bMHkAxgNTxYKcU6kkbpAAcX3OLtP0D+/btA28zgEp34=;
 b=dZUEmD7bB0r6ZH06gj8itcc6F03TuvWVs1NNpi+Zs/jzXZlcOkSxdQHMXcnHd8Bsnm
 qtRSiKpF15NrwlsNV+0I4Sqj5so6vimsLha4ojwiCqC00n7pBESjpoQKp8TXFPf5DFTk
 NsW/Rx5chNt/Op6cX963+ePk00RgUjkBnJ1SvykLMNlqViHwe+6IkDZhCb50Z9o3QekC
 SNf98cjXuvci306gXvq3i+2p0AQ9KNZ59wCwEDQFBTNZ4KfbSODqnYHtdOdDY6gfgVaw
 dtPWnvY2mkIrQt63nZeBbTZjdrqK+iw7pkN+uZgQ3FzNA7Fi6/nuxE5xQandcwwh6AF2
 b4lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=bMHkAxgNTxYKcU6kkbpAAcX3OLtP0D+/btA28zgEp34=;
 b=MJ5/WHM5q0aYozpdgnjY6NwPRAnEAjocSDZOcoXIlYIDDBFQgAdhULAyxwlfnHZop7
 bRbUFwZty3qRwVrPTqjYXRO8VXE3qzeXvlD2JbmuOY/B1QaAK/YMxG2/rywkd6vyPuRX
 mIa0zumataoR1TKn+1MF7rkF1QoYZ0jQcLbAlYu2SSJuuSZJ+voq5Qg+l2/CLaFGKhgb
 1QVeKIalWjbIpTbuc+W7/CToCGCJNGhiDU6qSeggTTOeN+7ZfUdR4xt9vHmWFI3/GedL
 o5gLKXJoQm/y99iP4ZnlaJeEpGUFcYHflvqtJxo0eyJG1QuwQkm9+CwkKeWY1b5jlCH1
 rVmQ==
X-Gm-Message-State: AOAM532ex6BcPbdGQ9ITv+RG9Klni4ML4kGDfFxVUn/CCAprmhhCuBW2
 2X3fYIEYxtJbVc9v/BhmfcrSNw==
X-Google-Smtp-Source: ABdhPJyVllK4hX9aSvBRzAxU35TuM5hgS86uJJNDddkS2nRWKejK+2ByUQ5msQhHm4Xrel+Hguu0aQ==
X-Received: by 2002:adf:e692:: with SMTP id r18mr3671884wrm.192.1592324031957; 
 Tue, 16 Jun 2020 09:13:51 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o10sm29218671wrj.37.2020.06.16.09.13.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 09:13:50 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2F2E61FF7E;
 Tue, 16 Jun 2020 17:13:50 +0100 (BST)
References: <20200604085441.103087-1-kbastian@mail.uni-paderborn.de>
 <20200604085441.103087-3-kbastian@mail.uni-paderborn.de>
User-agent: mu4e 1.5.3; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Subject: Re: [PATCH v2 02/15] tests/tcg: Add docker_as and docker_ld cmds
In-reply-to: <20200604085441.103087-3-kbastian@mail.uni-paderborn.de>
Date: Tue, 16 Jun 2020 17:13:50 +0100
Message-ID: <87eeqfyon5.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


Bastian Koppelmann <kbastian@mail.uni-paderborn.de> writes:

> At least for the TriCore target no easily available c compiler exists.
> Thus we need to rely on "as" and "ld". This allows us to run them
> through the docker image.
>
> Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> ---
>  tests/tcg/Makefile.qemu | 11 +++++++++++
>  tests/tcg/configure.sh  |  2 ++
>  2 files changed, 13 insertions(+)
>
> diff --git a/tests/tcg/Makefile.qemu b/tests/tcg/Makefile.qemu
> index 9c23aeaa2a..e5b3a4bacc 100644
> --- a/tests/tcg/Makefile.qemu
> +++ b/tests/tcg/Makefile.qemu
> @@ -50,11 +50,22 @@ DOCKER_COMPILE_CMD=3D"$(DOCKER_SCRIPT) cc \
>  		-i qemu:$(DOCKER_IMAGE) \
>  		-s $(SRC_PATH) -- "
>=20=20
> +DOCKER_AS_CMD=3D"$(DOCKER_SCRIPT) cc \
> +		--cc $(DOCKER_CROSS_AS_GUEST) \
> +		-i qemu:$(DOCKER_IMAGE) \
> +		-s $(SRC_PATH) -- "
> +
> +DOCKER_LD_CMD=3D"$(DOCKER_SCRIPT) cc \
> +		--cc $(DOCKER_CROSS_LD_GUEST) \
> +		-i qemu:$(DOCKER_IMAGE) \
> +		-s $(SRC_PATH) -- "
> +
>  .PHONY: docker-build-guest-tests
>  docker-build-guest-tests: docker-image-$(DOCKER_IMAGE)
>  	$(call quiet-command, \
>  	  (mkdir -p tests/tcg/$(TARGET) && cd tests/tcg/$(TARGET) && \
>  	   $(MAKE) -f $(TCG_MAKE) TARGET=3D"$(TARGET)" CC=3D$(DOCKER_COMPILE_CM=
D) \
> +			AS=3D$(DOCKER_AS_CMD) LD=3D$(DOCKER_LD_CMD) \
>  			SRC_PATH=3D"$(SRC_PATH)" BUILD_STATIC=3Dy \
>  			EXTRA_CFLAGS=3D"$(CROSS_CC_GUEST_CFLAGS)"), \
>  	"BUILD","$(TARGET) guest-tests with docker qemu:$(DOCKER_IMAGE)")
> diff --git a/tests/tcg/configure.sh b/tests/tcg/configure.sh
> index 2326f97856..6e8659d488 100755
> --- a/tests/tcg/configure.sh
> +++ b/tests/tcg/configure.sh
> @@ -242,6 +242,8 @@ for target in $target_list; do
>    if test $got_cross_cc =3D no && test "$container" !=3D no && test -n "=
$container_image"; then
>      echo "DOCKER_IMAGE=3D$container_image" >> $config_target_mak
>      echo "DOCKER_CROSS_CC_GUEST=3D$container_cross_cc" >> $config_target=
_mak
> +    echo "DOCKER_CROSS_AS_GUEST=3D$container_cross_as" >> $config_target=
_mak
> +    echo "DOCKER_CROSS_LD_GUEST=3D$container_cross_ld" >> $config_target=
_mak
>    fi
>  done

We should keep parity with locally installed tools though. Can we emit a
CROSS_LD_GUEST/CROSS_AS_GUEST for locally installed tools?

--=20
Alex Benn=C3=A9e

