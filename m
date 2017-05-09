Received: from eggs.gnu.org ([2001:4830:134:3::10]:60846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d7wOC-0005pk-Kw
	for qemu-devel@nongnu.org; Tue, 09 May 2017 00:04:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d7wO9-0001RR-Hz
	for qemu-devel@nongnu.org; Tue, 09 May 2017 00:04:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43110)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1d7wO9-0001Qg-Bb
	for qemu-devel@nongnu.org; Tue, 09 May 2017 00:04:41 -0400
Date: Tue, 9 May 2017 12:04:38 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170509040438.GB18973@lemon.lan>
References: <20170508221759.15616-1-f4bug@amsat.org>
	<20170508221759.15616-6-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170508221759.15616-6-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 05/21] docker: compact debian base
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>

On Mon, 05/08 19:17, Philippe Mathieu-Daud=E9 wrote:
> - install common/basic tools at once
> - use eatmydata and remove apt cache to save space
> - add bison and flex and git
> - create deb-src entry and setup Emdebian in the same layer
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
>  tests/docker/dockerfiles/debian.docker | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
>=20
> diff --git a/tests/docker/dockerfiles/debian.docker b/tests/docker/dock=
erfiles/debian.docker
> index d08def6a8d..dcded3ce84 100644
> --- a/tests/docker/dockerfiles/debian.docker
> +++ b/tests/docker/dockerfiles/debian.docker
> @@ -9,17 +9,17 @@
>  #
>  FROM debian:stable-slim
> =20
> -# Setup some basic tools we need
> -RUN apt update
> -RUN apt install -yy aptitude ca-certificates curl
> +# Install some basic tools and common build utilities
> +RUN apt-get update && \
> +    DEBIAN_FRONTEND=3Dnoninteractive apt-get install -yy \
> +        eatmydata && \
> +    DEBIAN_FRONTEND=3Dnoninteractive eatmydata apt-get install -y --no=
-install-recommends \
> +        aptitude ca-certificates curl \
> +        build-essential clang git \
> +        bison flex && \
> +    apt-get clean

Any particular reason to make multiple "RUN" directives into one?

Fam

> =20
> -# Setup Emdebian
> -RUN echo "deb http://emdebian.org/tools/debian/ jessie main" >> /etc/a=
pt/sources.list
> -RUN curl http://emdebian.org/tools/debian/emdebian-toolchain-archive.k=
ey | apt-key add -
> -
> -# Duplicate deb line as deb-src
> -RUN cat /etc/apt/sources.list | sed "s/deb/deb-src/" >> /etc/apt/sourc=
es.list
> -
> -# Install common build utilities
> -RUN apt update
> -RUN apt install -yy build-essential clang
> +# Duplicate deb line as deb-src, setup Emdebian
> +RUN cat /etc/apt/sources.list | sed "s/deb/deb-src/" >> /etc/apt/sourc=
es.list && \
> +    echo "deb http://emdebian.org/tools/debian/ jessie main" >> /etc/a=
pt/sources.list && \
> +    curl http://emdebian.org/tools/debian/emdebian-toolchain-archive.k=
ey | apt-key add -
> --=20
> 2.11.0
>=20
