Received: from eggs.gnu.org ([2001:4830:134:3::10]:50482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eJir4-0007VU-3h
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 11:35:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eJiqy-0002sz-6f
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 11:35:30 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47974
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1eJiqx-0002sV-UB
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 11:35:24 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vASGXnKh130810
	for <qemu-devel@nongnu.org>; Tue, 28 Nov 2017 11:35:19 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ehb4qs4jn-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 28 Nov 2017 11:35:18 -0500
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Tue, 28 Nov 2017 11:35:18 -0500
References: <1511816136-30068-1-git-send-email-walling@linux.vnet.ibm.com>
	<20171128113546.7f3f2b38.cohuck@redhat.com>
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Date: Tue, 28 Nov 2017 11:35:16 -0500
MIME-Version: 1.0
In-Reply-To: <20171128113546.7f3f2b38.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <e88bef2f-ac0d-5a75-fe92-14ce821bc101@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v1 0/5] (FIXED) Interactive
 Boot Menu for DASD and SCSI Guests on s390x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, frankja@linux.vnet.ibm.com

On 11/28/2017 05:35 AM, Cornelia Huck wrote:
> On Mon, 27 Nov 2017 15:55:31 -0500
> "Collin L. Walling" <walling@linux.vnet.ibm.com> wrote:
>
>> These patches implement a boot menu for ECKD DASD and SCSI guests on s390x.
>> The menu will only appear if the disk has been configured for IPL with the
>> zIPL tool and with the following QEMU command line options:
>>
>>      -boot menu=on[,splash-time=X] and/or -machine loadparm='prompt'
>>
>> or via the following libvirt domain xml:
>>
>>      <os>
>>        <bootmenu enable='yes' timeout='X'/>
>>      </os>
>>
>>      or
>> 	
>>      <disk>
>>        ...
>>        <boot order='1' loadparm='PROMPT'/>
>>      </disk>
>>
>> Where X is some positive integer representing time in milliseconds.
>>
>> Loadparm will override all boot options.
> I have a bit of trouble parsing that last sentence: Do you mean a
> loadparm other than 'prompt' will disable the menu and just boot the
> specified entry, without any delay? (That's what would make most sense
> to me.)

Correct. If loadparm is given boot index, we simply boot that entry.
I like "a loadparm other than 'prompt' will disable the menu and just
boot the specified entry"... I hope you don't mind if I steal it ;)

>
>> Collin L. Walling (5):
>>    s390-ccw: update libc.h
>>    s390-ccw: ipl structs for eckd cdl/ldl
>>    s390-ccw: parse and set boot menu options
>>    s390-ccw: interactive boot menu for eckd dasd
>>    s390-ccw: interactive boot menu for scsi
>>
>>   hw/s390x/ipl.c              |  23 +++++++
>>   hw/s390x/ipl.h              |   8 ++-
>>   pc-bios/s390-ccw/Makefile   |   2 +-
>>   pc-bios/s390-ccw/bootmap.c  | 110 ++++++++++++++++++++++++++++------
>>   pc-bios/s390-ccw/bootmap.h  |  73 +++++++++++++----------
>>   pc-bios/s390-ccw/iplb.h     |   8 ++-
>>   pc-bios/s390-ccw/libc.h     |  94 +++++++++++++++++++++++++++++
>>   pc-bios/s390-ccw/main.c     |  35 +++++------
>>   pc-bios/s390-ccw/menu.c     | 122 +++++++++++++++++++++++++++++++++++++
>>   pc-bios/s390-ccw/s390-ccw.h |   7 +++
>>   pc-bios/s390-ccw/sclp.c     | 142 +++++++++++++++++++++++++++++++++++++++++---
>>   11 files changed, 546 insertions(+), 78 deletions(-)
>>   create mode 100644 pc-bios/s390-ccw/menu.c
>>
>

-- 
- Collin L Walling
