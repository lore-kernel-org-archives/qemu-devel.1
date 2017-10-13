Received: from eggs.gnu.org ([2001:4830:134:3::10]:60800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e2vac-0000bq-M9
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 04:45:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e2vaX-0008Eo-Ua
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 04:45:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51050)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1e2vaX-0008Dl-LF
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 04:45:01 -0400
Date: Fri, 13 Oct 2017 10:44:53 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20171013104453.50284426@nial.brq.redhat.com>
In-Reply-To: <20171013075326.77azyi4j2wo3b2fx@hz-desktop>
References: <20170911043820.14617-1-haozhong.zhang@intel.com>
	<20170911044157.15403-1-haozhong.zhang@intel.com>
	<20170911160818.1bd44a82@nial.brq.redhat.com>
	<alpine.DEB.2.10.1709111119480.19719@sstabellini-ThinkPad-X260>
	<20170912031509.vufszbju3s2v2bw3@hz-desktop>
	<20171010160544.GA1772@char.us.oracle.com>
	<20171012124544.dq3wyr65tefi3glk@hz-desktop>
	<f6478644-0d4a-6531-9016-aee2a0e76417@redhat.com>
	<20171013075326.77azyi4j2wo3b2fx@hz-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
To: Haozhong Zhang <haozhong.zhang@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Stefano Stabellini <sstabellini@kernel.org>, qemu-devel@nongnu.org, xen-devel@lists.xen.org, Dan Williams <dan.j.williams@intel.com>, Chao Peng <chao.p.peng@linux.intel.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Richard Henderson <rth@twiddle.net>, Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org, ian.jackson@eu.citrix.com, wei.liu2@citrix.com, george.dunlap@citrix.com, JBeulich@suse.com, andrew.cooper3@citrix.com

On Fri, 13 Oct 2017 15:53:26 +0800
Haozhong Zhang <haozhong.zhang@intel.com> wrote:

> On 10/12/17 17:45 +0200, Paolo Bonzini wrote:
> > On 12/10/2017 14:45, Haozhong Zhang wrote:  
> > > Basically, QEMU builds two ROMs for guest, /rom@etc/acpi/tables and
> > > /rom@etc/table-loader. The former is unstructured to guest, and
> > > contains all data of guest ACPI. The latter is a BIOSLinkerLoader
> > > organized as a set of commands, which direct the guest (e.g., SeaBIOS
> > > on KVM/QEMU) to relocate data in the former file, recalculate checksum
> > > of specified area, and fill guest address in specified ACPI field.
> > > 
> > > One part of my patches is to implement a mechanism to tell Xen which
> > > part of ACPI data is a table (NFIT), and which part defines a
> > > namespace device and what the device name is. I can add two new loader
> > > commands for them respectively.
> > > 
> > > Because they just provide information and SeaBIOS in non-xen
> > > environment ignores unrecognized commands, they will not break SeaBIOS
> > > in non-xen environment.
> > > 
> > > On QEMU side, most Xen-specific hacks in ACPI builder could be
> > > dropped, and replaced by adding the new loader commands (though they
> > > may be used only by Xen).
> > > 
> > > On Xen side, a fw_cfg driver and a BIOSLinkerLoader command executor
> > > are needed in, perhaps, hvmloader.  
> > 
> > If Xen has to parse BIOSLinkerLoader, it can use the existing commands
> > to process a reduced set of ACPI tables.  In other words,
> > etc/acpi/tables would only include the NFIT, the SSDT with namespace
> > devices, and the XSDT.  etc/acpi/rsdp would include the RSDP table as usual.
> >
> > hvmloader can then:
> > 
> > 1) allocate some memory for where the XSDT will go
> > 
> > 2) process the BIOSLinkerLoader like SeaBIOS would do
> > 
> > 3) find the RSDP in low memory, since the loader script must have placed
> > it there.  If it cannot find it, allocate some low memory, fill it with
> > the RSDP header and revision, and and jump to step 6
> > 
> > 4) If it found QEMU's RSDP, use it to find QEMU's XSDT
> > 
> > 5) Copy ACPI table pointers from QEMU to hvmloader's RSDT and/or XSDT.
> > 
> > 6) build hvmloader tables and link them into the RSDT and/or XSDT as usual.
> > 
> > 7) overwrite the RSDP in low memory with a pointer to hvmloader's own
> > RSDT and/or XSDT, and updated the checksums
> > 
> > QEMU's XSDT remains there somewhere in memory, unused but harmless.
> >   
+1 to Paolo's suggestion, i.e.
 1. add BIOSLinkerLoader into hvmloader
 2. load/process QEMU's tables with #1
 3. get pointers to QEMU generated NFIT and NVDIMM SSDT from QEMU's RSDT/XSDT
    and put them in hvmloader's RSDT

> It can work for plan tables which do not contain AML.
> 
> However, for a namespace device, Xen needs to know its name in order
> to detect the potential name conflict with those used in Xen built
> ACPI. Xen does not (and is not going to) introduce an AML parser, so
> it cannot get those device names from QEMU built ACPI by its own.
> 
> The idea of either this patch series or the new BIOSLinkerLoader
> command is to let QEMU tell Xen where the definition body of a
> namespace device (i.e. that part within the outmost "Device(NAME)") is
> and what the device name is. Xen, after the name conflict check, can
> re-package the definition body in a namespace device (w/ minimal AML
> builder code added in Xen) and then in SSDT.

I'd skip conflict check at runtime as hvmloader doesn't currently
have "\\_SB\NVDR" device so instead of doing runtime check it might
do primitive check at build time that ASL sources in hvmloader do
not contain reserved for QEMU "NVDR" keyword to avoid its addition
by accident in future. (it also might be reused in future if some
other tables from QEMU will be reused).
It's a bit hackinsh but at least it does the job and keeps
BIOSLinkerLoader interface the same for all supported firmwares
(I'd consider it as a temporary hack on the way to fully build
by QEMU ACPI tables for Xen).

Ideally it would be better for QEMU to build all ACPI tables for
hvmloader to avoid split brain issues and need to invent extra
interfaces every time a feature is added to pass configuration
data from QEMU to firmware.
But that's probably out of scope of this project, it could be
done on top of this if Xen folks would like to do it. Adding
BIOSLinkerLoader to hvmloader would be a good starting point
for that future effort.
