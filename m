Received: from eggs.gnu.org ([2001:4830:134:3::10]:44157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d7ga2-0008Uo-2x
	for qemu-devel@nongnu.org; Mon, 08 May 2017 07:11:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d7ga0-00045X-Ts
	for qemu-devel@nongnu.org; Mon, 08 May 2017 07:11:54 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:35587)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1d7ga0-00045M-Od
	for qemu-devel@nongnu.org; Mon, 08 May 2017 07:11:52 -0400
Received: by mail-wr0-x236.google.com with SMTP id z52so40672967wrc.2
	for <qemu-devel@nongnu.org>; Mon, 08 May 2017 04:11:52 -0700 (PDT)
References: <20170508045715.21770-1-f4bug@amsat.org>
	<20170508045715.21770-15-f4bug@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170508045715.21770-15-f4bug@amsat.org>
Date: Mon, 08 May 2017 12:12:35 +0100
Message-ID: <874lwva9gc.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 14/23] docker: add 'apt-fake' script
 which generate fake debian packages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, Aurelien Jarno <aurel32@debian.org>, Riku Voipio <riku.voipio@iki.fi>, Vagrant Cascadian <vagrant@debian.org>, Michael Tokarev <mjt@tls.msk.ru>


Philippe Mathieu-Daudé <f4bug@amsat.org> writes:

> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  tests/docker/Makefile.include               |  2 ++
>  tests/docker/dockerfiles/debian-apt-fake.sh | 46 +++++++++++++++++++++++++++++
>  tests/docker/dockerfiles/debian.docker      |  2 ++
>  3 files changed, 50 insertions(+)
>  create mode 100755 tests/docker/dockerfiles/debian-apt-fake.sh
>
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
> index 47978fb56c..ca6f57a292 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -55,6 +55,8 @@ docker-image-%: $(DOCKER_FILES_DIR)/%.docker
>  		$(if $(EXTRA_FILE),--include-file=$(EXTRA_FILE)),\
>  		"BUILD","$*")
>
> +docker-image-debian: EXTRA_FILE:=tests/docker/dockerfiles/debian-apt-fake.sh
> +

Can we only include debian-apt-fake on the debian images that require it please?

>  # Enforce dependancies for composite images
>  docker-image-debian-armhf-cross: docker-image-debian
>  docker-image-debian-arm64-cross: docker-image-debian
> diff --git a/tests/docker/dockerfiles/debian-apt-fake.sh b/tests/docker/dockerfiles/debian-apt-fake.sh
> new file mode 100755
> index 0000000000..387522c174
> --- /dev/null
> +++ b/tests/docker/dockerfiles/debian-apt-fake.sh
> @@ -0,0 +1,46 @@
> +#! /bin/sh
> +#
> +# Generate fake debian package to resolve unimportant unmet dependencies held
> +# by upstream multiarch broken packages.
> +#
> +# Copyright (c) 2017 Philippe Mathieu-Daudé <f4bug@amsat.org>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2
> +# or (at your option) any later version. See the COPYING file in
> +# the top-level directory.
> +
> +test $1 = "install" && shift 1
> +
> +fake_install()
> +{
> +    echo "Generating fake $2 $1 $3 ..."
> +    (cd /var/cache/apt/archives
> +        (cat << 'EOF'
> +Section: misc
> +Priority: optional
> +Standards-Version: 3.9.2
> +
> +Package: NAME
> +Version: VERSION
> +Maintainer: qemu-devel@nongnu.org
> +Architecture: any
> +Multi-Arch: same
> +Description: fake NAME
> +EOF
> +        ) | sed s/NAME/$2/g | sed s/VERSION/$3/g > $2.control
> +        equivs-build -a $1 $2.control 1>/dev/null 2>/dev/null
> +        dpkg -i $2_$3_$1.deb
> +    )
> +}
> +
> +try_install()
> +{
> +    name=$(echo $1|sed "s/\(.*\):\(.*\)=\(.*\)/\1/")
> +    arch=$(echo $1|sed "s/\(.*\):\(.*\)=\(.*\)/\2/")
> +    vers=$(echo $1|sed "s/\(.*\):\(.*\)=\(.*\)/\3/")
> +    apt-get install -q -yy $1 || fake_install $arch $name $vers
> +}
> +
> +for package in $*; do
> +    try_install $package
> +done
> diff --git a/tests/docker/dockerfiles/debian.docker b/tests/docker/dockerfiles/debian.docker
> index 694f8d3b63..a99396ae8f 100644
> --- a/tests/docker/dockerfiles/debian.docker
> +++ b/tests/docker/dockerfiles/debian.docker
> @@ -22,6 +22,8 @@ RUN apt-get update && \
>  # Duplicate deb line as deb-src
>  RUN cat /etc/apt/sources.list | sed "s/deb/deb-src/" >> /etc/apt/sources.list
>
> +ADD debian-apt-fake.sh /usr/local/bin/apt-fake
> +

And only add this in the images that need it.

>  # Setup Emdebian
>  RUN echo "deb http://emdebian.org/tools/debian/ jessie main" >> /etc/apt/sources.list && \
>      curl http://emdebian.org/tools/debian/emdebian-toolchain-archive.key | apt-key add -


--
Alex Bennée
