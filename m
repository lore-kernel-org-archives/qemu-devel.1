Received: from eggs.gnu.org ([2001:4830:134:3::10]:35838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1gBMR9-0003dE-R0
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 12:06:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1gBMR9-0003PM-4t
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 12:06:43 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:33536)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dan.j.williams@intel.com>)
	id 1gBMR8-0003MM-So
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 12:06:43 -0400
Received: by mail-ot1-x344.google.com with SMTP id q50so15173424otd.0
	for <qemu-devel@nongnu.org>; Sat, 13 Oct 2018 09:06:18 -0700 (PDT)
MIME-Version: 1.0
References: <20181013050021.11962-1-pagupta@redhat.com>
In-Reply-To: <20181013050021.11962-1-pagupta@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Sat, 13 Oct 2018 09:06:07 -0700
Message-ID: <CAPcyv4gEVxoNFUmFctSR6nRku_Pcz2GfXB+-iHBARmc+Wa+dfQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 0/2] kvm "fake DAX" device
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

On Fri, Oct 12, 2018 at 10:00 PM Pankaj Gupta <pagupta@redhat.com> wrote:
>
>  This patch series has implementation for "fake DAX".
>  "fake DAX" is fake persistent memory(nvdimm) in guest
>  which allows to bypass the guest page cache. This also
>  implements a VIRTIO based asynchronous flush mechanism.

Can we stop calling this 'fake DAX', because it isn't 'DAX' and it's
starting to confuse people. This enabling is effectively a
host-page-cache-passthrough mechanism not DAX. Let's call the whole
approach virtio-pmem, and leave DAX out of the name to hopefully
prevent people from wondering why some DAX features are disabled with
this driver. For example MAP_SYNC is not compatible with this
approach.

Additional enabling is need to disable MAP_SYNC in the presence of a
virtio-pmem device. See the rough proposal here:

    https://lkml.org/lkml/2018/4/25/756
