Received: from eggs.gnu.org ([2001:4830:134:3::10]:57151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1fBLIS-0004CE-K4
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 10:21:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1fBLIR-0000fw-Qx
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 10:21:24 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:33852)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dan.j.williams@intel.com>)
	id 1fBLIR-0000ec-JP
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 10:21:23 -0400
Received: by mail-ot0-x241.google.com with SMTP id i5-v6so25518502oth.1
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 07:21:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180425112415.12327-2-pagupta@redhat.com>
References: <20180425112415.12327-1-pagupta@redhat.com>
	<20180425112415.12327-2-pagupta@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 25 Apr 2018 07:21:21 -0700
Message-ID: <CAPcyv4hvrB08XPTbVK0xT2_1Xmaid=-v3OMxJVDTNwQucsOHLA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC v2 1/2] virtio: add pmem driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pankaj Gupta <pagupta@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, KVM list <kvm@vger.kernel.org>, Qemu Developers <qemu-devel@nongnu.org>, linux-nvdimm <linux-nvdimm@ml01.01.org>, Linux MM <linux-mm@kvack.org>, Jan Kara <jack@suse.cz>, Stefan Hajnoczi <stefanha@redhat.com>, Rik van Riel <riel@surriel.com>, Haozhong Zhang <haozhong.zhang@intel.com>, Nitesh Narayan Lal <nilal@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Zwisler, Ross" <ross.zwisler@intel.com>, David Hildenbrand <david@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Christoph Hellwig <hch@infradead.org>, Marcel Apfelbaum <marcel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, niteshnarayanlal@hotmail.com, Igor Mammedov <imammedo@redhat.com>, lcapitulino@redhat.com

On Wed, Apr 25, 2018 at 4:24 AM, Pankaj Gupta <pagupta@redhat.com> wrote:
> This patch adds virtio-pmem driver for KVM
> guest.

Minor nit, please expand your changelog line wrapping to 72 columns.

>
> Guest reads the persistent memory range
> information from Qemu over VIRTIO and registers
> it on nvdimm_bus. It also creates a nd_region
> object with the persistent memory range
> information so that existing 'nvdimm/pmem'
> driver can reserve this into system memory map.
> This way 'virtio-pmem' driver uses existing
> functionality of pmem driver to register persistent
> memory compatible for DAX capable filesystems.

We need some additional enabling to disable MAP_SYNC for this
configuration. In other words, if fsync() is required then we must
disable the MAP_SYNC optimization. I think this should be a struct
dax_device property looked up at mmap time in each MAP_SYNC capable
->mmap() file operation implementation.
