Received: from eggs.gnu.org ([209.51.188.92]:57371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1h1uej-0005w0-87
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 10:09:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1h1uei-0001A9-A8
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 10:09:57 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36634
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jjherne@linux.ibm.com>)
	id 1h1uei-00017a-1W
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 10:09:56 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x27ExNW9005754
	for <qemu-devel@nongnu.org>; Thu, 7 Mar 2019 10:09:54 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2r34x5jyjy-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 10:09:54 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <jjherne@linux.ibm.com>;
	Thu, 7 Mar 2019 15:09:53 -0000
Reply-To: jjherne@linux.ibm.com
References: <1551466776-29123-1-git-send-email-jjherne@linux.ibm.com>
	<1551466776-29123-13-git-send-email-jjherne@linux.ibm.com>
	<20190305133058.536c2eeb.cohuck@redhat.com>
From: "Jason J. Herne" <jjherne@linux.ibm.com>
Date: Thu, 7 Mar 2019 10:09:46 -0500
MIME-Version: 1.0
In-Reply-To: <20190305133058.536c2eeb.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <b67c0d7a-89a0-c61b-f082-da303eb6a830@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 12/16] s390-bios: Refactor virtio to run
 channel programs via cio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, pasic@linux.ibm.com, alifm@linux.ibm.com, borntraeger@de.ibm.com

On 3/5/19 7:30 AM, Cornelia Huck wrote:
> On Fri,  1 Mar 2019 13:59:32 -0500
> "Jason J. Herne" <jjherne@linux.ibm.com> wrote:
> 
>> Now that we have a Channel I/O library let's modify virtio boot code to
>> make use of it for running channel programs.
>>
>> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
>> ---
>>   pc-bios/s390-ccw/virtio.c | 49 +++++++++++++++++++----------------------------
>>   1 file changed, 20 insertions(+), 29 deletions(-)
>>
>> diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
>> index aa9da72..711daf5 100644
>> --- a/pc-bios/s390-ccw/virtio.c
>> +++ b/pc-bios/s390-ccw/virtio.c
>> @@ -14,6 +14,7 @@
>>   #include "virtio.h"
>>   #include "virtio-scsi.h"
>>   #include "bswap.h"
>> +#include "helper.h"
>>   
>>   #define VRING_WAIT_REPLY_TIMEOUT 30
>>   
>> @@ -89,33 +90,20 @@ int drain_irqs(SubChannelId schid)
>>       }
>>   }
>>   
>> -static int run_ccw(VDev *vdev, int cmd, void *ptr, int len)
>> +static int run_ccw(VDev *vdev, int cmd, void *ptr, int len, bool sli)
>>   {
>>       Ccw1 ccw = {};
>> -    CmdOrb orb = {};
>> -    int r;
>> -
>> -    enable_subchannel(vdev->schid);
>> -
>> -    /* start subchannel command */
>> -    orb.fmt = 1;
>> -    orb.cpa = (u32)(long)&ccw;
>> -    orb.lpm = 0x80;
>>   
>>       ccw.cmd_code = cmd;
>>       ccw.cda = (long)ptr;
>>       ccw.count = len;
>>   
>> -    r = ssch(vdev->schid, &orb);
>> -    /*
>> -     * XXX Wait until device is done processing the CCW. For now we can
>> -     *     assume that a simple tsch will have finished the CCW processing,
>> -     *     but the architecture allows for asynchronous operation
>> -     */
>> -    if (!r) {
>> -        r = drain_irqs(vdev->schid);
>> +    if (sli) {
>> +        ccw.flags |= CCW_FLAG_SLI;
>>       }
>> -    return r;
>> +
>> +    enable_subchannel(vdev->schid);
> 
> As said, maybe just move this to the main routine, instead of having to
> call this here again and again.
> 

I can just remove this call all together, but because of the netboot case I'll need to add 
a call to enable_subchannel to virtio_is_supported() or find_net_dev().

netmain.c: main -> virtio_setup-> find_net_dev-> virtio_is_supported

Let me know if you like this idea or not. If you're okay with it, I'll queue it up for v4. 
IMHO, adding the call to find_net_dev makes more sense than virtio_is_supported.


>> +    return do_cio(vdev->schid, ptr2u32(&ccw), CCW_FMT1);
>>   }
>>   
>>   static void vring_init(VRing *vr, VqInfo *info)
> 
> (...)
> 
>> @@ -324,7 +314,8 @@ bool virtio_is_supported(SubChannelId schid)
>>       vdev.schid = schid;
>>       memset(&vdev.senseid, 0, sizeof(vdev.senseid));
>>       /* run sense id command */
>> -    if (run_ccw(&vdev, CCW_CMD_SENSE_ID, &vdev.senseid, sizeof(vdev.senseid))) {
>> +    if (run_ccw(&vdev, CCW_CMD_SENSE_ID, &vdev.senseid, sizeof(vdev.senseid),
>> +                true)) {
>>           return false;
>>       }
>>       if (vdev.senseid.cu_type == 0x3832) {
> 
> Can't you use the new routine for obtaining the cu type here?
> 

cu_type only returns the control unit type. This code goes on to look at the model number 
as well. In hind sight, I could have noticed this and simply structured my code to return 
the whole sense_id data structure. I'm not against making this change, but things seem 
pretty clean as they are. :)

-- 
-- Jason J. Herne (jjherne@linux.ibm.com)
