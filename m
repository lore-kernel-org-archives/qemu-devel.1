Received: from eggs.gnu.org ([2001:4830:134:3::10]:53165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e4Mjo-0008RR-6P
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 03:56:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e4Mjl-0003ic-2y
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 03:56:32 -0400
Date: Tue, 17 Oct 2017 09:56:24 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171017095624.523fdc7b.cohuck@redhat.com>
In-Reply-To: <bc948ac4-6efd-63e2-35e3-e7be6c656536@linux.vnet.ibm.com>
References: <1507729193-9747-1-git-send-email-jjherne@linux.vnet.ibm.com>
	<20171016154433.246fb264.cohuck@redhat.com>
	<bc948ac4-6efd-63e2-35e3-e7be6c656536@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] s390x/event-facility: variable-length
 event masks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Jason J. Herne" <jjherne@linux.vnet.ibm.com>
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

On Mon, 16 Oct 2017 13:11:19 -0400
"Jason J. Herne" <jjherne@linux.vnet.ibm.com> wrote:

> On 10/16/2017 09:44 AM, Cornelia Huck wrote:
> > On Wed, 11 Oct 2017 09:39:53 -0400
> > "Jason J. Herne" <jjherne@linux.vnet.ibm.com> wrote:  
> >> ...  
> > 
> > Out of curiousity: Do you have a guest that can verify this for mask
> > lengths != 4? Given that the guest I wrote that one for back then is
> > not publicly available...
> >   
> 
> I do have a guest OS that exercises larger mask lengths. Nothing 
> publicly available however.

Great. I have verified that this works with Linux under tcg as well.

> 
> >> ...
> >>   static void write_event_mask(SCLPEventFacility *ef, SCCB *sccb)
> >>   {
> >>       WriteEventMask *we_mask = (WriteEventMask *) sccb;
> >> +    uint16_t mask_length = be16_to_cpu(we_mask->mask_length);
> >> +    uint32_t tmp_mask;
> >>   
> >> -    /* Attention: We assume that Linux uses 4-byte masks, what it actually
> >> -       does. Architecture allows for masks of variable size, though */
> >> -    if (be16_to_cpu(we_mask->mask_length) != 4) {
> >> +    if (!mask_length || (mask_length > SCLP_EVENT_MASK_LEN_MAX)) {
> >>           sccb->h.response_code = cpu_to_be16(SCLP_RC_INVALID_MASK_LENGTH);
> >>           goto out;
> >>       }
> >>   
> >> +    /*
> >> +     * Note: We currently only support masks up to 4 byte length;
> >> +     *       the remainder is filled up with zeroes. Linux uses
> >> +     *       a 4 byte mask length.
> >> +     */  
> > 
> > Do you have any plans for extending this? Or is there no need?
> > 
> > (I have to ask those questions, as the documentation is not publicly
> > available...)
> >   
> 
> As of right now 4B is all that is actually needed for any of the masks. 
> The reason to allow for 32 byte requests is for guest operating systems 
> who are already planning for the future. Someday more than 4B may be 
> used but we have no way to know if or when.

It should not be hard to extend the masks on top of this patch, I
think. Let's see what comes.

> 
> >> ...  
> > 
> > Patch looks reasonable as far as I can see (the documentation issue
> > again...)
> > 
> > Did you need to change much from the original patch?
> >   
> 
> Very little. Just a quick forward fit and test and all is well :)
> Thanks for the original work. This saved me some time.

You're welcome :)
