Received: from eggs.gnu.org ([2001:4830:134:3::10]:55779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=596235071=anthony.perard@citrix.com>)
	id 1etAvq-0005Qj-M2
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 06:38:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=596235071=anthony.perard@citrix.com>)
	id 1etAvn-0004wx-HP
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 06:38:58 -0500
Received: from smtp.citrix.com ([66.165.176.89]:30976)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=596235071=anthony.perard@citrix.com>)
	id 1etAvn-0004uu-6f
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 06:38:55 -0500
Date: Tue, 6 Mar 2018 11:38:24 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20180306113824.GD1921@perard.uk.xensource.com>
References: <20171207101030.22364-1-haozhong.zhang@intel.com>
	<20171207101812.23602-1-haozhong.zhang@intel.com>
	<20180227172223.GD1799@perard.uk.xensource.com>
	<20180228093659.xpq2amq2zjuw2mdr@hz-desktop>
	<20180302120323.GG1799@perard.uk.xensource.com>
	<20180306041608.mbr6b25y557awxrn@hz-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180306041608.mbr6b25y557awxrn@hz-desktop>
Subject: Re: [Qemu-devel] [Xen-devel] [RFC QEMU PATCH v4 00/10] Implement
 vNVDIMM for Xen HVM guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, Stefano Stabellini <sstabellini@kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Dan Williams <dan.j.williams@intel.com>, Chao Peng <chao.p.peng@linux.intel.com>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Tue, Mar 06, 2018 at 12:16:08PM +0800, Haozhong Zhang wrote:
> On 03/02/18 12:03 +0000, Anthony PERARD wrote:
> > On Wed, Feb 28, 2018 at 05:36:59PM +0800, Haozhong Zhang wrote:
> > > On 02/27/18 17:22 +0000, Anthony PERARD wrote:
> > > > On Thu, Dec 07, 2017 at 06:18:02PM +0800, Haozhong Zhang wrote:
> > > > > This is the QEMU part patches that works with the associated Xen
> > > > > patches to enable vNVDIMM support for Xen HVM domains. Xen relies on
> > > > > QEMU to build guest NFIT and NVDIMM namespace devices, and allocate
> > > > > guest address space for vNVDIMM devices.
> > > > 
> > > > I've got other question, and maybe possible improvements.
> > > > 
> > > > When QEMU build the ACPI tables, it also initialize some MemoryRegion,
> > > > which use more guest memory. Do you know if those regions are used with
> > > > your patch series on Xen?
> > > 
> > > Yes, that's why dm_acpi_size is introduced.
> > > 
> > > > Otherwise, we could try to avoid their
> > > > creation with this:
> > > > In xenfv_machine_options()
> > > > m->rom_file_has_mr = false;
> > > > (setting this in xen_hvm_init() would probably be better, but I havn't
> > > > try)
> > > 
> > > If my memory is correct, simply setting rom_file_has_mr to false does
> > > not work (though I cannot remind the exact reason). I'll have a look
> > > as the code to refresh my memory.
> > 
> > I've played a bit with this idea, but without a proper NVDIMM available
> > for the guest, so I don't know if it's going to work properly without
> > the mr.
> > 
> > To make it work, I had to disable some code in acpi_build_update() that
> > make use of the MemoryRegions, as well as an assert in acpi_setup().
> > After those small hacks, I could boot the guest, and I've check that the
> > expected ACPI tables where there, and they looked correct to my eyes.
> > And least `ndctl list` works and showed the nvdimm (that I have
> > configured on QEMU's cmdline).
> > 
> > But I may not have been far enough with my tests, and maybe something
> > later relies on the MRs, especially the _DSM method that I don't know if
> > it was working properly.
> > 
> > Anyway, that why I proposed the idea, and if we can avoid more
> > uncertainty about how much guest memory QEMU is going to use, that would
> > be good.
> > 
> 
> Yes, I also tested some non-trivial _DSM methods and it looks rom
> files without memory regions can work with Xen after some
> modifications. I'll apply this idea in the next version if no other
> issues are found.

Awesome, thanks.

-- 
Anthony PERARD
