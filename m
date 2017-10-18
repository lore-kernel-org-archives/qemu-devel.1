Received: from eggs.gnu.org ([2001:4830:134:3::10]:56202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=457281bb7=roger.pau@citrix.com>)
	id 1e4jmO-0008B0-TE
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 04:32:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=457281bb7=roger.pau@citrix.com>)
	id 1e4jmL-0002lY-NI
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 04:32:44 -0400
Received: from smtp.citrix.com.au ([103.14.252.240]:21298)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=457281bb7=roger.pau@citrix.com>)
	id 1e4jmL-0002hz-3i
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 04:32:41 -0400
Date: Wed, 18 Oct 2017 09:32:25 +0100
From: Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
Message-ID: <20171018083225.4x42tkamuuauj4ki@dhcp-3-128.uk.xensource.com>
References: <20171010160544.GA1772@char.us.oracle.com>
	<20171012124544.dq3wyr65tefi3glk@hz-desktop>
	<f6478644-0d4a-6531-9016-aee2a0e76417@redhat.com>
	<20171013075326.77azyi4j2wo3b2fx@hz-desktop>
	<20171013104453.50284426@nial.brq.redhat.com>
	<20171013111341.feb2462nh2rcrjpp@hz-desktop>
	<59E0C9F602000078001862C4@prv-mh.provo.novell.com>
	<alpine.DEB.2.10.1710131544350.2967@sstabellini-ThinkPad-X260>
	<50dba025-45db-f723-1441-c048f2a30e6a@redhat.com>
	<20171017121647.et5w5w3ss457twov@hz-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20171017121647.et5w5w3ss457twov@hz-desktop>
Subject: Re: [Qemu-devel] [Xen-devel] [RFC QEMU PATCH v3 00/10] Implement
 vNVDIMM for Xen HVM guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Haozhong Zhang <haozhong.zhang@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Jan Beulich <JBeulich@suse.com>, andrew.cooper3@citrix.com, Anthony Perard <anthony.perard@citrix.com>, george.dunlap@citrix.com, wei.liu2@citrix.com, ian.jackson@eu.citrix.com, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Dan Williams <dan.j.williams@intel.com>, Chao Peng <chao.p.peng@linux.intel.com>, xen-devel@lists.xen.org, xen-devel@lists.xenproject.org, qemu-devel@nongnu.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>

On Tue, Oct 17, 2017 at 08:16:47PM +0800, Haozhong Zhang wrote:
> On 10/17/17 13:45 +0200, Paolo Bonzini wrote:
> > On 14/10/2017 00:46, Stefano Stabellini wrote:
> > > On Fri, 13 Oct 2017, Jan Beulich wrote:
> > >>>>> On 13.10.17 at 13:13, <haozhong.zhang@intel.com> wrote:
> > >>> To Jan, Andrew, Stefano and Anthony,
> > >>>
> > >>> what do you think about allowing QEMU to build the entire guest ACPI
> > >>> and letting SeaBIOS to load it? ACPI builder code in hvmloader is
> > >>> still there and just bypassed in this case.
> > >> Well, if that can be made work in a non-quirky way and without
> > >> loss of functionality, I'd probably be fine. I do think, however,
> > >> that there's a reason this is being handled in hvmloader right now.
> > > And not to discourage you, just as a clarification, you'll also need to
> > > consider backward compatibility: unless the tables are identical, I
> > > imagine we'll have to keep using the old tables for already installed
> > > virtual machines.
> > 
> > I agree.  Some of them are already identical, some are not but the QEMU
> > version should be okay, and for yet more it's probably better to keep
> > the Xen-specific parts in hvmloader.
> > 
> > The good thing is that it's possible to proceed incrementally once you
> > have the hvmloader support for merging the QEMU and hvmloader RSDT or
> > XSDT (whatever you are using), starting with just NVDIMM and proceeding
> > later with whatever you see fit.
> > 
> 
> I'll have a try to check how much the differences would affect. If it
> would not take too much work, I'd like to adapt Xen NVDIMM enabling
> patches to the all QEMU built ACPI. Otherwise, I'll fall back to Paolo
> and MST's suggestions.

I don't agree with the end goal of fully switching to the QEMU build
ACPI tables. First of all, the only entity that has all the
information about the guest it's the toolstack, and so it should be
the one in control of the ACPI tables.

Also, Xen guests can use several device models concurrently (via the
ioreq server interface), and each should be able to contribute to the
information presented in the ACPI tables. Intel is also working on
adding IOMMU emulation to the Xen hypervisor, in which case the vIOMMU
ACPI tables should be created by the toolstack and not QEMU. And
finally keep in mind that there are Xen guests (PVH) that use ACPI
tables but not QEMU.

Thanks, Roger.
