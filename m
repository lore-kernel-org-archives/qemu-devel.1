Received: from eggs.gnu.org ([2001:4830:134:3::10]:45167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gOzZq-0000vA-Hc
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 01:32:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gOzZe-00044F-Rw
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 01:32:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42434)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gOzZe-00040Y-GA
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 01:31:50 -0500
Date: Tue, 20 Nov 2018 14:31:43 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20181120063143.GB24163@xz-x1>
References: <20181030191620.32168-1-armbru@redhat.com>
	<CAFEAcA8RdNrbCLL7tXY=e95N2Y0LcZdCPr3EuQo1_hu08qJuaQ@mail.gmail.com>
	<87sh0eyzb0.fsf@dusky.pond.sub.org> <20181107025628.GB17134@xz-x1>
	<CAFEAcA_FhkA_1DiDM2PWDw27dupsAdP==kBUxRrw5rGDnLzMwg@mail.gmail.com>
	<20181108024406.GB3170@xz-x1> <20181119061727.GA1901@xz-x1>
	<20181119070558.GB1901@xz-x1> <87ftvxlz3m.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ftvxlz3m.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PULL 0/8] Monitor patches for 2018-10-30
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On Mon, Nov 19, 2018 at 07:08:13PM +0100, Markus Armbruster wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Mon, Nov 19, 2018 at 02:17:27PM +0800, Peter Xu wrote:
> >> I reproduced the error with a FreeBSD guest and this change (which
> >> possibly can be squashed into "tests: qmp-test: add queue full test")
> >> worked for me:
> >> 
> >> diff --git a/tests/qmp-test.c b/tests/qmp-test.c
> >> index 6989acbca4..83f353db4f 100644
> >> --- a/tests/qmp-test.c
> >> +++ b/tests/qmp-test.c
> >> @@ -281,8 +281,15 @@ static void test_qmp_oob(void)
> >>       * will only be able to be handled after the queue is shrinked, so
> >>       * it'll be processed only after one existing in-band command
> >>       * finishes.
> >> +     *
> >> +     * NOTE: we need to feed the queue with one extra request to make
> >> +     * sure it'll be stuck since when we have sent the Nth request
> >> +     * it's possible that we have already popped and processing the
> >> +     * 1st request so the Nth request (which could potentially be the
> >> +     * [N-1]th element on the queue) might not trigger the
> >> +     * monitor-full condition deterministically.
> >>       */
> >> -    for (i = 1; i <= QMP_REQ_QUEUE_LEN_MAX; i++) {
> >> +    for (i = 1; i <= QMP_REQ_QUEUE_LEN_MAX + 1; i++) {
> >>          id = g_strdup_printf("queue-blocks-%d", i);
> >>          send_cmd_that_blocks(qts, id);
> >>          g_free(id);
> >> @@ -291,7 +298,7 @@ static void test_qmp_oob(void)
> >>      unblock_blocked_cmd();
> >>      recv_cmd_id(qts, "queue-blocks-1");
> >>      recv_cmd_id(qts, "oob-1");
> >> -    for (i = 2; i <= QMP_REQ_QUEUE_LEN_MAX; i++) {
> >> +    for (i = 2; i <= QMP_REQ_QUEUE_LEN_MAX + 1; i++) {
> >>          unblock_blocked_cmd();
> >>          id = g_strdup_printf("queue-blocks-%d", i);
> >>          recv_cmd_id(qts, id);
> >> 
> >> So the problem here is that the queue-block-N command might not really
> >> suspend the monitor everytime if we already popped the 1st request,
> >> which will let the N-th request to be (N-1)th, then the parser will
> >> continue to eat the oob command and it could "preempt" the previous
> >> commands.
> >> 
> >> Maybe FreeBSD is scheduling the threads in some pattern so it happens
> >> only on FreeBSD and very constantly, but anyway it should be a general
> >> fix to the test program.
> 
> I feel particularly dense right now, and need a more detailed analysis
> to understand.  Let me try.
> 
> Here's what the test does before your fix
> 
>     Send QMP_REQ_QUEUE_LEN_MAX "blocking" in-band commands
>     queue-blocks-1, queue-blocks-2, ...  "Blocking" means the command
>     blocks until we explicitly unblock it.
> 
>     Send an out-of-band command oob-1.
> 
>     Unblock queue-blocks-1.
> 
>     Receive response to queue-blocks-1.
> 
>     Receive response to oob-1.
> 
>     Unblock queue-blocks-2, receive response
>     ...
> 
> Here's what test test expects QEMU to do:
> 
>     In I/O thread:
> 
>         Receive and queue queue-blocks-1, ...
> 
>         Queue is full, stop receiving commands.
> 
>     In main thread:
> 
>         Dequeue queue-blocks-1.
> 
>         Execute queue-blocks-1, block for a while, finish and send
>         response.
> 
>     In I/O thread:
> 
>         Queue is no longer full, resume receiving commands.
> 
>         Receive and execute oob-1, send response
> 
>     In main thread:
> 
>         Dequeue queue-blocks-2, execute, block for a while, finish and
>         send response.
>         ...
> 
> No good because the two threads race.  On my Linux box the test passes.
> Let's have a closer look how it does that.  The appended patch that adds
> another tracepoint.  With tracepoints monitor_* and handle_qmp_command
> enabled, I get:
> 
>     19271@1542641581.372890:handle_qmp_command mon 0x563e19be4e80 req: {"execute": "blockdev-add", "arguments": {"image": {"driver": "null-co"}, "node-name": "queue-blocks-1", "driver": "blkdebug", "config": "/tmp/qmp-test-EZroW3/fifo"}}
> 
> I/O thread receives and queues queue-blocks-1.
> 
>     19271@1542641581.372954:monitor_qmp_cmd_in_band queue-blocks-1
> 
> Main thread dequeues qemu-blocks-1 and starts executing it.
> 
> We already lost: the queue won't actually fill up.  The test passes
> anyway, but it doesn't actually test "queue full".  But why does it
> pass?  Let's see.
> 
>     19271@1542641581.373211:monitor_qmp_respond queue-blocks-1
> 
> Main thread sends response to queue-blocks-1.  This means queue-blocks-1
> has been unblocked already.  This is possible, because qmp-test sends
> all the commands and then immediately unblocks queue-blocks-1, and the
> main thread can win the race with the I/O thread.
> 
>     19271@1542641581.373826:handle_qmp_command mon 0x563e19be4e80 req: {"execute": "blockdev-add", "arguments": {"image": {"driver": "null-co"}, "node-name": "queue-blocks-2", "driver": "blkdebug", "config": "/tmp/qmp-test-EZroW3/fifo"}}
>     19271@1542641581.373864:monitor_qmp_cmd_in_band queue-blocks-2
>     19271@1542641581.374575:handle_qmp_command mon 0x563e19be4e80 req: {"execute": "blockdev-add", "arguments": {"image": {"driver": "null-co"}, "node-name": "queue-blocks-3", "driver": "blkdebug", "config": "/tmp/qmp-test-EZroW3/fifo"}}
>     19271@1542641581.375344:handle_qmp_command mon 0x563e19be4e80 req: {"execute": "blockdev-add", "arguments": {"image": {"driver": "null-co"}, "node-name": "queue-blocks-4", "driver": "blkdebug", "config": "/tmp/qmp-test-EZroW3/fifo"}}
>     19271@1542641581.376162:handle_qmp_command mon 0x563e19be4e80 req: {"execute": "blockdev-add", "arguments": {"image": {"driver": "null-co"}, "node-name": "queue-blocks-5", "driver": "blkdebug", "config": "/tmp/qmp-test-EZroW3/fifo"}}
>     19271@1542641581.376996:handle_qmp_command mon 0x563e19be4e80 req: {"execute": "blockdev-add", "arguments": {"image": {"driver": "null-co"}, "node-name": "queue-blocks-6", "driver": "blkdebug", "config": "/tmp/qmp-test-EZroW3/fifo"}}
>     19271@1542641581.377790:handle_qmp_command mon 0x563e19be4e80 req: {"execute": "blockdev-add", "arguments": {"image": {"driver": "null-co"}, "node-name": "queue-blocks-7", "driver": "blkdebug", "config": "/tmp/qmp-test-EZroW3/fifo"}}
>     19271@1542641581.378562:handle_qmp_command mon 0x563e19be4e80 req: {"execute": "blockdev-add", "arguments": {"image": {"driver": "null-co"}, "node-name": "queue-blocks-8", "driver": "blkdebug", "config": "/tmp/qmp-test-EZroW3/fifo"}}
> 
> I/O thread receives and queues queue-blocks-2, ... queue-blocks-8.
> 
>     19271@1542641581.378796:handle_qmp_command mon 0x563e19be4e80 req: {"exec-oob": "migrate-pause"}
>     19271@1542641581.378800:monitor_qmp_cmd_out_of_band oob-1
>     19271@1542641581.378823:monitor_qmp_respond oob-1
> 
> I/O thread receives, executes and responds to oob-1.
> 
>     19271@1542641581.379197:monitor_qmp_respond queue-blocks-2
>     19271@1542641581.379228:monitor_qmp_cmd_in_band queue-blocks-3
>     19271@1542641581.379435:monitor_qmp_respond queue-blocks-3
>     19271@1542641581.379477:monitor_qmp_cmd_in_band queue-blocks-4
>     19271@1542641581.379597:monitor_qmp_respond queue-blocks-4
>     19271@1542641581.379621:monitor_qmp_cmd_in_band queue-blocks-5
>     19271@1542641581.379800:monitor_qmp_respond queue-blocks-5
>     19271@1542641581.379824:monitor_qmp_cmd_in_band queue-blocks-6
>     19271@1542641581.379953:monitor_qmp_respond queue-blocks-6
>     19271@1542641581.379992:monitor_qmp_cmd_in_band queue-blocks-7
>     19271@1542641581.380132:monitor_qmp_respond queue-blocks-7
>     19271@1542641581.380170:monitor_qmp_cmd_in_band queue-blocks-8
>     19271@1542641581.380283:monitor_qmp_respond queue-blocks-8
> 
> Main thread dequeues, executes and responds to queue-blocks-2,
> ... queue-blocks-8.
> 
> If I make the main thread lose the race by sticking a sleep(1) before
> the unblock_blocked_cmd() that unblocks queue-blocks-1, I get:
> 
>     22762@1542641707.818838:handle_qmp_command mon 0x55f5b6a5de80 req: {"execute": "blockdev-add", "arguments": {"image": {"driver": "null-co"}, "node-name": "queue-blocks-1", "driver": "blkdebug", "config": "/tmp/qmp-test-PqO2uz/fifo"}}
> 
> I/O thread receives and queues queue-blocks-1.
> 
>     22762@1542641707.818856:monitor_qmp_cmd_in_band queue-blocks-1
> 
> Main thread dequeues qemu-blocks-1 and starts executing it.  We already
> lost.
> 
>     22762@1542641707.819585:handle_qmp_command mon 0x55f5b6a5de80 req: {"execute": "blockdev-add", "arguments": {"image": {"driver": "null-co"}, "node-name": "queue-blocks-2", "driver": "blkdebug", "config": "/tmp/qmp-test-PqO2uz/fifo"}}
>     22762@1542641707.820331:handle_qmp_command mon 0x55f5b6a5de80 req: {"execute": "blockdev-add", "arguments": {"image": {"driver": "null-co"}, "node-name": "queue-blocks-3", "driver": "blkdebug", "config": "/tmp/qmp-test-PqO2uz/fifo"}}
>     22762@1542641707.821072:handle_qmp_command mon 0x55f5b6a5de80 req: {"execute": "blockdev-add", "arguments": {"image": {"driver": "null-co"}, "node-name": "queue-blocks-4", "driver": "blkdebug", "config": "/tmp/qmp-test-PqO2uz/fifo"}}
>     22762@1542641707.821821:handle_qmp_command mon 0x55f5b6a5de80 req: {"execute": "blockdev-add", "arguments": {"image": {"driver": "null-co"}, "node-name": "queue-blocks-5", "driver": "blkdebug", "config": "/tmp/qmp-test-PqO2uz/fifo"}}
>     22762@1542641707.822569:handle_qmp_command mon 0x55f5b6a5de80 req: {"execute": "blockdev-add", "arguments": {"image": {"driver": "null-co"}, "node-name": "queue-blocks-6", "driver": "blkdebug", "config": "/tmp/qmp-test-PqO2uz/fifo"}}
>     22762@1542641707.823314:handle_qmp_command mon 0x55f5b6a5de80 req: {"execute": "blockdev-add", "arguments": {"image": {"driver": "null-co"}, "node-name": "queue-blocks-7", "driver": "blkdebug", "config": "/tmp/qmp-test-PqO2uz/fifo"}}
>     22762@1542641707.824069:handle_qmp_command mon 0x55f5b6a5de80 req: {"execute": "blockdev-add", "arguments": {"image": {"driver": "null-co"}, "node-name": "queue-blocks-8", "driver": "blkdebug", "config": "/tmp/qmp-test-PqO2uz/fifo"}}
> 
> I/O thread receives and queues queue-blocks-2, ... queue-blocks-8.
> 
>     22762@1542641707.824253:handle_qmp_command mon 0x55f5b6a5de80 req: {"exec-oob": "migrate-pause"}
>     22762@1542641707.824257:monitor_qmp_cmd_out_of_band oob-1
>     22762@1542641707.824282:monitor_qmp_respond oob-1
> 
> I/O thread receives, executes and responds to oob-1.
> 
> Test is going to fail: response to oob-1 sent before response to
> queue-blocks-1.
> 
> Now let me try your fix.  Here's what I see:
> 
>     16585@1542650042.980953:handle_qmp_command mon 0x5597b8e0de80 req: {"execute": "blockdev-add", "arguments": {"image": {"driver": "null-co"}, "node-name": "queue-blocks-1", "driver": "blkdebug", "config": "/tmp/qmp-test-8YRbOJ/fifo"}}
>     16585@1542650042.981018:monitor_qmp_cmd_in_band queue-blocks-1
>     16585@1542650042.981252:monitor_qmp_respond queue-blocks-1
>     16585@1542650042.981838:handle_qmp_command mon 0x5597b8e0de80 req: {"execute": "blockdev-add", "arguments": {"image": {"driver": "null-co"}, "node-name": "queue-blocks-2", "driver": "blkdebug", "config": "/tmp/qmp-test-8YRbOJ/fifo"}}
>     16585@1542650042.981916:monitor_qmp_cmd_in_band queue-blocks-2
>     16585@1542650042.982656:handle_qmp_command mon 0x5597b8e0de80 req: {"execute": "blockdev-add", "arguments": {"image": {"driver": "null-co"}, "node-name": "queue-blocks-3", "driver": "blkdebug", "config": "/tmp/qmp-test-8YRbOJ/fifo"}}
>     16585@1542650042.983406:handle_qmp_command mon 0x5597b8e0de80 req: {"execute": "blockdev-add", "arguments": {"image": {"driver": "null-co"}, "node-name": "queue-blocks-4", "driver": "blkdebug", "config": "/tmp/qmp-test-8YRbOJ/fifo"}}
>     16585@1542650042.984170:handle_qmp_command mon 0x5597b8e0de80 req: {"execute": "blockdev-add", "arguments": {"image": {"driver": "null-co"}, "node-name": "queue-blocks-5", "driver": "blkdebug", "config": "/tmp/qmp-test-8YRbOJ/fifo"}}
>     16585@1542650042.984975:handle_qmp_command mon 0x5597b8e0de80 req: {"execute": "blockdev-add", "arguments": {"image": {"driver": "null-co"}, "node-name": "queue-blocks-6", "driver": "blkdebug", "config": "/tmp/qmp-test-8YRbOJ/fifo"}}
>     16585@1542650042.985778:handle_qmp_command mon 0x5597b8e0de80 req: {"execute": "blockdev-add", "arguments": {"image": {"driver": "null-co"}, "node-name": "queue-blocks-7", "driver": "blkdebug", "config": "/tmp/qmp-test-8YRbOJ/fifo"}}
>     16585@1542650042.986565:handle_qmp_command mon 0x5597b8e0de80 req: {"execute": "blockdev-add", "arguments": {"image": {"driver": "null-co"}, "node-name": "queue-blocks-8", "driver": "blkdebug", "config": "/tmp/qmp-test-8YRbOJ/fifo"}}
>     16585@1542650042.987396:handle_qmp_command mon 0x5597b8e0de80 req: {"execute": "blockdev-add", "arguments": {"image": {"driver": "null-co"}, "node-name": "queue-blocks-9", "driver": "blkdebug", "config": "/tmp/qmp-test-8YRbOJ/fifo"}}
>     16585@1542650042.987626:handle_qmp_command mon 0x5597b8e0de80 req: {"exec-oob": "migrate-pause"}
>     16585@1542650042.987630:monitor_qmp_cmd_out_of_band oob-1
>     16585@1542650042.987676:monitor_qmp_respond oob-1
>     16585@1542650042.988035:monitor_qmp_respond queue-blocks-2
>     16585@1542650042.988066:monitor_qmp_cmd_in_band queue-blocks-3
>     16585@1542650042.988329:monitor_qmp_respond queue-blocks-3
>     16585@1542650042.988360:monitor_qmp_cmd_in_band queue-blocks-4
>     16585@1542650042.988575:monitor_qmp_respond queue-blocks-4
>     16585@1542650042.988616:monitor_qmp_cmd_in_band queue-blocks-5
>     16585@1542650042.988803:monitor_qmp_respond queue-blocks-5
>     16585@1542650042.988826:monitor_qmp_cmd_in_band queue-blocks-6
>     16585@1542650042.988977:monitor_qmp_respond queue-blocks-6
>     16585@1542650042.989001:monitor_qmp_cmd_in_band queue-blocks-7
>     16585@1542650042.989223:monitor_qmp_respond queue-blocks-7
>     16585@1542650042.989279:monitor_qmp_cmd_in_band queue-blocks-8
>     16585@1542650042.989447:monitor_qmp_respond queue-blocks-8
>     16585@1542650042.989469:monitor_qmp_cmd_in_band queue-blocks-9
>     16585@1542650042.989582:monitor_qmp_respond queue-blocks-9
> 
> Tracepoint monitor_suspend still not hit.  This means the queue does not
> fill up.

You are right.  I think I figured out one thing but I missed another
point here that "sent the command" does not mean "received by the QMP
server": we can never identify when the queue is full, meanwhile
that's what we need to write a unit test for it.

For example: in this test what we want to achieve is:

  for i in 1 .. N:
      send blocking commands Bi
  ... wait until queue is full ...  [1]
  send oob command O1
  unblock blocking command B1
  receive response B1
  receive response O1
  for i in 2 .. N:
      unblock blocking command Bi
      receive response Bi

All looks sane except the assumption at [1].  In the code we didn't do
anything for [1] assuming that it's naturally happening.  However it's
not since when finishing the first for loop we only queued the
commands into the send buffer, but we can't guarantee that the
commands are well received and further queued in the qmp request list
on the server side.  Now when the server qmp request queue gets full
it will only suspend the monitor, and that event is totally unseen
from the client POV, so IMHO we don't have a good way to guarantee
this.  E.g., we can do a very long sleep(100) at [1] to pretty make
sure the queue full is happened, however it might still break on a
super slow machine.

In other words, I don't see a good way to automate the testing of
queue full for now (but I'm pretty sure the queue full is working
there since if you really insert a sleep you'll definitely see the
monitor_suspend tracepoint).  We might need something like an event to
make sure the queue full happened and then the client can detect this
and insert the next out-of-band command, but then we're going backword
and I don't see much point to introduce a new event only for testing
purpose...

> 
> > Markus, do you want me to repost a new version with this change?  Is
> > it still possible to have the oob-default series for 3.1?
> 
> We're trying to, but we need to get the test to work.
> 
> Two problems:
> 
> 1. The test doesn't seem to succed at testing "queue full".
> 
> 2. The test might still be racy.
> 
> I suspect the code we test is solid, and it's "only" the test we screwed
> up.

I agree.  Do you have better idea to test queue full?  I'd be more
than glad to try any suggestions here, otherwise I am thinking whether
we can just simply drop the queue full test (which is the last patch
of the oob series) for now but merge the rest.  We can introduce new
queue full test after 3.1 if we want, though again I really doubt
whether we can without new things introduced into the procedure.

Thoughts?

> 
> 
> diff --git a/monitor.c b/monitor.c
> index 431795d686..52112889ef 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -4064,6 +4064,7 @@ static int monitor_can_read(void *opaque)
>   */
>  static void monitor_qmp_respond(Monitor *mon, QDict *rsp, QObject *id)
>  {
> +    trace_monitor_qmp_respond(qobject_get_try_str(id) ?: "");
>      if (rsp) {
>          if (id) {
>              qdict_put_obj(rsp, "id", qobject_ref(id));
> diff --git a/trace-events b/trace-events
> index 4fd2cb4b97..57c5f6cc94 100644
> --- a/trace-events
> +++ b/trace-events
> @@ -50,6 +50,7 @@ handle_qmp_command(void *mon, const char *req) "mon %p req: %s"
>  monitor_suspend(void *ptr, int cnt) "mon %p: %d"
>  monitor_qmp_cmd_in_band(const char *id) "%s"
>  monitor_qmp_cmd_out_of_band(const char *id) "%s"
> +monitor_qmp_respond(const char *id) "%s"
>  
>  # dma-helpers.c
>  dma_blk_io(void *dbs, void *bs, int64_t offset, bool to_dev) "dbs=%p bs=%p offset=%" PRId64 " to_dev=%d"

Regards,

-- 
Peter Xu
