Received: from eggs.gnu.org ([2001:4830:134:3::10]:52600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ffgsN-0005Gc-Kz
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 03:27:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ffgsM-0006Mc-FV
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 03:27:55 -0400
Date: Wed, 18 Jul 2018 08:27:42 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180718072742.GC9812@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180717234015.22700-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180717234015.22700-1-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.1] qemu-iotests: Adapt to moved
 location of StringIO module in py3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

On Tue, Jul 17, 2018 at 08:40:15PM -0300, Philippe Mathieu-Daud=C3=A9 wro=
te:
> Since 356dc290f the Fedora image default to Python3.
>=20
> This fixes:
>=20
>   $ make docker-test-block@fedora
>   [...]
>   045         [failed, exit status 1] - output mismatch (see 045.out.ba=
d)
>   --- /tmp/qemu-test/src/tests/qemu-iotests/045.out       2018-07-17 16=
:56:18.000000000 +0000
>   +++ /tmp/qemu-test/build/tests/qemu-iotests/045.out.bad 2018-07-17 17=
:19:22.448409007 +0000
>   @@ -1,5 +1,6 @@
>   -...........
>   ---------------------------------------------------------------------=
--
>   -Ran 11 tests
>   -
>   -OK
>   +Traceback (most recent call last):
>   +  File "045", line 178, in <module>
>   +    iotests.main(supported_fmts=3D['raw'])
>   +  File "/tmp/qemu-test/src/tests/qemu-iotests/iotests.py", line 682,=
 in main
>   +    import StringIO
>   +ModuleNotFoundError: No module named 'StringIO'
>   132         [failed, exit status 1] - output mismatch (see 132.out.ba=
d)
>   148         [failed, exit status 1] - output mismatch (see 148.out.ba=
d)
>   152         [failed, exit status 1] - output mismatch (see 152.out.ba=
d)
>=20
>   Failures: 045 132 148 152
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  tests/qemu-iotests/iotests.py | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests=
.py
> index 4e67fbbe96..2fc7165fb9 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
> @@ -679,13 +679,17 @@ def main(supported_fmts=3D[], supported_oses=3D['=
linux'], supported_cache_modes=3D[],
> =20
>      # We need to filter out the time taken from the output so that qem=
u-iotest
>      # can reliably diff the results against master output.
> -    import StringIO
> +    try:
> +        from StringIO import StringIO
> +    except ImportError:
> +        from io import StringIO
> +
>      if debug:
>          output =3D sys.stdout
>          verbosity =3D 2
>          sys.argv.remove('-d')
>      else:
> -        output =3D StringIO.StringIO()
> +        output =3D StringIO()
> =20
>      logging.basicConfig(level=3D(logging.DEBUG if debug else logging.W=
ARN))

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
