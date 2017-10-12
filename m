Received: from eggs.gnu.org ([2001:4830:134:3::10]:38014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e2fgC-0000QU-C7
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 11:45:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e2fg8-0005aY-CX
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 11:45:48 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:49626)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1e2fg8-0005Zv-5C
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 11:45:44 -0400
Received: by mail-wm0-f46.google.com with SMTP id b189so14269648wmd.4
	for <qemu-devel@nongnu.org>; Thu, 12 Oct 2017 08:45:43 -0700 (PDT)
References: <20170911043820.14617-1-haozhong.zhang@intel.com>
	<20170911044157.15403-1-haozhong.zhang@intel.com>
	<20170911160818.1bd44a82@nial.brq.redhat.com>
	<alpine.DEB.2.10.1709111119480.19719@sstabellini-ThinkPad-X260>
	<20170912031509.vufszbju3s2v2bw3@hz-desktop>
	<20171010160544.GA1772@char.us.oracle.com>
	<20171012124544.dq3wyr65tefi3glk@hz-desktop>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f6478644-0d4a-6531-9016-aee2a0e76417@redhat.com>
Date: Thu, 12 Oct 2017 17:45:39 +0200
MIME-Version: 1.0
In-Reply-To: <20171012124544.dq3wyr65tefi3glk@hz-desktop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Stefano Stabellini <sstabellini@kernel.org>, Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, xen-devel@lists.xen.org, Dan Williams <dan.j.williams@intel.com>, Chao Peng <chao.p.peng@linux.intel.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Richard Henderson <rth@twiddle.net>, Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org, ian.jackson@eu.citrix.com, wei.liu2@citrix.com, george.dunlap@citrix.com, JBeulich@suse.com, andrew.cooper3@citrix.com

On 12/10/2017 14:45, Haozhong Zhang wrote:
> Basically, QEMU builds two ROMs for guest, /rom@etc/acpi/tables and
> /rom@etc/table-loader. The former is unstructured to guest, and
> contains all data of guest ACPI. The latter is a BIOSLinkerLoader
> organized as a set of commands, which direct the guest (e.g., SeaBIOS
> on KVM/QEMU) to relocate data in the former file, recalculate checksum
> of specified area, and fill guest address in specified ACPI field.
> 
> One part of my patches is to implement a mechanism to tell Xen which
> part of ACPI data is a table (NFIT), and which part defines a
> namespace device and what the device name is. I can add two new loader
> commands for them respectively.
> 
> Because they just provide information and SeaBIOS in non-xen
> environment ignores unrecognized commands, they will not break SeaBIOS
> in non-xen environment.
> 
> On QEMU side, most Xen-specific hacks in ACPI builder could be
> dropped, and replaced by adding the new loader commands (though they
> may be used only by Xen).
> 
> On Xen side, a fw_cfg driver and a BIOSLinkerLoader command executor
> are needed in, perhaps, hvmloader.

If Xen has to parse BIOSLinkerLoader, it can use the existing commands
to process a reduced set of ACPI tables.  In other words,
etc/acpi/tables would only include the NFIT, the SSDT with namespace
devices, and the XSDT.  etc/acpi/rsdp would include the RSDP table as usual.

hvmloader can then:

1) allocate some memory for where the XSDT will go

2) process the BIOSLinkerLoader like SeaBIOS would do

3) find the RSDP in low memory, since the loader script must have placed
it there.  If it cannot find it, allocate some low memory, fill it with
the RSDP header and revision, and and jump to step 6

4) If it found QEMU's RSDP, use it to find QEMU's XSDT

5) Copy ACPI table pointers from QEMU to hvmloader's RSDT and/or XSDT.

6) build hvmloader tables and link them into the RSDT and/or XSDT as usual.

7) overwrite the RSDP in low memory with a pointer to hvmloader's own
RSDT and/or XSDT, and updated the checksums

QEMU's XSDT remains there somewhere in memory, unused but harmless.

Paolo
