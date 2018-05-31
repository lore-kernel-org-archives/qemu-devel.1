Received: from eggs.gnu.org ([2001:4830:134:3::10]:33624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1fOC31-0001iq-7a
	for qemu-devel@nongnu.org; Wed, 30 May 2018 21:06:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1fOC2y-0008Bc-28
	for qemu-devel@nongnu.org; Wed, 30 May 2018 21:06:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44332 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1fOC2x-0008BM-TM
	for qemu-devel@nongnu.org; Wed, 30 May 2018 21:06:31 -0400
References: <20180530200334.24179-1-f4bug@amsat.org>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <22ca41bb-9f8b-e8bb-e676-b5c96f3f9add@redhat.com>
Date: Wed, 30 May 2018 21:06:30 -0400
MIME-Version: 1.0
In-Reply-To: <20180530200334.24179-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Fam Zheng <famz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Amador Pahim <amador@pahim.org>
Cc: qemu-devel@nongnu.org



On 05/30/2018 04:03 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> In order to allow out-of-tree acceptance tests with Avocado,
> create a symlink in the build tree.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> Based-on: 20180530184156.15634-1-crosa@redhat.com
> http://lists.nongnu.org/archive/html/qemu-devel/2018-05/msg06877.html
>=20
> Before:
>=20
>   build_dir$ avocado run /full/path/to/sources/qemu/tests/acceptance/bo=
ot_linux_console.py
>=20
> After
>=20
>   build_dir$ avocado run tests/acceptance/boot_linux_console.py
>=20
> I first wanted to try something like:
>=20
> echo "[datadir.paths]" > .avocado.conf
> echo "test_dir =3D $source_path/tests/acceptance" >> .avocado.conf
>=20

FIY, "$HOME/.config/avocado/avocado.conf" is parsed by default.  Take a
look at the "avocado config" output for the details.

> to run:
>=20
>   build_dir$ avocado run -t console
>=20

I see your point, you'd like the command above to behave similarly to:

  avocado run -t console $avocado_datadir_paths_test_dir

Right?  So, the first compromise solution with current Avocado is:

  echo "[datadir.paths]" > ~/.config/avocado/avocado.conf
  echo "test_dir =3D $source_path/tests/acceptance" >>
~/.config/avocado/avocado.conf

With "$source_path" being something literal, and not a variable.  It
allows individual tests to be found at that location:

  cd /some/random/path
  avocado run boot_linux_console.py

But the following still won't work:

  avocado run -t console
  No test references provided nor any other arguments resolved into
tests. Please double check the executed command.

I do think the current Avocado behavior is somewhat inconsistent,
because list and run should ideally be symmetrical.  With the
configuration above, "list" behaves like this:

   avocado list
INSTRUMENTED
/home/cleber/src/qemu/tests/acceptance/boot_linux_console.py:BootLinuxCon=
sole.test
INSTRUMENTED
/home/cleber/src/qemu/tests/acceptance/version.py:Version.test_qmp_human_=
info_version
INSTRUMENTED /home/cleber/src/qemu/tests/acceptance/vnc.py:Vnc.test_no_vn=
c
INSTRUMENTED
/home/cleber/src/qemu/tests/acceptance/vnc.py:Vnc.test_no_vnc_change_pass=
word
INSTRUMENTED
/home/cleber/src/qemu/tests/acceptance/vnc.py:Vnc.test_vnc_change_passwor=
d_requires_a_password
INSTRUMENTED
/home/cleber/src/qemu/tests/acceptance/vnc.py:Vnc.test_vnc_change_passwor=
d

But at the same, there are security implications: `list` won't
load/execute any test code (different from, say, standard Python
unittests), while "run" obviously will.  So "avocado run" may end up
running what users don't want if a malicious user controls
"$avocado_datadir_paths_test_dir".

What if Avocado introduces an option that would enable the use of
Avocado's test dir when no test reference is given?  This could be
enabled only once (but would be disabled by default):

  echo "[loader]" > ~/.config/avocado/avocado.conf
  echo "use_test_dir_when_no_references_given =3D True" >> >
~/.config/avocado/avocado.conf

  echo "[datadir.paths]" >> ~/.config/avocado/avocado.conf
  echo "test_dir =3D $source_path/tests/acceptance" >>
~/.config/avocado/avocado.conf

And after that, the following would run all "console" tests:

  avocado run -t console

How does this sound?

- Cleber.

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
>=20
