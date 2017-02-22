Received: from eggs.gnu.org ([2001:4830:134:3::10]:47422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cgbBa-0006tW-9q
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 12:58:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cgbBX-0004WP-8z
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 12:58:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55538)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cgbBX-0004WD-44
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 12:58:39 -0500
Date: Wed, 22 Feb 2017 17:58:33 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170222175832.GB2352@work-vm>
References: <20170222162507.25987-1-alex.bennee@linaro.org>
	<CAFEAcA8VQAE9_THkm45SS5YoO8cAnf60bCJ4iTaoH+6aL-Qo3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAFEAcA8VQAE9_THkm45SS5YoO8cAnf60bCJ4iTaoH+6aL-Qo3w@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hmp: add PC information for ARM vCPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

* Peter Maydell (peter.maydell@linaro.org) wrote:
> On 22 February 2017 at 16:25, Alex Benn=E9e <alex.bennee@linaro.org> wr=
ote:
> > Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
> > ---
> >  cpus.c           |  6 ++++++
> >  hmp.c            |  3 +++
> >  qapi-schema.json | 14 +++++++++++++-
> >  3 files changed, 22 insertions(+), 1 deletion(-)
> >
> > diff --git a/cpus.c b/cpus.c
> > index 559a0805bc..dc8dbfb0f0 100644
> > --- a/cpus.c
> > +++ b/cpus.c
> > @@ -1869,6 +1869,9 @@ CpuInfoList *qmp_query_cpus(Error **errp)
> >  #elif defined(TARGET_TRICORE)
> >          TriCoreCPU *tricore_cpu =3D TRICORE_CPU(cpu);
> >          CPUTriCoreState *env =3D &tricore_cpu->env;
> > +#elif defined(TARGET_AARCH64)
> > +        ARMCPU *arm_cpu =3D ARM_CPU(cpu);
> > +        CPUARMState *env =3D &arm_cpu->env;
> >  #endif
> >
> >          cpu_synchronize_state(cpu);
> > @@ -1896,6 +1899,9 @@ CpuInfoList *qmp_query_cpus(Error **errp)
> >  #elif defined(TARGET_TRICORE)
> >          info->value->arch =3D CPU_INFO_ARCH_TRICORE;
> >          info->value->u.tricore.PC =3D env->PC;
> > +#elif defined(TARGET_AARCH64)
> > +        info->value->arch =3D CPU_INFO_ARCH_ARM;
> > +        info->value->u.arm.pc =3D env->pc;
> >  #else
> >          info->value->arch =3D CPU_INFO_ARCH_OTHER;
> >  #endif
>=20
> My standard reaction when I see patches adding another
> arm to a target-ifdef ladder like this is to ask whether
> we can refactor this so that the target-specific
> code lives in target/$ARCH instead...

It feels like that should be possible with PC; but then you get
the weird outliers; x86 that adds in CS, but OK that could be wrapped
up in a target function; and then SPARC that's got pc and npc
just to be different.

Dave

> thanks
> -- PMM
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
