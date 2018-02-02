Received: from eggs.gnu.org ([208.118.235.92]:39666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ehdU8-0001Pv-Bt
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:46:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ehdT4-0005HQ-Ck
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:42:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35414)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ehdHU-0008O2-Em
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:29:36 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 94C9B78559
	for <qemu-devel@nongnu.org>; Fri,  2 Feb 2018 15:29:35 +0000 (UTC)
References: <20180202111022.19269-1-kraxel@redhat.com>
	<20180202111022.19269-5-kraxel@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <50c1cdbc-411a-2b90-f720-0b8e4372997d@redhat.com>
Date: Fri, 2 Feb 2018 09:29:17 -0600
MIME-Version: 1.0
In-Reply-To: <20180202111022.19269-5-kraxel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="CH8kEKQQwRcsiI2GUik9B5ti10h8GyjnC"
Subject: Re: [Qemu-devel] [PATCH v3 04/12] gtk: add and use DisplayOptions +
 DisplayGTK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CH8kEKQQwRcsiI2GUik9B5ti10h8GyjnC
From: Eric Blake <eblake@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <50c1cdbc-411a-2b90-f720-0b8e4372997d@redhat.com>
Subject: Re: [PATCH v3 04/12] gtk: add and use DisplayOptions + DisplayGTK
References: <20180202111022.19269-1-kraxel@redhat.com>
 <20180202111022.19269-5-kraxel@redhat.com>
In-Reply-To: <20180202111022.19269-5-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/02/2018 05:10 AM, Gerd Hoffmann wrote:
> Add QAPI DisplayType enum, DisplayOptions union and DisplayGTK struct.
> Switch gtk configuration to use the qapi type.
>=20
> Some bookkeeping (fullscreen for example) is done twice now, this is
> temporary until more/all UIs are switched over to qapi configuration.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/ui/console.h |  9 ++++----
>  ui/gtk.c             | 32 ++++++++++++++++-------------
>  vl.c                 | 23 ++++++++++++++++-----
>  qapi/ui.json         | 58 ++++++++++++++++++++++++++++++++++++++++++++=
++++++++
>  4 files changed, 98 insertions(+), 24 deletions(-)
>=20

> +++ b/vl.c

>              if (strstart(opts, ",grab_on_hover=3D", &nextopt)) {
>                  opts =3D nextopt;
> +                dpy.u.gtk.has_grab_on_hover =3D true;
>                  if (strstart(opts, "on", &nextopt)) {

Pre-existing: this doesn't flag stuff like "grab_on_hover=3Donly" as
bogus.  But doing further cleanups can be later patches; for example,
Markus' work to unify command-line parsing through QAPI visits.

> +++ b/qapi/ui.json
> @@ -982,3 +982,61 @@
>    'data': { '*device': 'str',
>              '*head'  : 'int',
>              'events' : [ 'InputEvent' ] } }
> +
> +
> +##

Is two blank lines typical here, or just one?

> +# @DisplayNoOpts:
> +#
> +# Empty struct for displays without config options.
> +#
> +# Since: 2.12
> +#
> +##
> +{ 'struct'  : 'DisplayNoOpts',
> +  'data'    : { } }
> +
> +##
> +# @DisplayGTK:
> +#
> +# GTK display options.
> +#
> +# @grab-on-hover: Grab keyboard input on mouse hover.
> +#
> +# Since: 2.12
> +#
> +##
> +{ 'struct'  : 'DisplayGTK',
> +  'data'    : { '*grab-on-hover' : 'bool' } }
> +
> +##
> +# @DisplayType:
> +#
> +# Display (user interface) type.
> +#
> +# Since: 2.12
> +#
> +##
> +{ 'enum'    : 'DisplayType',
> +  'data'    : [ 'none', 'gtk' ] }
> +
> +##
> +# @DisplayOptions:
> +#
> +# Display (user interface) options.
> +#
> +# @type:          Which DisplayType qemu should use.
> +# @full-screen:   Start user interface in fullscreen mode (default: of=
f).
> +# @window-close:  Allow to quit qemu with window close button (default=
: on).

s/Allow to quit/Allow quitting/

> +# @gl:            Enable OpenGL support (default: off).
> +#
> +# Since: 2.12
> +#
> +##
> +{ 'union'   : 'DisplayOptions',
> +  'base'    : { 'type'           : 'DisplayType',
> +                '*full-screen'   : 'bool',
> +                '*window-close'  : 'bool',
> +                '*gl'            : 'bool' },
> +  'discriminator' : 'type',
> +  'data'    : { 'none'           : 'DisplayNoOpts',
> +                'gtk'            : 'DisplayGTK' } }
>=20

Struct looks okay, and grammar tweak is minor, so you can add
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--CH8kEKQQwRcsiI2GUik9B5ti10h8GyjnC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlp0g80ACgkQp6FrSiUn
Q2oZPwf+OKBML5D/w1dLb0FR+YZwLp1V+5fsbQSV+n6O/kOgTORBfqLxn/S/oxs+
mhuh04DvflOoKJ/bjsekMs3mVzI4biKUY8Eo91bXEbrGOJoU3odtHO8Qj/6dG2ZM
QeB71RK8hpYtGAg0G9eHOCPW/8BtS2s7ZqFG0grqg0ITZxcd6t9b4w54FnMV+jnI
YEufbOPcnnG8P/NVaJL5O8wSXoOQ7QXlxesHZDtN5mFhL1aNPaGqyLR01LWcXhpr
hG7/WHfCyyYwu/Agjz7T9/dSETxVWNQ7exfp0LdX672Ilsx7s8DrsRvq2nLQW+F1
ixzamIUc/fnmQwr+mpdx2ZQOKAFcQg==
=543h
-----END PGP SIGNATURE-----

--CH8kEKQQwRcsiI2GUik9B5ti10h8GyjnC--
