Received: from eggs.gnu.org ([2001:4830:134:3::10]:58083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dr9wp-0005u7-P4
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 17:39:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dr9wm-0007T1-Hf
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 17:39:23 -0400
Received: from roura.ac.upc.edu ([147.83.33.10]:42354 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dr9wm-0007SB-2e
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 17:39:20 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <150471856141.24907.274176769201097378.stgit@frigg.lan>
	<150472025751.24907.6133235993130047929.stgit@frigg.lan>
	<877exalwzf.fsf@dusky.pond.sub.org>
Date: Mon, 11 Sep 2017 00:39:05 +0300
In-Reply-To: <877exalwzf.fsf@dusky.pond.sub.org> (Markus Armbruster's message
	of "Thu, 07 Sep 2017 10:43:48 +0200")
Message-ID: <87tw0axmh2.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 07/20] instrument: [qapi] Add library
 loader
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, "Emilio G. Cota" <cota@braap.org>, Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

Markus Armbruster writes:

> I missed prior versions of this series.  Please cc: qapi-schema
> maintainers on all non-trivial schema patches.
> scripts/get_maintainer.pl points to them for this patch.

> Marc-Andr=C3=A9, semantic conflict with your QAPI conditionals series.  J=
ust
> a heads-up, there's nothing for you to do about it right now.

> Llu=C3=ADs Vilanova <vilanova@ac.upc.edu> writes:

[...]
>> diff --git a/instrument/load.h b/instrument/load.h
>> index 2ddb2c6c19..f8a02e6849 100644
>> --- a/instrument/load.h
>> +++ b/instrument/load.h
>> @@ -25,6 +25,8 @@
>> * @INSTR_LOAD_DLERROR: Error with libdl (see dlerror).
>> *
>> * Error codes for instr_load().
>> + *
>> + * NOTE: Keep in sync with QAPI's #InstrLoadCode.
>> */
>> typedef enum {
>> INSTR_LOAD_OK,
>> @@ -40,6 +42,8 @@ typedef enum {
>> * @INSTR_UNLOAD_DLERROR: Error with libdl (see dlerror).
>> *
>> * Error codes for instr_unload().
>> + *
>> + * NOTE: Keep in sync with QAPI's #InstrUnloadCode.
>> */
>> typedef enum {
>> INSTR_UNLOAD_OK,

> Any particular reason why you can't simply use the QAPI-generated enum
> types?

Silly me, just missed that "optimization" :) But after reading your later
comments, I'll keep these and remove the QAPI-generated enums.


[...]
>> diff --git a/instrument/qmp.c b/instrument/qmp.c
>> new file mode 100644
>> index 0000000000..c36960c12f
>> --- /dev/null
>> +++ b/instrument/qmp.c
>> @@ -0,0 +1,88 @@
>> +/*
>> + * QMP interface for instrumentation control commands.
>> + *
>> + * Copyright (C) 2012-2017 Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or l=
ater.
>> + * See the COPYING file in the top-level directory.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qemu-common.h"
>> +#include "qapi/qmp/qerror.h"
>> +#include "qmp-commands.h"
>> +
>> +#include <dlfcn.h>

> System headers go right after "qemu/osdep.h".

>> +
>> +#include "instrument/load.h"
>> +
>> +
>> +

> Fewer blank lines would do.

>> +InstrLoadResult *qmp_instr_load(const char * path,
>> +                                bool have_args, strList * args,

> checkpatch ERROR: "foo * bar" should be "foo *bar"

> Please feed it all your patches, and carefully consider which of its
> complaints you should address.

>> +                                Error **errp)
>> +{
>> +    InstrLoadResult *res =3D g_malloc0(sizeof(*res));
>> +
>> +#if defined(CONFIG_INSTRUMENT)
>> +    int argc =3D 0;
>> +    const char **argv =3D NULL;
>> +
>> +    strList *entry =3D have_args ? args : NULL;
>> +    while (entry !=3D NULL) {
>> +        argv =3D realloc(argv, sizeof(*argv) * (argc + 1));
>> +        argv[argc] =3D entry->value;
>> +        argc++;
>> +        entry =3D entry->next;
>> +    }
>> +
>> +    InstrLoadError code =3D instr_load(path, argc, argv, &res->handle);
>> +    switch (code) {
>> +    case INSTR_LOAD_OK:
>> +        res->code =3D INSTR_LOAD_CODE_OK;
>> +        res->has_handle =3D true;
>> +        break;
>> +    case INSTR_LOAD_TOO_MANY:
>> +        res->code =3D INSTR_LOAD_CODE_TOO_MANY;
>> +        break;
>> +    case INSTR_LOAD_ERROR:
>> +        res->code =3D INSTR_LOAD_CODE_ERROR;
>> +        break;
>> +    case INSTR_LOAD_DLERROR:
>> +        res->has_msg =3D true;
>> +        res->msg =3D dlerror();
>> +        res->code =3D INSTR_LOAD_CODE_DLERROR;
>> +        break;
>> +    }
>> +#else
>> +    res->code =3D INSTR_LOAD_CODE_UNAVAILABLE;
>> +#endif
>> +
>> +    return res;
>> +}
>> +
>> +InstrUnloadResult *qmp_instr_unload(int64_t handle, Error **errp)
>> +{
>> +    InstrUnloadResult *res =3D g_malloc0(sizeof(*res));
>> +
>> +#if defined(CONFIG_INSTRUMENT)
>> +    InstrUnloadError code =3D instr_unload(handle);
>> +    switch (code) {
>> +    case INSTR_UNLOAD_OK:
>> +        res->code =3D INSTR_UNLOAD_CODE_OK;
>> +        break;
>> +    case INSTR_UNLOAD_INVALID:
>> +        res->code =3D INSTR_UNLOAD_CODE_INVALID;
>> +        break;
>> +    case INSTR_UNLOAD_DLERROR:
>> +        res->has_msg =3D true;
>> +        res->msg =3D dlerror();
>> +        break;
>> +        res->code =3D INSTR_UNLOAD_CODE_DLERROR;
>> +    }
>> +#else
>> +    res->code =3D INSTR_UNLOAD_CODE_UNAVAILABLE;
>> +#endif
>> +
>> +    return res;
>> +}

> You're inventing your own "this feature isn't compiled in" protocol.  We
> already got too many of them.  Let's stick to one of the existing ones,
> namely the one that's got some visibility in introspection.  Bonus:
> turns the semantic conflict with Marc-Andr=C3=A9's work into a textual
> conflict.  Here's how:

> * Add your commands to qmp_unregister_commands_hack() in monitor.c,
>   roughly like this:

>     #ifndef CONFIG_INSTRUMENT
>         qmp_unregister_command(&qmp_commands, "instr-load");
>         qmp_unregister_command(&qmp_commands, "instr-unload");
>     #endif

> * Compile qmp.c only when CONFIG_INSTRUMENT, just like the other .c
>   files there, except for cmdline.c.  Drop the ifdeffery there.

> * Add stubbed out command handlers to stubs/instrument.c, roughly like
>   this:

>     InstrLoadResult *qmp_instr_load(const char *path,
>                                     bool have_args, strList *args,
>                                     Error **errp)
>     {
>         error_setg(errp, QERR_UNSUPPORTED);
>         return NULL;
>     }

>   Same for qmp_instr_unload().

>   These stubs must exist for the link to succeed, but they won't be
>   called.  They'll go away when Marc-Andr=C3=A9's work lands.

> * In the next patch, make the HMP command conditional on
>   CONFIG_INSTRUMENT, just like trace-file is conditional on
>   CONFIG_TRACE_SIMPLE.

> Questions?

Crystal clear, applied.


> You're also inventing your own "command failed" protocol.  I'll explain
> in my review of instrument.json.

>> diff --git a/qapi-schema.json b/qapi-schema.json
>> index 802ea53d00..5e343be9ff 100644
>> --- a/qapi-schema.json
>> +++ b/qapi-schema.json
>> @@ -90,6 +90,9 @@
>> # QAPI introspection
>> { 'include': 'qapi/introspect.json' }
>>=20
>> +# Instrumentation commands
>> +{ 'include': 'qapi/instrument.json' }
>> +
>> ##
>> # =3D QMP commands
>> ##
>> diff --git a/qapi/instrument.json b/qapi/instrument.json
>> new file mode 100644
>> index 0000000000..ea63fae309
>> --- /dev/null
>> +++ b/qapi/instrument.json
>> @@ -0,0 +1,96 @@
>> +# *-*- Mode: Python -*-*
>> +#
>> +# QAPI instrumentation control commands.
>> +#
>> +# Copyright (C) 2012-2017 Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
>> +#
>> +# This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
>> +# See the COPYING file in the top-level directory.

> Make the title a doc comment, like this:

>    # *-*- Mode: Python -*-*
>    #
>    # Copyright (C) 2012-2017 Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
>    #
>    # This work is licensed under the terms of the GNU GPL, version 2 or l=
ater.
>    # See the COPYING file in the top-level directory.

>    ##
>    # QAPI instrumentation control commands.
>    ##

> The ## around the title make it go into generated
> docs/interop/qemu-qmp-ref.* documentation.

>> +
>> +##
>> +# @InstrLoadCode:
>> +#
>> +# Result code of an 'instr-load' command.
>> +#
>> +# @ok: Correctly loaded.
>> +# @too-many: Tried to load too many instrumentation libraries.
>> +# @error: The library's main() function returned a non-zero value.
>> +# @dlerror: Error with libdl (see 'msg').
>> +# @unavailable: Service not available.
>> +#
>> +# Since: 2.11
>> +##
>> +{ 'enum': 'InstrLoadCode',
>> +  'data': [ 'ok', 'too-many', 'error', 'dlerror', 'unavailable' ] }
>> +
>> +##
>> +# @InstrLoadResult:
>> +#
>> +# Result of an 'instr-load' command.
>> +#
>> +# @code: Result code.
>> +# @msg: Additional error message (for human consumption only; present o=
nly in
>> +#       case of error).
>> +# @handle: Instrumentation library identifier (present only if successf=
ul).
>> +#
>> +# Since: 2.11
>> +##
>> +{ 'struct': 'InstrLoadResult',
>> +  'data': { 'code': 'InstrLoadCode', '*msg': 'str', '*handle': 'int' } }
>> +
>> +##
>> +# @instr-load:
>> +#
>> +# Load an instrumentation library.
>> +#
>> +# @path: path to the dynamic instrumentation library
>> +# @args: arguments to the dynamic instrumentation library
>> +#
>> +# Since: 2.11
>> +##
>> +{ 'command': 'instr-load',
>> +  'data':    { 'path': 'str', '*args': ['str'] },
>> +  'returns': 'InstrLoadResult' }

> No :)

> If the command fails, it must send an error response instead success
> response.  Yours always sends a success response.

> As far as I can tell, instr-load returns a handle on success, always,
> and nothing else.  Therefore:

>    { 'struct': 'InstrLoadResult',
>      'data': { 'handle': 'int' } }

> On error, qmp_instr_load() should set a suitable error with error_setg()
> and return NULL.

> QAPI enum type InstrLoadCode goes away.

> On returning a handle: we commonly let the user specify an ID string
> instead.  For instance, device_add doesn't return a handle you can pass
> to device_del.  Instead, it takes a string-valued 'id' parameter.  Other
> commands, such as device_del, can refer to the device by that ID.  Is
> there any particular reason why you can't stick to this convention for
> instrumentation?

Done too :)

>> +
>> +
>> +##
>> +# @InstrUnloadCode:
>> +#
>> +# Result code of an 'instr-unload' command.
>> +#
>> +# @ok: Correctly unloaded.
>> +# @invalid: Invalid handle.
>> +# @dlerror: Error with libdl (see 'msg').
>> +# @unavailable: Service not available.
>> +#
>> +# Since: 2.11
>> +##
>> +{ 'enum': 'InstrUnloadCode',
>> +  'data': [ 'ok', 'invalid', 'dlerror', 'unavailable' ] }
>> +
>> +##
>> +# @InstrUnloadResult:
>> +#
>> +# Result of an 'instr-unload' command.
>> +#
>> +# @code: Result code.
>> +# @msg: Additional error message (for human consumption only; present o=
nly in
>> +#       case of error).
>> +#
>> +# Since: 2.11
>> +##
>> +{ 'struct': 'InstrUnloadResult',
>> +  'data': { 'code': 'InstrUnloadCode', '*msg': 'str' } }
>> +
>> +##
>> +# @instr-unload:
>> +#
>> +# Unload an instrumentation library.
>> +#
>> +# @handle: Instrumentation library identifier (see #InstrLoadResult).
>> +#
>> +# Since: 2.11
>> +##
>> +{ 'command': 'instr-unload',
>> +  'data': { 'handle': 'int' },
>> +  'returns': 'InstrUnloadResult' }

> Likewise.  instr-unload returns nothing on success.  Both QAPI types go
> away.


Thanks a lot!
Lluis
