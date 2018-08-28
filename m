Received: from eggs.gnu.org ([2001:4830:134:3::10]:36261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fuWiI-0002Yc-Gh
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 01:38:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fuWaN-0002E8-5k
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 01:30:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45660 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fuWaM-0002DY-V3
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 01:30:39 -0400
Date: Tue, 28 Aug 2018 07:30:36 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180828053036.7pueu6jk6y6wnm47@sirius.home.kraxel.org>
References: <1533793434-7614-1-git-send-email-whois.zihan.yang@gmail.com>
	<ece2a3ff-678d-00b6-3fd6-660972c5beca@gmail.com>
	<20180827070406.t525gr43qpu7wpsj@sirius.home.kraxel.org>
	<CAKwiv-gyGoqEpmpicxo_a3cQBsb0-XoT9cqkJu5WOtkUtAx0eQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwiv-gyGoqEpmpicxo_a3cQBsb0-XoT9cqkJu5WOtkUtAx0eQ@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [SeaBIOS] [RFC v2 0/3] Support multiple pci
 domains in pci_device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zihan Yang <whois.zihan.yang@gmail.com>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

On Tue, Aug 28, 2018 at 04:12:17AM +0000, Zihan Yang wrote:
> Gerd Hoffmann <kraxel@redhat.com> =E4=BA=8E2018=E5=B9=B48=E6=9C=8827=E6=
=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8A=E5=8D=887:04=E5=86=99=E9=81=93=EF=BC=9A
> >
> >   Hi,
> >
> > > >   However, QEMU only binds port 0xcf8 and 0xcfc to
> > > > bus pcie.0. To avoid bus confliction, we should use other port pa=
irs for
> > > > busses under new domains.
> > >
> > > I would skip support for IO based configuration and use only MMCONF=
IG
> > > for extra root buses.
> > >
> > > The question remains: how do we assign MMCONFIG space for
> > > each PCI domain.
> >
> > Allocation-wise it would be easiest to place them above 4G.  Right af=
ter
> > memory, or after etc/reserved-memory-end (if that fw_cfg file is
> > present), where the 64bit pci bars would have been placed.  Move the =
pci
> > bars up in address space to make room.
> >
> > Only problem is that seabios wouldn't be able to access mmconfig then=
.
> >
> > Placing them below 4G would work at least for a few pci domains.  q35
> > mmconfig bar is placed at 0xb0000000 -> 0xbfffffff, basically for
> > historical reasons.  Old qemu versions had 2.75G low memory on q35 (u=
p
> > to 0xafffffff), and I think old machine types still have that for liv=
e
> > migration compatibility reasons.  Modern qemu uses 2G only, to make
> > gigabyte alignment work.
> >
> > 32bit pci bars are placed above 0xc0000000.  The address space from 2=
G
> > to 2.75G (0x8000000 -> 0xafffffff) is unused on new machine types.
> > Enough room for three additional mmconfig bars (full size), so four
> > pci domains total if you add the q35 one.
>=20
> Maybe we can support 4 domains first before we come up
> with a better solution. But I'm not sure if four domains are
> enough for those who want too many devices?

There is the option to use ovmf instead.  Runs in long mode, so mapping
and using mmconfig above 4G isn't a problem for ovmf.  Given that
alternative exists I think it is reasonable to declare only 4 pci
domains being fully supported with seabios.

We can even configure mmconfig (above 4G) for the 5th and above, seabios
just would not enumerate the devices and map the pci bars for these
domains and leave it to the guest os instead.

cheers,
  Gerd
