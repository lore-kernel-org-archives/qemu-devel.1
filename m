Received: from eggs.gnu.org ([2001:4830:134:3::10]:35330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1dcS3L-00085a-F8
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 03:57:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1dcS3I-0005dT-C9
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 03:57:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33669)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1dcS3I-0005c8-2m
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 03:57:16 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v717rxew006979
	for <qemu-devel@nongnu.org>; Tue, 1 Aug 2017 03:57:14 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2c2nd1gsey-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 01 Aug 2017 03:57:13 -0400
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Tue, 1 Aug 2017 03:57:12 -0400
Date: Tue, 1 Aug 2017 15:57:06 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20170727015418.85407-1-bjsdjshi@linux.vnet.ibm.com>
	<20170727015418.85407-4-bjsdjshi@linux.vnet.ibm.com>
	<20170727135910.27d9e42e@gondolin>
	<20170731035137.GB21572@bjsdjshi@linux.vnet.ibm.com>
	<20170731131302.5bb2198c@gondolin>
	<20170801022910.GF12259@bjsdjshi@linux.vnet.ibm.com>
	<20170801092420.5217bd85@gondolin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170801092420.5217bd85@gondolin>
Message-Id: <20170801075706.GA9357@bjsdjshi@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] s390x/css: generate channel path
 initialized CRW for channel path hotplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, pasic@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, qemu-devel@nongnu.org, agraf@suse.de, borntraeger@de.ibm.com, rth@twiddle.net

* Cornelia Huck <cohuck@redhat.com> [2017-08-01 09:24:20 +0200]:

> On Tue, 1 Aug 2017 10:29:10 +0800
> Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:
> 
> > * Cornelia Huck <cohuck@redhat.com> [2017-07-31 13:13:02 +0200]:
> > 
> > > On Mon, 31 Jul 2017 11:51:37 +0800
> > > Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:
> 
> > > > When defining a vfio-ccw device, since the real subchannel implicitly
> > > > indicates the chps it bound to, we grasp the CHPIDs from sysfs (or, with
> > > > my current work, we could even retrieve these information from a new
> > > > added MMIO region). In this case, defining some channel path devices
> > > > separately does not make sense to me.  
> > > 
> > > We might want to pass only a subset of the channel paths to guest. This
> > > can only work if we can define individual chp objects.  
> > Why would we want this?
> 
> For example, if you know that a reconfiguration is coming on soon, you
> can just exclude the paths that will go away anyway and the guest will
> never know about them. Or for preferred pathing, although that one
> fortunately seems to have died out.
> 
> Not very strong reasons to spend time on this, though.
Got it.

> 
> > 
> > We can add, for example, a "chpids" parameter for the "vfio-ccw" device
> > to limit its chpids to a subset that we want it to have? E.g.:
> > 
> > For this mdev:
> > MDEV                                  Subchan.  PIM PAM POM  CHPIDs
> > ------------------------------------------------------------------------------
> > 6dfd3ec5-e8b3-4e18-a6fe-57bc9eceb920  0.0.013f  f0  f0  ff   42434445 00000000
> > 
> > We could use this command line:
> > -device vfio-ccw,sysfsdev=$MDEV_CCW013f,devno=0.0.1234,chpids=4245000000000000
> >                                                               ^^^^
> 
> Yes, that would work, should we want that. We can probably do without for now.
> 
Let's deffer this too!

-- 
Dong Jia Shi
