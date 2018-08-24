Received: from eggs.gnu.org ([2001:4830:134:3::10]:38375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ftCIB-0000l2-Ad
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 09:38:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ftCCc-0000u4-Fr
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 09:32:39 -0400
MIME-Version: 1.0
References: <20180817171932.31976-1-marcandre.lureau@redhat.com>
	<20180817171932.31976-3-marcandre.lureau@redhat.com>
	<87d0u8b2u8.fsf@dusky.pond.sub.org>
	<CAJ+F1CLVBmcqa0Rz_=KJY9VphbwxhFWrqWtGnc4kTu61BJOjDg@mail.gmail.com>
	<87sh337v8x.fsf@dusky.pond.sub.org>
In-Reply-To: <87sh337v8x.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 24 Aug 2018 15:32:24 +0200
Message-ID: <CAJ+F1C++Vudnf-E+-NCFjN8mKTtQL-mFFj3uRT4Q7=JE=0YfrA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] qobject: modify qobject_ref() to
 assert on NULL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, "open list:Block layer core" <qemu-block@nongnu.org>, QEMU <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>

Hi
On Fri, Aug 24, 2018 at 3:24 PM Markus Armbruster <armbru@redhat.com> wrote=
:
>
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:
>
> > Hi
> > On Fri, Aug 24, 2018 at 10:12 AM Markus Armbruster <armbru@redhat.com> =
wrote:
> >>
> >> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
> >>
> >> > While it may be convenient to accept NULL value in
> >> > qobject_unref() (for similar reasons as free() accepts NULL), it is
> >> > not such a good idea for qobject_ref(): now assert() on NULL.
> >>
> >> Why is it not such a good idea?
> >>
> >> Is it unsafe?  Unclean?  Ugly?
> >>
> >> If unsafe, can you point to actual problems, present or past?
> >>
> >> If you consider it unclean or ugly, can you point to established
> >> convention?
> >
> > In general, a function/method shouldn't accept NULL as argument, as it
> > is usually a programmer mistake.
>
> There are certainly plenty of specific functions where the claim is
> true.  But a blanket claim like yours need to be supported by evidence.

There is no evidence for such claim, only idiomatic code or common
patterns. It's clear when the caller handles/expects NULL cases.
That's what the patch does, there are a few places where this is made
explicit, and imho that improves readability.

For ex:
            evstate->data =3D qobject_ref(data);

You might assume, by just reading that line, that evstate->data !=3D NULL.

But if you rewrite:

            evstate->data =3D data ? qobject_ref(data) : NULL;

Then it's clear that field accpets both cases, and programmer has
thought about that case, it's not handled by mistake (where it could
be a bug).


>
> > free() / unref() are exceptions, for convenience.
>
> Here's the argument for cleanup functions accepting null pointers.
>
> Having cleanup functions reject null pointers complicates cleanup for no
> gain.  Examples of this are everywhere.  Common pattern:
>
>     T1 *v1 =3D NULL;
>     ...
>     Tn *vn =3D NULL;
>
>     ... do stuff, create v1, ..., vn, goto out on error ...
>
> out:
>     T1_cleanup(v1);
>     ...
>     Tn_cleanup(vn);
>
> Guarding the Ti_cleanup() with if (vi) clutters the code.  Moving the
> guard into the Ti_cleanup() is an obvious improvement.
>
> Conversely, examples where a cleanup function rejecting null would catch
> actual mistakes do not come to mind.
>
> qobject_unref() is an instance of this pattern.
>
> qobject_ref() isn't, but there are similarities.  Again, examples exist
> where rejecting null buys us nothing but additional code to guard the
> call.  These are visible in your patch.  And again, examples where
> rejecting null would catch mistakes do not come to (my) mind.  That's
> why I'm asking for them.
>
> > fwiw, g_object_ref/unref() do not accept NULL. However,
> > g_clear_object() was introduced later to simply clearing an object
> > reference (unref and set to NULL, checks NULL).
>
> [...]



--=20
Marc-Andr=C3=A9 Lureau
