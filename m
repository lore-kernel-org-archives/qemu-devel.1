Received: from eggs.gnu.org ([2001:4830:134:3::10]:57056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frankja@linux.vnet.ibm.com>) id 1ceNP7-0000GP-Cm
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:51:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frankja@linux.vnet.ibm.com>) id 1ceNP3-0007gS-4a
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:51:29 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49256
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frankja@linux.vnet.ibm.com>)
	id 1ceNP2-0007g9-WD
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:51:25 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1GEnFhG086392
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 09:51:22 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28n9sx3sjt-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 09:51:22 -0500
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <frankja@linux.vnet.ibm.com>;
	Thu, 16 Feb 2017 14:51:20 -0000
From: Janosch Frank <frankja@linux.vnet.ibm.com>
Date: Thu, 16 Feb 2017 15:51:17 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Message-Id: <0f8f3bd3-04d2-7213-2afb-ea75507eced6@linux.vnet.ibm.com>
Subject: [Qemu-devel] Error handling for KVM_GET_DIRTY_LOG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>

While trying to fix a bug in the s390 migration code, I noticed that
QEMU ignores practically all errors returned from that VM ioctl. QEMU
behaves as specified in the KVM api and only processes -1 (-EPERM) as an
error.

Unfortunately the documentation is wrong/old and KVM may return -EFAULT,
-EINVAL, -ENOTSUPP (BookE) and -ENOENT. This bugs me, as I found a case
where I want to return -EFAULT because of guest memory problems and QEMU
will still happily migrate the VM.

I currently don't see a reason why we continue to migrate on EFAULT and
EINVAL. But returning -error from kvm_physical_sync_dirty_bitmap might
also a bit hard, as it kills QEMU.

Do we want to fix this and if, how do we want it done?
If not we at least have a definitive mail to point to when the next one
comes around. I also have a KVM patch to update the api documentation if
wanted (maybe we should dust that off a bit anyhow).


This has been brought up in 2009 [1] the first time and was more or less
fixed and then reverted in 2014 [2].

The reason in [1] was that PPC hadn't settled yet on a valid return code.

In [2] it was too close to the v2 to handle it properly.


[1] https://lists.nongnu.org/archive/html/qemu-devel/2009-07/msg01772.html

[2] https://lists.nongnu.org/archive/html/qemu-devel/2014-04/msg01993.html


Cheers,
Janosch
