Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A93BC32751
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 13:11:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 564E321E6B
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 13:11:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V70mvRPF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 564E321E6B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvLis-0007if-Lg
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 09:11:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54317)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hvLiJ-0006R1-6T
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 09:10:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hvLiH-0003DY-LK
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 09:10:47 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42215)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hvLiH-0003Ca-EO
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 09:10:45 -0400
Received: by mail-wr1-x441.google.com with SMTP id x1so41430801wrr.9
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 06:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=TqZvb6/RcZfca07vu0Qsu5ZSe13HcGsM4Zu5AipDN/k=;
 b=V70mvRPF7bJBmuJ9v9v5NDzcXLl8tA0Q4ghQBYOPngSKMy6XGyt3aHg6HLpxLfylMx
 jGhzo/geS5WMFpyYDMXO7coFRKIFXw64Rjr1UfTxIaD/HSFDCY6UYWt+GGVd71h33dIx
 oHIBp4Xd2JY+rUQ9CPNhDcBhlb6V8HtMfrRy1zBnAcmd1GxXGW5P5hhzeKUJuNaLMJb2
 GipbgbCwUuZZPPbu5okXF1sJfLuApdVzhE017h0q0OCgicOdeq9YP9Nma0ofAXdDELh6
 OFwK7extEevOUmpV6zvKLR8rY0vQtocVros5fPXAran6WxIncclO6M8/0QI5stz6gu7I
 2Wpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=TqZvb6/RcZfca07vu0Qsu5ZSe13HcGsM4Zu5AipDN/k=;
 b=PW87gmNcOuw3g+3s6Am5J79bre3bKKXE9Nh2VCL0okeFtxycphSdT1gNlJxHqw7O/X
 GhEBDkEY8O4VgcD6o1FZDamD4iCCNkCgWAnnfc6F58l0W6yrS5giSVQOrp6u9f5BN6NC
 a9NtM91n2QCM5DeCIvomvgjHxQ9fGH+YZF6ZM6jPgxpd3g4A8UhP8CJT2Jp9ZT9PD/gj
 DVVpuCt0x4XP9xuphsMZx8nBZvw0bKr+dZdJTvHFCLF9+tBcB7IhQlfzbAoEUhTfPzLM
 g4QlinV9IUIDouD0hEa2XdIf2q2pRqvs8EG5XdXSfIjSiM0AXdc2EHiYe6L/Z4VCE5m+
 GZuw==
X-Gm-Message-State: APjAAAUNakyg/wmHf1vpF9Esq6Gend0ycNpRMfwc2QqRPrin3gvjVq7/
 aaWsNXitPH9doo0wWfK7K9qZu/r8y78=
X-Google-Smtp-Source: APXvYqwJslF48u7VIwW+/dlk5oAnglufUWxKZ92HOejf5TzbTEcLA9xWYf3aiPORP1Sks//kmtD5og==
X-Received: by 2002:a5d:4cca:: with SMTP id c10mr10461040wrt.233.1565183443679; 
 Wed, 07 Aug 2019 06:10:43 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id c7sm84491738wro.70.2019.08.07.06.10.43
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 07 Aug 2019 06:10:43 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BCA081FF87;
 Wed,  7 Aug 2019 14:10:42 +0100 (BST)
References: <20190730123759.21723-1-pbonzini@redhat.com>
 <20190730123759.21723-4-pbonzini@redhat.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
In-reply-to: <20190730123759.21723-4-pbonzini@redhat.com>
Date: Wed, 07 Aug 2019 14:10:42 +0100
Message-ID: <87lfw5i0j1.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [PATCH 3/3] tests/tcg: move configuration to a
 sub-shell script
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

> Avoid the repeated inclusions of config-target.mak, which have
> risks of namespace pollution, and instead build minimal configuration
> files in a configuration script.  The same configuration files can
> also be included in Makefile and Makefile.qemu
>
<snip>
>  if [ "$fdt" =3D "git" ]; then
>    echo "config-host.h: dtc/all" >> $config_host_mak
>  fi
> @@ -7923,15 +7799,14 @@ fi
>  # so the build tree will be missing the link back to the new file, and
>  # tests might fail. Prefer to keep the relevant files in their own
>  # directory and symlink the directory instead.
> -DIRS=3D"tests tests/tcg tests/tcg/cris tests/tcg/lm32 tests/libqos tests=
/qapi-schema tests/tcg/xtensa tests/qemu-iotests tests/vm"
> +DIRS=3D"tests tests/tcg tests/tcg/lm32 tests/libqos tests/qapi-schema te=
sts/qemu-iotests tests/vm"
>  DIRS=3D"$DIRS tests/fp tests/qgraph"
>  DIRS=3D"$DIRS docs docs/interop fsdev scsi"
>  DIRS=3D"$DIRS pc-bios/optionrom pc-bios/spapr-rtas pc-bios/s390-ccw"
>  DIRS=3D"$DIRS roms/seabios roms/vgabios"
> -LINKS=3D"Makefile tests/tcg/Makefile"
> -LINKS=3D"$LINKS tests/tcg/cris/Makefile tests/tcg/cris/.gdbinit"
> -LINKS=3D"$LINKS tests/tcg/lm32/Makefile tests/tcg/xtensa/Makefile po/Mak=
efile"
> -LINKS=3D"$LINKS tests/fp/Makefile"
> +LINKS=3D"Makefile"
> +LINKS=3D"$LINKS tests/tcg/lm32/Makefile po/Makefile"
> +LINKS=3D"$LINKS tests/tcg/Makefile.target tests/fp/Makefile"

Is this why I get complaints on a clean tree:


  libpmem support   no
  libudev           yes
  default devices   yes
  /home/alex/lsrc/qemu.git/tests/tcg/configure.sh: 179: /home/alex/lsrc/qem=
u.git/tests/tcg/configure.sh: cannot create tests/tcg/config-aarch64-linux-=
user.mak: Directory nonexistent
  /home/alex/lsrc/qemu.git/tests/tcg/configure.sh: 180: /home/alex/lsrc/qem=
u.git/tests/tcg/configure.sh: cannot create tests/tcg/config-aarch64-linux-=
user.mak: Directory nonexistent
  /home/alex/lsrc/qemu.git/tests/tcg/configure.sh: 183: /home/alex/lsrc/qem=
u.git/tests/tcg/configure.sh: cannot create tests/tcg/config-aarch64-linux-=
user.mak: Directory nonexistent
  /home/alex/lsrc/qemu.git/tests/tcg/configure.sh: 184: /home/alex/lsrc/qem=
u.git/tests/tcg/configure.sh: cannot create tests/tcg/config-aarch64-linux-=
user.mak: Directory nonexistent
  /home/alex/lsrc/qemu.git/tests/tcg/configure.sh: 193: /home/alex/lsrc/qem=
u.git/tests/tcg/configure.sh: cannot create tests/tcg/config-aarch64-linux-=
user.mak: Directory nonexistent
  /home/alex/lsrc/qemu.git/tests/tcg/configure.sh: 213: /home/alex/lsrc/qem=
u.git/tests/tcg/configure.sh: cannot create tests/tcg/config-aarch64-linux-=
user.mak: Directory nonexistent
  /home/alex/lsrc/qemu.git/tests/tcg/configure.sh: 179: /home/alex/lsrc/qem=
u.git/tests/tcg/configure.sh: cannot create tests/tcg/config-arm-linux-user=
.mak: Directory nonexist
  ...


>  LINKS=3D"$LINKS pc-bios/optionrom/Makefile pc-bios/keymaps"
>  LINKS=3D"$LINKS pc-bios/spapr-rtas/Makefile"
>  LINKS=3D"$LINKS pc-bios/s390-ccw/Makefile"
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 8bb5c97..a3ee649 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -1058,30 +1058,28 @@ BUILD_TCG_TARGET_RULES=3D$(patsubst %,build-tcg-t=
ests-%, $(TARGET_DIRS))
>  CLEAN_TCG_TARGET_RULES=3D$(patsubst %,clean-tcg-tests-%, $(TARGET_DIRS))
>  RUN_TCG_TARGET_RULES=3D$(patsubst %,run-tcg-tests-%, $(TARGET_DIRS))
>
> -ifeq ($(HAVE_USER_DOCKER),y)
>  # Probe for the Docker Builds needed for each build
>  $(foreach PROBE_TARGET,$(TARGET_DIRS), 				\
>  	$(eval -include $(SRC_PATH)/tests/tcg/Makefile.prereqs))
> -endif
>
>  build-tcg-tests-%:
>  	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) \
>  		-f $(SRC_PATH)/tests/tcg/Makefile.qemu \
>  		SRC_PATH=3D$(SRC_PATH) \
> -	       	V=3D"$(V)" TARGET_DIR=3D"$*/" guest-tests, \
> +	       	V=3D"$(V)" TARGET=3D"$*" guest-tests, \
>  		"BUILD", "TCG tests for $*")
>
>  run-tcg-tests-%: build-tcg-tests-% %/all
>  	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) \
>  		-f $(SRC_PATH)/tests/tcg/Makefile.qemu \
>  		SRC_PATH=3D$(SRC_PATH) SPEED=3D"$(SPEED)" \
> -		V=3D"$(V)" TARGET_DIR=3D"$*/" run-guest-tests, \
> +		V=3D"$(V)" TARGET=3D"$*" run-guest-tests, \
>  		"RUN", "TCG tests for $*")
>
>  clean-tcg-tests-%:
>  	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) \
>  		-f $(SRC_PATH)/tests/tcg/Makefile.qemu \
> -		SRC_PATH=3D$(SRC_PATH) TARGET_DIR=3D"$*/" clean-guest-tests, \
> +		SRC_PATH=3D$(SRC_PATH) TARGET=3D"$*" clean-guest-tests, \
>  		"RUN", "TCG tests for $*")
>
>  .PHONY: build-tcg
> diff --git a/tests/tcg/Makefile.prereqs b/tests/tcg/Makefile.prereqs
> index 53b0196..7494b31 100644
> --- a/tests/tcg/Makefile.prereqs
> +++ b/tests/tcg/Makefile.prereqs
> @@ -7,24 +7,12 @@
>  # selection of required docker targets before we invoke a sub-make for
>  # each target.
>
> -# First we need the target makefile which tells us the target architectu=
re
> -CROSS_CC_GUEST:=3D
> --include $(BUILD_DIR)/$(PROBE_TARGET)/config-target.mak
> -
> -# Then we load up the target architecture makefiles which tell us
> -# about the compilers
>  DOCKER_IMAGE:=3D
>
> --include $(SRC_PATH)/tests/tcg/$(TARGET_BASE_ARCH)/Makefile.include
> --include $(SRC_PATH)/tests/tcg/$(TARGET_NAME)/Makefile.include
> +-include $(BUILD_DIR)/tests/tcg/config-$(PROBE_TARGET).mak
>
> -ifndef CROSS_CC_GUEST
>  ifneq ($(DOCKER_IMAGE),)
>  build-tcg-tests-$(PROBE_TARGET): docker-image-$(DOCKER_IMAGE)
> +$(BUILD_DIR)/tests/tcg/config_$(PROBE_TARGET).mak: config-host.mak
> +config-host.mak: $(SRC_PATH)/tests/tcg/configure.sh
>  endif
> -endif
> -
> -# Clean-up
> -# undefine TARGET_NAME
> -# undefine TARGET_BASE_ARCH
> -# undefine TARGET_ABI_DIR
> diff --git a/tests/tcg/Makefile.qemu b/tests/tcg/Makefile.qemu
> index d3f3437..c8bec7b 100644
> --- a/tests/tcg/Makefile.qemu
> +++ b/tests/tcg/Makefile.qemu
> @@ -8,17 +8,22 @@
>  # to do it for us.
>  #
>
> -# The per ARCH makefile, if it exists, holds extra information about
> +include $(SRC_PATH)/rules.mak
> +
> +# The configure script fills in extra information about
>  # useful docker images or alternative compiler flags.
>
> -include $(TARGET_DIR)config-target.mak
> -include $(SRC_PATH)/rules.mak
> -include $(wildcard \
> -	$(SRC_PATH)/tests/tcg/$(TARGET_BASE_ARCH)/Makefile.include \
> -	$(SRC_PATH)/tests/tcg/$(TARGET_NAME)/Makefile.include)
> +CROSS_CC_GUEST:=3D
> +DOCKER_IMAGE:=3D
> +-include $(BUILD_DIR)/tests/tcg/config-$(TARGET).mak
>
>  GUEST_BUILD=3D
>  TCG_MAKE=3D../Makefile.target
> +
> +# We also need the Docker make rules to depend on
> +SKIP_DOCKER_BUILD=3D1
> +include $(SRC_PATH)/tests/docker/Makefile.include
> +
>  # Support installed Cross Compilers
>
>  ifdef CROSS_CC_GUEST
> @@ -26,11 +31,11 @@ ifdef CROSS_CC_GUEST
>  .PHONY: cross-build-guest-tests
>  cross-build-guest-tests:
>  	$(call quiet-command, \
> -	   (mkdir -p tests/tcg/$(TARGET_DIR) && cd tests/tcg/$(TARGET_DIR) && \
> -	    $(MAKE) -f $(TCG_MAKE) TARGET_DIR=3D"$(TARGET_DIR)" CC=3D"$(CROSS_C=
C_GUEST)" \
> +	   (mkdir -p tests/tcg/$(TARGET) && cd tests/tcg/$(TARGET) && \
> +	    $(MAKE) -f $(TCG_MAKE) TARGET=3D"$(TARGET)" CC=3D"$(CROSS_CC_GUEST)=
" \
>  			SRC_PATH=3D"$(SRC_PATH)" BUILD_STATIC=3D$(CROSS_CC_GUEST_STATIC) \
> -			EXTRA_CFLAGS=3D$(CROSS_CC_GUEST_CFLAGS)), \

I expect given we need config-FOO.mak files before that these mkdir's are i=
n the wrong place.

<snip>

Otherwise I think this is going in the right direction.

--
Alex Benn=C3=A9e

