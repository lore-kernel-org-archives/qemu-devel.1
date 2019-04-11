Received: from eggs.gnu.org ([209.51.188.92]:35810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1hEcTi-00082g-Nu
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 12:23:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1hEcTh-0004cU-Bw
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 12:23:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39738)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1hEcTg-0004c6-P3
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 12:23:05 -0400
Date: Thu, 11 Apr 2019 12:23:00 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
Message-ID: <1150671088.21162726.1554999780030.JavaMail.zimbra@redhat.com>
In-Reply-To: <CAPcyv4gOPtgmVyk+zayRBtkbSivEvBNn1tyKL2ycT_q_nTHUUA@mail.gmail.com>
References: <20190410040826.24371-1-pagupta@redhat.com>
	<20190410040826.24371-2-pagupta@redhat.com>
	<CAPcyv4i1FjBzfcWtzeCvj-giHa9xaX0dMQ==q4LZC_L8VEqkHg@mail.gmail.com>
	<1463291806.21158433.1554998258746.JavaMail.zimbra@redhat.com>
	<CAPcyv4gOPtgmVyk+zayRBtkbSivEvBNn1tyKL2ycT_q_nTHUUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 1/6] libnvdimm: nd_region flush callback
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dan Williams <dan.j.williams@intel.com>
Cc: cohuck@redhat.com, Jan Kara <jack@suse.cz>, KVM list <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, david <david@fromorbit.com>, Qemu Developers <qemu-devel@nongnu.org>, virtualization@lists.linux-foundation.org, Andreas Dilger <adilger.kernel@dilger.ca>, Ross Zwisler <zwisler@kernel.org>, Andrea Arcangeli <aarcange@redhat.com>, Dave Jiang <dave.jiang@intel.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, Vishal L Verma <vishal.l.verma@intel.com>, David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>, Linux ACPI <linux-acpi@vger.kernel.org>, jmoyer <jmoyer@redhat.com>, linux-ext4 <linux-ext4@vger.kernel.org>, Len Brown <lenb@kernel.org>, kilobyte@angband.pl, Rik van Riel <riel@surriel.com>, yuval shaia <yuval.shaia@oracle.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, lcapitulino@redhat.com, Kevin Wolf <kwolf@redhat.com>, Nitesh Narayan Lal <nilal@redhat.com>, Theodore Ts'o <tytso@mit.edu>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, "Darrick J. Wong" <darrick.wong@oracle.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-xfs <linux-xfs@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Igor Mammedov <imammedo@redhat.com>


> > > > This patch adds functionality to perform flush from guest
> > > > to host over VIRTIO. We are registering a callback based
> > > > on 'nd_region' type. virtio_pmem driver requires this special
> > > > flush function. For rest of the region types we are registering
> > > > existing flush function. Report error returned by host fsync
> > > > failure to userspace.
> > > >
> > > > This also handles asynchronous flush requests from the block layer
> > > > by creating a child bio and chaining it with parent bio.
> > > >
> > > > Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> > > > ---bio_chain Dan williams
> > > [..]
> > > > diff --git a/drivers/nvdimm/region_devs.c
> > > > b/drivers/nvdimm/region_devs.c
> > > > index b4ef7d9ff22e..fb1041ab32a6 100644
> > > > --- a/drivers/nvdimm/region_devs.c
> > > > +++ b/drivers/nvdimm/region_devs.c
> > > > @@ -295,7 +295,9 @@ static ssize_t deep_flush_store(struct device *dev,
> > > > struct device_attribute *att
> > > >                 return rc;
> > > >         if (!flush)
> > > >                 return -EINVAL;
> > > > -       nvdimm_flush(nd_region);
> > > > +       rc = nvdimm_flush(nd_region, NULL, false);
> > > > +       if (rc)
> > > > +               return rc;
> > > >
> > > >         return len;
> > > >  }
> > > > @@ -1085,6 +1087,11 @@ static struct nd_region *nd_region_create(struct
> > > > nvdimm_bus *nvdimm_bus,
> > > >         dev->of_node = ndr_desc->of_node;
> > > >         nd_region->ndr_size = resource_size(ndr_desc->res);
> > > >         nd_region->ndr_start = ndr_desc->res->start;
> > > > +       if (ndr_desc->flush)
> > > > +               nd_region->flush = ndr_desc->flush;
> > > > +       else
> > > > +               nd_region->flush = generic_nvdimm_flush;
> > > > +
> > > >         nd_device_register(dev);
> > > >
> > > >         return nd_region;
> > > > @@ -1125,11 +1132,36 @@ struct nd_region
> > > > *nvdimm_volatile_region_create(struct nvdimm_bus *nvdimm_bus,
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(nvdimm_volatile_region_create);
> > > >
> > > > +int nvdimm_flush(struct nd_region *nd_region, struct bio *bio, bool
> > > > async)
> > > > +{
> > >
> > > I don't quite see the point of the 'async' argument. All the usages of
> > > this routine are either
> > >
> > > nvdimm_flush(nd_region, bio, true)
> > > ...or:
> > > nvdimm_flush(nd_region, NULL, false)
> >
> > Agree.
> >
> > >
> > > ...so why not gate async behavior on the presence of the 'bio' argument?
> >
> > Sure.
> >
> > >
> > >
> > > > +       int rc = 0;
> > > > +
> > > > +       /* Create child bio for asynchronous flush and chain with
> > > > +        * parent bio. Otherwise directly call nd_region flush.
> > > > +        */
> > > > +       if (async && bio->bi_iter.bi_sector != -1) {
> > > > +
> > > > +               struct bio *child = bio_alloc(GFP_ATOMIC, 0);
> > > > +
> > > > +               if (!child)
> > > > +                       return -ENOMEM;
> > > > +               bio_copy_dev(child, bio);
> > > > +               child->bi_opf = REQ_PREFLUSH;
> > > > +               child->bi_iter.bi_sector = -1;
> > > > +               bio_chain(child, bio);
> > > > +               submit_bio(child);
> > >
> > > I understand how this works, but it's a bit too "magical" for my
> > > taste. I would prefer that all flush implementations take an optional
> > > 'bio' argument rather than rely on the make_request implementation to
> > > stash the bio away on a driver specific list.
> >
> > I did this to make use of "bio_chain" for chaining child bio for async
> > flush
> > suggested [1]. Are you saying to remove this and just call "flush" based on
> > bio argument? Or I implemented the 'bio_chain' request entirely wrong?
> 
> No, I think you implemented it correctly. I'm just asking for the
> chaining to be performed internal to the ->flush() callback rather
> than in the common nvdimm_flush() front-end.

Sure. Perfect!

Thank you very much for all the suggestions. 

Best regards,
Pankaj
> 
