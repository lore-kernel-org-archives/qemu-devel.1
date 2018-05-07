Received: from eggs.gnu.org ([2001:4830:134:3::10]:48287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fFd7u-0007Xx-9a
	for qemu-devel@nongnu.org; Mon, 07 May 2018 06:12:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fFd7p-0006S5-A6
	for qemu-devel@nongnu.org; Mon, 07 May 2018 06:12:14 -0400
Date: Mon, 7 May 2018 12:12:03 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180507121203.01ef4abd.cohuck@redhat.com>
In-Reply-To: <3597f256-cc9d-c1a2-9fa1-b8d2d1d3d3d7@linux.ibm.com>
References: <20180504131605.22816-1-cohuck@redhat.com>
	<3597f256-cc9d-c1a2-9fa1-b8d2d1d3d3d7@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] s390x/css: disabled subchannels cannot be
 status pending
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

On Fri, 4 May 2018 17:02:07 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> Could we somehow get 'fix' or something similar into the title?

Frankly, I have no idea how to do so in a readable way.

> 
> Also do we need cc stable for this? I guess this is broken
> for a while now.

The function has been like that since its introduction, but only 3270
tries to do something on non-enabled subchannels, and this is the
easiest place to fence it off. Stable probably doesn't hurt.

> 
> On 05/04/2018 03:16 PM, Cornelia Huck wrote:
> > The 3270 code will try to post an attention interrupt when the
> > 3270 emulator (e.g. x3270) attaches. If the guest has not yet
> > enabled the subchannel for the 3270 device, we will give it a
> > spurious status during msch when it does so later.  
> 
> Maybe something like 'The spurious status will preclude the successful
> execution of msch (e.g. when the guest later tries to enable
> the subchannel).' I had difficulties getting your sentence right-away.

I would have problems parsing your sentence :)

"..., we will present a spurious cc 1 (status pending) when it uses
msch on it later on, e.g. when trying to enable the subchannel."

?

> 
> > 
> > To fix this, just don't do anything in css_conditional_io_interrupt()
> > if the subchannel is not enabled. The 3270 code will work fine with
> > that, and the other user of this function (virtio-ccw) never
> > attempts to post an interrupt for a disabled device to begin with.
> >   
> 
> And I guess vfio-ccw is also unaffected, as the passed through
> stuff is going to handle this correctly on the lower levels.

Yes, vfio-ccw does not use this code path at all.

> 
> > Reported-by: Thomas Huth <thuth@redhat.com>
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>  
> 
> Overall I agree with the patch.
> 
> Acked-by: Halil Pasic <pasic@linux.ibm.com>
> 
> > ---
> >   hw/s390x/css.c | 8 ++++++++
> >   1 file changed, 8 insertions(+)
> > 
> > diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> > index 301bf1772f..56c3fa8c89 100644
> > --- a/hw/s390x/css.c
> > +++ b/hw/s390x/css.c
> > @@ -616,6 +616,14 @@ void css_inject_io_interrupt(SubchDev *sch)
> >   
> >   void css_conditional_io_interrupt(SubchDev *sch)  
> 
> Loosely related:
> What is the semantic difference between css_inject_io_interrupt and
> this css_conditional_io_interrup? The css_conditional_io_interrupt
> could be 'unsolicited' or 'virtio notification'. This function also
> relies on the serialization of io instructions or?

I introduced the "conditional interrupt" function to inject virtio
notifications. 3270 started using this interface later on. I had not
intended it to be a "generic unsolicited interrupt" interface.

> 
> Also there is this paragraph to be considered if this is indeed
> about unsolicited:
> """
> The subchannel and device status associated with
> an unsolicited interruption condition is never merged
> with that of any currently existing interruption condi-
> tion. If the subchannel is currently status pending, the
> unsolicited interruption condition is held in abeyance
> in either the channel subsystem or the device, as
> appropriate, until the status-pending condition has
> been cleared.
> """
> 
> 
> >   {
> > +    /*
> > +     * If the subchannel is not enabled, it is not made status pending
> > +     * (see PoP p. 16-17, "Status Control").
> > +     */  
> 
> In not sure about the reference. We usually don't do that or? And the page
> number may change. I would probably just drop the PoP reference.

I did not spot it immediately, that's why I added it.

> 
> > +    if (!(sch->curr_status.pmcw.flags & PMCW_FLAGS_MASK_ENA)) {
> > +        return;
> > +    }
> > +  
> 
> We don't have a scenario where the guest is expected to do some 'recovery'
> after being educated about some condition by the means of an alert-status,
> do we?

As said, this function was initially introduced for virtio
notifications, not as a generic interface.

> 
> I also wonder if this is the right place to handle the problem. The
> 3870 also manipulates scsw.dstat before calling this. And I'm not sure
> where/if is that cleared, or if it's OK to leave it set...

It's the easiest way to fix this. 3270 probably wants some review
regarding its interaction with the css as well, but that's something
for another day.
