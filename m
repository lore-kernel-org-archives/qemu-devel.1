Received: from eggs.gnu.org ([2001:4830:134:3::10]:47072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1daeKE-0004QU-IY
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 04:39:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1daeKA-0005DW-D2
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 04:39:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44242)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1daeKA-0005Cr-3y
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 04:39:14 -0400
Message-ID: <1501144750.27172.1.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 27 Jul 2017 10:39:10 +0200
In-Reply-To: <1419439438.19249924.1501100483485.JavaMail.zimbra@redhat.com>
References: <CAGCz3vu5x59+mKg8011=DRyZQKbuBV2F20ZpPnG1TOCxsOb+mQ@mail.gmail.com>
	<CAGCz3vvBDC0cYY_kmgoCn1D1j9RLAda646n_NTuVq6PQF1qNmw@mail.gmail.com>
	<9767baed-582d-8aab-f9a6-0d04d7ec9d23@redhat.com>
	<165445ef-c2fb-f49e-8185-2a8af0e27bf2@redhat.com>
	<a92581c5-87b8-26d0-15d3-33ea6e87d442@redhat.com>
	<20170725220150.GA2891@morn.lan>
	<8ce79be9-5512-148d-f2d4-3bb8c04d6eda@redhat.com>
	<20170726191252.GA8769@morn.lan>
	<1419439438.19249924.1501100483485.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [SeaBIOS] Commit
 77af8a2b95b79699de650965d5228772743efe84 breaks Windows 2000 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Kevin O'Connor <kevin@koconnor.net>
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, seabios@seabios.org, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>, Programmingkid <programmingkidx@gmail.com>, Phil Dennis-Jordan <lists@philjordan.eu>, Igor Mammedov <imammedo@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Richard Henderson <rth@twiddle.net>

  Hi,

> > SeaBIOS is used with both modern and legacy OSes, and it doesn't
> > have
> > any knowledge about what kind of OS will be used.=C2=A0=C2=A0If anyth=
ing, I'd
> > argue that QEMU has more knowledge about the guest OS than SeaBIOS
> > does (due to command-line options like machine version).
>=20
> No, the machine type is independent from the guest OS.

Well, not really.  Old guests (winxp & older) don't do very well on pc.
 Modern ones are better served with q35, because they either don't boot
on pc (macos I think) or can use the features of the modern hardware,
like pci express.

I still like the idea to have pc machine type provide the older stuff.=20
The hardware we emulate for the pc machine type is old enough that old
acpi versions should have no problems describing it.

> > A - It would require deploying SeaBIOS and QEMU in lock-step.=C2=A0=C2=
=A0To
> > get
> > =C2=A0=C2=A0=C2=A0=C2=A0this in for QEMU v2.10 would require making Q=
EMU changes during
> > =C2=A0=C2=A0=C2=A0=C2=A0the soft freeze and would require a SeaBIOS "=
stable" release
> > that
> > =C2=A0=C2=A0=C2=A0=C2=A0introduces ACPI table manipulation.
>=20
> Yes.

Since the switch to qemu-generated acpi tables we were able to avoid
that kind of lockstep updates, I'd prefer to not loose that.

> > B - I don't have full confidence the proposed ACPI changes wont
> > expose
> > =C2=A0=C2=A0=C2=A0=C2=A0a quirk in some obscure OS from the last 25 y=
ears.=C2=A0=C2=A0If it does
> > =C2=A0=C2=A0=C2=A0=C2=A0expose a quirk, any work-around would likely =
require deploying
> > a
> > =C2=A0=C2=A0=C2=A0=C2=A0new SeaBIOS and QEMU in lock-step.
>=20
> Well, the solution is proposed by ACPI itself, and the worst that can
> happen is that some OS prefers the RSDT to the XSDT (which we already
> test on Windows 2000).
>=20
> > C - We'd be introducing "shared ownership" of the acpi
> > tables.=C2=A0=C2=A0Some
> > =C2=A0=C2=A0=C2=A0=C2=A0of the tables would be produced by QEMU and s=
ome of them by
> > =C2=A0=C2=A0=C2=A0=C2=A0SeaBIOS.=C2=A0=C2=A0Explaining when and why t=
o future developers would be
> > a
> > =C2=A0=C2=A0=C2=A0=C2=A0challenge.
>=20
> The advantage is that the same shared ownership is already present in
> OVMF.=C2=A0=C2=A0The RSDP/RSDT/XSDT are entirely created by the firmwar=
e in
> OVMF.

Hmm, seabios could do the same then, and we would not need a lockstep
update?

cheers,
  Gerd
