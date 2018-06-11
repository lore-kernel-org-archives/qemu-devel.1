Received: from eggs.gnu.org ([2001:4830:134:3::10]:54776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fSNrK-0000UT-RC
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 10:31:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fSNrH-0004YX-M2
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 10:31:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55888 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fSNrH-0004YQ-HV
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 10:31:47 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180501132031.13270-1-viktor.prutyanov@virtuozzo.com>
Date: Mon, 11 Jun 2018 16:31:42 +0200
In-Reply-To: <20180501132031.13270-1-viktor.prutyanov@virtuozzo.com> (Viktor
	Prutyanov's message of "Tue, 1 May 2018 16:20:31 +0300")
Message-ID: <87h8m94coh.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4] dump: add Windows dump format to
 dump-guest-memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, rkagan@virtuozzo.com, armbru@redhat.com, dgilbert@redhat.com, Paolo Bonzini <pbonzini@redhat.com>

Looks stuck.  Paolo, would you be willing to take this through your
tree?

Viktor Prutyanov <viktor.prutyanov@virtuozzo.com> writes:

> This patch adds Windows crashdumping feature. Now QEMU can produce ELF-du=
mp
> containing Windows crashdump header, which can help to convert to a valid
> WinDbg-understandable crashdump file, or immediately create such file.
> The crashdump will be obtained by joining physical memory dump and 8K hea=
der
> exposed through vmcoreinfo/fw_cfg device by guest driver at BSOD time. Op=
tion
> '-w' was added to dump-guest-memory command. At the moment, only x64
> configuration is supported.
> Suitable driver can be found at
> https://github.com/virtio-win/kvm-guest-drivers-windows/tree/master/fwcfg=
64
>
> Signed-off-by: Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>
>  v1: documentation updated
>  v2: qapi/misc.json updated with version info
>  v3: qapi/misc.json codestyle fixed
>  v4: make error processing more quality
>
>  Makefile.target |   1 +
>  dump.c          |  24 ++++++-
>  hmp-commands.hx |  13 ++--
>  hmp.c           |   9 ++-
>  qapi/misc.json  |   5 +-
>  win_dump.c      | 209 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  win_dump.h      |  87 +++++++++++++++++++++++
>  7 files changed, 339 insertions(+), 9 deletions(-)
>  create mode 100644 win_dump.c
>  create mode 100644 win_dump.h
>
> diff --git a/Makefile.target b/Makefile.target
> index d0ec77a307..6ae2609597 100644
> --- a/Makefile.target
> +++ b/Makefile.target
> @@ -138,6 +138,7 @@ obj-y +=3D hw/
>  obj-y +=3D memory.o
>  obj-y +=3D memory_mapping.o
>  obj-y +=3D dump.o
> +obj-y +=3D win_dump.o
>  obj-y +=3D migration/ram.o
>  LIBS :=3D $(libs_softmmu) $(LIBS)
>=20=20
> diff --git a/dump.c b/dump.c
> index b54cd42b21..04467b353e 100644
> --- a/dump.c
> +++ b/dump.c
> @@ -29,6 +29,10 @@
>  #include "qemu/error-report.h"
>  #include "hw/misc/vmcoreinfo.h"
>=20=20
> +#ifdef TARGET_X86_64
> +#include "win_dump.h"
> +#endif
> +
>  #include <zlib.h>
>  #ifdef CONFIG_LZO
>  #include <lzo/lzo1x.h>
> @@ -1866,7 +1870,11 @@ static void dump_process(DumpState *s, Error **err=
p)
>      Error *local_err =3D NULL;
>      DumpQueryResult *result =3D NULL;
>=20=20
> -    if (s->has_format && s->format !=3D DUMP_GUEST_MEMORY_FORMAT_ELF) {
> +    if (s->has_format && s->format =3D=3D DUMP_GUEST_MEMORY_FORMAT_WIN_D=
MP) {
> +#ifdef TARGET_X86_64
> +        create_win_dump(s, &local_err);
> +#endif
> +    } else if (s->has_format && s->format !=3D DUMP_GUEST_MEMORY_FORMAT_=
ELF) {
>          create_kdump_vmcore(s, &local_err);
>      } else {
>          create_vmcore(s, &local_err);
> @@ -1970,6 +1978,13 @@ void qmp_dump_guest_memory(bool paging, const char=
 *file,
>      }
>  #endif
>=20=20
> +#ifndef TARGET_X86_64
> +    if (has_format && format =3D=3D DUMP_GUEST_MEMORY_FORMAT_WIN_DMP) {
> +        error_setg(errp, "Windows dump is only available for x86-64");
> +        return;
> +    }
> +#endif
> +
>  #if !defined(WIN32)
>      if (strstart(file, "fd:", &p)) {
>          fd =3D monitor_get_fd(cur_mon, p, errp);
> @@ -2044,5 +2059,12 @@ DumpGuestMemoryCapability *qmp_query_dump_guest_me=
mory_capability(Error **errp)
>      item->value =3D DUMP_GUEST_MEMORY_FORMAT_KDUMP_SNAPPY;
>  #endif
>=20=20
> +    /* Windows dump is available only if target is x86_64 */
> +#ifdef TARGET_X86_64
> +    item->next =3D g_malloc0(sizeof(DumpGuestMemoryFormatList));
> +    item =3D item->next;
> +    item->value =3D DUMP_GUEST_MEMORY_FORMAT_WIN_DMP;
> +#endif
> +
>      return cap;
>  }
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index 35d862a5d2..6f35e4f5d0 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -1088,30 +1088,33 @@ ETEXI
>=20=20
>      {
>          .name       =3D "dump-guest-memory",
> -        .args_type  =3D "paging:-p,detach:-d,zlib:-z,lzo:-l,snappy:-s,fi=
lename:F,begin:i?,length:i?",
> -        .params     =3D "[-p] [-d] [-z|-l|-s] filename [begin length]",
> +        .args_type  =3D "paging:-p,detach:-d,windmp:-w,zlib:-z,lzo:-l,sn=
appy:-s,filename:F,begin:i?,length:i?",
> +        .params     =3D "[-p] [-d] [-z|-l|-s|-w] filename [begin length]=
",
>          .help       =3D "dump guest memory into file 'filename'.\n\t\t\t"
>                        "-p: do paging to get guest's memory mapping.\n\t\=
t\t"
>                        "-d: return immediately (do not wait for completio=
n).\n\t\t\t"
>                        "-z: dump in kdump-compressed format, with zlib co=
mpression.\n\t\t\t"
>                        "-l: dump in kdump-compressed format, with lzo com=
pression.\n\t\t\t"
>                        "-s: dump in kdump-compressed format, with snappy =
compression.\n\t\t\t"
> +                      "-w: dump in Windows crashdump format (can be used=
 instead of ELF-dump converting),\n\t\t\t"
> +                      "    for Windows x64 guests with vmcoreinfo driver=
 only.\n\t\t\t"

Whatever "ELF-dump converting" is.  Do we need that part of the help text?

>                        "begin: the starting physical address.\n\t\t\t"
>                        "length: the memory size, in bytes.",
>          .cmd        =3D hmp_dump_guest_memory,
>      },
>=20=20
> -
>  STEXI
>  @item dump-guest-memory [-p] @var{filename} @var{begin} @var{length}
> -@item dump-guest-memory [-z|-l|-s] @var{filename}
> +@item dump-guest-memory [-z|-l|-s|-w] @var{filename}
>  @findex dump-guest-memory
>  Dump guest memory to @var{protocol}. The file can be processed with cras=
h or
> -gdb. Without -z|-l|-s, the dump format is ELF.
> +gdb. Without -z|-l|-s|-w, the dump format is ELF.
>          -p: do paging to get guest's memory mapping.
>          -z: dump in kdump-compressed format, with zlib compression.
>          -l: dump in kdump-compressed format, with lzo compression.
>          -s: dump in kdump-compressed format, with snappy compression.
> +        -w: dump in Windows crashdump format (can be used instead of ELF=
-dump converting),

Likewise.

> +            for Windows x64 guests with vmcoreinfo driver only
>    filename: dump file name.
>       begin: the starting physical address. It's optional, and should be
>              specified together with length.
> diff --git a/hmp.c b/hmp.c
> index a25c7bd9a8..bb6a6eaf00 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -1951,6 +1951,7 @@ void hmp_device_del(Monitor *mon, const QDict *qdic=
t)
>  void hmp_dump_guest_memory(Monitor *mon, const QDict *qdict)
>  {
>      Error *err =3D NULL;
> +    bool win_dmp =3D qdict_get_try_bool(qdict, "windmp", false);
>      bool paging =3D qdict_get_try_bool(qdict, "paging", false);
>      bool zlib =3D qdict_get_try_bool(qdict, "zlib", false);
>      bool lzo =3D qdict_get_try_bool(qdict, "lzo", false);
> @@ -1965,12 +1966,16 @@ void hmp_dump_guest_memory(Monitor *mon, const QD=
ict *qdict)
>      enum DumpGuestMemoryFormat dump_format =3D DUMP_GUEST_MEMORY_FORMAT_=
ELF;
>      char *prot;
>=20=20
> -    if (zlib + lzo + snappy > 1) {
> -        error_setg(&err, "only one of '-z|-l|-s' can be set");
> +    if (zlib + lzo + snappy + win_dmp > 1) {
> +        error_setg(&err, "only one of '-z|-l|-s|-w' can be set");
>          hmp_handle_error(mon, &err);
>          return;
>      }
>=20=20
> +    if (win_dmp) {
> +        dump_format =3D DUMP_GUEST_MEMORY_FORMAT_WIN_DMP;
> +    }
> +
>      if (zlib) {
>          dump_format =3D DUMP_GUEST_MEMORY_FORMAT_KDUMP_ZLIB;
>      }
> diff --git a/qapi/misc.json b/qapi/misc.json
> index 5636f4a149..83f2df6b41 100644
> --- a/qapi/misc.json
> +++ b/qapi/misc.json
> @@ -1645,10 +1645,13 @@
>  #
>  # @kdump-snappy: kdump-compressed format with snappy-compressed
>  #
> +# @win-dmp: Windows full crashdump format,
> +#           can be used instead of ELF converting (since 2.13)

Whatever "ELF converting" is.  Do we need that part of the comment?

The 2.13 needs to be fixed up to 3.0 now.

> +#
>  # Since: 2.0
>  ##
>  { 'enum': 'DumpGuestMemoryFormat',
> -  'data': [ 'elf', 'kdump-zlib', 'kdump-lzo', 'kdump-snappy' ] }
> +  'data': [ 'elf', 'kdump-zlib', 'kdump-lzo', 'kdump-snappy', 'win-dmp' =
] }
>=20=20
>  ##
>  # @dump-guest-memory:
[...]

Acked-by: Markus Armbruster <armbru@redhat.com>
