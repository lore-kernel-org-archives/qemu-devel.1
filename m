Received: from eggs.gnu.org ([2001:4830:134:3::10]:48958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1fBjx4-0003qv-Sr
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 12:40:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1fBjx1-0004J7-ON
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 12:40:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51594)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1fBjx1-0004Ih-G3
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 12:40:55 -0400
Date: Thu, 26 Apr 2018 12:40:53 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
Message-ID: <58645254.23011245.1524760853269.JavaMail.zimbra@redhat.com>
In-Reply-To: <20180426131517.GB30991@stefanha-x1.localdomain>
References: <20180425112415.12327-1-pagupta@redhat.com>
	<20180425112415.12327-3-pagupta@redhat.com>
	<20180426131517.GB30991@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v2 2/2] pmem: device flush over VIRTIO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, linux-nvdimm@ml01.01.org, linux-mm@kvack.org, jack@suse.cz, stefanha@redhat.com, dan j williams <dan.j.williams@intel.com>, riel@surriel.com, haozhong zhang <haozhong.zhang@intel.com>, nilal@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, ross zwisler <ross.zwisler@intel.com>, david@redhat.com, xiaoguangrong eric <xiaoguangrong.eric@gmail.com>, hch@infradead.org, marcel@redhat.com, mst@redhat.com, niteshnarayanlal@hotmail.com, imammedo@redhat.com, lcapitulino@redhat.com


> 
> On Wed, Apr 25, 2018 at 04:54:14PM +0530, Pankaj Gupta wrote:
> > This patch adds functionality to perform
> > flush from guest to hosy over VIRTIO
> > when 'ND_REGION_VIRTIO'flag is set on
> > nd_negion. Flag is set by 'virtio-pmem'
> > driver.
> > 
> > Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> > ---
> >  drivers/nvdimm/region_devs.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
> > index a612be6..6c6454e 100644
> > --- a/drivers/nvdimm/region_devs.c
> > +++ b/drivers/nvdimm/region_devs.c
> > @@ -20,6 +20,7 @@
> >  #include <linux/nd.h>
> >  #include "nd-core.h"
> >  #include "nd.h"
> > +#include <linux/virtio_pmem.h>
> >  
> >  /*
> >   * For readq() and writeq() on 32-bit builds, the hi-lo, lo-hi order is
> > @@ -1074,6 +1075,12 @@ void nvdimm_flush(struct nd_region *nd_region)
> >  	struct nd_region_data *ndrd = dev_get_drvdata(&nd_region->dev);
> >  	int i, idx;
> >  
> > +       /* call PV device flush */
> > +	if (test_bit(ND_REGION_VIRTIO, &nd_region->flags)) {
> > +		virtio_pmem_flush(&nd_region->dev);
> > +		return;
> > +	}
> 
> How does libnvdimm know when flush has completed?
> 
> Callers expect the flush to be finished when nvdimm_flush() returns but
> the virtio driver has only queued the request, it hasn't waited for
> completion!

I tried to implement what nvdimm does right now. It just writes to
flush hint address to make sure data persists.

I just did not want to block guest write requests till host side 
fsync completes.

Operations(write/fsync) on same file would be blocking at guest side and wait time could 
be worse for operations on different guest files because all these operations would happen 
ultimately on same file at host.

I think with current way, we can achieve an asynchronous queuing mechanism on cost of not 
100% sure when fsync would complete but it is assured it will happen. Also, its entire block
flush.

I am open for suggestions here, this is my current thought and implementation. 

Thanks,
Pankaj
