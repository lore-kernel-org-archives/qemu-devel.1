Received: from eggs.gnu.org ([2001:4830:134:3::10]:48944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eZkSi-0003od-Mc
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:32:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eZkSh-00086A-CA
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:32:36 -0500
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:35507)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1eZkSh-00085Q-2a
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:32:35 -0500
Received: by mail-wr0-x22e.google.com with SMTP id g38so362975wrd.2
	for <qemu-devel@nongnu.org>; Thu, 11 Jan 2018 13:32:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87ind9uv40.fsf@dusky.pond.sub.org>
References: <20170911110623.24981-1-marcandre.lureau@redhat.com>
	<20170911110623.24981-45-marcandre.lureau@redhat.com>
	<87ind9uv40.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 11 Jan 2018 22:32:33 +0100
Message-ID: <CAJ+F1CKhNF1b_2hD7yY9zVz=Z9XOOUWSp-48OCKPr_7BJ9k2vQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 44/50] build-sys: add a target schema
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Hi

On Thu, Dec 14, 2017 at 5:34 PM, Markus Armbruster <armbru@redhat.com> wrot=
e:
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
>> This schema is going to contain target-specific commands/events &
>> types, that can be conditionnally guarded with poisoned defines. To
>> filter it out by default, set the unit name to 'target'.
>>
>> And new rules to compile this unit generated files per-target.
>>
>> Use the "-u all" options for the introspection schema, since it is
>> generated as a single file and must contain all definitions.
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>  qapi-schema.json |  1 +
>>  qapi/target.json |  3 +++
>>  monitor.c        |  2 ++
>>  Makefile         | 29 ++++++++++++++++++++++++++++-
>>  Makefile.target  |  2 ++
>>  5 files changed, 36 insertions(+), 1 deletion(-)
>>  create mode 100644 qapi/target.json
>>
>> diff --git a/qapi-schema.json b/qapi-schema.json
>> index f3af2cb851..42b6aebddb 100644
>> --- a/qapi-schema.json
>> +++ b/qapi-schema.json
>> @@ -92,6 +92,7 @@
>>  { 'include': 'qapi/transaction.json' }
>>  { 'include': 'qapi/trace.json' }
>>  { 'include': 'qapi/introspect.json' }
>> +{ 'include': 'qapi/target.json' }
>>
>>  ##
>>  # =3D Miscellanea
>> diff --git a/qapi/target.json b/qapi/target.json
>> new file mode 100644
>> index 0000000000..e9644f52c2
>> --- /dev/null
>> +++ b/qapi/target.json
>> @@ -0,0 +1,3 @@
>> +# -*- Mode: Python -*-
>> +
>> +{ 'pragma': { 'unit': 'target' } }
>> diff --git a/monitor.c b/monitor.c
>> index bf8a7685bf..af4eaeca5e 100644
>> --- a/monitor.c
>> +++ b/monitor.c
>> @@ -68,6 +68,7 @@
>>  #include "exec/exec-all.h"
>>  #include "qemu/log.h"
>>  #include "qmp-commands.h"
>> +#include "target-qmp-commands.h"
>>  #include "hmp.h"
>>  #include "qemu/thread.h"
>>  #include "block/qapi.h"
>> @@ -1003,6 +1004,7 @@ void monitor_init_qmp_commands(void)
>>
>>      QTAILQ_INIT(&qmp_commands);
>>      qmp_init_marshal(&qmp_commands);
>> +    target_qmp_init_marshal(&qmp_commands);
>>
>>      qmp_register_command(&qmp_commands, "query-qmp-schema",
>>                           qmp_query_qmp_schema,
>> diff --git a/Makefile b/Makefile
>> index 337a1f6f9b..7356b4e7b7 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -54,6 +54,8 @@ include $(SRC_PATH)/rules.mak
>>  GENERATED_FILES =3D qemu-version.h config-host.h qemu-options.def
>>  GENERATED_FILES +=3D qmp-commands.h qapi-types.h qapi-visit.h qapi-even=
t.h
>>  GENERATED_FILES +=3D qmp-marshal.c qapi-types.c qapi-visit.c qapi-event=
.c
>> +GENERATED_FILES +=3D target-qmp-commands.h target-qapi-types.h target-q=
api-visit.h target-qapi-event.h
>> +GENERATED_FILES +=3D target-qmp-marshal.c target-qapi-types.c target-qa=
pi-visit.c target-qapi-event.c
>>  GENERATED_FILES +=3D qmp-introspect.h
>>  GENERATED_FILES +=3D qmp-introspect.c
>>
>> @@ -418,6 +420,7 @@ qapi-modules =3D $(SRC_PATH)/qapi-schema.json $(SRC_=
PATH)/qapi/common.json \
>>                 $(SRC_PATH)/qapi/rocker.json \
>>                 $(SRC_PATH)/qapi/run-state.json \
>>                 $(SRC_PATH)/qapi/sockets.json \
>> +               $(SRC_PATH)/qapi/target.json \
>>                 $(SRC_PATH)/qapi/tpm.json \
>>                 $(SRC_PATH)/qapi/trace.json \
>>                 $(SRC_PATH)/qapi/transaction.json \
>> @@ -443,10 +446,34 @@ $(qapi-modules) $(SRC_PATH)/scripts/qapi-commands.=
py $(qapi-py)
>>       $(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-commands.p=
y \
>>               $(gen-out-type) -o "." $<, \
>>               "GEN","$@")
>> +
>> +target-qapi-types.c target-qapi-types.h :\
>> +$(qapi-modules) $(SRC_PATH)/scripts/qapi-types.py $(qapi-py)
>> +     $(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-types.py \
>> +             -i qapi-types.h \
>> +             $(gen-out-type) -p target- -u target $<, \
>> +             "GEN","$@")
>> +target-qapi-visit.c target-qapi-visit.h :\
>> +$(qapi-modules) $(SRC_PATH)/scripts/qapi-visit.py $(qapi-py)
>> +     $(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-visit.py \
>> +             -i qapi-visit.h \
>> +             $(gen-out-type) -p target- -u target $<, \
>> +             "GEN","$@")
>> +target-qapi-event.c target-qapi-event.h :\
>> +$(qapi-modules) $(SRC_PATH)/scripts/qapi-event.py $(qapi-py)
>> +     $(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-event.py \
>> +             $(gen-out-type) -p target- -u target  $<, \
>> +             "GEN","$@")
>> +target-qmp-commands.h target-qmp-marshal.c :\
>> +$(qapi-modules) $(SRC_PATH)/scripts/qapi-commands.py $(qapi-py)
>> +     $(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-commands.p=
y \
>> +             $(gen-out-type) -p target- -u target $<, \
>> +             "GEN","$@")
>> +
>>  qmp-introspect.h qmp-introspect.c :\
>>  $(qapi-modules) $(SRC_PATH)/scripts/qapi-introspect.py $(qapi-py)
>>       $(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-introspect=
.py \
>> -             $(gen-out-type) -o "." $<, \
>> +             $(gen-out-type) -o "." -u all $<, \
>>               "GEN","$@")
>>
>
> Let's see whether I understand how this works.  Without -u (not fully
> visible in the diff), we get everything but the target-specific stuff.
> With -u target, we get just the target-specific stuff.  With -u all, we
> get everything.  Correct?
>

Right, but I changed the logic as discussed in "qapi: add a -u/--unit
option to specify which unit to visit " (this changes a bit the way
inclusion is being done, now target.json is the top-level for the
documentation)

So only -u target will be needed to generate the target specific code
now (while still parsing and checking with the rest of the schemas)

All documentation is generated from target.json. The rest is
unaffected by this new schema (which is a good thing imho).

>>  QGALIB_GEN=3D$(addprefix qga/qapi-generated/, qga-qapi-types.h qga-qapi=
-visit.h qga-qmp-commands.h)
>> diff --git a/Makefile.target b/Makefile.target
>> index 0d28ed1df0..e44a3847d3 100644
>> --- a/Makefile.target
>> +++ b/Makefile.target
>> @@ -157,6 +157,8 @@ endif
>>
>>  GENERATED_FILES +=3D hmp-commands.h hmp-commands-info.h
>>
>> +obj-y +=3D target-qapi-types.o target-qapi-visit.o
>> +obj-y +=3D target-qapi-event.o target-qmp-marshal.o
>>  obj-y +=3D qmp-introspect.o
>>
>>  endif # CONFIG_SOFTMMU
>


thanks

--=20
Marc-Andr=C3=A9 Lureau
