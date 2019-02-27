Received: from eggs.gnu.org ([209.51.188.92]:51072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1gyzUU-00053S-2O
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 08:43:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1gyzLA-0004pi-HY
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 08:33:42 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36556)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jjherne@linux.ibm.com>)
	id 1gyzL7-0004ha-MV
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 08:33:38 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1RDSfqu086290
	for <qemu-devel@nongnu.org>; Wed, 27 Feb 2019 08:33:18 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qwtux2bye-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 27 Feb 2019 08:33:17 -0500
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <jjherne@linux.ibm.com>;
	Wed, 27 Feb 2019 13:33:16 -0000
Reply-To: jjherne@linux.ibm.com
References: <1548768562-20007-1-git-send-email-jjherne@linux.ibm.com>
	<1548768562-20007-11-git-send-email-jjherne@linux.ibm.com>
	<735ca9ff-76e3-966f-6fbc-a72bf994b413@linux.ibm.com>
	<20190204121319.32915fd6.cohuck@redhat.com>
From: "Jason J. Herne" <jjherne@linux.ibm.com>
Date: Wed, 27 Feb 2019 08:32:58 -0500
MIME-Version: 1.0
In-Reply-To: <20190204121319.32915fd6.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <333f78d1-48e1-3483-7c94-5cf52e1eafab@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 10/15] s390-bios: Support for running
 format-0/1 channel programs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Farhan Ali <alifm@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, pasic@linux.ibm.com, borntraeger@de.ibm.com

On 2/4/19 6:13 AM, Cornelia Huck wrote:
> On Thu, 31 Jan 2019 12:31:00 -0500
> Farhan Ali <alifm@linux.ibm.com> wrote:
> 
>> On 01/29/2019 08:29 AM, Jason J. Herne wrote:
>>> Add struct for format-0 ccws. Support executing format-0 channel
>>> programs and waiting for their completion before continuing execution.
>>> This will be used for real dasd ipl.
>>>
>>> Add cu_type() to channel io library. This will be used to query control
>>> unit type which is used to determine if we are booting a virtio device or a
>>> real dasd device.
>>>
>>> Signed-off-by: Jason J. Herne<jjherne@linux.ibm.com>
>>> ---
>>>    pc-bios/s390-ccw/cio.c      | 114 +++++++++++++++++++++++++++++++++++++++
>>>    pc-bios/s390-ccw/cio.h      | 127 ++++++++++++++++++++++++++++++++++++++++++--
>>>    pc-bios/s390-ccw/s390-ccw.h |   1 +
>>>    pc-bios/s390-ccw/start.S    |  33 +++++++++++-
>>>    4 files changed, 270 insertions(+), 5 deletions(-)
> 
>>> +/*
>>> + * Executes a channel program at a given subchannel. The request to run the
>>> + * channel program is sent to the subchannel, we then wait for the interrupt
>>> + * signaling completion of the I/O operation(s) performed by the channel
>>> + * program. Lastly we verify that the i/o operation completed without error and
>>> + * that the interrupt we received was for the subchannel used to run the
>>> + * channel program.
>>> + *
>>> + * Note: This function assumes it is running in an environment where no other
>>> + * cpus are generating or receiving I/O interrupts. So either run it in a
>>> + * single-cpu environment or make sure all other cpus are not doing I/O and
>>> + * have I/O interrupts masked off.
>>> + */
>>> +int do_cio(SubChannelId schid, uint32_t ccw_addr, int fmt)
>>> +{
>>> +    CmdOrb orb = {};
>>> +    Irb irb = {};
>>> +    sense_data_eckd_dasd sd;
>>> +    int rc, retries = 0;
>>> +
>>> +    IPL_assert(fmt == 0 || fmt == 1, "Invalid ccw format");
>>> +
>>> +    /* ccw_addr must be <= 24 bits and point to at least one whole ccw. */
>>> +    if (fmt == 0) {
>>> +        IPL_assert(ccw_addr <= 0xFFFFFF - 8, "Invalid ccw address");
>>> +    }
>>> +
>>> +    orb.fmt = fmt ;
>>> +    orb.pfch = 1;  /* QEMU's cio implementation requires prefetch */
>>> +    orb.c64 = 1;   /* QEMU's cio implementation requires 64-bit idaws */
>>> +    orb.lpm = 0xFF; /* All paths allowed */
>>> +    orb.cpa = ccw_addr;
>>> +
>>> +    while (true) {
>>> +        rc = ssch(schid, &orb);
>>> +        if (rc == 1) {
>>> +            /* Status pending, not sure why. Let's eat the status and retry. */
>>> +            tsch(schid, &irb);
>>> +            retries++;
>>> +            continue;
>>> +        }
>>> +        if (rc) {
>>> +            print_int("ssch failed with rc=", rc);
>>> +            break;
>>> +        }
>>> +
>>> +        consume_io_int();
>>> +
>>> +        /* collect status */
>>> +        rc = tsch(schid, &irb);
>>> +        if (rc) {
>>> +            print_int("tsch failed with rc=", rc);
>>> +            break;
>>> +        }
>>> +
>>> +        if (!irb_error(&irb)) {
>>> +            break;
>>> +        }
>>> +
>>> +        /*
>>> +         * Unexpected unit check, or interface-control-check. Use sense to
>>> +         * clear unit check then retry.
>>> +         */
>>> +        if ((unit_check(&irb) || iface_ctrl_check(&irb)) && retries <= 2) {
>>> +            basic_sense(schid, &sd, sizeof(sd));
>>
>> We are using basic sense to clear any unit check or ifcc, but is it
>> possible for the basic sense to cause another unit check?
>>
>> The chapter on Basic Sense in the Common I/O Device Commands
>> (http://publibz.boulder.ibm.com/support/libraryserver/FRAMESET/dz9ar501/2.1?SHELF=&DT=19920409154647&CASE=)
>>    says this:
>>
>> ""
>> The basic sense command initiates a sense operation  at  all  devices
>> and cannot  cause  the  command-reject,  intervention-required,
>> data-check, or overrun bit to be set to one.  If the control unit
>> detects  an  equipment malfunction  or  invalid  checking-block  code
>> (CBC) on the sense-command code, the equipment-check or bus-out-check
>> bit is set  to  one,  and  unit check is indicated in the device-status
>> byte.
>> ""
>>
>> If my understanding is correct, if there is an equipment malfunction
>> then the control unit can return a unit check even for a basic sense.
>> This can lead to infinite recursion in the bios.
> 
> I think the retries variable is supposed to take care of that.
> 
> What I don't understand is why we do the basic sense after an IFCC?
> Wouldn't it make more sense to simply retry the original command in
> that case?
> 

I assumed it might be needed to clear status. It seems not. I'll modify that code path 
accordingly.


-- 
-- Jason J. Herne (jjherne@linux.ibm.com)
