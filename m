Received: from eggs.gnu.org ([209.51.188.92]:55491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gx77P-00068M-LS
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 04:27:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gx77O-0004Hz-7I
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 04:27:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46052)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gx77M-0003pG-Tb
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 04:27:41 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2A6B7307D985
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 09:27:11 +0000 (UTC)
References: <20190222031413.20250-1-peterx@redhat.com>
	<20190222031413.20250-2-peterx@redhat.com>
	<CAMxuvayiNpRqudM9Ex_3MDYuTvcs3ya-tHmoAhWvCEu70WzUOA@mail.gmail.com>
	<20190222063658.GF8904@xz-x1>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <057fcf24-4a21-b6ad-0bfc-af2308f24cb1@redhat.com>
Date: Fri, 22 Feb 2019 10:27:01 +0100
MIME-Version: 1.0
In-Reply-To: <20190222063658.GF8904@xz-x1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/4] iothread: replace init_done_cond with
 a semaphore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>

On 22/02/19 07:36, Peter Xu wrote:
> On Fri, Feb 22, 2019 at 07:25:16AM +0100, Marc-Andr=C3=A9 Lureau wrote:
>> Hi
>>
>> On Fri, Feb 22, 2019 at 4:14 AM Peter Xu <peterx@redhat.com> wrote:
>>>
>>> Only sending an init-done message using lock+cond seems an overkill t=
o
>>> me.  Replacing it with a simpler semaphore.
>>>
>>> Meanwhile, init the semaphore unconditionally, then we can destroy it
>>> unconditionally too in finalize which seems cleaner.
>>>
>>> Signed-off-by: Peter Xu <peterx@redhat.com>
>>
>> The lock is also protecting thread_id.
>=20
> IMHO it's fine because thread_id is only changed at the beginning of
> iothread_run where the caller will definitely wait for the thread_id
> to be generated.  Here qemu_sem_post() should at least contain one
> write memory barrier there to make sure the waker will read the
> correct value after sem_wait() and then later on thread_id is never
> changed.

Yes, qemu_sem_post() is a "release" operation.  Anything that happens
before it is visible to the thread that does qemu_sem_wait().

In fact, thread_id is accessed outside the lock in
iothread_instance_finalize, so Peter's change is overall an improvement.

Paolo
