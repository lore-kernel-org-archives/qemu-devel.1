Received: from eggs.gnu.org ([2001:4830:134:3::10]:39226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dkSmp-0007PO-JG
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 06:21:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dkSmk-0006cx-Kp
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 06:21:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33322)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1dkSmk-0006aQ-C5
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 06:21:18 -0400
Date: Wed, 23 Aug 2017 06:21:16 -0400 (EDT)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <2076518614.2481492.1503483676829.JavaMail.zimbra@redhat.com>
In-Reply-To: <20170822184213.GH19998@localhost.localdomain>
References: <20170822132255.23945-1-marcandre.lureau@redhat.com>
	<20170822132255.23945-54-marcandre.lureau@redhat.com>
	<20170822184213.GH19998@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 53/54] qapi: make
 query-cpu-model-expansion depend on s390 or x86
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>

Hi

----- Original Message -----
> On Tue, Aug 22, 2017 at 03:22:54PM +0200, Marc-Andr=C3=A9 Lureau wrote:
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  qapi-schema.json                       |  4 +++-
> >  include/sysemu/arch_init.h             |  3 ---
> >  monitor.c                              |  3 ---
> >  qmp.c                                  |  7 -------
> >  stubs/arch-query-cpu-model-expansion.c | 12 ------------
> >  target/i386/cpu.c                      |  2 +-
> >  target/s390x/cpu_models.c              |  3 ++-
> >  stubs/Makefile.objs                    |  1 -
> >  8 files changed, 6 insertions(+), 29 deletions(-)
> >  delete mode 100644 stubs/arch-query-cpu-model-expansion.c
> >=20
> > diff --git a/qapi-schema.json b/qapi-schema.json
> > index 6c1adb35b5..127a2c71c6 100644
> > --- a/qapi-schema.json
> > +++ b/qapi-schema.json
> > @@ -4535,7 +4535,9 @@
> >  { 'command': 'query-cpu-model-expansion',
> >    'data': { 'type': 'CpuModelExpansionType',
> >              'model': 'CpuModelInfo' },
> > -  'returns': 'CpuModelExpansionInfo' }
> > +  'returns': 'CpuModelExpansionInfo',
> > +  'if': ['defined(NEED_CPU_H)',
> > +         'defined(TARGET_S390X) || defined(TARGET_I386)']}
>=20
> Maybe this is already documented somewhere in the series (I'm
> still going through the other patches), but: why exactly is
> 'defined(NEED_CPU_H)' in the list, too?

The point of this series is to make qapi schema configurable.

Some types/commands/events are target-specifc. In order to #ifdef on poisoi=
ned symbols, we make most of QAPI generated code built per-target in patch =
49/54. But the common code still need to compile some units, that's why #if=
def NEED_CPU_U. The clean solution is probably to split the generated schem=
a to common & per-target, that's not covered in the series.

>=20
> I always assumed that all the QAPI and QMP dispatching code would
> be compiled only once, and never be compiled with -DNEED_CPU_H
> defined.

No longer after 49/54.
