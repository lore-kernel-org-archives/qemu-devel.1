Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C39C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 20:21:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33EA6206A2
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 20:21:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tqb1buDN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33EA6206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgDPy-0000Ws-EY
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 16:21:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36880)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jgDPN-00005y-VT
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 16:21:13 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33744)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jgDPM-0007lU-Hp
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 16:21:13 -0400
Received: by mail-wr1-x441.google.com with SMTP id l11so16759wru.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 13:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=qYBIGWgbg2K9CKfY4sy00VfVvZOkQcFErzcLj8bb9hw=;
 b=tqb1buDNgOZLJzCj+o+bbVM34uJEEHTmR27M/koBt78dZrGcKek/fvP7+3rqI1rnOQ
 TYxP+NwEiECyR8UEF/JkciFF72WE+6OBzg3irT+vLMRTXi5qgV9YloKHqmVGvEPD1shn
 8FaAv5v7eFxFg6Ws4KDdwwlM7yxJBIK9rAuJY3zSTRYDd9RP+PSVYXwUHRsNIulG9k5p
 2FF/6ps874Wgrhk4UIBna1//Ft4f21Yb1Q6E87OWTavBNQxmnYDhpirUjMrX3pFEVNOw
 LJuiuSQkK9NuD/utwlQShQc/kcwGqqmBT4IqW1iI3n7ynUJaEz2XHrf66cTe5ov2p3Lh
 vTXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=qYBIGWgbg2K9CKfY4sy00VfVvZOkQcFErzcLj8bb9hw=;
 b=GKAwdaZskh9QZ+SxHvIHvnQsjbBMBWmGKqAeBUI/eBsBw+u8+AEsfcvMkuHPVu0jdJ
 3TNp5tdxnGY98MxPjxbC8vosIDkyb/kQ2+5lqmn2L7Rik3jv/4TRfNkQvHkPL60QxI9B
 yfAaOhqRD8u4KwAZfd5z63G1x2BCG+Yb2N4R+tZyTCDQ0UAXb/DAGZ1tQoJ+qSuQyutc
 PKINz5On/mwg4FJz8e4MKE+C+UM9EeyncdSCUEn7IQaGzQJY+ZRs3d+QLA9CuKNKHVjo
 o47i4niSQYFE6XW4NiLkY48qBy2JyhFU7jdIpX6l1SbhgB8qW3Ud1abcp+EUbcI3hZkW
 nDvw==
X-Gm-Message-State: AOAM533xJWTHNicJu5pHj5KGIpukui8phAMYTIvLiuQv/4IzlStpDrnJ
 ksIRSJABAbxJiJOVe9Vu+5MsEQ==
X-Google-Smtp-Source: ABdhPJwE9un6H1gL/PZEDvG6j4LsBCR8wmeGyuTH6WDz13nNLUylFio4da2yNuorqwS+nsogQMQcng==
X-Received: by 2002:a5d:490f:: with SMTP id x15mr27521439wrq.259.1591129270704; 
 Tue, 02 Jun 2020 13:21:10 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q4sm1178186wma.47.2020.06.02.13.21.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2020 13:21:08 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1A3901FF7E;
 Tue,  2 Jun 2020 21:21:08 +0100 (BST)
References: <20200529132341.755-1-robert.foley@linaro.org>
 <20200529132341.755-9-robert.foley@linaro.org>
User-agent: mu4e 1.5.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH v1 09/12] tests/docker: Added docker build support for
 TSan.
In-reply-to: <20200529132341.755-9-robert.foley@linaro.org>
Date: Tue, 02 Jun 2020 21:21:08 +0100
Message-ID: <87zh9l5idn.fsf@linaro.org>
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
Cc: Fam Zheng <fam@euphon.net>, peter.puhov@linaro.org, cota@braap.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Robert Foley <robert.foley@linaro.org> writes:

> Added a new docker for ubuntu 20.04.
> This docker has support for Thread Sanitizer
> including one patch we need in one of the header files.
> https://github.com/llvm/llvm-project/commit/a72dc86cd
>
> This command will build with tsan enabled:
> make docker-test-build-ubuntu2004 V=3D1 TSAN=3D1
>
> Also added the TSAN suppresion file to disable certain
> cases of TSAN warnings.
>
> Cc: Fam Zheng <fam@euphon.net>
> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Robert Foley <robert.foley@linaro.org>
> ---
>  tests/docker/Makefile.include              |  2 +
>  tests/docker/common.rc                     | 19 +++++++
>  tests/docker/dockerfiles/ubuntu2004.docker | 65 ++++++++++++++++++++++
>  tests/tsan/blacklist.tsan                  | 10 ++++
>  tests/tsan/suppressions.tsan               | 14 +++++
>  5 files changed, 110 insertions(+)
>  create mode 100644 tests/docker/dockerfiles/ubuntu2004.docker
>  create mode 100644 tests/tsan/blacklist.tsan
>  create mode 100644 tests/tsan/suppressions.tsan
>
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
> index 43a8678688..e029e54b42 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -202,6 +202,7 @@ endif
>  	@echo '                         (default is 1)'
>  	@echo '    DEBUG=3D1              Stop and drop to shell in the created=
 container'
>  	@echo '                         before running the command.'
> +	@echo '    TSAN=3D1               Enable use of tsan during the
> build/test.'

I'd rather not pollute the build with another env flag, rather...

>  	@echo '    NETWORK=3D1            Enable virtual network interface with=
 default backend.'
>  	@echo '    NETWORK=3D$$BACKEND     Enable virtual network interface wit=
h $$BACKEND.'
>  	@echo '    NOUSER               Define to disable adding current user t=
o containers passwd.'
> @@ -239,6 +240,7 @@ docker-run: docker-qemu-src
>  			-e EXTRA_CONFIGURE_OPTS=3D"$(EXTRA_CONFIGURE_OPTS)" \
>  			-e V=3D$V -e J=3D$J -e DEBUG=3D$(DEBUG)		\
>  			-e SHOW_ENV=3D$(SHOW_ENV) 			\
> +	                $(if $(TSAN),,-e TSAN=3D$(TSAN))		        \
>  			$(if $(NOUSER),,				\
>  				-e CCACHE_DIR=3D/var/tmp/ccache 		\
>  				-v $(DOCKER_CCACHE_DIR):/var/tmp/ccache:z \
> diff --git a/tests/docker/common.rc b/tests/docker/common.rc
> index 02cd67a8c5..5df93c6326 100755
> --- a/tests/docker/common.rc
> +++ b/tests/docker/common.rc
> @@ -27,6 +27,25 @@ requires()
>=20=20
>  configure_qemu()
>  {
> +    if test -z "$TSAN"; then
> +        requires clang tsan
> +        echo "Including TSan Support"
> +        tsan_log_dir=3D"/tmp/qemu-test/build/tsan"
> +        mkdir -p $tsan_log_dir > /dev/null || true
> +        EXTRA_CONFIGURE_OPTS=3D"${EXTRA_CONFIGURE_OPTS} --enable-tsan \
> +                             --cc=3Dclang-10 --cxx=3Dclang++-10 \
> +                             --disable-werror --extra-cflags=3D-O0"
> +        # detect deadlocks is false currently simply because
> +        # TSan crashes immediately with deadlock detecter enabled.
> +        # We have maxed out the history size to get the best chance of f=
inding
> +        # warnings during testing.
> +        # Note, to get tsan to fail on warning, use exitcode=3D66 below.
> +        tsan_opts=3D"suppressions=3D/tmp/qemu-test/src/tests/tsan/suppre=
ssions.tsan\
> +                   detect_deadlocks=3Dfalse history_size=3D7\
> +                   halt_on_error=3D0 exitcode=3D0 verbose=3D5\
> +                   log_path=3D$tsan_log_dir/tsan_warnings.txt"
> +        export TSAN_OPTIONS=3D"$tsan_opts"
> +    fi

...I think it would be better to put this in it's own test (test-tsan?)

--=20
Alex Benn=C3=A9e

