Received: from eggs.gnu.org ([209.51.188.92]:44137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gt8wB-0000wH-VY
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 05:35:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gt8wA-0001SD-So
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 05:35:43 -0500
MIME-Version: 1.0
References: <20190206174328.9736-1-marcandre.lureau@redhat.com>
	<20190206174328.9736-4-marcandre.lureau@redhat.com>
	<20190207181415.07d0d7ae.cohuck@redhat.com>
	<20190211071235.GE1011@xz-x1>
	<CAJ+F1CJ_ND3u4jZTOJSbsS=ZwvzR-y9NYYkCX5HdoKDDRKwKvw@mail.gmail.com>
	<20190211102713.GG1011@xz-x1>
In-Reply-To: <20190211102713.GG1011@xz-x1>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 11 Feb 2019 11:35:28 +0100
Message-ID: <CAJ+F1CKQk8qhJ8b6o=h53fiZ5_7R4LXJu1=NbyyeP_AFidcNSA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 3/6] terminal3270: do not use backend
 timer sources
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, QEMU <qemu-devel@nongnu.org>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "open list:S390" <qemu-s390x@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

Hi

On Mon, Feb 11, 2019 at 11:27 AM Peter Xu <peterx@redhat.com> wrote:
>
> On Mon, Feb 11, 2019 at 10:57:01AM +0100, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Mon, Feb 11, 2019 at 8:13 AM Peter Xu <peterx@redhat.com> wrote:
> > >
> > > On Thu, Feb 07, 2019 at 06:14:15PM +0100, Cornelia Huck wrote:
> > > > On Wed,  6 Feb 2019 18:43:25 +0100
> > > > Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:
> > > >
> > > > > terminal3270 uses the front-end side of the chardev. It shouldn't
> > > > > create sources from backend side context (with backend
> > > > > functions).
> > > > >
> > > > > send_timing_mark_cb calls qemu_chr_fe_write_all() which should be
> > > > > thread safe.
> > > > >
> > > > > This partially reverts changes from commit
> > > > > 2c716ba1506769c9be2caa02f0f6d6e7c00f4304.
> > > > >
> > > > > CC: Peter Xu <peterx@redhat.com>
> > > > > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.co=
m>
> > > > > ---
> > > > >  hw/char/terminal3270.c | 15 ++++++---------
> > > > >  1 file changed, 6 insertions(+), 9 deletions(-)
> > > >
> > > > I've verified that 3270 continues to work as before.
> > > >
> > > > Acked-by: Cornelia Huck <cohuck@redhat.com>
> > >
> > > A pure question: is it broken before this patch?
> >
> > No
> >
> > >
> > > Asked since I don't understand this patch and what it tries to fix...
> >
> > A front-end shouldn't use backend functions.
> >
> > > E.g., in terminal_init(), qemu_chr_fe_set_handlers() is always passin=
g
> > > NULL as chardev context so AFAICT this patch changes nothing from
> > > functional-wise for now.  Meanwhile, if we pass in some non-NULL into
> > > it in the future, IMHO this patch would break it instead of fixing
> > > anything... anything I've missed?
> > >
> >
> > If the frontend switches the context and creates timers with this
> > context, it should do it without using the backend functions.
>
> I see your point (assuming that concurrent writes are safe).  But IMHO
> we should first discuss on how to fix the existing multi-threading
> issues (since it's not really safe yet).  After all this patch offers

Yes, various people are looking at this problem. We need to fix it.

> nothing real for us for now, and if one day we want to run the chardev
> in a single thread again then this will just break again unnoticed.
>

I assume you are not speaking about that patch in particular, when you
say it will "break again unnoticed".

This patch helps when you do whole-tree code review or change over a
particular aspect of the backend code. In my case, I wrote this patch
because I did a review of all the backend context users. And this one
is a "bad" user, I think you agree by now. So let's apply this change.
And let's focus on multi-thread bugs in respective threads.

thanks


--=20
Marc-Andr=C3=A9 Lureau
