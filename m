Received: from eggs.gnu.org ([209.51.188.92]:42885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gt8oG-0007qb-0A
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 05:27:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gt8oE-00046Z-OJ
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 05:27:31 -0500
Date: Mon, 11 Feb 2019 18:27:13 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20190211102713.GG1011@xz-x1>
References: <20190206174328.9736-1-marcandre.lureau@redhat.com>
	<20190206174328.9736-4-marcandre.lureau@redhat.com>
	<20190207181415.07d0d7ae.cohuck@redhat.com>
	<20190211071235.GE1011@xz-x1>
	<CAJ+F1CJ_ND3u4jZTOJSbsS=ZwvzR-y9NYYkCX5HdoKDDRKwKvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJ+F1CJ_ND3u4jZTOJSbsS=ZwvzR-y9NYYkCX5HdoKDDRKwKvw@mail.gmail.com>
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
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: Cornelia Huck <cohuck@redhat.com>, QEMU <qemu-devel@nongnu.org>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "open list:S390" <qemu-s390x@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On Mon, Feb 11, 2019 at 10:57:01AM +0100, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Mon, Feb 11, 2019 at 8:13 AM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Thu, Feb 07, 2019 at 06:14:15PM +0100, Cornelia Huck wrote:
> > > On Wed,  6 Feb 2019 18:43:25 +0100
> > > Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:
> > >
> > > > terminal3270 uses the front-end side of the chardev. It shouldn't
> > > > create sources from backend side context (with backend
> > > > functions).
> > > >
> > > > send_timing_mark_cb calls qemu_chr_fe_write_all() which should be
> > > > thread safe.
> > > >
> > > > This partially reverts changes from commit
> > > > 2c716ba1506769c9be2caa02f0f6d6e7c00f4304.
> > > >
> > > > CC: Peter Xu <peterx@redhat.com>
> > > > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.co=
m>
> > > > ---
> > > >  hw/char/terminal3270.c | 15 ++++++---------
> > > >  1 file changed, 6 insertions(+), 9 deletions(-)
> > >
> > > I've verified that 3270 continues to work as before.
> > >
> > > Acked-by: Cornelia Huck <cohuck@redhat.com>
> >
> > A pure question: is it broken before this patch?
>=20
> No
>=20
> >
> > Asked since I don't understand this patch and what it tries to fix...
>=20
> A front-end shouldn't use backend functions.
>=20
> > E.g., in terminal_init(), qemu_chr_fe_set_handlers() is always passin=
g
> > NULL as chardev context so AFAICT this patch changes nothing from
> > functional-wise for now.  Meanwhile, if we pass in some non-NULL into
> > it in the future, IMHO this patch would break it instead of fixing
> > anything... anything I've missed?
> >
>=20
> If the frontend switches the context and creates timers with this
> context, it should do it without using the backend functions.

I see your point (assuming that concurrent writes are safe).  But IMHO
we should first discuss on how to fix the existing multi-threading
issues (since it's not really safe yet).  After all this patch offers
nothing real for us for now, and if one day we want to run the chardev
in a single thread again then this will just break again unnoticed.

Frankly speaking I don't think making the chardev to be completely
multi-threading is very attractive to me - chardevs are mostly slow,
otherwise imho better techniques should be used (e.g., virtio).  OOB
did that majorly for only isolating chardev IOs out of main thread so
that chardevs won't be blocked by other unpredictable behaviors (like
userfaults), but it still wants to keep the old code running with as
less change as possible.  For this we can discuss in the other
thread too for sure...

Thanks,

--=20
Peter Xu
