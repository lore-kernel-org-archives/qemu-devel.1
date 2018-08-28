Received: from eggs.gnu.org ([2001:4830:134:3::10]:39290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fubT6-0001vj-Cp
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 06:43:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fubQG-0006Xu-Q5
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 06:40:33 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36344)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fubQG-0006TZ-Gf
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 06:40:32 -0400
Received: by mail-wr1-x441.google.com with SMTP id m27-v6so1109439wrf.3
	for <qemu-devel@nongnu.org>; Tue, 28 Aug 2018 03:40:32 -0700 (PDT)
MIME-Version: 1.0
References: <20180827222322.26009-1-marcandre.lureau@redhat.com>
	<20180827222322.26009-7-marcandre.lureau@redhat.com>
	<20180828035232.GD4446@xz-x1>
	<CAJ+F1C+fe4QGZmvtw76SQH=pqu6Nwure+CVPXBT_deHKgE5n0Q@mail.gmail.com>
	<20180828102051.GF4446@xz-x1>
In-Reply-To: <20180828102051.GF4446@xz-x1>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 28 Aug 2018 12:40:19 +0200
Message-ID: <CAJ+F1CLnBd_dfhdARaD-qzC5qhb-tw-ZMgBur9=2u9Bx_M31SQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Peter Xu <peterx@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>

Hi

On Tue, Aug 28, 2018 at 12:20 PM Peter Xu <peterx@redhat.com> wrote:
>
> On Tue, Aug 28, 2018 at 11:09:28AM +0200, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Tue, Aug 28, 2018 at 5:52 AM Peter Xu <peterx@redhat.com> wrote:
> > >
> > > On Tue, Aug 28, 2018 at 12:23:19AM +0200, Marc-Andr=C3=A9 Lureau wrot=
e:
> > > > terminal3270 is uses the front-end side of the chardev. It shouldn'=
t
> > > > create sources from backend side context. Fwiw, send_timing_mark_cb
> > > > calls qemu_chr_fe_write_all() which should be thread safe.
> > > >
> > > > This partially reverts changes from commit
> > > > 2c716ba1506769c9be2caa02f0f6d6e7c00f4304.
> > >
> > > I don't fully understand too on why "It shouldn't create sources from
> > > backend side context".  Could you explain a bit?
> >
> > A frontend shouldn't use a backend function, and doesn't have to use
> > the backend gmaincontext.
> >
> > >
> > > If you don't want the backend gcontext to be exposed to the frontend,
> > > IMHO the simplest thing is just to use the NULL gcontext in
> > > qemu_chr_timeout_add_ms() which is a one-liner change. I don't see
> > > much point on re-using the GSource tags since IMHO GSource pointer is
> > > always superior to the old tag system.
> >
> > Using the tag or the GSource * doesn't change much afaik.
>
> I did some convertions in the past year to convert tag -> GSource and
> that shows some differences when we want non-default gcontexts...
> Otherwise I won't bother. :)

It doesn't need a specific context here, does it?

>
> > Not only
> > this is not a hot path, but glib gmain code does create the tag on
> > attach anyway. You may be marginally faster on remove/detach by
> > avoiding one lookup.
> >
> > (btw, I think both tag and GSource* are as old)
>
> I am not strong on this, but my rule is that if I don't have explicit
> reason to change a code I keep it there.  Here I don't see an obvious
> reason to switch back to the tag things (not to mention that I still
> think GSource is better, always).

As I explained, you shouldn't use backend fonctions in the frontend,
and there is no reason to use the backend context. I try to keep all
the sources created around chardev under control, and this one is
incorrect imho.

Using g_timeout_add() is convenient, since it does all the work you do
manually by creating a source, setting callback, attaching, unref etc.
And it uses the default context, which is in general the right thing.

I can do all the manual work and keep the GSource* around, but I don't
think that helps in any way here.


>
> Thanks,
>
> --
> Peter Xu



--=20
Marc-Andr=C3=A9 Lureau
