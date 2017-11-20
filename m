Received: from eggs.gnu.org ([2001:4830:134:3::10]:53814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eGhyR-0000fU-EI
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 04:02:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eGhyL-0006bk-CB
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 04:02:39 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43414)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1eGhyL-0006bD-4q
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 04:02:33 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAK90F9s135039
	for <qemu-devel@nongnu.org>; Mon, 20 Nov 2017 04:02:28 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ebv13r6j4-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Nov 2017 04:02:27 -0500
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 20 Nov 2017 09:02:24 -0000
References: <1510942228-22822-1-git-send-email-thuth@redhat.com>
	<b083a168-4743-46a7-d78c-78b86d300dbc@de.ibm.com>
	<b4f16003-a1ff-c5dd-dc06-c285929254ba@de.ibm.com>
	<20171120100037.4a694914.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 20 Nov 2017 10:02:22 +0100
MIME-Version: 1.0
In-Reply-To: <20171120100037.4a694914.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <894f3253-fdb8-503b-26f1-be8c4ba57bb0@de.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH for-2.11] pc-bios/s390-ccw:
 Fix problem with invalid virtio-scsi LUN when rebooting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org



On 11/20/2017 10:00 AM, Cornelia Huck wrote:
> On Mon, 20 Nov 2017 09:48:36 +0100
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>> Thomas,
>>
>> does this patch help as well?
>>
>> diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
>> index 6d0c2ee..2687590 100644
>> --- a/pc-bios/s390-ccw/Makefile
>> +++ b/pc-bios/s390-ccw/Makefile
>> @@ -12,7 +12,7 @@ $(call set-vpath, $(SRC_PATH)/pc-bios/s390-ccw)
>>  OBJECTS = start.o main.o bootmap.o sclp.o virtio.o virtio-scsi.o virtio-blkdev.o
>>  QEMU_CFLAGS := $(filter -W%, $(QEMU_CFLAGS))
>>  QEMU_CFLAGS += -ffreestanding -fno-delete-null-pointer-checks -msoft-float
>> -QEMU_CFLAGS += -march=z900 -fPIE -fno-strict-aliasing
>> +QEMU_CFLAGS += -march=z900 -fPIE -fno-strict-aliasing -fno-zero-initialized-in-bss
>>  QEMU_CFLAGS += $(call cc-option, $(QEMU_CFLAGS), -fno-stack-protector)
>>  LDFLAGS += -Wl,-pie -nostdlib
> 
> If this would actually enable us to kill a whole bird swarm with one
> stone, I'd prefer it over the patch below, nicely short though it is.

I will resend with proper patch description so that Thomas can comment on a proper
patch.


> 
> 
> I plan to pack the one or the other into s390-fixes today and rebuild.
> 
>>  
>>
>>
>>
>> On 11/17/2017 07:45 PM, Christian Borntraeger wrote:
>>>
>>>
>>> On 11/17/2017 07:10 PM, Thomas Huth wrote:  
>>>> When rebooting a guest that has a virtio-scsi disk, the s390-ccw
>>>> bios sometimes bails out with an error message like this:
>>>>
>>>> ! SCSI cannot report LUNs: STATUS=02 RSPN=70 KEY=05 CODE=25 QLFR=00, sure !
>>>>
>>>> Enabling the scsi_req* tracing in QEMU shows that the ccw bios is
>>>> trying to execute the REPORT LUNS SCSI command with a LUN != 0, and
>>>> this causes the SCSI command to fail.
>>>> Looks like we neither clear the BSS of the s390-ccw bios during reboot,
>>>> nor do we explicitly set the default_scsi_device.lun value to 0, so
>>>> this variable can contain random values from the OS after the reboot.
>>>> By setting this variable explicitly to 0, the problem is fixed and
>>>> the reboots always succeed.
>>>>
>>>> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1514352
>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>  
>>>
>>> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>>
>>> We had these things multile times in the past. The QEMU elf loader does not
>>> zero the BSS (it just loads the load section).  Hmm, what about letting the 
>>> BIOS zero its bss itself. IIRC the kernel does the same thing. I will have a
>>> look into that for 2.12.
>>>
>>> PS: Please do not forget to rebuild the bios  
>>>> ---
>>>>  pc-bios/s390-ccw/virtio-scsi.c | 3 ++-
>>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/pc-bios/s390-ccw/virtio-scsi.c b/pc-bios/s390-ccw/virtio-scsi.c
>>>> index c92f5d3..4fe4b9d 100644
>>>> --- a/pc-bios/s390-ccw/virtio-scsi.c
>>>> +++ b/pc-bios/s390-ccw/virtio-scsi.c
>>>> @@ -223,7 +223,8 @@ static void virtio_scsi_locate_device(VDev *vdev)
>>>>
>>>>      for (target = 0; target <= vdev->config.scsi.max_target; target++) {
>>>>          sdev->channel = channel;
>>>> -        sdev->target = target; /* sdev->lun will be 0 here */
>>>> +        sdev->target = target;
>>>> +        sdev->lun = 0;          /* LUN has to be 0 for REPORT LUNS */
>>>>          if (!scsi_report_luns(vdev, data, sizeof(data))) {
>>>>              if (resp.response == VIRTIO_SCSI_S_BAD_TARGET) {
>>>>                  continue;
>>>>  
>>>
>>>   
>>
> 
