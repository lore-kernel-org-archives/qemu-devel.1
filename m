Received: from eggs.gnu.org ([2001:4830:134:3::10]:58878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fimjA-0004Ee-MS
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 16:19:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fimj9-0006d2-IC
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 16:19:12 -0400
Date: Thu, 26 Jul 2018 22:19:03 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180726201903.GL4215@localhost.localdomain>
References: <20180725082611.GA4879@localhost.localdomain>
	<32a32b18-0c7c-63cd-3b1d-429717b23a85@redhat.com>
	<499d5d12-cdba-76e4-3b2e-122675ef9eec@janustech.com>
	<20180725133243.GC4879@localhost.localdomain>
	<dd4a32bc-845c-f529-51a8-71c978f93861@janustech.com>
	<20180725155323.GD4879@localhost.localdomain>
	<0638cd7c-23f7-0f99-735b-c3fb3102e254@janustech.com>
	<20180726144232.GE4215@localhost.localdomain>
	<c1a93a3b-1207-99c9-fcf4-a23db8f45dcc@janustech.com>
	<05696f3c-369e-22a7-a556-d6fae22ec623@janustech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05696f3c-369e-22a7-a556-d6fae22ec623@janustech.com>
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

Am 26.07.2018 um 21:43 hat Leonid Bloch geschrieben:
> On 07/26/2018 05:50 PM, Leonid Bloch wrote:
> > On 07/26/2018 05:42 PM, Kevin Wolf wrote:
> > > Am 26.07.2018 um 14:24 hat Leonid Bloch geschrieben:
> > > > > > You mean with QDict? I'll look into that now. But
> > > > > > already sent v5 before
> > > > > > reading this email.
> > > > > 
> > > > > Yes, with reading it from the QDict. (Or whatever the simplest way is
> > > > > that results in the right external interface, but I suppose this is the
> > > > > one.)
> > > > 
> > > > Well, there is a problem with that: I can easily isolate
> > > > l2-cache-size from QDict, check if it is "full", and if it is -
> > > > do whatever
> > > > is needed, and delete this option before parsing. But what if it
> > > > is "foo"?
> > > > It will not get deleted, and the regular QEMU_OPT_SIZE parsing
> > > > error will
> > > > appear, stating that l2-cache-size "expects a non-negative
> > > > number..." - no
> > > > word about that it can expect "full" as well. Now, one can try to modify
> > > > local_err->msg for this particular option, but this will require
> > > > substantial
> > > > additional logic. I think considering this, it would be easier
> > > > to stick with
> > > > a dedicated option, l2-cache-full.
> > > > 
> > > > Do you think there is a smarter way to parse the l2-cache-size
> > > > option, so it
> > > > would accept both size and "full", while handling errors
> > > > correctly? It seems
> > > > more elegant to have a single option, but the internal handling
> > > > will be more
> > > > elegant and simpler with two mutually exclusive options.
> > > 
> > > I think we can live with the suboptimal error message for a while. Once
> > > qcow2 is QAPIfied, it should become easy to improve it. Let's not choose
> > > a worse design (that stays forever) for a temporarily better error
> > > message.
> > 
> > OK. I'll add a TODO then.
> 
> Another problem without a dedicated option, is that if l2-cache-size is
> processed and deleted, it can not be read again when needed for resizing.
> Without some *extremely* dirty tricks, that is.

Are you sure? The way that the .bdrv_open() callbacks work, _all_
options that are processed are removed from the QDict. The difference is
just whether qemu_opts_absorb_qdict() removes them or you do that
manually. In the end, if options are left in the QDict, the block layer
returns an error because that means that an unknown option was
specified.

I suppose you use bs->options while resizing. This is a copy of the
QDict which is not affected by the removal of processed options.

> Can QAPI be the solution? I've seen some examples, and it looks like the
> qcow2 driver already uses QAPI to some extent - I mean all the qdict stuff
> is from QAPI, no? Can you please point me to an example of how QAPI can
> solve the issue of an option that can accept both a size and a string?

By using QAPI I mean using types like BlockdevOptionsQcow2. These types
are directly generated from the JSON schema, where it's possible to
specify an alternate of a string and an integer.

One example for an alternate in the JSON schema is BlockdevRef, where
you can give a string (to reference a node-name) or an inline
declaration of a block device. In JSON, it looks like this:

    { 'alternate': 'BlockdevRef',
      'data': { 'definition': 'BlockdevOptions',
                'reference': 'str' } }

And the generated C type for it is:

    struct BlockdevRef {
        QType type;
        union { /* union tag is @type */
            BlockdevOptions definition;
            char *reference;
        } u;
    };

In our case, we would get a union of int64_t and char* instead, and
still the QType type as a discriminator.

Kevin
