Received: from eggs.gnu.org ([2001:4830:134:3::10]:58291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fDn3M-0001jW-8C
	for qemu-devel@nongnu.org; Wed, 02 May 2018 04:23:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fDn3J-0002IT-6G
	for qemu-devel@nongnu.org; Wed, 02 May 2018 04:23:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48884)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1fDn3I-0002HY-TF
	for qemu-devel@nongnu.org; Wed, 02 May 2018 04:23:53 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w428NfiD133954
	for <qemu-devel@nongnu.org>; Wed, 2 May 2018 04:23:51 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2hq6n1fk3y-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 02 May 2018 04:23:51 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 2 May 2018 09:23:49 +0100
References: <1524734910-17970-1-git-send-email-thuth@redhat.com>
	<06fd547e-6a1b-6920-fb5e-acadea0b8fd0@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 2 May 2018 10:23:45 +0200
MIME-Version: 1.0
In-Reply-To: <06fd547e-6a1b-6920-fb5e-acadea0b8fd0@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <102a05ac-e888-3a6b-f788-d2b780e40445@de.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v4 0/3] pc-bios/s390-ccw: Some
 few network boot improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Cc: Collin Walling <walling@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>



On 04/27/2018 03:14 PM, David Hildenbrand wrote:
> On 26.04.2018 11:28, Thomas Huth wrote:
>> Note: I've decided to removed the pxelinux.cfg patches from this series
>> for now, since full pxelinux support requires to parse some additional
>> DHCP options (see https://tools.ietf.org/html/rfc5071), and for this, the
>> SLOF libnet code needs to be changed first. So I guess I first have to
>> implement pxelinux.cfg support for PPC, too, which will likely take a
>> little bit longer...
> 
> I don't think it would be wrong to include it for now. We just don't
> support all options yet - that can be fixed later. If the current state
> is what 99.9999% of all users will need, than include it. If it is a
> crucial feature, than I agree.

Agreed. 
Lets start with these 3 patches and then do a followup review of the "pxe light"
patch so that we can keep the discussion in there.

> 
>> Thus to keep this series short and reviewable, and to avoid that the other
>> patches bit-rot on my hard disk, I've now only included the patches that
>> are not related to pxelinux.cfg.
>>
>> The first patch is just a minor code refactoring which should not have
>> any visible impact, but makes the following patches easier.
>>
>> The second patch makes sure that we leave the machine in a sane state
>> before jumping into the Linux kernel - i.e. the netboot firmware now
>> resets the machine with diag308, too, just like the main s390-ccw
>> is doing it already.
>>
>> Patch 3 adds support for loading kernels via .INS configuration files.
>> You can find these .INS config files on ISO images, so with this patch,
>> it should be possible to boot if the TFTP server is configured to use
>> the contents of such an ISO image.
>>
>> v4:
>>  - s/uninit/release/ in the title of the first patch
>>  - Set schid of the network device in 184
>>  - Jump to 0x10000 start address if S390EP magic is available
>>
>> Thomas Huth (3):
>>   pc-bios/s390-ccw/net: Split up net_load() into init, load and release
>>     parts
>>   pc-bios/s390-ccw/net: Use diag308 to reset machine before jumping to
>>     the OS
>>   pc-bios/s390-ccw/net: Add support for .INS config files
>>
>>  pc-bios/s390-ccw/Makefile    |   4 +-
>>  pc-bios/s390-ccw/bootmap.c   |  63 +---------------
>>  pc-bios/s390-ccw/bootmap.h   |   4 --
>>  pc-bios/s390-ccw/jump2ipl.c  |  91 +++++++++++++++++++++++
>>  pc-bios/s390-ccw/netboot.mak |   3 +-
>>  pc-bios/s390-ccw/netmain.c   | 168 +++++++++++++++++++++++++++++++++++--------
>>  pc-bios/s390-ccw/s390-ccw.h  |   4 ++
>>  7 files changed, 240 insertions(+), 97 deletions(-)
>>  create mode 100644 pc-bios/s390-ccw/jump2ipl.c
>>
> 
> 
