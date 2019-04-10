Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6194C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 14:40:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 805222133D
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 14:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="zcbdSOGo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 805222133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60803 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEEP1-0008Fy-Iz
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 10:40:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1hEENw-0007dS-J2
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 10:39:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1hEENv-0006KP-7w
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 10:39:32 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:49236)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1hEENu-0006H6-RH
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 10:39:31 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
	by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x3AEcbdu111325; Wed, 10 Apr 2019 14:38:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=date : from : to : cc
	: subject : message-id : references : mime-version : content-type :
	in-reply-to; s=corp-2018-07-02;
	bh=8zY1P35x/rzR+C1mZrAQNK5FK6EfzLZNq2j3WW+HQq0=;
	b=zcbdSOGoaRvd42yr8N7Pe1s82+WI5xUHwMjo7QLsB5zPLkFlUV2yCJckNj8vqBxQa28q
	md1OCK7m2Ys3vDLJar0a/zvCizjTRB5JApyt1lZccd/xmtysqcVs1hn4xIJwKftMnmwo
	kMhS7/inTmVxoe8KSYvB564o8VTjliqUpa0+ARRIF7BL2XB4MuE/7EVk3Z6El0UZfR9n
	6yTEkR2xBxKs6+C6wdu7NaSiBE+jQuR6koWsPisbqvVxxxaYFQN/HVUTP82w9A8xcNvL
	GKPHpvqMTcWG0cvPB3nYeBaPLHEJZdMGwJcodCWQMLTT9q+6yChgKSD/ne33L9RZgRD4
	HA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
	by aserp2130.oracle.com with ESMTP id 2rphmeknu0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Apr 2019 14:38:52 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
	by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x3AEc8Oo074891; Wed, 10 Apr 2019 14:38:52 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
	by userp3020.oracle.com with ESMTP id 2rpkejxshf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Apr 2019 14:38:51 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
	by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x3AEcihO024464;
	Wed, 10 Apr 2019 14:38:44 GMT
Received: from lap1 (/77.138.183.59) by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Wed, 10 Apr 2019 07:38:43 -0700
Date: Wed, 10 Apr 2019 17:38:26 +0300
From: Yuval Shaia <yuval.shaia@oracle.com>
To: Cornelia Huck <cohuck@redhat.com>, pagupta@redhat.com
Message-ID: <20190410143826.GA7856@lap1>
References: <20190410040826.24371-1-pagupta@redhat.com>
	<20190410040826.24371-3-pagupta@redhat.com>
	<20190410142426.5bf0d9a4.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190410142426.5bf0d9a4.cohuck@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9222
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1810050000 definitions=main-1904100104
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9222
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
	definitions=main-1904100104
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 141.146.126.79
Subject: Re: [Qemu-devel] [PATCH v5 2/5] virtio-pmem: Add virtio pmem driver
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Pankaj Gupta <pagupta@redhat.com>, jack@suse.cz, kvm@vger.kernel.org,
	mst@redhat.com, jasowang@redhat.com, david@fromorbit.com,
	qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org,
	adilger.kernel@dilger.ca, zwisler@kernel.org,
	aarcange@redhat.com, dave.jiang@intel.com,
	linux-nvdimm@lists.01.org, vishal.l.verma@intel.com,
	david@redhat.com, willy@infradead.org, hch@infradead.org,
	linux-acpi@vger.kernel.org, jmoyer@redhat.com,
	linux-ext4@vger.kernel.org, lenb@kernel.org, kilobyte@angband.pl,
	riel@surriel.com, stefanha@redhat.com, pbonzini@redhat.com,
	dan.j.williams@intel.com, lcapitulino@redhat.com,
	kwolf@redhat.com, nilal@redhat.com, tytso@mit.edu,
	xiaoguangrong.eric@gmail.com, darrick.wong@oracle.com,
	rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190410143826.G8AZjFDJjgvTuJKp1UygA5uPV8AsTY0OHLSzd4NryW4@z>

On Wed, Apr 10, 2019 at 02:24:26PM +0200, Cornelia Huck wrote:
> On Wed, 10 Apr 2019 09:38:22 +0530
> Pankaj Gupta <pagupta@redhat.com> wrote:
> 
> > This patch adds virtio-pmem driver for KVM guest.
> > 
> > Guest reads the persistent memory range information from
> > Qemu over VIRTIO and registers it on nvdimm_bus. It also
> > creates a nd_region object with the persistent memory
> > range information so that existing 'nvdimm/pmem' driver
> > can reserve this into system memory map. This way
> > 'virtio-pmem' driver uses existing functionality of pmem
> > driver to register persistent memory compatible for DAX
> > capable filesystems.
> > 
> > This also provides function to perform guest flush over
> > VIRTIO from 'pmem' driver when userspace performs flush
> > on DAX memory range.
> > 
> > Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> > ---
> >  drivers/nvdimm/virtio_pmem.c     |  88 ++++++++++++++++++++++
> >  drivers/virtio/Kconfig           |  10 +++
> >  drivers/virtio/Makefile          |   1 +
> >  drivers/virtio/pmem.c            | 124 +++++++++++++++++++++++++++++++
> >  include/linux/virtio_pmem.h      |  60 +++++++++++++++
> >  include/uapi/linux/virtio_ids.h  |   1 +
> >  include/uapi/linux/virtio_pmem.h |  10 +++
> >  7 files changed, 294 insertions(+)
> >  create mode 100644 drivers/nvdimm/virtio_pmem.c
> >  create mode 100644 drivers/virtio/pmem.c
> >  create mode 100644 include/linux/virtio_pmem.h
> >  create mode 100644 include/uapi/linux/virtio_pmem.h
> > 
> (...)
> > diff --git a/drivers/virtio/pmem.c b/drivers/virtio/pmem.c
> > new file mode 100644
> > index 000000000000..cc9de9589d56
> > --- /dev/null
> > +++ b/drivers/virtio/pmem.c
> > @@ -0,0 +1,124 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * virtio_pmem.c: Virtio pmem Driver
> > + *
> > + * Discovers persistent memory range information
> > + * from host and registers the virtual pmem device
> > + * with libnvdimm core.
> > + */
> > +#include <linux/virtio_pmem.h>
> > +#include <../../drivers/nvdimm/nd.h>
> > +
> > +static struct virtio_device_id id_table[] = {
> > +	{ VIRTIO_ID_PMEM, VIRTIO_DEV_ANY_ID },
> > +	{ 0 },
> > +};
> > +
> > + /* Initialize virt queue */
> > +static int init_vq(struct virtio_pmem *vpmem)
> 
> IMHO, you don't gain much by splitting off this function...

It make sense to have all the vq-init-related stuff in one function, so
here pmem_lock and req_list are used only for the vq.
Saying that - maybe it would be better to have the 3 in one struct.

> 
> > +{
> > +	struct virtqueue *vq;
> > +
> > +	/* single vq */
> > +	vpmem->req_vq = vq = virtio_find_single_vq(vpmem->vdev,
> > +				host_ack, "flush_queue");
> > +	if (IS_ERR(vq))
> > +		return PTR_ERR(vq);
> 
> I'm personally not a fan of chained assignments... I think I'd just
> drop the 'vq' variable and operate on vpmem->req_vq directly.

+1

> 
> > +
> > +	spin_lock_init(&vpmem->pmem_lock);
> > +	INIT_LIST_HEAD(&vpmem->req_list);
> > +
> > +	return 0;
> > +};
> > +
> > +static int virtio_pmem_probe(struct virtio_device *vdev)
> > +{
> > +	int err = 0;
> > +	struct resource res;
> > +	struct virtio_pmem *vpmem;
> > +	struct nvdimm_bus *nvdimm_bus;
> > +	struct nd_region_desc ndr_desc = {};
> > +	int nid = dev_to_node(&vdev->dev);
> > +	struct nd_region *nd_region;
> > +
> > +	if (!vdev->config->get) {
> > +		dev_err(&vdev->dev, "%s failure: config disabled\n",
> 
> Maybe s/config disabled/config access disabled/ ? That seems to be the
> more common message.
> 
> > +			__func__);
> > +		return -EINVAL;
> > +	}
> > +
> > +	vdev->priv = vpmem = devm_kzalloc(&vdev->dev, sizeof(*vpmem),
> > +					GFP_KERNEL);
> 
> Here, the vpmem variable makes sense for convenience, but I'm again not
> a fan of the chaining :)

+1

> 
> > +	if (!vpmem) {
> > +		err = -ENOMEM;
> > +		goto out_err;
> > +	}
> > +
> > +	vpmem->vdev = vdev;
> > +	err = init_vq(vpmem);
> > +	if (err)
> > +		goto out_err;
> > +
> > +	virtio_cread(vpmem->vdev, struct virtio_pmem_config,
> > +			start, &vpmem->start);
> > +	virtio_cread(vpmem->vdev, struct virtio_pmem_config,
> > +			size, &vpmem->size);
> > +
> > +	res.start = vpmem->start;
> > +	res.end   = vpmem->start + vpmem->size-1;
> > +	vpmem->nd_desc.provider_name = "virtio-pmem";
> > +	vpmem->nd_desc.module = THIS_MODULE;
> > +
> > +	vpmem->nvdimm_bus = nvdimm_bus = nvdimm_bus_register(&vdev->dev,
> > +						&vpmem->nd_desc);
> 
> And here :)
> 
> > +	if (!nvdimm_bus)
> > +		goto out_vq;
> > +
> > +	dev_set_drvdata(&vdev->dev, nvdimm_bus);
> > +
> > +	ndr_desc.res = &res;
> > +	ndr_desc.numa_node = nid;
> > +	ndr_desc.flush = virtio_pmem_flush;
> > +	set_bit(ND_REGION_PAGEMAP, &ndr_desc.flags);
> > +	set_bit(ND_REGION_ASYNC, &ndr_desc.flags);
> > +	nd_region = nvdimm_pmem_region_create(nvdimm_bus, &ndr_desc);
> > +	nd_region->provider_data =  dev_to_virtio
> > +					(nd_region->dev.parent->parent);
> 
> Isn't it clear that this parent chain will always end up at &vdev->dev?
> Maybe simply set ->provider_data to vdev directly? (Does it need to
> grab a reference count of the device, BTW?)
> 
> > +
> > +	if (!nd_region)
> > +		goto out_nd;
> 
> Probably better to do this check before you access nd_region's
> members :)
> 
> > +
> > +	return 0;
> > +out_nd:
> > +	err = -ENXIO;
> > +	nvdimm_bus_unregister(nvdimm_bus);
> > +out_vq:
> > +	vdev->config->del_vqs(vdev);
> > +out_err:
> > +	dev_err(&vdev->dev, "failed to register virtio pmem memory\n");
> > +	return err;
> > +}
> > +
> > +static void virtio_pmem_remove(struct virtio_device *vdev)
> > +{
> > +	struct virtio_pmem *vpmem = vdev->priv;
> > +	struct nvdimm_bus *nvdimm_bus = dev_get_drvdata(&vdev->dev);
> > +
> > +	nvdimm_bus_unregister(nvdimm_bus);
> 
> I haven't followed this around the nvdimm code, but is the nd_region
> you created during probe cleaned up automatically, or would you need to
> do something here?
> 
> > +	vdev->config->del_vqs(vdev);
> > +	vdev->config->reset(vdev);
> > +	kfree(vpmem);
> 
> You allocated vpmem via devm_kzalloc; isn't it freed automatically on
> remove?
> 
> > +}
> > +
> > +static struct virtio_driver virtio_pmem_driver = {
> > +	.driver.name		= KBUILD_MODNAME,
> > +	.driver.owner		= THIS_MODULE,
> > +	.id_table		= id_table,
> > +	.probe			= virtio_pmem_probe,
> > +	.remove			= virtio_pmem_remove,
> > +};
> > +
> > +module_virtio_driver(virtio_pmem_driver);
> > +MODULE_DEVICE_TABLE(virtio, id_table);
> > +MODULE_DESCRIPTION("Virtio pmem driver");
> > +MODULE_LICENSE("GPL");
> 
> Only looked at this from the general virtio driver angle; seems fine
> apart from some easy-to-fix issues and some personal style preference
> things.

