Received: from eggs.gnu.org ([2001:4830:134:3::10]:56037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1dsO9X-0001T4-7S
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 03:01:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1dsO9U-0001NK-5r
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 03:01:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51832
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1dsO9T-0001Mg-Vo
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 03:01:32 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8E6xDxq105855
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 03:01:30 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cyfh4ngnq-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 03:01:30 -0400
Received: from localhost
	by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Thu, 14 Sep 2017 17:01:26 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v8E71Oe042860572
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 17:01:24 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v8E71Ql0025274
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 17:01:26 +1000
Date: Thu, 14 Sep 2017 12:31:18 +0530
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Reply-To: bharata@linux.vnet.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Message-Id: <20170914070118.GA8181@in.ibm.com>
Subject: [Qemu-devel] QEMU terminates during reboot after memory unplug with
 vhost=on
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: david@gibson.dropbear.id.au, groug@kaod.org, mst@redhat.com

Hi,

QEMU hits the below assert

qemu-system-ppc64: used ring relocated for ring 2
qemu-system-ppc64: qemu/hw/virtio/vhost.c:649: vhost_commit: Assertion `r >= 0' failed.

in the following scenario:

1. Boot guest with vhost=on
  -netdev tap,id=mynet0,script=qemu-ifup,downscript=qemu-ifdown,vhost=on -device virtio-net-pci,netdev=mynet0
2. Hot add a DIMM device 
3. Reboot
   When the guest reboots, we can see
   vhost_virtqueue_start:vq->used_phys getting assigned an address that
   falls in the hotplugged memory range.
4. Remove the DIMM device
   Guest refuses the removal as the hotplugged memory is under use.
5. Reboot
   QEMU forces the removal of the DIMM device during reset and that's
   when we hit the above assert.

Any pointers on why we are hitting this assert ? Shouldn't vhost be
done with using the hotplugged memory when we hit reset ?

Regards,
Bharata.
