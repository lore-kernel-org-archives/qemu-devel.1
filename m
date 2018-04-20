Received: from eggs.gnu.org ([2001:4830:134:3::10]:43466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1f9SHU-0007kS-5a
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 05:24:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1f9SHQ-0003pa-VY
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 05:24:36 -0400
Received: from mail-lf0-x234.google.com ([2a00:1450:4010:c07::234]:34856)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1f9SHQ-0003ot-3s
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 05:24:32 -0400
Received: by mail-lf0-x234.google.com with SMTP id r125-v6so4200851lfe.2
	for <qemu-devel@nongnu.org>; Fri, 20 Apr 2018 02:24:32 -0700 (PDT)
Date: Fri, 20 Apr 2018 11:24:28 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Message-ID: <20180420092428.j5doxzh3lanwubhu@toto>
References: <20180413075200.15217-1-clg@kaod.org>
	<CAFEAcA_2314nBLZxaK91dNnEaefF9RAf5DA208Zg-Kyp-zQ5cQ@mail.gmail.com>
	<20180419174519.ardehg2pmp47fnvg@toto>
	<b5fa27c8-5ab1-a0c3-598a-5a377b0a441d@adacore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b5fa27c8-5ab1-a0c3-598a-5a377b0a441d@adacore.com>
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
To: KONRAD Frederic <frederic.konrad@adacore.com>
Cc: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, "Tian, Kevin" <kevin.tian@intel.com>, Alistair Francis <alistair@alistair23.me>, Juan Quintela <quintela@redhat.com>, Francisco Iglesias <frasse.iglesias@gmail.com>, joonas.lahtinen@linux.intel.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, zhenyuw@linux.intel.com, QEMU Developers <qemu-devel@nongnu.org>, Yulei Zhang <yulei.zhang@intel.com>, Alex Williamson <alex.williamson@redhat.com>, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Kirti Wankhede <kwankhede@nvidia.com>, Paolo Bonzini <pbonzini@redhat.com>, zhi.a.wang@intel.com, David Gibson <david@gibson.dropbear.id.au>

On Fri, Apr 20, 2018 at 10:14:15AM +0200, KONRAD Frederic wrote:
> 
> 
> On 04/19/2018 07:45 PM, Edgar E. Iglesias wrote:
> > On Thu, Apr 19, 2018 at 06:32:07PM +0100, Peter Maydell wrote:
> > > On 13 April 2018 at 08:52, Cédric Le Goater <clg@kaod.org> wrote:
> > > > On the POWER9 processor, the XIVE interrupt controller can control
> > > > interrupt sources using MMIO to trigger events, to EOI or to turn off
> > > > the sources. Priority management and interrupt acknowledgment is also
> > > > controlled by MMIO in the presenter sub-engine.
> > > > 
> > > > These MMIO regions are exposed to guests in QEMU with a set of 'ram
> > > > device' memory mappings, similarly to VFIO, and the VMAs are populated
> > > > dynamically with the appropriate pages using a fault handler.
> > > > 
> > > > But, these regions are an issue for migration. We need to discard the
> > > > associated RAMBlocks from the RAM state on the source VM and let the
> > > > destination VM rebuild the memory mappings on the new host in the
> > > > post_load() operation just before resuming the system.
> > > > 
> > > > To achieve this goal, the following introduces a new RAMBlock flag
> > > > RAM_MIGRATABLE which is updated in the vmstate_register_ram() and
> > > > vmstate_unregister_ram() routines. This flag is then used by the
> > > > migration to identify RAMBlocks to discard on the source. Some checks
> > > > are also performed on the destination to make sure nothing invalid was
> > > > sent.
> > > 
> > > I think in theory this should Just Work for allowing us to
> > > enable migration when the xilinx-spips device is using its
> > > execute-from-mmio feature (we would just need to remove the
> > > code that puts in the migration blocker).
> > > 
> > > Xilinx folks -- do you have a test image for a board that uses
> > > xilinx-spips and exercises the execute-from-mmio code, that
> > > we can use to test migration/vmsave with?
> > 
> > CC:ing Fred
> > 
> > I got an image from Fred a while back ago, I probably still have it
> > somewhere but I've totally forgotten the name for it.
> > 
> > Fred, do you have the image or roughly remember the filename?
> > 
> > Cheers,
> > Edgar
> > 
> 
> Edgar,
> 
> That was a while ago! I don't recall the name sorry for that!
> 
> In the worse case maybe building and putting an u-boot binary for
> zynq in the SPIs will do the job?
> 

Hi again,

I've found the test-case and it still runs OK. Who should I send the
tarball to? 

Cédric Le Goater <clg@kaod.org>
Peter Maydell <peter.maydell@linaro.org>

Anyone else who needs it?
Just let me know and I'll email it outside of the mailing list.

Cheers,
Edgar
