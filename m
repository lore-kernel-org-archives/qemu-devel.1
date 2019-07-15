Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8DFCC76191
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 14:38:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76C56216C4
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 14:38:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NbxR3WlQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76C56216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hn27r-0004ud-Qk
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 10:38:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36986)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hn27h-0004SJ-KF
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 10:38:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hn27g-0002MA-Le
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 10:38:37 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38877)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hn27g-0002LP-ET
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 10:38:36 -0400
Received: by mail-wr1-x441.google.com with SMTP id g17so17385856wrr.5
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2019 07:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=ajHDS2lbYllGnG5aHUiawHju26MKJ1Wjkxgqh9xuxXk=;
 b=NbxR3WlQkRybzRtHaTlWQeXAuAxn29jMRSmK5xcft2VEbjJ9VixQifWjiHDobSXrT5
 l2jHi7D6syFBiJdoA0qwUpP54R67LLveodJQYj6wTMfEy/O4DvsawYpNSBoszhVht/p2
 VLdT/S1xAXrzCpX6jKUINRmckV95Qsm0xLJab9x6S1SuvYhGaUk679QlneGgVuP/RurR
 0YnRIeOkQSAVEYgfE/FG1mWoiOFPvqFKf1xoyiEIkOF1dUEqJVy56wkOiC873ymMsg3c
 BAiFFzwnvm5KecamsYEvLOYxWnbzR/XmmaqmGpvPN2GzkCh6WPExkt2oOAAmqmf0dz2j
 qNlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=ajHDS2lbYllGnG5aHUiawHju26MKJ1Wjkxgqh9xuxXk=;
 b=N5NCe38cro1KNL8LPRWsW4X9SrB2pOXSFqkYlxEHfrghopPRn0lYTOmMiifk1EtFC/
 eD7B6K0R7fWWaYmtNPhRgKZ++TOc1Eae7NEelktiQvAgGoABhYtwURlMcnDhI0D+ErOu
 lAL+BM+pqp3PdwDMg/kcdzpD+/O2PMvsLN1rNZjP34y43L6nLq229Mqaqn2qymb5Y71A
 czf6QUQ3vz3QNP/FL+D1s9/7Od5h9RuHq2CBlfPMuu32OFVT1Vh9w2Gx5jQfEtcw62jg
 zY7YzR0DY7lH9GkONQYkqdjA1SbwO85a0N2lQvYHhdC67ykW0LIh/DtfrlhqOmmY1fbU
 tG0g==
X-Gm-Message-State: APjAAAU+XvV5Eg+Nqa4PN/iznfJkViXRAwhmFUAqWRrEqnR1WEMTd0ku
 EnWt/EH2T24Izp78AWJh0ywNyA==
X-Google-Smtp-Source: APXvYqzxBvp9ukhljgLjv1AQe0kpT9p6GRai7jHesB32tEypVz7C36g3u8l8uM1E0deufBO4UVU9Ng==
X-Received: by 2002:a5d:6190:: with SMTP id j16mr17410188wru.49.1563201515020; 
 Mon, 15 Jul 2019 07:38:35 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id j17sm18992733wrb.35.2019.07.15.07.38.34
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 15 Jul 2019 07:38:34 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2DAAD1FF87;
 Mon, 15 Jul 2019 15:38:34 +0100 (BST)
References: <20190713143311.17620-1-marcandre.lureau@redhat.com>
 <20190713143311.17620-2-marcandre.lureau@redhat.com>
User-agent: mu4e 1.3.3; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
In-reply-to: <20190713143311.17620-2-marcandre.lureau@redhat.com>
Date: Mon, 15 Jul 2019 15:38:34 +0100
Message-ID: <87h87nuzv9.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [PATCH v3 1/6] docker.py: add --run-as-current-user
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
Cc: Fam Zheng <fam@euphon.net>, berrange@redhat.com, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, pbonzini@redhat.com,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Podman will need further tweaks.
>
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tests/docker/Makefile.include | 2 +-
>  tests/docker/docker.py        | 5 +++++
>  2 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
> index aaf5396b85..f4226b79d0 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -212,7 +212,7 @@ docker-run: docker-qemu-src
>  			"  COPYING $(EXECUTABLE) to $(IMAGE)"))
>  	$(call quiet-command,						\
>  		$(DOCKER_SCRIPT) run 					\
> -			$(if $(NOUSER),,-u $(shell id -u)) 		\
> +			$(if $(NOUSER),,--run-as-current-user) 		\
>  			--security-opt seccomp=3Dunconfined		\
>  			$(if $V,,--rm) 					\
>  			$(if $(DEBUG),-ti,)				\
> diff --git a/tests/docker/docker.py b/tests/docker/docker.py
> index 53a8c9c801..f15545aeea 100755
> --- a/tests/docker/docker.py
> +++ b/tests/docker/docker.py
> @@ -333,8 +333,13 @@ class RunCommand(SubCommand):
>      def args(self, parser):
>          parser.add_argument("--keep", action=3D"store_true",
>                              help=3D"Don't remove image when command comp=
letes")
> +        parser.add_argument("--run-as-current-user", action=3D"store_tru=
e",
> +                            help=3D"Run container using the current user=
's uid")
>
>      def run(self, args, argv):
> +        if args.run_as_current_user:
> +            uid =3D os.getuid()
> +            argv =3D [ "-u", str(uid) ] + argv
>          return Docker().run(argv, args.keep, quiet=3Dargs.quiet)


--
Alex Benn=C3=A9e

