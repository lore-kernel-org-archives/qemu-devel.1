Received: from eggs.gnu.org ([2001:4830:134:3::10]:55387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dFMwP-0006BP-Ml
	for qemu-devel@nongnu.org; Mon, 29 May 2017 11:50:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dFMwK-0002Zu-Lw
	for qemu-devel@nongnu.org; Mon, 29 May 2017 11:50:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43010)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1dFMwK-0002Zk-BV
	for qemu-devel@nongnu.org; Mon, 29 May 2017 11:50:40 -0400
Date: Mon, 29 May 2017 17:50:36 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170529155036.GA5910@noname.redhat.com>
References: <CAJSP0QU1gHgZbeBfL1y15FL9muD4G6r3MBYvVMVXTMj=GCB7oA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJSP0QU1gHgZbeBfL1y15FL9muD4G6r3MBYvVMVXTMj=GCB7oA@mail.gmail.com>
Subject: Re: [Qemu-devel] Throttling groups vs filter nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Manos Pitsidianakis <el13635@mail.ntua.gr>, Alberto Garcia <berto@igalia.com>

Am 27.05.2017 um 09:56 hat Stefan Hajnoczi geschrieben:
> Throttling groups allow multiple drives to share the same throttling
> state (i.e. budget) between them.  Manos is working on moving the
> throttling code into a block filter driver so it is no longer
> hardcoded into the I/O code path.
> 
> Throttling groups are not defined explicitly using -object syntax.
> Instead they are brought into existence by referring to them by name:
> -drive throttling.group=group0.

We could still add -object for throttling groups if that allows us to
use a cleaner syntax.

> A quirk in the current implementation is that the throttling limits
> for the group are overwritten by each -drive throttling.group=group0.
> Limits for all but the last -drive in a group are ignored.
> 
> There is no way to associate with an existing throttling group while
> keeping current limits in place.  The caller must pass in desired
> limits with at least the last -drive (and with every hotplugged
> drive).
> 
> The new throttling filter node could do things differently:
> If *no* limits were specified (i.e. iops, bps, etc) then keep existing
> limits for the group in place.
> 
> These semantics are more convenient - especially for hotplugging
> drives after the guest has launched.
> 
> Manos: I suggest implementing this new behavior when you write the
> throttling filter driver.  The code needs to check that all throttle
> cfg fields are 0.  There are no backwards compatibility concerns since
> the throttle filter is new and existing users don't rely on it.

If we implement things this way, we shouldn't test that all fields are
0, but that the limits are simply not given. In QAPI, I think we get
something like this then:

{ 'struct': 'BlockdevOptionsThrottle',
  'data': { 'image': 'BlockdevRef',
            '*limits': 'ThrottleLimits',
            '*group': 'str' } }

Callers must either pass 'limits' or 'group', but formally they are both
optional. The first time that a group is referenced, giving limits as
well is mandatory, afterwards it is forbidden.

If we use a separate QOM object with -object, it always becomes either
limits or groups, i.e. we could use a QAPI union here.


Another interesting question is how the limits are updated after
creating the first throttle node of the group. With -object, I guess
this would simply become qom-set commands.

Without it, we would probably want to use bdrv_reopen() - with some
strange effects like bdrv_reopen() of one throttle node affecting other
throttle nodes, even though their bs->options/explicit_options don't
represent this. Another bdrv_reopen() on a second throttling node, even
if it just wants to update some unrelated option, say 'read-only', could
end up switching throttling back to old configuration values as they are
recorded in that other node's bs->options. Requiring that limits can
only be changed via the node that initially created the group isn't a
solution either because it could have been closed while the throttle
group is still in use by different images.

After writing this, my gut feeling is that -object might well be worth
it.

Kevin
