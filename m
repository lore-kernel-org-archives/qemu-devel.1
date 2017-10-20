Received: from eggs.gnu.org ([2001:4830:134:3::10]:47785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e5V1M-0008Nc-3h
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 06:59:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e5V1I-0004IQ-Uk
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 06:59:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39488)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1e5V1I-0004Hz-LS
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 06:59:16 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 344C17EA94
	for <qemu-devel@nongnu.org>; Fri, 20 Oct 2017 10:59:15 +0000 (UTC)
Message-ID: <1508497148.18146.10.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 20 Oct 2017 12:59:08 +0200
In-Reply-To: <c839fe51-fc84-b297-a669-d8b3a0001017@redhat.com>
References: <20171018095807.101406-1-marcel@redhat.com>
	<69cefa98-5681-5b12-719c-e13fcba969c4@redhat.com>
	<9d4b1fa8-e670-556b-278d-4993ad41b512@redhat.com>
	<1508418225.18146.1.camel@redhat.com>
	<d231ac0a-bb7d-78aa-ddb4-8048cc7bdfd8@redhat.com>
	<1508482525.18146.6.camel@redhat.com>
	<c839fe51-fc84-b297-a669-d8b3a0001017@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/pci-host: Fix x86 Host Bridges 64bit
 PCI hole
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, pbonzini@redhat.com, ehabkost@redhat.com, Igor Mammedov <imammedo@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On Fri, 2017-10-20 at 11:32 +0200, Laszlo Ersek wrote:
> On 10/20/17 08:55, Gerd Hoffmann wrote:
> > =C2=A0 Hi,
> >=20
> > > > commit message says:
> > > >=20
> > > > <quote>
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0It turns out that some 32 bit windo=
ws guests crash
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if 64 bit PCI hole size is >2G.
> > > > </quote>
> > > >=20
> > > > Why this suddenly isn't a problem any more?
> > > >=20
> > >=20
> > > I suppose it is, so we need a way to turn it "off".
> >=20
> > Or have machine types behave differently, i.e. give q35 a large
> > 64bit
> > hole and leave pc as-is.
>=20
> *If* we make it dependent on machine types at all, then please also
> make
> it versioned for Q35.

We probably need that for live migration compatibility anyway.  If we
add a switch we can add it to both pc and q35 (I think they share most
code so little extra cost), but have different defaults depending on
machine type.

> > BTW:=C2=A0=C2=A0Is it safe to just assume 40 bits physical is going t=
o
> > work?=C2=A0=C2=A0My
> > workstation:
> >=20
> > model name=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0: Intel(R) Core(TM) i7-=
7700K CPU @ 4.20GHz
> > address sizes=C2=A0=C2=A0=C2=A0: 39 bits physical, 48 bits virtual
> >=20
> > Does this imply ept is limited 39 bits physical too?
>=20
> Very good point to raise; "39 bits physical" on your workstation
> *does*
> imply that EPT is limited exactly the same way. I had run into this
> very
> problem while working on 64GB+ RAM enablement in OVMF. (Back then my
> laptop had: "address sizes : 36 bits physical, 48 bits virtual".)

Ah, right, I remember.  This is why we ended up with 32G window 32G
aligned above highest memory (or reserved) address.  No address above
64G will be used unless you have lots of memory in your virtual machine
(in which case your host very likely supports more than 36 address
lines).

So I guess the options are to play safe and do something simliar on the
qemu side, or go figure how much physical address space is available
and use that (which should also solve the "what do we with >1TB guests"
issue).  The later could cause some interesting live migration issues
though, when migrating between hosts with different physical address
space sizes.

So maybe the pci-hole64-size option isn't that bad after all?  We could
make it default to 2G on pc and 32G on q35 ...

cheers,
  Gerd
