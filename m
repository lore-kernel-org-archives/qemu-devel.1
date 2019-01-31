Received: from eggs.gnu.org ([209.51.188.92]:44768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1gpGBC-0002Lk-NY
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 12:31:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1gpGBB-0007zr-Fw
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 12:31:10 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34556)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.ibm.com>) id 1gpGBB-0007yv-3W
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 12:31:09 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0VHQnjc062850
	for <qemu-devel@nongnu.org>; Thu, 31 Jan 2019 12:31:07 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qc5dx06qr-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 31 Jan 2019 12:31:06 -0500
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alifm@linux.ibm.com>;
	Thu, 31 Jan 2019 17:31:05 -0000
References: <1548768562-20007-1-git-send-email-jjherne@linux.ibm.com>
	<1548768562-20007-11-git-send-email-jjherne@linux.ibm.com>
From: Farhan Ali <alifm@linux.ibm.com>
Date: Thu, 31 Jan 2019 12:31:00 -0500
MIME-Version: 1.0
In-Reply-To: <1548768562-20007-11-git-send-email-jjherne@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <735ca9ff-76e3-966f-6fbc-a72bf994b413@linux.ibm.com>
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
To: "Jason J. Herne" <jjherne@linux.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, pasic@linux.ibm.com, borntraeger@de.ibm.com



On 01/29/2019 08:29 AM, Jason J. Herne wrote:
> Add struct for format-0 ccws. Support executing format-0 channel
> programs and waiting for their completion before continuing execution.
> This will be used for real dasd ipl.
> 
> Add cu_type() to channel io library. This will be used to query control
> unit type which is used to determine if we are booting a virtio device or a
> real dasd device.
> 
> Signed-off-by: Jason J. Herne<jjherne@linux.ibm.com>
> ---
>   pc-bios/s390-ccw/cio.c      | 114 +++++++++++++++++++++++++++++++++++++++
>   pc-bios/s390-ccw/cio.h      | 127 ++++++++++++++++++++++++++++++++++++++++++--
>   pc-bios/s390-ccw/s390-ccw.h |   1 +
>   pc-bios/s390-ccw/start.S    |  33 +++++++++++-
>   4 files changed, 270 insertions(+), 5 deletions(-)
> 
> diff --git a/pc-bios/s390-ccw/cio.c b/pc-bios/s390-ccw/cio.c
> index 095f79b..63581c6 100644
> --- a/pc-bios/s390-ccw/cio.c
> +++ b/pc-bios/s390-ccw/cio.c
> @@ -10,6 +10,7 @@
>   
>   #include "libc.h"
>   #include "s390-ccw.h"
> +#include "s390-arch.h"
>   #include "cio.h"
>   
>   static char chsc_page[PAGE_SIZE] __attribute__((__aligned__(PAGE_SIZE)));
> @@ -39,3 +40,116 @@ void enable_subchannel(SubChannelId schid)
>       schib.pmcw.ena = 1;
>       msch(schid, &schib);
>   }
> +
> +uint16_t cu_type(SubChannelId schid)
> +{
> +    Ccw1 sense_id_ccw;
> +    SenseId sense_data;
> +
> +    sense_id_ccw.cmd_code = CCW_CMD_SENSE_ID;
> +    sense_id_ccw.cda = ptr2u32(&sense_data);
> +    sense_id_ccw.count = sizeof(sense_data);
> +    sense_id_ccw.flags |= CCW_FLAG_SLI;
> +
> +    if (do_cio(schid, ptr2u32(&sense_id_ccw), CCW_FMT1)) {
> +        panic("Failed to run SenseID CCw\n");
> +    }
> +
> +    return sense_data.cu_type;
> +}
> +
> +void basic_sense(SubChannelId schid, void *sense_data, uint16_t data_size)
> +{
> +    Ccw1 senseCcw;
> +
> +    senseCcw.cmd_code = CCW_CMD_BASIC_SENSE;
> +    senseCcw.cda = ptr2u32(sense_data);
> +    senseCcw.count = data_size;
> +
> +    if (do_cio(schid, ptr2u32(&senseCcw), CCW_FMT1)) {
> +        panic("Failed to run Basic Sense CCW\n");
> +    }
> +}
> +
> +static bool irb_error(Irb *irb)
> +{
> +    if (irb->scsw.cstat) {
> +        return true;
> +    }
> +    return irb->scsw.dstat != (SCSW_DSTAT_DEVEND | SCSW_DSTAT_CHEND);
> +}
> +
> +/*
> + * Executes a channel program at a given subchannel. The request to run the
> + * channel program is sent to the subchannel, we then wait for the interrupt
> + * signaling completion of the I/O operation(s) performed by the channel
> + * program. Lastly we verify that the i/o operation completed without error and
> + * that the interrupt we received was for the subchannel used to run the
> + * channel program.
> + *
> + * Note: This function assumes it is running in an environment where no other
> + * cpus are generating or receiving I/O interrupts. So either run it in a
> + * single-cpu environment or make sure all other cpus are not doing I/O and
> + * have I/O interrupts masked off.
> + */
> +int do_cio(SubChannelId schid, uint32_t ccw_addr, int fmt)
> +{
> +    CmdOrb orb = {};
> +    Irb irb = {};
> +    sense_data_eckd_dasd sd;
> +    int rc, retries = 0;
> +
> +    IPL_assert(fmt == 0 || fmt == 1, "Invalid ccw format");
> +
> +    /* ccw_addr must be <= 24 bits and point to at least one whole ccw. */
> +    if (fmt == 0) {
> +        IPL_assert(ccw_addr <= 0xFFFFFF - 8, "Invalid ccw address");
> +    }
> +
> +    orb.fmt = fmt ;
> +    orb.pfch = 1;  /* QEMU's cio implementation requires prefetch */
> +    orb.c64 = 1;   /* QEMU's cio implementation requires 64-bit idaws */
> +    orb.lpm = 0xFF; /* All paths allowed */
> +    orb.cpa = ccw_addr;
> +
> +    while (true) {
> +        rc = ssch(schid, &orb);
> +        if (rc == 1) {
> +            /* Status pending, not sure why. Let's eat the status and retry. */
> +            tsch(schid, &irb);
> +            retries++;
> +            continue;
> +        }
> +        if (rc) {
> +            print_int("ssch failed with rc=", rc);
> +            break;
> +        }
> +
> +        consume_io_int();
> +
> +        /* collect status */
> +        rc = tsch(schid, &irb);
> +        if (rc) {
> +            print_int("tsch failed with rc=", rc);
> +            break;
> +        }
> +
> +        if (!irb_error(&irb)) {
> +            break;
> +        }
> +
> +        /*
> +         * Unexpected unit check, or interface-control-check. Use sense to
> +         * clear unit check then retry.
> +         */
> +        if ((unit_check(&irb) || iface_ctrl_check(&irb)) && retries <= 2) {
> +            basic_sense(schid, &sd, sizeof(sd));

We are using basic sense to clear any unit check or ifcc, but is it 
possible for the basic sense to cause another unit check?

The chapter on Basic Sense in the Common I/O Device Commands 
(http://publibz.boulder.ibm.com/support/libraryserver/FRAMESET/dz9ar501/2.1?SHELF=&DT=19920409154647&CASE=) 
  says this:

""
The basic sense command initiates a sense operation  at  all  devices 
and cannot  cause  the  command-reject,  intervention-required, 
data-check, or overrun bit to be set to one.  If the control unit 
detects  an  equipment malfunction  or  invalid  checking-block  code 
(CBC) on the sense-command code, the equipment-check or bus-out-check 
bit is set  to  one,  and  unit check is indicated in the device-status 
byte.
""

If my understanding is correct, if there is an equipment malfunction 
then the control unit can return a unit check even for a basic sense. 
This can lead to infinite recursion in the bios.



> +            retries++;
> +            continue;
> +        }
> +
> +        break;
> +    }
> +
> +    return rc;
> +}
