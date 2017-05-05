Received: from eggs.gnu.org ([2001:4830:134:3::10]:58026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farman@linux.vnet.ibm.com>) id 1d6elg-0001RF-HS
	for qemu-devel@nongnu.org; Fri, 05 May 2017 11:03:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farman@linux.vnet.ibm.com>) id 1d6elc-0001Su-Ez
	for qemu-devel@nongnu.org; Fri, 05 May 2017 11:03:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55383
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farman@linux.vnet.ibm.com>)
	id 1d6elc-0001RI-9E
	for qemu-devel@nongnu.org; Fri, 05 May 2017 11:03:36 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v45ExPkB055927
	for <qemu-devel@nongnu.org>; Fri, 5 May 2017 11:03:33 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a8q5re3bb-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 05 May 2017 11:03:33 -0400
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farman@linux.vnet.ibm.com>;
	Fri, 5 May 2017 09:03:32 -0600
References: <20170426144645.12476-1-farman@linux.vnet.ibm.com>
	<20170505074143.GB21435@lemon.lan>
From: Eric Farman <farman@linux.vnet.ibm.com>
Date: Fri, 5 May 2017 11:03:25 -0400
MIME-Version: 1.0
In-Reply-To: <20170505074143.GB21435@lemon.lan>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <298bd169-6f9f-e622-1b8b-85ef126d8d0c@linux.vnet.ibm.com>
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
To: Fam Zheng <famz@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>



On 05/05/2017 03:41 AM, Fam Zheng wrote:
> On Wed, 04/26 16:46, Eric Farman wrote:
>> The short version of what happens is the host device driver rejects our
>> requests because the transfer lengths are too long for it to satisfy.
>> A virtio-scsi disk connected via scsi-generic is fine as a non-boot device
>> because the guest kernel is able to break up the requests for us.  So we just
>> need to handle this situation for the boot process.
>>
>> Patches 2-N in this series do that, but rely on us to specify the max_sectors
>> parameter for the virtio-scsi-ccw device:
>>
>>   /usr/bin/qemu-system-s390x ...
>>     -device virtio-scsi-ccw,id=scsi0,devno=fe.0.0001,max_sectors=2048
>
> Can you instead do an INQUIRY from the bios code to check the Block Limits page?
> The response is intercepted by hw/scsi/scsi-generic.c to merge in the host LUN's
> limits. That's how Linux kernel finds the granularity for request splitting.

It's a good idea (Thanks Christian, Paolo, and Fam :), but this leads to 
other difficulties.

We get a value of x3fffff when sending that to a scsi-disk from bios 
code.  That's fully emulated though, in scsi_disk_emulate_inquiry.  And 
that's the scenario that already works.

While there is indeed code in hw/scsi/scsi-generic.c to wire that in, 
that only happens after the I/O goes to the device itself.  The Block 
Limits page isn't supported [1] and thus it gets rejected with "invalid 
field in cdb".  We never get to that fixup code you reference, since the 
returned len is zero.

Should I be refactoring this code to always patch in that block limit 
regardless of a response from the host/device?  (That is, when page xb0 
isn't supported by the hw.)

  - Eric

[1] If I issue an EVPD page x00 from the QEMU bios code, I only see 
pages xb1, xc0, and c1 are supported.  If I look at the supported pages 
from the host, I see a few more but still not xb0:

$ sg_inq --page=0 /dev/sda
VPD INQUIRY: Supported VPD pages page
    Supported VPD pages:
      0x0	Supported VPD pages
      0x80	Unit serial number
      0x83	Device identification
      0x86	Extended INQUIRY data
      0xb1	Block device characteristics (sbc3)
      0xc0	vendor: Firmware numbers (seagate); Unit path report (EMC)
      0xc1	vendor: Date code (seagate)
$ sg_inq --page=0 /dev/sg0
VPD INQUIRY: Supported VPD pages page
    Supported VPD pages:
      0x0	Supported VPD pages
      0x80	Unit serial number
      0x83	Device identification
      0x86	Extended INQUIRY data
      0xb1	Block device characteristics (sbc3)
      0xc0	vendor: Firmware numbers (seagate); Unit path report (EMC)
      0xc1	vendor: Date code (seagate)


>
> That way, patch 1 is not necessary too. I don't like it because it doesn't
> always work considering LUN hotplug.
>
> Fam
>
