Received: from eggs.gnu.org ([2001:4830:134:3::10]:43957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1cg7bw-0000Fp-Mv
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 05:23:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1cg7bs-0004y9-MI
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 05:23:56 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33504)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1cg7bs-0004xl-Cd
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 05:23:52 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1LANWwc012714
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 05:23:50 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28rekcc4f2-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 05:23:49 -0500
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 21 Feb 2017 03:23:48 -0700
References: <20170220141943.8426-1-cornelia.huck@de.ibm.com>
	<20170220141943.8426-2-cornelia.huck@de.ibm.com>
	<967f7397-9995-0d24-bf35-682da2c732ff@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 21 Feb 2017 11:23:44 +0100
MIME-Version: 1.0
In-Reply-To: <967f7397-9995-0d24-bf35-682da2c732ff@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Message-Id: <48b23a4f-ebd3-2306-ea0f-75b713817440@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/5] elf-loader: Allow late loading of elf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Cornelia Huck <cornelia.huck@de.ibm.com>, Farhan Ali <alifm@linux.vnet.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>

On 02/20/2017 04:33 PM, Thomas Huth wrote:
> On 20.02.2017 15:19, Cornelia Huck wrote:
>> From: Farhan Ali <alifm@linux.vnet.ibm.com>
>>
>> The current QEMU ROM infrastructure rejects late loading of ROMs.
>> And ELFs are currently loaded as ROM, this prevents delayed loading
>> of ELFs. So when loading ELF, allow the user to specify if ELF should
>> be loaded as ROM or not.
>>
>> If an ELF is not loaded as ROM, then they are not restored on a
>> guest reboot/reset and so its upto the user to handle the reloading.
> 
> Could you maybe also explain here why you need such a delayed ELF
> loading? Why can't you load the s390-netboot.img at the same time as
> s390-ccw.img?

Please read the cover letter for some details how to build such a netrom.
This is a simple variant to implement a standard compliant network boot 
today but using a kernel+busybox+scripts.
Long term we certainly want to have a look at implementing something in
the ccw bios, but this (tcp stack, virtio net, etc) will take some (a lot?)
more time. Having a ramdisk+kernel loaded  all the time would be extremely
wasteful.

This patch (1) has another advantage.
Right now we load the ccw bios all the time, even for -kernel xxx boot,
to allow the guest user to use chreipl to reboot from a disk. With this
in place we can rework our ccw bios loader to load the ccw bios lazily
as well.

Christian
