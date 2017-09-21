Received: from eggs.gnu.org ([2001:4830:134:3::10]:47494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1dux7N-0003wB-MS
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 04:45:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1dux7K-0005CP-Iu
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 04:45:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43302
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1dux7K-00059X-CK
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 04:45:54 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8L8hvuF139042
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 04:45:52 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2d48cgng73-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 04:45:52 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Thu, 21 Sep 2017 02:45:51 -0600
Date: Thu, 21 Sep 2017 16:45:47 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20170905111645.18068-1-pasic@linux.vnet.ibm.com>
	<20170905111645.18068-6-pasic@linux.vnet.ibm.com>
	<20170906151821.1a77afe5.cohuck@redhat.com>
	<20170907073108.GD31680@bjsdjshi@linux.vnet.ibm.com>
	<20170907100817.08ddae29.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170907100817.08ddae29.cohuck@redhat.com>
Message-Id: <20170921084547.GN11080@bjsdjshi@linux.vnet.ibm.com>
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
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org

* Cornelia Huck <cohuck@redhat.com> [2017-09-07 10:08:17 +0200]:

[...]

> > I'm thinking of a method these days:
> > Could passing through an fully emulated ccw device (e.g. 3270), or a
> > virtio ccw device, in the level 1 kvm guest to a level 2 guest be a test
> > method for this?
> > 
> > All of the CCWs will be translated to IDAL CCWs by vfio-ccw in the level
> > 1 guest (which is the level 2 kvm host) and issued to the level 1 kvm
> > host. So, those IDALs will eventually be handled by the emulated device,
> > or the virtio ccw device, on the level 1 kvm host...
> > 
> > Some days ago, one of my colleague tried the emulated 3270 passing
> > through. She stucked with the problem that the level 1 kvm host handling
> > a senseid IDAL ccw as a Direct ccw.
> > 
> > Maybe I could try to pass through a virtio ccw device. I don't think of
> > any obvious problem that would lead to fail. Any comment?
> > 
> 
> That actually looks like a good thing to try! Cool idea.
> 

Tried to test with the following method:
1. Start g1 (first level guest on kvm a host) with a virtio blk device
   defined:
-drive file=/dev/disk/by-path/ccw-0.0.3f3e,if=none,id=drive-virtio-disk1,format=raw \
-device virtio-blk-ccw,devno=fe.0.2222,scsi=off,drive=drive-virtio-disk1,id=virtio-disk1 \
2. Login g1, and bind the subchannel of ccw device 0.0.2222 with
   vfio-ccw drvier.
3. Create a mdev on the above subchannel.
4. Passthrough the mdev to g2, and try to start g2.

The 4th step failed with the following message and hang:
qemu-system-s390x: vfio-ccw: wirte I/O region: errno=4
(BTW, 4 is EINTR.)

I roughly guess this might be caused by:
On the kvm host, virtio callback injects the I/O interrupt in a
synchronzing manner. And this causes g1's I/O interrupt handler getting
the interrupt and then signaling the Qemu instance on g1 with the I/O
result, even before return of the pwrite().

But, using gdb on the kvm host, I do see several ssch successfully
executed. I will dig the root reason, and see if there is some way to
fix the issue.

-- 
Dong Jia Shi
