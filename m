Received: from eggs.gnu.org ([209.51.188.92]:45511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1h1ydk-0001EK-IF
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 14:25:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1h1ydj-0006Ad-2L
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 14:25:12 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50986)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jjherne@linux.ibm.com>)
	id 1h1ydi-00066E-Ll
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 14:25:11 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x27JJFdi046480
	for <qemu-devel@nongnu.org>; Thu, 7 Mar 2019 14:25:09 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2r36jpssk7-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 14:25:08 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <jjherne@linux.ibm.com>;
	Thu, 7 Mar 2019 19:25:07 -0000
Reply-To: jjherne@linux.ibm.com
References: <1551466776-29123-1-git-send-email-jjherne@linux.ibm.com>
	<1551466776-29123-11-git-send-email-jjherne@linux.ibm.com>
	<20190304192522.138639d3.cohuck@redhat.com>
From: "Jason J. Herne" <jjherne@linux.ibm.com>
Date: Thu, 7 Mar 2019 14:25:00 -0500
MIME-Version: 1.0
In-Reply-To: <20190304192522.138639d3.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <4410deed-a325-cbe2-382a-bb08ab6490d5@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 10/16] s390-bios: Support for running
 format-0/1 channel programs
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

On 3/4/19 1:25 PM, Cornelia Huck wrote:
> On Fri,  1 Mar 2019 13:59:30 -0500
> "Jason J. Herne" <jjherne@linux.ibm.com> wrote:
> 
>> Add struct for format-0 ccws. Support executing format-0 channel
>> programs and waiting for their completion before continuing execution.
> 
> That sentence is a bit confusing. What about:
> 
> "Introduce a library function for executing format-0 and format-1
> channel programs..."
> 

Agreed. Fixed.

>> This will be used for real dasd ipl.
> 
> But also for virtio in the follow-on patches, won't it?
> 

True. I removed that line. It is obvious and not really useful anyway.

...
>> +    orb.fmt = fmt ;
> 
> extra ' ' before ';'
> 

Fixed.

>> +    orb.pfch = 1;  /* QEMU's cio implementation requires prefetch */
>> +    orb.c64 = 1;   /* QEMU's cio implementation requires 64-bit idaws */
>> +    orb.lpm = 0xFF; /* All paths allowed */
>> +    orb.cpa = ccw_addr;
>> +
>> +    rc = ssch(schid, &orb);
>> +    if (rc == 1) {
>> +        /* Status pending, not sure why. Eat status and ask for retry. */
>> +        tsch(schid, irb);
>> +        return -1;
>> +    }
>> +    if (rc) {
>> +        print_int("ssch failed with rc=", rc);
> 
> Better 'cc' than 'rc' in the message?
> 

Fixed here and for tsch as well.

>> +        return rc;
>> +    }
>> +
>> +    consume_io_int();
>> +
>> +    /* collect status */
>> +    rc = tsch(schid, irb);
>> +    if (rc) {
>> +        print_int("tsch failed with rc=", rc);
>> +    }
> 
> Hm. The whole code flow relies on the fact that not only no more than
> one cpu is enabled for I/O interrupts, but also only one subchannel.
> Otherwise, you could get an interrupt for another subchannel, which
> would be the only way you'd get cc 1 on the tsch for this subchannel
> here (no status pending). Maybe peek at the interruption information
> stored into the lowcore first?
> 
> Won't be a problem with the code as it is now, though, AFAICS.
> 
Agreed, voting to leave as is. Perhaps a comment to explain that we rely on only one 
"Active" i/o device?

>> +
>> +    return rc;
>> +}
>> +
>> +/*
>> + * Executes a channel program at a given subchannel. The request to run the
>> + * channel program is sent to the subchannel, we then wait for the interrupt
>> + * signaling completion of the I/O operation(s) performed by the channel
>> + * program. Lastly we verify that the i/o operation completed without error and
>> + * that the interrupt we received was for the subchannel used to run the
>> + * channel program.
>> + *
>> + * Note: This function assumes it is running in an environment where no other
>> + * cpus are generating or receiving I/O interrupts. So either run it in a
>> + * single-cpu environment or make sure all other cpus are not doing I/O and
>> + * have I/O interrupts masked off.
>> + *
>> + * Returns non-zero on error.
>> + */
>> +int do_cio(SubChannelId schid, uint32_t ccw_addr, int fmt)
>> +{
>> +    Irb irb = {};
>> +    SenseDataEckdDasd sd;
>> +    int rc, retries = 0;
>> +
>> +    while (true) {
>> +        rc = __do_cio(schid, ccw_addr, fmt, &irb);
>> +
>> +        if (rc == -1) {
>> +            retries++;
>> +            continue;
>> +        }
>> +        if (rc) {
>> +            /* ssch/tsch error. Message already reported by __do_cio */
> 
> You might also want to consider retrying on cc 2. Not very likely,
> though.
> 

It is easy to retry on cc=2, fixed.

>> +            break;
>> +        }
>> +
>> +        if (!irb_error(&irb)) {
>> +            break;
>> +        }
>> +
>> +        /*
>> +         * Unexpected unit check, or interface-control-check. Use sense to
>> +         * clear (unit check only) then retry.
>> +         */
>> +        if ((unit_check(&irb) || iface_ctrl_check(&irb)) && retries <= 2) {
>> +            if (unit_check(&irb)) {
>> +                basic_sense(schid, &sd, sizeof(sd));
> 
> Unless I'm confused: I think you can still descend into the unit check
> rabbit hole here. basic_sense() calls do_cio(), which calls
> basic_sense(),... and we don't even get to the retries check.
> 
> Maybe call __do_cio() from basic_sense() instead and make that return
> an error instead of panicking? Then you could just bump retries here
> and give up after some retries...
> 

Yes, good point. This is now fixed.
-- 
-- Jason J. Herne (jjherne@linux.ibm.com)
