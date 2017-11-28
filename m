Received: from eggs.gnu.org ([2001:4830:134:3::10]:39557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eJjTj-0000yD-JA
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 12:15:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eJjTb-0005it-3D
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 12:15:23 -0500
References: <20171128154350.21504-1-kwolf@redhat.com>
	<20171128154350.21504-4-kwolf@redhat.com>
	<9bd2921d-64c6-724c-0d80-b43e33f41817@redhat.com>
	<20171128162850.GF3703@localhost.localdomain>
	<20171128164210.GG25110@localhost.localdomain>
	<73fda5ef-429b-1310-255f-0f37b7e3a325@redhat.com>
	<20171128170902.GH25110@localhost.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b55ab5e2-9aa0-c11b-5212-39d0a40e68d5@redhat.com>
Date: Tue, 28 Nov 2017 18:14:54 +0100
MIME-Version: 1.0
In-Reply-To: <20171128170902.GH25110@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.11 3/4] coroutine: Cancel
 aio_co_schedule() on direct entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

On 28/11/2017 18:09, Jeff Cody wrote:
>> Yes, terminating a scheduled coroutine is a bug; same for scheduling a
>> terminated coroutine, both orders are wrong. However, "unscheduling" i=
s
>> not the solution; you would just be papering over the issue.
>
> Maybe we should at least add an abort on coroutine termination if there=
 are
> still outstanding schedules, as that is preferable to operating in the
> weeds.

Sure, why not.  I'm all for adding more assertions (not less :)).

>> aio_co_schedule() on a running coroutine can only happen when the
>> coroutine is going to yield soon.
>>
> That is a bit vague.  What is "soon", and how does an external caller k=
now
> if a coroutine is going to yield in this timeframe?

Soon really means "eventually"; basically if you do

	f();
	qemu_coroutine_yield();

then f() can call aio_co_wake() or aio_co_schedule() and knows that it
will be entirely thread-safe.

However, remember that only one aio_co_schedule() can be pending at a
single time; so if you have

	f();
	g();
	qemu_coroutine_yield();

either f() or g() can wake you up but not both.

Thanks,

Paolo
