Received: from eggs.gnu.org ([209.51.188.92]:50049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1goBno-0008Sx-Mv
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:38:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1goBnZ-0004FG-OW
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:38:25 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <271482fe-741a-6a15-15fd-181d4e55a8c4@redhat.com>
	<w51bm469xhh.fsf@maestria.local.igalia.com>
	<w518szam8em.fsf@maestria.local.igalia.com>
	<4236ceac-fd50-ad04-811a-0be7b3dbd667@redhat.com>
	<w51a7jkstdd.fsf@maestria.local.igalia.com>
Date: Mon, 28 Jan 2019 19:38:08 +0100
In-Reply-To: <w51a7jkstdd.fsf@maestria.local.igalia.com> (Alberto Garcia's
	message of "Mon, 28 Jan 2019 16:18:38 +0100")
Message-ID: <87tvhsy6en.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] Consistency of iotests 093 and 136
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>, Qemu-block <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>

Alberto Garcia <berto@igalia.com> writes:

> On Thu 24 Jan 2019 07:07:47 PM CET, Eric Blake wrote:
>>>>> 093 and 136 seem really flaky to me.  I can reproduce that by
>>>>> running:
>>>>
>>>> That's interesting, I can make 093 fail quite easily now (I haven't
>>>> tested the other one yet), but I don't think this happened
>>>> earlier. I'll try to figure out what's going on.
>>> 
>>> I bisected this and it seems that 093 started to fail after this:
>>> 
>>> 8258292e monitor: Remove "x-oob", offer capability "oob" unconditionally
>>> 
>>> I'm not familiar with that option so I need to investigate.
>>
>> We've got several tests failing after making x-oob unconditional; here's
>> another thread:
>>
>> https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg05587.html
>>
>> Could it be that the test was using some sort of QMP command as an
>> attempt to synchronize state, but the OOB handling is now making it not
>> a reliable sync point?
>
> 093 submits several I/O requests using aio_read and aio_write with
> hmp_qemu_io(), then advances the clock using clock_step and finally
> calls query-blockstats to see how much of the I/O has been completed
> (it's an I/O throttling test).
>
> The expectation is that by the time query-blockstats is called all
> submitted I/O requests have been processed (up to the amount allowed by
> the throttling limits).

Assumptions like "when we see the reply to QMP command X, surely the
main loop has completed doing Y" are problematic.  When possible, rely
on something more direct, such as a query command that shows you whether
Y has been completed.

Mind, I'm not claiming the assumption you described is invalid.

> Are the QMP (hmp_qemu_io, query-blockstats) and qtest (clock_step)
> sockets maybe running in different threads?

First order approximation: the QMP *monitors* run in the monitor I/O
thread (as of commit 8258292e18c), but the QMP *commands* still run in
the main loop.  The QMP monitor suspends itself after reading a command
and sending it to the main loop.  The main loop resumes the monitor
after sending the reply.

Before this change, the QMP monitors also ran in the main loop, and
executed each command right after reading it.  The monitor suspend /
resume described above is designed to minimize observable differences in
behavior.

More exact version, may not be relevant to you now.

The QMP monitors run in the monitor I/O thread when the underlying
character can support that.  The character devices you typically want to
use with QMP, such as socket, all can.  Some character devices can't,
e.g. ringbuf, spice, braille, MUX.

Monitors offer capability "oob" when running in the I/O thread.  For
instance:

    $ qemu-system-x86_64 -nodefaults -S -display none -qmp-pretty stdio
    {
        "QMP": {
            "version": {
                "qemu": {
                    "micro": 50,
                    "minor": 1,
                    "major": 3
                },
                "package": "v3.1.0-1200-g9dd0d8111f"
            },
            "capabilities": [
-->             "oob"
            ]
        }
    }

QMP commands still run in the main loop.  The monitor reads commands and
sends them to the main loop.  The main loop executes them one after the
other, and sends replies.  The number of commands in flight is limited.

Unless the client accepted capability "oob", the limit is one.

Clients that accepted capability "oob" can execute oob-capable commands
out of band.  The monitor executes them right away, jumping the queue.
The only commands that can be executed out of band so far are
migrate-recover and migrate-pause.  See docs/interop/qmp-spec.txt for
more detailed information.
