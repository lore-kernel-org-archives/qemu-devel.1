Received: from eggs.gnu.org ([2001:4830:134:3::10]:48928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1fbRpP-0000Wx-RC
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 10:35:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1fbRpL-0006bQ-Km
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 10:35:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58648)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jjherne@linux.ibm.com>)
	id 1fbRpL-0006ax-Cc
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 10:35:15 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w66ETD0b082395
	for <qemu-devel@nongnu.org>; Fri, 6 Jul 2018 10:35:14 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2k29wuh1rd-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 06 Jul 2018 10:35:13 -0400
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <jjherne@linux.ibm.com>;
	Fri, 6 Jul 2018 08:35:13 -0600
Reply-To: jjherne@linux.ibm.com
References: <1530811543-6881-1-git-send-email-jjherne@linux.ibm.com>
	<1530811543-6881-11-git-send-email-jjherne@linux.ibm.com>
	<20180706100346.3dda6b10.cohuck@redhat.com>
From: "Jason J. Herne" <jjherne@linux.ibm.com>
Date: Fri, 6 Jul 2018 10:35:06 -0400
MIME-Version: 1.0
In-Reply-To: <20180706100346.3dda6b10.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <6d312b22-5af2-bed5-c920-9b5133598515@linux.ibm.com>
Subject: Re: [Qemu-devel] [RFC 10/15] s390-bios: Support for running
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
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, pasic@linux.ibm.com, bjsdjshi@linux.ibm.com, borntraeger@de.ibm.com

On 07/06/2018 04:03 AM, Cornelia Huck wrote:
> On Thu,  5 Jul 2018 13:25:38 -0400
> "Jason J. Herne" <jjherne@linux.ibm.com> wrote:
> ...
>> +
>> +    senseIdCcw.cmd_code = CCW_CMD_SENSE_ID;
>> +    senseIdCcw.cda = ptr2u32(&senseData);
> 
> Are we sure that this is always under 2G?
> 

I thought I saw somewhere that Qemu always loads the bios at the high 
end of guest memory or right under the 2 GB line if guest memory is 
greater than 2 GB... I cannot remember the source of this information 
but I do use it when calculating where to find the bios code for 
debugging with GDB. Here is the formula used:

let "FW_BASE=RAM_SIZE > 0x80000000 ? 0x80000000 : RAM_SIZE"
let "FW_BASE=(FW_BASE - 0x200000)  & (~0xffff)"

So 2GB - 2MB is where we seem to load the bios.
Can anyone provide more concrete info?

FWIW I've tried booting a 6 GB guest and it works :).

>> +    senseIdCcw.count = sizeof(senseData);
>> +
>> +    if (do_cio(schid, ptr2u32(&senseIdCcw), CCW_FMT1)) {
>> +        panic("Failed to run SenseID CCw\n");
>> +    }
>> +
>> +    return senseData.cu_type;
>> +}
>> +
>> +static bool irb_error(Irb *irb)
>> +{
>> +    /* We have to ignore Incorrect Length (cstat == 0x40) indicators because
>> +     * real devices expect a 24 byte SenseID  buffer, and virtio devices expect
>> +     * a much larger buffer. Neither device type can tolerate a buffer size
>> +     * different from what they expect so they set this indicator.
> 
> Hm... do you have details? Is that basic vs. extended SenseID
> information?
> 
> (If the code in QEMU is making incorrect assumptions, I'd like to fix
> that.)

I really have no idea and was hoping someone who knows virtio ccw better 
than myself would have some ideas. This comment simply documents what I 
discovered in testing. I can look into it more if no one else has any 
information on this. FWIW, it has been working without issue in my testing.

>> +     */
>> +    if (irb->scsw.cstat != 0x00 && irb->scsw.cstat != 0x40) {
>> +        return true;
>> +    }
>> +    return irb->scsw.dstat != 0xc;
>> +}
>> +
>> +/* Executes a channel program at a given subchannel. The request to run the
>> + * channel program is sent to the subchannel, we then wait for the interrupt
>> + * singaling completion of the I/O operation(s) perfomed by the channel
>> + * program. Lastly we verify that the i/o operation completed without error and
>> + * that the interrupt we received was for the subchannel used to run the
>> + * channel program.
> 
> Finally, real interrupts instead of polling in the s390-ccw bios,
> nice :)
> 

Yep, I was happy to replace the polling. This probably needs wider 
testing however as it is tricky enough to hide some really weird side 
effects as I discovered a few times during development.

>> + *
>> + * Note: This function assumes it is running in an environment where no other
>> + * cpus are generating or receiving I/O interrupts. So either run it in a
>> + * single-cpu environment or make sure all other cpus are not doing I/O and
>> + * have I/O interrupts masked off.
>> + */
>> +int do_cio(SubChannelId schid, uint32_t ccw_addr, int fmt)
>> +{
>> +    Ccw0 *this_ccw, *prev_ccw;
>> +    CmdOrb orb = {};
>> +    Irb irb = {};
>> +    int rc;
>> +
>> +    IPL_assert(fmt == 0 || fmt == 1, "Invalid ccw format");
>> +
>> +    /* ccw_addr must be <= 24 bits and point to at least one whole ccw. */
>> +    if (fmt == 0) {
>> +        IPL_assert(ccw_addr <= 0xFFFFFF - 8, "Invalid ccw address");
>> +    }
>> +
>> +    orb.fmt = fmt ;
>> +    orb.pfch = 1;  /* QEMU's cio implementation requires prefetch */
>> +    orb.c64 = 1;   /* QEMU's cio implementation requires 64-bit idaws */
>> +    orb.lpm = 0xFF; /* All paths allowed */
>> +    orb.cpa = ccw_addr;
>> +
>> +    rc = ssch(schid, &orb);
>> +    if (rc) {
>> +        print_int("ssch failed with rc=", rc);
>> +        return rc;
> 
> Are you doing anything like retrying on cc 1/2? It's probably fine to
> give up on cc 3.
> 
>> +    }
>> +
>> +    await_io_int(schid.sch_no);
>> +
>> +    /* Clear read */
>> +    rc = tsch(schid, &irb);
>> +    if (rc) {
>> +        print_int("tsch failed with rc=", rc);
>> +        return rc;
> 
> If you get a cc 1 here (no status pending), that's probably an internal
> error (as you just did a successful ssch and assume you got an I/O
> interrupt). If you get a cc 3, it's probably a good idea to give up on
> this subchannel.

At the moment the code treats any non-zero CC as an error and returns it 
to the caller.



-- 
-- Jason J. Herne (jjherne@linux.ibm.com)
