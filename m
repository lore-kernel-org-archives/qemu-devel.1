Received: from eggs.gnu.org ([209.51.188.92]:52531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1hEbnR-00010m-MW
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 11:39:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1hEbnQ-00085Q-PP
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 11:39:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42638)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1hEbnQ-0007wx-9d
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 11:39:24 -0400
Date: Thu, 11 Apr 2019 11:39:06 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
Message-ID: <393821092.21153045.1554997146416.JavaMail.zimbra@redhat.com>
In-Reply-To: <CAPcyv4gXwE2k3JU94GPav0xn2LEgR6-7ZEVYyTHFRjCfTYjerw@mail.gmail.com>
References: <20190410040826.24371-1-pagupta@redhat.com>
	<20190410040826.24371-4-pagupta@redhat.com>
	<CAPcyv4gXwE2k3JU94GPav0xn2LEgR6-7ZEVYyTHFRjCfTYjerw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 3/6] libnvdimm: add dax_dev sync flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, KVM list <kvm@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Qemu Developers <qemu-devel@nongnu.org>, linux-ext4 <linux-ext4@vger.kernel.org>, linux-xfs <linux-xfs@vger.kernel.org>, Ross Zwisler <zwisler@kernel.org>, Vishal L Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Matthew Wilcox <willy@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Christoph Hellwig <hch@infradead.org>, Len Brown <lenb@kernel.org>, Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, "Darrick J. Wong" <darrick.wong@oracle.com>, lcapitulino@redhat.com, Kevin Wolf <kwolf@redhat.com>, Igor Mammedov <imammedo@redhat.com>, jmoyer <jmoyer@redhat.com>, Nitesh Narayan Lal <nilal@redhat.com>, Rik van Riel <riel@surriel.com>, Stefan Hajnoczi <stefanha@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, David Hildenbrand <david@redhat.com>, david <david@fromorbit.com>, cohuck@redhat.com, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, kilobyte@angband.pl, yuval shaia <yuval.shaia@oracle.com>


Hi Dan,

Thank you for the review.

> >
> > This patch adds 'DAXDEV_SYNC' flag which is set
> > for nd_region doing synchronous flush. This later
> > is used to disable MAP_SYNC functionality for
> > ext4 & xfs filesystem for devices don't support
> > synchronous flush.
> >
> > Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> > ---
> >  drivers/dax/bus.c            |  2 +-
> >  drivers/dax/super.c          | 13 ++++++++++++-
> >  drivers/md/dm.c              |  2 +-
> >  drivers/nvdimm/pmem.c        |  3 ++-
> >  drivers/nvdimm/region_devs.c |  7 +++++++
> >  include/linux/dax.h          |  9 +++++++--
> >  include/linux/libnvdimm.h    |  1 +
> >  7 files changed, 31 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> > index 2109cfe80219..431bf7d2a7f9 100644
> > --- a/drivers/dax/bus.c
> > +++ b/drivers/dax/bus.c
> > @@ -388,7 +388,7 @@ struct dev_dax *__devm_create_dev_dax(struct dax_region
> > *dax_region, int id,
> >          * No 'host' or dax_operations since there is no access to this
> >          * device outside of mmap of the resulting character device.
> >          */
> > -       dax_dev = alloc_dax(dev_dax, NULL, NULL);
> > +       dax_dev = alloc_dax(dev_dax, NULL, NULL, true);
> 
> I find apis that take a boolean as unreadable. What does 'true' mean?
> It wastes time to go look at the function definition vs something
> like:
> 
>     alloc_dax(dev_dax, NULL, NULL, DAXDEV_F_SYNC);

Agree. Will change as suggested.

Best regards,
Pankaj
> 
