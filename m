Received: from eggs.gnu.org ([2001:4830:134:3::10]:42363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d7gRx-0005V4-N0
	for qemu-devel@nongnu.org; Mon, 08 May 2017 07:03:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d7gRt-0002IO-FP
	for qemu-devel@nongnu.org; Mon, 08 May 2017 07:03:33 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:38074)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1d7gRt-0002IF-9l
	for qemu-devel@nongnu.org; Mon, 08 May 2017 07:03:29 -0400
Received: by mail-wm0-x232.google.com with SMTP id 142so60653675wma.1
	for <qemu-devel@nongnu.org>; Mon, 08 May 2017 04:03:29 -0700 (PDT)
References: <20170508045715.21770-1-f4bug@amsat.org>
	<20170508045715.21770-5-f4bug@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170508045715.21770-5-f4bug@amsat.org>
Date: Mon, 08 May 2017 12:04:11 +0100
Message-ID: <878tm7a9uc.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 04/23] docker: compact debian base
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>


Philippe Mathieu-Daudé <f4bug@amsat.org> writes:

> - install common/basic tools at once
> - one-line Emdebian setup
> - use eatmydata and remove apt cache to save space
> - add bison and flex and git
>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  tests/docker/dockerfiles/debian.docker | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
>
> diff --git a/tests/docker/dockerfiles/debian.docker b/tests/docker/dockerfiles/debian.docker
> index 52bd79938e..694f8d3b63 100644
> --- a/tests/docker/dockerfiles/debian.docker
> +++ b/tests/docker/dockerfiles/debian.docker
> @@ -9,17 +9,19 @@
>  #
>  FROM debian:stable-slim
>
> -# Setup some basic tools we need
> -RUN apt update
> -RUN apt install -yy curl aptitude
> -
> -# Setup Emdebian
> -RUN echo "deb http://emdebian.org/tools/debian/ jessie main" >> /etc/apt/sources.list
> -RUN curl http://emdebian.org/tools/debian/emdebian-toolchain-archive.key | apt-key add -
> +# Install some basic tools and common build utilities
> +RUN apt-get update && \
> +    DEBIAN_FRONTEND=noninteractive apt-get install -yy \
> +        eatmydata && \

I wonder if we should just use ENV instead to set DEBIAN_FRONTEND?

> +    DEBIAN_FRONTEND=noninteractive eatmydata apt-get install -y --no-install-recommends \
> +        curl aptitude \
> +        build-essential clang git \
> +        bison flex && \
> +    rm -rf /var/lib/apt

Use apt clean to do this.

>
>  # Duplicate deb line as deb-src
>  RUN cat /etc/apt/sources.list | sed "s/deb/deb-src/" >> /etc/apt/sources.list
>
> -# Install common build utilities
> -RUN apt update
> -RUN apt install -yy build-essential clang
> +# Setup Emdebian
> +RUN echo "deb http://emdebian.org/tools/debian/ jessie main" >> /etc/apt/sources.list && \
> +    curl http://emdebian.org/tools/debian/emdebian-toolchain-archive.key | apt-key add -

Why move this to the end? Once we have curl installed it would be nice
to do just one update step and have emdebian synced up in the base
image.


--
Alex Bennée
