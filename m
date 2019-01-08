Received: from eggs.gnu.org ([209.51.188.92]:53570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ggpEO-0002nD-5W
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 06:07:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ggpEJ-0006M9-3M
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 06:07:33 -0500
Date: Tue, 8 Jan 2019 12:07:19 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190108120719.7c477382.cohuck@redhat.com>
In-Reply-To: <bfde1bd3-0725-1085-8a98-eeaf2b0694ed@linux.ibm.com>
References: <1544623878-11248-1-git-send-email-jjherne@linux.ibm.com>
	<1544623878-11248-11-git-send-email-jjherne@linux.ibm.com>
	<20181213182100.6da37a95.cohuck@redhat.com>
	<bfde1bd3-0725-1085-8a98-eeaf2b0694ed@linux.ibm.com>
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
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, pasic@linux.ibm.com, borntraeger@de.ibm.com

On Mon, 7 Jan 2019 14:02:45 -0500
"Jason J. Herne" <jjherne@linux.ibm.com> wrote:

> On 12/13/18 12:21 PM, Cornelia Huck wrote:
> > On Wed, 12 Dec 2018 09:11:13 -0500
> > "Jason J. Herne" <jjherne@linux.ibm.com> wrote:
> >   
> >> Add struct for format-0 ccws. Support executing format-0 channel
> >> programs and waiting for their completion before continuing execution.
> >> This will be used for real dasd ipl.
> >>
> >> Add cu_type() to channel io library. This will be used to query control
> >> unit type which is used to determine if we are booting a virtio device or a
> >> real dasd device.
> >>
> >> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
> >> ---
> >>   pc-bios/s390-ccw/cio.c      | 108 ++++++++++++++++++++++++++++++++++++++
> >>   pc-bios/s390-ccw/cio.h      | 124 ++++++++++++++++++++++++++++++++++++++++++--
> >>   pc-bios/s390-ccw/s390-ccw.h |   1 +
> >>   pc-bios/s390-ccw/start.S    |  33 +++++++++++-
> >>   4 files changed, 261 insertions(+), 5 deletions(-)
> >>  
> > 
> > (...)
> >   
> >> +static bool irb_error(Irb *irb)
> >> +{
> >> +    /* We have to ignore Incorrect Length (cstat == 0x40) indicators because
> >> +     * real devices expect a 24 byte SenseID  buffer, and virtio devices expect
> >> +     * a much larger buffer. Neither device type can tolerate a buffer size
> >> +     * different from what they expect so they set this indicator.  
> > 
> > Hm, can't you specify SLI for SenseID?
> >   
> 
> Yes, but this requires modifying run_ccw() in virtio.c to always specify the SLI flag. I'm 
> not sure that is the best choice? I suppose I could add an sli argument to run_ccw if 
> you'd prefer that.

Ignoring an error feels wrong :) Telling the function "hey, I don't
know what buffer size you expect, just give me what you have" feels
better. If I read SA22-7204-01 correctly, there's always just a minimum
of sense id data, and how much we get is device dependent. (FWIW, the
Linux kernel does sense id with SLI as well.)

So yes, +1 to adding a sli parameter to run_ccw().

> 
> >> +     */
> >> +    if (irb->scsw.cstat != 0x00 && irb->scsw.cstat != 0x40) {
> >> +        return true;
> >> +    }
> >> +    return irb->scsw.dstat != 0xc;  
> > 
> > Also, shouldn't you actually use the #defines you introduce further
> > down?
> >   
> 
> Yep, I added the defines after I wrote this code. I'll fix that.
> 
> >> +}
> >> +
> >> +/* Executes a channel program at a given subchannel. The request to run the
> >> + * channel program is sent to the subchannel, we then wait for the interrupt
> >> + * singaling completion of the I/O operation(s) perfomed by the channel

s/perfomed/performed/

> >> + * program. Lastly we verify that the i/o operation completed without error and
> >> + * that the interrupt we received was for the subchannel used to run the
> >> + * channel program.
> >> + *
> >> + * Note: This function assumes it is running in an environment where no other
> >> + * cpus are generating or receiving I/O interrupts. So either run it in a
> >> + * single-cpu environment or make sure all other cpus are not doing I/O and
> >> + * have I/O interrupts masked off.  
> > 
> > Anything about iscs here (cr6)?
> >   
> 
> Those details are handled in the assembler code. Do you think I should mention something 
> about cr6 here?

We can probably do without.

> 
> >> + */
> >> +int do_cio(SubChannelId schid, uint32_t ccw_addr, int fmt)
> >> +{
> >> +    CmdOrb orb = {};
> >> +    Irb irb = {};
> >> +    SenseData sd;
> >> +    int rc, retries = 0;
> >> +
> >> +    IPL_assert(fmt == 0 || fmt == 1, "Invalid ccw format");
> >> +
> >> +    /* ccw_addr must be <= 24 bits and point to at least one whole ccw. */
> >> +    if (fmt == 0) {
> >> +        IPL_assert(ccw_addr <= 0xFFFFFF - 8, "Invalid ccw address");
> >> +    }
> >> +
> >> +    orb.fmt = fmt ;
> >> +    orb.pfch = 1;  /* QEMU's cio implementation requires prefetch */
> >> +    orb.c64 = 1;   /* QEMU's cio implementation requires 64-bit idaws */
> >> +    orb.lpm = 0xFF; /* All paths allowed */
> >> +    orb.cpa = ccw_addr;
> >> +
> >> +    while (true) {
> >> +        rc = ssch(schid, &orb);  
> > 
> > I think we can get here:
> > - cc 0 -> all ok
> > - cc 1 -> status pending; could that be an unsolicited interrupt from
> >    the device? or would we always get a deferred cc 1 in that case?
> > - cc 2 -> another function pending; Should Not Happen
> > - cc 3 -> it's dead, Jim
> > 
> > So I'm wondering whether we should consume the status and retry for cc
> > 1. The handling of the others is fine.
> >   
> 
> I took a look at css_do_ssch() in hw/s390x/css.c and it appears as though CC1 is a 
> possibility here. I'm not against taking action, but I suspect we would have to clear the 
> status with a basic sense (or something) before simply retrying... right?

It depends on the status. If you get an unit check, you'll probably
need the basic sense; in other cases, you'll probably want to simply
retry.

> 
> Is it safe for us to just assume we can clear it and move on? It seems like an edge case 
> that we'd be better off failing on. Perhaps let the user try again which will redrive the 
> process?

A very low amount of retries (2?) sounds reasonable: this would keep us
going if there's a state from the device that will be ignored anyway,
and won't get us stuck in a pointless retry loop if something more
involved is going on.

> 
> 
> >> +        if (rc) {
> >> +            print_int("ssch failed with rc=", rc);
> >> +            break;
> >> +        }
> >> +
> >> +        consume_io_int();
> >> +
> >> +        /* Clear read */  
> > 
> > I find that comment confusing. /* collect status */ maybe?
> >   
> >> +        rc = tsch(schid, &irb);  
> > 
> > Here we can get:
> > - cc 0 -> status pending, all ok
> > - cc 1 -> no status pending, Should Not Happen
> > - cc 3 -> it's dead, Jim
> > 
> > So this looks fine.
> >   
> >> +        if (rc) {
> >> +            print_int("tsch failed with rc=", rc);
> >> +            break;
> >> +        }
> >> +
> >> +        if (!irb_error(&irb)) {
> >> +            break;
> >> +        }
> >> +
> >> +        /* Unexpected unit check. Use sense to clear unit check then retry. */  
> > 
> > The dasds still don't support concurrent sense, do they? Might also be
> > worth investigating whether some unit checks are more "recoverable"
> > than others.
> >   
> 
> I wasn't sure on concurrent sense. I'd bet there are situations or environments where it 
> won't be supported so it seems safest to assume we don't have it.

Ok.

> 
> We already recover from the one unit check scenario I've discovered in practice (initial 
> reset). And the algorithm I chose is to simply retry a few times whenever we're presented 
> with unexpected unit check status. This is what the kernel does. It seems fairly robust.

Nod.

> > I expect we simply want to ignore IFCCs? IIRC, the strategy for those
> > is "retry, in case it is transient"; but that may take some time. Or
> > was there some path handling to be considered? (i.e., retrying may
> > select another path, which may be fine.)
> >   
> 
> Currently we'll give up on IFCC. I think this is the right thing to do. A user can always 
> retry if they want. But in reality an IFCC very likely means faulty hardware IIUC.

It could also be a transient link issue. Maybe retry twice, just to
avoid the very tiny blips?

> I've not thought about path management much. I suspect paths changing isn't something we 
> should realistically see in the bios. Even still, a retry is really all we can do, so 
> assuming path changes result in a unit check then we should be okay there.

If you use a full path mask, the channel subsystem might try a
different path (that is working correctly) the next time. I don't think
you want to implement path grouping stuff in the bios, which would mean
a lot of pain for very little gain :)

Thinking about path groups: One scenario we might have is that another
LPAR did a reserve on a dasd and then died. The dasd is then
unaccessible by our LPAR until we do a steal lock. If the device is
bound to the vfio-ccw subchannel driver, we don't have an interface for
that, though (we would need to re-bind to the I/O subchannel driver and
the dasd driver so we can invoke tunedasd). We could add an option to
break the lock from the bios, although that's probably overkill for a
real edge case. Just wanted to mention it :)

> 
> 
> >> +        if (unit_check(&irb) && retries <= 2) {
> >> +            basic_sense(schid, &sd);
> >> +            retries++;
> >> +            continue;
> >> +        }
> >> +
> >> +        break;
> >> +    }
> >> +
> >> +    return rc;
> >> +}  
> > 
> > (...)
> >   
> >> @@ -190,6 +247,9 @@ struct ciw {
> >>       __u16 count;
> >>   };
> >>   
> >> +#define CU_TYPE_VIRTIO          0x3832
> >> +#define CU_TYPE_DASD            0x3990  
> > 
> > No other dasd types we want to support? :) (Not sure if others are out
> > in the wild. Maybe FBA?)
> >  
> 
> I have no idea. I assumed 3390 was the only thing we supported. Perhaps 3380? I'd need to 
> find a test device, which I could probably do ... I'll look more into this.

IIRC, z/VM can hand out FBA devices. I'm not sure if current storage
systems can emulate them.

> 
> 
> >> +
> >>   /*
> >>    * sense-id response buffer layout
> >>    */
> >> @@ -205,6 +265,61 @@ typedef struct senseid {
> >>       struct ciw ciw[62];
> >>   }  __attribute__ ((packed, aligned(4))) SenseId;
> >>   
> >> +/* architected values for first sense byte */
> >> +#define SNS0_CMD_REJECT         0x80
> >> +#define SNS0_INTERVENTION_REQ   0x40
> >> +#define SNS0_BUS_OUT_CHECK      0x20
> >> +#define SNS0_EQUIPMENT_CHECK    0x10
> >> +#define SNS0_DATA_CHECK         0x08
> >> +#define SNS0_OVERRUN            0x04
> >> +#define SNS0_INCOMPL_DOMAIN     0x01  
> > 
> > IIRC, only byte 0 is device independent, and the others below are
> > (ECKD) dasd specific?
> >   
> >> +
> >> +/* architectured values for second sense byte */
> >> +#define SNS1_PERM_ERR           0x80
> >> +#define SNS1_INV_TRACK_FORMAT   0x40
> >> +#define SNS1_EOC                0x20
> >> +#define SNS1_MESSAGE_TO_OPER    0x10
> >> +#define SNS1_NO_REC_FOUND       0x08
> >> +#define SNS1_FILE_PROTECTED     0x04
> >> +#define SNS1_WRITE_INHIBITED    0x02
> >> +#define SNS1_INPRECISE_END      0x01
> >> +
> >> +/* architectured values for third sense byte */
> >> +#define SNS2_REQ_INH_WRITE      0x80
> >> +#define SNS2_CORRECTABLE        0x40
> >> +#define SNS2_FIRST_LOG_ERR      0x20
> >> +#define SNS2_ENV_DATA_PRESENT   0x10
> >> +#define SNS2_INPRECISE_END      0x04
> >> +
> >> +/* 24-byte Sense fmt/msg codes */
> >> +#define SENSE24_FMT_PROG_SYS    0x0
> >> +#define SENSE24_FMT_EQUIPMENT   0x2
> >> +#define SENSE24_FMT_CONTROLLER  0x3
> >> +#define SENSE24_FMT_MISC        0xF
> >> +
> >> +#define SENSE24_FMT0_MSG_RESET_NOTIFICATION 0x16
> >> +
> >> +/* basic sense response buffer layout */
> >> +typedef struct senseData {
> >> +    uint8_t status[3];
> >> +    uint8_t res_count;
> >> +    uint8_t phys_drive_id;
> >> +    uint8_t low_cyl_addr;
> >> +    uint8_t head_high_cyl_addr;
> >> +    uint8_t fmt_msg;
> >> +    uint64_t fmt_dependent_info[2];
> >> +    uint8_t reserved;
> >> +    uint8_t program_action_code;
> >> +    uint16_t config_info;
> >> +    uint8_t mcode_hicyl;
> >> +    uint8_t cyl_head_addr[3];
> >> +}  __attribute__ ((packed, aligned(4))) SenseData;  
> > 
> > And this looks _really_ dasd specific.
> >   
> 
> Yep, I glossed over those details while I was furiously tracking down the reset bug. I'll 
> take a look at redesigning this.

Ok.

> 
> >> +
> >> +#define SENSE24_GET_FMT(sd)     (sd->fmt_msg & 0xF0 >> 4)
> >> +#define SENSE24_GET_MSG(sd)     (sd->fmt_msg & 0x0F)
> >> +
> >> +#define unit_check(irb)     ((irb)->scsw.dstat & SCSW_DSTAT_UCHK)
> >> +
> >>   /* interruption response block */
> >>   typedef struct irb {
> >>       struct scsw scsw;  
> > 
> > (...)
> >   
> >> diff --git a/pc-bios/s390-ccw/start.S b/pc-bios/s390-ccw/start.S
> >> index eb8d024..a48c38f 100644
> >> --- a/pc-bios/s390-ccw/start.S
> >> +++ b/pc-bios/s390-ccw/start.S
> >> @@ -65,12 +65,32 @@ consume_sclp_int:
> >>           /* prepare external call handler */
> >>           larl %r1, external_new_code
> >>           stg %r1, 0x1b8
> >> -        larl %r1, external_new_mask
> >> +        larl %r1, int_new_mask
> >>           mvc 0x1b0(8),0(%r1)
> >>           /* load enabled wait PSW */
> >>           larl %r1, enabled_wait_psw
> >>           lpswe 0(%r1)
> >>   
> >> +/*
> >> + * void consume_io_int(void)
> >> + *
> >> + * eats one I/O interrupt  
> > 
> > *nomnom*
> >   
> >> + */
> >> +        .globl consume_io_int
> >> +consume_io_int:
> >> +        /* enable I/O interrupts in cr0 */  
> > 
> > cr6?
> >   
> >> +        stctg 6,6,0(15)
> >> +        oi 4(15), 0xff
> >> +        lctlg 6,6,0(15)
> >> +        /* prepare external call handler */  
> > 
> > I/O call handler?
> >   
> 
> Both copy/paste errors. Thanks for catching these. :)
> 
> >> +        larl %r1, io_new_code
> >> +        stg %r1, 0x1f8
> >> +        larl %r1, int_new_mask
> >> +        mvc 0x1f0(8),0(%r1)
> >> +        /* load enabled wait PSW */
> >> +        larl %r1, enabled_wait_psw
> >> +        lpswe 0(%r1)
> >> +
> >>   external_new_code:
> >>           /* disable service interrupts in cr0 */
> >>           stctg 0,0,0(15)
> >> @@ -78,10 +98,19 @@ external_new_code:
> >>           lctlg 0,0,0(15)
> >>           br 14
> >>   
> >> +io_new_code:
> >> +        /* disable I/O interrupts in cr6 */
> >> +        stctg 6,6,0(15)  
> > 
> > I'm wondering why you are changing cr6 every time you wait for an I/O
> > interrupt. Just enable the isc(s) you want once, and disable them again
> > after you're done with all I/O? Simply disabling the I/O interrupts
> > should be enough to prevent further interrupts popping up. You maybe
> > want two enabled wait PSWs, one with I/O + external and one with
> > external only?
> >   
> 
> No real reason. We only come through here a hand full of times so performance is not a 
> consideration. I guess my thought process was probably to keep the system is as close to 
> initial state as possible through the ipl process. Eventually when we hand control to the 
> guest OS we want the system as close to undisturbed as possible. If you think I should 
> only be setting cr-6 once, it sounds reasonable.

It just looked a bit odd to me. But I agree that this isn't
performance-sensitive.

> 
> 
> >> +        ni 4(15), 0x00
> >> +        lctlg 6,6,0(15)
> >> +        br 14
> >> +
> >> +
> >> +
> >>           .align  8
> >>   disabled_wait_psw:
> >>           .quad   0x0002000180000000,0x0000000000000000
> >>   enabled_wait_psw:
> >>           .quad   0x0302000180000000,0x0000000000000000
> >> -external_new_mask:
> >> +int_new_mask:
> >>           .quad   0x0000000180000000  
> > 
> >   
> 
> 
