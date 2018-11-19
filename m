Received: from eggs.gnu.org ([2001:4830:134:3::10]:58106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gOjqS-000562-MO
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 08:44:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gOjqO-0003WQ-HG
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 08:44:08 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:40703)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gOjqO-0003Vy-BE
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 08:44:04 -0500
Received: by mail-wr1-x443.google.com with SMTP id p4so22960582wrt.7
	for <qemu-devel@nongnu.org>; Mon, 19 Nov 2018 05:44:04 -0800 (PST)
References: <20181118203312.5376-1-f4bug@amsat.org>
	<20181118203312.5376-2-f4bug@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181118203312.5376-2-f4bug@amsat.org>
Date: Mon, 19 Nov 2018 13:44:01 +0000
Message-ID: <87va4ti3mm.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 1/2] docker: Add
 gentoo-mipsr5900el-cross image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Fredrik Noring <noring@nocrew.org>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Mike Frysinger <vapier@gentoo.org>


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> This image is based on Gentoo and the toolchain is built using crossdev.
>
> Recipe from:
>   https://lists.gnu.org/archive/html/qemu-devel/2018-09/msg03944.html
>
> Suggested-by: Fredrik Noring <noring@nocrew.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> TODO:
> - Add Fredrik Noring S-o-b in his patches
> - Check patch merged upstream
>
>  tests/docker/Makefile.include                 |   6 +
>  .../gentoo-mipsr5900el-cross.docker           |  39 ++++
>  .../binutils-v2.30-ps2-llsc.patch             |  36 +++
>  .../crossdev.conf                             |   5 +
>  .../gcc-v7.2.0-ps2-llsc.patch                 |  23 ++
>  .../gcc-v7.2.0-ps2.patch                      | 219 ++++++++++++++++++
>  6 files changed, 328 insertions(+)
>  create mode 100644 tests/docker/dockerfiles/gentoo-mipsr5900el-cross.doc=
ker
>  create mode 100644 tests/docker/dockerfiles/gentoo-mipsr5900el-cross.doc=
ker.d/binutils-v2.30-ps2-llsc.patch
>  create mode 100644 tests/docker/dockerfiles/gentoo-mipsr5900el-cross.doc=
ker.d/crossdev.conf
>  create mode 100644 tests/docker/dockerfiles/gentoo-mipsr5900el-cross.doc=
ker.d/gcc-v7.2.0-ps2-llsc.patch
>  create mode 100644 tests/docker/dockerfiles/gentoo-mipsr5900el-cross.doc=
ker.d/gcc-v7.2.0-ps2.patch
>
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
> index 9467e9d088..6ca615206f 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -119,6 +119,12 @@ docker-image-debian-sparc64-cross: docker-image-debi=
an-sid
>  docker-image-debian-mips64-cross: docker-image-debian-sid
>  docker-image-debian-riscv64-cross: docker-image-debian-sid
>  docker-image-debian-powerpc-cross: docker-image-debian-sid
> +docker-image-gentoo-mipsr5900el-cross: EXTRA_FILES:=3D$(addprefix \
> +			$(SRC_PATH)/tests/docker/dockerfiles/gentoo-mipsr5900el-cross.docker.=
d/,\
> +				crossdev.conf \
> +				binutils-v2.30-ps2-llsc.patch \
> +				gcc-v7.2.0-ps2.patch \
> +				gcc-v7.2.0-ps2-llsc.patch)
>  docker-image-travis: NOUSER=3D1
>
>  # Specialist build images, sometimes very limited tools
> diff --git a/tests/docker/dockerfiles/gentoo-mipsr5900el-cross.docker b/t=
ests/docker/dockerfiles/gentoo-mipsr5900el-cross.docker
> new file mode 100644
> index 0000000000..dbc2eb007b
> --- /dev/null
> +++ b/tests/docker/dockerfiles/gentoo-mipsr5900el-cross.docker
> @@ -0,0 +1,39 @@
> +#
> +# Docker mipsel (r5900) cross-compiler target
> +#
> +# Using multi-stage builds, this image requires docker-17.05.0 or later.
> +# (See: https://github.com/gentoo/gentoo-docker-images)
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +# name the portage image
> +FROM gentoo/portage:latest as portage
> +
> +# image is based on stage3-amd64
> +FROM gentoo/stage3-amd64:latest
> +
> +# copy the entire portage volume in
> +COPY --from=3Dportage /usr/portage /usr/portage

OK digging into this more I think the problem is the images are too old:

  bdb7b450deaa / # ls -l usr/lib/python-exec/python-exec2
  -rwxr-xr-x 1 root root 1461 Dec  8  2016 usr/lib/python-exec/python-exec2

To have a proper Gentoo environment you need to take the latest stage3,
sync the portage tree and update all the tools. It's a little odd
because the hub claims the last build was 18 hours ago but the portage
is still older than mine:

  13:37:45 [alex@danny:~/tmp] 1 $ ls -l /usr/lib/python-exec/python-exec2
  -rwxr-xr-x 1 root root 2302 Sep 10 14:09 /usr/lib/python-exec/python-exec=
2*

I'll have a dig into the stage tarballs.

--
Alex Benn=C3=A9e
