Received: from eggs.gnu.org ([2001:4830:134:3::10]:42021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fdZ8E-0002sT-85
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 06:47:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fdZ8A-0003C4-8g
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 06:47:30 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d]:37389)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fdZ8A-0003AI-0x
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 06:47:26 -0400
Received: by mail-ed1-x52d.google.com with SMTP id v22-v6so21522977edq.4
	for <qemu-devel@nongnu.org>; Thu, 12 Jul 2018 03:47:25 -0700 (PDT)
References: <20180711043417.24097-1-f4bug@amsat.org>
	<20180711043417.24097-2-f4bug@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180711043417.24097-2-f4bug@amsat.org>
Date: Thu, 12 Jul 2018 11:47:23 +0100
Message-ID: <87o9fcd938.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH for-3.1 1/2] docker: Fix TriCore
 binutils build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, David Brenken <david.brenken@efs-auto.de>, Florian Artmeier <florian.artmeier@efs-auto.de>, Georg Hofstetter <georg.hofstetter@efs-auto.de>


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> - Use recent 'missing' from libtool,
> - Fix 'ylwrap' permissions
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> Shippable runs 'clang --version'.
>
>  .../dockerfiles/debian-tricore-cross.docker   | 23 ++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
>
> diff --git a/tests/docker/dockerfiles/debian-tricore-cross.docker b/tests=
/docker/dockerfiles/debian-tricore-cross.docker
> index 898b8dd511..f833a6ca16 100644
> --- a/tests/docker/dockerfiles/debian-tricore-cross.docker
> +++ b/tests/docker/dockerfiles/debian-tricore-cross.docker
> @@ -7,16 +7,33 @@
>  #
>  # SPDX-License-Identifier: GPL-2.0-or-later
>  #
> -FROM debian:9
> +FROM debian:9-slim
>
>  MAINTAINER Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
> +# Install common build utilities
> +RUN apt-get update && \
> +    DEBIAN_FRONTEND=3Dnoninteractive apt-get install -yy eatmydata && \
> +    DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
> +    apt-get install -y --no-install-recommends \
> +        automake \
> +        bison \
> +        build-essential \
> +        ca-certificates \
> +        flex \
> +        git \
> +        libtool && \
> +    ln -s /usr/bin/cc /usr/bin/clang && \
> +    ln -s /usr/bin/gcc /usr/bin/tricore-gcc

Erm what is this trying to do?

> +
>  RUN git clone --single-branch \
>          https://github.com/bkoppelmann/tricore-binutils.git \
>          /usr/src/binutils && \
> -    cd /usr/src/binutils && chmod +x missing && \
> +    cd /usr/src/binutils && \
> +    cp /usr/share/libtool/build-aux/missing . && \
> +    chmod +x ylwrap binutils/ylwrap && \
>      CFLAGS=3D-w ./configure --prefix=3D/usr --disable-nls --target=3Dtri=
core && \
> -    make && make install && \
> +    make all install && \
>      rm -rf /usr/src/binutils
>
>  # Specify the cross prefix for this image (see tests/docker/common.rc)


--
Alex Benn=C3=A9e
