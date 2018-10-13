Received: from eggs.gnu.org ([2001:4830:134:3::10]:36407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1gBMUq-0004ne-DZ
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 12:10:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1gBMUn-0004P9-Cr
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 12:10:31 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:40665)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dan.j.williams@intel.com>)
	id 1gBMUm-0004KR-AP
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 12:10:28 -0400
Received: by mail-ot1-x344.google.com with SMTP id w67so15149308ota.7
	for <qemu-devel@nongnu.org>; Sat, 13 Oct 2018 09:10:24 -0700 (PDT)
MIME-Version: 1.0
References: <20181013050021.11962-1-pagupta@redhat.com>
	<20181013050021.11962-3-pagupta@redhat.com>
In-Reply-To: <20181013050021.11962-3-pagupta@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Sat, 13 Oct 2018 09:10:13 -0700
Message-ID: <CAPcyv4hroaVWA-HgjWCnr7QTd_y7U8sCvS+Up733ttnD6_cKzQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 2/2] virtio-pmem: Add virtio pmem driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pankaj Gupta <pagupta@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, KVM list <kvm@vger.kernel.org>, Qemu Developers <qemu-devel@nongnu.org>, linux-nvdimm <linux-nvdimm@ml01.01.org>, Jan Kara <jack@suse.cz>, Stefan Hajnoczi <stefanha@redhat.com>, Rik van Riel <riel@surriel.com>, Nitesh Narayan Lal <nilal@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, zwisler@kernel.org, Vishal L Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, David Hildenbrand <david@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Christoph Hellwig <hch@infradead.org>, "Michael S. Tsirkin" <mst@redhat.com>, lcapitulino@redhat.com, Igor Mammedov <imammedo@redhat.com>, Eric Blake <eblake@redhat.com>

On Fri, Oct 12, 2018 at 10:01 PM Pankaj Gupta <pagupta@redhat.com> wrote:
>
> This patch adds virtio-pmem driver for KVM guest.
>
> Guest reads the persistent memory range information from
> Qemu over VIRTIO and registers it on nvdimm_bus. It also
> creates a nd_region object with the persistent memory
> range information so that existing 'nvdimm/pmem' driver
> can reserve this into system memory map. This way
> 'virtio-pmem' driver uses existing functionality of pmem
> driver to register persistent memory compatible for DAX
> capable filesystems.
>
> This also provides function to perform guest flush over
> VIRTIO from 'pmem' driver when userspace performs flush
> on DAX memory range.

Before we can move forward with this driver we need additional
filesystem enabling to detect when the backing device is fronting DAX
pmem or a paravirtualized page cache through virtio-pmem. Any
interface that requires fsync() and a round trip to the hypervisor to
flush host page cache is not DAX.
