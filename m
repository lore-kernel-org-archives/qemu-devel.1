Received: from eggs.gnu.org ([2001:4830:134:3::10]:60940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f9DQ5-0007Ru-OP
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 13:32:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f9DQ5-0006t4-0O
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 13:32:29 -0400
Received: from mail-oi0-x22f.google.com ([2607:f8b0:4003:c06::22f]:38382)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f9DQ4-0006sw-Qb
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 13:32:28 -0400
Received: by mail-oi0-x22f.google.com with SMTP id y20-v6so5593083oix.5
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 10:32:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180413075200.15217-1-clg@kaod.org>
References: <20180413075200.15217-1-clg@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Apr 2018 18:32:07 +0100
Message-ID: <CAFEAcA_2314nBLZxaK91dNnEaefF9RAf5DA208Zg-Kyp-zQ5cQ@mail.gmail.com>
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
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Alex Williamson <alex.williamson@redhat.com>, Yulei Zhang <yulei.zhang@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, joonas.lahtinen@linux.intel.com, zhenyuw@linux.intel.com, Kirti Wankhede <kwankhede@nvidia.com>, zhi.a.wang@intel.com, Paolo Bonzini <pbonzini@redhat.com>, Edgar Iglesias <edgar.iglesias@xilinx.com>, Francisco Iglesias <frasse.iglesias@gmail.com>, Alistair Francis <alistair@alistair23.me>

On 13 April 2018 at 08:52, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> On the POWER9 processor, the XIVE interrupt controller can control
> interrupt sources using MMIO to trigger events, to EOI or to turn off
> the sources. Priority management and interrupt acknowledgment is also
> controlled by MMIO in the presenter sub-engine.
>
> These MMIO regions are exposed to guests in QEMU with a set of 'ram
> device' memory mappings, similarly to VFIO, and the VMAs are populated
> dynamically with the appropriate pages using a fault handler.
>
> But, these regions are an issue for migration. We need to discard the
> associated RAMBlocks from the RAM state on the source VM and let the
> destination VM rebuild the memory mappings on the new host in the
> post_load() operation just before resuming the system.
>
> To achieve this goal, the following introduces a new RAMBlock flag
> RAM_MIGRATABLE which is updated in the vmstate_register_ram() and
> vmstate_unregister_ram() routines. This flag is then used by the
> migration to identify RAMBlocks to discard on the source. Some checks
> are also performed on the destination to make sure nothing invalid was
> sent.

I think in theory this should Just Work for allowing us to
enable migration when the xilinx-spips device is using its
execute-from-mmio feature (we would just need to remove the
code that puts in the migration blocker).

Xilinx folks -- do you have a test image for a board that uses
xilinx-spips and exercises the execute-from-mmio code, that
we can use to test migration/vmsave with?

thanks
-- PMM
