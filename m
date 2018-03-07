Received: from eggs.gnu.org ([2001:4830:134:3::10]:33660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1etPwH-0000or-Mz
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 22:40:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1etPwG-0000HU-RI
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 22:40:25 -0500
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:34495)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1etPwG-0000Gr-Ay
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 22:40:24 -0500
Received: by mail-ot0-x242.google.com with SMTP id n74so833074ota.1
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 19:40:24 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1520327623.4132.10.camel@redhat.com>
References: <1519998942-73622-1-git-send-email-mjc@sifive.com>
	<CAFEAcA_kTXTs9z-v3Zow8r52QFrWPwQ3YSjhZOzPr6aj8jdSJQ@mail.gmail.com>
	<CAHNT7Nt72aUwGAGfV0zYya_WH3qXipk6XnLbfDPytMXMTLSJ-Q@mail.gmail.com>
	<CAFEAcA_otsCR5CC2amGpU2cTdViH4+PkH84XHz1PaYt5nKGhAQ@mail.gmail.com>
	<CAHNT7NtJniQs_JcWOHnUr06be7Ht=9+sHmdr+rVNRUwy5+fJiw@mail.gmail.com>
	<CAHNT7Nv-Whr=fdgXANnSuw1yxb6EEBzdxVFSfkLZhh6knzS3sA@mail.gmail.com>
	<1520327623.4132.10.camel@redhat.com>
From: Michael Clark <mjc@sifive.com>
Date: Wed, 7 Mar 2018 16:40:23 +1300
Message-ID: <CAHNT7NsinOUYaFyEXxA5jCKpU7Du2=xocOAga_gVpjSN=WJHoA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL] RISC-V QEMU Port Submission v8
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrea Bolognani <abologna@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, QEMU Developers <qemu-devel@nongnu.org>, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches <patches@groups.riscv.org>

On Tue, Mar 6, 2018 at 10:13 PM, Andrea Bolognani <abologna@redhat.com>
wrote:

> On Tue, 2018-03-06 at 14:30 +1300, Michael Clark wrote:
> > I'm currently working on some changes locally to split the firmware from
> > the kernel image. Currently the kernel image is embedded in the firmware
> (r
> > iscv-pk/bbl).
>
> I was wondering about this just yesterday.
>
> Will this eventually lead to a situation where we can have a single
> firmware image which is shared between all guests, a la OVMF/AAVMF,
> with grub and the kernels stored on the virtual disk itself, like
> on most other architectures?
>

Possibly.

My first cut is to put the kernel-entry load address into a "chosen"
device-tree node so that the firmware knows where to jump to, versus having
the kernel as an embedded payload.

Currently the kernel image is embedded inside of the riscv-pk/bbl firmware
which is less than ideal and obviously a temporary solution.

We want to be able to build the firmware, kernel and initramfs separately.

That should make it less awkward to add RISC-V support to libvirt,
> plus I expect it to be kind of a requirement for full distribution
> support, especially when it comes to updates and such.
>

Apparently some folk have spent some time working on UEFI support for
RISC-V and I noticed that there is a UEFI model for passing FDT (versus
other platform specific tables).

The only thing I don't like about UEFI is that it uses LLP64 and PE/COFF vs
LP64/ELF
