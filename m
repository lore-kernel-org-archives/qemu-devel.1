Received: from eggs.gnu.org ([2001:4830:134:3::10]:55846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dX6pH-0005KJ-Dt
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 10:16:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dX6pE-0004eB-4x
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 10:16:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48266)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dX6pD-0004dp-V5
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 10:16:40 -0400
Message-ID: <1500300997.12570.8.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 17 Jul 2017 16:16:37 +0200
In-Reply-To: <39dc6b92-dd56-fe33-cd85-92c03d69f133@redhat.com>
References: <20170407143847.GM2138@work-vm>
	<1573e08f-9805-eaf4-3fe1-c1172b6ef6e4@amsat.org>
	<1c55bc6d-7ef7-dcf5-81e8-22712f575691@amsat.org>
	<6e4fb953-17b4-a11b-4f98-8ddfd5ff12f8@redhat.com>
	<39dc6b92-dd56-fe33-cd85-92c03d69f133@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Hacks for building on gcc 7 / Fedora 26
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, "Dr. David Alan
	Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org

  Hi,

> FWIW, most of these have been fixed in the meantime; the only
> remaining
> hack I had to add was:
>=20
> diff --git i/hw/usb/bus.c w/hw/usb/bus.c
> index 5939b273b9..bce011058b 100644
> --- i/hw/usb/bus.c
> +++ w/hw/usb/bus.c
> @@ -407,8 +407,9 @@ void usb_register_companion(const char
> *masterbus,
> USBPort *ports[],
> =C2=A0void usb_port_location(USBPort *downstream, USBPort *upstream, in=
t
> portnr)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (upstream) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0snprintf(downstream->p=
ath, sizeof(downstream->path),
> "%s.%d",
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0upstream->path, portnr);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int l =3D snprintf(dow=
nstream->path, sizeof(downstream->path),
> "%s.%d",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0upstream->path, portnr);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0assert(l < sizeof(down=
stream->path));

Approach looks ok to me.

Maximum hub chain length is 5, number of ports hubs is limited too,
you'll never need more that two digits for port numbers.  So 2*5 plus 4
connecting dots =3D> 14 chars is the max strlen.  path size is 16, so it
will fit, including the terminating \0.

Trying things like "assert(portnr <=3D 99)" have no effect on the
possible string length calculated by gcc7.

cheers,
  Gerd
