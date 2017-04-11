Received: from eggs.gnu.org ([2001:4830:134:3::10]:38913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1cxm8M-0005jo-Ny
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 23:06:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1cxm8H-00044A-Qg
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 23:06:22 -0400
Message-ID: <1491879951.4166.222.camel@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 11 Apr 2017 13:05:51 +1000
In-Reply-To: <20170410081414.GS27571@umbus>
References: <1491396106-26376-1-git-send-email-clg@kaod.org>
	<1491396106-26376-21-git-send-email-clg@kaod.org>
	<20170410081414.GS27571@umbus>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 20/21] ppc/pnv: Add model for Power8 PHB3
 PCIe Host bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On Mon, 2017-04-10 at 18:14 +1000, David Gibson wrote:
> > +=C2=A0=C2=A0=C2=A0 switch (size) {
> > +=C2=A0=C2=A0=C2=A0 case 1:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> > +=C2=A0=C2=A0=C2=A0 case 2:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val =3D bswap16(val);
>=20
> An unconditional bswap() seems unlikely to be correct.=C2=A0 What's the
> purpose of thise?

Though it is :-) I *think* ... I did test with both LE and BE hosts I
believe but Cedric can double check.

>From memory it comes from the fact that the PHB register space is
declared to be big endian since 99% of it actually is.

However the CONFIG_DATA register used to issue config space accesses is
"special" and expect little endian accesses.

However because the whole region is marked BE, qemu will have done
the necessary swapping for BE, which thus needs to be undone for
that specific register unconditionally:

 - BE host will not swap the value, so we get the LE value written by
the guest which needs to be swapped to BE.

 - LE host will have swapped the value as if it was BE except it isn't
so we need to re-swap it.

IE. Another option would be to create a specific memory region just for
that one register but it's easier to just unconditionally swap.

> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> > +=C2=A0=C2=A0=C2=A0 case 4:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val =3D bswap32(val);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>=20
> No 64-bit config registers?

No, they don't exist. (Which is also why an assert isn't a good
idea as other registers do support 64-bit accesses).

Ben.
