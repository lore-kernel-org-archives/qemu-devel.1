Received: from eggs.gnu.org ([2001:4830:134:3::10]:50342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fOATW-0002eX-9g
	for qemu-devel@nongnu.org; Wed, 30 May 2018 19:25:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fOATS-0008Ng-7a
	for qemu-devel@nongnu.org; Wed, 30 May 2018 19:25:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34908)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fOATR-0008NY-NS
	for qemu-devel@nongnu.org; Wed, 30 May 2018 19:25:46 -0400
Date: Wed, 30 May 2018 20:25:40 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180530232540.GL7451@localhost.localdomain>
References: <20180530200334.24179-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180530200334.24179-1-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] configure: Enable out-of-tree
 acceptance tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Fam Zheng <famz@redhat.com>, Amador Pahim <amador@pahim.org>, Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org

On Wed, May 30, 2018 at 05:03:34PM -0300, Philippe Mathieu-Daud=E9 wrote:
> In order to allow out-of-tree acceptance tests with Avocado,
> create a symlink in the build tree.
>=20

"In other to allow" seems to imply that running acceptance tests
on an out-of-tree build is impossible without this patch, but:

[...]
> Before:
>=20
>   build_dir$ avocado run /full/path/to/sources/qemu/tests/acceptance/bo=
ot_linux_console.py
>=20
> After
>=20
>   build_dir$ avocado run tests/acceptance/boot_linux_console.py
>=20

This seems to imply that running them is possible, but this patch
makes it more convenient.

Is this just for convenience, or necessary to allow acceptance
tests to run properly?  Can this be clarified in the commit
message?


> I first wanted to try something like:
>=20
> echo "[datadir.paths]" > .avocado.conf
> echo "test_dir =3D $source_path/tests/acceptance" >> .avocado.conf
>=20
> to run:
>=20
>   build_dir$ avocado run -t console
>=20
> but this doesn't work this way, I'd have to use
>=20
>   build_dir$ avocado --config .avocado.conf boot_linux_console.py -t co=
nsole
>=20
> which isn't a win.
> ---
>  configure | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/configure b/configure
> index a6a4616c3e..0763ebe5ba 100755
> --- a/configure
> +++ b/configure
> @@ -7213,9 +7213,11 @@ for rom in seabios vgabios ; do
>  done
> =20
>  # set up tests data directory
> -if [ ! -e tests/data ]; then
> -    symlink "$source_path/tests/data" tests/data
> -fi
> +for tests_subdir in acceptance data; do
> +    if [ ! -e tests/$tests_subdir ]; then
> +        symlink "$source_path/tests/$tests_subdir" tests/$tests_subdir
> +    fi
> +done
> =20
>  # set up qemu-iotests in this build directory
>  iotests_common_env=3D"tests/qemu-iotests/common.env"
> --=20
> 2.17.1
>=20

--=20
Eduardo
