Received: from eggs.gnu.org ([2001:4830:134:3::10]:34854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1feye3-0006lk-H6
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 04:14:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1feydm-0008Cz-3M
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 04:14:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34910)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1feydk-0008BB-Fb
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 04:13:53 -0400
Date: Mon, 16 Jul 2018 04:13:47 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
Message-ID: <9008103.50980761.1531728827436.JavaMail.zimbra@redhat.com>
In-Reply-To: <20180713163559.692aca30@doriath>
References: <20180713075232.9575-1-pagupta@redhat.com>
	<20180713075232.9575-2-pagupta@redhat.com>
	<20180713163559.692aca30@doriath>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v3 1/2] libnvdimm: Add flush callback for
 virtio pmem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Luiz Capitulino <lcapitulino@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, linux-nvdimm@ml01.01.org, jack@suse.cz, stefanha@redhat.com, dan j williams <dan.j.williams@intel.com>, riel@surriel.com, nilal@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, ross zwisler <ross.zwisler@intel.com>, david@redhat.com, xiaoguangrong eric <xiaoguangrong.eric@gmail.com>, hch@infradead.org, mst@redhat.com, niteshnarayanlal@hotmail.com, imammedo@redhat.com, eblake@redhat.com


Hi Luiz,

> 
> > This patch adds functionality to perform flush from guest to host
> > over VIRTIO. We are registering a callback based on 'nd_region' type.
> > As virtio_pmem driver requires this special flush interface, for rest
> > of the region types we are registering existing flush function.
> > Also report the error returned by virtio flush interface.
> 
> This patch doesn't apply against latest upstream. A few more comments
> below.

My bad, I tested it with 4.17-rc1. Will rebase it.

> 
> > 
> > Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> > ---
> >  drivers/nvdimm/nd.h          |  1 +
> >  drivers/nvdimm/pmem.c        |  4 ++--
> >  drivers/nvdimm/region_devs.c | 24 ++++++++++++++++++------
> >  include/linux/libnvdimm.h    |  5 ++++-
> >  4 files changed, 25 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/nvdimm/nd.h b/drivers/nvdimm/nd.h
> > index 32e0364..1b62f79 100644
> > --- a/drivers/nvdimm/nd.h
> > +++ b/drivers/nvdimm/nd.h
> > @@ -159,6 +159,7 @@ struct nd_region {
> >  	struct badblocks bb;
> >  	struct nd_interleave_set *nd_set;
> >  	struct nd_percpu_lane __percpu *lane;
> > +	int (*flush)(struct device *dev);
> >  	struct nd_mapping mapping[0];
> >  };
> >  
> > diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> > index 9d71492..29fd2cd 100644
> > --- a/drivers/nvdimm/pmem.c
> > +++ b/drivers/nvdimm/pmem.c
> > @@ -180,7 +180,7 @@ static blk_qc_t pmem_make_request(struct request_queue
> > *q, struct bio *bio)
> >  	struct nd_region *nd_region = to_region(pmem);
> >  
> >  	if (bio->bi_opf & REQ_FLUSH)
> > -		nvdimm_flush(nd_region);
> > +		bio->bi_status = nvdimm_flush(nd_region);
> >  
> >  	do_acct = nd_iostat_start(bio, &start);
> >  	bio_for_each_segment(bvec, bio, iter) {
> > @@ -196,7 +196,7 @@ static blk_qc_t pmem_make_request(struct request_queue
> > *q, struct bio *bio)
> >  		nd_iostat_end(bio, start);
> >  
> >  	if (bio->bi_opf & REQ_FUA)
> > -		nvdimm_flush(nd_region);
> > +		bio->bi_status = nvdimm_flush(nd_region);
> >  
> >  	bio_endio(bio);
> >  	return BLK_QC_T_NONE;
> > diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
> > index a612be6..124aae7 100644
> > --- a/drivers/nvdimm/region_devs.c
> > +++ b/drivers/nvdimm/region_devs.c
> > @@ -1025,6 +1025,7 @@ static struct nd_region *nd_region_create(struct
> > nvdimm_bus *nvdimm_bus,
> >  	dev->of_node = ndr_desc->of_node;
> >  	nd_region->ndr_size = resource_size(ndr_desc->res);
> >  	nd_region->ndr_start = ndr_desc->res->start;
> > +	nd_region->flush = ndr_desc->flush;
> >  	nd_device_register(dev);
> >  
> >  	return nd_region;
> > @@ -1065,13 +1066,10 @@ struct nd_region
> > *nvdimm_volatile_region_create(struct nvdimm_bus *nvdimm_bus,
> >  }
> >  EXPORT_SYMBOL_GPL(nvdimm_volatile_region_create);
> >  
> > -/**
> > - * nvdimm_flush - flush any posted write queues between the cpu and pmem
> > media
> > - * @nd_region: blk or interleaved pmem region
> > - */
> > -void nvdimm_flush(struct nd_region *nd_region)
> > +void pmem_flush(struct device *dev)
> >  {
> > -	struct nd_region_data *ndrd = dev_get_drvdata(&nd_region->dev);
> > +	struct nd_region_data *ndrd = dev_get_drvdata(dev);
> > +	struct nd_region *nd_region = to_nd_region(dev);
> >  	int i, idx;
> >  
> >  	/*
> > @@ -1094,6 +1092,20 @@ void nvdimm_flush(struct nd_region *nd_region)
> >  			writeq(1, ndrd_get_flush_wpq(ndrd, i, idx));
> >  	wmb();
> >  }
> > +
> > +/**
> > + * nvdimm_flush - flush any posted write queues between the cpu and pmem
> > media
> > + * @nd_region: blk or interleaved pmem region
> > + */
> > +int nvdimm_flush(struct nd_region *nd_region)
> > +{
> > +	if (nd_region->flush)
> > +		return(nd_region->flush(&nd_region->dev));
> > +
> > +	pmem_flush(&nd_region->dev);
> 
> IMHO, a better way of doing this would be to allow nvdimm_flush() to
> be overridden. That is, in nd_region_create() you set nd_region->flush
> to the original nvdimm_flush() if ndr_desc->flush is NULL. And then
> always call nd_region->flush() where nvdimm_flush() is called today.

I wanted to do minimal changes for actual 'nvdimm_flush' function because it
does not return an error or return status for fsync. So, I needed to differentiate
between 'fake DAX' & 'NVDIMM' at the time of calling 'flush', otherwise I need to 
change 'nvdimm_flush' to return zero for all the calls.

Looks like I am already doing this, will change as suggested.  
 
> 
> > +
> > +	return 0;
> > +}
> >  EXPORT_SYMBOL_GPL(nvdimm_flush);
> >  
> >  /**
> > diff --git a/include/linux/libnvdimm.h b/include/linux/libnvdimm.h
> > index 097072c..33b617f 100644
> > --- a/include/linux/libnvdimm.h
> > +++ b/include/linux/libnvdimm.h
> > @@ -126,6 +126,7 @@ struct nd_region_desc {
> >  	int numa_node;
> >  	unsigned long flags;
> >  	struct device_node *of_node;
> > +	int (*flush)(struct device *dev);
> >  };
> >  
> >  struct device;
> > @@ -201,7 +202,9 @@ unsigned long nd_blk_memremap_flags(struct
> > nd_blk_region *ndbr);
> >  unsigned int nd_region_acquire_lane(struct nd_region *nd_region);
> >  void nd_region_release_lane(struct nd_region *nd_region, unsigned int
> >  lane);
> >  u64 nd_fletcher64(void *addr, size_t len, bool le);
> > -void nvdimm_flush(struct nd_region *nd_region);
> > +int nvdimm_flush(struct nd_region *nd_region);
> > +void pmem_set_flush(struct nd_region *nd_region, void (*flush)
> > +					(struct device *));
> 
> It seems pmem_set_flush() doesn't exist.

Sorry! will remove it.
> 
> >  int nvdimm_has_flush(struct nd_region *nd_region);
> >  int nvdimm_has_cache(struct nd_region *nd_region);
> >  
> 
> 

Thanks,
Pankaj
