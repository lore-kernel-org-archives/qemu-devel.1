Received: from eggs.gnu.org ([2001:4830:134:3::10]:52007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fbNvV-0006oX-I2
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 06:25:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fbNvS-0004yt-BY
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 06:25:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49738)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1fbNvR-0004ty-S8
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 06:25:18 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w66ANfEU032328
	for <qemu-devel@nongnu.org>; Fri, 6 Jul 2018 06:25:16 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2k2524ks0p-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 06 Jul 2018 06:25:16 -0400
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 6 Jul 2018 11:25:14 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
References: <1530811543-6881-1-git-send-email-jjherne@linux.ibm.com>
	<1530811543-6881-11-git-send-email-jjherne@linux.ibm.com>
	<398b3770-75a4-8880-4cb9-a75770fb974b@de.ibm.com>
Date: Fri, 6 Jul 2018 12:25:09 +0200
MIME-Version: 1.0
In-Reply-To: <398b3770-75a4-8880-4cb9-a75770fb974b@de.ibm.com>
Content-Language: en-US
Message-Id: <74a23a35-f083-23d5-9364-906dcee840c0@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [qemu-s390x] [RFC 10/15] s390-bios: Support for
 running format-0/1 channel programs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Jason J. Herne" <jjherne@linux.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, pasic@linux.ibm.com, bjsdjshi@linux.ibm.com



On 07/06/2018 09:04 AM, Christian Borntraeger wrote:
> 
> 
> On 07/05/2018 07:25 PM, Jason J. Herne wrote:
>> From: "Jason J. Herne" <jjherne@linux.vnet.ibm.com>
>>
>> Add struct for format-0 ccws. Support executing format-0 channel
>> programs and waiting for their completion before continuing execution.
>> This will be used for real dasd ipl.
>>
>> Add cu_type() to channel io library. This will be used to query control
>> unit type which is used to determine if we are booting a virtio device or a
>> real dasd device.
>>
>> Signed-off-by: Jason J. Herne <jjherne@linux.vnet.ibm.com>
>> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
>> ---
>>  pc-bios/s390-ccw/cio.c | 127 +++++++++++++++++++++++++++++++++++++++++++++++++
>>  pc-bios/s390-ccw/cio.h |  25 +++++++++-
>>  2 files changed, 151 insertions(+), 1 deletion(-)
>>
>> diff --git a/pc-bios/s390-ccw/cio.c b/pc-bios/s390-ccw/cio.c
>> index 095f79b..f440380 100644
>> --- a/pc-bios/s390-ccw/cio.c
>> +++ b/pc-bios/s390-ccw/cio.c
>> @@ -10,6 +10,7 @@
>>  
>>  #include "libc.h"
>>  #include "s390-ccw.h"
>> +#include "s390-arch.h"
>>  #include "cio.h"
>>  
>>  static char chsc_page[PAGE_SIZE] __attribute__((__aligned__(PAGE_SIZE)));
>> @@ -39,3 +40,129 @@ void enable_subchannel(SubChannelId schid)
>>      schib.pmcw.ena = 1;
>>      msch(schid, &schib);
>>  }
>> +
>> +__u16 cu_type(SubChannelId schid)
>> +{
>> +    Ccw1 senseIdCcw;
>> +    SenseId senseData;
>> +
>> +    senseIdCcw.cmd_code = CCW_CMD_SENSE_ID;
>> +    senseIdCcw.cda = ptr2u32(&senseData);
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
>> +    }
>> +
>> +    await_io_int(schid.sch_no);
>> +
>> +    /* Clear read */
>> +    rc = tsch(schid, &irb);
>> +    if (rc) {
>> +        print_int("tsch failed with rc=", rc);
>> +        return rc;
>> +    }
>> +
>> +    if (irb_error(&irb)) {
>> +        this_ccw = u32toptr(irb.scsw.cpa);
>> +        prev_ccw = u32toptr(irb.scsw.cpa - 8);
>> +
>> +        print_int("irb_error: cstat=", irb.scsw.cstat);
>> +        print_int("           dstat=", irb.scsw.dstat);
>> +        print_int("           cpa=", irb.scsw.cpa);
>> +        print_int("           prev_ccw=", *((uint64_t *)prev_ccw));
>> +        print_int("           this_ccw=", *((uint64_t *)this_ccw));
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +void await_io_int(uint16_t sch_no)
>> +{
>> +    /*
>> +     * wait_psw and ctl6 must be static to avoid stack allocation as gcc cannot
>> +     * align stack variables. The stctg, lctlg and lpswe instructions require
>> +     * that their operands be aligned on an 8-byte boundary.
>> +    */
>> +    static uint64_t ctl6 __attribute__((__aligned__(8)));
>> +    static PSW wait_psw;
>> +
>> +    /* PSW to load when I/O interrupt happens */
>> +    lowcore->io_new_psw.mask = PSW_MASK_ZMODE;
>> +    lowcore->io_new_psw.addr = (uint64_t)&&IOIntWakeup; /* Wake-up address */
>> +
>> +    /* Enable io interrupts subclass mask */
>> +    asm volatile("stctg 6,6,%0" : "=S" (ctl6) : : "memory");
> 
> For some reason the sles12 gcc does not like this. Can you use the "Q" constraint 
> everywhere instead of "S".
> 
Or better use "QS" and "=QS"
