Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66223C47404
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 16:21:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 309DD20673
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 16:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qvtsFx2l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 309DD20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHVlV-0001mQ-Hk
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 12:21:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56517)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iHVcx-0001t8-VS
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 12:12:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iHVcw-0001aH-3t
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 12:12:51 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:50645)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iHVcv-0001Z4-Rm
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 12:12:50 -0400
Received: by mail-wm1-x343.google.com with SMTP id 5so118156wmg.0
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2019 09:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=uZMWKzuhe3VEqLo6JfdYkI2KhpJEWSxDlaIL7GMkiUg=;
 b=qvtsFx2l0zsfPEDr4F0KsytsS11w7ozfPTpVaaftsUfZHqF8N37y7bj/QBPVDNDnSe
 Y9cmtQe+0c7Q/l5wdBFjze4TgZAVVqu3vkreFJKIsh+2JfJpk3fMQ36uDALOWfNXE7PH
 Ti73iLIb444yUKJDVF/nsTzxrokgX/N6KmZWmtHyoNnFSe0u0tYVrdTYE71rGHM3YPuz
 qYduTPoASP4sdDeL5rUJpPuxi7/mtub7Ka6+2kkZBB7IiZ/NDmRHl1NzJkYRlAVJ5ZQU
 8jZ/5FOOQnLpsNvf2BL8y61GGITkxIx2MIQWEN9FIcXBQa4otCXuw+jQXppZfoWGHNtB
 RDnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=uZMWKzuhe3VEqLo6JfdYkI2KhpJEWSxDlaIL7GMkiUg=;
 b=OFr9bsy5cfR2Ty1Ln4c1Fr7BbFN6p9KEdXglv7zYw+L1aTVvnp+SFm4YBNGd05BUyT
 od1Lfn/s4R5Dzz9vATBCn4j0qOPpmmKZ//5b/DHz2uSMua+Gd+zsp9rWMr6VCODhXcMT
 L3gCFXkOUn4O3o66mTOma4tM9vwESYmEaECPtdDZ5uzy8s8bDn3WnJO6D1FirnYLCRNS
 JSKrsl1beJAxJuhp790v2JeDt4Sr3C1UkEsUfnshIQJpdd7K293O83oNp0dQDEsDpI73
 shOtjEgRTwgeigIScedAlPh4S1PJ9FYmvyiNonbicmFNPs2aHUR7FKTToQnMRXqMqckz
 39cg==
X-Gm-Message-State: APjAAAURsSKtypzChSkaepKMLN3GwEYkBX5fkjAv/72FRjcjh0RJ2c/T
 0+RgqU+aob/LQVekA9JgfhhH2w==
X-Google-Smtp-Source: APXvYqxHgjD8j4/ZgLtTP8zNLTloyNKzJ66ofL4SccFlaf6bSu/PbxlHxYvpocuTquWrSuNmJ/ZqPQ==
X-Received: by 2002:a1c:a546:: with SMTP id o67mr37215wme.57.1570464767964;
 Mon, 07 Oct 2019 09:12:47 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z142sm48541wmc.24.2019.10.07.09.12.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2019 09:12:47 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 843581FF87;
 Mon,  7 Oct 2019 17:12:46 +0100 (BST)
References: <20190920001823.23279-1-jsnow@redhat.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH RFC] docker: automatic dependencies for dockerfiles
In-reply-to: <20190920001823.23279-1-jsnow@redhat.com>
Date: Mon, 07 Oct 2019 17:12:46 +0100
Message-ID: <878spwk001.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: Fam Zheng <fam@euphon.net>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


John Snow <jsnow@redhat.com> writes:

> This is a demo for using makefile dependencies for image requisites.
> Honestly, I don't like it -- Makefile sorcery is a bit beyond my
> comprehension.
>
> This is as near as I could stab, and it has the unfortunate requisite
> that it will generate all of the *.d files at first run and not in an
> on-demand way. Boo.
>
> But, I wanted to raise the point that manually managing the variables
> is not long-term viable -- we should manage them automatically if we
> can.

I think this gets more complicated when we want to handle multiple host
architectures as well. We might for example have a final image that is
based of a native docker base in one case and a linux-user docker base
in another.

> As far as "partial" images vs "full" images, we should manage this
> too; perhaps by subdirectory on the dockerfiles -- that way these
> won't get out of date, either.

I'll have an experiment with different layouts and see.

>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  tests/docker/Makefile.include | 37 ++++++++-------------------------
>  tests/docker/deputil.py       | 39 +++++++++++++++++++++++++++++++++++
>  2 files changed, 48 insertions(+), 28 deletions(-)
>  create mode 100755 tests/docker/deputil.py
>
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
> index 50a400b573..266395d927 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -21,6 +21,7 @@ DOCKER_TOOLS :=3D travis
>  ENGINE :=3D auto
>
>  DOCKER_SCRIPT=3D$(SRC_PATH)/tests/docker/docker.py --engine $(ENGINE)
> +DEPTOOL=3D$(SRC_PATH)/tests/docker/deputil.py
>
>  TESTS ?=3D %
>  IMAGES ?=3D %
> @@ -47,12 +48,12 @@ docker-image: ${DOCKER_TARGETS}
>  # invoked with SKIP_DOCKER_BUILD we still check the image is up to date
>  # though
>  ifdef SKIP_DOCKER_BUILD
> -docker-image-%: $(DOCKER_FILES_DIR)/%.docker
> +docker-image-%: $(DOCKER_FILES_DIR)/%.docker %.d
>  	$(call quiet-command, \
>  		$(DOCKER_SCRIPT) check --quiet qemu:$* $<, \
>  		"CHECK", "$*")
>  else
> -docker-image-%: $(DOCKER_FILES_DIR)/%.docker
> +docker-image-%: $(DOCKER_FILES_DIR)/%.docker %.d
>  	$(call quiet-command,\
>  		$(DOCKER_SCRIPT) build qemu:$* $< \
>  		$(if $V,,--quiet) $(if $(NOCACHE),--no-cache) \
> @@ -88,23 +89,17 @@ docker-binfmt-image-debian-%: $(DOCKER_FILES_DIR)/deb=
ian-bootstrap.docker
>  endif
>
>  # Enforce dependencies for composite images
> -docker-image-debian9-mxe: docker-image-debian9
> +%.d: $(DOCKER_FILES_DIR)/%.docker
> +	$(call quiet-command, $(DEPTOOL) $(DOCKER_FILES_DIR)/$*.docker > $@)
> +
> +DEPFILES :=3D $(DOCKER_IMAGES:%=3D%.d)
> +include $(DEPFILES)
> +
>  ifeq ($(ARCH),x86_64)
> -docker-image-debian-amd64: docker-image-debian9
>  DOCKER_PARTIAL_IMAGES +=3D debian-amd64-cross
>  else
> -docker-image-debian-amd64-cross: docker-image-debian10
>  DOCKER_PARTIAL_IMAGES +=3D debian-amd64
>  endif
> -docker-image-debian-armel-cross: docker-image-debian9
> -docker-image-debian-armhf-cross: docker-image-debian9
> -docker-image-debian-mips-cross: docker-image-debian9
> -docker-image-debian-mipsel-cross: docker-image-debian9
> -docker-image-debian-mips64el-cross: docker-image-debian9
> -docker-image-debian-ppc64el-cross: docker-image-debian9
> -docker-image-debian-s390x-cross: docker-image-debian9
> -docker-image-debian-win32-cross: docker-image-debian9-mxe
> -docker-image-debian-win64-cross: docker-image-debian9-mxe
>
>  # For non-x86 hosts not all cross-compilers have been packaged
>  ifneq ($(ARCH),x86_64)
> @@ -115,22 +110,8 @@ DOCKER_PARTIAL_IMAGES +=3D debian-win32-cross debian=
-win64-cross
>  DOCKER_PARTIAL_IMAGES +=3D fedora travis
>  endif
>
> -docker-image-debian-alpha-cross: docker-image-debian10
> -docker-image-debian-arm64-cross: docker-image-debian10
> -docker-image-debian-hppa-cross: docker-image-debian10
> -docker-image-debian-m68k-cross: docker-image-debian10
> -docker-image-debian-mips64-cross: docker-image-debian10
> -docker-image-debian-powerpc-cross: docker-image-debian10
> -docker-image-debian-ppc64-cross: docker-image-debian10
> -docker-image-debian-riscv64-cross: docker-image-debian10
> -docker-image-debian-sh4-cross: docker-image-debian10
> -docker-image-debian-sparc64-cross: docker-image-debian10
> -
>  docker-image-travis: NOUSER=3D1
>
> -# Specialist build images, sometimes very limited tools
> -docker-image-tricore-cross: docker-image-debian9
> -
>  # These images may be good enough for building tests but not for test bu=
ilds
>  DOCKER_PARTIAL_IMAGES +=3D debian-alpha-cross
>  DOCKER_PARTIAL_IMAGES +=3D debian-hppa-cross
> diff --git a/tests/docker/deputil.py b/tests/docker/deputil.py
> new file mode 100755
> index 0000000000..69711cf85e
> --- /dev/null
> +++ b/tests/docker/deputil.py
> @@ -0,0 +1,39 @@
> +#!/usr/bin/env python3
> +import os
> +import re
> +import sys
> +from typing import IO, Optional
> +
> +def get_dep(infile: IO[str]) -> Optional[str]:
> +    """Get a dependency as a string from a dockerfile."""
> +    for line in infile:
> +        match =3D re.match(r'FROM (.+)', line)
> +        if match:
> +            return match[1]
> +    return None
> +
> +def get_qemu_dep(infile: IO[str]) -> Optional[str]:
> +    """Get a dependency on the qemu: namespace from a dockerfile."""
> +    dep =3D get_dep(infile) or ''
> +    match =3D re.match(r'qemu:(.+)', dep)
> +    return match[1] if match else None
> +
> +def main() -> None:
> +    filename =3D sys.argv[1]
> +    basefile =3D os.path.basename(filename)
> +    base =3D os.path.splitext(basefile)[0]
> +    depfile =3D f"{base}.d"
> +    deps =3D [filename]
> +
> +    print(f"{depfile}: {filename}")
> +    with open(filename, "r") as infile:
> +        match =3D get_qemu_dep(infile) or ''
> +        if match:
> +            deps.append(f"docker-image-{match}")
> +    print("{}: {}".format(
> +        f"docker-image-{base}",
> +        " ".join(deps)
> +    ))
> +
> +if __name__ =3D=3D '__main__':
> +    main()


--
Alex Benn=C3=A9e

