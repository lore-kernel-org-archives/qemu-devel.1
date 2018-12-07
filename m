Received: from eggs.gnu.org ([2001:4830:134:3::10]:34391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1gVINX-0005Gn-R7
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 10:49:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1gVINS-0007Ed-Jn
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 10:49:23 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38866
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1gVINS-00077y-BP
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 10:49:18 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wB7FmEw2031322
	for <qemu-devel@nongnu.org>; Fri, 7 Dec 2018 10:49:17 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2p7tc7vt8d-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 07 Dec 2018 10:49:16 -0500
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
	Fri, 7 Dec 2018 15:49:14 -0000
Date: Fri, 7 Dec 2018 16:49:09 +0100
From: Halil Pasic <pasic@linux.ibm.com>
In-Reply-To: <20181207110529.3b293124.cohuck@redhat.com>
References: <20181122165432.4437-1-cohuck@redhat.com>
	<20181204133810.66e8cfe5@oc2783563651>
	<20181204141130.06496b9b.cohuck@redhat.com>
	<20181204160236.54de2784@oc2783563651>
	<20181205135402.33c2b22d.cohuck@redhat.com>
	<20181206194714.31e9f43a@oc2783563651>
	<20181207110529.3b293124.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20181207164909.66abc005@oc2783563651>
Subject: Re: [Qemu-devel] [PATCH 0/3] vfio-ccw: support hsch/csch (kernel
 part)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: "Jason J . Herne" <jjherne@linux.ibm.com>, linux-s390@vger.kernel.org, Eric Farman <farman@linux.ibm.com>, kvm@vger.kernel.org, Pierre Morel <pmorel@linux.ibm.com>, qemu-s390x@nongnu.org, Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>

On Fri, 7 Dec 2018 11:05:29 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

[..]
> > To clarify my concern let me quote from the PoP
> > (SA22-7832-10 page 14-9):
> > 
> > """
> > If a device presents unsolicited status while the
> > associated subchannel is disabled, that status is
> > discarded by the channel subsystem without
> > generating an I/O-interruption condition. How-
> > ever, if the status presented contains unit check,
> > the channel subsystem issues the clear signal for
> > the associated subchannel and does not gener-
> > ate an I/O-interruption condition. This should be
> > taken into account when the program uses MOD-
> > IFY SUBCHANNEL to enable a subchannel. For
> > example, the medium on the associated device
> > that was present when the subchannel became
> > disabled may have been replaced, and, there-
> > fore, the program should verify the integrity of
> > that medium.
> > """
> 
> Hm, so is your concern that we might have a status (unit check) if we
> have an enabled subchannel that might not be present if the subchannel
> had been disabled all the time? Is that a problem in practice?
> 

No idea if it is a problem in practice.

> > > > 
> > > > I think Jason has discovered some problems related to this while
> > > > doing his DASD IPL with vfio-ccw work, but I don't quite remember
> > > > any more.  
> > > 
> > > cc:ing Jason, in case he remembers :)
> 
> Like in that case. Couldn't a unit check status also arrive just when
> the subchannel has been enabled, and the code therefore has to deal
> with it anyway?
> 

I assumed that programming note is there for a reason. Of course if
it can not been proven it ain't cheating. I don't remember exactly this
interacts with the rest of the architecture. In fact I asked my question,
because my feeling was that tying the virtual an the backing subchannel
together is simpler, than proving that we are fine without doing it.


> > >   
> > > > IMHO it may be possible to emulate enable/disable, but it seems way
> > > > more error prone and complicated, than letting the guest
> > > > enable/disable the host subchannel.
> > > > 
> > > > I have no idea what was the reason for going with the initial design.
> > > > I would appreciate any hints or explanations, but I'm well aware
> > > > that it was a long time ago.  
> > > 
> > > I don't really remember either, and any non-public mails from that time
> > > are inaccessible to me :(
> > > 
> > > It *might* be an artifact of the original design (which operated at the
> > > ccw_device rather than the subchannel level), though.
> > >   
> > 
> > Interesting.
> > 
> > > > > Parameters (like for channel measurements) are a different game.
> > > > > It is something we should look into, but it will need a different
> > > > > region.    
> > > > 
> > > > Yes emulation only channel measurements seem even less likely than
> > > > proper enable/disable. And 'that would need a different' region
> > > > helps me understanding the scope of async_cmd_region. Maybe we
> > > > should reconsider the comment '+ * @cmd_region: MMIO region for
> > > > asynchronous I/O commands other than START'.  
> > > 
> > > What do you think is wrong with that comment?
> > >   
> > 
> > Well msch is also an async I/O command other than START. If msch does not
> > belong here but needs it's own region, then this description seems too
> > generic.
> 
> Why do you consider msch to be async? ssch, hsch, csch all have the
> potential to cause the execution of an asynchronous (start/halt/clear)
> function, while msch just (possibly) modifies the subchannel and is
> done.
>

Right, my bad. Got confused by my Z channel io is async superstition. I
did not quite understand what async means in this context.

Regards,
Halil
