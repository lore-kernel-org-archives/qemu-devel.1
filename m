Received: from eggs.gnu.org ([2001:4830:134:3::10]:48667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fVXMX-0005g7-Bw
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 03:17:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fVXMW-0005be-2Z
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 03:17:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49836 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fVXMV-0005bW-SJ
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 03:17:03 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180619053426.13065-1-peterx@redhat.com>
	<20180619053426.13065-4-peterx@redhat.com>
	<87a7rqvq60.fsf@dusky.pond.sub.org> <20180620025811.GA18985@xz-mi>
Date: Wed, 20 Jun 2018 09:17:01 +0200
In-Reply-To: <20180620025811.GA18985@xz-mi> (Peter Xu's message of "Wed, 20
	Jun 2018 10:58:11 +0800")
Message-ID: <87o9g6j5aq.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 3/7] monitor: flush qmp responses when
 CLOSED
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Fam Zheng <famz@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Eric Auger <eric.auger@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, John Snow <jsnow@redhat.com>, "Dr . David
	Alan Gilbert" <dgilbert@redhat.com>

Peter Xu <peterx@redhat.com> writes:

> On Tue, Jun 19, 2018 at 03:53:11PM +0200, Markus Armbruster wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > Previously we clean up the queues when we got CLOSED event.  It was used
>> > to make sure we won't send leftover replies/events of a old client to a
>> > new client which makes perfect sense. However this will also drop the
>> > replies/events even if the output port of the previous chardev backend
>> > is still open, which can lead to missing of the last replies/events.
>> > Now this patch does an extra operation to flush the response queue
>> > before cleaning up.
>> >
>> > In most cases, a QMP session will be based on a bidirectional channel (a
>> > TCP port, for example, we read/write to the same socket handle), so in
>> > port and out port of the backend chardev are fundamentally the same
>> > port. In these cases, it does not really matter much on whether we'll
>> > flush the response queue since flushing will fail anyway.  However there
>> > can be cases where in & out ports of the QMP monitor's backend chardev
>> > are separated.  Here is an example:
>> >
>> >   cat $QMP_COMMANDS | qemu -qmp stdio ... | filter_commands
>> >
>> > In this case, the backend is fd-typed, and it is connected to stdio
>> > where in port is stdin and out port is stdout.  Now if we drop all the
>> > events on the response queue then filter_command process might miss some
>> > events that it might expect.  The thing is that, when stdin closes,
>> > stdout might still be there alive!
>> >
>> > In practice, I encountered SHUTDOWN event missing when running test with
>> > iotest 087 with Out-Of-Band enabled.  Here is one of the ways that this
>> > can happen (after "quit" command is executed and QEMU quits the main
>> > loop):
>> >
>> > 1. [main thread] QEMU queues a SHUTDOWN event into response queue.
>> >
>> > 2. "cat" terminates (to distinguish it from the animal, I quote it).
>> >
>> > 3. [monitor iothread] QEMU's monitor iothread reads EOF from stdin.
>> >
>> > 4. [monitor iothread] QEMU's monitor iothread calls the CLOSED event
>> >    hook for the monitor, which will destroy the response queue of the
>> >    monitor, then the SHUTDOWN event is dropped.
>> >
>> > 5. [main thread] QEMU's main thread cleans up the monitors in
>> >    monitor_cleanup().  When trying to flush pending responses, it sees
>> >    nothing.  SHUTDOWN is lost forever.
>> >
>> > Note that before the monitor iothread was introduced, step [4]/[5] could
>> > never happen since the main loop was the only place to detect the EOF
>> > event of stdin and run the CLOSED event hooks.  Now things can happen in
>> > parallel in the iothread.
>> >
>> > Without this patch, iotest 087 will have ~10% chance to miss the
>> > SHUTDOWN event and fail when with Out-Of-Band enabled (the output is
>> > manually touched up to suite line width requirement):
>> 
>> I wouldn't wrap lines when quoting a diff.
>> 
>> >
>> > --- /home/peterx/git/qemu/tests/qemu-iotests/087.out
>> > +++ /home/peterx/git/qemu/bin/tests/qemu-iotests/087.out.bad
>> > @@ -8,7 +8,6 @@
>> >  {"return": {}}
>> >  {"error": {"class": "GenericError", "desc": "'node-name' must be
>> >   specified for the root node"}}
>> >  {"return": {}}
>> > -{"timestamp": {"seconds": TIMESTAMP, "microseconds": TIMESTAMP},
>> > - "event": "SHUTDOWN", "data": {"guest": false}}
>> >
>> >  === Duplicate ID ===
>> > @@ -53,7 +52,6 @@
>> >  {"return": {}}
>> >  {"return": {}}
>> >  {"return": {}}
>> >
>> > -{"timestamp": {"seconds": TIMESTAMP, "microseconds": TIMESTAMP},
>> > - "event": "SHUTDOWN", "data": {"guest": false}}
>> 
>> Please indent the quoted diff a bit, so make it more obviously not part
>> of the patch.  In fact, git-am chokes on it for me.
>
> To make it even simpler, I plan to remove the whole chunk of the diff
> from the commit message if you won't disagree.

In general, I rather like having test failure details in the commit
message.  In this particular case, however, the diff is probably not
necessary, as "iotest 087 will have ~10% chance to miss the SHUTDOWN
event" is clear enough.

>> >
>> > This patch fixes the problem.
>> >
>> > Fixes: 6d2d563f8c ("qmp: cleanup qmp queues properly", 2018-03-27)
>> > Suggested-by: Markus Armbruster <armbru@redhat.com>
>> > Signed-off-by: Peter Xu <peterx@redhat.com>
>> >
>> > Signed-off-by: Peter Xu <peterx@redhat.com>
>> > ---
>> >  monitor.c | 33 ++++++++++++++++++++++++++++++---
>> >  1 file changed, 30 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/monitor.c b/monitor.c
>> > index d4a463f707..c9a02ee40c 100644
>> > --- a/monitor.c
>> > +++ b/monitor.c
[...]
>> > @@ -4364,6 +4383,14 @@ static void monitor_qmp_event(void *opaque, int event)
>> >          mon_refcount++;
>> >          break;
>> >      case CHR_EVENT_CLOSED:
>> > +        /*
>> > +         * Note: this is only useful when the output of the chardev
>> > +         * backend is still open.  For example, when the backend is
>> > +         * stdio, it's possible that stdout is still open when stdin
>> > +         * is closed.  After all, CHR_EVENT_CLOSED event is currently
>> > +         * only bound to stdin.
>> > +         */
>> 
>> I'm not sure I get the last sentence.  What do you mean by "bound to
>> stdin"?
>
> I want to express that the event is only related to the state of
> stdin, meanwhile it's never related to the state of stdout.  How about
> I remove the sentence after "after all"?  I think it's clear enough
> with the rest of the comments.

Works for me.

[...]
