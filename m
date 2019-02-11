Received: from eggs.gnu.org ([209.51.188.92]:42717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1gtFqB-0008Cb-BS
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 12:58:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1gtFqA-0006e1-Ck
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 12:57:59 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36756
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jjherne@linux.ibm.com>)
	id 1gtFq8-0006ZF-Fw
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 12:57:56 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1BHnCrq134449
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 12:57:41 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2qkc6f5hj2-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 12:57:41 -0500
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <jjherne@linux.ibm.com>;
	Mon, 11 Feb 2019 17:57:40 -0000
Reply-To: jjherne@linux.ibm.com
References: <1548768562-20007-1-git-send-email-jjherne@linux.ibm.com>
	<1548768562-20007-6-git-send-email-jjherne@linux.ibm.com>
	<20190204114537.0ddb236a.cohuck@redhat.com>
From: "Jason J. Herne" <jjherne@linux.ibm.com>
Date: Mon, 11 Feb 2019 12:57:36 -0500
MIME-Version: 1.0
In-Reply-To: <20190204114537.0ddb236a.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <d6de7984-bd51-ebfb-a6eb-32759faeab12@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 05/15] s390-bios: Factor finding boot
 device out of virtio code path
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

On 2/4/19 5:45 AM, Cornelia Huck wrote:
> On Tue, 29 Jan 2019 08:29:12 -0500
> "Jason J. Herne" <jjherne@linux.ibm.com> wrote:
> 
>> Make a new routine find_boot_device to locate the boot device for all
>> cases. not just virtio.
> 
> s/cases./cases,/
> 
>>
>> In one case no boot device is specified and a suitable boot device can not
>> be auto detected. The error message for this case was specific to virtio
>> devices. We update this message to remove virtio specific wording.
> 
> "The error message for the case where no boot device has been specified
> and a suitable boot device cannot be auto detected was specific to
> virtio devices. We update..."
> 
>>
>> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
>> ---
>>   pc-bios/s390-ccw/main.c  | 87 ++++++++++++++++++++++++++----------------------
>>   tests/boot-serial-test.c |  2 +-
>>   2 files changed, 49 insertions(+), 40 deletions(-)
>>
>> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
>> index 7e3f65e..2457752 100644
>> --- a/pc-bios/s390-ccw/main.c
>> +++ b/pc-bios/s390-ccw/main.c
>> @@ -55,17 +55,18 @@ unsigned int get_loadparm_index(void)
>>    * NOTE: The global variable blk_schid is updated to contain the subchannel
>>    * information.
>>    */
>> -static bool find_dev(Schib *schib, int dev_no)
>> +static bool find_subch(int dev_no)
> 
> I'm wondering why you drop passing in the schib here? But OTOH, the
> usage of global variables or not is a bit confused in the bios anyway...
> 

I dropped it as an argument because the schib was never used outside of find_dev. Seems to 
make sense to make it a local variable in this case.

-- 
-- Jason J. Herne (jjherne@linux.ibm.com)
