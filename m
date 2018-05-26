Received: from eggs.gnu.org ([2001:4830:134:3::10]:34177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fMRTP-0002pR-Lq
	for qemu-devel@nongnu.org; Sat, 26 May 2018 01:10:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fMRTL-0005hj-Ob
	for qemu-devel@nongnu.org; Sat, 26 May 2018 01:10:35 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:36566)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fMRTL-0005hO-IS
	for qemu-devel@nongnu.org; Sat, 26 May 2018 01:10:31 -0400
Received: by mail-qt0-x242.google.com with SMTP id q6-v6so9167501qtn.3
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 22:10:31 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180502002143.30624-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <082d9daf-d430-0917-f71e-a96d7735160e@amsat.org>
Date: Sat, 26 May 2018 02:10:26 -0300
MIME-Version: 1.0
In-Reply-To: <20180502002143.30624-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH] docker: add debian/tricore image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, David Brenken <david.brenken@efs-auto.de>, Florian Artmeier <florian.artmeier@efs-auto.de>, Georg Hofstetter <georg.hofstetter@efs-auto.de>

Hi Alex, ping for review ;)

On 05/01/2018 09:21 PM, Philippe Mathieu-Daudé wrote:
> TriCore binutils is built from Bastian Koppelmann repository.
> 
> Note: There is no TriCore compiler in this image (only assembler/linker).
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> See http://lists.nongnu.org/archive/html/qemu-devel/2018-05/msg00074.html
> 
> $ docker images --format "{{.Repository}}:{{.Tag}} {{.Size}}"
> qemu:debian-tricore-cross 323MB
> 
>  .../dockerfiles/debian-tricore-cross.docker   | 35 +++++++++++++++++++
>  1 file changed, 35 insertions(+)
>  create mode 100644 tests/docker/dockerfiles/debian-tricore-cross.docker
> 
> diff --git a/tests/docker/dockerfiles/debian-tricore-cross.docker b/tests/docker/dockerfiles/debian-tricore-cross.docker
> new file mode 100644
> index 0000000000..f71ac3eb47
> --- /dev/null
> +++ b/tests/docker/dockerfiles/debian-tricore-cross.docker
> @@ -0,0 +1,35 @@
> +#
> +# Docker TriCore cross-compiler target
> +#
> +# This docker target builds on the debian Stretch base image.
> +#
> +# Copyright (c) 2018 Philippe Mathieu-Daudé
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +FROM debian:stretch-slim
> +
> +MAINTAINER Philippe Mathieu-Daudé <f4bug@amsat.org>
> +
> +# Install common build utilities
> +RUN apt-get update && \
> +    DEBIAN_FRONTEND=noninteractive apt-get install -yy eatmydata && \
> +    DEBIAN_FRONTEND=noninteractive eatmydata \
> +    apt-get install -y --no-install-recommends \
> +        automake \
> +        bison \
> +        build-essential \
> +        ca-certificates \
> +        flex \
> +        git
> +
> +RUN git clone --single-branch \
> +        https://github.com/bkoppelmann/tricore-binutils.git \
> +        /usr/src/binutils && \
> +    cd /usr/src/binutils && chmod +x missing && \
> +    CFLAGS=-w ./configure --prefix=/usr --disable-nls --target=tricore && \
> +    make && make install && \
> +    rm -rf /usr/src/binutils
> +
> +# Specify the cross prefix for this image (see tests/docker/common.rc)
> +ENV QEMU_CONFIGURE_OPTS --cross-prefix=tricore-
> 
