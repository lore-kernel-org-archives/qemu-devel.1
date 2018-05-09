Received: from eggs.gnu.org ([2001:4830:134:3::10]:49336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fGI6o-0005Tr-Lc
	for qemu-devel@nongnu.org; Wed, 09 May 2018 01:57:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fGI6l-0008LB-Jp
	for qemu-devel@nongnu.org; Wed, 09 May 2018 01:57:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48328 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fGI6l-0008KR-FB
	for qemu-devel@nongnu.org; Wed, 09 May 2018 01:57:47 -0400
Date: Wed, 9 May 2018 13:57:29 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180509032533.GI22503@lemon.usersys.redhat.com>
References: <90990df8024b287004e771ebd2370cc390e49106.1525723355.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90990df8024b287004e771ebd2370cc390e49106.1525723355.git.alistair.francis@wdc.com>
Subject: Re: [Qemu-devel] [PATCH v1 1/1] tests/docker: Add a Avocado Docker
 test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@wdc.com>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, f4bug@amsat.org, alistair23@gmail.com

On Mon, 05/07 13:09, Alistair Francis wrote:
> Avocado is not trivial to setup on non-Fedora systems. To simplfying
> future testing add a docker test image that runs Avocado tests.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  tests/docker/dockerfiles/fedora.docker | 12 +++++++++--
>  tests/docker/test-avocado              | 28 ++++++++++++++++++++++++++
>  2 files changed, 38 insertions(+), 2 deletions(-)
>  create mode 100755 tests/docker/test-avocado
> 
> diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
> index b706f42405..5c23f6e459 100644
> --- a/tests/docker/dockerfiles/fedora.docker
> +++ b/tests/docker/dockerfiles/fedora.docker
> @@ -18,9 +18,17 @@ ENV PACKAGES \
>      mingw64-pixman mingw64-glib2 mingw64-gmp mingw64-SDL mingw64-pkg-config \
>      mingw64-gtk2 mingw64-gtk3 mingw64-gnutls mingw64-nettle mingw64-libtasn1 \
>      mingw64-libjpeg-turbo mingw64-libpng mingw64-curl mingw64-libssh2 \
> -    mingw64-bzip2
> +    mingw64-bzip2 \
> +    xz tcpdump nc \
> +    python2-devel python3-devel python-avocado \
> +    libvirt-devel qemu-kvm
>  ENV QEMU_CONFIGURE_OPTS --python=/usr/bin/python3
> +ENV PIP_PACKAGES \
> +    avocado-framework avocado-qemu \

I think python-avacado overlaps with pip avacado-framework. Why are both needed?

Fam

> +    avocado-framework-plugin-vt avocado-framework-plugin-runner-vm \
> +    avocado-framework-plugin-runner-remote avocado-framework-plugin-result-html
>  
>  RUN dnf install -y $PACKAGES
> +RUN pip install $PIP_PACKAGES
>  RUN rpm -q $PACKAGES | sort > /packages.txt
> -ENV FEATURES mingw clang pyyaml asan
> +ENV FEATURES mingw clang pyyaml asan avocado
> diff --git a/tests/docker/test-avocado b/tests/docker/test-avocado
> new file mode 100755
> index 0000000000..8da7bc10a2
> --- /dev/null
> +++ b/tests/docker/test-avocado
> @@ -0,0 +1,28 @@
> +#!/bin/bash -e
> +#
> +# Avocado tests on Fedora, as these are a real pain on Debian systems
> +#
> +# Copyright (c) 2018 Western Digital.
> +#
> +# Authors:
> +#  Alistair Francis <alistair.francis@wdc.com>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2
> +# or (at your option) any later version. See the COPYING file in
> +# the top-level directory.
> +#
> +# Run this test: NETWORK=1 make docker-test-avocado@fedora
> +
> +. common.rc
> +
> +requires avocado
> +
> +cd "$BUILD_DIR"
> +
> +DEF_TARGET_LIST="x86_64-softmmu"
> +TARGET_LIST=${TARGET_LIST:-$DEF_TARGET_LIST} \
> +build_qemu
> +install_qemu
> +export PATH="${PATH}:$(pwd)"
> +avocado vt-bootstrap --yes-to-all --vt-type qemu
> +avocado run boot --vt-qemu-bin ./x86_64-softmmu/qemu-system-x86_64
> -- 
> 2.17.0
> 
> 
