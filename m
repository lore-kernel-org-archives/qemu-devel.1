Received: from eggs.gnu.org ([2001:4830:134:3::10]:55278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ffh4q-0008O2-Rl
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 03:40:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ffh4n-00014n-Mw
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 03:40:48 -0400
Date: Wed, 18 Jul 2018 09:40:39 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180718094039.3271a216.cohuck@redhat.com>
In-Reply-To: <a00e445e-f8f5-b098-bccb-7fcaf1260402@redhat.com>
References: <1530811543-6881-1-git-send-email-jjherne@linux.ibm.com>
	<1530811543-6881-15-git-send-email-jjherne@linux.ibm.com>
	<a00e445e-f8f5-b098-bccb-7fcaf1260402@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [RFC 14/15] s390-bios: Support
 booting from real dasd device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: "Jason J. Herne" <jjherne@linux.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, pasic@linux.ibm.com, bjsdjshi@linux.ibm.com, borntraeger@de.ibm.com

On Tue, 17 Jul 2018 22:43:27 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 05.07.2018 19:25, Jason J. Herne wrote:

> > +*****************************************
> > +***** How this all pertains to Qemu *****
> > +*****************************************
> > +
> > +In theory we should merely have to do the following to IPL/boot a guest
> > +operating system from a DASD device:
> > +
> > +1. Place a "Read IPL" ccw into memory location 0x0 with chaining bit on.
> > +2. Execute channel program at 0x0.
> > +3. LPSW 0x0.
> > +
> > +However, our emulation of the machine's channel program logic is missing one key
> > +feature that is required for this process to work: non-prefetch of ccw data.
> > +
> > +When we start a channel program we pass the channel subsystem parameters via an
> > +ORB (Operation Request Block). One of those parameters is a prefetch bit. If the
> > +bit is on then Qemu is allowed to read the entire channel program from guest
> > +memory before it starts executing it. This means that any channel commands that
> > +read additional channel commands will not work as expected because the newly
> > +read commands will only exist in guest memory and NOT within Qemu's channel
> > +subsystem memory. Qemu's channel subsystem's implementation currently requires
> > +this bit to be on for all channel programs. This is a problem because the IPL
> > +process consists of transferring control from the "Read IPL" ccw immediately to
> > +the IPL1 channel program that was read by "Read IPL".
> > ++  
> 
> I have way too little insight into channel devices and how QEMU
> implements them, however I wonder what hinders us from implementing
> support for !prefetch in QEMU?
> 
> What you tailored here seems impressive :) Just want to know what the
> technical background of this prefetch thingy in QEMU is.

This has to do with how vfio-ccw processes and translates channel
programs.

Currently, we hand over the chain of channel commands to the kernel to
be translated (guest->host addresses) and to execute ssch on the real
subchannel. However, this requires sending the channel program over in
one go, which makes it impossible for the guest to modify an in-flight
channel program (there are tricks like putting a suspend marker on a
channel command and moving that marker forward as you go which make it
possible to know that a channel command has not yet been processed;
IIRC the lcs driver in Linux does that, or at least used to do that).
Our implementation currently does not accommodate that (the Linux dasd
driver does not use that feature). It's not impossible to implement it,
but it would require some effort (and I don't think anybody currently
has spare time for that...)
