Received: from eggs.gnu.org ([2001:4830:134:3::10]:38758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1eJ92j-0003bh-Gd
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 21:21:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1eJ92h-0001hW-5a
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 21:21:09 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40870)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1eJ92g-0001hA-SQ
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 21:21:07 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAR2JaCv030518
	for <qemu-devel@nongnu.org>; Sun, 26 Nov 2017 21:21:03 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2efpxbexya-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sun, 26 Nov 2017 21:21:03 -0500
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Sun, 26 Nov 2017 21:21:02 -0500
Date: Mon, 27 Nov 2017 10:20:56 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <594e1952-7097-0927-d913-d3b915df2305@linux.vnet.ibm.com>
	<20171122172522.281cfb4b.cohuck@redhat.com>
	<76f95c6f-641e-2fe0-73b4-3ab24fc1a93f@linux.vnet.ibm.com>
	<20171124134650.46665791.cohuck@redhat.com>
	<7eaa796e-7815-f943-58b5-ecb5a0bb252e@de.ibm.com>
	<20171124142758.39d7726f.cohuck@redhat.com>
	<131b311b-c262-3636-c7ee-1c59ee283823@de.ibm.com>
	<1ddb44db-2c5c-d64f-56e0-e4582f82b572@linux.vnet.ibm.com>
	<20171124171510.2343ccdf.cohuck@redhat.com>
	<8c18df3e-92a0-f88f-6d24-e1df051c8138@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c18df3e-92a0-f88f-6d24-e1df051c8138@linux.vnet.ibm.com>
Message-Id: <20171127022056.GK5859@bjsdjshi@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH 1/1] s390x/css: unresrict cssids
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Shalini Chellathurai Saroja <shalini@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>

* Halil Pasic <pasic@linux.vnet.ibm.com> [2017-11-24 17:39:04 +0100]:

> 
> 
> On 11/24/2017 05:15 PM, Cornelia Huck wrote:
> >>> In theory this should work. 
> >>>
> >>> In reality it seems more complicated. A per-device property is easy and can be
> >>> inspected on the command line (e.g. -device virtio-blk-ccw,help), while a new 
> >>> machine property would require to change the qemu help output and qemu-options 
> >>> file (which makes it visible for all architectures).  
> >> And then we have the fun of describing, that this property is weird, and can
> >> not be set, and it's value does not matter.
> > Well, that's the case for both, no?
> 
> 
> I don't think we have to document _device_ properites in qemu-options.hx
> I don't see any documented neither for virtio-ccw nor for vfio-ccw. The
> machine properties, on the contrary, are documented in this file.
Is it sane and possible to reuse the existing s390-squash-mcss property
to achieve the goal?  I mean, when it is false (which is the default
value), can we treat it as "we are allowed to put devices everywhere"?
Then we'd have the way to use a property of the -M to tell libvirt that
devices can be everywhere?

However then we can not drop it completely I guess, since Libvirt will
depends on it. But we can ignore the operation of setting it's value to
true.

> > 
> > (Unless we simply make this a "default cssid" prop after all - then it
> > would be more than just a simple indication for libvirt...)
> > 
> 
> We are now talking about the "cssid-unrestricted" property. The default
> cssid is not something I would like to do any time soon.

-- 
Dong Jia Shi
