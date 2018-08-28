Received: from eggs.gnu.org ([2001:4830:134:3::10]:48713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1fuVPg-0005o0-Am
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 00:15:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1fuVMl-0006dO-1M
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 00:12:31 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:42936)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <whois.zihan.yang@gmail.com>)
	id 1fuVMk-0006dA-Pl
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 00:12:30 -0400
Received: by mail-lf1-x142.google.com with SMTP id z11-v6so182225lff.9
	for <qemu-devel@nongnu.org>; Mon, 27 Aug 2018 21:12:30 -0700 (PDT)
MIME-Version: 1.0
References: <1533793434-7614-1-git-send-email-whois.zihan.yang@gmail.com>
	<ece2a3ff-678d-00b6-3fd6-660972c5beca@gmail.com>
	<20180827070406.t525gr43qpu7wpsj@sirius.home.kraxel.org>
In-Reply-To: <20180827070406.t525gr43qpu7wpsj@sirius.home.kraxel.org>
From: Zihan Yang <whois.zihan.yang@gmail.com>
Date: Tue, 28 Aug 2018 04:12:17 +0000
Message-ID: <CAKwiv-gyGoqEpmpicxo_a3cQBsb0-XoT9cqkJu5WOtkUtAx0eQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

Gerd Hoffmann <kraxel@redhat.com> =E4=BA=8E2018=E5=B9=B48=E6=9C=8827=E6=97=
=A5=E5=91=A8=E4=B8=80 =E4=B8=8A=E5=8D=887:04=E5=86=99=E9=81=93=EF=BC=9A
>
>   Hi,
>
> > >   However, QEMU only binds port 0xcf8 and 0xcfc to
> > > bus pcie.0. To avoid bus confliction, we should use other port pairs =
for
> > > busses under new domains.
> >
> > I would skip support for IO based configuration and use only MMCONFIG
> > for extra root buses.
> >
> > The question remains: how do we assign MMCONFIG space for
> > each PCI domain.
>
> Allocation-wise it would be easiest to place them above 4G.  Right after
> memory, or after etc/reserved-memory-end (if that fw_cfg file is
> present), where the 64bit pci bars would have been placed.  Move the pci
> bars up in address space to make room.
>
> Only problem is that seabios wouldn't be able to access mmconfig then.
>
> Placing them below 4G would work at least for a few pci domains.  q35
> mmconfig bar is placed at 0xb0000000 -> 0xbfffffff, basically for
> historical reasons.  Old qemu versions had 2.75G low memory on q35 (up
> to 0xafffffff), and I think old machine types still have that for live
> migration compatibility reasons.  Modern qemu uses 2G only, to make
> gigabyte alignment work.
>
> 32bit pci bars are placed above 0xc0000000.  The address space from 2G
> to 2.75G (0x8000000 -> 0xafffffff) is unused on new machine types.
> Enough room for three additional mmconfig bars (full size), so four
> pci domains total if you add the q35 one.

Maybe we can support 4 domains first before we come up
with a better solution. But I'm not sure if four domains are
enough for those who want too many devices?

> cheers,
>   Gerd
>
