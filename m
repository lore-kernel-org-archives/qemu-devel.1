Received: from eggs.gnu.org ([2001:4830:134:3::10]:57249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f5t5O-0006QY-50
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 09:13:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f5t5J-0005vP-VZ
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 09:13:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36500 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f5t5J-0005v3-Po
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 09:13:17 -0400
References: <20180410120222.31845-1-tournier.elie@gmail.com>
	<20180410120222.31845-2-tournier.elie@gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c6e49f50-0cd0-c118-f080-48751de595ec@redhat.com>
Date: Tue, 10 Apr 2018 08:13:00 -0500
MIME-Version: 1.0
In-Reply-To: <20180410120222.31845-2-tournier.elie@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="GHXLIqOf82NFWYzYlgVFIkgbVRtnP05lP"
Subject: Re: [Qemu-devel] [PATCH v2 1/2 for-2.12?] qapi: Parameter gl of
 DisplayType now accept an enum
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Elie Tournier <tournier.elie@gmail.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, Elie Tournier <elie.tournier@collabora.com>, kraxel@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GHXLIqOf82NFWYzYlgVFIkgbVRtnP05lP
From: Eric Blake <eblake@redhat.com>
To: Elie Tournier <tournier.elie@gmail.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, Elie Tournier <elie.tournier@collabora.com>,
 kraxel@redhat.com
Message-ID: <c6e49f50-0cd0-c118-f080-48751de595ec@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/2 for-2.12?] qapi: Parameter gl of
 DisplayType now accept an enum
References: <20180410120222.31845-1-tournier.elie@gmail.com>
 <20180410120222.31845-2-tournier.elie@gmail.com>
In-Reply-To: <20180410120222.31845-2-tournier.elie@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/10/2018 07:02 AM, Elie Tournier wrote:
> Signed-off-by: Elie Tournier <elie.tournier@collabora.com>
> ---
>  qapi/ui.json | 21 ++++++++++++++++++++-
>  vl.c         | 10 +++++-----
>  2 files changed, 25 insertions(+), 6 deletions(-)
>=20
> diff --git a/qapi/ui.json b/qapi/ui.json
> index 5d01ad4304..c8005867e5 100644
> --- a/qapi/ui.json
> +++ b/qapi/ui.json
> @@ -1019,6 +1019,25 @@
>  { 'struct'  : 'DisplayGTK',
>    'data'    : { '*grab-on-hover' : 'bool' } }
> =20
> + ##
> + # @DisplayGLMode:
> + #
> + # Display OpenGL mode.
> + #
> + # 'off'   Disable OpenGL (default).

Wrong format; this should be:

# @off: Disable OpenGL (default).

> + # 'on'    Use OpenGL, pick context type automatically.
> + #         Would better be named 'auto' but is called 'on' for backwar=
d
> + #         compatibility with bool type.

See below...

> + # 'core'  Use OpenGL with Core (desktop) Context.
> + # 'es'    Use OpenGL with ES (embedded systems) Context.
> + #
> + # Since: 2.13
> + #
> + ##
> + { 'enum'    : 'DisplayGLMode',
> +   'data'    : [ 'off', 'on', 'core', 'es' ] }
> +
> +
>  ##
>  # @DisplayType:
>  #
> @@ -1048,7 +1067,7 @@
>    'base'    : { 'type'           : 'DisplayType',
>                  '*full-screen'   : 'bool',
>                  '*window-close'  : 'bool',
> -                '*gl'            : 'bool' },
> +                '*gl'            : 'DisplayGLMode' },

DisplayOptions was added in 2.12.  This is a backwards-incompatible
change in QMP (you CANNOT change 'bool' to 'DisplayGLMode' across
releases, because the on-the-wire representation differs; pre-patch it
would be "gl":true, post-patch it is "gl":"on").  So if it affects QMP,
and we want it, this patch either HAS to go in 2.12, or we have to have
more finesse (perhaps by using an 'alternate' type in the QAPI) so that
it remains backwards-compatible.

/me goes and looks at introspection output...

You may be in luck - there is no instance of 'window-close' in the
introspection output, which means 'DisplayType' exists only for ease of
command-line parsing and is not currently used by QMP, so tweaks here
are not affecting the command line.

That said, you can STILL name the enum value something smarter than 'on'
IF you make the change now, for 2.12, given that the QAPI type was only
introduced in 2.12 (you only have to worry about backwards compatibility
if 2.11 already parsed gl=3Don).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--GHXLIqOf82NFWYzYlgVFIkgbVRtnP05lP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrMuFwACgkQp6FrSiUn
Q2onBwf+NhCeWl3bvvHY9a/x+74q3kb/XivxZFemRCRY2t6fv+Fd95LAVMnvqrev
nv5j3XUEDMmxjIa57LVIT3w+62zJUCKGnep+19w6xUC4oKA22ymgIG8/ssF4AJY2
cEkQWmXCHYpqzDWU0KGku6ISr0It/Gmikag/nPVk7+nqogGA0TpLy8xsjE+hz4QI
FZC+DqKTRWUJSsVSnK9Q3XlVtYVdlBbYPMYwJKjzlaLjPxyYtJ+9IZzA3MwMf+wl
0Knw4jgj+opMtK4q/mFPO5AeXqhYma3e/K9xBsCyvCpNsk5esSOAj7iTf9WnMwb+
H/lvPsPHGWGE0xFWtfGOGjEcOhOrWw==
=i+u8
-----END PGP SIGNATURE-----

--GHXLIqOf82NFWYzYlgVFIkgbVRtnP05lP--
