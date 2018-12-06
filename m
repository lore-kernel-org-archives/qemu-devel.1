Received: from eggs.gnu.org ([2001:4830:134:3::10]:57384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gUt5N-0005DQ-Ph
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 07:49:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gUt5J-0001Th-Do
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 07:48:57 -0500
Date: Thu, 6 Dec 2018 13:48:42 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181206134842.6fbfe6d3.cohuck@redhat.com>
In-Reply-To: <20181206133239.5e5b5cb3@oc2783563651>
References: <20181205145131.28467-1-cohuck@redhat.com>
	<0d97dcf5-de40-3f18-64fc-7b2eb1799a84@redhat.com>
	<20181205174508.3e2452af.cohuck@redhat.com>
	<55928716-cd64-735b-ae66-64b370997e22@de.ibm.com>
	<6b238b89-f1a0-834b-b2f4-3b8c30c484a2@redhat.com>
	<20181206133239.5e5b5cb3@oc2783563651>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC] vfio-ap: flag as compatible with
 balloon
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: David Hildenbrand <david@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Tony Krowiak <akrowiak@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, Alex Williamson <alex.williamson@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

On Thu, 6 Dec 2018 13:32:39 +0100
Halil Pasic <pasic@linux.ibm.com> wrote:

> On Thu, 6 Dec 2018 09:28:34 +0100
> David Hildenbrand <david@redhat.com> wrote:
> 
> > On 05.12.18 18:25, Christian Borntraeger wrote:  
> > > 
> > > 
> > > On 05.12.2018 17:45, Cornelia Huck wrote:  
> > >> On Wed, 5 Dec 2018 17:38:22 +0100
> > >> David Hildenbrand <david@redhat.com> wrote:
> > >>  
> > >>> On 05.12.18 15:51, Cornelia Huck wrote:  
> > >>>> vfio-ap devices do not pin any pages in the host. Therefore, they
> > >>>> are belived to be compatible with memory ballooning.
> > >>>>
> > >>>> Flag them as compatible, so both vfio-ap and a balloon can be
> > >>>> used simultaneously.
> > >>>>
> > >>>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > >>>> ---
> > >>>>
> > >>>> As briefly discussed on IRC. RFC as I do not have easy access to
> > >>>> hardware I can test this with.
> > >>>>
> > >>>> ---
> > >>>>  hw/vfio/ap.c | 8 ++++++++
> > >>>>  1 file changed, 8 insertions(+)
> > >>>>
> > >>>> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> > >>>> index 65de952f44..3bf48eed28 100644
> > >>>> --- a/hw/vfio/ap.c
> > >>>> +++ b/hw/vfio/ap.c
> > >>>> @@ -104,6 +104,14 @@ static void vfio_ap_realize(DeviceState *dev, Error **errp)
> > >>>>      vapdev->vdev.name = g_strdup_printf("%s", mdevid);
> > >>>>      vapdev->vdev.dev = dev;
> > >>>>  
> > >>>> +    /*
> > >>>> +     * vfio-ap devices are believed to operate in a way compatible with
> > >>>> +     * memory ballooning, as no pages are pinned in the host.
> > >>>> +     * This needs to be set before vfio_get_device() for vfio common to
> > >>>> +     * handle the balloon inhibitor.
> > >>>> +     */
> > >>>> +    vapdev->vdev.balloon_allowed = true;
> > >>>> +
> > >>>>      ret = vfio_get_device(vfio_group, mdevid, &vapdev->vdev, &local_err);
> > >>>>      if (ret) {
> > >>>>          goto out_get_dev_err;
> > >>>>     
> > >>>
> > >>> What happens if this ever changes? Shouldn't we have an API to at least
> > >>> check what the vfio device can guarantee?
> > >>>
> > >>> "are believed to operate" doesn't sound like guarantees to me :)  
> > > 
> > > I would actually remove that comment or fix it. We either know or we dont.
> > > In the way vfio-works I see no reason to disallow balloon. Even if the guest does
> > > something wrong (e.g. crypto I/O on freed pages) the host would handle that the
> > > same as it would for normal page accesses. From a host point of view the crypto
> > > instructions are just CISC instructions with load/store semantics.  
> > 
> > As long as vfio-ap does not and will never pin pages (and keep them
> > pinned), we are fine. I don't know about the details, but if vfio-ap
> > really just issues a synchronous instruction for us, we are fine.
> >   
> 
> I agree with Christian. That comment is best removed.

What about s/believed to operate/operate/?

The second part of the comment is still useful, I believe.

> 
> @Tony, I guess you should have the most elaborate test setup. Can you give
> this some testing just in case?

Actual testing would be great :)

> 
> > >   
> > >>
> > >> It's the same for ccw :)  
> 
> As a matter of fact, I don't like that comment.

Do you have a suggestion for rewording it?

> 
> Regards,
> Halil
> 
> > >>
> > >> While such an API definitely sounds like a good idea, it is probably
> > >> overkill to introduce it for this case (do we envision changing the way
> > >> vfio-ap operates in the future to make that statement non-true?)  
> > > 
> > > agreed.   
> > >>  
> > >   
> > 
> >   
> 
