Received: from eggs.gnu.org ([2001:4830:134:3::10]:41474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=457281bb7=roger.pau@citrix.com>)
	id 1e4k8t-0000m9-0q
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 04:56:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=457281bb7=roger.pau@citrix.com>)
	id 1e4k8p-0003t8-Uo
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 04:55:59 -0400
Received: from smtp.citrix.com.au ([103.14.252.240]:5523)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=457281bb7=roger.pau@citrix.com>)
	id 1e4k8p-0003pV-BS
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 04:55:55 -0400
Date: Wed, 18 Oct 2017 09:55:44 +0100
From: Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
Message-ID: <20171018085544.xvtiejabymftfcz5@dhcp-3-128.uk.xensource.com>
References: <f6478644-0d4a-6531-9016-aee2a0e76417@redhat.com>
	<20171013075326.77azyi4j2wo3b2fx@hz-desktop>
	<20171013104453.50284426@nial.brq.redhat.com>
	<20171013111341.feb2462nh2rcrjpp@hz-desktop>
	<59E0C9F602000078001862C4@prv-mh.provo.novell.com>
	<alpine.DEB.2.10.1710131544350.2967@sstabellini-ThinkPad-X260>
	<50dba025-45db-f723-1441-c048f2a30e6a@redhat.com>
	<20171017121647.et5w5w3ss457twov@hz-desktop>
	<20171018083225.4x42tkamuuauj4ki@dhcp-3-128.uk.xensource.com>
	<f43ea65c-29c5-42bd-9b1e-9200662d4e41@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f43ea65c-29c5-42bd-9b1e-9200662d4e41@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Haozhong Zhang <haozhong.zhang@intel.com>, Stefano Stabellini <sstabellini@kernel.org>, Jan Beulich <JBeulich@suse.com>, andrew.cooper3@citrix.com, Anthony Perard <anthony.perard@citrix.com>, george.dunlap@citrix.com, wei.liu2@citrix.com, ian.jackson@eu.citrix.com, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Dan Williams <dan.j.williams@intel.com>, Chao Peng <chao.p.peng@linux.intel.com>, xen-devel@lists.xen.org, xen-devel@lists.xenproject.org, qemu-devel@nongnu.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>

On Wed, Oct 18, 2017 at 10:46:57AM +0200, Paolo Bonzini wrote:
> On 18/10/2017 10:32, Roger Pau Monné wrote:
> >> I'll have a try to check how much the differences would affect. If it
> >> would not take too much work, I'd like to adapt Xen NVDIMM enabling
> >> patches to the all QEMU built ACPI. Otherwise, I'll fall back to Paolo
> >> and MST's suggestions.
> > I don't agree with the end goal of fully switching to the QEMU build
> > ACPI tables. First of all, the only entity that has all the
> > information about the guest it's the toolstack, and so it should be
> > the one in control of the ACPI tables.
> > 
> > Also, Xen guests can use several device models concurrently (via the
> > ioreq server interface), and each should be able to contribute to the
> > information presented in the ACPI tables. Intel is also working on
> > adding IOMMU emulation to the Xen hypervisor, in which case the vIOMMU
> > ACPI tables should be created by the toolstack and not QEMU. And
> > finally keep in mind that there are Xen guests (PVH) that use ACPI
> > tables but not QEMU.
> 
> I agree with this in fact; QEMU has a view of _most_ of the emulated
> hardware, but not all.
> 
> However, I disagree that the toolstack should be alone in controlling
> the ACPI tables; rather, each involved part of the stack should be
> providing its own part of the tables.  For example, QEMU (in addition to
> NVDIMM information) should be the one providing an SSDT for southbridge
> devices (floppy, COMx, LPTx, etc.).

Yes, that's what I wanted to say, rather than the toolstack providing
all the ACPI tables by itself. Every component should provide the
tables of the devices under it's control, and that should be glued
together by the toolstack (ie: hvmloader).

Roger.
