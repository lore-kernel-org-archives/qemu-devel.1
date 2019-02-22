Received: from eggs.gnu.org ([209.51.188.92]:56337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gx6Ja-0008Q2-8y
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 03:36:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gx6JX-0006gX-1u
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 03:36:12 -0500
Date: Fri, 22 Feb 2019 09:35:59 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190222093559.5334886d.cohuck@redhat.com>
In-Reply-To: <397b094e-d140-d1c3-5ced-ca2d2e0e5d8e@linux.ibm.com>
References: <1548768562-20007-1-git-send-email-jjherne@linux.ibm.com>
	<1548768562-20007-11-git-send-email-jjherne@linux.ibm.com>
	<20190204122437.58ebdba9.cohuck@redhat.com>
	<397b094e-d140-d1c3-5ced-ca2d2e0e5d8e@linux.ibm.com>
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
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, pasic@linux.ibm.com, alifm@linux.ibm.com, borntraeger@de.ibm.com

On Thu, 21 Feb 2019 13:01:40 -0500
"Jason J. Herne" <jjherne@linux.ibm.com> wrote:

> On 2/4/19 6:24 AM, Cornelia Huck wrote:
> > On Tue, 29 Jan 2019 08:29:17 -0500
> > "Jason J. Herne" <jjherne@linux.ibm.com> wrote:
(...)
> >> -#define SCSW_FCTL_CLEAR_FUNC 0x1000
> >> -#define SCSW_FCTL_HALT_FUNC 0x2000
> >> +/* Function Control */
> >>   #define SCSW_FCTL_START_FUNC 0x4000
> >> +#define SCSW_FCTL_HALT_FUNC 0x2000
> >> +#define SCSW_FCTL_CLEAR_FUNC 0x1000
> >> +
> >> +/* Activity Control */
> >> +#define SCSW_ACTL_RESUME_PEND   0x0800
> >> +#define SCSW_ACTL_START_PEND    0x0400
> >> +#define SCSW_ACTL_HALT_PEND     0x0200
> >> +#define SCSW_ACTL_CLEAR_PEND    0x0100
> >> +#define SCSW_ACTL_CH_ACTIVE     0x0080
> >> +#define SCSW_ACTL_DEV_ACTIVE    0x0040
> >> +#define SCSW_ACTL_SUSPENDED     0x0020
> >> +
> >> +/* Status Control */
> >> +#define SCSW_SCTL_ALERT         0x0010
> >> +#define SCSW_SCTL_INTERMED      0x0008
> >> +#define SCSW_SCTL_PRIMARY       0x0004
> >> +#define SCSW_SCTL_SECONDARY     0x0002
> >> +#define SCSW_SCTL_STATUS_PEND   0x0001
> >> +
> >> +/* SCSW Device Status Flags */
> >> +#define SCSW_DSTAT_ATTN     0x80
> >> +#define SCSW_DSTAT_STATMOD  0x40
> >> +#define SCSW_DSTAT_CUEND    0x20
> >> +#define SCSW_DSTAT_BUSY     0x10
> >> +#define SCSW_DSTAT_CHEND    0x08
> >> +#define SCSW_DSTAT_DEVEND   0x04
> >> +#define SCSW_DSTAT_UCHK     0x02
> >> +#define SCSW_DSTAT_UEXCP    0x01
> >> +
> >> +/* SCSW Subchannel Status Flags */
> >> +#define SCSW_CSTAT_PCINT    0x80
> >> +#define SCSW_CSTAT_BADLEN   0x40
> >> +#define SCSW_CSTAT_PROGCHK  0x20
> >> +#define SCSW_CSTAT_PROTCHK  0x10
> >> +#define SCSW_CSTAT_CHDCHK   0x08
> >> +#define SCSW_CSTAT_CHCCHK   0x04
> >> +#define SCSW_CSTAT_ICCHK    0x02
> >> +#define SCSW_CSTAT_CHAINCHK 0x01  
> > 
> > Any reason you're not following the Linux kernel definitions here?
> > Might make it easier for folks familiar with the kernel implementation.
> >   
> 
> There wasn't any real reason. I do like some of my names better as I feel that they all 
> should start with SCSW_. But in the interest of homogenizing I could change to the kernel 
> implementation. Let me know if you think its worth the time, I could go either way on it.

TBH, some of the kernel defines _are_ a bit wonky, but I'm used to
them :)

Not sure if any of the others who will look at this code are that
familiar with the kernel code, though, so I'll leave the decision to
the bios maintainers. (Your names are more consistent...)

(...)
> >> +io_new_code:
> >> +        /* disable I/O interrupts in cr6 */
> >> +        stctg 6,6,0(15)
> >> +        ni 4(15), 0x00
> >> +        lctlg 6,6,0(15)  
> > 
> > What about leaving the isc enabled in cr6 all the time and just
> > controlling interrupts via enabling/disabling I/O interrupts?
> >   
> 
> Its really all about leaving the system in as close to a default and unaltered state as 
> possible. I could just set isc sometime at the beginning of dasd ipl and clear it right 
> before transferring control, if you feel strongly about it.

Not feeling strongly. Nobody probably cares about how often you change
cr6 during load...
