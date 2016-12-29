Received: from eggs.gnu.org ([2001:4830:134:3::10]:39262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cMebz-00064h-H8
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 12:35:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cMebu-0002yR-KJ
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 12:35:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60152)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cMebu-0002xx-Bi
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 12:35:26 -0500
References: <E14D0C7B-2C4B-4D29-AC31-A651AB7573DE@gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c299a5a4-c27e-b6f8-1d6c-c91f96c97a57@redhat.com>
Date: Thu, 29 Dec 2016 11:35:23 -0600
MIME-Version: 1.0
In-Reply-To: <E14D0C7B-2C4B-4D29-AC31-A651AB7573DE@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="DejDc6e15SBTROWOwxKuOWoGUfKenFFH4"
Subject: Re: [Qemu-devel] [PATCH] ui/cocoa.m: add Speed menu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel qemu-devel <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DejDc6e15SBTROWOwxKuOWoGUfKenFFH4
From: Eric Blake <eblake@redhat.com>
To: Programmingkid <programmingkidx@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel qemu-devel <qemu-devel@nongnu.org>
Message-ID: <c299a5a4-c27e-b6f8-1d6c-c91f96c97a57@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] ui/cocoa.m: add Speed menu
References: <E14D0C7B-2C4B-4D29-AC31-A651AB7573DE@gmail.com>
In-Reply-To: <E14D0C7B-2C4B-4D29-AC31-A651AB7573DE@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/29/2016 11:24 AM, Programmingkid wrote:
> Programs running inside of QEMU can sometimes use more CPU time than is=
 really
> needed. To solve this problem, we just need to throttle the virtual CPU=
=2E This
> feature will stop laptops from burning up.=20
>=20
> This patch adds a menu called Speed that has menu items from 10 to 1. T=
hey
> represent the speed options. 10 is full speed and 1 is slowest.

Why not make it a type-in box where the user specifies a percentage, up
to 100 (unthrottled)?

Is this feature present in the other GUIs, such as the gtk view?  I'm
reluctant to invent features for the less-tested cocoa interface that
are not FIRST present on other interfaces.

>=20
> Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
> ---
>  ui/cocoa.m | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++
>  1 file changed, 56 insertions(+)

> =20
> +/* Used by the Speed menu items */
> +- (void)adjustSpeed:(id)sender
> +{
> +    /* 10 has two digits in it - plus the NULL termination at the end =
*/
> +    const int max_title_size =3D 3;
> +    char menu_item_title[max_title_size];
> +    int speed, menu_number, count, item;
> +    NSMenu *menu;
> +    NSArray *itemArray;
> +
> +    // uncheck all the menu items in the Speed menu
> +    menu =3D [sender menu];
> +	if(menu !=3D nil)
> +	{
> +		count =3D [[menu itemArray] count];

TAB damage.

> +		itemArray =3D [menu itemArray];
> +		for(item =3D 0; item < count; item++)  // unselect each item

Space after 'for'.

> +			[[itemArray objectAtIndex: item] setState: NSOffState];
> +	}
> +
> +    // check the menu item
> +    [sender setState: NSOnState];
> +
> +    // get the menu number
> +    snprintf(menu_item_title, max_title_size, "%s", [[sender title] cS=
tringUsingEncoding: NSASCIIStringEncoding]);
> +    sscanf(menu_item_title, "%d", &menu_number);

Eew. That just feels fragile.

> +
> +     /* Calculate the speed */
> +    // inverse relationship between menu item number and speed
> +    speed =3D -1 * menu_number + 10;
> +    speed =3D speed * 10;
> +    cpu_throttle_set(speed);
> +    COCOA_DEBUG("cpu throttling at %d%c\n", cpu_throttle_get_percentag=
e(), '%');

Again, I think that '100%' makes more intuitive sense than '10' for
knowing that my VM is running unthrottled.  The amount of math you have
to do to transform the menu numbers into the cpu_throttle_set() call is
a sign that your mapping is rather complex compared to a more intuitive
setup.

> +}
> +
>  @end
> =20
> =20
> @@ -1316,6 +1353,25 @@ int main (int argc, const char * argv[]) {
>      [menuItem setSubmenu:menu];
>      [[NSApp mainMenu] addItem:menuItem];
> =20
> +    // Speed menu
> +    menu =3D [[NSMenu alloc] initWithTitle:@"Speed"];
> +    menuItem =3D [[[NSMenuItem alloc] initWithTitle:@"10 (fastest)" ac=
tion:@selector(adjustSpeed:) keyEquivalent:@""] autorelease];
> +    [menuItem setState: NSOnState];
> +    [menu addItem: menuItem];
> +    [menu addItem: [[[NSMenuItem alloc] initWithTitle:@"9" action:@sel=
ector(adjustSpeed:) keyEquivalent:@""] autorelease]];
> +    [menu addItem: [[[NSMenuItem alloc] initWithTitle:@"8" action:@sel=
ector(adjustSpeed:) keyEquivalent:@""] autorelease]];

And this adds a LOT of menu items, compared to what you could get if a
single menu item opens up a dialog box for typing in a number that is
validated to be between 1 and 100.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--DejDc6e15SBTROWOwxKuOWoGUfKenFFH4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYZUlbAAoJEKeha0olJ0NqgtEIAIbE/nn0sgPd3g+voq3YHuZk
+1MCeqUqlYT2MRsXjtDFA/yiqlDIlCFkXfWsACZ9ohGyuEcLgUydBQme+SfIGI+o
8jDFKxeTRsJFUZ49CHJNBq8sxK48QnFGzsRDC0t4FFKCvksOVIEtmABV/95X0Abo
uYgAYk0KV5nISM9ZyJgVolyS3YL/gVWHz4EcpfeJeR2mDEDcrbzME8LaU2AVMYEL
KjP13h1pxQt4sGda6YvEL/Ei2M9WlHIkPSTDt4h5kcI6UeQXAjGX03OETh++X62z
1Ozg0iVqN+88MRp77vS1s9Gi7Ia8MQdKrnmZ0iRIbBQPbA0aDPS4DpRu7t7DHio=
=+UUF
-----END PGP SIGNATURE-----

--DejDc6e15SBTROWOwxKuOWoGUfKenFFH4--
