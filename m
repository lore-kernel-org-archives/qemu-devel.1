Received: from eggs.gnu.org ([209.51.188.92]:36736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gj9He-00057o-W0
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 15:56:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gj9Hc-0002lP-3W
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 15:56:34 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20190114163117.GA521@stefanha-x1.localdomain>
References: <20190109110144.18633-1-stefanha@redhat.com>
	<w51pnt57slp.fsf@maestria.local.igalia.com>
	<w51tvifqqlr.fsf@maestria.local.igalia.com>
	<20190111132416.GI5010@dhcp-200-186.str.redhat.com>
	<w51pnt3qo27.fsf@maestria.local.igalia.com>
	<20190114133553.GE7038@stefanha-x1.localdomain>
	<w51won7480o.fsf@maestria.local.igalia.com>
	<20190114161525.GA32304@stefanha-x1.localdomain>
	<w51zhs32ojb.fsf@maestria.local.igalia.com>
	<20190114163117.GA521@stefanha-x1.localdomain>
Date: Mon, 14 Jan 2019 21:56:28 +0100
Message-ID: <w51h8eb7ybn.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] throttle-groups: fix restart coroutine
 iothread race
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Mon 14 Jan 2019 05:31:17 PM CET, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> On Mon, Jan 14, 2019 at 05:26:48PM +0100, Alberto Garcia wrote:
>> On Mon 14 Jan 2019 05:15:25 PM CET, Stefan Hajnoczi wrote:
>> >> > I've been able to reproduce this in an iotest, please see v2 of this
>> >> > series.
>> >> 
>> >> That iotest doesn't crash for me :-?
>> >
>> > Does my iotest pass for you?
>> 
>> Yes, it does. I'm trying to figure out why because if I run the QMP
>> commands by hand then it does crash.
>
> I ran the iotest 20 times on my machine and it segfaulted every time
> (with the fix not yet applied).

Yeah I can also reproduce it all the time if I run it by hand...

I was debugging it and although I don't know why this is different when
I run it through tests/qemu-iotests/check, here's why it doesn't crash:

After the ThrottleGroupMember is unregistered and its BlockBackend is
destroyed, the throttle_group_co_restart_queue() coroutine takes
control.

The first thing that it does is lock tgm->throttled_reqs_lock. It turns
out that although this memory has been freed (it's part of the
BlockBackend struct) it is still accessible but contains pure
gargabe. 'Garbage' here means that the mutex counter contains some
random value != 0, so the thread waits, it doesn't have a chance to
crash the process, and QEMU shuts down cleanly.

So if my understanding is correct QEMU can be shut down when there are
iothreads waiting for a mutex. Is that something that we should be
worried about?

Berto
