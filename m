Received: from eggs.gnu.org ([2001:4830:134:3::10]:52267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1etCnt-0006Uq-By
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:38:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1etCnq-0002Jz-5S
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:38:53 -0500
Date: Tue, 6 Mar 2018 13:38:42 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180306133842.GH6163@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180306132430.32110-1-berrange@redhat.com>
	<CAFEAcA95xt-9MJHcRC7WovEB3W259_eFD7Q8v_pG5rGh3L7oCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA95xt-9MJHcRC7WovEB3W259_eFD7Q8v_pG5rGh3L7oCg@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] misc: don't use hwaddr as a type in trace
 events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

On Tue, Mar 06, 2018 at 01:33:42PM +0000, Peter Maydell wrote:
> On 6 March 2018 at 13:24, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
> > Use types that are defined by QEMU in trace events caused build failu=
res
> > for the UST trace backend:
> >
> >   In file included from trace-ust-all.c:13:0:
> >   trace-ust-all.h:11844:206: error: unknown type name =E2=80=98hwaddr=
=E2=80=99
> >
> > It only knows about C built-in types, and any types that are pulled i=
n
> > from includs of qemu-common.h and lttng/tracepoint.h. This does not
> > include the 'hwaddr' type, so replace it with a uint64_t which is wha=
t
> > exec/hwaddr.h defines 'hwaddr' as. This fixes the build failure
> > introduced by
> >
> >   commit 9eb8040c2d2b38e1a40bb6129b1b668fa178fcab
> >   Author: Peter Maydell <peter.maydell@linaro.org>
> >   Date:   Fri Mar 2 10:45:39 2018 +0000
> >
> >     hw/misc/tz-ppc: Model TrustZone peripheral protection controller
> >
> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > ---
>=20
> Oops.
>=20
> > --- a/hw/misc/trace-events
> > +++ b/hw/misc/trace-events
> > @@ -92,8 +92,8 @@ tz_ppc_cfg_sec_resp(int level) "TZ PPC: cfg_sec_res=
p =3D %d"
> >  tz_ppc_irq_enable(int level) "TZ PPC: int_enable =3D %d"
> >  tz_ppc_irq_clear(int level) "TZ PPC: int_clear =3D %d"
> >  tz_ppc_update_irq(int level) "TZ PPC: setting irq line to %d"
> > -tz_ppc_read_blocked(int n, hwaddr offset, bool secure, bool user) "T=
Z PPC: port %d offset 0x%" HWADDR_PRIx " read (secure %d user %d) blocked=
"
> > -tz_ppc_write_blocked(int n, hwaddr offset, bool secure, bool user) "=
TZ PPC: port %d offset 0x%" HWADDR_PRIx " write (secure %d user %d) block=
ed"
> > +tz_ppc_read_blocked(int n, uint64_t offset, bool secure, bool user) =
"TZ PPC: port %d offset 0x%" HWADDR_PRIx " read (secure %d user %d) block=
ed"
> > +tz_ppc_write_blocked(int n, uint64_t offset, bool secure, bool user)=
 "TZ PPC: port %d offset 0x%" HWADDR_PRIx " write (secure %d user %d) blo=
cked"
>=20
>=20
> If the type isn't "hwaddr" then HWADDR_PRIx is the wrong
> format string macro -- those should change to PRIx64.

Eeek, that HWADDR_PRIx macro is used throughout this file, sometimes
even with uint32_t as the arg !

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
