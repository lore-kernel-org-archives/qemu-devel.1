Received: from eggs.gnu.org ([2001:4830:134:3::10]:42052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1ebrYs-0000Mz-5b
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 12:31:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1ebrYo-0008Ud-8S
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 12:31:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39988)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1ebrYo-0008Tv-0A
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 12:31:38 -0500
Date: Wed, 17 Jan 2018 12:31:31 -0500 (EST)
From: Pankaj Gupta <pagupta@redhat.com>
Message-ID: <1574489596.1317450.1516210291136.JavaMail.zimbra@redhat.com>
In-Reply-To: <CAPcyv4iCDGx11vHmxK=Q3aLdUBFef1QuvGE_Jh3DLm1pPkeeMw@mail.gmail.com>
References: <1455443283.33337333.1500618150787.JavaMail.zimbra@redhat.com>
	<d1df875c-5b64-67d9-2b3c-4ec14c03b85b@gmail.com>
	<CAPcyv4ip6m6e9Bh7weJNB3m3kpDpRkhHDZf0JYyr5UbkD41oLg@mail.gmail.com>
	<654f8935-258e-22ef-fae4-3e14e91e8fae@redhat.com>
	<336152896.34452750.1511527207457.JavaMail.zimbra@redhat.com>
	<CAPcyv4j6nk1cJFuG4DDA9JoNJe2d3rSskdFSUPu4aWzWX+JQeQ@mail.gmail.com>
	<326660076.6160176.1515824585284.JavaMail.zimbra@redhat.com>
	<CAPcyv4iCDGx11vHmxK=Q3aLdUBFef1QuvGE_Jh3DLm1pPkeeMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] KVM "fake DAX" flushing interface - discussion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Rik van Riel <riel@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>, Stefan Hajnoczi <stefanha@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, kvm-devel <kvm@vger.kernel.org>, Qemu Developers <qemu-devel@nongnu.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@ml01.01.org>, ross zwisler <ross.zwisler@linux.intel.com>, Kevin Wolf <kwolf@redhat.com>, Nitesh Narayan Lal <nilal@redhat.com>, Haozhong Zhang <haozhong.zhang@intel.com>, Ross Zwisler <ross.zwisler@intel.com>, Rik van Riel <riel@surriel.com>


Hi Dan,

Thanks for your reply.

> 
> On Fri, Jan 12, 2018 at 10:23 PM, Pankaj Gupta <pagupta@redhat.com> wrote:
> >
> > Hello Dan,
> >
> >> Not a flag, but a new "Address Range Type GUID". See section "5.2.25.2
> >> System Physical Address (SPA) Range Structure" in the ACPI 6.2A
> >> specification. Since it is a GUID we could define a Linux specific
> >> type for this case, but spec changes would allow non-Linux hypervisors
> >> to advertise a standard interface to guests.
> >>
> >
> > I have added new SPA with a GUUID for this memory type and I could add
> > this new memory type in System memory map. I need help with the namespace
> > handling for this new type As mentioned in [1] discussion:
> >
> > - Create a new namespace for this new memory type
> > - Teach libnvdimm how to handle this new namespace
> >
> > I have some queries on this:
> >
> > 1] How namespace handling of this new memory type would be?
> 
> This would be a namespace that creates a pmem device, but does not allow DAX.

o.k

> 
> >
> > 2] There are existing namespace types:
> >   ND_DEVICE_NAMESPACE_IO, ND_DEVICE_NAMESPACE_PMEM, ND_DEVICE_NAMESPACE_BLK
> >
> >   How libnvdimm will handle this new name-space type in conjuction with
> >   existing
> >   memory type, region & namespaces?
> 
> The type will be either ND_DEVICE_NAMESPACE_IO or
> ND_DEVICE_NAMESPACE_PMEM depending on whether you configure KVM to
> provide a virtual NVDIMM and label space. In other words the only
> difference between this range and a typical persistent memory range is
> that we will have a flag to disable DAX operation.

o.k. In short we have disable this flag 'QUEUE_FLAG_DAX' for this 
namespace & region? Also don't execute below code for this new type?

pmem_attach_disk()
...
...
        dax_dev = alloc_dax(pmem, disk->disk_name, &pmem_dax_ops);
        if (!dax_dev) {
                put_disk(disk);
                return -ENOMEM;
        }
        dax_write_cache(dax_dev, wbc);
        pmem->dax_dev = dax_dev;

> 
> See the usage of nvdimm_has_cache() in pmem_attach_disk() as an
> example of how to pass attributes about the "region" to the the pmem
> driver.

sure.

> 
> >
> > 3] For sending guest to host flush commands we still have to think about
> > some
> >    async way?
> 
> I thought we discussed this being a paravirtualized virtio command ring?

o.k. will implement this. 

> 
