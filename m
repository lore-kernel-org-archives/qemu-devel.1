Received: from eggs.gnu.org ([2001:4830:134:3::10]:37642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gL78c-0001H6-M2
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 08:47:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gL78X-0007hU-Ri
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 08:47:54 -0500
Date: Fri, 9 Nov 2018 14:47:19 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181109144719.4680ccc9.cohuck@redhat.com>
In-Reply-To: <87wopy5a21.fsf@linaro.org>
References: <20181025144644.15464-1-cota@braap.org>
	<20181025144644.15464-24-cota@braap.org>
	<8736sm857y.fsf@linaro.org> <20181031163846.GC15881@flamenco>
	<87wopy5a21.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v4 24/71] s390x: convert to cpu_halted
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>
Cc: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On Wed, 31 Oct 2018 16:56:54 +0000
Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:

> Emilio G. Cota <cota@braap.org> writes:
>=20
> > On Wed, Oct 31, 2018 at 16:13:05 +0000, Alex Benn=C3=A9e wrote: =20
> >> > @@ -353,10 +355,12 @@ void s390_cpu_unhalt(S390CPU *cpu)
> >> >      CPUState *cs =3D CPU(cpu);
> >> >      trace_cpu_unhalt(cs->cpu_index);
> >> >
> >> > -    if (cs->halted) {
> >> > -        cs->halted =3D 0;
> >> > +    cpu_mutex_lock(cs);
> >> > +    if (cpu_halted(cs)) {
> >> > +        cpu_halted_set(cs, 0);
> >> >          cs->exception_index =3D -1;
> >> >      }
> >> > +    cpu_mutex_unlock(cs); =20
> >>
> >> I think this locking is superfluous as you already added locking when
> >> you introduced the helper. =20
> >
> > It gives a small perf gain, since it avoids locking & unlocking twice
> > in a row (cpu_halted and cpu_halted_set both take the lock if needed). =
=20
>=20
> Maybe a one line comment then above the first lock:
>=20
>   /* lock outside cpu_halted(_set) to avoid bouncing */
>=20
> Or some such.....

Yes, please.

Or introduce something like cpu_halted_flip(cs, new_state) where you
could convert the above to

if (cpu_halted_flip(cs, 0)) { /* cpu halted before */
    cs_exception_index =3D -1;
}

Or is that actually an uncommon pattern?

>=20
> > =20
> >> Otherwise:
> >>
> >> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org> =20
> >
> > Thanks!
> >
> > 		Emilio =20
>=20
>=20
> --
> Alex Benn=C3=A9e
