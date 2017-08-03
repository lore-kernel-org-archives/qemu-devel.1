Received: from eggs.gnu.org ([2001:4830:134:3::10]:33309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ddH3Y-0000gW-Mp
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 10:24:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ddH3V-0007sS-Gv
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 10:24:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40096)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ddH3V-0007oE-8L
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 10:24:53 -0400
Date: Thu, 3 Aug 2017 16:24:41 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170803162441.43f84f54@gondolin>
In-Reply-To: <b999332b-aef1-6f19-0a1c-cf1d4a694b32@redhat.com>
References: <150168523493.31663.3716600121804656211.stgit@bahia.lan>
	<928f0ce3-159a-e371-6309-078fac31eace@amsat.org>
	<b999332b-aef1-6f19-0a1c-cf1d4a694b32@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] kvm: workaround build break on gcc-7.1.1 /
 fedora26
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>

On Thu, 3 Aug 2017 09:10:29 -0500
Eric Blake <eblake@redhat.com> wrote:

> On 08/03/2017 08:46 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> > Hi Greg,
> >=20
> > On 08/02/2017 11:47 AM, Greg Kurz wrote: =20
> >> Building QEMU on fedora26 with the latest gcc package fails:
> >>
> >>    CC      ppc64-softmmu/target/ppc/kvm.o
> >> In file included from include/sysemu/hw_accel.h:16:0,
> >>                   from target/ppc/kvm.c:31:
> >> target/ppc/kvm.c: In function =E2=80=98kvmppc_booke_watchdog_enable=E2=
=80=99:
> >> include/sysemu/kvm.h:449:35: error: =E2=80=98args_tmp[i]=E2=80=99 may =
be used
> >> uninitialized
> >>   in this function [-Werror=3Dmaybe-uninitialized]
> >>               cap.args[i] =3D args_tmp[i];                            =
   \
> >>                                     ^
> >> target/ppc/kvm.c: In function =E2=80=98kvmppc_set_papr=E2=80=99:
> >> include/sysemu/kvm.h:449:35: error: =E2=80=98args_tmp[i]=E2=80=99 may =
be used
> >> uninitialized
> >>   in this function [-Werror=3Dmaybe-uninitialized]
> >> cc1: all warnings being treated as errors =20
> >=20
> > I'm trying to reproduce this in our docker images (all x86_64 based) but
> > can't reproduce. =20
>=20
> That's because x86_64 hosts only call kvm_vm_enable_cap() with non-empty
> varargs. =20

There's

target/i386/kvm.c:            kvm_vcpu_enable_cap(cs, KVM_CAP_HYPERV_SYNIC,=
 0)) {

> But we have:
>=20
> accel/kvm/kvm-all.c: ret =3D kvm_vm_enable_cap(s, KVM_CAP_S390_IRQCHIP, 0=
);
>=20
> which is only compiled on s390 hosts (or, at least that's my guess,
> based on the cap name)

I don't see how the compiler can optimize this away, as the check for
this cap is an ioctl...

>  - and THAT code is passing empty varargs, which
> explains args_tmp[] being a 0-length array, and getting the compiler to
> complain about i < 0 always being false.

[I don't have any s390x system with gcc7 yet, or I'd test this.]

>=20
> So my question on IRC was whether we can stack the decks, and force a
> non-empty args_tmp =3D { 0, __VA_ARGS__} coupled by skipping the first
> iteration in the for loop.  Or, since cap.args[] is already being
> zero-initialized, args_tmp =3D { __VA_ARGS__, 0 } means the last iteration
> of the for loop is a no-op (assigning 0 to something that is already 0)
> - although that may be harder to correctly account for both empty and
> non-empty __VA_ARGS__.

This seems a bit ugly. And I still don't understand why this only seems
to hit on ppc...
