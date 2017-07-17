Received: from eggs.gnu.org ([2001:4830:134:3::10]:52667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dX9AZ-00030i-NF
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 12:46:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dX9AW-0004t8-Il
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 12:46:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52998)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dX9AW-0004sH-9x
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 12:46:48 -0400
Date: Mon, 17 Jul 2017 17:46:41 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170717164641.GA31820@work-vm>
References: <20170407143847.GM2138@work-vm>
	<1573e08f-9805-eaf4-3fe1-c1172b6ef6e4@amsat.org>
	<1c55bc6d-7ef7-dcf5-81e8-22712f575691@amsat.org>
	<6e4fb953-17b4-a11b-4f98-8ddfd5ff12f8@redhat.com>
	<39dc6b92-dd56-fe33-cd85-92c03d69f133@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <39dc6b92-dd56-fe33-cd85-92c03d69f133@redhat.com>
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
To: Eric Blake <eblake@redhat.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>

* Eric Blake (eblake@redhat.com) wrote:
> On 07/17/2017 08:42 AM, Eric Blake wrote:
> > On 07/13/2017 08:07 AM, Philippe Mathieu-Daud=E9 wrote:
> >> On 04/07/2017 04:21 PM, Philippe Mathieu-Daud=E9 wrote:
> >>> Hi Dave,
> >>>
> >>> On 04/07/2017 11:38 AM, Dr. David Alan Gilbert wrote:
> >>>> Hi,
> >>>>    Fedora 26 has gcc 7.0.1 which has the normal compliment
> >>>> of new fussy warnings; so far I've posted :
> >>>>
> >>>> tests/check-qdict: Fix missing brackets
> >>>> slirp/smb: Replace constant strings by glib string
> >>>>
> >>>> that fix one actual mistake and work around something it's being
> >>>> fussy over.
> >>>>
> >>>> But I've also got a pile of hacks, attached below that I'm
> >>>> not too sure what I'll do with them yet, but they're attached
> >>
> >> ping ... What do we do with them?
> >=20
> > Well, now that I've upgraded to the just-released Fedora 26, it is no=
w
> > mainline gcc and affecting my builds.  So we should really try and fi=
nd
> > patches that silence the warnings (although it counts as bug fixes, s=
o
> > it won't hurt if it doesn't make tomorrow's freeze deadline).
>=20
> FWIW, most of these have been fixed in the meantime; the only remaining
> hack I had to add was:
>=20
> diff --git i/hw/usb/bus.c w/hw/usb/bus.c
> index 5939b273b9..bce011058b 100644
> --- i/hw/usb/bus.c
> +++ w/hw/usb/bus.c
> @@ -407,8 +407,9 @@ void usb_register_companion(const char *masterbus,
> USBPort *ports[],
>  void usb_port_location(USBPort *downstream, USBPort *upstream, int por=
tnr)
>  {
>      if (upstream) {
> -        snprintf(downstream->path, sizeof(downstream->path), "%s.%d",
> -                 upstream->path, portnr);
> +        int l =3D snprintf(downstream->path, sizeof(downstream->path),
> "%s.%d",
> +                         upstream->path, portnr);
> +        assert(l < sizeof(downstream->path));

You may find this doesn't help in some windows builds;  the assert
functions aren't always marked as noreturn (because they pop up a dialog
that asks you whether you want to run into a debugger etc).

Dave

>          downstream->hubcount =3D upstream->hubcount + 1;
>      } else {
>          snprintf(downstream->path, sizeof(downstream->path), "%d", por=
tnr);
>=20
> Gerd, MAINTAINERS lists you; can you come up with something more robust=
?
>=20
> --=20
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
>=20



--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
