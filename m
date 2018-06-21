Received: from eggs.gnu.org ([2001:4830:134:3::10]:60848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fVzIL-0006TC-UC
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 09:06:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fVzIF-0001XC-SL
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 09:06:37 -0400
Date: Thu, 21 Jun 2018 15:06:22 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180621130622.GH5024@localhost.localdomain>
References: <cover.1528991017.git.berto@igalia.com>
	<6782db91216488e4fc1509a267a362a3f15a1aaa.1528991017.git.berto@igalia.com>
	<20180618143801.GC4667@localhost.localdomain>
	<w51in6gp213.fsf@maestria.local.igalia.com>
	<20180618161229.GD4667@localhost.localdomain>
	<w51vaaf0xnj.fsf@maestria.local.igalia.com>
	<20180619130509.GA21115@dhcp-200-186.str.redhat.com>
	<w51sh5i5047.fsf@maestria.local.igalia.com>
	<20180620105854.GC3946@localhost.localdomain>
	<w51vaadr5ys.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <w51vaadr5ys.fsf@maestria.local.igalia.com>
Subject: Re: [Qemu-devel] [RFC PATCH 06/10] block: Allow changing the
 backing file on reopen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

Am 20.06.2018 um 14:35 hat Alberto Garcia geschrieben:
> On Wed 20 Jun 2018 12:58:55 PM CEST, Kevin Wolf wrote:
> > Am 19.06.2018 um 16:20 hat Alberto Garcia geschrieben:
> >> >> Wait, I think the description I gave is inaccurate:
> >> >> 
> >> >> commit_complete() calls bdrv_drop_intermediate(), and that updates the
> >> >> backing image name (c->role->update_filename()). If we're doing this in
> >> >> an intermediate node then it needs to be reopened in read-write mode,
> >> >> while keeping the rest of the options.
> >> >> 
> >> >> But then bdrv_reopen_commit() realizes that the backing file (from
> >> >> reopen_state->options) is not the current one (because there's a
> >> >> bdrv_mirror_top implicit filter) and attempts to remove it. And that's
> >> >> the root cause of the crash.
> >> >
> >> > How did the other (the real?) backing file get into
> >> > reopen_state->options? I don't think bdrv_drop_intermediate() wants to
> >> > change anything except the read-only flag, so we should surely have
> >> > the node name of bdrv_mirror_top there?
> >> 
> >> No, it doesn't (try to) change anything else. It cannot do it:
> >> bdrv_reopen() only takes flags, but keeps the current options. And the
> >> current options have 'backing' set to a thing different from the
> >> bdrv_mirror_top node.
> >
> > Okay, so in theory this is expected to just work.
> >
> > Actually, do we ever use bdrv_reopen() for flags other than read-only?
> > Maybe we should get rid of that flags nonsense and simply make it a
> > bdrv_reopen_set_readonly() taking a boolean.
> 
> I think that's a good idea. There's however one case where other flags
> are changed: reopen_backing_file() in block/replication.c that also
> clears BDRV_O_INACTIVE. I'd need to take a closer look to that code to
> see what we can do about it.

Uh, and that works?

Clearing BDRV_O_INACTIVE with bdrv_reopen() (which means, without
calling bdrv_invalidate_cache()) is surely suspicious. Probably this
code is buggy.

Another reason for removing flags from the interface: We didn't do any
sanity checks for the flag changes.

> And there's of course qemu-io's "reopen" command, which does take
> options but keeps the previous values.

It provides -r/-w for changing readonly and -c to change the cache mode
flags. Both should be easy to convert to QDict options.

> > I think we should already remove nested options of children from the
> > dicts in bdrv_open_inherit(). I'm less sure about node-name
> > references.  Maybe instead of keeing the dicts up-to-date each time we
> > modify the graph, we should just get rid of those in the dicts as
> > well, and instead add a function that reconstructs the full dict from
> > bs->options and the currently attached children. This requires that
> > the child name and the option name match, but I think that's
> > true. (Mostly at least - what about quorum? But the child node
> > handling of quorum is broken anyway.)
> 
> Yes, removing nested options sounds like a good idea. In what cases do
> we need the full qdict, though?

Not sure, maybe we don't even need them now that we decided that the
default is leaving the reference unchanged.

There's the creation of json: filenames, maybe we need it there. We'd
also certainly need to get the full QDict if we wanted to convert the
options to a QAPI object before we pass them to the drivers.

Kevin
