Received: from eggs.gnu.org ([209.51.188.92]:36997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gx7OL-0003aD-E6
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 04:45:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gx7OJ-0008Iu-AJ
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 04:45:13 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:53105)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gx7OI-0007u7-Pr
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 04:45:11 -0500
Received: by mail-wm1-x342.google.com with SMTP id m1so1349948wml.2
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 01:44:40 -0800 (PST)
MIME-Version: 1.0
References: <20190222031413.20250-1-peterx@redhat.com>
	<20190222031413.20250-2-peterx@redhat.com>
	<CAMxuvayiNpRqudM9Ex_3MDYuTvcs3ya-tHmoAhWvCEu70WzUOA@mail.gmail.com>
	<20190222063658.GF8904@xz-x1>
	<057fcf24-4a21-b6ad-0bfc-af2308f24cb1@redhat.com>
In-Reply-To: <057fcf24-4a21-b6ad-0bfc-af2308f24cb1@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 22 Feb 2019 10:44:27 +0100
Message-ID: <CAJ+F1CKuhVQjx1mQd0TXDt2FAfREZL45GPPuiqNxw+-Fa721ew@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

Hi

On Fri, Feb 22, 2019 at 10:33 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 22/02/19 07:36, Peter Xu wrote:
> > On Fri, Feb 22, 2019 at 07:25:16AM +0100, Marc-Andr=C3=A9 Lureau wrote:
> >> Hi
> >>
> >> On Fri, Feb 22, 2019 at 4:14 AM Peter Xu <peterx@redhat.com> wrote:
> >>>
> >>> Only sending an init-done message using lock+cond seems an overkill t=
o
> >>> me.  Replacing it with a simpler semaphore.
> >>>
> >>> Meanwhile, init the semaphore unconditionally, then we can destroy it
> >>> unconditionally too in finalize which seems cleaner.
> >>>
> >>> Signed-off-by: Peter Xu <peterx@redhat.com>
> >>
> >> The lock is also protecting thread_id.
> >
> > IMHO it's fine because thread_id is only changed at the beginning of
> > iothread_run where the caller will definitely wait for the thread_id
> > to be generated.  Here qemu_sem_post() should at least contain one
> > write memory barrier there to make sure the waker will read the
> > correct value after sem_wait() and then later on thread_id is never
> > changed.
>
> Yes, qemu_sem_post() is a "release" operation.  Anything that happens
> before it is visible to the thread that does qemu_sem_wait().

ok

> In fact, thread_id is accessed outside the lock in
> iothread_instance_finalize, so Peter's change is overall an improvement.
>

finalize() stops the threadm though


--=20
Marc-Andr=C3=A9 Lureau
