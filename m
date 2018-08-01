Received: from eggs.gnu.org ([2001:4830:134:3::10]:36601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fknCQ-0005x1-CR
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 05:13:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fknCM-0006qs-UU
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 05:13:42 -0400
Received: from 15.mo3.mail-out.ovh.net ([87.98.150.177]:34849)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fknCM-0006qI-Nw
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 05:13:38 -0400
Received: from player734.ha.ovh.net (unknown [10.109.159.139])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id B92331C9688
	for <qemu-devel@nongnu.org>; Wed,  1 Aug 2018 11:13:36 +0200 (CEST)
Date: Wed, 1 Aug 2018 11:13:29 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180801111329.425ff0cc@bahia.lan>
In-Reply-To: <b510d9a7-fbda-b3c9-98a7-9fffee7a12cf@kaod.org>
References: <20180730141134.31153-1-clg@kaod.org>
	<20180730141134.31153-3-clg@kaod.org>
	<20180731193945.35360b15@bahia.lan>
	<20180801063823.GQ2708@umbus.fritz.box>
	<b510d9a7-fbda-b3c9-98a7-9fffee7a12cf@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 2/4] spapr: introduce a fixed IRQ number
 space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Wed, 1 Aug 2018 09:14:43 +0200
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> [ ... ]
>=20
> >>> +typedef struct sPAPRMachineState sPAPRMachineState;
> >>> + =20
> >>
> >> Old compilers (GCC < 4.6) might complain about 'redefinition of typede=
f' if
> >> some file, say hw/ppc/spapr.c, includes both this header and "hw/ppc/x=
ics.h".
> >> We had several build breaks detected by 'make docker-test-build@centos=
6'...
> >> The correct way to address this would be to move the typedef to the
> >> "qemu/typedefs.h" header.
> >>
> >> This being said, docker-test-build@centos6 vanished with commit e7b3af=
81597,
> >> so I guess we don't support such old distros anymore, and we can live =
with
> >> duplicate typedefs. =20
>=20
> I have a rhel6 vm for such tests but QEMU now requires python3 and=20
> glib-2.40 and maybe more stuff. I am not sure one can compile QEMU 3.1
> on rhel/centos 6 anymore :/
>=20

Minimal Python version is 2.7 actually, but rhel6 only has 2.6.6.

Anyway, with these new requirements, I'm pretty sure we can't build QEMU
anymore with these distros... even though rhel 6 EOL is Nov. 2020.

>=20
> [ ... ]
>=20
> >>>      /* Release previous MSIs */
> >>>      if (msi) {
> >>> +        if (!SPAPR_MACHINE_GET_CLASS(spapr)->legacy_irq_allocation) {
> >>> +            spapr_irq_msi_free(spapr, msi->first_irq, msi->num);
> >>> +        } =20
> >>
> >> SPAPR_MACHINE_GET_CLASS() does all the recursive type checking, and you
> >> call it three times. Even if this isn't a hot path, maybe cache this in
> >> an smc variable at the beginning of the function as we do pretty much
> >> everywhere else. Also this would give prettier code IMHO. =20
> >=20
> > I agree with Greg that this would be a nice improvement, but it can
> > wait until a followup. =20
>=20
> The sPAPR code base is very stable so it's not too much work to respin.
> FYI, most of the XIVE v4 patchset still applies without a change.
>=20
> Tell me if you find any other issues and I will resend.
>=20
> Thanks,
>=20
> C.
