Received: from eggs.gnu.org ([2001:4830:134:3::10]:35539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fiM6Z-0002Ob-P9
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 11:53:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fiM6W-0004eT-NK
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 11:53:35 -0400
Date: Wed, 25 Jul 2018 17:53:23 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180725155323.GD4879@localhost.localdomain>
References: <20180724200343.13733-1-lbloch@janustech.com>
	<20180724200343.13733-4-lbloch@janustech.com>
	<20180725082611.GA4879@localhost.localdomain>
	<32a32b18-0c7c-63cd-3b1d-429717b23a85@redhat.com>
	<499d5d12-cdba-76e4-3b2e-122675ef9eec@janustech.com>
	<20180725133243.GC4879@localhost.localdomain>
	<dd4a32bc-845c-f529-51a8-71c978f93861@janustech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd4a32bc-845c-f529-51a8-71c978f93861@janustech.com>
Subject: Re: [Qemu-devel] [PATCH v3 3/5] qcow2: Introduce an option for
 sufficient L2 cache for the entire image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Leonid Bloch <lbloch@janustech.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Am 25.07.2018 um 17:23 hat Leonid Bloch geschrieben:
> On 07/25/2018 04:32 PM, Kevin Wolf wrote:
> > Am 25.07.2018 um 14:32 hat Leonid Bloch geschrieben:
> > > On 07/25/2018 03:22 PM, Eric Blake wrote:
> > > 
> > >      On 07/25/2018 03:26 AM, Kevin Wolf wrote:
> > > 
> > >          Only looking at the external interface for now, I wonder whether it
> > >          would be nicer not to have two mutually exclusive options, but to make
> > >          l2-cache-size an alternate that can take either an int like before
> > >          (meaning the number of bytes) or a string/enum (with the only accepted
> > >          value "full" for now).
> > > 
> > >      That does sound interesting.
> > > 
> > > This does, but currently QEMU supports QEMU_OPT_STRING, QEMU_OPT_BOOL,
> > > QEMU_OPT_NUMBER, and QEMU_OPT_SIZE. Looks like it will require a more
> > > fundamental change to accept an option that can be either a string or a size.
> > 
> > Hm, yes, good point. We wouldn't be able to parse the options purely
> > with QemuOpts any more. So we would have to manually check for 'full' in
> > the QDict before calling qemu_opts_absorb_qdict(). If it's there, we
> > would have to process it and then delete it from the QDict before we
> > feed the QDict to qemu_opts_absorb_qdict(), which would only accept a
> > number there. A bit ugly, but should be workable.
> > 
> > Maybe this is really the time that we should convert qcow2 to use the
> > QAPI types anyway, like some of the protocol drivers do internally now.
> > Obviously, this is out of scope for this series, but it gives a
> > perspective for how to get rid of the ugliness again.
> 
> I need to look into that. Thanks for the idea. But indeed looks like
> out of scope for this series.

QAPIfication of .bdrv_open() is a long-term goal for all block drivers
anyway, so if you're really interested in this, any work towards it is
welcome. But it definitely won't be needed to get the cache size thing
in. I only mentioned it to show that we wouldn't be stuck with the
direct QDict access forever.

> > >          Another interesting question is whether 'full' shouldn't keep meaning
> > >          full throughout the lifetime of the BlockDriverState, i.e. should it
> > >          keep adapting to the new size when the image size changes?
> > > 
> > > 
> > >      Do we even resize the cache now for image size changes? If we use an enum,
> > >      we could have two different values depending on whether the chosen cache
> > >      size remains fixed or also tries to resize when the image grows.
> > 
> > We don't because we only support absolute cache sizes today. 'full'
> > would be the first one that is relative to the image size.
> > 
> > > Is it even possible to change the virtual disk image size online?
> > 
> > Yes, this is what qcow2_co_truncate() does (can be invoked, amongst
> > others, with the QMP command 'block_resize').
> 
> Cool! This does look like a good idea to resize the L2 cache accordingly,
> but maybe this is out of scope for now as well? The purpose of the current
> series is just to provide an option to automatically calculate the needed L2
> cache size for covering the entire image, instead of using an external
> script to do that and feed the output to l2-cache-size.

I'm not sure. Probably both ways can be defended, but if I as a user
said l2-cache-size=full, and then resized my 10 GB image to 20 GB, I
think I would expect that the cache still covers the whole image and not
only half of it. I never said I wanted enough cache for 10 GB, but I
said that I wanted enough cache to cover the whole image.

The thing is that once we decide not to resize the cache yet (and
document the option accordingly), it becomes ABI and we can't change
that later any more. We would have to introduce another option that
enables adaption to changed image sizes. As I don't see a reason why you
could want l2-cache-size=full, but no adaption, I'd prefer to implement
it right away.

And I think it might be as simple as adding something like this at the
end of qcow2_co_truncate():

    /* Update cache size for l2-cache-size=full */
    qcow2_update_options(bs, bs->options, s->flags, NULL);

I'm ignoring errors here because I think the resize was still successful
if we couldn't update the cache size, but that could be discussed.

> > > Found a problem with my previous patch: the property was not actually set as a
> > > proper boolean option. Also, fixing the error output in iotest 103 (thanks
> > > Kevin for the catch!). V5 is on the way.
> > 
> > Maybe give the alternate thing a try with v5, as everyone seems to agree
> > that it's a nicer interface if we can make it work.
> 
> You mean with QDict? I'll look into that now. But already sent v5 before
> reading this email.

Yes, with reading it from the QDict. (Or whatever the simplest way is
that results in the right external interface, but I suppose this is the
one.)

> > Also, a meta-comment: Leonid, would you mind sending plain text emails
> > instead of HTML-only?
> 
> Sure, Kevin! Sorry, I thought Thunderbird as configured here is sending
> plain text. I was wrong. Now it should be fine. Thanks for the remark.

Thanks, that looks better!

Kevin
