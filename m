Received: from eggs.gnu.org ([2001:4830:134:3::10]:53653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1cTfzr-0003be-F1
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 21:29:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1cTfzo-00049V-2I
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 21:29:11 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40865)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1cTfzn-00048c-Fh
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 21:29:07 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0I2Spv1049602
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 21:29:05 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 281svdbpxx-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 21:29:05 -0500
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Tue, 17 Jan 2017 19:29:04 -0700
Date: Wed, 18 Jan 2017 10:28:58 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20170112071947.98071-1-bjsdjshi@linux.vnet.ibm.com>
	<20170112071947.98071-7-bjsdjshi@linux.vnet.ibm.com>
	<20170117140233.4e169979@t450s.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170117140233.4e169979@t450s.home>
Message-Id: <20170118022858.GL30301@bjsdjshi@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH RFC v2 06/15] vfio: ccw: register vfio_ccw
 to the mediated device framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org, renxiaof@linux.vnet.ibm.com, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, pmorel@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, wkywang@linux.vnet.ibm.com

* Alex Williamson <alex.williamson@redhat.com> [2017-01-17 14:02:33 -0700]:

[...]

> > diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
[...]

> > +static int vfio_ccw_mdev_create(struct kobject *kobj, struct mdev_device *mdev)
> > +{
> > +	struct vfio_ccw_private *private = dev_get_drvdata(mdev->parent->dev);
> > +
> > +	/* Only support one mediated device for each physical subchannel. */
> > +	if (private->mdev)
> > +		return -EPERM;
> > +
> > +	private->mdev = mdev;
> > +	available_instances--;
> 
> 
> This looks racy and doesn't enforce the available instances.  Should
> this maybe be an atomic_t and use atomic_dec_if_positive() to return an
> error if no instances are available?
Hi Alex,

You are right. I will fix this according to your comment.

> 
> 
> > +
> > +	return 0;
> > +}
> > +

[...]

-- 
Dong Jia
