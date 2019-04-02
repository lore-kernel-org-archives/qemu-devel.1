Received: from eggs.gnu.org ([209.51.188.92]:54508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1hBDa9-0006tr-6G
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 03:11:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1hBDa8-00075C-3R
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 03:11:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54404)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pkrempa@redhat.com>) id 1hBDa7-00072N-Lh
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 03:11:40 -0400
Date: Tue, 2 Apr 2019 09:11:31 +0200
From: Peter Krempa <pkrempa@redhat.com>
Message-ID: <20190402071131.GC2686@andariel.pipo.sk>
References: <0259E1C966E8C54AA93AA2B1240828E65D08A619@dggeml509-mbx.china.huawei.com>
	<20190318131914.GH10608@angien.pipo.sk>
	<0259E1C966E8C54AA93AA2B1240828E65D08F146@dggeml509-mbx.china.huawei.com>
	<20190329073629.GC4288@angien.pipo.sk>
	<0259E1C966E8C54AA93AA2B1240828E65D0A8D5F@dggeml509-mbx.china.huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Clx92ZfkiYIKRjnr"
Content-Disposition: inline
In-Reply-To: <0259E1C966E8C54AA93AA2B1240828E65D0A8D5F@dggeml509-mbx.china.huawei.com>
Subject: Re: [Qemu-devel] [libvirt] Can jobs suck like qemu-pr-helper does
 be transfered to libvirtd?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Zhangbo (Oscar)" <oscar.zhangbo@huawei.com>
Cc: "libvir-list@redhat.com" <libvir-list@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>


--Clx92ZfkiYIKRjnr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 02, 2019 at 06:44:13 +0000, Zhangbo (Oscar) wrote:
> >[...]
> >
> >> >>This does not play well with the fact that processes as the PR helper
> >> >>are always required.
> >> >>
> >> >>Merging them into libvirtd would make the VM stop until libvirtd is
> >> >>running again. Additionally if any of the operations require persist=
ent
> >> >>kernel state as e.g. file descriptors, this would be impossible as
> >> >>stopping libvirtd process would close the FDs which may be then
> >> >>impossible to reopen properly e.g. due to state.
> >> >
> >> >Thanks! Besides these reasons above, will it weaken security if we le=
t libvirtd
> >do
> >> >these jobs? For example,
> >> >Such sayings, like "libvirtd would become the focus from attacking fo=
rces",
> >make
> >> >sense?
> >>
> >> If there's no security concern, then, will it be OK to add a new KVM i=
octl, which
> >allows
> >> qemu to ask kvm module to do the high prilidged jobs?
> >
> >Well there actually is security concern in qemu. Libvirt attempts to run
> >qemu with the least amount of privileges possible as the 'untrusted'
> >guest interacts directly with qemu.
> >
> >That is in the end the reason 'qemu-pr-helper' exists separately.
>=20
> Then, suppose we have this scenario:
> 1 Inside the guest,  the user binds certain irqs to certain vcpus
> 2 qemu helps to bind the irqs to the pcpus

Binding virtual cpus to physical cpus is usually done via libvirt at
this point but it's not automatic. Any automatic pinning approach must
not override the pinning set on the host side.

> Besides letting another agent daemon(similar to pr-helper) to do the bind=
ing job, can
> we add a new KVM ioctl and let qemu call kvm module to do the binding job?

Your description of what you want to do is not very specific. At any
rate if the automatic setting approach has always better properties and
does not override limits configured on the host side it should be
considered as a good idea. Just don't forget that the gues OS is always
treated as untrusted so you should make sure that any input you consider
=66rom the guest is treated as such.

Depending on "realtimeness" requirements of the operation you want to do
bud did not describe properly any of the approaches you describe may
make sense. One other, if the operation is not critical and thus can
wait is to implement it via a QMP event + query command where libvirt
can respond do that.

The situation really depends on what you are doing. In case of the
pr-helper it is not possible to wait for libvirt to do it as it has IO
implications.


--Clx92ZfkiYIKRjnr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUn7DGLvflazX+2GwHGwCByjY1GoFAlyjCx4ACgkQHGwCByjY
1Gr6Ug//dkNNOS6Pu3+hSWQUKc04Vp0hIKdwKgR9gWJS6v5wpqnPSnnyYv0ju0nH
LxLULGwgXvQWi8WmOCbMSS4NXMsutdk5I1i/0xvLzMIqMDBTuvD2L+z+dQMhDpLn
Gjyc4cIobGywmet+DdeQwG76iXxNor+xmpaL9Y6mVV1g+ohRLnFJZnPsdfRJM0pE
k/sQtcBuqJ44Bwe3vyOT5taO5XAfRL/BGP7flon9uZmC8CCRfmaXIgRcwN22uU2N
BbJiTwZdIJMtT3zdJUWmaTufGI0w8VYMqQkXUGVBhEuW8ehu+eTd5E+3zlG1n+RK
JzAFTiYmUMxeyAJgthjH3BaUeK/va+19OjbaClsbZ+IsWb+IYTHkahkgqCGRiAau
4EVdiPP0UsBIsf4B/wy1FK6kirT0NRJhWRaYHDzWj7hpI1mYsYxIbBd4WMClJKRO
FQr+STLEperiW12AcHddWQKtlHQhRRyhh7EAvc3DXe1nMzoYgPRlce8uGBUEFawJ
YZS3EBj1rFrpZn5WS8bfeseXyeTquNGkpplCG7Y2N/HzAPZPqK7Zu2NiP6qfc/JF
zC9mJvVpz0kWR2lcUtk0FM66pEU3hOqo2kKOPKtqwHmYMNR0lgqK4hN10i7plRzp
duWV2bygXJEtssrPzVuxaxBHnRuHCov/z/Su5ZHcCb6sr930SUs=
=S0oE
-----END PGP SIGNATURE-----

--Clx92ZfkiYIKRjnr--
