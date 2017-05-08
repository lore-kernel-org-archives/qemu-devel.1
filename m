Received: from eggs.gnu.org ([2001:4830:134:3::10]:45407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d7ggW-00042h-4P
	for qemu-devel@nongnu.org; Mon, 08 May 2017 07:18:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d7ggT-0006Eg-00
	for qemu-devel@nongnu.org; Mon, 08 May 2017 07:18:36 -0400
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:33190)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1d7ggS-0006EU-PU
	for qemu-devel@nongnu.org; Mon, 08 May 2017 07:18:32 -0400
Received: by mail-wm0-x22a.google.com with SMTP id n198so16232125wmg.0
	for <qemu-devel@nongnu.org>; Mon, 08 May 2017 04:18:32 -0700 (PDT)
References: <20170508045715.21770-1-f4bug@amsat.org>
	<20170508045715.21770-22-f4bug@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170508045715.21770-22-f4bug@amsat.org>
Date: Mon, 08 May 2017 12:19:15 +0100
Message-ID: <87y3u78uks.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 21/23] docker: fix powerpc debian/stable
 dependencies problem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, Aurelien Jarno <aurel32@debian.org>, Riku Voipio <riku.voipio@iki.fi>, Vagrant Cascadian <vagrant@debian.org>, Michael Tokarev <mjt@tls.msk.ru>


Philippe Mathieu-Daudé <f4bug@amsat.org> writes:

> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  tests/docker/dockerfiles/debian-powerpc-cross.docker | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/tests/docker/dockerfiles/debian-powerpc-cross.docker b/tests/docker/dockerfiles/debian-powerpc-cross.docker
> index 9107ebc2d3..d6e4d1e977 100644
> --- a/tests/docker/dockerfiles/debian-powerpc-cross.docker
> +++ b/tests/docker/dockerfiles/debian-powerpc-cross.docker
> @@ -12,6 +12,13 @@ RUN dpkg --add-architecture powerpc && \
>      DEBIAN_FRONTEND=noninteractive eatmydata apt-get install -y --no-install-recommends \
>          crossbuild-essential-powerpc
>
> +# <kludge> to fix "following packages have unmet dependencies" ...
> +RUN apt-get install -y --no-install-recommends equivs pkg-config && \
> +    apt-fake install pkg-config:powerpc=0.28-1.1-fake && \
> +    ln -s pkg-config /usr/bin/powerpc-linux-gnu-pkg-config
> +ENV PKG_CONFIG_PATH /usr/lib/powerpc-linux-gnu/pkgconfig
> +# </kludge>
> +
>  # Specify the cross prefix for this image (see tests/docker/common.rc)
>  ENV QEMU_CONFIGURE_OPTS --cross-prefix=powerpc-linux-gnu-

Given the image needs these package hacks it is probably best folded
into the commit adding the target.

--
Alex Bennée
