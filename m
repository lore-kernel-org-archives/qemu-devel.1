Received: from eggs.gnu.org ([2001:4830:134:3::10]:56027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fcmcU-0005sW-AN
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 02:59:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fcmcR-0002ze-9N
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 02:59:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32980 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fcmcR-0002zN-33
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 02:59:27 -0400
Date: Tue, 10 Jul 2018 14:59:22 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180710065922.GL17581@lemon.usersys.redhat.com>
References: <20180709152117.21585-1-alex.bennee@linaro.org>
	<20180709152117.21585-6-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180709152117.21585-6-alex.bennee@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for 3.0 05/10] docker: move make check into
 check_qemu helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: cota@braap.org, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, qemu-devel@nongnu.org

On Mon, 07/09 16:21, Alex Benn=E9e wrote:
> Not all docker images can run the check step. Let's everything into a

"move everything"?

> common helper so we don't need to replicate checks in the future.
>=20
> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
> ---
>  tests/docker/common.rc  | 10 ++++++++++
>  tests/docker/test-clang |  2 +-
>  tests/docker/test-debug |  2 +-
>  tests/docker/test-full  |  2 +-
>  tests/docker/test-quick |  2 +-
>  5 files changed, 14 insertions(+), 4 deletions(-)
>=20
> diff --git a/tests/docker/common.rc b/tests/docker/common.rc
> index ba1f942328..cfc620d554 100755
> --- a/tests/docker/common.rc
> +++ b/tests/docker/common.rc
> @@ -40,6 +40,16 @@ build_qemu()
>      make $MAKEFLAGS
>  }
> =20
> +check_qemu()
> +{
> +    if test -z "$@"; then
> +        TEST=3D"check"
> +    else
> +        TEST=3D"$@"
> +    fi
> +    make $MAKEFLAGS $TEST
> +}
> +
>  test_fail()
>  {
>      echo "$@"
> diff --git a/tests/docker/test-clang b/tests/docker/test-clang
> index e90a793178..324e341cea 100755
> --- a/tests/docker/test-clang
> +++ b/tests/docker/test-clang
> @@ -23,5 +23,5 @@ OPTS=3D"--cxx=3Dclang++ --cc=3Dclang --host-cc=3Dclan=
g"
>  #OPTS=3D"$OPTS --extra-cflags=3D-fsanitize=3Dundefined \
>      #--extra-cflags=3D-fno-sanitize=3Dfloat-divide-by-zero"
>  build_qemu $OPTS
> -make $MAKEFLAGS check
> +check_qemu
>  install_qemu
> diff --git a/tests/docker/test-debug b/tests/docker/test-debug
> index d3f9f70d01..137f4f2ddc 100755
> --- a/tests/docker/test-debug
> +++ b/tests/docker/test-debug
> @@ -22,5 +22,5 @@ OPTS=3D"--cxx=3Dclang++ --cc=3Dclang --host-cc=3Dclan=
g"
>  OPTS=3D"--enable-debug --enable-sanitizers $OPTS"
> =20
>  build_qemu $OPTS
> -make $MAKEFLAGS V=3D1 check
> +check_qemu check V=3D1
>  install_qemu
> diff --git a/tests/docker/test-full b/tests/docker/test-full
> index b4e42d25d7..aadc0f00a2 100755
> --- a/tests/docker/test-full
> +++ b/tests/docker/test-full
> @@ -15,4 +15,4 @@
> =20
>  cd "$BUILD_DIR"
> =20
> -build_qemu && make check $MAKEFLAGS && install_qemu
> +build_qemu && check_qemu && install_qemu
> diff --git a/tests/docker/test-quick b/tests/docker/test-quick
> index 3b7bce6105..eee59c55fb 100755
> --- a/tests/docker/test-quick
> +++ b/tests/docker/test-quick
> @@ -18,5 +18,5 @@ cd "$BUILD_DIR"
>  DEF_TARGET_LIST=3D"x86_64-softmmu,aarch64-softmmu"
>  TARGET_LIST=3D${TARGET_LIST:-$DEF_TARGET_LIST} \
>  build_qemu
> -make check $MAKEFLAGS
> +check_qemu
>  install_qemu
> --=20
> 2.17.1
>=20
