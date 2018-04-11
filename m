Received: from eggs.gnu.org ([2001:4830:134:3::10]:55046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f6BTA-0005at-Pj
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 04:51:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f6BT7-0003AA-IR
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 04:51:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44526 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1f6BT7-00039V-E9
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 04:51:05 -0400
Date: Wed, 11 Apr 2018 16:50:54 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180411085054.GC2785@lemon.usersys.redhat.com>
References: <20180410193919.28026-1-alex.bennee@linaro.org>
	<20180410193919.28026-2-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180410193919.28026-2-alex.bennee@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 01/24] configure: add test for docker
 availability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, cota@braap.org

On Tue, 04/10 20:38, Alex Benn=E9e wrote:
> This tests for a working docker installation without sudo and sets up
> config-host.mak accordingly. This will be useful from cross compiling
> things in the future.
>=20
> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
> ---
>  configure | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>=20
> diff --git a/configure b/configure
> index 4d0e92c96c..b402befe94 100755
> --- a/configure
> +++ b/configure
> @@ -451,6 +451,7 @@ jemalloc=3D"no"
>  replication=3D"yes"
>  vxhs=3D""
>  libxml2=3D""
> +docker=3D"no"
> =20
>  supported_cpu=3D"no"
>  supported_os=3D"no"
> @@ -5396,6 +5397,23 @@ EOF
>    fi
>  fi
> =20
> +##########################################
> +# Docker and cross-compiler support
> +#
> +# This is specifically for building test
> +# cases for foreign architectures, not
> +# cross-compiling QEMU itself.
> +
> +if has "docker"; then
> +    if docker images  >/dev/null 2>&1 ; then
> +        docker=3D"yes"
> +    else
> +        # docker may be available but using sudo
> +        # so we won't use it for cross-building
> +        docker=3D"maybe"

What is the problem with using sudo for cross-building?

Fam

> +    fi
> +fi
> +
>  ##########################################
>  # End of CC checks
>  # After here, no more $cc or $ld runs
> @@ -5857,6 +5875,7 @@ echo "avx2 optimization $avx2_opt"
>  echo "replication support $replication"
>  echo "VxHS block device $vxhs"
>  echo "capstone          $capstone"
> +echo "docker            $docker"
> =20
>  if test "$sdl_too_old" =3D "yes"; then
>  echo "-> Your SDL version is too old - please upgrade to have SDL supp=
ort"
> @@ -6680,6 +6699,10 @@ if test "$gcov" =3D "yes" ; then
>    echo "GCOV=3D$gcov_tool" >> $config_host_mak
>  fi
> =20
> +if test "$docker" =3D "yes"; then
> +    echo "HAVE_USER_DOCKER=3Dy" >> $config_host_mak
> +fi
> +
>  # use included Linux headers
>  if test "$linux" =3D "yes" ; then
>    mkdir -p linux-headers
> --=20
> 2.16.2
>=20
