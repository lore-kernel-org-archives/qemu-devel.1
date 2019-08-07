Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B7BC32751
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 13:09:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D5FF21E6B
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 13:09:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QvTeggDU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D5FF21E6B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvLhS-0004gC-R7
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 09:09:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53125)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hvLdc-0006Nk-P0
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 09:05:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hvLda-0007vP-Cv
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 09:05:56 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41648)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hvLdZ-0007sn-VR
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 09:05:54 -0400
Received: by mail-wr1-x443.google.com with SMTP id c2so88085655wrm.8
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 06:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=EfpKS3cpYGBt4UnRGzIZ21P5InRPamfiIhnMT9EYWyI=;
 b=QvTeggDUp2KJhJhJIU2VORZeFEWaBFltAaduh4VmgljzdBjbQEFmvgsdQ7sO7qPASl
 5aKwwqmcBqEeXIR8Pexg0JO6Cd8pGAOxGi+TPPMlv8od40Zqhz6A9+0xNyg8FZZVc0C/
 77uvNpFj5d4iortaatlsg9TrIrTzFeg5p3rAqjZ/s2c1EmX/jyFWwLa+q3EqKi5zb9Zi
 fv5mTLp4N/bsi2oYwhga3JrpsOPikWlEttW86jXJJNE1YKy7B0lbOouR4ri6MmHwwxPr
 lWoWhTCPhjUKCpFFmlXt4szm4E4uVueFH7swKgJyIfCNeck9uDMPOFFBSPzvOGz0780L
 xHHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=EfpKS3cpYGBt4UnRGzIZ21P5InRPamfiIhnMT9EYWyI=;
 b=fIg+9g++xVjMOt3QLOTt/ikXFU2MdYH7/dVWzvxyG7hTCRh2WznIeTxlhiZrYbZdrr
 9oqB2TGmjaHltUzwVPfR2kS8MN+9CF3SAuEY6NnNZIq+Cg0UuRdUPLG4UhX1bnmtRKHN
 OOxTVbtgtJWA9dj3poexrXQD5gQF5M+jTAk7Dg04jIlGrUSWbJhD0K0SUCIfuef/JMFZ
 87kc2uqTCHNRS+AvG/wjLm+UD2Jz5QXiia0SFojCt6pd5P95O0htqul6y2HPYlkqvwPk
 +B3d8YNZJ2QN6G38fkCvtmr3RUeTk77I4U/TKj3FidVR9H9MTdGYyEFqBMYOg2TjncHZ
 iYoQ==
X-Gm-Message-State: APjAAAXj31r4zy6OjBx5KCCrPC3h8lvSdffvsPfd3ZbWWLyD/KnmEOW1
 uoQcrDYhZ7g/ozQQNVGBQ3AkqsFCd5I=
X-Google-Smtp-Source: APXvYqwGR/XmdK2Ao7VQBjhXgyaW7QS08z9FJGR/9kFpIUbHbMGyZglce7RROIS1tV9wuxGVTcKaqg==
X-Received: by 2002:adf:ec0c:: with SMTP id x12mr10788250wrn.342.1565183152040; 
 Wed, 07 Aug 2019 06:05:52 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id h11sm5647180wrc.35.2019.08.07.06.05.51
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 07 Aug 2019 06:05:51 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id F3E231FF87;
 Wed,  7 Aug 2019 14:05:50 +0100 (BST)
References: <20190730123759.21723-1-pbonzini@redhat.com>
 <20190730123759.21723-3-pbonzini@redhat.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
In-reply-to: <20190730123759.21723-3-pbonzini@redhat.com>
Date: Wed, 07 Aug 2019 14:05:50 +0100
Message-ID: <87mugli0r5.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [PATCH 2/3] tests/tcg: cleanup Makefile inclusions
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

> Rename Makefile.probe to Makefile.prereqs and make it actually
> define rules for the tests.
>
> Rename Makefile to Makefile.target, since it is not a toplevel
> makefile.
>
> Rename Makefile.include to Makefile.qemu and disentangle it
> from the QEMU Makefile.target, so that it is invoked recursively
> by tests/Makefile.include.  Tests are now placed in
> tests/tcg/$(TARGET).
>
> Drop the usage of TARGET_BASE_ARCH, which is ignored by everything except
> x86_64 and aarch64.  Fix x86 tests by using -cpu max and, while
> at it, standardize on QEMU_OPTS for aarch64 tests too.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  Makefile.target                                |  3 --
>  tests/Makefile.include                         | 23 +++++++-----
>  tests/tcg/{Makefile.probe =3D> Makefile.prereqs} |  5 ++-
>  tests/tcg/{Makefile.include =3D> Makefile.qemu}  | 48 +++++++++++++++---=
--------
>  tests/tcg/{Makefile =3D> Makefile.target}        | 13 +++----
>  tests/tcg/aarch64/Makefile.target              | 12 ++++---
>  tests/tcg/arm/Makefile.softmmu-target          |  4 ---
>  tests/tcg/i386/Makefile.softmmu-target         |  8 -----
>  tests/tcg/i386/Makefile.target                 | 13 +++----
>  tests/tcg/x86_64/Makefile.softmmu-target       | 36 +++++++++++++++++++
>  tests/tcg/x86_64/Makefile.target               |  7 ++--
>  11 files changed, 100 insertions(+), 72 deletions(-)
>  rename tests/tcg/{Makefile.probe =3D> Makefile.prereqs} (92%)
>  rename tests/tcg/{Makefile.include =3D> Makefile.qemu} (52%)
>  rename tests/tcg/{Makefile =3D> Makefile.target} (92%)
>  create mode 100644 tests/tcg/x86_64/Makefile.softmmu-target
>
> diff --git a/Makefile.target b/Makefile.target
> index 933b274..5e91623 100644
> --- a/Makefile.target
> +++ b/Makefile.target
> @@ -39,9 +39,6 @@ endif
>  PROGS=3D$(QEMU_PROG) $(QEMU_PROGW)
>  STPFILES=3D
>
> -# Makefile Tests
> -include $(SRC_PATH)/tests/tcg/Makefile.include
> -

So this looses the ability to run:

  make run-guest-tests

in any given build directory. It would be useful to have a target that
could still get us there.

>  config-target.h: config-target.h-timestamp
>  config-target.h-timestamp: config-target.mak
>
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index fd7fdb8..8bb5c97 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -1061,23 +1061,28 @@ RUN_TCG_TARGET_RULES=3D$(patsubst %,run-tcg-tests=
-%, $(TARGET_DIRS))
>  ifeq ($(HAVE_USER_DOCKER),y)
>  # Probe for the Docker Builds needed for each build
>  $(foreach PROBE_TARGET,$(TARGET_DIRS), 				\
> -	$(eval -include $(SRC_PATH)/tests/tcg/Makefile.probe) 	\
> -	$(if $(DOCKER_PREREQ), 					\
> -		$(eval build-tcg-tests-$(PROBE_TARGET): $(DOCKER_PREREQ))))
> +	$(eval -include $(SRC_PATH)/tests/tcg/Makefile.prereqs))
>  endif
>
>  build-tcg-tests-%:
> -	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $* V=3D"$(V)" \
> -		SKIP_DOCKER_BUILD=3D1 TARGET_DIR=3D"$*/" guest-tests, \
> +	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) \
> +		-f $(SRC_PATH)/tests/tcg/Makefile.qemu \
> +		SRC_PATH=3D$(SRC_PATH) \
> +	       	V=3D"$(V)" TARGET_DIR=3D"$*/" guest-tests, \
>  		"BUILD", "TCG tests for $*")
>
> -run-tcg-tests-%: % build-tcg-tests-%
> -	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $* V=3D"$(V)" \
> -		SKIP_DOCKER_BUILD=3D1 TARGET_DIR=3D"$*/" run-guest-tests, \
> +run-tcg-tests-%: build-tcg-tests-% %/all
> +	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) \
> +		-f $(SRC_PATH)/tests/tcg/Makefile.qemu \
> +		SRC_PATH=3D$(SRC_PATH) SPEED=3D"$(SPEED)" \
> +		V=3D"$(V)" TARGET_DIR=3D"$*/" run-guest-tests, \
>  		"RUN", "TCG tests for $*")
>
>  clean-tcg-tests-%:
> -	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $* V=3D"$(V)" TARGE=
T_DIR=3D"$*/" clean-guest-tests,)
> +	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) \
> +		-f $(SRC_PATH)/tests/tcg/Makefile.qemu \
> +		SRC_PATH=3D$(SRC_PATH) TARGET_DIR=3D"$*/" clean-guest-tests, \
> +		"RUN", "TCG tests for $*")
>
>  .PHONY: build-tcg
>  build-tcg: $(BUILD_TCG_TARGET_RULES)
> diff --git a/tests/tcg/Makefile.probe b/tests/tcg/Makefile.prereqs
> similarity index 92%
> rename from tests/tcg/Makefile.probe
> rename to tests/tcg/Makefile.prereqs
> index 9dc6546..53b0196 100644
> --- a/tests/tcg/Makefile.probe
> +++ b/tests/tcg/Makefile.prereqs
> @@ -8,20 +8,19 @@
>  # each target.
>
>  # First we need the target makefile which tells us the target architectu=
re
> +CROSS_CC_GUEST:=3D
>  -include $(BUILD_DIR)/$(PROBE_TARGET)/config-target.mak
>
>  # Then we load up the target architecture makefiles which tell us
>  # about the compilers
> -CROSS_CC_GUEST:=3D
>  DOCKER_IMAGE:=3D
> -DOCKER_PREREQ:=3D
>
>  -include $(SRC_PATH)/tests/tcg/$(TARGET_BASE_ARCH)/Makefile.include
>  -include $(SRC_PATH)/tests/tcg/$(TARGET_NAME)/Makefile.include
>
>  ifndef CROSS_CC_GUEST
>  ifneq ($(DOCKER_IMAGE),)
> -DOCKER_PREREQ:=3Ddocker-image-$(DOCKER_IMAGE)
> +build-tcg-tests-$(PROBE_TARGET): docker-image-$(DOCKER_IMAGE)
>  endif
>  endif
>
> diff --git a/tests/tcg/Makefile.include b/tests/tcg/Makefile.qemu
> similarity index 52%
> rename from tests/tcg/Makefile.include
> rename to tests/tcg/Makefile.qemu
> index 73b5626..d3f3437 100644
> --- a/tests/tcg/Makefile.include
> +++ b/tests/tcg/Makefile.qemu
> @@ -2,20 +2,23 @@
>  #
>  # TCG tests (per-target rules)
>  #
> -# This Makefile fragment is included from the per-target
> -# Makefile.target so will be invoked for each linux-user program we
> -# build. We have two options for compiling, either using a configured
> -# guest compiler or calling one of our docker images to do it for us.
> +# This Makefile fragment is included from the build-tcg target, once
> +# for each target we build. We have two options for compiling, either
> +# using a configured guest compiler or calling one of our docker images
> +# to do it for us.
>  #
>
>  # The per ARCH makefile, if it exists, holds extra information about
>  # useful docker images or alternative compiler flags.
>
> --include $(SRC_PATH)/tests/tcg/$(TARGET_BASE_ARCH)/Makefile.include
> --include $(SRC_PATH)/tests/tcg/$(TARGET_NAME)/Makefile.include
> +include $(TARGET_DIR)config-target.mak
> +include $(SRC_PATH)/rules.mak
> +include $(wildcard \
> +	$(SRC_PATH)/tests/tcg/$(TARGET_BASE_ARCH)/Makefile.include \
> +	$(SRC_PATH)/tests/tcg/$(TARGET_NAME)/Makefile.include)
>
>  GUEST_BUILD=3D
> -TCG_MAKE=3D$(SRC_PATH)/tests/tcg/Makefile
> +TCG_MAKE=3D../Makefile.target
>  # Support installed Cross Compilers
>
>  ifdef CROSS_CC_GUEST
> @@ -23,9 +26,9 @@ ifdef CROSS_CC_GUEST
>  .PHONY: cross-build-guest-tests
>  cross-build-guest-tests:
>  	$(call quiet-command, \
> -	   (mkdir -p tests && cd tests && \
> -	    $(MAKE) -f $(TCG_MAKE) CC=3D$(CROSS_CC_GUEST) \
> -			BUILD_STATIC=3D$(CROSS_CC_GUEST_STATIC) \
> +	   (mkdir -p tests/tcg/$(TARGET_DIR) && cd tests/tcg/$(TARGET_DIR) && \
> +	    $(MAKE) -f $(TCG_MAKE) TARGET_DIR=3D"$(TARGET_DIR)" CC=3D"$(CROSS_C=
C_GUEST)" \
> +			SRC_PATH=3D"$(SRC_PATH)" BUILD_STATIC=3D$(CROSS_CC_GUEST_STATIC) \
>  			EXTRA_CFLAGS=3D$(CROSS_CC_GUEST_CFLAGS)), \
>  	"BUILD","$(TARGET_NAME) guest-tests with $(CROSS_CC_GUEST)")
>
> @@ -39,20 +42,20 @@ ifeq ($(HAVE_USER_DOCKER)$(GUEST_BUILD),y)
>  ifneq ($(DOCKER_IMAGE),)
>
>  # We also need the Docker make rules to depend on
> +SKIP_DOCKER_BUILD=3D1
>  include $(SRC_PATH)/tests/docker/Makefile.include
>
>  DOCKER_COMPILE_CMD=3D"$(DOCKER_SCRIPT) cc --user $(shell id -u) \
>  		--cc $(DOCKER_CROSS_COMPILER) \
>  		-i qemu:$(DOCKER_IMAGE) \
>  		-s $(SRC_PATH) -- "
> -DOCKER_PREREQ=3Ddocker-image-$(DOCKER_IMAGE)
>
>  .PHONY: docker-build-guest-tests
> -docker-build-guest-tests: $(DOCKER_PREREQ)
> +docker-build-guest-tests: docker-image-$(DOCKER_IMAGE)
>  	$(call quiet-command, \
> -	  (mkdir -p tests && cd tests && \
> -	   $(MAKE) -f $(TCG_MAKE) CC=3D$(DOCKER_COMPILE_CMD) \
> -			BUILD_STATIC=3Dy \
> +	  (mkdir -p tests/tcg/$(TARGET_DIR) && cd tests/tcg/$(TARGET_DIR) && \
> +	   $(MAKE) -f $(TCG_MAKE) TARGET_DIR=3D"$(TARGET_DIR)" CC=3D$(DOCKER_CO=
MPILE_CMD) \
> +			SRC_PATH=3D"$(SRC_PATH)" BUILD_STATIC=3Dy \
>  			EXTRA_CFLAGS=3D$(DOCKER_CROSS_COMPILER_CFLAGS)), \
>  	"BUILD","$(TARGET_NAME) guest-tests with docker qemu:$(DOCKER_IMAGE)")
>
> @@ -62,27 +65,32 @@ endif
>  endif
>
>  # Final targets
> +all:
> +	@echo "Do not invoke this Makefile directly"; exit 1
> +
>  .PHONY: guest-tests
>
>  ifneq ($(GUEST_BUILD),)
>  guest-tests: $(GUEST_BUILD)
>
> -run-guest-tests: guest-tests qemu-$(subst y,system-,$(CONFIG_SOFTMMU))$(=
TARGET_NAME)
> +run-guest-tests: guest-tests
>  	$(call quiet-command, \
> -	(cd tests && $(MAKE) -f $(TCG_MAKE) SPEED=3D$(SPEED) run), \
> +	(cd tests/tcg/$(TARGET_DIR) && \
> +	 $(MAKE) -f $(TCG_MAKE) TARGET_DIR=3D"$(TARGET_DIR)" \
> +	 		SRC_PATH=3D"$(SRC_PATH)" SPEED=3D$(SPEED) run), \
>  	"RUN", "tests for $(TARGET_NAME)")
>
>  else
>  guest-tests:
>  	$(call quiet-command, /bin/true, "BUILD", \
> -		"$(TARGET_NAME) guest-tests SKIPPED")
> +		"$(TARGET_DIR) guest-tests SKIPPED")
>
>  run-guest-tests:
>  	$(call quiet-command, /bin/true, "RUN", \
> -		"tests for $(TARGET_NAME) SKIPPED")
> +		"tests for $(TARGET_DIR) SKIPPED")
>  endif
>
>  # It doesn't matter if these don't exits
>  .PHONY: clean-guest-tests
>  clean-guest-tests:
> -	rm -rf tests || echo "no $(TARGET_NAME) tests to remove"
> +	rm -rf tests/tcg/$(TARGET_DIR)
> diff --git a/tests/tcg/Makefile b/tests/tcg/Makefile.target
> similarity index 92%
> rename from tests/tcg/Makefile
> rename to tests/tcg/Makefile.target
> index 9f56768..8dbcba4 100644
> --- a/tests/tcg/Makefile
> +++ b/tests/tcg/Makefile.target
> @@ -29,8 +29,9 @@
>  # We also expect to be in the tests build dir for the FOO-(linux-user|so=
ftmmu).
>  #
>
> +all:
>  -include ../../config-host.mak
> --include ../config-target.mak
> +-include ../../../$(TARGET_DIR)/config-target.mak
>
>  # for including , in command strings
>  COMMA :=3D ,
> @@ -64,9 +65,9 @@ LDFLAGS=3D
>
>  # The QEMU for this TARGET
>  ifdef CONFIG_USER_ONLY
> -QEMU=3D../qemu-$(TARGET_NAME)
> +QEMU=3D../../../$(TARGET_DIR)/qemu-$(TARGET_NAME)
>  else
> -QEMU=3D../qemu-system-$(TARGET_NAME)
> +QEMU=3D../../../$(TARGET_DIR)/qemu-system-$(TARGET_NAME)
>  endif
>  QEMU_OPTS=3D
>
> @@ -82,10 +83,7 @@ ifdef CONFIG_USER_ONLY
>  # The order we include is important. We include multiarch, base arch
>  # and finally arch if it's not the same as base arch.
>  -include $(SRC_PATH)/tests/tcg/multiarch/Makefile.target
> --include $(SRC_PATH)/tests/tcg/$(TARGET_BASE_ARCH)/Makefile.target
> -ifneq ($(TARGET_BASE_ARCH),$(TARGET_NAME))
>  -include $(SRC_PATH)/tests/tcg/$(TARGET_NAME)/Makefile.target
> -endif

Comment above needs fixing up.

>
>  # Add the common build options
>  CFLAGS+=3D-Wall -O0 -g -fno-strict-aliasing
> @@ -101,10 +99,7 @@ else
>  # are expected to provide their own build recipes.
>  -include $(SRC_PATH)/tests/tcg/minilib/Makefile.target
>  -include $(SRC_PATH)/tests/tcg/multiarch/system/Makefile.softmmu-target
> --include $(SRC_PATH)/tests/tcg/$(TARGET_BASE_ARCH)/Makefile.softmmu-targ=
et
> -ifneq ($(TARGET_BASE_ARCH),$(TARGET_NAME))
>  -include $(SRC_PATH)/tests/tcg/$(TARGET_NAME)/Makefile.softmmu-target
> -endif
>
>  endif
>
> diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefi=
le.target
> index 31ba9cf..e763dd9 100644
> --- a/tests/tcg/aarch64/Makefile.target
> +++ b/tests/tcg/aarch64/Makefile.target
> @@ -2,12 +2,14 @@
>  #
>  # AArch64 specific tweaks
>
> +ARM_SRC=3D$(SRC_PATH)/tests/tcg/arm
> +VPATH 		+=3D $(ARM_SRC)
> +
>  AARCH64_SRC=3D$(SRC_PATH)/tests/tcg/aarch64
>  VPATH 		+=3D $(AARCH64_SRC)
>
> -# we don't build any of the ARM tests
> -AARCH64_TESTS=3D$(filter-out $(ARM_TESTS), $(TESTS))
> -AARCH64_TESTS+=3Dfcvt
> +# we don't build any other ARM test
> +AARCH64_TESTS=3Dfcvt
>
>  fcvt: LDFLAGS+=3D-lm
>
> @@ -16,6 +18,6 @@ run-fcvt: fcvt
>  	$(call diff-out,$<,$(AARCH64_SRC)/fcvt.ref)
>
>  AARCH64_TESTS +=3D pauth-1 pauth-2
> -run-pauth-%: QEMU +=3D -cpu max
> +run-pauth-%: QEMU_OPTS +=3D -cpu max
>
> -TESTS:=3D$(AARCH64_TESTS)
> +TESTS +=3D $(AARCH64_TESTS)
> diff --git a/tests/tcg/arm/Makefile.softmmu-target b/tests/tcg/arm/Makefi=
le.softmmu-target
> index 2deb06e..231e9a5 100644
> --- a/tests/tcg/arm/Makefile.softmmu-target
> +++ b/tests/tcg/arm/Makefile.softmmu-target
> @@ -3,8 +3,6 @@
>  # ARM SoftMMU tests - included from tests/tcg/Makefile
>  #
>
> -ifeq ($(TARGET_ABI_DIR),arm)
> -
>  ARM_SRC=3D$(SRC_PATH)/tests/tcg/arm
>
>  # Set search path for all sources
> @@ -25,5 +23,3 @@ LDFLAGS+=3D-nostdlib -N -static
>  test-armv6m-undef: EXTRA_CFLAGS+=3D-mcpu=3Dcortex-m0
>
>  run-test-armv6m-undef: QEMU_OPTS+=3D-semihosting -M microbit -kernel
> -
> -endif
> diff --git a/tests/tcg/i386/Makefile.softmmu-target b/tests/tcg/i386/Make=
file.softmmu-target
> index cee3420..1c8790e 100644
> --- a/tests/tcg/i386/Makefile.softmmu-target
> +++ b/tests/tcg/i386/Makefile.softmmu-target
> @@ -12,17 +12,9 @@ X64_SYSTEM_SRC=3D$(SRC_PATH)/tests/tcg/x86_64/system
>  # These objects provide the basic boot code and helper functions for all=
 tests
>  CRT_OBJS=3Dboot.o
>
> -ifeq ($(TARGET_X86_64), y)
> -CRT_PATH=3D$(X64_SYSTEM_SRC)
> -CFLAGS=3D-march=3Dx86-64
> -LINK_SCRIPT=3D$(X64_SYSTEM_SRC)/kernel.ld
> -LDFLAGS=3D-Wl,-T$(LINK_SCRIPT) -Wl,-melf_x86_64
> -else
>  CRT_PATH=3D$(I386_SYSTEM_SRC)
> -CFLAGS+=3D-m32
>  LINK_SCRIPT=3D$(I386_SYSTEM_SRC)/kernel.ld
>  LDFLAGS=3D-Wl,-T$(LINK_SCRIPT) -Wl,-melf_i386
> -endif
>  CFLAGS+=3D-nostdlib -ggdb -O0 $(MINILIB_INC)
>  LDFLAGS+=3D-static -nostdlib $(CRT_OBJS) $(MINILIB_OBJS) -lgcc
>
> diff --git a/tests/tcg/i386/Makefile.target b/tests/tcg/i386/Makefile.tar=
get
> index d0eb702..08c5736 100644
> --- a/tests/tcg/i386/Makefile.target
> +++ b/tests/tcg/i386/Makefile.target
> @@ -6,14 +6,11 @@ I386_SRC=3D$(SRC_PATH)/tests/tcg/i386
>  VPATH 		+=3D $(I386_SRC)
>
>  I386_SRCS=3D$(notdir $(wildcard $(I386_SRC)/*.c))
> -I386_TESTS=3D$(I386_SRCS:.c=3D)
> -I386_ONLY_TESTS=3D$(filter-out test-i386-ssse3, $(I386_TESTS))
> +ALL_X86_TESTS=3D$(I386_SRCS:.c=3D)
> +I386_TESTS:=3D$(filter-out test-i386-ssse3, $(ALL_X86_TESTS))
> +X86_64_TESTS:=3D$(filter test-i386-ssse3, $(ALL_X86_TESTS))
>  # Update TESTS
> -TESTS+=3D$(I386_ONLY_TESTS)
> -
> -ifneq ($(TARGET_NAME),x86_64)
> -CFLAGS+=3D-m32
> -endif
> +TESTS=3D$(MULTIARCH_TESTS) $(I386_TESTS)
>
>  #
>  # hello-i386 is a barebones app
> @@ -26,7 +23,7 @@ hello-i386: LDFLAGS+=3D-nostdlib
>  #
>
>  test-i386: test-i386.c test-i386-code16.S test-i386-vm86.S test-i386.h t=
est-i386-shift.h test-i386-muldiv.h
> -	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ \
> +	$(CC) $(CFLAGS) $(LDFLAGS) $(EXTRA_CFLAGS) -o $@ \
>  	   $(<D)/test-i386.c $(<D)/test-i386-code16.S $(<D)/test-i386-vm86.S -lm
>
>  ifeq ($(SPEED), slow)
> diff --git a/tests/tcg/x86_64/Makefile.softmmu-target b/tests/tcg/x86_64/=
Makefile.softmmu-target
> new file mode 100644
> index 0000000..df252e7
> --- /dev/null
> +++ b/tests/tcg/x86_64/Makefile.softmmu-target
> @@ -0,0 +1,36 @@
> +#
> +# x86 system tests
> +#
> +# This currently builds only for i386. The common C code is built
> +# with standard compiler flags however so we can support both by
> +# adding additional boot files for x86_64.
> +#
> +
> +I386_SYSTEM_SRC=3D$(SRC_PATH)/tests/tcg/i386/system

I think this is redundant now...

> +X64_SYSTEM_SRC=3D$(SRC_PATH)/tests/tcg/x86_64/system
> +
> +# These objects provide the basic boot code and helper functions for all=
 tests
> +CRT_OBJS=3Dboot.o
> +
> +CRT_PATH=3D$(X64_SYSTEM_SRC)
> +LINK_SCRIPT=3D$(X64_SYSTEM_SRC)/kernel.ld
> +LDFLAGS=3D-Wl,-T$(LINK_SCRIPT) -Wl,-melf_x86_64
> +CFLAGS+=3D-nostdlib -ggdb -O0 $(MINILIB_INC)
> +LDFLAGS+=3D-static -nostdlib $(CRT_OBJS) $(MINILIB_OBJS) -lgcc
> +
> +TESTS+=3D$(MULTIARCH_TESTS)
> +
> +# building head blobs
> +.PRECIOUS: $(CRT_OBJS)
> +
> +%.o: $(CRT_PATH)/%.S
> +	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -c $< -o $@
> +
> +# Build and link the tests
> +%: %.c $(LINK_SCRIPT) $(CRT_OBJS) $(MINILIB_OBJS)
> +	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
> +
> +memory: CFLAGS+=3D-DCHECK_UNALIGNED=3D1
> +
> +# Running
> +QEMU_OPTS+=3D-device isa-debugcon,chardev=3Doutput -device isa-debug-exi=
t,iobase=3D0xf4,iosize=3D0x4 -kernel
> diff --git a/tests/tcg/x86_64/Makefile.target b/tests/tcg/x86_64/Makefile=
.target
> index 74f170b..20bf962 100644
> --- a/tests/tcg/x86_64/Makefile.target
> +++ b/tests/tcg/x86_64/Makefile.target
> @@ -6,9 +6,10 @@
>  # $(SRC)/tests/tcg/i386/
>  #
>
> -X86_64_TESTS=3D$(filter-out $(I386_ONLY_TESTS), $(TESTS))
> -X86_64_TESTS+=3Dtest-x86_64
> -TESTS:=3D$(X86_64_TESTS)
> +include $(SRC_PATH)/tests/tcg/i386/Makefile.target
> +
> +TESTS=3D$(MULTIARCH_TESTS) $(X86_64_TESTS) test-x86_64
> +QEMU_OPTS +=3D -cpu max
>
>  test-x86_64: LDFLAGS+=3D-lm -lc
>  test-x86_64: test-i386.c test-i386.h test-i386-shift.h test-i386-muldiv.h


--
Alex Benn=C3=A9e

