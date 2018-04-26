Received: from eggs.gnu.org ([2001:4830:134:3::10]:35478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jmoyer@redhat.com>) id 1fBg05-0005dY-PZ
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 08:27:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jmoyer@redhat.com>) id 1fBg00-0006LC-Oc
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 08:27:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43924 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jmoyer@redhat.com>) id 1fBg00-0006JQ-KJ
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 08:27:44 -0400
From: Jeff Moyer <jmoyer@redhat.com>
References: <20180425112415.12327-1-pagupta@redhat.com>
	<20180425112415.12327-2-pagupta@redhat.com>
	<CAPcyv4hvrB08XPTbVK0xT2_1Xmaid=-v3OMxJVDTNwQucsOHLA@mail.gmail.com>
	<CAPcyv4hiowWozV527sQA_e4fdgCYbD6xfG==vepAqu0hxQEQcw@mail.gmail.com>
Date: Thu, 26 Apr 2018 08:27:41 -0400
In-Reply-To: <CAPcyv4hiowWozV527sQA_e4fdgCYbD6xfG==vepAqu0hxQEQcw@mail.gmail.com>
	(Dan Williams's message of "Wed, 25 Apr 2018 07:43:52 -0700")
Message-ID: <x49o9i6885e.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [RFC v2 1/2] virtio: add pmem driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Pankaj Gupta <pagupta@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, KVM list <kvm@vger.kernel.org>, Qemu Developers <qemu-devel@nongnu.org>, linux-nvdimm <linux-nvdimm@ml01.01.org>, Linux MM <linux-mm@kvack.org>, Jan Kara <jack@suse.cz>, Stefan Hajnoczi <stefanha@redhat.com>, Rik van Riel <riel@surriel.com>, Haozhong Zhang <haozhong.zhang@intel.com>, Nitesh Narayan Lal <nilal@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Zwisler,
	Ross" <ross.zwisler@intel.com>, David Hildenbrand <david@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Christoph Hellwig <hch@infradead.org>, Marcel Apfelbaum <marcel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, niteshnarayanlal@hotmail.com, Igor Mammedov <imammedo@redhat.com>, lcapitulino@redhat.com

Dan Williams <dan.j.williams@intel.com> writes:

> [ adding Jeff directly since he has also been looking at
> infrastructure to track when MAP_SYNC should be disabled ]
>
> On Wed, Apr 25, 2018 at 7:21 AM, Dan Williams <dan.j.williams@intel.com> wrote:
>> On Wed, Apr 25, 2018 at 4:24 AM, Pankaj Gupta <pagupta@redhat.com> wrote:
>>> This patch adds virtio-pmem driver for KVM
>>> guest.
>>
>> Minor nit, please expand your changelog line wrapping to 72 columns.
>>
>>>
>>> Guest reads the persistent memory range
>>> information from Qemu over VIRTIO and registers
>>> it on nvdimm_bus. It also creates a nd_region
>>> object with the persistent memory range
>>> information so that existing 'nvdimm/pmem'
>>> driver can reserve this into system memory map.
>>> This way 'virtio-pmem' driver uses existing
>>> functionality of pmem driver to register persistent
>>> memory compatible for DAX capable filesystems.
>>
>> We need some additional enabling to disable MAP_SYNC for this

enable to disable... I like it!  ;-)

>> configuration. In other words, if fsync() is required then we must
>> disable the MAP_SYNC optimization. I think this should be a struct
>> dax_device property looked up at mmap time in each MAP_SYNC capable
>> ->mmap() file operation implementation.

Ideally, qemu (seabios?) would advertise a platform capabilities
sub-table that doesn't fill in the flush bits.

-Jeff
