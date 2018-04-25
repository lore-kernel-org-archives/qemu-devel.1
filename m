Received: from eggs.gnu.org ([2001:4830:134:3::10]:37555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1fBLiE-0001VW-KR
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 10:48:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1fBLiB-00051R-Gd
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 10:48:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46472)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1fBLiB-000518-9z
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 10:47:59 -0400
Date: Wed, 25 Apr 2018 10:47:56 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
Message-ID: <458087373.22645020.1524667676533.JavaMail.zimbra@redhat.com>
In-Reply-To: <CAPcyv4gpZzKfE7jY1peYOVd6sVhNz7jce1s_xNH_2Lt8AjRK-Q@mail.gmail.com>
References: <20180425112415.12327-1-pagupta@redhat.com>
	<20180425112415.12327-3-pagupta@redhat.com>
	<CAPcyv4gpZzKfE7jY1peYOVd6sVhNz7jce1s_xNH_2Lt8AjRK-Q@mail.gmail.com>
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
To: Dan Williams <dan.j.williams@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, KVM list <kvm@vger.kernel.org>, Qemu Developers <qemu-devel@nongnu.org>, linux-nvdimm <linux-nvdimm@ml01.01.org>, Linux MM <linux-mm@kvack.org>, Jan Kara <jack@suse.cz>, Stefan Hajnoczi <stefanha@redhat.com>, Rik van Riel <riel@surriel.com>, Haozhong Zhang <haozhong.zhang@intel.com>, Nitesh Narayan Lal <nilal@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Ross Zwisler <ross.zwisler@intel.com>, David Hildenbrand <david@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Christoph Hellwig <hch@infradead.org>, Marcel Apfelbaum <marcel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, niteshnarayanlal@hotmail.com, Igor Mammedov <imammedo@redhat.com>, lcapitulino@redhat.com


> 
> On Wed, Apr 25, 2018 at 4:24 AM, Pankaj Gupta <pagupta@redhat.com> wrote:
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
> >         struct nd_region_data *ndrd = dev_get_drvdata(&nd_region->dev);
> >         int i, idx;
> >
> > +       /* call PV device flush */
> > +       if (test_bit(ND_REGION_VIRTIO, &nd_region->flags)) {
> > +               virtio_pmem_flush(&nd_region->dev);
> > +               return;
> > +       }
> > +
> 
> I'd rather introduce a ->flush() operation hanging off of 'struct
> nd_region' so that this multiplexing can be a static setting.

Sure! will make the change.

Thanks,
Pankaj
