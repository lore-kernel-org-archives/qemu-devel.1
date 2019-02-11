Received: from eggs.gnu.org ([209.51.188.92]:36938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gt8Ky-0001BW-7p
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 04:57:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gt8Kw-0000P3-Td
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 04:57:15 -0500
MIME-Version: 1.0
References: <20190206174328.9736-1-marcandre.lureau@redhat.com>
	<20190206174328.9736-4-marcandre.lureau@redhat.com>
	<20190207181415.07d0d7ae.cohuck@redhat.com>
	<20190211071235.GE1011@xz-x1>
In-Reply-To: <20190211071235.GE1011@xz-x1>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 11 Feb 2019 10:57:01 +0100
Message-ID: <CAJ+F1CJ_ND3u4jZTOJSbsS=ZwvzR-y9NYYkCX5HdoKDDRKwKvw@mail.gmail.com>
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

On Mon, Feb 11, 2019 at 8:13 AM Peter Xu <peterx@redhat.com> wrote:
>
> On Thu, Feb 07, 2019 at 06:14:15PM +0100, Cornelia Huck wrote:
> > On Wed,  6 Feb 2019 18:43:25 +0100
> > Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:
> >
> > > terminal3270 uses the front-end side of the chardev. It shouldn't
> > > create sources from backend side context (with backend
> > > functions).
> > >
> > > send_timing_mark_cb calls qemu_chr_fe_write_all() which should be
> > > thread safe.
> > >
> > > This partially reverts changes from commit
> > > 2c716ba1506769c9be2caa02f0f6d6e7c00f4304.
> > >
> > > CC: Peter Xu <peterx@redhat.com>
> > > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > > ---
> > >  hw/char/terminal3270.c | 15 ++++++---------
> > >  1 file changed, 6 insertions(+), 9 deletions(-)
> >
> > I've verified that 3270 continues to work as before.
> >
> > Acked-by: Cornelia Huck <cohuck@redhat.com>
>
> A pure question: is it broken before this patch?

No

>
> Asked since I don't understand this patch and what it tries to fix...

A front-end shouldn't use backend functions.

> E.g., in terminal_init(), qemu_chr_fe_set_handlers() is always passing
> NULL as chardev context so AFAICT this patch changes nothing from
> functional-wise for now.  Meanwhile, if we pass in some non-NULL into
> it in the future, IMHO this patch would break it instead of fixing
> anything... anything I've missed?
>

If the frontend switches the context and creates timers with this
context, it should do it without using the backend functions.

thanks

--=20
Marc-Andr=C3=A9 Lureau
