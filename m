Received: from eggs.gnu.org ([2001:4830:134:3::10]:58171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gOiaH-00069B-5p
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 07:23:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gOiaD-0004O2-Uk
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 07:23:21 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51002)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gOiaB-0004M4-UK
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 07:23:17 -0500
Received: by mail-wm1-x342.google.com with SMTP id 125so3094823wmh.0
	for <qemu-devel@nongnu.org>; Mon, 19 Nov 2018 04:23:15 -0800 (PST)
References: <20181118203312.5376-1-f4bug@amsat.org>
	<20181118203312.5376-2-f4bug@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181118203312.5376-2-f4bug@amsat.org>
Date: Mon, 19 Nov 2018 12:23:12 +0000
Message-ID: <87wop9i7db.fsf@linaro.org>
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

This is going to be a rolling state of portage which may be why it broke.

> +
> +# image is based on stage3-amd64
> +FROM gentoo/stage3-amd64:latest
> +
> +# copy the entire portage volume in
> +COPY --from=3Dportage /usr/portage /usr/portage
> +
> +MAINTAINER Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> +
> +# continue with image build ...
> +RUN emerge -qv sys-devel/crossdev
> +
> +# set CROSSDEV_OVERLAY to /usr/local/portage-crossdev
> +RUN mkdir -p /usr/local/portage-crossdev/{profiles,metadata} && \
> +    echo 'crossdev' > /usr/local/portage-crossdev/profiles/repo_name && \
> +    echo 'masters =3D gentoo' > /usr/local/portage-crossdev/metadata/lay=
out.conf && \
> +    chown -R portage:portage /usr/local/portage-crossdev && \
> +    mkdir -p /etc/portage/repos.conf
> +ADD crossdev.conf /etc/portage/repos.conf/crossdev.conf
> +
> +# Fredrik's patches
> +RUN mkdir -p /etc/portage/patches/cross-mipsr5900el-unknown-linux-gnu/{b=
inutils,gcc}
> +ADD binutils-v2.30-ps2-llsc.patch /etc/portage/patches/cross-mipsr5900el=
-unknown-linux-gnu/binutils
> +ADD gcc-v7.2.0-ps2.patch /etc/portage/patches/cross-mipsr5900el-unknown-=
linux-gnu/gcc
> +ADD gcc-v7.2.0-ps2-llsc.patch /etc/portage/patches/cross-mipsr5900el-unk=
nown-linux-gnu/gcc
> +
> +RUN crossdev -s3 -t mipsr5900el-unknown-linux-gnu --binutils ">=3D2.30" =
--gcc ">=3D7.2.0"
> +

This fails to build glibc, but doesn't exactly give much info:

   * Log: /var/log/portage/cross-mipsr5900el-unknown-linux-gnu-binutils.log
   * Emerging cross-binutils ...                                           =
 [ ok ]
   * Log: /var/log/portage/cross-mipsr5900el-unknown-linux-gnu-linux-header=
s-quick.log
   * Emerging cross-linux-headers-quick ...                                =
 [ ok ]
   * Log: /var/log/portage/cross-mipsr5900el-unknown-linux-gnu-glibc-header=
s.log
   * Emerging cross-glibc-headers ...

   * error: glibc failed :(
   *
   * If you file a bug, please attach the following logfiles:
   * /var/log/portage/cross-mipsr5900el-unknown-linux-gnu-info.log
   * /var/log/portage/cross-mipsr5900el-unknown-linux-gnu-glibc-headers.log=
.xz
   * /var/tmp/portage/cross-mipsr5900el-unknown-linux-gnu/glibc*/temp/glibc=
-config.logs.tar.xz
  The command '/bin/sh -c crossdev -s3 -t mipsr5900el-unknown-linux-gnu --b=
inutils ">=3D2.30" --gcc ">=3D7.2.0"' returned a non-zero code: 1

But running in a container I did get:

  >>> Running pre-merge checks for cross-mipsr5900el-unknown-linux-gnu/glib=
c-2.27-r6
   * Checking general environment sanity.
   * Your //etc/nsswitch.conf is out of date.
   * Please make sure you have 'files' entries for
   * 'passwd:', 'group:' and 'shadow:' databases.
   * For more details see:
   *   https://wiki.gentoo.org/wiki/Project:Toolchain/nsswitch.conf_in_glib=
c-2.26
   * ERROR: cross-mipsr5900el-unknown-linux-gnu/glibc-2.27-r6::crossdev fai=
led (pretend phase):
   *   nsswitch.conf has no 'files' provider in 'passwd'.
   *
   * Call stack:
   *              ebuild.sh, line 115:  Called pkg_pretend
   *   glibc-2.27-r6.ebuild, line 723:  Called sanity_prechecks
   *   glibc-2.27-r6.ebuild, line 651:  Called die
   * The specific snippet of code:
   *                              die "nsswitch.conf has no 'files' provide=
r in '${entry}'."
   *
   * If you need support, post the output of `emerge --info '=3Dcross-mipsr=
5900el-unknown-linux-gnu/glibc-2.27-r6::crossdev'`,
   * the complete build log and the output of `emerge -pqv '=3Dcross-mipsr5=
900el-unknown-linux-gnu/glibc-2.27-r6::crossdev'`.
   * The complete build log is located at '/var/tmp/portage/cross-mipsr5900=
el-unknown-linux-gnu/glibc-2.27-r6/temp/build.log'.
   * The ebuild environment file is located at '/var/tmp/portage/cross-mips=
r5900el-unknown-linux-gnu/glibc-2.27-r6/temp/die.env'.
   * Working directory: '/usr/lib64/python3.4/site-packages'
   * S: '/var/tmp/portage/cross-mipsr5900el-unknown-linux-gnu/glibc-2.27-r6=
/work/glibc-2.27'
   * Messages for package cross-mipsr5900el-unknown-linux-gnu/glibc-2.27-r6:
   * Your //etc/nsswitch.conf is out of date.
   * Please make sure you have 'files' entries for
   * 'passwd:', 'group:' and 'shadow:' databases.
   * For more details see:
   *   https://wiki.gentoo.org/wiki/Project:Toolchain/nsswitch.conf_in_glib=
c-2.26
   * ERROR: cross-mipsr5900el-unknown-linux-gnu/glibc-2.27-r6::crossdev fai=
led (pretend phase):
   *   nsswitch.conf has no 'files' provider in 'passwd'.
   *
   * Call stack:
   *              ebuild.sh, line 115:  Called pkg_pretend
   *   glibc-2.27-r6.ebuild, line 723:  Called sanity_prechecks
   *   glibc-2.27-r6.ebuild, line 651:  Called die
   * The specific snippet of code:
   *                              die "nsswitch.conf has no 'files' provide=
r in '${entry}'."

--
Alex Benn=C3=A9e
