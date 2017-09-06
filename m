Received: from eggs.gnu.org ([2001:4830:134:3::10]:51003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1dpVpm-0002fB-BW
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 04:37:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1dpVpj-0007M7-3g
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 04:37:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53166
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1dpVpi-0007Ly-UC
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 04:37:15 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v868Tl38119836
	for <qemu-devel@nongnu.org>; Wed, 6 Sep 2017 04:37:14 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ctd7ch95k-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Sep 2017 04:37:14 -0400
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Wed, 6 Sep 2017 04:37:13 -0400
Date: Wed, 6 Sep 2017 16:37:08 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20170830163609.50260-1-pasic@linux.vnet.ibm.com>
	<20170830163609.50260-3-pasic@linux.vnet.ibm.com>
	<20170831111953.242ddc28.cohuck@redhat.com>
	<e805e756-495d-3125-eaf0-262635b9c545@linux.vnet.ibm.com>
	<20170905100234.7a92128e.cohuck@redhat.com>
	<bff0fcd2-4c1d-b5da-2d11-dc479d9d7275@linux.vnet.ibm.com>
	<20170905174606.1e0c6404.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170905174606.1e0c6404.cohuck@redhat.com>
Message-Id: <20170906083708.GA31680@bjsdjshi@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 2/9] s390x: fix invalid use of cc 1 for SSCH
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Halil Pasic <pasic@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org

* Cornelia Huck <cohuck@redhat.com> [2017-09-05 17:46:06 +0200]:

> On Tue, 5 Sep 2017 17:24:19 +0200
> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> 
> > My problem with a program check (indicated by SCSW word 2 bit 10) is
> > that, in my reading of the architecture, the semantic behind it is: The
> > channel subsystem (not the cu or device) has detected, that the 
> > the channel program (previously submitted as an ORB) is erroneous. Which
> > programs are erroneous is specified by the architecture. What we have
> > here does not qualify.
> > 
> > My idea was to rather blame the virtual hardware (device) and put no blame
> > on the program nor he channel subsystem. This could be done using device
> > status (unit check with command reject, maybe unit exception) or interface
> > check. My train of thought was, the problem is not consistent across a
> > device type, so it has to be device specific.
> 
> Unit exception might be a better way to express what is happening here.
> At least, it moves us away from cc 1 and not towards cc 3 :)
> 
> > 
> > Of course blaming the device could mislead the person encountering the
> > problem, and make him believe it's an non-virtual hardware problem.
> > 
> > About the misleading, I think the best we can do is log out a message
> > indicating what really happened.
> 
> Just document it in the code? If it doesn't happen with Linux as a
> guest, it is highly unlikely to be seen in the wild.
> 
> > 
> > In the end I don't care that deeply about vfio-ccw, and this problem
> > already took me more time than I intended to spend on this. We have
> > people driving this whole vfio-ccw stuff and I'm not one of them (I'm
> > rather in the supporting role).
> > 
> > I'm also fine with me being credited with a reported-by once the
> > more involved people figure out what to do, and keeping the vfio-ccw
> > stuff as is. Should we go with that option? 
> 
> If converting the reporting to a device status is straightforward
> enough, let's do that. I'm fine with postponing this and waiting for a
> real fix as well (I don't really have spare cycles to actually write
> vfio-ccw code currently...)
> 

I can do this after this series.

[...]

-- 
Dong Jia Shi
