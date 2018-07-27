Received: from eggs.gnu.org ([2001:4830:134:3::10]:48989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fiylh-0005ks-33
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 05:10:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fiyld-0003KP-SF
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 05:10:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59518 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fiyld-0003Jw-EX
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 05:10:33 -0400
Date: Fri, 27 Jul 2018 17:10:30 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180727091030.GE19416@lemon.usersys.redhat.com>
References: <20180621122638.12113-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180621122638.12113-1-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] travis: Test out-of-tree builds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org

On Thu, 06/21 09:26, Philippe Mathieu-Daud=E9 wrote:
> Force one config to build 'out-of-tree' (object files and executables
> are created in a tree outside the project source code).
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
> I noticed various out-of-tree issue in the last 2 merge windows.
>=20
> Pseudo-randomly picked a build from the matrix which covers system + us=
er.
>=20
>  .travis.yml | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/.travis.yml b/.travis.yml
> index fabfe9ec34..02e096f6a9 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -50,6 +50,8 @@ notifications:
>      on_failure: always
>  env:
>    global:
> +    - SRC_DIR=3D"."
> +    - BUILD_DIR=3D"."
>      - TEST_CMD=3D"make check"
>      - MAKEFLAGS=3D"-j3"
>    matrix:
> @@ -69,11 +71,15 @@ before_install:
>    - wget -O - http://people.linaro.org/~alex.bennee/qemu-submodule-git=
-seed.tar.xz | tar -xvJ
>    - git submodule update --init --recursive
>  before_script:
> -  - ./configure ${CONFIG} || { cat config.log && exit 1; }
> +  - mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
> +  - ${SRC_DIR}/configure ${CONFIG} || { cat config.log && exit 1; }
>  script:
>    - make ${MAKEFLAGS} && ${TEST_CMD}
>  matrix:
>    include:
> +    # Test out-of-tree builds
> +    - env: CONFIG=3D"--enable-debug --enable-debug-tcg"
> +           BUILD_DIR=3D"out-of-tree/build/dir" SRC_DIR=3D"../../.."

Is a three-level nesting really necessary? I think a simple './build' dir=
 should
do.

>      # Test with Clang for compile portability (Travis uses clang-5.0)
>      - env: CONFIG=3D"--disable-system"
>        compiler: clang
> --=20
> 2.18.0.rc2
>=20

Fam
