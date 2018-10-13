Received: from eggs.gnu.org ([2001:4830:134:3::10]:38261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gBOWs-0004n3-Bn
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 14:20:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gBOWr-0003Mu-Kc
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 14:20:46 -0400
References: <20181013050227.17022-1-ehabkost@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <219bba9b-4102-f838-a46f-11b9704ca78f@redhat.com>
Date: Sat, 13 Oct 2018 20:20:25 +0200
MIME-Version: 1.0
In-Reply-To: <20181013050227.17022-1-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC] Require Python 3 for building QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>
Cc: qemu-block@nongnu.org, "Daniel P. Berrange" <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 13.10.18 07:02, Eduardo Habkost wrote:
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> I'd like to do this in QEMU 3.1.  I think it's time to drop
> support for old systems that have only Python 2.
>=20
> We still have a few scripts that are not required for building
> QEMU that still work only with Python 2 (iotests being the most
> relevant set).  Requiring Python 3 for building QEMU won't
> prevent people from using those scripts with Python 2 until they
> are finally ported.

It very much does because the iotests specifically use the python path
qemu was configured with.

To fix this, configure would need to write something else for into
tests/qemu-iotests/common.env for $PYTHON.  But what?  I don't really
want to introduce a new configure option for this.

So the real fix is indeed to make the iotests work with Python 3, and I
think that needs to be done before we can require Python 3.  Maybe it
even needs to be done at the same time.

Max

> ---
>  configure   | 8 ++++----
>  .travis.yml | 2 +-
>  2 files changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/configure b/configure
> index f89d293585..43b45745dc 100755
> --- a/configure
> +++ b/configure
> @@ -885,7 +885,7 @@ fi
> =20
>  : ${make=3D${MAKE-make}}
>  : ${install=3D${INSTALL-install}}
> -: ${python=3D${PYTHON-python}}
> +: ${python=3D${PYTHON-python3}}
>  : ${smbd=3D${SMBD-/usr/sbin/smbd}}
> =20
>  # Default objcc to clang if available, otherwise use CC
> @@ -1730,13 +1730,13 @@ exit 0
>  fi
> =20
>  if ! has $python; then
> -  error_exit "Python not found. Use --python=3D/path/to/python"
> +  error_exit "Python 3 not found. Use --python=3D/path/to/python"
>  fi
> =20
>  # Note that if the Python conditional here evaluates True we will exit
>  # with status 1 which is a shell 'false' value.
> -if ! $python -c 'import sys; sys.exit(sys.version_info < (2,7))'; then
> -  error_exit "Cannot use '$python', Python 2 >=3D 2.7 or Python 3 is r=
equired." \
> +if ! $python -c 'import sys; sys.exit(sys.version_info < (3,0))'; then
> +  error_exit "Cannot use '$python', Python 3 is required." \
>        "Use --python=3D/path/to/python to specify a supported Python."
>  fi
> =20
> diff --git a/.travis.yml b/.travis.yml
> index 95be6ec59f..caca9685fa 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -5,7 +5,7 @@ sudo: false
>  dist: trusty
>  language: c
>  python:
> -  - "2.6"
> +  - "3.6"
>  compiler:
>    - gcc
>  cache: ccache
>=20
