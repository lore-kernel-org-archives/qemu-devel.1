Received: from eggs.gnu.org ([2001:4830:134:3::10]:35527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1drAOm-0003hP-4V
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 18:08:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1drAOi-0001Ll-3y
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 18:08:16 -0400
Received: from roura.ac.upc.edu ([147.83.33.10]:48948 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1drAOh-0001If-LL
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 18:08:12 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <150471856141.24907.274176769201097378.stgit@frigg.lan>
	<150472050004.24907.4613952373869620144.stgit@frigg.lan>
	<87vakuki1h.fsf@dusky.pond.sub.org>
Date: Mon, 11 Sep 2017 01:07:59 +0300
In-Reply-To: <87vakuki1h.fsf@dusky.pond.sub.org> (Markus Armbruster's message
	of "Thu, 07 Sep 2017 10:51:54 +0200")
Message-ID: <87poayxl4w.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 08/20] instrument: [hmp] Add library
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
Cc: qemu-devel@nongnu.org, "Emilio G. Cota" <cota@braap.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>

Markus Armbruster writes:

> Llu=C3=ADs Vilanova <vilanova@ac.upc.edu> writes:
>> Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
>> ---
>> hmp-commands.hx |   28 ++++++++++++++++++++++++++
>> monitor.c       |   60 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>> 2 files changed, 88 insertions(+)
>>=20
>> diff --git a/hmp-commands.hx b/hmp-commands.hx
>> index 1941e19932..703d7262f5 100644
>> --- a/hmp-commands.hx
>> +++ b/hmp-commands.hx
>> @@ -1858,6 +1858,34 @@ ETEXI
>> .sub_table  =3D info_cmds,
>> },
>>=20
>> +    {
>> +        .name       =3D "instr-load",
>> +        .args_type  =3D "path:F,args:s?",
>> +        .params     =3D "path [arg]",
>> +        .help       =3D "load an instrumentation library",
>> +        .cmd        =3D hmp_instr_load,
>> +    },
>> +
>> +STEXI
>> +@item instr-load @var{path} [args=3Dvalue[,...]]
>> +@findex instr-load
>> +Load an instrumentation library.
>> +ETEXI
>> +
>> +    {
>> +        .name       =3D "instr-unload",
>> +        .args_type  =3D "handle:i",
>> +        .params     =3D "handle",
>> +        .help       =3D "unload an instrumentation library",
>> +        .cmd        =3D hmp_instr_unload,
>> +    },
>> +
>> +STEXI
>> +@item instr-unload
>> +@findex instr-unload
>> +Unload an instrumentation library.
>> +ETEXI
>> +
>> STEXI
>> @end table
>> ETEXI

> Want #ifdef CONFIG_INSTRUMENT, see my review of the previous patch.

> See also my remark there on returning handles vs. passing in IDs.

>> diff --git a/monitor.c b/monitor.c
>> index e0f880107f..8a7684f860 100644
>> --- a/monitor.c
>> +++ b/monitor.c
>> @@ -2319,6 +2319,66 @@ int monitor_fd_param(Monitor *mon, const char *fd=
name, Error **errp)
>> return fd;
>> }
>>=20
>> +static void hmp_instr_load(Monitor *mon, const QDict *qdict)
>> +{
>> +    const char *path =3D qdict_get_str(qdict, "path");
>> +    const char *str =3D qdict_get_try_str(qdict, "args");
>> +    strList args;

> Blank line between last declaration and first statement, please.

>> +    args.value =3D (str =3D=3D NULL) ? NULL : (char *)str;

> What's wrong with

>        args.value =3D (char *)str;

> ?

>> +    args.next =3D NULL;
>> +    InstrLoadResult *res =3D qmp_instr_load(path, args.value !=3D NULL,
>> +                                          args.value !=3D NULL ? &args =
: NULL,
>> +                                          NULL);
>> +    switch (res->code) {
>> +    case INSTR_LOAD_CODE_OK:
>> +        monitor_printf(mon, "Handle: %"PRId64"\n", res->handle);
>> +        monitor_printf(mon, "OK\n");
>> +        break;
>> +    case INSTR_LOAD_CODE_TOO_MANY:
>> +        monitor_printf(mon, "Too many instrumentation libraries already=
 loaded\n");
>> +        break;
>> +    case INSTR_LOAD_CODE_ERROR:
>> +        monitor_printf(mon, "Instrumentation library returned a non-zer=
o value during initialization");
>> +        break;
>> +    case INSTR_LOAD_CODE_DLERROR:
>> +        monitor_printf(mon, "Error loading library: %s\n", res->msg);
>> +        break;
>> +    case INSTR_LOAD_CODE_UNAVAILABLE:
>> +        monitor_printf(mon, "Service not available\n");
>> +        break;
>> +    default:
>> +        fprintf(stderr, "Unknown instrumentation load code: %d", res->c=
ode);
>> +        exit(1);

> Impossible conditions should be assertion failures, but it's a moot point
> because...

>> +        break;
>> +    }
>> +    qapi_free_InstrLoadResult(res);
>> +}

> With qmp_instr_load() fixed to set an error on failure, this becomes
> something like

>        InstrLoadResult *res =3D qmp_instr_load(path, args.value !=3D NULL,
>                                              args.value !=3D NULL ? &args=
 : NULL,
>                                              &err);
>        if (err) {
>            error_report_err(err);
>        } else {
>            monitor_printf(mon, "Handle: %"PRId64"\n", res->handle);
>            monitor_printf(mon, "OK\n");
>        }
>        qapi_free_InstrLoadResult(res);

>> +
>> +static void hmp_instr_unload(Monitor *mon, const QDict *qdict)
>> +{
>> +    int64_t handle =3D qdict_get_int(qdict, "handle");
>> +    InstrUnloadResult *res =3D qmp_instr_unload(handle, NULL);
>> +    switch (res->code) {
>> +    case INSTR_UNLOAD_CODE_OK:
>> +        monitor_printf(mon, "OK\n");
>> +        break;
>> +    case INSTR_UNLOAD_CODE_INVALID:
>> +        monitor_printf(mon, "Invalid handle\n");
>> +        break;
>> +    case INSTR_UNLOAD_CODE_DLERROR:
>> +        monitor_printf(mon, "Error unloading library: %s\n", res->msg);
>> +        break;
>> +    case INSTR_UNLOAD_CODE_UNAVAILABLE:
>> +        monitor_printf(mon, "Service not available\n");
>> +        break;
>> +    default:
>> +        fprintf(stderr, "Unknown instrumentation unload code: %d", res-=
>code);
>> +        exit(1);
>> +        break;
>> +    }
>> +    qapi_free_InstrUnloadResult(res);
>> +}
>> +
>> /* Please update hmp-commands.hx when adding or changing commands */
>> static mon_cmd_t info_cmds[] =3D {
>> #include "hmp-commands-info.h"

> Likewise.

Done, thanks!

Lluis
