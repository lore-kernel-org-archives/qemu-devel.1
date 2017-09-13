Received: from eggs.gnu.org ([2001:4830:134:3::10]:47318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ds3xS-00052J-Px
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 05:27:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ds3xP-0008NU-KK
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 05:27:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42464)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ds3xP-0008ME-AB
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 05:27:43 -0400
Date: Wed, 13 Sep 2017 11:27:38 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170913112738.40e20115.cohuck@redhat.com>
In-Reply-To: <634ee6a4-535c-f342-b1ea-0ceb92abc9a1@linux.vnet.ibm.com>
References: <20170908152446.14606-1-pasic@linux.vnet.ibm.com>
	<20170908152446.14606-5-pasic@linux.vnet.ibm.com>
	<20170911120722.17236996.cohuck@redhat.com>
	<81215214-82a2-801f-3b5b-f649726f00c6@linux.vnet.ibm.com>
	<20170912163724.08a73a63.cohuck@redhat.com>
	<5b0495da-df9b-22b5-afc4-66b6a4f33122@linux.vnet.ibm.com>
	<20170912175922.6724712f.cohuck@redhat.com>
	<634ee6a4-535c-f342-b1ea-0ceb92abc9a1@linux.vnet.ibm.com>
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

On Tue, 12 Sep 2017 19:19:56 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> On 09/12/2017 05:59 PM, Cornelia Huck wrote:
> > On Tue, 12 Sep 2017 17:43:03 +0200
> > Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> >   
> >> On 09/12/2017 04:37 PM, Cornelia Huck wrote:  
> >>> On Mon, 11 Sep 2017 13:36:29 +0200
> >>> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> >>>     
> >>>> On 09/11/2017 12:07 PM, Cornelia Huck wrote:    
> >>>>> On Fri,  8 Sep 2017 17:24:46 +0200
> >>>>> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> >>>>>       
> >>>>>> We report incorrect length via SCSW program check instead of incorrect
> >>>>>> length check (SCWS word 2 bit 10 instead of bit 9). Since we have there
> >>>>>> is no fitting errno for incorrect length, and since I don't like what we
> >>>>>> do with the errno's, as part of the fix, errnos used for control flow in
> >>>>>> ccw interpretation are replaced with an enum using more speaking names.      
> >>>>>
> >>>>> I'm not sure whether this is the way to go. I mainly dislike the size
> >>>>> of the patch (and the fact that it mixes a fix and a change of function
> >>>>> signature).      
> >>>>
> >>>> Do you agree that we should move away from POSIX errno codes? I think
> >>>> if we do, this cant' get much smaller.    
> >>>
> >>> I'm not really a fan of defining our own return values, tbh.
> >>>     
> >>
> >> I've suspected. But your statement, although being useful, does
> >> not answer my question. I think we need to agree on this question
> >> before proceeding.
> >>
> >> In my opinion both the EIO bug and this bug are great examples
> >> why the POSIX errno codes are sub-optimal and misleading, but
> >> that's my opinion.  
> > 
> > It depends. I prefer them over home-grown ones.
> > 
> > (And I tend to dislike absolute statements.)
> >   
> 
> Ah, we may have a misunderstanding here. POSIX errno codes are great
> if they are used for what they are supposed to. The context was meant
> to be implicitly included in the statement limiting it's scope.
> 
> Other than spotting a possible misunderstanding (I hope I did
> not misunderstand what do you mean by absolute statements myself) this
> did not bring me any further.

As said, I'd probably prefer the alternative approach, as I'm not
really a fan of defining a set of return codes.


> >>>>>> For virtio, if incorrect length checking is suppressed we keep the
> >>>>>> current behavior (channel-program check).      
> >>>>>
> >>>>> Confused. If it is suppressed, there should not be an error, no?      
> >>>>
> >>>> No.
> >>>>
> >>>> From VIRTIO 1.0 4.3.1.2  Device Requirements: Basic Concepts
> >>>>
> >>>> "If a driver did suppress length checks for a channel command, the device
> >>>> MUST present a check condition if the transmitted data does not contain
> >>>> enough data to process the command."
> >>>> (http://docs.oasis-open.org/virtio/virtio/v1.0/cs04/virtio-v1.0-cs04.html#x1-1230001)
> >>>>
> >>>> So for virtio we have to present a check condition. Architecturally it
> >>>> might look better if the one refusing is the device and not the CSS, but
> >>>> for that we would have to change the VIRTIO spec. With the given
> >>>> constraints a program check is IMHO the best fit.    
> >>>
> >>> Ah, but that's not general length checking for virtio-ccw :)    
> >>
> >> What is general length checking for virtio-ccw? Did I say it
> >> was general length checking for virtio-ccw?  
> > 
> > Hm? Generally, suppressing is supposed to allow incorrect length
> > specifications. For virtio-ccw, that only applies to 'too much' and not
> > 'not enough'.
> > 
> > Also, reading the statement in the spec: It only talks about a 'check
> > condition', not _which_ one - so there's no requirement to keep a
> > channel-program check (other than possibly confusing guests)?
> >   
> .
> You are right, and I was wrong. We could also present an unit-check
> (that's also check  -- and is the only one in device status. The spec
> even says the 'device must present', although I device is in virtio sense
> and not in PoP sense here, and does not use 'present subchannel status'
> as in the previous sentence.  For a unit check I would have expected the
> some sense bit specified to though (like it's specified that under
> certain conditions we have to do an unit check with a command reject
> (that is sense bit 0). What shall we do in your opinion?

Whatever matches both the architecture and the qemu code flow best ;)

If we can present an incorrect-length check on short data even with
suppression set, that seems like the most consistent one.

Else I would keep the current behaviour. Defining a sense bit (we'd
need to spec that) seems like overkill to me.
