Received: from eggs.gnu.org ([2001:4830:134:3::10]:56323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fEFX1-0007Ge-Eh
	for qemu-devel@nongnu.org; Thu, 03 May 2018 10:48:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fEFWy-000760-Ba
	for qemu-devel@nongnu.org; Thu, 03 May 2018 10:48:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46152)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1fEFWy-00074G-3H
	for qemu-devel@nongnu.org; Thu, 03 May 2018 10:48:24 -0400
Date: Thu, 3 May 2018 08:48:16 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20180503084816.072d59a9@w520.home>
In-Reply-To: <dbe7f81f-4301-62fe-34e6-0a1f2094da57@redhat.com>
References: <20180501162901.28940.1075.stgit@gimli.home>
	<20180501164332.28940.40383.stgit@gimli.home>
	<dbe7f81f-4301-62fe-34e6-0a1f2094da57@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/4] vfio/quirks: ioeventfd quirk
 acceleration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, kvm@vger.kernel.org

On Thu, 3 May 2018 16:33:25 +0200
Auger Eric <eric.auger@redhat.com> wrote:
> > +    if (!vdev->no_kvm_ioeventfd &&
> > +        addr > PCI_STD_HEADER_SIZEOF && last->added < MAX_DYN_IOEVENTFD + 1) {  
> nit: <= MAX_DYN_IOEVENTFD?

Done, also the addr test should be >=, it doesn't make sense to exclude
the first byte after the standard capabilities, though for this quirk
we know we're looking well above this.

> > +        if (addr != last->addr || data != last->data || size != last->size) {
> > +            last->addr = addr;
> > +            last->data = data;
> > +            last->size = size;
> > +            last->hits = 1;
> > +        } else if (++last->hits >= HITS_FOR_IOEVENTFD) {
> > +            if (last->added < MAX_DYN_IOEVENTFD) {
> > +                VFIOIOEventFD *ioeventfd;
> > +                ioeventfd = vfio_ioeventfd_init(vdev, mirror->mem, addr, size,
> > +                                        data, &vdev->bars[mirror->bar].region,
> > +                                        mirror->offset + addr, true);
> > +                if (ioeventfd) {
> > +                    VFIOQuirk *quirk;
> > +
> > +                    QLIST_FOREACH(quirk,
> > +                                  &vdev->bars[mirror->bar].quirks, next) {
> > +                        if (quirk->data == mirror) {
> > +                            QLIST_INSERT_HEAD(&quirk->ioeventfds,
> > +                                              ioeventfd, next);
> > +                            break;
> > +                        }
> > +                    }
> > +
> > +                    assert(quirk != NULL); /* Check not found */
> > +
> > +                    last->added++;
> > +                }
> > +            } else {
> > +                last->added++;
> > +
> > +                error_report("NVIDIA ioeventfd queue full for %s, unable to "
> > +                             "accelerate 0x%"HWADDR_PRIx", data 0x%"PRIx64", "
> > +                             "size %u", vdev->vbasedev.name, addr, data, size);  
> nit: warn_report?

Done

... 
> > +typedef struct VFIOIOEventFD {
> > +    QLIST_ENTRY(VFIOIOEventFD) next;
> > +    MemoryRegion *mr;
> > +    hwaddr addr;
> > +    unsigned size;
> > +    uint64_t data;
> > +    EventNotifier e;
> > +    VFIORegion *region;
> > +    hwaddr region_addr;
> > +    bool match_data;
> > +    bool dynamic;  
> maybe the "dynamic" semantics may be docuemnted in the code and not only
> in the commit message.

Done, added

/* Added runtime, removed on device reset */

Thanks!

Alex
