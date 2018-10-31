Received: from eggs.gnu.org ([2001:4830:134:3::10]:59858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gHwpg-0004ld-5Z
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 16:11:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gHwpd-0008Vu-S1
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 16:11:15 -0400
MIME-Version: 1.0
References: <cover.1540937826.git.alistair.francis@wdc.com>
	<3f834825634e34ad107fe9e7af1b417cb47fc1f1.camel@redhat.com>
In-Reply-To: <3f834825634e34ad107fe9e7af1b417cb47fc1f1.camel@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 31 Oct 2018 13:10:43 -0700
Message-ID: <CAKmqyKNF+tQFf50BCj91_RypYeHbnoZLvpm8gH71iW1og9uWfA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v6 0/5] Connect a PCIe host and graphics
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, qemu-riscv@nongnu.org

On Wed, Oct 31, 2018 at 7:51 AM Andrea Bolognani <abologna@redhat.com> wrote:
>
> On Tue, 2018-10-30 at 22:17 +0000, Alistair Francis wrote:
> > V6:
> >  - Fix the interrupt issue for the GPEX device
>
> I gave this a spin.
>
> With the pcie.0 <- pcie-root-port <- virtio-net-pci setup I get
>
>   qemu-system-riscv64: -device pcie-root-port,port=0x8,chassis=1,\
>   id=pci.1,bus=pcie.0,multifunction=on,addr=0x1: MSI-X is not \
>   supported by interrupt controller
>
> just like last time, which as I mentioned is a problem for libvirt
> because we follow the recommendations outlined in qemu/docs/pcie.txt
> and never plug devices into pcie.0 directly.

At the moment we can't support MSI, the interrupt controller doesn't
support MSI.

>
> Even after working around that issue by manually placing the device
> at 0000:00:01.0, it still doesn't work: I see
>
>   pci 0000:00:01.0: BAR 6: assigned [mem 0x00000000-0x0003ffff pref]
>   pci 0000:00:01.0: BAR 4: assigned [mem 0x00040000-0x00043fff 64bit pref]
>   pci 0000:00:01.0: BAR 0: no space for [io  size 0x0020]
>   pci 0000:00:01.0: BAR 0: failed to assign [io  size 0x0020]
>   ...
>   virtio_net virtio3: virtio: device uses modern interface but does not have VIRTIO_F_VERSION_1
>   virtio_net: probe of virtio3 failed with error -22

Yep, someone else pointed out a problem as well. I have made some
changes [1] but I still can't get the BAR to line up.

>
> in dmesg and, while the device shows up in the output of lspci(8),
> it's nowhere to be seen when running 'ip addr' and friends.
>
> Let me know if you need me to try anything else :)

Any ideas on how to debug the confusing memory mappings or
non-existent interrupts would be helpful :)

1: https://github.com/alistair23/qemu/tree/mainline/alistair/sifive_pcie.next

Alistair

>
> --
> Andrea Bolognani / Red Hat / Virtualization
>
