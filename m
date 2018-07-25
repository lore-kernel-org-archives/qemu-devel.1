Received: from eggs.gnu.org ([2001:4830:134:3::10]:36596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fiJuS-0008Rr-1d
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 09:32:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fiJuP-0001eN-2H
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 09:32:56 -0400
Date: Wed, 25 Jul 2018 15:32:43 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180725133243.GC4879@localhost.localdomain>
References: <20180724200343.13733-1-lbloch@janustech.com>
	<20180724200343.13733-4-lbloch@janustech.com>
	<20180725082611.GA4879@localhost.localdomain>
	<32a32b18-0c7c-63cd-3b1d-429717b23a85@redhat.com>
	<499d5d12-cdba-76e4-3b2e-122675ef9eec@janustech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <499d5d12-cdba-76e4-3b2e-122675ef9eec@janustech.com>
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

Am 25.07.2018 um 14:32 hat Leonid Bloch geschrieben:
> On 07/25/2018 03:22 PM, Eric Blake wrote:
> 
>     On 07/25/2018 03:26 AM, Kevin Wolf wrote:
> 
>         Only looking at the external interface for now, I wonder whether it
>         would be nicer not to have two mutually exclusive options, but to make
>         l2-cache-size an alternate that can take either an int like before
>         (meaning the number of bytes) or a string/enum (with the only accepted
>         value "full" for now).
> 
>     That does sound interesting.
> 
> This does, but currently QEMU supports QEMU_OPT_STRING, QEMU_OPT_BOOL,
> QEMU_OPT_NUMBER, and QEMU_OPT_SIZE. Looks like it will require a more
> fundamental change to accept an option that can be either a string or a size.

Hm, yes, good point. We wouldn't be able to parse the options purely
with QemuOpts any more. So we would have to manually check for 'full' in
the QDict before calling qemu_opts_absorb_qdict(). If it's there, we
would have to process it and then delete it from the QDict before we
feed the QDict to qemu_opts_absorb_qdict(), which would only accept a
number there. A bit ugly, but should be workable.

Maybe this is really the time that we should convert qcow2 to use the
QAPI types anyway, like some of the protocol drivers do internally now.
Obviously, this is out of scope for this series, but it gives a
perspective for how to get rid of the ugliness again.

>         Another interesting question is whether 'full' shouldn't keep meaning
>         full throughout the lifetime of the BlockDriverState, i.e. should it
>         keep adapting to the new size when the image size changes?
> 
> 
>     Do we even resize the cache now for image size changes? If we use an enum,
>     we could have two different values depending on whether the chosen cache
>     size remains fixed or also tries to resize when the image grows.

We don't because we only support absolute cache sizes today. 'full'
would be the first one that is relative to the image size.

> Is it even possible to change the virtual disk image size online?

Yes, this is what qcow2_co_truncate() does (can be invoked, amongst
others, with the QMP command 'block_resize').

> Found a problem with my previous patch: the property was not actually set as a
> proper boolean option. Also, fixing the error output in iotest 103 (thanks
> Kevin for the catch!). V5 is on the way.

Maybe give the alternate thing a try with v5, as everyone seems to agree
that it's a nicer interface if we can make it work.

Also, a meta-comment: Leonid, would you mind sending plain text emails
instead of HTML-only?

Kevin
