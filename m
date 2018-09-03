Received: from eggs.gnu.org ([2001:4830:134:3::10]:49806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fwoxb-0007bn-LF
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 09:32:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fwoxY-0004dL-Gc
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 09:32:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33236 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fwoxY-0004cy-AA
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 09:32:04 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EB1808010FDF
	for <qemu-devel@nongnu.org>; Mon,  3 Sep 2018 13:32:03 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180903043149.4076-1-peterx@redhat.com>
	<20180903043149.4076-5-peterx@redhat.com>
	<87a7oz9g1y.fsf@dusky.pond.sub.org> <20180903101606.GB14774@xz-x1>
Date: Mon, 03 Sep 2018 15:31:58 +0200
In-Reply-To: <20180903101606.GB14774@xz-x1> (Peter Xu's message of "Mon, 3 Sep
	2018 18:16:06 +0800")
Message-ID: <87k1o2671t.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v7 4/7] qapi: remove COMMAND_DROPPED event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>

Cc: Eric & Daniel for the libvirt point of view.

Peter Xu <peterx@redhat.com> writes:

> On Mon, Sep 03, 2018 at 09:49:13AM +0200, Markus Armbruster wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > Now it was not used any more, drop it.  We can still do that since
>> > out-of-band is still experimental, and this event is only used when
>> > out-of-band is enabled.
>> >
>> > Signed-off-by: Peter Xu <peterx@redhat.com>
>> > ---
>> >  docs/interop/qmp-spec.txt |  5 +++--
>> >  qapi/misc.json            | 40 ---------------------------------------
>> >  2 files changed, 3 insertions(+), 42 deletions(-)
>> >
>> > diff --git a/docs/interop/qmp-spec.txt b/docs/interop/qmp-spec.txt
>> > index 8f7da0245d..67e44a8120 100644
>> > --- a/docs/interop/qmp-spec.txt
>> > +++ b/docs/interop/qmp-spec.txt
>> > @@ -130,8 +130,9 @@ to pass "id" with out-of-band commands.  Passing it with all commands
>> >  is recommended for clients that accept capability "oob".
>> >  
>> >  If the client sends in-band commands faster than the server can
>> > -execute them, the server will eventually drop commands to limit the
>> > -queue length.  The sever sends event COMMAND_DROPPED then.
>> > +execute them, the server will stop reading the requests from the QMP
>> > +channel until the request queue length is reduced to an acceptable
>> > +range.
>> 
>> The change described by this documentation update is in the previous
>> commit.  This commit merely cleans up unused code.  Instead of moving
>> the doc update to the previous commit, we can simply squash the two
>> commits.
>
> Sure, I'll squash.
>
>> 
>> Let's add a hint on managing flow of in-band commands to keep the
>> monitor available for out-of-band commands.  Here's my try:
>> 
>>     If the client sends in-band commands faster than the server can
>>     execute them, the server will stop reading the requests from the QMP
>>     channel until its request queue length falls below the limit.  To
>>     keep the monitor available for out-of-band commands, the client has
>>     to manage the flow of in-band commands.
>> 
>> Of course, anyone trying to put this hint to use will need to know the
>> actual request queue limit.  Options:
>> 
>> * Make it ABI by documenting it here
>> 
>> * Let the client configure it with a suitable command
>> 
>> * Let the introspect it with a suitable command
>
> I'm not sure whether we should expose this information to the client,
> considering that the client can after all detect that "full" by
> monitoring the status of its output buffer used (e.g., poll with
> POLLOUT) and assuming that should be enough for a client.  Or did I
> miss anything that you were trying to emphasize but I didn't notice
> (since after all you mentioned this too in the other thread)?

By the time the client gets "write would block", OOB has already become
unavailable, and will remain so until the logjam clears sufficiently.

Example:

    client sends in-band command #1
    QEMU reads and queues
    QEMU dequeues in-band command #1
    in-band command #1 starts executing, but it's slooow
    client sends in-band command #2
    QEMU reads and queues
    ...
    client sends in-band command #8
    QEMU reads, queues and suspends the monitor
    client sends out-of-band command
--> time passes...
    in-band command #1 completes, QEMU sends reply
    QEMU dequeues in-band command #2, resumes the monitor
    in-band command #2 starts executing
    QEMU reads and executes out-of-band command
    out-of-band command completes, QEMU sends reply
    in-band command #2 completes, QEMU sends reply
    ... same for remaining in-band commands ...

The out-of-band command gets stuck behind the in-band commands.

The client can avoid this by managing the flow of in-band commands: have
no more than 7 in flight, so the monitor never gets suspended.

This is a potentially useful thing to do for clients, isn't it?

Eric, Daniel, is it something libvirt would do?
