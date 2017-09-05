Received: from eggs.gnu.org ([2001:4830:134:3::10]:51469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dpDvZ-0001NX-RT
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 09:30:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dpDvU-0004G9-7U
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 09:30:05 -0400
MIME-Version: 1.0
References: <CAJ+F1C+mPu9ftXwgs4UrGTQp4f65-thhvmWoB-kuRmu0=vnFFw@mail.gmail.com>
	<87zia9palk.fsf@dusky.pond.sub.org>
In-Reply-To: <87zia9palk.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 05 Sep 2017 13:29:48 +0000
Message-ID: <CAJ+F1CJaxdbHnLQy6H=5=Q3ZMw0w01xsvK3ybhj80=6F9dR6gQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] clang-tidy: use g_new() family of functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, qemu trival <qemu-trivial@nongnu.org>

Hi

On Tue, Sep 5, 2017 at 2:56 PM Markus Armbruster <armbru@redhat.com> wrote:

> Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:
>
> > Hi,
> >
> > I have a series of changes generated with clang-tidy qemu [1] pending
> > for review [2].
> >
> > It translates calloc/*malloc*/*realloc() calls to
> > g_new/g_newa/g_new0/g_renew() where the argument is a sizeof(T) [* N].
>
> Only for *type* T, or for arbitrary T?
>
>
If sizeof() argument is a type:
https://github.com/elmarco/clang-tools-extra/blob/master/clang-tidy/qemu/Us=
eGnewCheck.cpp#L65

For type T, we've done the transformation repeatedly with Coccinelle,
> first in commit b45c03f (commit message appended).  Repeatedly, because
> they creep back in.
>
> How does your technique compare to this prior one?
>

Well, for one, I have a lot of trouble running coccinelle, mostly because
it is slow and/or eat all my memory. Afaik, coccinelle also has trouble
parsing the code in various cases. I have also trouble writing coccinelle
semantic patch... And, I gave up.

clang-tidy in comparison, is quite fast (it takes a minute to apply on qemu
code base). I find it easier to write a tidy check, and more friendly
command line / output etc:

/tmp/test.c:3:17: warning: use g_new() instead [qemu-use-gnew]
        int *f =3D (int*)malloc(sizeof(int) * 2);
                 ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~
                 g_new(int, 2)

clang-tidy should also respect clang-format rules when modifying the code
(see also
https://lists.nongnu.org/archive/html/qemu-devel/2017-08/msg05762.html).

I also imagine it should be possible to integrate to clang warnings in the
future (similar to libreoffice clang plugins for ex). All in all,
coccinelle or clang-tidy are probably both capable of doing this job, but
clang-tidy is snappier and has more potentials for toolchain integration.

> This is the first commit to give you an idea:
> >
> > diff --git a/hw/timer/arm_timer.c b/hw/timer/arm_timer.c
> > index 98fddd7ac1..75affcb8a6 100644
> > --- a/hw/timer/arm_timer.c
> > +++ b/hw/timer/arm_timer.c
> > @@ -166,7 +166,7 @@ static arm_timer_state *arm_timer_init(uint32_t fre=
q)
> >      arm_timer_state *s;
> >      QEMUBH *bh;
> >
> > -    s =3D (arm_timer_state *)g_malloc0(sizeof(arm_timer_state));
> > +    s =3D g_new0(arm_timer_state, 1);
> >      s->freq =3D freq;
> >      s->control =3D TIMER_CTRL_IE;
> >
> > g_new() advantages (from glib doc):
> > - the returned pointer is cast to a pointer to the given type.
> > - care is taken to avoid overflow when calculating the size of the
> > allocated block.
> >
> > But it is also shorter&nicer :)
> >
> > I have not included in the first batch the opportunity to also
> > translate: alloc(sizeof(*p) * x) to g_new(typeof(*p), x), since it is
> > arguably not much nicer. But for consistency, I think it would be good
> > to use g_new(). What do you think?
>
> p =3D g_malloc(sizeof(*p)) is idiomatic, and not obviously inferior to
> p =3D g_new(T, 1), where T is the type of *p.  Use whatever is easier to
> read, I guess.
>
> But once you add multiplication, g_new() adds something useful: overflow
> protection.  Conversion to g_new() might make sense then.
>
> > I splitted the changes amont the various MAINTAINERS entries, but it
> > is still about 70 patches (without the typeof() changes).
> >
> >
> > [1] https://github.com/elmarco/clang-tools-extra/
> > [2] https://github.com/elmarco/qemu/commits/gnew
>
>
> commit b45c03f585ea9bb1af76c73e82195418c294919d
> Author: Markus Armbruster <armbru@redhat.com>
> Date:   Mon Sep 7 10:39:27 2015 +0100
>
>     arm: Use g_new() & friends where that makes obvious sense
>
>     g_new(T, n) is neater than g_malloc(sizeof(T) * n).  It's also safer,
>     for two reasons.  One, it catches multiplication overflowing size_t.
>     Two, it returns T * rather than void *, which lets the compiler catch
>     more type errors.
>
>     This commit only touches allocations with size arguments of the form
>     sizeof(T).
>
>     Coccinelle semantic patch:
>
>         @@
>         type T;
>         @@
>         -g_malloc(sizeof(T))
>         +g_new(T, 1)
>         @@
>         type T;
>         @@
>         -g_try_malloc(sizeof(T))
>         +g_try_new(T, 1)
>

thanks, I actually forgot the g_try_new() family (I thought we didn't use
it!)

        @@
>         type T;
>         @@
>         -g_malloc0(sizeof(T))
>         +g_new0(T, 1)
>         @@
>         type T;
>         @@
>         -g_try_malloc0(sizeof(T))
>         +g_try_new0(T, 1)
>         @@
>         type T;
>         expression n;
>         @@
>         -g_malloc(sizeof(T) * (n))
>         +g_new(T, n)
>         @@
>         type T;
>         expression n;
>         @@
>         -g_try_malloc(sizeof(T) * (n))
>         +g_try_new(T, n)
>         @@
>         type T;
>         expression n;
>         @@
>         -g_malloc0(sizeof(T) * (n))
>         +g_new0(T, n)
>         @@
>         type T;
>         expression n;
>         @@
>         -g_try_malloc0(sizeof(T) * (n))
>         +g_try_new0(T, n)
>         @@
>         type T;
>         expression p, n;
>         @@
>         -g_realloc(p, sizeof(T) * (n))
>         +g_renew(T, p, n)
>         @@
>         type T;
>         expression p, n;
>         @@
>         -g_try_realloc(p, sizeof(T) * (n))
>         +g_try_renew(T, p, n)
>         @@
>         type T;
>         expression n;
>         @@
>         -(T *)g_new(T, n)
>         +g_new(T, n)
>         @@
>         type T;
>         expression n;
>         @@
>         -(T *)g_new0(T, n)
>         +g_new0(T, n)
>         @@
>         type T;
>         expression p, n;
>         @@
>         -(T *)g_renew(T, p, n)
>         +g_renew(T, p, n)
>
>     Signed-off-by: Markus Armbruster <armbru@redhat.com>
>     Reviewed-by: Eric Blake <eblake@redhat.com>
>     Message-id: 1440524394-15640-1-git-send-email-armbru@redhat.com
>     Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>
--=20
Marc-Andr=C3=A9 Lureau
