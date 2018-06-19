Received: from eggs.gnu.org ([2001:4830:134:3::10]:49777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fVFxJ-00089k-K0
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 08:41:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fVFxG-0000pz-HJ
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 08:41:53 -0400
Received: from 3.mo179.mail-out.ovh.net ([178.33.251.175]:45693)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fVFxG-0000p6-Ax
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 08:41:50 -0400
Received: from player739.ha.ovh.net (unknown [10.109.120.89])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 92AAFD2261
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 14:41:48 +0200 (CEST)
Date: Tue, 19 Jun 2018 14:41:38 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180619144138.4ccbe186@bahia.lan>
In-Reply-To: <87sh5jvw3r.fsf@dusky.pond.sub.org>
References: <20180619085631.2859-1-aik@ozlabs.ru>
	<87sh5jvw3r.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH qemu] xics-kvm: Fix compile
 warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On Tue, 19 Jun 2018 13:44:56 +0200
Markus Armbruster <armbru@redhat.com> wrote:

> Alexey Kardashevskiy <aik@ozlabs.ru> writes:
>=20
> > This fixes uninitialized variable warning:
> >
> > /home/aik/p/qemu/hw/intc/xics_kvm.c: In function =E2=80=98ics_set_kvm_s=
tate=E2=80=99:
> > /home/aik/p/qemu/hw/intc/xics_kvm.c:281:20: warning: =E2=80=98ret=E2=80=
=99 may be used uninitialized in this function [-Wmaybe-uninitialized]
> >              return ret;
> >                     ^~~
> >
> > Discovered with gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0 from Ubuntu 18.04.
> >
> > Fixes: bf358b541b8 "xics_kvm: use KVM helpers"
> > Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> > ---
> >  hw/intc/xics_kvm.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
> > index 8bdf6af..48efbce 100644
> > --- a/hw/intc/xics_kvm.c
> > +++ b/hw/intc/xics_kvm.c
> > @@ -273,8 +273,8 @@ static int ics_set_kvm_state(ICSState *ics, int ver=
sion_id)
> >                  state |=3D KVM_XICS_QUEUED;
> >          }
> > =20
> > -        kvm_device_access(kernel_xics_fd, KVM_DEV_XICS_GRP_SOURCES,
> > -                          i + ics->offset, &state, true, &local_err);
> > +        ret =3D kvm_device_access(kernel_xics_fd, KVM_DEV_XICS_GRP_SOU=
RCES,
> > +                                i + ics->offset, &state, true, &local_=
err);
> >          if (local_err) {
> >              error_report("Unable to restore KVM interrupt controller s=
tate"
> >                      " for IRQs %d: %s", i + ics->offset, strerror(errn=
o)); =20
>                return ret;
>            }
>=20
> Unless all callers effectively ignore the return value, this fixes a
> bug, not just a compiler warning.  Recommend to check callers to find
> the bug's impact, and document it in your commit message.
>=20

This function has two users:
1) ics_kvm_reset() which ignores it's return value (ie, not impacted)
2) ics_simple_dispatch_post_load() which propagates the return value to
  vmstate_load_state()

If ret is < 0, migration will fail as expected, possibly with an
'Unknow error' message.

If ret >=3D 0, it will creep up to:

static int
qemu_loadvm_section_start_full(QEMUFile *f, MigrationIncomingState *mis)
{
[...]
    ret =3D vmstate_load(f, se);
    if (ret < 0) {
        error_report("error while loading state for instance 0x%x of"
                     " device '%s'", instance_id, idstr);
        return ret;
    }
    if (!check_section_footer(f, se)) {
        return -EINVAL;
    }

    return 0;
}

and migration would likely succeed but leave the guest in an undefined
state.

> Messed up in commit bf358b541b8.  Would be nice to mention that in your
> commit message.
>=20
> Also messed up there: leaks local_err.  Please fix that, too.
>=20

Both the missing 'ret =3D' and local_err leak are addressed by:

https://lists.nongnu.org/archive/html/qemu-ppc/2018-06/msg00682.html

It doesn't mention the offending commit though...
