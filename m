Received: from eggs.gnu.org ([2001:4830:134:3::10]:40152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1dprHY-00045J-0Z
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 03:31:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1dprHT-0000pT-6h
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 03:31:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58774)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1dprHS-0000p2-U0
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 03:31:19 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v877Srlf087590
	for <qemu-devel@nongnu.org>; Thu, 7 Sep 2017 03:31:15 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cu1ku8hcd-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 07 Sep 2017 03:31:14 -0400
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Thu, 7 Sep 2017 01:31:13 -0600
Date: Thu, 7 Sep 2017 15:31:09 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20170905111645.18068-1-pasic@linux.vnet.ibm.com>
	<20170905111645.18068-6-pasic@linux.vnet.ibm.com>
	<20170906151821.1a77afe5.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170906151821.1a77afe5.cohuck@redhat.com>
Message-Id: <20170907073108.GD31680@bjsdjshi@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 5/5] s390x/ccs: add ccw-tester emulated
 device
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

* Cornelia Huck <cohuck@redhat.com> [2017-09-06 15:18:21 +0200]:

> On Tue,  5 Sep 2017 13:16:45 +0200
> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> 
> > Add a fake device meant for testing the correctness of our css emulation.
> > 
> > What we currently have is writing a Fibonacci sequence of uint32_t to the
> > device via ccw write. The write is going to fail if it ain't a Fibonacci
> > and indicate a device exception in scsw together with the proper residual
> > count.
> > 
> > Of course lot's of invalid inputs (besides basic data processing) can be
> > tested with that as well.
> > 
> > Usage:
> > 1) fire up a qemu with something like -device ccw-tester,devno=fe.0.0001
> >    on the command line
> > 2) exercise the device from the guest
> > 
> > Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> > ---
> > 
> > It may not make sense to merge this work in the current form, as it is
> > solely for test purposes.
> > ---
> >  hw/s390x/Makefile.objs |   1 +
> >  hw/s390x/ccw-tester.c  | 179 +++++++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 180 insertions(+)
> >  create mode 100644 hw/s390x/ccw-tester.c
> 
> The main problem here is that you want to exercise a middle layer (the
> css code) and need to write boilerplate code on both host and guest
> side in order to be able to do so.
> 
> In general, a device that accepts arbitrary channel programs looks
> useful for testing purposes. I would split out processing of expected
> responses out, though, so that it can be more easily reused for
> different use cases.
> 
> (I dimly recall other test devices...)
> 
> For the guest tester: Can that be done via the qtest infrastructure
> somehow?
> 

I'm thinking of a method these days:
Could passing through an fully emulated ccw device (e.g. 3270), or a
virtio ccw device, in the level 1 kvm guest to a level 2 guest be a test
method for this?

All of the CCWs will be translated to IDAL CCWs by vfio-ccw in the level
1 guest (which is the level 2 kvm host) and issued to the level 1 kvm
host. So, those IDALs will eventually be handled by the emulated device,
or the virtio ccw device, on the level 1 kvm host...

Some days ago, one of my colleague tried the emulated 3270 passing
through. She stucked with the problem that the level 1 kvm host handling
a senseid IDAL ccw as a Direct ccw.

Maybe I could try to pass through a virtio ccw device. I don't think of
any obvious problem that would lead to fail. Any comment?

-- 
Dong Jia Shi
