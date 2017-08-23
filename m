Received: from eggs.gnu.org ([2001:4830:134:3::10]:57674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dkWBT-0002vf-6M
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 09:59:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dkWBR-0002GT-9n
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 09:59:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:14709)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1dkWBQ-0002Fr-Ur
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 09:59:01 -0400
Date: Wed, 23 Aug 2017 09:58:59 -0400 (EDT)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <1155766546.2722774.1503496739716.JavaMail.zimbra@redhat.com>
In-Reply-To: <20170823125743.GF27715@localhost.localdomain>
References: <20170822132255.23945-1-marcandre.lureau@redhat.com>
	<20170822132255.23945-54-marcandre.lureau@redhat.com>
	<20170822184213.GH19998@localhost.localdomain>
	<2076518614.2481492.1503483676829.JavaMail.zimbra@redhat.com>
	<20170823125743.GF27715@localhost.localdomain>
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
> On Wed, Aug 23, 2017 at 06:21:16AM -0400, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >=20
> > ----- Original Message -----
> > > On Tue, Aug 22, 2017 at 03:22:54PM +0200, Marc-Andr=C3=A9 Lureau wrot=
e:
> > > > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > > > ---
> > > >  qapi-schema.json                       |  4 +++-
> > > >  include/sysemu/arch_init.h             |  3 ---
> > > >  monitor.c                              |  3 ---
> > > >  qmp.c                                  |  7 -------
> > > >  stubs/arch-query-cpu-model-expansion.c | 12 ------------
> > > >  target/i386/cpu.c                      |  2 +-
> > > >  target/s390x/cpu_models.c              |  3 ++-
> > > >  stubs/Makefile.objs                    |  1 -
> > > >  8 files changed, 6 insertions(+), 29 deletions(-)
> > > >  delete mode 100644 stubs/arch-query-cpu-model-expansion.c
> > > >=20
> > > > diff --git a/qapi-schema.json b/qapi-schema.json
> > > > index 6c1adb35b5..127a2c71c6 100644
> > > > --- a/qapi-schema.json
> > > > +++ b/qapi-schema.json
> > > > @@ -4535,7 +4535,9 @@
> > > >  { 'command': 'query-cpu-model-expansion',
> > > >    'data': { 'type': 'CpuModelExpansionType',
> > > >              'model': 'CpuModelInfo' },
> > > > -  'returns': 'CpuModelExpansionInfo' }
> > > > +  'returns': 'CpuModelExpansionInfo',
> > > > +  'if': ['defined(NEED_CPU_H)',
> > > > +         'defined(TARGET_S390X) || defined(TARGET_I386)']}
> > >=20
> > > Maybe this is already documented somewhere in the series (I'm
> > > still going through the other patches), but: why exactly is
> > > 'defined(NEED_CPU_H)' in the list, too?
> >=20
> > The point of this series is to make qapi schema configurable.
> >=20
> > Some types/commands/events are target-specifc. In order to
> > #ifdef on poisoined symbols, we make most of QAPI generated
> > code built per-target in patch 49/54. But the common code still
> > need to compile some units, that's why #ifdef NEED_CPU_U. The
> > clean solution is probably to split the generated schema to
> > common & per-target, that's not covered in the series.
>=20
> I see.  I'm worried about one thing: what if the QMP dispatch
> code is incorrectly moved back to common code later?  It will
> silently skip all the arch-dependent commands without any
> warnings.
>=20
> e.g.: I just applied the following change on top of your series,
> and all arch-dependent commands are silently skipped:
>=20

And it doesn't fail a full/all-arch make check? It probably should.

>   diff --git a/Makefile.objs b/Makefile.objs
>   index 2664720..24a4ea0 100644
>   --- a/Makefile.objs
>   +++ b/Makefile.objs
>   @@ -2,7 +2,7 @@
>    # Common libraries for tools and emulators
>    stub-obj-y =3D stubs/ crypto/
>    util-obj-y =3D util/ qobject/ qapi/
>   -util-obj-y +=3D qapi-types.o qapi-visit.o
>   +util-obj-y +=3D qmp-introspect.o qapi-types.o qapi-visit.o qapi-event.=
o
>   =20
>    chardev-obj-y =3D chardev/
>   =20
>   @@ -72,6 +72,13 @@ common-obj-y +=3D chardev/
>    common-obj-$(CONFIG_SECCOMP) +=3D qemu-seccomp.o
>   =20
>    common-obj-$(CONFIG_FDT) +=3D device_tree.o
>   +
>   +######################################################################
>   +# qapi
>   +
>   +common-obj-y +=3D qmp-marshal.o
>   +common-obj-y +=3D qmp-introspect.o
>   +common-obj-y +=3D qmp.o hmp.o
>    endif
>   =20
>    ######################################################################=
#
>   diff --git a/Makefile.target b/Makefile.target
>   index c5f8ded..7f42c45 100644
>   --- a/Makefile.target
>   +++ b/Makefile.target
>   @@ -157,10 +157,6 @@ endif
>   =20
>    GENERATED_FILES +=3D hmp-commands.h hmp-commands-info.h
>   =20
>   -obj-y +=3D qmp-introspect.o qapi-types.o qapi-visit.o qapi-event.o
>   -obj-y +=3D qmp-marshal.o qmp-introspect.o
>   -obj-y +=3D qmp.o hmp.o
>   -
>    endif # CONFIG_SOFTMMU
>   =20
>    # Workaround for http://gcc.gnu.org/PR55489, see configure.
>=20
>=20
> We wouldn't need to check NEED_CPU_H at all if the condition on
> QMP commands affect only the actual QMP dispatch code, and not
> the generated types or declarations.  e.g.:
>=20

Possible, but is it desirable? I would prefer if all the generated code wou=
ld be configured, so we can more easily compile out dead code when disablin=
g a feature.=20

>=20
> diff --git a/qapi-schema.json b/qapi-schema.json
> index 194859f..67b46ad 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -3578,7 +3578,7 @@
>  ##
>  { 'command': 'dump-skeys',
>    'data': { 'filename': 'str' },
> -  'if': ['defined(NEED_CPU_H)', 'defined(TARGET_S390X)']}
> +  'if': ['defined(TARGET_S390X)']}
> =20
>  ##
>  # @netdev_add:
> @@ -4434,8 +4434,7 @@
>  # Since: 1.2.0
>  ##
>  { 'command': 'query-cpu-definitions', 'returns': ['CpuDefinitionInfo'],
> -  'if': ['defined(NEED_CPU_H)',
> -         'defined(TARGET_PPC) || defined(TARGET_ARM) || defined(TARGET_I=
386)
> || defined(TARGET_S390X)'] }
> +  'if': ['defined(TARGET_PPC) || defined(TARGET_ARM) || defined(TARGET_I=
386)
> || defined(TARGET_S390X)'] }
> =20
>  ##
>  # @CpuModelInfo:
> @@ -4538,8 +4537,7 @@
>    'data': { 'type': 'CpuModelExpansionType',
>              'model': 'CpuModelInfo' },
>    'returns': 'CpuModelExpansionInfo',
> -  'if': ['defined(NEED_CPU_H)',
> -         'defined(TARGET_S390X) || defined(TARGET_I386)']}
> +  'if': ['defined(TARGET_S390X) || defined(TARGET_I386)']}
> =20
>  ##
>  # @CpuModelCompareResult:
> @@ -4627,7 +4625,7 @@
>  { 'command': 'query-cpu-model-comparison',
>    'data': { 'modela': 'CpuModelInfo', 'modelb': 'CpuModelInfo' },
>    'returns': 'CpuModelCompareInfo',
> -  'if': ['defined(NEED_CPU_H)', 'defined(TARGET_S390X)']}
> +  'if': ['defined(TARGET_S390X)']}
> =20
> =20
>  ##
> @@ -4681,7 +4679,7 @@
>    'data': { 'modela': 'CpuModelInfo',
>              'modelb': 'CpuModelInfo' },
>    'returns': 'CpuModelBaselineInfo',
> -  'if': ['defined(NEED_CPU_H)', 'defined(TARGET_S390X)']}
> +  'if': ['defined(TARGET_S390X)']}
> =20
>  ##
>  # @AddfdInfo:
> @@ -6303,7 +6301,7 @@
>  #
>  ##
>  { 'command': 'rtc-reset-reinjection',
> -  'if': ['defined(NEED_CPU_H)', 'defined(TARGET_I386)'] }
> +  'if': ['defined(TARGET_I386)'] }
> =20
>  # Rocker ethernet network switch
>  { 'include': 'qapi/rocker.json' }
> @@ -6466,7 +6464,7 @@
>  #
>  ##
>  { 'command': 'query-gic-capabilities', 'returns': ['GICCapability'],
> -  'if': ['defined(NEED_CPU_H)', 'defined(TARGET_ARM)']}
> +  'if': ['defined(TARGET_ARM)']}
> =20
>  ##
>  # @CpuInstanceProperties:
> diff --git a/scripts/qapi.py b/scripts/qapi.py
> index bcd8d37..769a730 100644
> --- a/scripts/qapi.py
> +++ b/scripts/qapi.py
> @@ -1720,8 +1720,7 @@ class QAPISchema(object):
>          ifcond =3D expr.get('if')
>          if isinstance(data, OrderedDict):
>              data =3D self._make_implicit_object_type(
> -                name, info, doc, 'arg', self._make_members(data, info),
> -                ifcond)
> +                name, info, doc, 'arg', self._make_members(data, info))
>          if isinstance(rets, list):
>              assert len(rets) =3D=3D 1
>              rets =3D self._make_array_type(rets[0], info)
> diff --git a/scripts/qapi-commands.py b/scripts/qapi-commands.py
> index db45415..2baa73f 100644
> --- a/scripts/qapi-commands.py
> +++ b/scripts/qapi-commands.py
> @@ -228,7 +228,7 @@ class QAPISchemaGenCommandVisitor(QAPISchemaVisitor):
>          self.defn =3D None
>          self._regy =3D None
>          self._visited_ret_types =3D None
> -        self.if_members =3D ['decl', 'defn', '_regy']
> +        self.if_members =3D ['defn', '_regy']
> =20
>      def visit_begin(self, schema):
>          self.decl =3D ''
>=20
>=20
> --
> Eduardo
>=20
