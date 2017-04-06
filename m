Received: from eggs.gnu.org ([2001:4830:134:3::10]:59231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cw2qn-0004d8-5u
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 04:33:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cw2qm-0006g3-2N
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 04:33:05 -0400
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:33150)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cw2ql-0006fu-Rz
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 04:33:03 -0400
Received: by mail-wr0-x22a.google.com with SMTP id g19so5771655wrb.0
	for <qemu-devel@nongnu.org>; Thu, 06 Apr 2017 01:33:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <7a623fb8d2284ee28ddbd6e1ccf277e0@XCGC3021.northgrum.com>
References: <7a623fb8d2284ee28ddbd6e1ccf277e0@XCGC3021.northgrum.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Apr 2017 09:32:42 +0100
Message-ID: <CAFEAcA8C17TnnBKim9T9k32Re9C-pWUokF-UeVAd=itcpROvRg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Emulating external registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Wu, Michael Y [US] (MS)" <Michael.Wu@ngc.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On 5 April 2017 at 22:03, Wu, Michael Y [US] (MS) <Michael.Wu@ngc.com> wrot=
e:
> My current approach is to create a new MemoryRegion in the init function =
of the g3beige source code (mac_oldworld.c). My idea is to set up some mmio=
 to certain address to represent those registers. For now I only care about=
 reading and writing, but in the future I hope to add additional logic when=
 the registers are written.
> I added the following lines:
> MemoryRegion *reg =3D g_new(MemoryRegion, 1);
> memory_region_init_alias(reg, NULL, "reg_mmio",
>                             get_system_io(), 0, 0x00200000);

This is defining your region to be an alias into the
system IO region, so reading/writing your region will
act like reads and writes into those IO ports. This
doesn't sound like what you were trying to do.
Usually memory regions for registers are defined using
memory_region_init_io(), where you pass in a structure
that includes pointers to functions which are called
for reads and writes.

> memory_region_add_subregion(sysmem, 0xfc000000, reg);

Typically you would create a device model for whatever this device
is, and then map it in the board code, not directly create a
memory region in the board code.

You might find it useful to look at hw/misc/unimp.c, which
is a device which simply prints log messages when it is
read or written. Or try a simple device that your board
already has.

thanks
-- PMM
