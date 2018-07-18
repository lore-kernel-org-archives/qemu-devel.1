Received: from eggs.gnu.org ([2001:4830:134:3::10]:43747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ffkkF-0007N8-9Y
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 07:35:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ffkkA-00082L-8I
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 07:35:47 -0400
Date: Wed, 18 Jul 2018 13:35:37 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180718133537.26dfeffa.cohuck@redhat.com>
In-Reply-To: <066430cc-7ab0-839e-0cc9-7cdda027c253@linux.ibm.com>
References: <1530811543-6881-1-git-send-email-jjherne@linux.ibm.com>
	<1530811543-6881-15-git-send-email-jjherne@linux.ibm.com>
	<a00e445e-f8f5-b098-bccb-7fcaf1260402@redhat.com>
	<20180718094039.3271a216.cohuck@redhat.com>
	<066430cc-7ab0-839e-0cc9-7cdda027c253@linux.ibm.com>
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
To: Halil Pasic <pasic@linux.ibm.com>
Cc: David Hildenbrand <david@redhat.com>, "Jason J. Herne" <jjherne@linux.ibm.com>, qemu-devel@nongnu.org, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, bjsdjshi@linux.ibm.com

On Wed, 18 Jul 2018 12:55:51 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> On 07/18/2018 09:40 AM, Cornelia Huck wrote:
> > On Tue, 17 Jul 2018 22:43:27 +0200
> > David Hildenbrand <david@redhat.com> wrote:
> >   
> >> On 05.07.2018 19:25, Jason J. Herne wrote:  
> >   
> >>> +*****************************************
> >>> +***** How this all pertains to Qemu *****
> >>> +*****************************************
> >>> +
> >>> +In theory we should merely have to do the following to IPL/boot a guest
> >>> +operating system from a DASD device:
> >>> +
> >>> +1. Place a "Read IPL" ccw into memory location 0x0 with chaining bit on.
> >>> +2. Execute channel program at 0x0.
> >>> +3. LPSW 0x0.
> >>> +
> >>> +However, our emulation of the machine's channel program logic is missing one key
> >>> +feature that is required for this process to work: non-prefetch of ccw data.
> >>> +
> >>> +When we start a channel program we pass the channel subsystem parameters via an
> >>> +ORB (Operation Request Block). One of those parameters is a prefetch bit. If the
> >>> +bit is on then Qemu is allowed to read the entire channel program from guest
> >>> +memory before it starts executing it. This means that any channel commands that
> >>> +read additional channel commands will not work as expected because the newly
> >>> +read commands will only exist in guest memory and NOT within Qemu's channel
> >>> +subsystem memory. Qemu's channel subsystem's implementation currently requires
> >>> +this bit to be on for all channel programs. This is a problem because the IPL
> >>> +process consists of transferring control from the "Read IPL" ccw immediately to
> >>> +the IPL1 channel program that was read by "Read IPL".
> >>> ++  
> >>
> >> I have way too little insight into channel devices and how QEMU
> >> implements them, however I wonder what hinders us from implementing
> >> support for !prefetch in QEMU?
> >>
> >> What you tailored here seems impressive :) Just want to know what the
> >> technical background of this prefetch thingy in QEMU is.  
> > 
> > This has to do with how vfio-ccw processes and translates channel
> > programs.
> > 
> > Currently, we hand over the chain of channel commands to the kernel to
> > be translated (guest->host addresses) and to execute ssch on the real
> > subchannel. However, this requires sending the channel program over in
> > one go, which makes it impossible for the guest to modify an in-flight
> > channel program (there are tricks like putting a suspend marker on a
> > channel command and moving that marker forward as you go which make it
> > possible to know that a channel command has not yet been processed;
> > IIRC the lcs driver in Linux does that, or at least used to do that).
> > Our implementation currently does not accommodate that (the Linux dasd
> > driver does not use that feature). It's not impossible to implement it,
> > but it would require some effort (and I don't think anybody currently
> > has spare time for that...)  
> 
> 
> I disagree, IMHO we can not implement generic support for !prefetch in
> vfio-ccw with what we have at our disposal at the abstraction level we
> are currently working on. (If we were to abandon using IO instructions
> in the host but rely on lower level protocols like FC it may be possible,
> I don't want to make a statement about that).
> 
> The problem is the address translation. If the channel program reads
> something that is going to be used as a ccw by the same (e.g. CCW-IPL)
> the address within that ccw that was read is a guest-physical address.
> 
> We however need to translate the addresses in the guest ccws (and in the
> (m)idaw's) too before these get executed as a part of a host channel
> program. And because the address of the ccws themselves needs to be
> 31 bit addressable in host physical we actually copy the channel program
> form guest memory to suitable host memory in the vfio-ccw driver.
> 
> So to translate the new stuff we would actually have to stop the channel
> program and resubmit the rest (either by suspend+resume or by break
> chaining+ssch). The problem with that an execution of a channel program
> that is composed of four ccws A,B,C,D and an execution of a channel
> programs composed of ccws A,B immediately followed by and execution
> of a channel program composed of the ccws C,D is not the same. I.e. it
> is not generally safe to break a chain of ccws.

Exploiting suspending would have been my idea. Probably combined with a
new interface that fetches ccw-by-ccw.

But I don't think it makes sense to spend time thinking about this
right now.

> 
> If you still think it's possible to implement !prefetch, could you please
> explain your idea.
> 
> Regards,
> Halil
> 
