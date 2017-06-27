Received: from eggs.gnu.org ([2001:4830:134:3::10]:57487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dPv9y-0003zD-Eb
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 14:24:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dPv9x-0007Ma-IE
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 14:24:22 -0400
References: <20170627163145.GC4792@noname.redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <612358d1-4be0-7118-0e88-d5fce2b19d18@redhat.com>
Date: Tue, 27 Jun 2017 14:24:12 -0400
MIME-Version: 1.0
In-Reply-To: <20170627163145.GC4792@noname.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [RFC] QMP design: Fixing query-block
 and friends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: armbru@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com, mreitz@redhat.com



On 06/27/2017 12:31 PM, Kevin Wolf wrote:
> Hi,
> 
> I haven't really liked query-block for a long time, but now that
> blockdev-add and -blockdev have settled, it might finally be the time to
> actually do something about it. In fact, if used together with these
> modern interfaces, our query commands are simply broken, so we have to
> fix something.
> 

[...words...]

> 
> So how do we go forward from here?
> 
> I guess we could add a few hacks o fix the really urgent things, and
> just adding more information is always possible (at the cost of even
> more duplication).
> 

I think you've included this suggestion so that you can summarily
dismiss it as foolish.

> However, it appears to me that I dislike so many thing about our current
> query commands that I'm tempted to say: Throw it all away and start
> over.
> 

Inclined to agree. The structure of the block layer has changed so much
in the past few years and this is easily seen by the gap you've outlined
here.

We have to keep the old query commands around for a while as Eric says,
but I worry that they are so wrong and misleading as to be actively harmful.

Maybe there's some hair trigger somewhere that if $NEW_FEATURE_X is used
to configure QEMU in some way, that the old commands can be deprecated
at runtime, such that we can more aggressively force their retirement.

> If that's what we're going to do, I think I can figure out something
> nice for block nodes. That shouldn't be too hard. The only question
> would be whether we want a command to query one node or whether we would
> keep returning all of them.
> 

Personally in favor of allowing filtering, as an option. I don't see why
we couldn't, or why it would be a problem, or worse in any way.

> I am, however, a bit less confident about BBs. As I said above, I
> consider them part of the qdev devices. As far as I know, there is no
> high-level infrastructure to query runtime state of devices and qdev
> properties are supposed to be read-only. Maybe non-qdev QOM properties
> can be used somehow? But QOM isn't really nice to use as you need to
> query each property individually.
> 
> Another option would be to have a QMP command that takes a qdev ID of a
> block device and queries its BB. Or maybe it should stay like
> query-block and return an array of all of them, but include the qdev
> device name. Actually, maybe query-block can stay as it contains only
> two fields that are useless in the new world.
> 
> 
> I think this has become long enough now, so any opinions? On anything I
> said above, but preferably also about what a new interface should look
> like?
> 

Sadly (for you, if you want advice) you're probably in the best shape to
decide such a thing. I like the idea of being able to query parts of the
tree on a per-device basis, as I think this likely reflects real world
usage the most.

"I want to do a thing to /dev/sda... what are the backends I am dealing
with for that?"

I think that's probably most along the "QMP command that takes a qdev
ID" option that you proposed.

> Kevin
> 
