Received: from eggs.gnu.org ([2001:4830:134:3::10]:41144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fNdzp-0003rm-DM
	for qemu-devel@nongnu.org; Tue, 29 May 2018 08:45:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fNdzo-0005YL-6y
	for qemu-devel@nongnu.org; Tue, 29 May 2018 08:45:01 -0400
References: <20180525163327.23097-1-kwolf@redhat.com>
	<20180525163327.23097-10-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <869b7bc2-26fa-96cd-3136-313e253db0d4@redhat.com>
Date: Tue, 29 May 2018 14:44:52 +0200
MIME-Version: 1.0
In-Reply-To: <20180525163327.23097-10-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="XgzMrOBA055z4B7J7K8InK3r8oUIJ2I5Y"
Subject: Re: [Qemu-devel] [PATCH 09/14] qemu-iotests: Rewrite 207 for
 blockdev-create job
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jsnow@redhat.com, eblake@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XgzMrOBA055z4B7J7K8InK3r8oUIJ2I5Y
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jsnow@redhat.com, eblake@redhat.com, pkrempa@redhat.com,
 qemu-devel@nongnu.org
Message-ID: <869b7bc2-26fa-96cd-3136-313e253db0d4@redhat.com>
Subject: Re: [PATCH 09/14] qemu-iotests: Rewrite 207 for blockdev-create job
References: <20180525163327.23097-1-kwolf@redhat.com>
 <20180525163327.23097-10-kwolf@redhat.com>
In-Reply-To: <20180525163327.23097-10-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-25 18:33, Kevin Wolf wrote:
> This rewrites the test case 207 to work with the new x-blockdev-create
> job rather than the old synchronous version of the command.
>=20
> Most of the test cases stay the same as before (the exception being som=
e
> improved 'size' options that allow distinguishing which command created=

> the image), but in order to be able to implement proper job handling,
> the test case is rewritten in Python.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/207        | 435 +++++++++++++++++++---------------=
--------
>  tests/qemu-iotests/207.out    |  89 +++++----
>  tests/qemu-iotests/group      |   6 +-
>  tests/qemu-iotests/iotests.py |  23 ++-
>  4 files changed, 264 insertions(+), 289 deletions(-)
>=20
> diff --git a/tests/qemu-iotests/207 b/tests/qemu-iotests/207
> index f5c77852d1..91c1f7e811 100755
> --- a/tests/qemu-iotests/207
> +++ b/tests/qemu-iotests/207

[...]

> +    #
> +    # Test host-key-check options
> +    #
> +    iotests.log("=3D=3D=3D Test host-key-check options =3D=3D=3D")
> +    iotests.log("")

[...]

> +    md5_key =3D subprocess.check_output(
> +        'ssh-keyscan -t rsa 127.0.0.1 2>/dev/null | grep -v "\\^#" | '=
 +
> +        'cut -d" " -f3 | base64 -d | md5sum -b | cut -d" " -f1',
> +        shell=3DTrue).rstrip()
> +
> +    vm.launch()
> +    blockdev_create(vm, { 'driver': 'ssh',
> +                          'location': {
> +                              'path': disk_path,
> +                              'server': {
> +                                  'host': '127.0.0.1',
> +                                  'port': '22'
> +                              },
> +                              'host-key-check': {
> +                                  'mode': 'hash',
> +                                  'type': 'md5',
> +                                  'hash': 'wrong',
> +                              }
> +                          },
> +                          'size': 2097152 })

Technically a change from before where it was 8M, but not a change I'm
opposed to.

[...]

> +    #
> +    # Invalid path and user
> +    #
> +    iotests.log("=3D=3D=3D Invalid path and user =3D=3D=3D")
> +    iotests.log("")
> +
> +    vm.launch()
> +    blockdev_create(vm, { 'driver': 'ssh',
> +                          'location': {
> +                              'path': '/this/is/not/an/existing/path',=

> +                              'server': {
> +                                  'host': '127.0.0.1',
> +                                  'port': '22'
> +                              },
> +                              'host-key-check': {
> +                                  'mode': 'none'
> +                              }
> +                          },
> +                          'size': 4194304 })
> +    blockdev_create(vm, { 'driver': 'ssh',
> +                          'location': {
> +                              'path': disk_path,
> +                              'user': 'invalid user',
> +                              'server': {
> +                                  'host': '127.0.0.1',
> +                                  'port': '22'
> +                              },
> +                              'host-key-check': {
> +                                  'mode': 'none'
> +                              }
> +                          },
> +                          'size': 4194304 })

Technical changes again (the previous test didn't have host-key-check),
but these are good changes.

[...]

> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests=
=2Epy
> index f0f4ef32f0..e945caa6bb 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
> @@ -109,9 +109,11 @@ def qemu_img_pipe(*args):
>          sys.stderr.write('qemu-img received signal %i: %s\n' % (-exitc=
ode, ' '.join(qemu_img_args + list(args))))
>      return subp.communicate()[0]
> =20
> -def img_info_log(filename):
> +def img_info_log(filename, filter_path=3DNone):
>      output =3D qemu_img_pipe('info', '-f', imgfmt, filename)
> -    log(filter_img_info(output, filename))
> +    if not filter_path:
> +        filter_path =3D filename
> +    log(filter_img_info(output, filter_path))
> =20
>  def qemu_io(*args):
>      '''Run qemu-io and return the stdout data'''
> @@ -301,6 +303,13 @@ def file_path(*names):
> =20
>      return paths[0] if len(paths) =3D=3D 1 else paths
> =20
> +def remote_filename(path):

I don't really understand why you have two patches in this series to add
functions to iotests.py, but then you keep on adding more functions in
other patches on the side.

> +    if imgproto =3D=3D 'file':
> +        return imgproto

Shouldn't this be path?

With that fixed:

Reviewed-by: Max Reitz <mreitz@redhat.com>

> +    elif imgproto =3D=3D 'ssh':
> +        return "ssh://127.0.0.1%s" % (path)
> +    else:
> +        raise Exception("Protocol %s not supported" % (imgproto))
> =20
>  class VM(qtest.QEMUQtestMachine):
>      '''A QEMU VM'''
> @@ -595,6 +604,16 @@ def verify_image_format(supported_fmts=3D[], unsup=
ported_fmts=3D[]):
>      if not_sup or (imgfmt in unsupported_fmts):
>          notrun('not suitable for this image format: %s' % imgfmt)
> =20
> +def verify_protocol(supported=3D[], unsupported=3D[]):
> +    assert not (supported and unsupported)
> +
> +    if 'generic' in supported:
> +        return
> +
> +    not_sup =3D supported and (imgproto not in supported)
> +    if not_sup or (imgproto in unsupported):
> +        notrun('not suitable for this protocol: %s' % imgproto)
> +
>  def verify_platform(supported_oses=3D['linux']):
>      if True not in [sys.platform.startswith(x) for x in supported_oses=
]:
>          notrun('not suitable for this OS: %s' % sys.platform)
>=20



--XgzMrOBA055z4B7J7K8InK3r8oUIJ2I5Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsNS0QACgkQ9AfbAGHV
z0AjWAgAoKuAMhTxhTt9y7A26caPJXi8XB44HT3p8Cb+ipMM+OG2j5/bu8w1AmH0
+MC1u5ke4yVQi/q4URxBrbczRf/cY8v1XyvaIGDsNMywWOU1TNzi3491WAYH9xQu
aJr03kju8HwW8Qji7dEhcBgFFkFsvAph+efRqauJ6DYLy2+GPV0144e4EvU4IVwy
E2iDt+Anu31tfiVOyQvCBRnPgCmpnoW9eMyfsKz1i6KJmAR+Pe0qsFoZU0Sc5eAw
JhTuqU1ziQdzXCzSBTGgkOliVXNDAU2A3xYhtdHR3bg3K7z5B+WgwQs2M6iA2CVX
iDOuxMlLOn3DW3V5ty0s/5r8qPSMPw==
=ZLz8
-----END PGP SIGNATURE-----

--XgzMrOBA055z4B7J7K8InK3r8oUIJ2I5Y--
