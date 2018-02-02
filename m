Received: from eggs.gnu.org ([208.118.235.92]:55980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ehdOp-0002k9-10
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:38:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ehdNh-0007m4-70
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:37:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35462)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ehdNg-0007jo-51
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:36:00 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3F3ED13AA0
	for <qemu-devel@nongnu.org>; Fri,  2 Feb 2018 15:35:59 +0000 (UTC)
References: <20180202111022.19269-1-kraxel@redhat.com>
	<20180202111022.19269-7-kraxel@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0ef8a626-9623-b87a-b37e-ef4ebdfa8816@redhat.com>
Date: Fri, 2 Feb 2018 09:35:52 -0600
MIME-Version: 1.0
In-Reply-To: <20180202111022.19269-7-kraxel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="67QfVs3alyQpQ4l4FcMCSAOg2Y9SrOrqm"
Subject: Re: [Qemu-devel] [PATCH v3 06/12] vl: drop no_quit variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--67QfVs3alyQpQ4l4FcMCSAOg2Y9SrOrqm
From: Eric Blake <eblake@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
Message-ID: <0ef8a626-9623-b87a-b37e-ef4ebdfa8816@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 06/12] vl: drop no_quit variable
References: <20180202111022.19269-1-kraxel@redhat.com>
 <20180202111022.19269-7-kraxel@redhat.com>
In-Reply-To: <20180202111022.19269-7-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/02/2018 05:10 AM, Gerd Hoffmann wrote:
> Not used any more, delete it.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  vl.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>=20
> diff --git a/vl.c b/vl.c

> @@ -4368,7 +4364,8 @@ int main(int argc, char **argv, char **envp)
>          error_report("-no-frame, -alt-grab and -ctrl-grab are only val=
id "
>                       "for SDL, ignoring option");
>      }
> -    if (no_quit && (display_type !=3D DT_GTK && display_type !=3D DT_S=
DL)) {
> +    if (dpy.has_window_close &&
> +        (display_type !=3D DT_GTK && display_type !=3D DT_SDL)) {
>          error_report("-no-quit is only valid for GTK and SDL, "
>                       "ignoring option");

Does this mean we should move the 'window-close' field out of the common
base type and into DisplayGTK/DisplaySDL instead (where sdl would need
its own type instead of DisplayNoOpts)?  I guess the difference is how
long we have been flagging this error message - if we rearrange the QAPI
type, this code is dead and you've broken the command line that tries to
do window type none combined with -no-quit; but if that command line has
already been documented as broken, it is no real loss.  But if we
haven't had enough of a deprecation period yet, then keeping
window-close global to all variants of the union and doing the runtime
rejection check lets us finish the deprecation period.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--67QfVs3alyQpQ4l4FcMCSAOg2Y9SrOrqm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlp0hVgACgkQp6FrSiUn
Q2qbqQf/ZjF01OskYWC166Y5R2Ej+1XJ9DmJcZMZfxnnDTU7AOu1b53U9TgoZl+l
YOIAhdEhWF6E1KP6rH4YhOSrh4oVahx86pR2KfwVqny92rs+3my9mvVI4U4uPTWi
zAwjo8LpIgSDKTWqmFXkhYKRYhcmvoZPFy60B28A61przRZHhhr+nrlYaoqu+CK9
WROMT1CODcJIRcP58UWSb+nbUi0EsEHSXowspj/SlMd2fe8h0fzMzw5VVWaYpCDf
2DY0ZDTQsQRbt19zZMbB64uOwpZzrCbcywh/kTxb7O5I5SHfJ5T9yyDqsj6lEc5a
x/n7ybcR6EJH6wFeSdvowGIRFYwzZw==
=QByS
-----END PGP SIGNATURE-----

--67QfVs3alyQpQ4l4FcMCSAOg2Y9SrOrqm--
