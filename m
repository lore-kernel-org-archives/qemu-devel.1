Received: from eggs.gnu.org ([2001:4830:134:3::10]:55629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imbrenda@linux.vnet.ibm.com>) id 1dG6q8-0005vD-7C
	for qemu-devel@nongnu.org; Wed, 31 May 2017 12:51:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imbrenda@linux.vnet.ibm.com>) id 1dG6q4-0002gc-AI
	for qemu-devel@nongnu.org; Wed, 31 May 2017 12:51:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41286)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imbrenda@linux.vnet.ibm.com>)
	id 1dG6q4-0002gK-0y
	for qemu-devel@nongnu.org; Wed, 31 May 2017 12:51:16 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4VGmf8o075478
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 12:51:14 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2asu6vbb82-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 12:51:13 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <imbrenda@linux.vnet.ibm.com>;
	Wed, 31 May 2017 17:51:11 +0100
Date: Wed, 31 May 2017 18:51:06 +0200
From: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
In-Reply-To: <20170531183324.03bf98fe@bahia.lan>
References: <20170531150933.10156-1-alex.bennee@linaro.org>
	<20170531150933.10156-3-alex.bennee@linaro.org>
	<20170531181737.230cbded@p-imbrenda.boeblingen.de.ibm.com>
	<20170531183324.03bf98fe@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Message-Id: <20170531185106.126f19ac@p-imbrenda.boeblingen.de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v1 2/2] gdbstub: don't fail on vCont; C04:0;
 c packets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>, pbonzini@redhat.com, doug16k@gmail.com, qemu-devel@nongnu.org

On Wed, 31 May 2017 18:33:24 +0200
Greg Kurz <groug@kaod.org> wrote:

> On Wed, 31 May 2017 18:17:37 +0200
> Claudio Imbrenda <imbrenda@linux.vnet.ibm.com> wrote:
>=20
> > On Wed, 31 May 2017 16:09:33 +0100
> > Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
> >  =20
> > > The thread-id of 0 means any CPU but we then ignore the fact we
> > > find the first_cpu in this case who can have an index of 0.
> > > Instead of bailing out just test if we have managed to match up
> > > thread-id to a CPU.
> > >=20
> > > Otherwise you get:
> > >   gdb_handle_packet: command=3D'vCont;C04:0;c'
> > >   put_packet: reply=3D'E22'
> > >=20
> > > Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> > > ---
> > >  gdbstub.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/gdbstub.c b/gdbstub.c
> > > index a249846954..29c9ed3002 100644
> > > --- a/gdbstub.c
> > > +++ b/gdbstub.c
> > > @@ -934,8 +934,8 @@ static int gdb_handle_vcont(GDBState *s, const
> > > char *p)
> > >               * CPU first, and only then we can use its index.
> > >               */
> > >              cpu =3D find_cpu(idx);
> > > -            /* invalid CPU/thread specified */
> > > -            if (!idx || !cpu) {
> > > +            /* invalid thread specified, cpu not found. */
> > > +            if (!cpu) {
> > >                  res =3D -EINVAL;
> > >                  goto out;
> > >              }   =20
> >=20
> > This is strange. cpu_index() is defined as:
> >=20
> > static inline int cpu_index(CPUState *cpu)
> > {
> > #if defined(CONFIG_USER_ONLY)
> >     return cpu->host_tid;
> > #else
> >     return cpu->cpu_index + 1;
> > #endif
> > }
> >=20
> > therefore it shouldn't return 0 under any circumstance, and =20
>=20
> I think it is 0 for first_cpu in user mode.

in linux-user/syscall.c:

info->tid =3D gettid();
cpu->host_tid =3D info->tid;

kernel thread-ids are system-wide unique and can't be 0
=20
> > find_cpu(idx) should also fail if idx =3D=3D 0, because internally it
> > also uses cpu_index()
> >=20
> > on the other hand, you say that the patch does fix the problem for
> > you, which really confuses me.
> >=20
> >=20
> >=20
> > (probably) completely unrelatedly, this:
> >=20
> > res =3D qemu_strtoul(p + 1, &p, 16, &tmp);
> >=20
> > should be like this instead:
> >=20
> > res =3D qemu_strtoul(p, &p, 16, &tmp);
> >=20
> > but this shouldn't impact you in any way.
> >=20
> >=20
> >  =20
>=20
