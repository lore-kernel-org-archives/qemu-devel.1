Received: from eggs.gnu.org ([2001:4830:134:3::10]:50166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1e2utO-0006IA-IF
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 04:00:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1e2utI-0002ww-8p
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 04:00:26 -0400
Received: from mga01.intel.com ([192.55.52.88]:62421)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1e2utH-0002vx-Lk
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 04:00:20 -0400
Date: Fri, 13 Oct 2017 16:00:11 +0800
From: Haozhong Zhang <haozhong.zhang@intel.com>
Message-ID: <20171013080011.fgqxa7wgf6w4ytcp@hz-desktop>
References: <20170911043820.14617-1-haozhong.zhang@intel.com>
	<20170911044157.15403-1-haozhong.zhang@intel.com>
	<20170911160818.1bd44a82@nial.brq.redhat.com>
	<alpine.DEB.2.10.1709111119480.19719@sstabellini-ThinkPad-X260>
	<20170912031509.vufszbju3s2v2bw3@hz-desktop>
	<20171010160544.GA1772@char.us.oracle.com>
	<20171012124544.dq3wyr65tefi3glk@hz-desktop>
	<20171012173903.GK26278@char.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171012173903.GK26278@char.us.oracle.com>
Subject: Re: [Qemu-devel] [RFC QEMU PATCH v3 00/10] Implement vNVDIMM for
 Xen HVM guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>, Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, xen-devel@lists.xen.org, Dan Williams <dan.j.williams@intel.com>, Chao Peng <chao.p.peng@linux.intel.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org, ian.jackson@eu.citrix.com, wei.liu2@citrix.com, george.dunlap@citrix.com, JBeulich@suse.com, andrew.cooper3@citrix.com

On 10/12/17 13:39 -0400, Konrad Rzeszutek Wilk wrote:
> On Thu, Oct 12, 2017 at 08:45:44PM +0800, Haozhong Zhang wrote:
> > On 10/10/17 12:05 -0400, Konrad Rzeszutek Wilk wrote:
> > > On Tue, Sep 12, 2017 at 11:15:09AM +0800, Haozhong Zhang wrote:
> > > > On 09/11/17 11:52 -0700, Stefano Stabellini wrote:
> > > > > CC'ing xen-devel, and the Xen tools and x86 maintainers.
> > > > > 
> > > > > On Mon, 11 Sep 2017, Igor Mammedov wrote:
> > > > > > On Mon, 11 Sep 2017 12:41:47 +0800
> > > > > > Haozhong Zhang <haozhong.zhang@intel.com> wrote:
> > > > > > 
> > > > > > > This is the QEMU part patches that works with the associated Xen
> > > > > > > patches to enable vNVDIMM support for Xen HVM domains. Xen relies on
> > > > > > > QEMU to build guest NFIT and NVDIMM namespace devices, and allocate
> > > > > > > guest address space for vNVDIMM devices.
> > > > > > > 
> > > > > > > All patches can be found at
> > > > > > >   Xen:  https://github.com/hzzhan9/xen.git nvdimm-rfc-v3
> > > > > > >   QEMU: https://github.com/hzzhan9/qemu.git xen-nvdimm-rfc-v3
> > > > > > > 
> > > > > > > Patch 1 is to avoid dereferencing the NULL pointer to non-existing
> > > > > > > label data, as the Xen side support for labels is not implemented yet.
> > > > > > > 
> > > > > > > Patch 2 & 3 add a memory backend dedicated for Xen usage and a hotplug
> > > > > > > memory region for Xen guest, in order to make the existing nvdimm
> > > > > > > device plugging path work on Xen.
> > > > > > > 
> > > > > > > Patch 4 - 10 build and cooy NFIT from QEMU to Xen guest, when QEMU is
> > > > > > > used as the Xen device model.
> > > > > > 
> > > > > > I've skimmed over patch-set and can't say that I'm happy with
> > > > > > number of xen_enabled() invariants it introduced as well as
> > > > > > with partial blobs it creates.
> > > > > 
> > > > > I have not read the series (Haozhong, please CC me, Anthony and
> > > > > xen-devel to the whole series next time), but yes, indeed. Let's not add
> > > > > more xen_enabled() if possible.
> > > > > 
> > > > > Haozhong, was there a design document thread on xen-devel about this? If
> > > > > so, did it reach a conclusion? Was the design accepted? If so, please
> > > > > add a link to the design doc in the introductory email, so that
> > > > > everybody can read it and be on the same page.
> > > > 
> > > > Yes, there is a design [1] discussed and reviewed. Section 4.3 discussed
> > > > the guest ACPI.
> > > > 
> > > > [1] https://lists.xenproject.org/archives/html/xen-devel/2016-07/msg01921.html
> > > 
> > > Igor, did you have a chance to read it?
> > > 
> > > .. see below
> > > > 
> > > > > 
> > > > > 
> > > > > > I'd like to reduce above and a way to do this might be making xen 
> > > > > >  1. use fw_cfg
> > > > > >  2. fetch QEMU build acpi tables from fw_cfg
> > > > > >  3. extract nvdim tables (which is trivial) and use them
> > > > > > 
> > > > > > looking at xen_load_linux(), it seems possible to use fw_cfg.
> > > > > > 
> > > > > > So what's stopping xen from using it elsewhere?,
> > > > > > instead of adding more xen specific code to do 'the same'
> > > > > > job and not reusing/sharing common code with tcg/kvm.
> > > > > 
> > > > > So far, ACPI tables have not been generated by QEMU. Xen HVM machines
> > > > > rely on a firmware-like application called "hvmloader" that runs in
> > > > > guest context and generates the ACPI tables. I have no opinions on
> > > > > hvmloader and I'll let the Xen maintainers talk about it. However, keep
> > > > > in mind that with an HVM guest some devices are emulated by Xen and/or
> > > > > by other device emulators that can run alongside QEMU. QEMU doesn't have
> > > > > a full few of the system.
> > > > > 
> > > > > Here the question is: does it have to be QEMU the one to generate the
> > > > > ACPI blobs for the nvdimm? It would be nicer if it was up to hvmloader
> > > > > like the rest, instead of introducing this split-brain design about
> > > > > ACPI. We need to see a design doc to fully understand this.
> > > > >
> > > > 
> > > > hvmloader runs in the guest and is responsible to build/load guest
> > > > ACPI. However, it's not capable to build AML at runtime (for the lack
> > > > of AML builder). If any guest ACPI object is needed (e.g. by guest
> > > > DSDT), it has to be generated from ASL by iasl at Xen compile time and
> > > > then be loaded by hvmloader at runtime.
> > > > 
> > > > Xen includes an OperationRegion "BIOS" in the static generated guest
> > > > DSDT, whose address is hardcoded and which contains a list of values
> > > > filled by hvmloader at runtime. Other ACPI objects can refer to those
> > > > values (e.g., the number of vCPUs). But it's not enough for generating
> > > > guest NVDIMM ACPI objects at compile time and then being customized
> > > > and loaded by hvmload, because its structure (i.e., the number of
> > > > namespace devices) cannot be decided util the guest config is known.
> > > > 
> > > > Alternatively, we may introduce an AML builder in hvmloader and build
> > > > all guest ACPI completely in hvmloader. Looking at the similar
> > > > implementation in QEMU, it would not be small, compared to the current
> > > > size of hvmloader. Besides, I'm still going to let QEMU handle guest
> > > > NVDIMM _DSM and _FIT calls, which is another reason I use QEMU to
> > > > build NVDIMM ACPI.
> > > > 
> > > > > If the design doc thread led into thinking that it has to be QEMU to
> > > > > generate them, then would it make the code nicer if we used fw_cfg to
> > > > > get the (full or partial) tables from QEMU, as Igor suggested?
> > > > 
> > > > I'll have a look at the code (which I didn't notice) pointed by Igor.
> > > 
> > > And there is a spec too!
> > > 
> > > https://github.com/qemu/qemu/blob/master/docs/specs/fw_cfg.txt
> > > 
> > > Igor, did you have in mind to use FW_CFG_FILE_DIR to retrieve the
> > > ACPI AML code?
> > > 
> > 
> > Basically, QEMU builds two ROMs for guest, /rom@etc/acpi/tables and
> > /rom@etc/table-loader. The former is unstructured to guest, and
> > contains all data of guest ACPI. The latter is a BIOSLinkerLoader
> > organized as a set of commands, which direct the guest (e.g., SeaBIOS
> > on KVM/QEMU) to relocate data in the former file, recalculate checksum
> > of specified area, and fill guest address in specified ACPI field.
> > 
> > One part of my patches is to implement a mechanism to tell Xen which
> > part of ACPI data is a table (NFIT), and which part defines a
> > namespace device and what the device name is. I can add two new loader
> > commands for them respectively.
> 
> <nods>
> > 
> > Because they just provide information and SeaBIOS in non-xen
> > environment ignores unrecognized commands, they will not break SeaBIOS
> > in non-xen environment.
> > 
> > On QEMU side, most Xen-specific hacks in ACPI builder could be
> 
> Wooot!
> > dropped, and replaced by adding the new loader commands (though they
> > may be used only by Xen).
> 
> And eventually all of the hvmloader ACPI built in code could be dropped
> and use all of the loader commands?

If Xen is going to rely on QEMU to build the entire ACPI for a HVM
guest, then there would be no need to check the signature/name
conflict, so the new BIOSLinkerLoader commands here would not be
necessary in that case (or only for backwards compatible). I don't
know how much work would be needed, and that could be another project.

Haozhong

> 
> > 
> > On Xen side, a fw_cfg driver and a BIOSLinkerLoader command executor
> > are needed in, perhaps, hvmloader.
> 
> <nods>
> > 
> > 
> > Haozhong
> > 
> 
