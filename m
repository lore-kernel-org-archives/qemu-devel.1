Received: from eggs.gnu.org ([2001:4830:134:3::10]:58233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dG1GF-00012I-Cb
	for qemu-devel@nongnu.org; Wed, 31 May 2017 06:53:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dG1GE-0007gt-1m
	for qemu-devel@nongnu.org; Wed, 31 May 2017 06:53:55 -0400
Received: from mail-lf0-x22b.google.com ([2a00:1450:4010:c07::22b]:36850)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dG1GD-0007gZ-Mk
	for qemu-devel@nongnu.org; Wed, 31 May 2017 06:53:53 -0400
Received: by mail-lf0-x22b.google.com with SMTP id h4so6675593lfj.3
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 03:53:53 -0700 (PDT)
MIME-Version: 1.0
References: <20170509173559.31598-1-marcandre.lureau@redhat.com>
	<20170509173559.31598-8-marcandre.lureau@redhat.com>
	<87tw4mgr07.fsf@dusky.pond.sub.org>
	<CAJ+F1CKctXGjPOghFGXQTyTdT9Oaxn8w3x0N+L5vBp4m8U4XCA@mail.gmail.com>
	<8760ghfidl.fsf@dusky.pond.sub.org>
In-Reply-To: <8760ghfidl.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 31 May 2017 10:53:41 +0000
Message-ID: <CAJ+F1C+w-7Vc3qz-SK4qJGUNLJTNSkN-6s9d82L3bb5Y1pbHLg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 07/17] json: learn to parse uint64 numbers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org

Hi

On Wed, May 31, 2017 at 2:08 PM Markus Armbruster <armbru@redhat.com> wrote=
:

> Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:
>
> > Hi
> >
> > On Mon, May 15, 2017 at 6:00 PM Markus Armbruster <armbru@redhat.com>
> wrote:
> >
> >> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
> >>
> >> > Switch strtoll() usage to qemu_strtoi64() helper while at it.
> >> >
> >> > Replace temporarily the error in qnum_get_int() with values >INT64_M=
AX
> >> > until the visitor is updated.
> >> >
> >> > Add a few tests for large numbers.
> >> >
> >> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> [...]
> >> > diff --git a/qobject/qnum.c b/qobject/qnum.c
> >> > index be6307accf..2f87952db8 100644
> >> > --- a/qobject/qnum.c
> >> > +++ b/qobject/qnum.c
> >> > @@ -76,8 +76,8 @@ int64_t qnum_get_int(const QNum *qn, Error **errp)
> >> >          return qn->u.i64;
> >> >      case QNUM_U64:
> >> >          if (qn->u.u64 > INT64_MAX) {
> >> > -            error_setg(errp, "The number is too large, use
> qnum_get_uint()");
> >> > -            return 0;
> >> > +            /* temporarily accepts to cast to i64 until visitor is
> switched */
> >> > +            error_report("The number is too large, use
> qnum_get_uint()");
> >>
> >> Awkward.  Can we avoid this somehow?
> >>
> >>
> > by merging the next two patches? I think it's easier to understand why
> and
> > how I came up with the following fix.
>
> I played with it a bit.  Here's something that appears to do the trick:
>
> PATCH 07: Drop changes to qobject/qnum.c tests/check-qnum.c
>           Move change to tests/test-qobject-input-visitor.c to PATCH 08
> PATCH 08: Move PATCH 09's change to hw/i386/acpi-build.c here
> PATCH 09: No need to revert the changes dropped in PATCH 07; patch is
>           now empty
>
> Less churn, no temporary breakage, same end result.
>

ok


>
> Pushed as branch hack-qapi-qnum for your convenience:
> https://repo.or.cz/qemu/armbru.git/shortlog/refs/heads/hack-qapi-qnum
>
> Original is on branch review-qapi-qnum.
>
>
thanks that helped

> >> >          }
> >> >          return qn->u.u64;
> >> >      case QNUM_DOUBLE:
> [...]
>
--=20
Marc-Andr=C3=A9 Lureau
