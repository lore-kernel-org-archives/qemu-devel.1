Received: from eggs.gnu.org ([2001:4830:134:3::10]:55067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1fbQMq-0002K9-PU
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 09:01:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1fbQMi-0001Ns-U4
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 09:01:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35432)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1fbQMi-0001Nd-K9
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 09:01:36 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w66Bcugd110472
	for <qemu-devel@nongnu.org>; Fri, 6 Jul 2018 07:42:32 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2k2524pjxb-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 06 Jul 2018 07:42:32 -0400
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
	Fri, 6 Jul 2018 12:42:30 +0100
References: <1530811543-6881-1-git-send-email-jjherne@linux.ibm.com>
	<1530811543-6881-11-git-send-email-jjherne@linux.ibm.com>
	<20180706100346.3dda6b10.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.ibm.com>
Date: Fri, 6 Jul 2018 13:42:25 +0200
MIME-Version: 1.0
In-Reply-To: <20180706100346.3dda6b10.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <81699814-1e9a-7031-ca3f-4d4d5c58906a@linux.ibm.com>
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
To: Cornelia Huck <cohuck@redhat.com>, "Jason J. Herne" <jjherne@linux.ibm.com>
Cc: bjsdjshi@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com



On 07/06/2018 10:03 AM, Cornelia Huck wrote:
> On Thu,  5 Jul 2018 13:25:38 -0400
> "Jason J. Herne" <jjherne@linux.ibm.com> wrote:
> 
>> From: "Jason J. Herne" <jjherne@linux.vnet.ibm.com>
>>
>> Add struct for format-0 ccws. Support executing format-0 channel
> 
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

We are in IPL context. We should have exclusive access to the DASD
we are IPL-ing from, or not? My understanding was that if the layers
below us don't violate the rules, we should never observe cc 1 or 2
here. Or am I wrong?

Regards,
Halil
