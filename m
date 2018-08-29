Received: from eggs.gnu.org ([2001:4830:134:3::10]:39101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fv3Fn-0006I3-Kt
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 12:23:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fv3Fi-0003lj-UJ
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 12:23:35 -0400
Date: Wed, 29 Aug 2018 18:23:19 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180829182319.4dd00611.cohuck@redhat.com>
In-Reply-To: <877ek9883z.fsf@dusky.pond.sub.org>
References: <20180828123346.17548-1-cohuck@redhat.com>
	<20180828123346.17548-3-cohuck@redhat.com>
	<877ek9883z.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/3] qemu-error: make use of {error,
 warn}_report_once_cond
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>

On Wed, 29 Aug 2018 18:12:32 +0200
Markus Armbruster <armbru@redhat.com> wrote:

> Cornelia Huck <cohuck@redhat.com> writes:
>=20
> > {error,warn}_report_once() are a special case of the new functions
> > and can simply switch to them.
> >
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > ---
> >  include/qemu/error-report.h | 10 ++--------
> >  1 file changed, 2 insertions(+), 8 deletions(-)
> >
> > diff --git a/include/qemu/error-report.h b/include/qemu/error-report.h
> > index d2a6515e68..4e4c0e757c 100644
> > --- a/include/qemu/error-report.h
> > +++ b/include/qemu/error-report.h
> > @@ -58,10 +58,7 @@ void warn_report_once_cond(bool *printed, const char=
 *fmt, ...)
> >          static bool print_once_;                \
> >          bool ret_print_once_ =3D !print_once_;    \
> >                                                  \
> > -        if (!print_once_) {                     \
> > -            print_once_ =3D true;                 \
> > -            error_report(fmt, ##__VA_ARGS__);   \
> > -        }                                       \
> > +        error_report_once_cond(&print_once_, fmt, ##__VA_ARGS__); \
> >          unlikely(ret_print_once_);              \
> >      })
> > =20
> > @@ -74,10 +71,7 @@ void warn_report_once_cond(bool *printed, const char=
 *fmt, ...)
> >          static bool print_once_;                \
> >          bool ret_print_once_ =3D !print_once_;    \
> >                                                  \
> > -        if (!print_once_) {                     \
> > -            print_once_ =3D true;                 \
> > -            warn_report(fmt, ##__VA_ARGS__);    \
> > -        }                                       \
> > +        warn_report_once_cond(&print_once_, fmt, ##__VA_ARGS__); \
> >          unlikely(ret_print_once_);              \
> >      }) =20
>=20
> Hmm.  The macros return a value, while the functions do not.  Doesn't
> this contradict the commit message's claim the macros are =C3=A4 special =
case
> of the new functions"?
>=20
> If you make the functions return the value, too, the macros become
> simpler.  Moving complexity from macros to functions feels like a good
> deal, even when it's just a little bit of complexity like here.

Reducing macro complexity is a good idea, agreed.

Thanks for looking!
