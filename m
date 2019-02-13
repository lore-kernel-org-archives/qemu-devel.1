Received: from eggs.gnu.org ([209.51.188.92]:60974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1gtvE1-0006hQ-Ik
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 09:09:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1gtv4U-0003pO-Bt
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 08:59:34 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54254
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jjherne@linux.ibm.com>)
	id 1gtv4K-0003Si-Q3
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 08:59:24 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1DDtnM8112007
	for <qemu-devel@nongnu.org>; Wed, 13 Feb 2019 08:59:17 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qmhq1qwj3-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 13 Feb 2019 08:59:17 -0500
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <jjherne@linux.ibm.com>;
	Wed, 13 Feb 2019 13:59:16 -0000
Reply-To: jjherne@linux.ibm.com
References: <1548768562-20007-1-git-send-email-jjherne@linux.ibm.com>
	<1548768562-20007-5-git-send-email-jjherne@linux.ibm.com>
	<cc6dcf27-e1cf-14de-e729-486e1995f6eb@redhat.com>
From: "Jason J. Herne" <jjherne@linux.ibm.com>
Date: Wed, 13 Feb 2019 08:59:08 -0500
MIME-Version: 1.0
In-Reply-To: <cc6dcf27-e1cf-14de-e729-486e1995f6eb@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <722772b9-bdf7-6a4e-16cb-21bfb54e70ac@linux.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH 04/15] s390-bios: Extend
 find_dev() for non-virtio devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, pasic@linux.ibm.com, alifm@linux.ibm.com, borntraeger@de.ibm.com

On 2/11/19 11:38 AM, Thomas Huth wrote:
> On 2019-01-29 14:29, Jason J. Herne wrote:
>> We need a method for finding the subchannel of a dasd device. Let's
>> modify find_dev to handle this since it mostly does what we need. Up to
>> this point find_dev has been specific to only virtio devices.
>>
>> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
>> Acked-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>> ---
>>   pc-bios/s390-ccw/main.c | 16 +++++++++++-----
>>   1 file changed, 11 insertions(+), 5 deletions(-)
>>
>> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
>> index 67df421..7e3f65e 100644
>> --- a/pc-bios/s390-ccw/main.c
>> +++ b/pc-bios/s390-ccw/main.c
>> @@ -49,6 +49,12 @@ unsigned int get_loadparm_index(void)
>>       return atoui(loadparm_str);
>>   }
>>   
>> +/*
>> + * Find the subchannel connected to the given device (dev_no) and fill in the
>> + * subchannel information block (schib) with the connected subchannel's info.
>> + * NOTE: The global variable blk_schid is updated to contain the subchannel
>> + * information.
>> + */
>>   static bool find_dev(Schib *schib, int dev_no)
>>   {
>>       int i, r;
>> @@ -62,15 +68,15 @@ static bool find_dev(Schib *schib, int dev_no)
>>           if (!schib->pmcw.dnv) {
>>               continue;
>>           }
>> -        if (!virtio_is_supported(blk_schid)) {
>> -            continue;
>> -        }
>> +
>>           /* Skip net devices since no IPLB is created and therefore no
>> -         * no network bootloader has been loaded
>> +         * network bootloader has been loaded
>>            */
>> -        if (virtio_get_device_type() == VIRTIO_ID_NET && dev_no < 0) {
>> +        if (virtio_is_supported(blk_schid) &&
>> +            virtio_get_device_type() == VIRTIO_ID_NET && dev_no < 0) {
>>               continue;
>>           }
>> +
>>           if ((dev_no < 0) || (schib->pmcw.dev == dev_no)) {
>>               return true;
>>           }
>>
> 
> Not sure whether this really works as expected? If dev_no is -1, this
> used to return the first supported virtio device. Now it returns the
> first device that could be found - but how are we sure that we can boot
> from that device?
> 

How could we ever be sure we could boot from the first virtio device? The dev_no=1 case 
means we don't know which device to boot from so we're guessing.  The only thing that is 
changing here is that we're allowing non-virtio devices as well. We do this because we now 
support booting from a device type that is not virtio.


-- 
-- Jason J. Herne (jjherne@linux.ibm.com)
