Received: from eggs.gnu.org ([209.51.188.92]:53797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1go8gT-0007Kg-HH
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 10:18:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1go8gS-0004w8-Jm
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 10:18:49 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <4236ceac-fd50-ad04-811a-0be7b3dbd667@redhat.com>
References: <271482fe-741a-6a15-15fd-181d4e55a8c4@redhat.com>
	<w51bm469xhh.fsf@maestria.local.igalia.com>
	<w518szam8em.fsf@maestria.local.igalia.com>
	<4236ceac-fd50-ad04-811a-0be7b3dbd667@redhat.com>
Date: Mon, 28 Jan 2019 16:18:38 +0100
Message-ID: <w51a7jkstdd.fsf@maestria.local.igalia.com>
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
To: Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>, Qemu-block <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Thu 24 Jan 2019 07:07:47 PM CET, Eric Blake wrote:
>>>> 093 and 136 seem really flaky to me.  I can reproduce that by
>>>> running:
>>>
>>> That's interesting, I can make 093 fail quite easily now (I haven't
>>> tested the other one yet), but I don't think this happened
>>> earlier. I'll try to figure out what's going on.
>> 
>> I bisected this and it seems that 093 started to fail after this:
>> 
>> 8258292e monitor: Remove "x-oob", offer capability "oob" unconditionally
>> 
>> I'm not familiar with that option so I need to investigate.
>
> We've got several tests failing after making x-oob unconditional; here's
> another thread:
>
> https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg05587.html
>
> Could it be that the test was using some sort of QMP command as an
> attempt to synchronize state, but the OOB handling is now making it not
> a reliable sync point?

093 submits several I/O requests using aio_read and aio_write with
hmp_qemu_io(), then advances the clock using clock_step and finally
calls query-blockstats to see how much of the I/O has been completed
(it's an I/O throttling test).

The expectation is that by the time query-blockstats is called all
submitted I/O requests have been processed (up to the amount allowed by
the throttling limits).

Are the QMP (hmp_qemu_io, query-blockstats) and qtest (clock_step)
sockets maybe running in different threads?

Berto
