Received: from eggs.gnu.org ([2001:4830:134:3::10]:33009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fGNLf-0005FZ-O8
	for qemu-devel@nongnu.org; Wed, 09 May 2018 07:33:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fGNLe-0000Y7-Pn
	for qemu-devel@nongnu.org; Wed, 09 May 2018 07:33:31 -0400
Received: from mail-oi0-x22b.google.com ([2607:f8b0:4003:c06::22b]:45505)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fGNLe-0000We-L6
	for qemu-devel@nongnu.org; Wed, 09 May 2018 07:33:30 -0400
Received: by mail-oi0-x22b.google.com with SMTP id b130-v6so31157653oif.12
	for <qemu-devel@nongnu.org>; Wed, 09 May 2018 04:33:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180509110833.GD2527@work-vm>
References: <20180413075200.15217-1-clg@kaod.org>
	<20180419165800.GA2731@work-vm>
	<e5447136-8de7-73f3-ca6d-0c7a1fe11abe@kaod.org>
	<20180509110833.GD2527@work-vm>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 9 May 2018 12:33:09 +0100
Message-ID: <CAFEAcA9T=UUXS1ABrtahv_LyDtAf6DT-pRoTRYFr3LvvSkdyTQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] migration: discard non-migratable
 RAMBlocks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, QEMU Developers <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Alex Williamson <alex.williamson@redhat.com>, Yulei Zhang <yulei.zhang@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, joonas.lahtinen@linux.intel.com, zhenyuw@linux.intel.com, Kirti Wankhede <kwankhede@nvidia.com>, zhi.a.wang@intel.com, Paolo Bonzini <pbonzini@redhat.com>, Paul Burton <paul.burton@mips.com>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>

On 9 May 2018 at 12:08, Dr. David Alan Gilbert <dgilbert@redhat.com> wrote:
> This thread seems to have stalled; we've got the list of potential
> migration breaks that Peter found and only some minor comments on the
> actual patch.
>
> I'd like to get it going again sicne as well as C=C3=A9dric, and Peter's
> cases, there's Lai Jiangshan and now Eric Wheeler was asking for
> something similar.
>
> Anyone understand the way forward? Do we have to go and fix the
> odd board failures first?

aspeed and highbank I already changed in master. That leaves

hw/mips/boston.c:    memory_region_init_rom_nomigrate(flash, NULL,
hw/mips/mips_malta.c:    memory_region_init_ram_nomigrate(bios_copy,
NULL, "bios.1fc", BIOS_SIZE,
hw/net/dp8393x.c:    memory_region_init_ram_nomigrate(&s->prom, OBJECT(dev)=
,
  [device only used on mips jazz board]
hw/pci-host/xilinx-pcie.c:    memory_region_init_ram_nomigrate(&s->io,
OBJECT(s), "io", 16, NULL);
  [device only used on mips boston board]

which affect mips boston, malta and jazz boards.

I don't think we need to fix those first, but:

 * we should note in the commit message for this patch that
   it is a de-facto migration break for those boards
 * we should fix those devices/boards in this release cycle,
   since we've broken migration compat anyway
 * we should check with the MIPS maintainers that they're ok
   with a cross-version migration compat break for those boards
   (I've cc'd them)

thanks
-- PMM
