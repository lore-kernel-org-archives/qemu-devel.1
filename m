Received: from eggs.gnu.org ([2001:4830:134:3::10]:59654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gXUfm-0004ts-4c
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 12:21:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gXUfc-0000re-BA
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 12:21:14 -0500
Date: Thu, 13 Dec 2018 18:21:00 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181213182100.6da37a95.cohuck@redhat.com>
In-Reply-To: <1544623878-11248-11-git-send-email-jjherne@linux.ibm.com>
References: <1544623878-11248-1-git-send-email-jjherne@linux.ibm.com>
	<1544623878-11248-11-git-send-email-jjherne@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
To: "Jason J. Herne" <jjherne@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, pasic@linux.ibm.com, bjsdjshi@linux.ibm.com, borntraeger@de.ibm.com

On Wed, 12 Dec 2018 09:11:13 -0500
"Jason J. Herne" <jjherne@linux.ibm.com> wrote:

> Add struct for format-0 ccws. Support executing format-0 channel
> programs and waiting for their completion before continuing execution.
> This will be used for real dasd ipl.
> 
> Add cu_type() to channel io library. This will be used to query control
> unit type which is used to determine if we are booting a virtio device or a
> real dasd device.
> 
> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
> ---
>  pc-bios/s390-ccw/cio.c      | 108 ++++++++++++++++++++++++++++++++++++++
>  pc-bios/s390-ccw/cio.h      | 124 ++++++++++++++++++++++++++++++++++++++++++--
>  pc-bios/s390-ccw/s390-ccw.h |   1 +
>  pc-bios/s390-ccw/start.S    |  33 +++++++++++-
>  4 files changed, 261 insertions(+), 5 deletions(-)
> 

(...)

> +static bool irb_error(Irb *irb)
> +{
> +    /* We have to ignore Incorrect Length (cstat == 0x40) indicators because
> +     * real devices expect a 24 byte SenseID  buffer, and virtio devices expect
> +     * a much larger buffer. Neither device type can tolerate a buffer size
> +     * different from what they expect so they set this indicator.

Hm, can't you specify SLI for SenseID?

> +     */
> +    if (irb->scsw.cstat != 0x00 && irb->scsw.cstat != 0x40) {
> +        return true;
> +    }
> +    return irb->scsw.dstat != 0xc;

Also, shouldn't you actually use the #defines you introduce further
down?

> +}
> +
> +/* Executes a channel program at a given subchannel. The request to run the
> + * channel program is sent to the subchannel, we then wait for the interrupt
> + * singaling completion of the I/O operation(s) perfomed by the channel
> + * program. Lastly we verify that the i/o operation completed without error and
> + * that the interrupt we received was for the subchannel used to run the
> + * channel program.
> + *
> + * Note: This function assumes it is running in an environment where no other
> + * cpus are generating or receiving I/O interrupts. So either run it in a
> + * single-cpu environment or make sure all other cpus are not doing I/O and
> + * have I/O interrupts masked off.

Anything about iscs here (cr6)?

> + */
> +int do_cio(SubChannelId schid, uint32_t ccw_addr, int fmt)
> +{
> +    CmdOrb orb = {};
> +    Irb irb = {};
> +    SenseData sd;
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

I think we can get here:
- cc 0 -> all ok
- cc 1 -> status pending; could that be an unsolicited interrupt from
  the device? or would we always get a deferred cc 1 in that case?
- cc 2 -> another function pending; Should Not Happen
- cc 3 -> it's dead, Jim

So I'm wondering whether we should consume the status and retry for cc
1. The handling of the others is fine.

> +        if (rc) {
> +            print_int("ssch failed with rc=", rc);
> +            break;
> +        }
> +
> +        consume_io_int();
> +
> +        /* Clear read */

I find that comment confusing. /* collect status */ maybe?

> +        rc = tsch(schid, &irb);

Here we can get:
- cc 0 -> status pending, all ok
- cc 1 -> no status pending, Should Not Happen
- cc 3 -> it's dead, Jim

So this looks fine.

> +        if (rc) {
> +            print_int("tsch failed with rc=", rc);
> +            break;
> +        }
> +
> +        if (!irb_error(&irb)) {
> +            break;
> +        }
> +
> +        /* Unexpected unit check. Use sense to clear unit check then retry. */

The dasds still don't support concurrent sense, do they? Might also be
worth investigating whether some unit checks are more "recoverable"
than others.

I expect we simply want to ignore IFCCs? IIRC, the strategy for those
is "retry, in case it is transient"; but that may take some time. Or
was there some path handling to be considered? (i.e., retrying may
select another path, which may be fine.)

> +        if (unit_check(&irb) && retries <= 2) {
> +            basic_sense(schid, &sd);
> +            retries++;
> +            continue;
> +        }
> +
> +        break;
> +    }
> +
> +    return rc;
> +}

(...)

> @@ -190,6 +247,9 @@ struct ciw {
>      __u16 count;
>  };
>  
> +#define CU_TYPE_VIRTIO          0x3832
> +#define CU_TYPE_DASD            0x3990

No other dasd types we want to support? :) (Not sure if others are out
in the wild. Maybe FBA?)

> +
>  /*
>   * sense-id response buffer layout
>   */
> @@ -205,6 +265,61 @@ typedef struct senseid {
>      struct ciw ciw[62];
>  }  __attribute__ ((packed, aligned(4))) SenseId;
>  
> +/* architected values for first sense byte */
> +#define SNS0_CMD_REJECT         0x80
> +#define SNS0_INTERVENTION_REQ   0x40
> +#define SNS0_BUS_OUT_CHECK      0x20
> +#define SNS0_EQUIPMENT_CHECK    0x10
> +#define SNS0_DATA_CHECK         0x08
> +#define SNS0_OVERRUN            0x04
> +#define SNS0_INCOMPL_DOMAIN     0x01

IIRC, only byte 0 is device independent, and the others below are
(ECKD) dasd specific?

> +
> +/* architectured values for second sense byte */
> +#define SNS1_PERM_ERR           0x80
> +#define SNS1_INV_TRACK_FORMAT   0x40
> +#define SNS1_EOC                0x20
> +#define SNS1_MESSAGE_TO_OPER    0x10
> +#define SNS1_NO_REC_FOUND       0x08
> +#define SNS1_FILE_PROTECTED     0x04
> +#define SNS1_WRITE_INHIBITED    0x02
> +#define SNS1_INPRECISE_END      0x01
> +
> +/* architectured values for third sense byte */
> +#define SNS2_REQ_INH_WRITE      0x80
> +#define SNS2_CORRECTABLE        0x40
> +#define SNS2_FIRST_LOG_ERR      0x20
> +#define SNS2_ENV_DATA_PRESENT   0x10
> +#define SNS2_INPRECISE_END      0x04
> +
> +/* 24-byte Sense fmt/msg codes */
> +#define SENSE24_FMT_PROG_SYS    0x0
> +#define SENSE24_FMT_EQUIPMENT   0x2
> +#define SENSE24_FMT_CONTROLLER  0x3
> +#define SENSE24_FMT_MISC        0xF
> +
> +#define SENSE24_FMT0_MSG_RESET_NOTIFICATION 0x16
> +
> +/* basic sense response buffer layout */
> +typedef struct senseData {
> +    uint8_t status[3];
> +    uint8_t res_count;
> +    uint8_t phys_drive_id;
> +    uint8_t low_cyl_addr;
> +    uint8_t head_high_cyl_addr;
> +    uint8_t fmt_msg;
> +    uint64_t fmt_dependent_info[2];
> +    uint8_t reserved;
> +    uint8_t program_action_code;
> +    uint16_t config_info;
> +    uint8_t mcode_hicyl;
> +    uint8_t cyl_head_addr[3];
> +}  __attribute__ ((packed, aligned(4))) SenseData;

And this looks _really_ dasd specific.

> +
> +#define SENSE24_GET_FMT(sd)     (sd->fmt_msg & 0xF0 >> 4)
> +#define SENSE24_GET_MSG(sd)     (sd->fmt_msg & 0x0F)
> +
> +#define unit_check(irb)     ((irb)->scsw.dstat & SCSW_DSTAT_UCHK)
> +
>  /* interruption response block */
>  typedef struct irb {
>      struct scsw scsw;

(...)

> diff --git a/pc-bios/s390-ccw/start.S b/pc-bios/s390-ccw/start.S
> index eb8d024..a48c38f 100644
> --- a/pc-bios/s390-ccw/start.S
> +++ b/pc-bios/s390-ccw/start.S
> @@ -65,12 +65,32 @@ consume_sclp_int:
>          /* prepare external call handler */
>          larl %r1, external_new_code
>          stg %r1, 0x1b8
> -        larl %r1, external_new_mask
> +        larl %r1, int_new_mask
>          mvc 0x1b0(8),0(%r1)
>          /* load enabled wait PSW */
>          larl %r1, enabled_wait_psw
>          lpswe 0(%r1)
>  
> +/*
> + * void consume_io_int(void)
> + *
> + * eats one I/O interrupt

*nomnom*

> + */
> +        .globl consume_io_int
> +consume_io_int:
> +        /* enable I/O interrupts in cr0 */

cr6?

> +        stctg 6,6,0(15)
> +        oi 4(15), 0xff
> +        lctlg 6,6,0(15)
> +        /* prepare external call handler */

I/O call handler?

> +        larl %r1, io_new_code
> +        stg %r1, 0x1f8
> +        larl %r1, int_new_mask
> +        mvc 0x1f0(8),0(%r1)
> +        /* load enabled wait PSW */
> +        larl %r1, enabled_wait_psw
> +        lpswe 0(%r1)
> +
>  external_new_code:
>          /* disable service interrupts in cr0 */
>          stctg 0,0,0(15)
> @@ -78,10 +98,19 @@ external_new_code:
>          lctlg 0,0,0(15)
>          br 14
>  
> +io_new_code:
> +        /* disable I/O interrupts in cr6 */
> +        stctg 6,6,0(15)

I'm wondering why you are changing cr6 every time you wait for an I/O
interrupt. Just enable the isc(s) you want once, and disable them again
after you're done with all I/O? Simply disabling the I/O interrupts
should be enough to prevent further interrupts popping up. You maybe
want two enabled wait PSWs, one with I/O + external and one with
external only?

> +        ni 4(15), 0x00
> +        lctlg 6,6,0(15)
> +        br 14
> +
> +
> +
>          .align  8
>  disabled_wait_psw:
>          .quad   0x0002000180000000,0x0000000000000000
>  enabled_wait_psw:
>          .quad   0x0302000180000000,0x0000000000000000
> -external_new_mask:
> +int_new_mask:
>          .quad   0x0000000180000000
