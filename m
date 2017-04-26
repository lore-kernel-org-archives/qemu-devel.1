Received: from eggs.gnu.org ([2001:4830:134:3::10]:58369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farman@linux.vnet.ibm.com>) id 1d3PZr-00019O-5b
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 12:14:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farman@linux.vnet.ibm.com>) id 1d3PZn-0000yB-Tr
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 12:14:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48654)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farman@linux.vnet.ibm.com>)
	id 1d3PZn-0000x8-KP
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 12:13:59 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3QG91YV057252
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 12:13:58 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a2xckhnqj-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 12:13:57 -0400
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farman@linux.vnet.ibm.com>;
	Wed, 26 Apr 2017 10:13:56 -0600
References: <20170426144645.12476-1-farman@linux.vnet.ibm.com>
	<76868ba7-610d-ef56-bbd4-ed26f55164dd@de.ibm.com>
From: Eric Farman <farman@linux.vnet.ibm.com>
Date: Wed, 26 Apr 2017 12:13:51 -0400
MIME-Version: 1.0
In-Reply-To: <76868ba7-610d-ef56-bbd4-ed26f55164dd@de.ibm.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <caa4a6bc-c717-15dd-27fd-de47ddbe30d1@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH v1 0/5] Enable virtio-scsi boot from
 /dev/sgX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, "Michael S . Tsirkin" <mst@redhat.com>



On 04/26/2017 11:48 AM, Christian Borntraeger wrote:
> On 04/26/2017 04:46 PM, Eric Farman wrote:
>> Today, trying to boot a guest from a SCSI LUN on s390x yields the following:
>>
>>   virtio-blk               = OK
>>   virtio-scsi and /dev/sdX = OK
>>   virtio-scsi and /dev/sgX = FAIL
>>
>> Example of the failing scenario:
>>
>>   /usr/bin/qemu-system-s390x ...
>>     -device virtio-scsi-ccw,id=scsi0,devno=fe.0.0001
>>     -drive file=/dev/sg2,if=none,id=drive0,format=raw
>>     -device scsi-generic,bus=scsi0.0,channel=0,scsi-id=0,drive=drive0,id=disk0
>>   LOADPARM=[........]
>>   Using virtio-scsi.
>>   Using SCSI scheme.
>>   ..
>>   ! virtio-scsi:read_many: STATUS=02 RSPN=70 KEY=0b CODE=00 QLFR=06, sure !
>>
>> Why do we care?  Well, libvirt converts a virtio-scsi device from the host
>> SCSI address (host:bus:target:lun) into the associated /dev/sgX device,
>> which means we can't boot from virtio-scsi and have to rely on virtio-blk
>> for this action.
>>
>> The short version of what happens is the host device driver rejects our
>> requests because the transfer lengths are too long for it to satisfy.
>> A virtio-scsi disk connected via scsi-generic is fine as a non-boot device
>> because the guest kernel is able to break up the requests for us.  So we just
>> need to handle this situation for the boot process.
>
> Out of curiosity. Why is the guest kernel submitting "short enough" requests?
> If it querying the device itself via scsi commands before issuing commands?
>

Looking at some old traces I have, I think I misspoke that it's the 
guest kernel.  In the failing case, the host kernel is processing an 
ioctl system call via sg_ioctl, and just passing our I/O transaction to 
the block driver.  It blows up because the number of iovecs needed for 
the transaction exceeds UIO_MAXIOV.  In the working case (boot from 
virtio-scsi as /dev/sdX or virtio-blk), the host kernel goes through 
read system call, and the I/O is broken up by do_generic_file_read.
