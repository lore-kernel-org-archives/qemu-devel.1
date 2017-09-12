Received: from eggs.gnu.org ([2001:4830:134:3::10]:46787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1drmJg-0000bL-IQ
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 10:37:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1drmJd-0004eN-9m
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 10:37:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37472)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1drmJd-0004dk-0i
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 10:37:29 -0400
Date: Tue, 12 Sep 2017 16:37:24 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170912163724.08a73a63.cohuck@redhat.com>
In-Reply-To: <81215214-82a2-801f-3b5b-f649726f00c6@linux.vnet.ibm.com>
References: <20170908152446.14606-1-pasic@linux.vnet.ibm.com>
	<20170908152446.14606-5-pasic@linux.vnet.ibm.com>
	<20170911120722.17236996.cohuck@redhat.com>
	<81215214-82a2-801f-3b5b-f649726f00c6@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/4] s390x/css: fix incorrect length
 indication
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org

On Mon, 11 Sep 2017 13:36:29 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> On 09/11/2017 12:07 PM, Cornelia Huck wrote:
> > On Fri,  8 Sep 2017 17:24:46 +0200
> > Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> >   
> >> We report incorrect length via SCSW program check instead of incorrect
> >> length check (SCWS word 2 bit 10 instead of bit 9). Since we have there
> >> is no fitting errno for incorrect length, and since I don't like what we
> >> do with the errno's, as part of the fix, errnos used for control flow in
> >> ccw interpretation are replaced with an enum using more speaking names.  
> > 
> > I'm not sure whether this is the way to go. I mainly dislike the size
> > of the patch (and the fact that it mixes a fix and a change of function
> > signature).  
> 
> Do you agree that we should move away from POSIX errno codes? I think
> if we do, this cant' get much smaller.

I'm not really a fan of defining our own return values, tbh.

> 
> > 
> > Can we instead choose a mapping for incorrect length, and defer a
> > possible rework?
> >   
> 
> In the commit message, I say that I don't have a fitting errno.
> If you tell me which one to use, I would be glad to split this up.
> I don't like mixing re-factoring and changing behavior myself.
> 
> Can I have your position on the re-factoring (that is let us
> imagine I did not change handling for incorrect length)?

If there is no return code that can be made to fit, we probably won't
be able to get around some kind of refactoring... but then I'd prefer
to do the refactoring first and the fix second.

> 
> > (Another idea would be to have the callback prepare the scsw via helper
> > functions. We'd just keep -EAGAIN to keep processing a chain and 0 to
> > stop.)
> >   
> 
> That was my first idea how to improve on this. I should still have the
> code (patches), but I'm not sure whether it's clean or lumped together
> with other experiments.
> 
> After pushing the handling down the call chain (caller would use
> inline functions to manipulate SCSW), I've realized that it does
> not buy us much/anything expect the better names, while we get
> the machine code manipulating the SCSW generated in multiple
> instead of in one place. I also showed the results to Dong Jia and
> he was ambivalent too: said something like it does look better,
> but it ain't better enough to make it worthwhile.
> 
> This is why I've decided to go with a less intrusive approach:
> just change the names so that it's obvious what's happening.

Something like return channel_program_check(...); or so would be quite
obvious, I think.

But yes, it will be easier to evaluate this for an actual patch ;)

> >> For virtio, if incorrect length checking is suppressed we keep the
> >> current behavior (channel-program check).  
> > 
> > Confused. If it is suppressed, there should not be an error, no?  
> 
> No.
> 
> From VIRTIO 1.0 4.3.1.2  Device Requirements: Basic Concepts
> 
> "If a driver did suppress length checks for a channel command, the device
> MUST present a check condition if the transmitted data does not contain
> enough data to process the command."
> (http://docs.oasis-open.org/virtio/virtio/v1.0/cs04/virtio-v1.0-cs04.html#x1-1230001)
> 
> So for virtio we have to present a check condition. Architecturally it
> might look better if the one refusing is the device and not the CSS, but
> for that we would have to change the VIRTIO spec. With the given
> constraints a program check is IMHO the best fit.

Ah, but that's not general length checking for virtio-ccw :)

Reword the sentence to use 'short data with incorrect length checking
suppressed' or so?
