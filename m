Received: from eggs.gnu.org ([2001:4830:134:3::10]:33395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1epGzQ-0004xV-Pu
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 12:18:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1epGzN-0003pa-J2
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 12:18:32 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40442 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1epGzN-0003p5-Cx
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 12:18:29 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20180211093607.27351-1-armbru@redhat.com>
	<20180211093607.27351-6-armbru@redhat.com>
	<151882914354.12376.14797462837938712408@sif>
Date: Fri, 23 Feb 2018 18:18:25 +0100
In-Reply-To: <151882914354.12376.14797462837938712408@sif> (Michael Roth's
	message of "Fri, 16 Feb 2018 18:59:03 -0600")
Message-ID: <87inanlj4u.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 05/29] qapi: New classes QAPIGenC,
 QAPIGenH, QAPIGenDoc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com

Michael Roth <mdroth@linux.vnet.ibm.com> writes:

> Quoting Markus Armbruster (2018-02-11 03:35:43)
>> These classes encapsulate accumulating and writing output.
>>=20
>> Convert C code generation to QAPIGenC and QAPIGenH.  The conversion is
>> rather shallow: most of the output accumulation is not converted.
>> Left for later.
>>=20
>> The indentation machinery uses a single global variable indent_level,
>> even though we generally interleave creation of a .c and its .h.  It
>> should become instance variable of QAPIGenC.  Also left for later.
>>=20
>> Documentation generation isn't converted, and QAPIGenDoc isn't used.
>> This will change shortly.
>>=20
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> 2 minor nits below, but in any case:
>
> Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>
>
>> ---
>>  scripts/qapi-commands.py   | 23 +++++------
>>  scripts/qapi-event.py      | 22 ++++++-----
>>  scripts/qapi-introspect.py | 18 +++++----
>>  scripts/qapi-types.py      | 22 ++++++-----
>>  scripts/qapi-visit.py      | 22 ++++++-----
>>  scripts/qapi.py            | 99 +++++++++++++++++++++++++--------------=
-------
>>  6 files changed, 112 insertions(+), 94 deletions(-)
>>=20
>> diff --git a/scripts/qapi-commands.py b/scripts/qapi-commands.py
>> index c3aa52fce1..8d38ade076 100644
>> --- a/scripts/qapi-commands.py
>> +++ b/scripts/qapi-commands.py
>> @@ -260,12 +260,10 @@ blurb =3D '''
>>   * Schema-defined QAPI/QMP commands
>>  '''
>>=20
>> -(fdef, fdecl) =3D open_output(output_dir, do_c, do_h, prefix,
>> -                            'qmp-marshal.c', 'qmp-commands.h',
>> -                            blurb, __doc__)
>> -
>> -fdef.write(mcgen('''
>> +genc =3D QAPIGenC(blurb, __doc__)
>> +genh =3D QAPIGenH(blurb, __doc__)
>>=20
>> +genc.add(mcgen('''
>>  #include "qemu/osdep.h"
>>  #include "qemu-common.h"
>>  #include "qemu/module.h"
>> @@ -280,20 +278,23 @@ fdef.write(mcgen('''
>>  #include "%(prefix)sqmp-commands.h"
>>=20
>>  ''',
>> -                 prefix=3Dprefix))
>> +               prefix=3Dprefix))
>>=20
>> -fdecl.write(mcgen('''
>> +genh.add(mcgen('''
>>  #include "%(prefix)sqapi-types.h"
>>  #include "qapi/qmp/dispatch.h"
>>=20
>>  void %(c_prefix)sqmp_init_marshal(QmpCommandList *cmds);
>>  ''',
>> -                  prefix=3Dprefix, c_prefix=3Dc_name(prefix, protect=3D=
False)))
>> +               prefix=3Dprefix, c_prefix=3Dc_name(prefix, protect=3DFal=
se)))
>>=20
>>  schema =3D QAPISchema(input_file)
>>  vis =3D QAPISchemaGenCommandVisitor()
>>  schema.visit(vis)
>> -fdef.write(vis.defn)
>> -fdecl.write(vis.decl)
>> +genc.add(vis.defn)
>> +genh.add(vis.decl)
>>=20
>> -close_output(fdef, fdecl)
>> +if do_c:
>> +    genc.write(output_dir, prefix + 'qmp-marshal.c')
>> +if do_h:
>> +    genh.write(output_dir, prefix + 'qmp-commands.h')
>> diff --git a/scripts/qapi-event.py b/scripts/qapi-event.py
>> index edb9ddb650..bd7a9be3dc 100644
>> --- a/scripts/qapi-event.py
>> +++ b/scripts/qapi-event.py
>> @@ -176,11 +176,10 @@ blurb =3D '''
>>   * Schema-defined QAPI/QMP events
>>  '''
>>=20
>> -(fdef, fdecl) =3D open_output(output_dir, do_c, do_h, prefix,
>> -                            'qapi-event.c', 'qapi-event.h',
>> -                            blurb, __doc__)
>> +genc =3D QAPIGenC(blurb, __doc__)
>> +genh =3D QAPIGenH(blurb, __doc__)
>>=20
>> -fdef.write(mcgen('''
>> +genc.add(mcgen('''
>>  #include "qemu/osdep.h"
>>  #include "qemu-common.h"
>>  #include "%(prefix)sqapi-event.h"
>> @@ -191,21 +190,24 @@ fdef.write(mcgen('''
>>  #include "qapi/qmp-event.h"
>>=20
>>  ''',
>> -                 prefix=3Dprefix))
>> +               prefix=3Dprefix))
>>=20
>> -fdecl.write(mcgen('''
>> +genh.add(mcgen('''
>>  #include "qapi/util.h"
>>  #include "%(prefix)sqapi-types.h"
>>=20
>>  ''',
>> -                  prefix=3Dprefix))
>> +               prefix=3Dprefix))
>>=20
>>  event_enum_name =3D c_name(prefix + 'QAPIEvent', protect=3DFalse)
>>=20
>>  schema =3D QAPISchema(input_file)
>>  vis =3D QAPISchemaGenEventVisitor()
>>  schema.visit(vis)
>> -fdef.write(vis.defn)
>> -fdecl.write(vis.decl)
>> +genc.add(vis.defn)
>> +genh.add(vis.decl)
>>=20
>> -close_output(fdef, fdecl)
>> +if do_c:
>> +    genc.write(output_dir, prefix + 'qapi-event.c')
>> +if do_h:
>> +    genh.write(output_dir, prefix + 'qapi-event.h')
>> diff --git a/scripts/qapi-introspect.py b/scripts/qapi-introspect.py
>> index ebe8706f41..3d65690fe3 100644
>> --- a/scripts/qapi-introspect.py
>> +++ b/scripts/qapi-introspect.py
>> @@ -181,21 +181,23 @@ blurb =3D '''
>>   * QAPI/QMP schema introspection
>>  '''
>>=20
>> -(fdef, fdecl) =3D open_output(output_dir, do_c, do_h, prefix,
>> -                            'qmp-introspect.c', 'qmp-introspect.h',
>> -                            blurb, __doc__)
>> +genc =3D QAPIGenC(blurb, __doc__)
>> +genh =3D QAPIGenH(blurb, __doc__)
>>=20
>> -fdef.write(mcgen('''
>> +genc.add(mcgen('''
>>  #include "qemu/osdep.h"
>>  #include "%(prefix)sqmp-introspect.h"
>>=20
>>  ''',
>> -                 prefix=3Dprefix))
>> +               prefix=3Dprefix))
>>=20
>>  schema =3D QAPISchema(input_file)
>>  vis =3D QAPISchemaGenIntrospectVisitor(opt_unmask)
>>  schema.visit(vis)
>> -fdef.write(vis.defn)
>> -fdecl.write(vis.decl)
>> +genc.add(vis.defn)
>> +genh.add(vis.decl)
>>=20
>> -close_output(fdef, fdecl)
>> +if do_c:
>> +    genc.write(output_dir, prefix + 'qmp-introspect.c')
>> +if do_h:
>> +    genh.write(output_dir, prefix + 'qmp-introspect.h')
>> diff --git a/scripts/qapi-types.py b/scripts/qapi-types.py
>> index 4db8424da1..c0ac879beb 100644
>> --- a/scripts/qapi-types.py
>> +++ b/scripts/qapi-types.py
>> @@ -180,7 +180,7 @@ class QAPISchemaGenTypeVisitor(QAPISchemaVisitor):
>>          self.decl =3D ''
>>          self.defn =3D ''
>>          self._fwdecl =3D ''
>> -        self._btin =3D guardstart('QAPI_TYPES_BUILTIN')
>> +        self._btin =3D '\n' + guardstart('QAPI_TYPES_BUILTIN')
>
> Minor nit, but if we compensate for guardstart() change here, shouldn't
> we do the same in QAPISchemaGenVisitVisitor? Both are cosmetic (though
> Visit is in less need since it has extra an extra newline already,
> but changing one and not the other to compensate here makes the patch
> appear less mechanical, and the resulting formatting fix-up gets dropped
> later in the series anyway)

Yes, it's better to keep the two consistent.

>>      def visit_end(self):
>>          self.decl =3D self._fwdecl + self.decl
>
> <snip>
>
>> +class QAPIGenDoc(QAPIGen):
>> +    def _top(self, fname):
>> +        return (QAPIGen._top(self, fname)
>> +                + '@c AUTOMATICALLY GENERATED, DO NOT MODIFY\n\n')
>
> The whitespace change in
> "qapi/types qapi/visit: Generate built-in stuff into separate files" shou=
ld
> probably be squashed in here:
>
>  class QAPIGenDoc(QAPIGen):
> +
>      def _top(self, fname):
>          return (QAPIGen._top(self, fname)
>                  + '@c AUTOMATICALLY GENERATED, DO NOT MODIFY\n\n')

Yes.
