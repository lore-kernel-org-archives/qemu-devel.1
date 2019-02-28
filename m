Received: from eggs.gnu.org ([209.51.188.92]:40594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1gzO6d-0006cX-Bq
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 11:00:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1gzO6X-0002nK-BC
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 11:00:19 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51140)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jjherne@linux.ibm.com>)
	id 1gzO6V-0002TF-9u
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 11:00:13 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1SFo2Mx033407
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 10:59:48 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qxfs51etd-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 10:59:42 -0500
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <jjherne@linux.ibm.com>;
	Thu, 28 Feb 2019 15:59:23 -0000
Reply-To: jjherne@linux.ibm.com
References: <1548768562-20007-1-git-send-email-jjherne@linux.ibm.com>
	<1548768562-20007-12-git-send-email-jjherne@linux.ibm.com>
	<20190204124105.0abb9b44.cohuck@redhat.com>
From: "Jason J. Herne" <jjherne@linux.ibm.com>
Date: Thu, 28 Feb 2019 10:59:13 -0500
MIME-Version: 1.0
In-Reply-To: <20190204124105.0abb9b44.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <1ae847e3-5f46-e050-5910-7e9010a8c6cf@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 11/15] s390-bios: cio error handling
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

On 2/4/19 6:41 AM, Cornelia Huck wrote:
...
> 
>> +static void print_irb_err(Irb *irb)
>> +{
>> +    Ccw0 *this_ccw = u32toptr(irb->scsw.cpa);
>> +    Ccw0 *prev_ccw = u32toptr(irb->scsw.cpa - 8);
> 
> I don't think you can cast this conditionally to format 0 -- I'd pass
> in the format from do_cio and handle it accordingly.
> 
>> +    char msgline[256];
>> +
>> +    sclp_print("vfio-ccw device I/O error - Interrupt Response Block Data:\n");
> 
> If you call this from the generic function, you shouldn't talk about
> vfio-ccw here; but it might make sense to print subchannel/devno and
> the cu type.
> 
> (...)
>

Fixed for v3.


>> @@ -148,6 +370,9 @@ int do_cio(SubChannelId schid, uint32_t ccw_addr, int fmt)
>>               continue;
>>           }
>>   
>> +        print_irb_err(&irb);
>> +        basic_sense(schid, &sd, sizeof(sd));
>> +        print_eckd_dasd_sense_data(&sd);
> 
> I think this should only be printed for actual dasds (and maybe only
> print it if there is actually sense data available)?
> 

Good point. Currently do_cio doesn't have any info on its device type. Should I pass in 
the controller type? Thats the easiest way I can think of to make the decision.

-- 
-- Jason J. Herne (jjherne@linux.ibm.com)
