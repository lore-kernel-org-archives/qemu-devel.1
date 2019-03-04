Received: from eggs.gnu.org ([209.51.188.92]:47671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h0sHJ-0006MW-D6
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:25:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h0sHI-0004oN-A7
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:25:29 -0500
Date: Mon, 4 Mar 2019 19:25:22 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190304192522.138639d3.cohuck@redhat.com>
In-Reply-To: <1551466776-29123-11-git-send-email-jjherne@linux.ibm.com>
References: <1551466776-29123-1-git-send-email-jjherne@linux.ibm.com>
	<1551466776-29123-11-git-send-email-jjherne@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
To: "Jason J. Herne" <jjherne@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, pasic@linux.ibm.com, alifm@linux.ibm.com, borntraeger@de.ibm.com

On Fri,  1 Mar 2019 13:59:30 -0500
"Jason J. Herne" <jjherne@linux.ibm.com> wrote:

> Add struct for format-0 ccws. Support executing format-0 channel
> programs and waiting for their completion before continuing execution.

That sentence is a bit confusing. What about:

"Introduce a library function for executing format-0 and format-1
channel programs..."

> This will be used for real dasd ipl.

But also for virtio in the follow-on patches, won't it?

> 
> Add cu_type() to channel io library. This will be used to query control
> unit type which is used to determine if we are booting a virtio device or a
> real dasd device.
> 
> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
> ---
>  pc-bios/s390-ccw/cio.c      | 141 ++++++++++++++++++++++++++++++++++++++++++++
>  pc-bios/s390-ccw/cio.h      | 127 ++++++++++++++++++++++++++++++++++++++-
>  pc-bios/s390-ccw/s390-ccw.h |   1 +
>  pc-bios/s390-ccw/start.S    |  31 ++++++++++
>  4 files changed, 297 insertions(+), 3 deletions(-)
> 
(...)
> +/*
> + * Handles executing ssch, tsch and returns the irb obtained from tsch.
> + * Returns 0 on success, -1 if unexpected status pending and we need to retry,
> + * otherwse returns condition code from ssch/tsch for error cases.

s/otherwse/otherwise/

> + */
> +static int __do_cio(SubChannelId schid, uint32_t ccw_addr, int fmt, Irb *irb)
> +{
> +    CmdOrb orb = {};
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

extra ' ' before ';'

> +    orb.pfch = 1;  /* QEMU's cio implementation requires prefetch */
> +    orb.c64 = 1;   /* QEMU's cio implementation requires 64-bit idaws */
> +    orb.lpm = 0xFF; /* All paths allowed */
> +    orb.cpa = ccw_addr;
> +
> +    rc = ssch(schid, &orb);
> +    if (rc == 1) {
> +        /* Status pending, not sure why. Eat status and ask for retry. */
> +        tsch(schid, irb);
> +        return -1;
> +    }
> +    if (rc) {
> +        print_int("ssch failed with rc=", rc);

Better 'cc' than 'rc' in the message?

> +        return rc;
> +    }
> +
> +    consume_io_int();
> +
> +    /* collect status */
> +    rc = tsch(schid, irb);
> +    if (rc) {
> +        print_int("tsch failed with rc=", rc);
> +    }

Hm. The whole code flow relies on the fact that not only no more than
one cpu is enabled for I/O interrupts, but also only one subchannel.
Otherwise, you could get an interrupt for another subchannel, which
would be the only way you'd get cc 1 on the tsch for this subchannel
here (no status pending). Maybe peek at the interruption information
stored into the lowcore first?

Won't be a problem with the code as it is now, though, AFAICS.

> +
> +    return rc;
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
> + *
> + * Returns non-zero on error.
> + */
> +int do_cio(SubChannelId schid, uint32_t ccw_addr, int fmt)
> +{
> +    Irb irb = {};
> +    SenseDataEckdDasd sd;
> +    int rc, retries = 0;
> +
> +    while (true) {
> +        rc = __do_cio(schid, ccw_addr, fmt, &irb);
> +
> +        if (rc == -1) {
> +            retries++;
> +            continue;
> +        }
> +        if (rc) {
> +            /* ssch/tsch error. Message already reported by __do_cio */

You might also want to consider retrying on cc 2. Not very likely,
though.

> +            break;
> +        }
> +
> +        if (!irb_error(&irb)) {
> +            break;
> +        }
> +
> +        /*
> +         * Unexpected unit check, or interface-control-check. Use sense to
> +         * clear (unit check only) then retry.
> +         */
> +        if ((unit_check(&irb) || iface_ctrl_check(&irb)) && retries <= 2) {
> +            if (unit_check(&irb)) {
> +                basic_sense(schid, &sd, sizeof(sd));

Unless I'm confused: I think you can still descend into the unit check
rabbit hole here. basic_sense() calls do_cio(), which calls
basic_sense(),... and we don't even get to the retries check.

Maybe call __do_cio() from basic_sense() instead and make that return
an error instead of panicking? Then you could just bump retries here
and give up after some retries...

> +            }
> +            retries++;
> +            continue;
> +        }
> +
> +        rc = -1;
> +        break;
> +    }
> +
> +    return rc;
> +}
