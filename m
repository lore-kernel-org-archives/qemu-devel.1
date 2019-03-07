Received: from eggs.gnu.org ([209.51.188.92]:47320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1h1yjz-0006cr-7U
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 14:31:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1h1yjw-0002YL-Qt
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 14:31:38 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46880
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jjherne@linux.ibm.com>)
	id 1h1yjw-0002Uv-ID
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 14:31:36 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x27JTeTc103772
	for <qemu-devel@nongnu.org>; Thu, 7 Mar 2019 14:31:34 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2r38ya1s9s-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 14:31:32 -0500
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <jjherne@linux.ibm.com>;
	Thu, 7 Mar 2019 19:31:31 -0000
Reply-To: jjherne@linux.ibm.com
References: <1551466776-29123-1-git-send-email-jjherne@linux.ibm.com>
	<1551466776-29123-12-git-send-email-jjherne@linux.ibm.com>
	<20190304193509.5eae1b41.cohuck@redhat.com>
From: "Jason J. Herne" <jjherne@linux.ibm.com>
Date: Thu, 7 Mar 2019 14:31:23 -0500
MIME-Version: 1.0
In-Reply-To: <20190304193509.5eae1b41.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <5cf175cf-892c-d909-f832-127bf3f4747a@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 11/16] s390-bios: cio error handling
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

On 3/4/19 1:35 PM, Cornelia Huck wrote:
> On Fri,  1 Mar 2019 13:59:31 -0500
> "Jason J. Herne" <jjherne@linux.ibm.com> wrote:
> 
>> Add verbose error output for when unexpected i/o errors happen. This eases the
>> burden of debugging and reporting i/o errors. No error information is printed
>> in the success case, here is an example of what is output on error:
>>
>> cio device error
>>    ssid  : 0x0000000000000000
>>    cssid : 0x0000000000000000
>>    sch_no: 0x0000000000000000
>>
>> Interrupt Response Block Data:
>>      Function Ctrl : [Start]
>>      Activity Ctrl : [Start-Pending]
>>      Status Ctrl : [Alert] [Primary] [Secondary] [Status-Pending]
>>      Device Status : [Unit-Check]
>>      Channel Status :
>>      cpa=: 0x000000007f8d6038
>>      prev_ccw=: 0x0000000000000000
>>      this_ccw=: 0x0000000000000000
>> Eckd Dasd Sense Data (fmt 32-bytes):
>>      Sense Condition Flags :
>>      Residual Count     =: 0x0000000000000000
>>      Phys Drive ID      =: 0x000000000000009e
>>      low cyl address    =: 0x0000000000000000
>>      head addr & hi cyl =: 0x0000000000000000
>>      format/message     =: 0x0000000000000008
>>      fmt-dependent[0-7] =: 0x0000000000000004
>>      fmt-dependent[8-15]=: 0xe561282305082fff
>>      prog action code   =: 0x0000000000000016
>>      Configuration info =: 0x00000000000040e0
>>      mcode / hi-cyl     =: 0x0000000000000000
>>      cyl & head addr [0]=: 0x0000000000000000
>>      cyl & head addr [1]=: 0x0000000000000000
>>      cyl & head addr [2]=: 0x0000000000000000
>>
>> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
>> ---
>>   pc-bios/s390-ccw/cio.c  | 230 ++++++++++++++++++++++++++++++++++++++++++++++++
>>   pc-bios/s390-ccw/libc.h |  11 +++
>>   2 files changed, 241 insertions(+)
>>
>> diff --git a/pc-bios/s390-ccw/cio.c b/pc-bios/s390-ccw/cio.c
>> index e61cfd3..c528bbf 100644
>> --- a/pc-bios/s390-ccw/cio.c
>> +++ b/pc-bios/s390-ccw/cio.c
>> @@ -82,6 +82,228 @@ static bool irb_error(Irb *irb)
>>       return irb->scsw.dstat != (SCSW_DSTAT_DEVEND | SCSW_DSTAT_CHEND);
>>   }
>>   
>> +static void print_eckd_dasd_sense_data(SenseDataEckdDasd *sd)
>> +{
>> +    char msgline[512];
>> +
>> +    if (sd->config_info & 0x8000) {
>> +        sclp_print("Eckd Dasd Sense Data (fmt 24-bytes):\n");
>> +    } else {
>> +        sclp_print("Eckd Dasd Sense Data (fmt 32-bytes):\n");
>> +    }
>> +
>> +    strcat(msgline, "    Sense Condition Flags :");
>> +    if (sd->status[0] & SNS_STAT0_CMD_REJECT) {
>> +        strcat(msgline, " [Cmd-Reject]");
>> +    }
>> +    if (sd->status[0] & SNS_STAT0_INTERVENTION_REQ) {
>> +        strcat(msgline, " [Intervention-Required]");
>> +    }
>> +    if (sd->status[0] & SNS_STAT0_BUS_OUT_CHECK) {
>> +        strcat(msgline, " [Bus-Out-Parity-Check]");
>> +    }
>> +    if (sd->status[0] & SNS_STAT0_EQUIPMENT_CHECK) {
>> +        strcat(msgline, " [Equipment-Check]");
>> +    }
>> +    if (sd->status[0] & SNS_STAT0_DATA_CHECK) {
>> +        strcat(msgline, " [Data-Check]");
> 
> I'm wondering whether it would make sense to factor the common bits
> out. Might be overkill, though.
> 

I'm not huge fan of this error code myself. It looks nice in output and may be useful for 
debugging which is why I decided to submit it. I did think about ways to make it look 
cleaner but didn't come up with anything great. I'd be open to suggestions, but I also 
think going too deep is overkill.

...
> Maybe do basic_sense + print sense data only if there's actually a unit
> check?
> 
> (Also, I'm not sure if you can even do a basic_sense in case e.g. of
> unexpected busy.)
> 
>> +        basic_sense(schid, &sd, sizeof(sd));
>> +        print_eckd_dasd_sense_data(&sd);
>>           rc = -1;
>>           break;
>>       }

I've made a change that should address both issues. Preview:

         if (cutype == CU_TYPE_DASD_3990 || cutype == CU_TYPE_UNKNOWN) {
             if (!basic_sense(schid, cutype, &sd, sizeof(sd))) {
                 print_eckd_dasd_sense_data(&sd);
             }
         }

Now we only print sense data if basic sense works. So if it fails because of a busy status 
(or any reason) we won't try to print.

-- 
-- Jason J. Herne (jjherne@linux.ibm.com)
