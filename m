Received: from eggs.gnu.org ([2001:4830:134:3::10]:45803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1eKFYE-0002Fc-FI
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 22:30:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1eKFYA-0006y2-1d
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 22:30:14 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58244)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1eKFY9-0006vV-Ob
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 22:30:09 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAU3TMId018930
	for <qemu-devel@nongnu.org>; Wed, 29 Nov 2017 22:30:05 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ej712egck-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 29 Nov 2017 22:30:05 -0500
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Wed, 29 Nov 2017 20:30:04 -0700
Date: Thu, 30 Nov 2017 11:29:58 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20171128130758.67556-1-pasic@linux.vnet.ibm.com>
	<20171129081735.GR5859@bjsdjshi@linux.vnet.ibm.com>
	<20171129124747.63c1359b.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171129124747.63c1359b.cohuck@redhat.com>
Message-Id: <20171130032958.GU5859@bjsdjshi@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH v2 1/1] s390x/css: unrestrict cssids
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Shalini Chellathurai Saroja <shalini@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org

* Cornelia Huck <cohuck@redhat.com> [2017-11-29 12:47:47 +0100]:

[...]

> > With this patch
> > ===============
> > 
> > ------------+---------------+-------------
> >             | squashing off | squashing on
> > ------------+---------------+-------------
> >     auto id |        F      |     F
> > ------------+---------------+-------------
> > explicit id |        S'     |     S
> > ------------+---------------+-------------
> > 
> > T5. squashing off + auto id
> >   qemu-system-s390x: Unknown savevm section or instance '/fe.0.0003/virtio-rng' 0
> >   qemu-system-s390x: load of migration failed: Invalid argument
> > [Fail due to busid mismatch.]
> > 
> > T6. squashing off + explicit given id
> >   qemu-system-s390x: vmstate: get_nullptr expected VMS_NULLPTR_MARKER
> >   qemu-system-s390x: Failed to load s390_css:css
> >   qemu-system-s390x: error while loading state for instance 0x0 of device 's390_css'
> >   qemu-system-s390x: load of migration failed: Invalid argument
> > [Setting vfio-ccw.devno=non-fe.x.xxxx. (same as T1)
> >  Fail due to css mismatch - there is no css 0 in the new vm.]
> > 
> >   Succeed.
> > [Setting vfio-ccw.devno=fe.x.xxxx.]
> 
> Don't you need to attach the vfio-ccw device later anyway? You have to
> detach it from the source before you migrate, and I'd expect it to be
> symmetric.
Yes. After migrate, there is no problem to device_add the vfio-ccw
device (id=vfio0,devno=fe.x.xxxx). The result (succeed for this case)
does not change.

> 
> > 
> > T7. squashing on  + auto id
> >   qemu-system-s390x: Unknown savevm section or instance '/00.0.0003/virtio-rng' 0
> >   qemu-system-s390x: load of migration failed: Invalid argument
> > [Fail due to busid mismatch.]
> > 
> > T8. squashing on  + explicit given id
> >   Succeed.
> > 
> > 
> > Notice:
> > The differences of the test results between w and w/o this patch are in
> > the "squashing off" cases. I think these are things that we can accept.
> 
> Yes, I think that makes sense. If you want reliable migration, you need
> to be specific with your ids. I'd just don't want us to break things
> explicitly.
> 
Fair enough. Got the message.

-- 
Dong Jia Shi
