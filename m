Received: from eggs.gnu.org ([209.51.188.92]:60141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1gtXq5-0001Ly-Pm
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 08:11:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1gtXq3-0006Pf-Or
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 08:11:05 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35864
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1gtXq2-0006HW-Bk
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 08:11:03 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1CCxiXp060340
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 08:11:00 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2qkvg1wyht-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 08:11:00 -0500
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
	Tue, 12 Feb 2019 13:10:58 -0000
Date: Tue, 12 Feb 2019 14:10:52 +0100
From: Halil Pasic <pasic@linux.ibm.com>
In-Reply-To: <20190205111838.5fe2fc47.cohuck@redhat.com>
References: <1548768562-20007-1-git-send-email-jjherne@linux.ibm.com>
	<1548768562-20007-11-git-send-email-jjherne@linux.ibm.com>
	<735ca9ff-76e3-966f-6fbc-a72bf994b413@linux.ibm.com>
	<20190204121319.32915fd6.cohuck@redhat.com>
	<bd0a3a4e-d82c-e01b-7c81-60ee2b50eebe@linux.ibm.com>
	<20190205111838.5fe2fc47.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190212141052.66bd4ed2@oc2783563651>
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
To: Cornelia Huck <cohuck@redhat.com>
Cc: Farhan Ali <alifm@linux.ibm.com>, "Jason J. Herne" <jjherne@linux.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, borntraeger@de.ibm.com

On Tue, 5 Feb 2019 11:18:38 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> On Mon, 4 Feb 2019 14:29:18 -0500
> Farhan Ali <alifm@linux.ibm.com> wrote:
> 
> > On 02/04/2019 06:13 AM, Cornelia Huck wrote:
> > > On Thu, 31 Jan 2019 12:31:00 -0500
> > > Farhan Ali <alifm@linux.ibm.com> wrote:
> > >   
> > >> On 01/29/2019 08:29 AM, Jason J. Herne wrote:  
> > >>> Add struct for format-0 ccws. Support executing format-0 channel
> > >>> programs and waiting for their completion before continuing execution.
> > >>> This will be used for real dasd ipl.
> > >>>
> > >>> Add cu_type() to channel io library. This will be used to query control
> > >>> unit type which is used to determine if we are booting a virtio device or a
> > >>> real dasd device.
> > >>>
> > >>> Signed-off-by: Jason J. Herne<jjherne@linux.ibm.com>
> > >>> ---
> > >>>    pc-bios/s390-ccw/cio.c      | 114 +++++++++++++++++++++++++++++++++++++++
> > >>>    pc-bios/s390-ccw/cio.h      | 127 ++++++++++++++++++++++++++++++++++++++++++--
> > >>>    pc-bios/s390-ccw/s390-ccw.h |   1 +
> > >>>    pc-bios/s390-ccw/start.S    |  33 +++++++++++-
> > >>>    4 files changed, 270 insertions(+), 5 deletions(-)  
> > >   
> > >>> +/*
> > >>> + * Executes a channel program at a given subchannel. The request to run the
> > >>> + * channel program is sent to the subchannel, we then wait for the interrupt
> > >>> + * signaling completion of the I/O operation(s) performed by the channel
> > >>> + * program. Lastly we verify that the i/o operation completed without error and
> > >>> + * that the interrupt we received was for the subchannel used to run the
> > >>> + * channel program.
> > >>> + *
> > >>> + * Note: This function assumes it is running in an environment where no other
> > >>> + * cpus are generating or receiving I/O interrupts. So either run it in a
> > >>> + * single-cpu environment or make sure all other cpus are not doing I/O and
> > >>> + * have I/O interrupts masked off.
> > >>> + */
> > >>> +int do_cio(SubChannelId schid, uint32_t ccw_addr, int fmt)
> > >>> +{
> > >>> +    CmdOrb orb = {};
> > >>> +    Irb irb = {};
> > >>> +    sense_data_eckd_dasd sd;
> > >>> +    int rc, retries = 0;
> > >>> +
> > >>> +    IPL_assert(fmt == 0 || fmt == 1, "Invalid ccw format");
> > >>> +
> > >>> +    /* ccw_addr must be <= 24 bits and point to at least one whole ccw. */
> > >>> +    if (fmt == 0) {
> > >>> +        IPL_assert(ccw_addr <= 0xFFFFFF - 8, "Invalid ccw address");
> > >>> +    }
> > >>> +
> > >>> +    orb.fmt = fmt ;
> > >>> +    orb.pfch = 1;  /* QEMU's cio implementation requires prefetch */
> > >>> +    orb.c64 = 1;   /* QEMU's cio implementation requires 64-bit idaws */
> > >>> +    orb.lpm = 0xFF; /* All paths allowed */
> > >>> +    orb.cpa = ccw_addr;
> > >>> +
> > >>> +    while (true) {
> > >>> +        rc = ssch(schid, &orb);
> > >>> +        if (rc == 1) {
> > >>> +            /* Status pending, not sure why. Let's eat the status and retry. */
> > >>> +            tsch(schid, &irb);
> > >>> +            retries++;
> > >>> +            continue;
> > >>> +        }
> > >>> +        if (rc) {
> > >>> +            print_int("ssch failed with rc=", rc);
> > >>> +            break;
> > >>> +        }
> > >>> +
> > >>> +        consume_io_int();
> > >>> +
> > >>> +        /* collect status */
> > >>> +        rc = tsch(schid, &irb);
> > >>> +        if (rc) {
> > >>> +            print_int("tsch failed with rc=", rc);
> > >>> +            break;
> > >>> +        }
> > >>> +
> > >>> +        if (!irb_error(&irb)) {
> > >>> +            break;
> > >>> +        }
> > >>> +
> > >>> +        /*
> > >>> +         * Unexpected unit check, or interface-control-check. Use sense to
> > >>> +         * clear unit check then retry.
> > >>> +         */
> > >>> +        if ((unit_check(&irb) || iface_ctrl_check(&irb)) && retries <= 2) {
> > >>> +            basic_sense(schid, &sd, sizeof(sd));  
> > >>
> > >> We are using basic sense to clear any unit check or ifcc, but is it
> > >> possible for the basic sense to cause another unit check?
> > >>
> > >> The chapter on Basic Sense in the Common I/O Device Commands
> > >> (http://publibz.boulder.ibm.com/support/libraryserver/FRAMESET/dz9ar501/2.1?SHELF=&DT=19920409154647&CASE=)
> > >>    says this:
> > >>
> > >> ""
> > >> The basic sense command initiates a sense operation  at  all  devices
> > >> and cannot  cause  the  command-reject,  intervention-required,
> > >> data-check, or overrun bit to be set to one.  If the control unit
> > >> detects  an  equipment malfunction  or  invalid  checking-block  code
> > >> (CBC) on the sense-command code, the equipment-check or bus-out-check
> > >> bit is set  to  one,  and  unit check is indicated in the device-status
> > >> byte.
> > >> ""
> > >>
> > >> If my understanding is correct, if there is an equipment malfunction
> > >> then the control unit can return a unit check even for a basic sense.
> > >> This can lead to infinite recursion in the bios.  
> > > 
> > > I think the retries variable is supposed to take care of that.
> > >   
> > 
> > If I understand the code correctly, the retries variable cannot prevent 
> > infinite recursion. Because every time we get a unit check we do a basic 
> > sense which calls the do_cio function again. If that basic sense returns 
> > a unit check we do another basic sense....
> 
> Eww, you're right...
> 
> I think that the routine needs to be split:
> - inner routine that does the ssch, retries if the subchannel is status
>   pending, and waits for a final status (regardless whether it is a
>   special condition or not)
> - outer routine that does error handling, if needed (like retrying on
>   IFCC, or doing a basic sense on unit check)
> 
> The inner routine will probably only be called by the outer routine
> (and not directly by other code).
> 
> Does that make sense? It's hopefully enough; we really don't want to
> transplant the whole Linux cio state machine into the bios...
> 

IMHO we should orient ourselves after the corresponding section in the
PoP. We do have this reset notification we have to work around though,
but for that one sense and retry should work.

Regards,
Halil
