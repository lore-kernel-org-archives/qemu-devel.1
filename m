Received: from eggs.gnu.org ([2001:4830:134:3::10]:60387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1dXITN-0001Q4-KL
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 22:42:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1dXITJ-0003fK-La
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 22:42:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50824)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1dXITJ-0003eE-Bp
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 22:42:49 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6I2gl9F143455
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 22:42:47 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2brr0gmr8x-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 22:42:47 -0400
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Mon, 17 Jul 2017 22:42:46 -0400
Date: Tue, 18 Jul 2017 10:42:41 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20170718014926.44781-1-bjsdjshi@linux.vnet.ibm.com>
	<20170718014926.44781-3-bjsdjshi@linux.vnet.ibm.com>
	<20170717202653.46b12372@w520.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170717202653.46b12372@w520.home>
Message-Id: <20170718024241.GB15985@bjsdjshi@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] vfio/ccw: fix initialization of the
 Object DeviceState pointer in the common base-device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, cohuck@redhat.com, borntraeger@de.ibm.com

* Alex Williamson <alex.williamson@redhat.com> [2017-07-17 20:26:53 -0600]:

> On Tue, 18 Jul 2017 03:49:26 +0200
> Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:
> 
> > Commit 7da624e2 ("vfio: Test realized when using VFIOGroup.device_list
> > iterator") introduced a pointer to the Object DeviceState in the VFIO
> > common base-device and skiped non-realized devices as we iterate
> > VFIOGroup.device_list. While it missed to initialize the pointer for
> > the vfio-ccw case. Let's fix it.
> > 
> > Fixes: 7da624e2 ("vfio: Test realized when using VFIOGroup.device_list
> >                   iterator")
> 
> Sorry for that.
No problem.

> 
> Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Thanks! :D

> 
> > Cc: Alex Williamson <alex.williamson@redhat.com>
> > Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> > Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> > ---
> >  hw/vfio/ccw.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> > index 8d97b53e77..a8baadf57a 100644
> > --- a/hw/vfio/ccw.c
> > +++ b/hw/vfio/ccw.c
> > @@ -338,6 +338,7 @@ static void vfio_ccw_realize(DeviceState *dev, Error **errp)
> >      vcdev->vdev.type = VFIO_DEVICE_TYPE_CCW;
> >      vcdev->vdev.name = g_strdup_printf("%x.%x.%04x", cdev->hostid.cssid,
> >                                         cdev->hostid.ssid, cdev->hostid.devid);
> > +    vcdev->vdev.dev = dev;
> >      QLIST_FOREACH(vbasedev, &group->device_list, next) {
> >          if (strcmp(vbasedev->name, vcdev->vdev.name) == 0) {
> >              error_setg(&err, "vfio: subchannel %s has already been attached",
> 

-- 
Dong Jia Shi
