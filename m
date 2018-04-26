Received: from eggs.gnu.org ([2001:4830:134:3::10]:35271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1fBkUi-0005oX-89
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 13:15:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1fBkUe-00041U-5R
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 13:15:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42350)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1fBkUd-00041G-Ts
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 13:15:40 -0400
Date: Thu, 26 Apr 2018 13:15:38 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
Message-ID: <1499190564.23017177.1524762938762.JavaMail.zimbra@redhat.com>
In-Reply-To: <x49o9i6885e.fsf@segfault.boston.devel.redhat.com>
References: <20180425112415.12327-1-pagupta@redhat.com>
	<20180425112415.12327-2-pagupta@redhat.com>
	<CAPcyv4hvrB08XPTbVK0xT2_1Xmaid=-v3OMxJVDTNwQucsOHLA@mail.gmail.com>
	<CAPcyv4hiowWozV527sQA_e4fdgCYbD6xfG==vepAqu0hxQEQcw@mail.gmail.com>
	<x49o9i6885e.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v2 1/2] virtio: add pmem driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Moyer <jmoyer@redhat.com>, Dan Williams <dan.j.williams@intel.com>
Cc: Jan Kara <jack@suse.cz>, KVM list <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>, linux-nvdimm <linux-nvdimm@ml01.01.org>, Ross Zwisler <ross.zwisler@intel.com>, Qemu Developers <qemu-devel@nongnu.org>, lcapitulino@redhat.com, Linux MM <linux-mm@kvack.org>, niteshnarayanlal@hotmail.com, "Michael S. Tsirkin" <mst@redhat.com>, Christoph Hellwig <hch@infradead.org>, Marcel Apfelbaum <marcel@redhat.com>, Nitesh Narayan Lal <nilal@redhat.com>, Haozhong Zhang <haozhong.zhang@intel.com>, Rik van Riel <riel@surriel.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Igor Mammedov <imammedo@redhat.com>


> 
> Dan Williams <dan.j.williams@intel.com> writes:
> 
> > [ adding Jeff directly since he has also been looking at
> > infrastructure to track when MAP_SYNC should be disabled ]
> >
> > On Wed, Apr 25, 2018 at 7:21 AM, Dan Williams <dan.j.williams@intel.com>
> > wrote:
> >> On Wed, Apr 25, 2018 at 4:24 AM, Pankaj Gupta <pagupta@redhat.com> wrote:
> >>> This patch adds virtio-pmem driver for KVM
> >>> guest.
> >>
> >> Minor nit, please expand your changelog line wrapping to 72 columns.
> >>
> >>>
> >>> Guest reads the persistent memory range
> >>> information from Qemu over VIRTIO and registers
> >>> it on nvdimm_bus. It also creates a nd_region
> >>> object with the persistent memory range
> >>> information so that existing 'nvdimm/pmem'
> >>> driver can reserve this into system memory map.
> >>> This way 'virtio-pmem' driver uses existing
> >>> functionality of pmem driver to register persistent
> >>> memory compatible for DAX capable filesystems.
> >>
> >> We need some additional enabling to disable MAP_SYNC for this
> 
> enable to disable... I like it!  ;-)
> 
> >> configuration. In other words, if fsync() is required then we must
> >> disable the MAP_SYNC optimization. I think this should be a struct
> >> dax_device property looked up at mmap time in each MAP_SYNC capable
> >> ->mmap() file operation implementation.

I understand you mean we want to disable 'MAP_SYNC' optimization as
we are relying on additional fsync. You mean if we add a property/flag
in dax_device struct and its set, disable 'MAP_SYNC' accordingly during
mmap time for corresponding filesystems?  

> 
> Ideally, qemu (seabios?) would advertise a platform capabilities
> sub-table that doesn't fill in the flush bits.

Could you please elaborate on this, how its related to disabling
MAP_SYNC? We are not doing entire nvdimm device emulation. 

> 
> -Jeff
> 
> 
