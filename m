Received: from eggs.gnu.org ([2001:4830:134:3::10]:33057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dcmeO-0006B4-Pq
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 01:56:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dcmeL-0003iK-Nx
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 01:56:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41844)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dcmeL-0003i2-EH
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 01:56:53 -0400
Date: Wed, 2 Aug 2017 13:56:46 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170802055646.GE15080@pxdev.xzpeter.org>
References: <1501229198-30588-1-git-send-email-peterx@redhat.com>
	<1501229198-30588-17-git-send-email-peterx@redhat.com>
	<20170801110348.GH12670@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170801110348.GH12670@redhat.com>
Subject: Re: [Qemu-devel] [RFC 16/29] qmp: hmp: add migrate "resume" option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, Juan Quintela <quintela@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Tue, Aug 01, 2017 at 12:03:48PM +0100, Daniel P. Berrange wrote:
> On Fri, Jul 28, 2017 at 04:06:25PM +0800, Peter Xu wrote:
> > It will be used when we want to resume one paused migration.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  hmp-commands.hx       | 7 ++++---
> >  hmp.c                 | 4 +++-
> >  migration/migration.c | 2 +-
> >  qapi-schema.json      | 5 ++++-
> >  4 files changed, 12 insertions(+), 6 deletions(-)
> 
> I'm not seeing explicit info about how we handle the original failure
> and how it relates to this resume command, but this feels like a
> potentially racy approach to me.
> 
> If we have a network problem between source & target, we could see
> two results. Either the TCP stream will simply hang (it'll still
> appear open to QEMU but no traffic will be flowing),

(let's say this is the "1st condition")

> or the connection
> may actually break such that we get EOF and end up closing the file
> descriptor.

(let's say this is the "2nd condition")

> 
> In the latter case, we're ok because the original channel is now
> gone and we can safely establish the new one by issuing the new
> 'migrate --resume URI' command.
> 
> In the former case, however, there is the possibility that the
> hang may come back to life at some point, concurrently with us
> trying to do 'migrate --resume URI' and I'm unclear on the
> semantics if that happens.
> 
> Should the original connection carry on, and thus cause the
> 'migrate --resume' command to fail, or will we forcably terminate
> the original connection no matter what and use the new "resumed"
> connection.

Hmm yes, this is a good question. Currently this series is only
handling the 2nd condition, say, when we can detect the error via
system calls (IIUC we can know nothing when the 1st condition is
encountered, we just e.g. block at the system calls as usual when
reading the file handle). And currently the "resume" command is only
allowed if the 2nd condition is detected (so it will never destroy an
existing channel).

If you see the next following patch, there is something like:

    if (has_resume && resume) {
        if (s->state != MIGRATION_STATUS_POSTCOPY_PAUSED) {
            error_setg(errp, "Cannot resume if there is no "
                       "paused migration");
            return;
        }
        goto do_resume;
    }

And here MIGRATION_STATUS_POSTCOPY_PAUSED will only be set when the
2nd condition is met.

> 
> There's also synchronization with the target host - at the time we
> want to recover, we need to be able to tell the target to accept
> new incoming clients again, but we don't want to do that if the
> original connection comes back to life.

Yeah, I hacked this part in this v1 series (as you may have seen) to
keep the ports open-forever. I am not sure whether that is acceptable,
but looks not. :)

How about this: when destination detected 2nd condition, it firstly
switch to "postcopy-pause" state, then re-opens the accept channels.
And it can turns the accept channels off when the state moves out of
"postcopy-pause".

> 
> It feels to me that if the mgmt app or admin believes the migration
> is in a stuck state, we should be able to explicitly terminate the
> existing connection via a monitor command. Then setup the target
> host to accept new client, and then issue this migrate resume on
> the source.

Totally agree. That should be the only way to handle 1st condition
well. However, would you mind if I postpone it a bit? IMHO as long as
we can solve the 2nd condition nicely (which is the goal of this
series), then it won't be too hard to continue support the 1st
condition.

Since we are at here discussing the usage model... maybe I can further
extend it a bit to gain more input.

IMHO in general there are two phases for the recovery (assume we are
always talking about postcopy):

  active --> paused --> recovery --> active
               [1]         [2]

For [1]: the 1st condition we discussed above can be seen as "manual
pause" - user can provide a command to forcely discard existing
migration channel. While 2nd condition is the "automatic pause" (what
this series does): when qemu detected network problem, it
automatically switch to the paused state.

For [2]: we are always doing it in the "manual" way: we need a command
to trigger the recovery.

What I am thinking is whether it would make sense in the future to do
the "automatic" thing for [2] as well. In that sense, source
periodically detects connectability of existing migration channel
(which is broken), and it will auto-reconnect if it finds that the
network is recovered. We can add a new capability bit for it (e.g.,
"postcopy-auto-recovery"), showing whether we would like the
"automatic recovery" happen.

If we put these into a matrix:

|------------+---------------+----------------------------------------|
| Pause mode | Recovery mode | Use case                               |
|------------+---------------+----------------------------------------|
| manual     | manual        | 1st condition mentioned above          |
|            | auto          | (I *guess* we don't need this one)     |
|------------+---------------+----------------------------------------|
| auto       | manual        | 2nd condition mentioned above          |
|            | auto          | (will we want this one in the future?) |
|------------+---------------+----------------------------------------|

Thanks,

-- 
Peter Xu
