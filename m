Received: from eggs.gnu.org ([2001:4830:134:3::10]:54360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1fSj4m-0001Vm-4H
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 09:11:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1fSj4l-0002iR-90
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 09:11:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46794 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pkrempa@redhat.com>) id 1fSj4l-0002i0-2a
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 09:11:07 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 50908401EF24
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 13:11:06 +0000 (UTC)
Date: Tue, 12 Jun 2018 15:10:46 +0200
From: Peter Krempa <pkrempa@redhat.com>
Message-ID: <20180612131046.GB16514@angien.pipo.sk>
References: <20180606135051.GR7451@localhost.localdomain>
	<1528372809-175770-1-git-send-email-imammedo@redhat.com>
	<20180608132105.GA24764@localhost.localdomain>
	<20180611151625.4b2420b8@redhat.com>
	<20180611190607.GU7451@localhost.localdomain>
	<20180611232924.6e04b6f8@igors-macbook-pro.local>
	<20180611223633.GG7451@localhost.localdomain>
	<5cef972d-250b-5464-7482-90fa24d36c80@redhat.com>
	<20180612144205.2169e7a2@redhat.com>
	<1282921e-0d38-7bd2-de8b-64d327dd2549@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="v9Ux+11Zm5mwPlX6"
Content-Disposition: inline
In-Reply-To: <1282921e-0d38-7bd2-de8b-64d327dd2549@redhat.com>
Subject: Re: [Qemu-devel] [libvirt] [PATCH v6 2/2] vl: fix use of
 --daemonize with --preconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michal Privoznik <mprivozn@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, ldoktor@redhat.com, Eduardo Habkost <ehabkost@redhat.com>, libvir-list@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, pbonzini@redhat.com


--v9Ux+11Zm5mwPlX6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 12, 2018 at 15:04:42 +0200, Michal Privoznik wrote:
> On 06/12/2018 02:42 PM, Igor Mammedov wrote:
>=20
> >>>
> >>> Do we really need to make -daemonize and -preconfig work
> >>> together?  libvirt uses -daemonize only for its initial
> >>> capability probing, which shouldn't require -preconfig at all.
> >>>
> >>> Even on that case, I wonder why libvirt doesn't simply create a
> >>> server socket and waits for QEMU to connect instead of using
> >>> -daemonize as a sync point.
> >>>  =20
> >>
> >> because libvirt views qemu as well behaved daemon. Should anything go
> >> wrong libvirt reads qemu's stderr and reports error to upper layers.
> > We can keep daemonizing flow in QEMU as it's now.
> > But Eduardo's idea about libvirt created socked + letting QEMU connect =
to it
> > has a merit. It should fix current deadlock issue with as monitor
> > won't be depending on lead exit event.
>=20
> Not sure about the benefits. Currently, libvirt spawns qemu, waits for
> monitor to show up (currently, the timeout dynamic depending on some
> black magic involving guest RAM size) and if it does not show up in time
> it kills qemu. The same algorithm must be kept in place even for case
> when libvirt would pass pre-opened socket to qemu in case qemu deadlocks
> before being able to communicate over qmp. The only advantage I see is
> libvirt would not need to label the socket (set uid:gid, selinux, ...).
> On the other hand, since it would be libvirt creating the socket what
> would happen on libvirtd restart?

Well, if qemu deadlocks just after spewing out the monitor greeting you
end up in the same situation as the timeout code is not applied later
for regular monitor communication.

Depending on how early the preconfig state happens, keeping in the
timeout may be pointless.

--v9Ux+11Zm5mwPlX6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUn7DGLvflazX+2GwHGwCByjY1GoFAlsfxlQACgkQHGwCByjY
1Gr/QQ//b8FPXFocpdhyjagn/E9SUxINhKdY0Zyy2sO6PcBvVb74FwcTyMTRBorN
MbHgGPZHUu/dAbiG33954exBCj1wlMnXnWMI1kEyj4YJoLh0dEogixmBkWX5tCCA
niqLqep1+OtJb6DLYMy7p7+NWAKwD6OFr4A0eV4kXxe4nZa1w0JBG7jbqLL+Hdkw
o4ikkBQy6lUs1CbQkfyvRBOiglMYAqW4op0Nn806sNTEoY84hOhNKXMNVIBtvQq0
hKMdmZQi7eGb4tsrXMu8VzX9RO2uBZDwP5DYhbzj03A5r+49TPckFXPwNi17H06K
8FsEejTdtXiIAKP6+QIkrBmBzdsacN7VFk3STpL1qxWeMwmT9bSLCSjcLhASuUoo
EAWkFEsidgUcb7x4ZQN/NpM5Qv+Lhh301ynMUcBaWhcGO9pJ02N3c0gHe13cev+V
u/ytcx+hncgQlHm+ObIBixeUhtdImiluL/sZetYjX9s0jZzQc7941cETrG+656I2
t2dhCm2vlphzWY4r0NPaseaslV0ca+l0A+hc9KUUHHvKZfUxPL3IXAlVDBEoo0Wg
juC+ljvspmQIuikwyxGYo5umanLn5mLkn6/zQaaHfFlSk5s6ZRPyvlGbqC2RzaTK
aOC2Y//8hudaD7aVHKCPi3m7w8n2luBbHkRLnHqKLnlbFb0uqX4=
=talJ
-----END PGP SIGNATURE-----

--v9Ux+11Zm5mwPlX6--
