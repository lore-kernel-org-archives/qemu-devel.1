Received: from eggs.gnu.org ([2001:4830:134:3::10]:57491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dCngB-0001b0-P6
	for qemu-devel@nongnu.org; Mon, 22 May 2017 09:47:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dCng9-0001wm-4e
	for qemu-devel@nongnu.org; Mon, 22 May 2017 09:47:23 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:34961)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dCng8-0001we-Ts
	for qemu-devel@nongnu.org; Mon, 22 May 2017 09:47:21 -0400
Received: by mail-wm0-x231.google.com with SMTP id b84so299349507wmh.0
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 06:47:20 -0700 (PDT)
References: <20170521032956.27446-1-f4bug@amsat.org>
	<20170521032956.27446-5-f4bug@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170521032956.27446-5-f4bug@amsat.org>
Date: Mon, 22 May 2017 14:47:23 +0100
Message-ID: <87fufx3swk.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 04/24] docker: add 'apt-fake' script
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

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

> ---
>  tests/docker/dockerfiles/debian-apt-fake.sh | 46 +++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>  create mode 100755 tests/docker/dockerfiles/debian-apt-fake.sh
>
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


--
Alex Bennée
