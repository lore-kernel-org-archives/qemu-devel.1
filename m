Received: from eggs.gnu.org ([2001:4830:134:3::10]:52603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ft7oa-0006e3-HZ
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 04:51:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ft7oZ-0002Du-Lj
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 04:51:32 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36317)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1ft7oZ-0002Dc-E8
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 04:51:31 -0400
Received: by mail-wr1-x443.google.com with SMTP id m27-v6so6821819wrf.3
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 01:51:31 -0700 (PDT)
MIME-Version: 1.0
References: <20180823143125.16767-1-marcandre.lureau@redhat.com>
	<20180824034517.GF24044@xz-x1>
	<CAMxuvayHnOM1_iGPqg5MBxhYa_Mz=S-jC5z_Tp_UmwvLo0Zu-Q@mail.gmail.com>
	<20180824084454.GA3020@xz-x1>
In-Reply-To: <20180824084454.GA3020@xz-x1>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 24 Aug 2018 10:51:18 +0200
Message-ID: <CAJ+F1CLBGcc0B+BQTZh8KLhqPr7PAf4mDLb81nQSVmiZxK7Anw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/5] Fix socket chardev regression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU <qemu-devel@nongnu.org>

Hi

On Fri, Aug 24, 2018 at 10:45 AM Peter Xu <peterx@redhat.com> wrote:
>
> On Fri, Aug 24, 2018 at 10:32:58AM +0200, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Fri, Aug 24, 2018 at 5:45 AM, Peter Xu <peterx@redhat.com> wrote:
> > > On Thu, Aug 23, 2018 at 04:31:20PM +0200, Marc-Andr=C3=A9 Lureau wrot=
e:
> > >> Hi,
> > >>
> > >> In commit 25679e5d58e "chardev: tcp: postpone async connection setup=
"
> > >> (and its follow up 99f2f54174a59), Peter moved chardev socket
> > >> connection to machine_done event. However, chardev created later wil=
l
> > >> no longer attempt to connect, and chardev created in tests do not ha=
ve
> > >> machine_done event (breaking some of vhost-user-test).
> > >>
> > >> The goal was to move the "connect" source to the chardev frontend
> > >> context (the monitor thread context in his case). chr->gcontext is s=
et
> > >> with qemu_chr_fe_set_handlers(). But there is no guarantee that the
> > >> function will be called in general, so we can't delay connection unt=
il
> > >> then: the chardev should still attempt to connect during open(), usi=
ng
> > >> the main context.
> > >>
> > >> An alternative would be to specify the iothread during chardev
> > >> creation. Setting up monitor OOB would be quite different too, it
> > >> would take the same iothread as argument.
> > >>
> > >> 99f2f54174a595e is also a bit problematic, since it will behave
> > >> differently before and after machine_done (the first case gives a
> > >> chance to use a different context reliably, the second looks racy)
> > >>
> > >> In the end, I am not sure this is all necessary, as chardev callback=
s
> > >> are called after qemu_chr_fe_set_handlers(), at which point the
> > >> context of sources are updated. In "char-socket: update all ioc
> > >> handlers when changing context", I moved also the hup handler to the
> > >> updated context. So unless the main thread is already stuck, we can
> > >> setup a different context for the chardev at that time. Or not?
> > >>
> > >> v2:
> > >> - fix a random socket chardev test failure
> > >
> > > I have no problem on patch 3-5, but aren't patch 1-2 still breaking
> > > the context switch of chardev?  Or did I misunderstood?
> >
> > Switching context is broken/racy regardless. My current plan is to
> > suspend the context to switch to, and update all sources before
> > thawing the target context.
> >
> > If you prefer we can delay the revert, but I would rather have them
> > because the regression seems much worse to me.
>
> Have you started working on above?  I started to code up some RFC
> patch to let the chardev maintain the iothreads (now it'll only have a
> monitor iothread) then we don't need to switch context for chardev any
> more.  I plan to post it today for a quick look.  With that, this
> series will not break anything then.

No, I haven't really started the code, but spent some time thinking...

Ok, if you manage to put together that proposal, that sounds interesting.

Nevertheless, I can work on improving/fixing the race when switching
contexts (already used by colo)

>
> >
> > >
> > > Regards,
> > >
> > > --
> > > Peter Xu
>
> Regards,
>
> --
> Peter Xu
>


--=20
Marc-Andr=C3=A9 Lureau
