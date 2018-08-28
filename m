Received: from eggs.gnu.org ([2001:4830:134:3::10]:33368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fub7L-0001KG-Lb
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 06:21:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fub7I-0002Mu-EL
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 06:20:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38002 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fub7I-0002MJ-8G
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 06:20:56 -0400
Date: Tue, 28 Aug 2018 18:20:51 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180828102051.GF4446@xz-x1>
References: <20180827222322.26009-1-marcandre.lureau@redhat.com>
	<20180827222322.26009-7-marcandre.lureau@redhat.com>
	<20180828035232.GD4446@xz-x1>
	<CAJ+F1C+fe4QGZmvtw76SQH=pqu6Nwure+CVPXBT_deHKgE5n0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJ+F1C+fe4QGZmvtw76SQH=pqu6Nwure+CVPXBT_deHKgE5n0Q@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 6/9] terminal3270: do not use backend timer
 sources
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>

On Tue, Aug 28, 2018 at 11:09:28AM +0200, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Tue, Aug 28, 2018 at 5:52 AM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Tue, Aug 28, 2018 at 12:23:19AM +0200, Marc-Andr=C3=A9 Lureau wrot=
e:
> > > terminal3270 is uses the front-end side of the chardev. It shouldn'=
t
> > > create sources from backend side context. Fwiw, send_timing_mark_cb
> > > calls qemu_chr_fe_write_all() which should be thread safe.
> > >
> > > This partially reverts changes from commit
> > > 2c716ba1506769c9be2caa02f0f6d6e7c00f4304.
> >
> > I don't fully understand too on why "It shouldn't create sources from
> > backend side context".  Could you explain a bit?
>=20
> A frontend shouldn't use a backend function, and doesn't have to use
> the backend gmaincontext.
>=20
> >
> > If you don't want the backend gcontext to be exposed to the frontend,
> > IMHO the simplest thing is just to use the NULL gcontext in
> > qemu_chr_timeout_add_ms() which is a one-liner change. I don't see
> > much point on re-using the GSource tags since IMHO GSource pointer is
> > always superior to the old tag system.
>=20
> Using the tag or the GSource * doesn't change much afaik.

I did some convertions in the past year to convert tag -> GSource and
that shows some differences when we want non-default gcontexts...
Otherwise I won't bother. :)

> Not only
> this is not a hot path, but glib gmain code does create the tag on
> attach anyway. You may be marginally faster on remove/detach by
> avoiding one lookup.
>=20
> (btw, I think both tag and GSource* are as old)

I am not strong on this, but my rule is that if I don't have explicit
reason to change a code I keep it there.  Here I don't see an obvious
reason to switch back to the tag things (not to mention that I still
think GSource is better, always).

Thanks,

--=20
Peter Xu
