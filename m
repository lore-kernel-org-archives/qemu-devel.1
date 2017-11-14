Received: from eggs.gnu.org ([2001:4830:134:3::10]:45496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1eEWXl-0008UA-P5
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 03:26:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1eEWXi-0005D3-GZ
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 03:26:05 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40560)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1eEWXi-0005Bt-7S
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 03:26:02 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAE8OLrK068305
	for <qemu-devel@nongnu.org>; Tue, 14 Nov 2017 03:25:54 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2e7uptur36-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 14 Nov 2017 03:25:53 -0500
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Tue, 14 Nov 2017 03:25:52 -0500
Date: Tue, 14 Nov 2017 16:25:47 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Message-Id: <20171114082547.GB12696@bjsdjshi@linux.vnet.ibm.com>
Subject: [Qemu-devel] Questions about usability mess that caused by
 differentiating address based on devices types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, bjsdjshi@linux.vnet.ibm.com, fiuczy@linux.vnet.ibm.com, bwalk@linux.vnet.ibm.com, shalini@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, borntraeger@de.ibm.com

Dear Conny,

Good day!

Just now, our Libvirt folks pointed out a "usability mess" for the
design of differentiating address based on devices classes (real |
virtual). The complaints are mainly about the "s390-squash-mcss"
property and restrictions to define virtual device in the special 0xFE
css, and define real devices in non-0xFE.

We have some discussions internally, but failed to get it cleared. As we
think this is about the architecture, so hereby, I as a representative,
forward our arguments and questions here to ask you for help:

1. What benifit do we get to put virtual devices in css 0xFE?

2. Since we could accept squashing virtual devices into css 0, can we
accept to not trading 0xFE as a special css?
So that we can remove the restrictions for the cssid validation for each
type of device. Even we could drop the s390-squash-mcss, and just allow
the user to define any device in any css.

3. If we have to keep the squash property, then when squashing, it's
somewhat like "I don't care for the cssid", so is it possible for us to
not check the cssid in the device devno?
Libvirt would be benifited with this when automatically generating the
addresses.

4. Error message for devno conflict is not helpful. For the following
case:
  -M s390-ccw-virtio,s390-squash-mcss=on \
  -drive file=/dev/disk/by-path/ccw-0.0.3f3e,if=none,id=drive-virtio-disk1,format=raw \
  -device virtio-blk-ccw,devno=fe.0.2222,scsi=off,drive=drive-virtio-disk1,id=virtio-disk1,bootindex=0 \
  -device vfio-ccw,devno=0.0.2222,sysfsdev=/sys/devices/css0/0.0.013f/6dfd3ec5-e8b3-4e18-a6fe-57bc9eceb920 \

We get this error message:
qemu-system-s390x: -device vfio-ccw,devno=0.0.2222,sysfsdev=/sys/devices/css0/0.0.013f/6dfd3ec5-e8b3-4e18-a6fe-57bc9eceb920: Device 0.0.2222 already exists

By checking 0.0.2222 from the cmd line, users can not find out the root
cause - squashing, easily. So, if we have to keep the squash property,
we could improve this message by adding a hint.

To sum up, we got the feeling that, this mess is not only for Libvirt
but also for QEMU cmd line users. And we are wondering if there is some
way to improve it.

Thanks,

-- 
Dong Jia Shi
