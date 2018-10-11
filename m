Received: from eggs.gnu.org ([2001:4830:134:3::10]:43202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gAexj-0004Kb-K3
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 13:41:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gAexh-0004d1-2Z
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 13:41:27 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:40169)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1gAexd-0004aO-V0
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 13:41:24 -0400
Received: by mail-lf1-x142.google.com with SMTP id t22-v6so7342625lfb.7
	for <qemu-devel@nongnu.org>; Thu, 11 Oct 2018 10:41:15 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1538683492.git.alistair.francis@wdc.com>
	<5dd21056229d12a1af8d65e9208f4de43ba4a2ae.camel@redhat.com>
	<892d54c5-2851-74ec-bdf2-286c1665c44f@gmail.com>
	<7d54ec114745b00b82601875416ccfe6a5f9fe6f.camel@redhat.com>
In-Reply-To: <7d54ec114745b00b82601875416ccfe6a5f9fe6f.camel@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 11 Oct 2018 10:40:46 -0700
Message-ID: <CAKmqyKNTTu+5KyTMBHw5-+UMa7qnm9EaowxHj8NLxED98m1MKw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 0/5] Connect a PCIe host and graphics
 support to RISC-V
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrea Bolognani <abologna@redhat.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, stephen@eideticom.com, "Richard W.M. Jones" <rjones@redhat.com>

On Wed, Oct 10, 2018 at 11:00 PM Andrea Bolognani <abologna@redhat.com> wrote:
>
> On Wed, 2018-10-10 at 10:57 -0700, Alistair wrote:
> > On 10/10/2018 05:26 AM, Andrea Bolognani wrote:
> > > * what should libvirt look for to figure out whether or not a RISC-V
> > >    guest will have PCI support? For aarch64 we look for the presence
> > >    of the 'gpex-pcihost' device, but of course that won't work for
> > >    RISC-V so we need something else;
> >
> > I'm not sure what you mean here. Why can we not do the same thing with
> > RISC-V?
>
> The gpex-pcihost device was introduced at the same time as
> aarch64/virt gained PCI support, so we can probe the binary[1] and,
> if the device is present, we know that aarch64/virt guests will be
> able to use PCI. We cannot do the same for RISC-V for obvious
> reasons: the device is already there :)

The device shouldn't exist in the RISC-V QEMU binary though until
after this patch series. So it should have the same effect.

Alistair

>
> Is there any RISC-V device / property that was introduced along
> with PCI support and we can use as a witness?
>
> > > * I have succesfully started a RISC-V guest with virtio-pci devices
> > >    attached but, while they show up in 'info qtree' and friends, the
> > >    guest OS itself doesn't seem to recognize any of them - not even
> > >    pcie.0! I'm using the guest images listed at [1] and following the
> > >    corresponding instructions, but I think the BBL build (config at
> > >    [2]) is missing some feature... Any ideas what we would need to
> > >    add there?
> >
> > I use this monolithic config:
> > https://github.com/alistair23/meta-riscv/blob/7a950aa705b439b5ec19bb6f094930888335ba7b/recipes-kernel/linux/files/freedom-u540/defconfig
> >
> > It has way too much enabled, but I think if you copy the PCIe part that
> > should be enough.
>
> Looks like there's quite a few CONFIG*PCI* options we're missing!
>
> Rich, can you try incorporating those and kicking off a BBL build?
> If I remember correctly you might also have to backport a commit or
> two to make some of the options available on RISC-V, but it should
> be very feasible.
>
> [...]
> > Obviously on top of that you will need to enable the VirtIO support as
> > that doesn't exist in the hardware.
>
> Yeah, we already have that enabled and non-PCI VirtIO devices work
> just fine.
>
>
> [1] Not the guest, mind you: libvirt will probe each QEMU binary only
>     once to reduce the overhead, so anyth
> --
> Andrea Bolognani / Red Hat / Virtualization
>
