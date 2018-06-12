Received: from eggs.gnu.org ([2001:4830:134:3::10]:53759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fSetz-0003kv-8G
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 04:43:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fSetu-000195-Gh
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 04:43:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45080 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fSetu-00018o-B5
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 04:43:38 -0400
Date: Tue, 12 Jun 2018 16:43:34 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180612084334.GE29380@lemon.usersys.redhat.com>
References: <20180612082823.25507-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180612082823.25507-1-berrange@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] travis: display config.log when configure
 fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>

On Tue, 06/12 09:28, Daniel P. Berrang=E9 wrote:
> When configure fails in CI systems we must be able to see the contents
> of the config.log file to diagnose the root cause.
>=20
> Signed-off-by: Daniel P. Berrang=E9 <berrange@redhat.com>
> ---
>  .travis.yml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/.travis.yml b/.travis.yml
> index 814be151f4..fc9a1fe8a8 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -69,7 +69,7 @@ before_install:
>    - wget -O - http://people.linaro.org/~alex.bennee/qemu-submodule-git=
-seed.tar.xz | tar -xvJ
>    - git submodule update --init --recursive
>  before_script:
> -  - ./configure ${CONFIG}
> +  - ./configure ${CONFIG} || (cat config.log && exit 1)
>  script:
>    - make ${MAKEFLAGS} && ${TEST_CMD}
>  matrix:
> @@ -151,4 +151,4 @@ matrix:
>          - CONFIG=3D"--cc=3Dgcc-7 --cxx=3Dg++-7 --disable-pie --disable=
-linux-user"
>          - TEST_CMD=3D""
>        before_script:
> -        - ./configure ${CONFIG} --extra-cflags=3D"-g3 -O0 -fsanitize=3D=
thread -fuse-ld=3Dgold" || cat config.log
> +        - ./configure ${CONFIG} --extra-cflags=3D"-g3 -O0 -fsanitize=3D=
thread -fuse-ld=3Dgold" || (cat config.log && exit 1)
> --=20
> 2.17.0
>=20

Makes sense. this fixes the status code of before_script, though previous=
ly as
we mask the error with the "|| cat config.log", make will still fail.

Reviewed-by: Fam Zheng <famz@redhat.com>
