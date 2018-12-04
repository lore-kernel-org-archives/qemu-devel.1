Received: from eggs.gnu.org ([208.118.235.92]:43982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1gUCDw-0006da-6i
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 10:02:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1gUCDq-0001DL-5m
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 10:02:56 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46504)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1gUCDo-0001Bn-6X
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 10:02:49 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wB4F0CTH013718
	for <qemu-devel@nongnu.org>; Tue, 4 Dec 2018 10:02:47 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2p5unw1249-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 04 Dec 2018 10:02:46 -0500
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
	Tue, 4 Dec 2018 15:02:41 -0000
Date: Tue, 4 Dec 2018 16:02:36 +0100
From: Halil Pasic <pasic@linux.ibm.com>
In-Reply-To: <20181204141130.06496b9b.cohuck@redhat.com>
References: <20181122165432.4437-1-cohuck@redhat.com>
	<20181204133810.66e8cfe5@oc2783563651>
	<20181204141130.06496b9b.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20181204160236.54de2784@oc2783563651>
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
Cc: linux-s390@vger.kernel.org, Eric Farman <farman@linux.ibm.com>, Alex Williamson <alex.williamson@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org, Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org

On Tue, 4 Dec 2018 14:11:30 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> On Tue, 4 Dec 2018 13:38:10 +0100
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
> > On Thu, 22 Nov 2018 17:54:29 +0100
> > Cornelia Huck <cohuck@redhat.com> wrote:
> > 
> > > [This is the Linux kernel part, git tree is available at
> > > https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/vfio-ccw.git vfio-ccw-caps
> > > 
> > > The companion QEMU patches are available at
> > > https://github.com/cohuck/qemu vfio-ccw-caps]
> > > 
> > > Currently, vfio-ccw only relays START SUBCHANNEL requests to the real
> > > device. This tends to work well for the most common 'good path' scenarios;
> > > however, as we emulate {HALT,CLEAR} SUBCHANNEL in QEMU, things like
> > > clearing pending requests at the device is currently not supported.
> > > This may be a problem for e.g. error recovery.  
> > 
> > I'm wondering: what about MODIFY SUBCHANNEL? Do we plan to add MSCH
> > as well or is it supposed to remain 'userspace emulated'? AFAIR MSCH
> > may have an effect on error recovery as well.
> 
> I think that would require a deeper change, as we have the requirement
> to enable the subchannel before handing it to userspace. IOW, the guest
> does not cause the subchannel to be enabled/disabled, but the host does.
> 

My point is, when the subchannel is disabled, 'firmware' is responsible
for suppressing interrupts and error conditions, and also for
doing the appropriate recovery procedure, so to say under the hood.

I think Jason has discovered some problems related to this while doing
his DASD IPL with vfio-ccw work, but I don't quite remember any more.

IMHO it may be possible to emulate enable/disable, but it seems way more
error prone and complicated, than letting the guest enable/disable the
host subchannel.

I have no idea what was the reason for going with the initial design.
I would appreciate any hints or explanations, but I'm well aware that it
was a long time ago.


> Parameters (like for channel measurements) are a different game. It is
> something we should look into, but it will need a different region.

Yes emulation only channel measurements seem even less likely than proper
enable/disable. And 'that would need a different' region helps me
understanding the scope of async_cmd_region. Maybe we should reconsider
the comment '+ * @cmd_region: MMIO region for asynchronous I/O commands
other than START'.

> 
> > BTW I would like to have the concurrency discussion sorted out before
> > I proceed with my review, because reviewing the stuff without a fair idea
> > of what exactly are we trying to achieve would yield poor results.
> 
> I'm not sure what is unclear about what we're trying to achieve (enable
> the guest to issue halt/clear on real hardware)?

Yeah, that is perfectly clear, but it ain't the complete story. E.g.
are subsequent commands blocking until the preceding command finishes
is part of the interface. And what is good implementation depends on the
answer. What I mean, I first need to understand how things are supposed
to work (together) so I can double check that against the
implementation. Otherwise all I can do is nitpicking.

To get more tangible: we are in the middle of processing an SSCH request
(e.g. doing the translation) when a HSCH comes in. What should happen?
Should we start processing HSCH after he instruction part of SSCH is
done -- which currently includes translation? Or should we -EBUSY? Or do
we abort START related activities and do the HALT stuff?


> 
> But yes, we need to sort out that concurrency thing; I'm currently
> unsure if the core should do some things as well or if it's more of a
> vendor-driver thing.
> 

By core you mean vfio-mdev core? If yes, I think it is a vendor-driver
thing: limiting concurrency for all vfio-mdev  does not make sense IMHO.

Regards,
Halil
