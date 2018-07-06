Received: from eggs.gnu.org ([2001:4830:134:3::10]:53181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fbLic-0006zK-4n
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 04:03:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fbLiZ-0004cT-0L
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 04:03:54 -0400
Date: Fri, 6 Jul 2018 10:03:46 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180706100346.3dda6b10.cohuck@redhat.com>
In-Reply-To: <1530811543-6881-11-git-send-email-jjherne@linux.ibm.com>
References: <1530811543-6881-1-git-send-email-jjherne@linux.ibm.com>
	<1530811543-6881-11-git-send-email-jjherne@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
To: "Jason J. Herne" <jjherne@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, pasic@linux.ibm.com, bjsdjshi@linux.ibm.com, borntraeger@de.ibm.com

On Thu,  5 Jul 2018 13:25:38 -0400
"Jason J. Herne" <jjherne@linux.ibm.com> wrote:

> From: "Jason J. Herne" <jjherne@linux.vnet.ibm.com>
> 
> Add struct for format-0 ccws. Support executing format-0 channel
> programs and waiting for their completion before continuing execution.
> This will be used for real dasd ipl.
> 
> Add cu_type() to channel io library. This will be used to query control
> unit type which is used to determine if we are booting a virtio device or a
> real dasd device.
> 
> Signed-off-by: Jason J. Herne <jjherne@linux.vnet.ibm.com>
> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
> ---
>  pc-bios/s390-ccw/cio.c | 127 +++++++++++++++++++++++++++++++++++++++++++++++++
>  pc-bios/s390-ccw/cio.h |  25 +++++++++-
>  2 files changed, 151 insertions(+), 1 deletion(-)
> 
> diff --git a/pc-bios/s390-ccw/cio.c b/pc-bios/s390-ccw/cio.c
> index 095f79b..f440380 100644
> --- a/pc-bios/s390-ccw/cio.c
> +++ b/pc-bios/s390-ccw/cio.c
> @@ -10,6 +10,7 @@
>  
>  #include "libc.h"
>  #include "s390-ccw.h"
> +#include "s390-arch.h"
>  #include "cio.h"
>  
>  static char chsc_page[PAGE_SIZE] __attribute__((__aligned__(PAGE_SIZE)));
> @@ -39,3 +40,129 @@ void enable_subchannel(SubChannelId schid)
>      schib.pmcw.ena = 1;
>      msch(schid, &schib);
>  }
> +
> +__u16 cu_type(SubChannelId schid)

Make this return uint16_t?

> +{
> +    Ccw1 senseIdCcw;
> +    SenseId senseData;

I'd prefer the variables to be sense_id_ccw and sense_data instead of
CamelCasing.

> +
> +    senseIdCcw.cmd_code = CCW_CMD_SENSE_ID;
> +    senseIdCcw.cda = ptr2u32(&senseData);

Are we sure that this is always under 2G?

> +    senseIdCcw.count = sizeof(senseData);
> +
> +    if (do_cio(schid, ptr2u32(&senseIdCcw), CCW_FMT1)) {
> +        panic("Failed to run SenseID CCw\n");
> +    }
> +
> +    return senseData.cu_type;
> +}
> +
> +static bool irb_error(Irb *irb)
> +{
> +    /* We have to ignore Incorrect Length (cstat == 0x40) indicators because
> +     * real devices expect a 24 byte SenseID  buffer, and virtio devices expect
> +     * a much larger buffer. Neither device type can tolerate a buffer size
> +     * different from what they expect so they set this indicator.

Hm... do you have details? Is that basic vs. extended SenseID
information?

(If the code in QEMU is making incorrect assumptions, I'd like to fix
that.)

> +     */
> +    if (irb->scsw.cstat != 0x00 && irb->scsw.cstat != 0x40) {
> +        return true;
> +    }
> +    return irb->scsw.dstat != 0xc;
> +}
> +
> +/* Executes a channel program at a given subchannel. The request to run the
> + * channel program is sent to the subchannel, we then wait for the interrupt
> + * singaling completion of the I/O operation(s) perfomed by the channel
> + * program. Lastly we verify that the i/o operation completed without error and
> + * that the interrupt we received was for the subchannel used to run the
> + * channel program.

Finally, real interrupts instead of polling in the s390-ccw bios,
nice :)

> + *
> + * Note: This function assumes it is running in an environment where no other
> + * cpus are generating or receiving I/O interrupts. So either run it in a
> + * single-cpu environment or make sure all other cpus are not doing I/O and
> + * have I/O interrupts masked off.
> + */
> +int do_cio(SubChannelId schid, uint32_t ccw_addr, int fmt)
> +{
> +    Ccw0 *this_ccw, *prev_ccw;
> +    CmdOrb orb = {};
> +    Irb irb = {};
> +    int rc;
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
> +    rc = ssch(schid, &orb);
> +    if (rc) {
> +        print_int("ssch failed with rc=", rc);
> +        return rc;

Are you doing anything like retrying on cc 1/2? It's probably fine to
give up on cc 3.

> +    }
> +
> +    await_io_int(schid.sch_no);
> +
> +    /* Clear read */
> +    rc = tsch(schid, &irb);
> +    if (rc) {
> +        print_int("tsch failed with rc=", rc);
> +        return rc;

If you get a cc 1 here (no status pending), that's probably an internal
error (as you just did a successful ssch and assume you got an I/O
interrupt). If you get a cc 3, it's probably a good idea to give up on
this subchannel.

> +    }
> +
> +    if (irb_error(&irb)) {
> +        this_ccw = u32toptr(irb.scsw.cpa);
> +        prev_ccw = u32toptr(irb.scsw.cpa - 8);
> +
> +        print_int("irb_error: cstat=", irb.scsw.cstat);
> +        print_int("           dstat=", irb.scsw.dstat);
> +        print_int("           cpa=", irb.scsw.cpa);
> +        print_int("           prev_ccw=", *((uint64_t *)prev_ccw));
> +        print_int("           this_ccw=", *((uint64_t *)this_ccw));
> +    }
> +
> +    return 0;
> +}
