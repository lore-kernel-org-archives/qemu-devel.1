Received: from eggs.gnu.org ([2001:4830:134:3::10]:44187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dTA9s-0003OR-VF
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 13:01:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dTA9p-0006n7-1N
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 13:01:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39710)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dTA9o-0006lh-OY
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 13:01:36 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 59F22C1F79
	for <qemu-devel@nongnu.org>; Thu,  6 Jul 2017 17:01:35 +0000 (UTC)
References: <20170706101611.27031-1-marcandre.lureau@redhat.com>
	<20170706101611.27031-5-marcandre.lureau@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <d306200b-a747-e823-6d40-af739ad1244b@redhat.com>
Date: Thu, 6 Jul 2017 19:01:23 +0200
MIME-Version: 1.0
In-Reply-To: <20170706101611.27031-5-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 4/7] dump: add vmcoreinfo ELF note
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, anderson@redhat.com, imammedo@redhat.com

On 07/06/17 12:16, Marc-Andr=C3=A9 Lureau wrote:
> Read the vmcoreinfo ELF PT_NOTE from guest memory when vmcoreinfo
> device provides the location, and write it as an ELF note in the dump.
>=20
> There are now 2 possible sources of phys_base information.
>=20
> (1) arch guessed value from cpu_dump_info_get()

I recommend using the clipboard; the function is still called
cpu_get_dump_info() :)

> (2) vmcoreinfo ELF note NUMBER(phys_base)=3D field
>=20
>     NUMBER(phys_base) in vmcoreinfo has only been recently introduced
>     in Linux 4.10 (401721ecd1dc "kexec: export the value of phys_base
>     instead of symbol address").
>=20
> Since (2) has better chances to be accurate, the guessed value is
> replaced by the value from the vmcoreinfo ELF note.
>=20
> The phys_base value is stored in the same dump field locations as
> before, and may duplicate the information available in the vmcoreinfo
> ELF PT_NOTE. Crash tools should be prepared to handle this case.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/sysemu/dump.h |   2 +
>  dump.c                | 125 ++++++++++++++++++++++++++++++++++++++++++=
++++++++
>  2 files changed, 127 insertions(+)
>=20
> diff --git a/include/sysemu/dump.h b/include/sysemu/dump.h
> index 2672a15f8b..111a7dcaa4 100644
> --- a/include/sysemu/dump.h
> +++ b/include/sysemu/dump.h
> @@ -192,6 +192,8 @@ typedef struct DumpState {
>                                    * this could be used to calculate
>                                    * how much work we have
>                                    * finished. */
> +    uint8_t *vmcoreinfo;         /* ELF note content */
> +    size_t vmcoreinfo_size;
>  } DumpState;
> =20
>  uint16_t cpu_to_dump16(DumpState *s, uint16_t val);
> diff --git a/dump.c b/dump.c
> index d9090a24cc..f699198204 100644
> --- a/dump.c
> +++ b/dump.c
> @@ -26,6 +26,8 @@
>  #include "qapi/qmp/qerror.h"
>  #include "qmp-commands.h"
>  #include "qapi-event.h"
> +#include "qemu/error-report.h"
> +#include "hw/acpi/vmcoreinfo.h"
> =20
>  #include <zlib.h>
>  #ifdef CONFIG_LZO
> @@ -38,6 +40,11 @@
>  #define ELF_MACHINE_UNAME "Unknown"
>  #endif
> =20
> +#define ELF_NOTE_SIZE(hdr_size, name_size, desc_size)   \
> +    ((DIV_ROUND_UP((hdr_size), 4) +                     \
> +      DIV_ROUND_UP((name_size), 4) +                    \
> +      DIV_ROUND_UP((desc_size), 4)) * 4)
> +
>  uint16_t cpu_to_dump16(DumpState *s, uint16_t val)
>  {
>      if (s->dump_info.d_endian =3D=3D ELFDATA2LSB) {
> @@ -76,6 +83,8 @@ static int dump_cleanup(DumpState *s)
>      guest_phys_blocks_free(&s->guest_phys_blocks);
>      memory_mapping_list_free(&s->list);
>      close(s->fd);
> +    g_free(s->vmcoreinfo);
> +    s->vmcoreinfo =3D NULL;
>      if (s->resume) {
>          if (s->detached) {
>              qemu_mutex_lock_iothread();
> @@ -235,6 +244,19 @@ static inline int cpu_index(CPUState *cpu)
>      return cpu->cpu_index + 1;
>  }
> =20
> +static void write_vmcoreinfo_note(WriteCoreDumpFunction f, DumpState *=
s,
> +                                  Error **errp)
> +{
> +    int ret;
> +
> +    if (s->vmcoreinfo) {
> +        ret =3D f(s->vmcoreinfo, s->vmcoreinfo_size, s);
> +        if (ret < 0) {
> +            error_setg(errp, "dump: failed to write vmcoreinfo");
> +        }
> +    }
> +}
> +
>  static void write_elf64_notes(WriteCoreDumpFunction f, DumpState *s,
>                                Error **errp)
>  {
> @@ -258,6 +280,8 @@ static void write_elf64_notes(WriteCoreDumpFunction=
 f, DumpState *s,
>              return;
>          }
>      }
> +
> +    write_vmcoreinfo_note(f, s, errp);
>  }
> =20
>  static void write_elf32_note(DumpState *s, Error **errp)
> @@ -303,6 +327,8 @@ static void write_elf32_notes(WriteCoreDumpFunction=
 f, DumpState *s,
>              return;
>          }
>      }
> +
> +    write_vmcoreinfo_note(f, s, errp);
>  }
> =20
>  static void write_elf_section(DumpState *s, int type, Error **errp)
> @@ -714,6 +740,44 @@ static int buf_write_note(const void *buf, size_t =
size, void *opaque)
>      return 0;
>  }
> =20
> +/*
> + * This function retrieves various sizes from an elf header.
> + *
> + * @note has to be a valid ELF note. The return sizes are unmodified
> + * (not padded or rounded up to be multiple of 4).
> + */
> +static void get_note_sizes(DumpState *s, const void *note,
> +                           uint64_t *note_head_size,
> +                           uint64_t *name_size,
> +                           uint64_t *desc_size)
> +{
> +    uint64_t note_head_sz;
> +    uint64_t name_sz;
> +    uint64_t desc_sz;
> +
> +    if (s->dump_info.d_class =3D=3D ELFCLASS64) {
> +        const Elf64_Nhdr *hdr =3D note;
> +        note_head_sz =3D sizeof(Elf64_Nhdr);
> +        name_sz =3D tswap64(hdr->n_namesz);
> +        desc_sz =3D tswap64(hdr->n_descsz);
> +    } else {
> +        const Elf32_Nhdr *hdr =3D note;
> +        note_head_sz =3D sizeof(Elf32_Nhdr);
> +        name_sz =3D tswap32(hdr->n_namesz);
> +        desc_sz =3D tswap32(hdr->n_descsz);
> +    }
> +
> +    if (note_head_size) {
> +        *note_head_size =3D note_head_sz;
> +    }
> +    if (name_size) {
> +        *name_size =3D name_sz;
> +    }
> +    if (desc_size) {
> +        *desc_size =3D desc_sz;
> +    }
> +}
> +
>  /* write common header, sub header and elf note to vmcore */
>  static void create_header32(DumpState *s, Error **errp)
>  {
> @@ -1488,10 +1552,40 @@ static int64_t dump_calculate_size(DumpState *s=
)
>      return total;
>  }
> =20
> +static void vmcoreinfo_update_phys_base(DumpState *s)
> +{
> +    uint64_t size, note_head_size, name_size, phys_base;
> +    char **lines;
> +    uint8_t *vmci;
> +    size_t i;
> +
> +    get_note_sizes(s, s->vmcoreinfo, &note_head_size, &name_size, &siz=
e);
> +    note_head_size =3D ROUND_UP(note_head_size, 4);
> +    name_size =3D ROUND_UP(name_size, 4);
> +    vmci =3D s->vmcoreinfo + note_head_size + name_size;
> +    *(vmci + size) =3D '\0';
> +
> +    lines =3D g_strsplit((char *)vmci, "\n", -1);
> +    for (i =3D 0; lines[i]; i++) {
> +        if (g_str_has_prefix(lines[i], "NUMBER(phys_base)=3D")) {
> +            if (qemu_strtou64(lines[i] + 18, NULL, 16,
> +                              &phys_base) < 0) {
> +                error_report("Failed to read NUMBER(phys_base)=3D");
> +            } else {
> +                s->dump_info.phys_base =3D phys_base;
> +            }
> +            break;
> +        }
> +    }
> +
> +    g_strfreev(lines);
> +}
> +
>  static void dump_init(DumpState *s, int fd, bool has_format,
>                        DumpGuestMemoryFormat format, bool paging, bool =
has_filter,
>                        int64_t begin, int64_t length, Error **errp)
>  {
> +    Object *vmcoreinfo_dev =3D find_vmcoreinfo_dev();
>      CPUState *cpu;
>      int nr_cpus;
>      Error *err =3D NULL;
> @@ -1563,6 +1657,37 @@ static void dump_init(DumpState *s, int fd, bool=
 has_format,
>          goto cleanup;
>      }
> =20
> +#define MAX_VMCOREINFO_SIZE (1 << 20) /* 1MB should be enough */

I think we generally place macros like this near the top of the file.
You already #define ELF_NOTE_SIZE up there.

> +    if (vmcoreinfo_dev) {

I'm sorry, I should have asked for this in the previous version -- can
you place a comment here, above the "if", saying that the goal of this
block is to (a) update the previously guessed phys_base, (b) copy the
vmcoreinfo note out of the guest? And that failure to do so is not fatal
for dumping.

> +        uint64_t addr, note_head_size, name_size, desc_size;
> +        uint32_t size;
> +
> +        note_head_size =3D s->dump_info.d_class =3D=3D ELFCLASS32 ?
> +            sizeof(Elf32_Nhdr) : sizeof(Elf64_Nhdr);
> +
> +        if (!vmcoreinfo_get(VMCOREINFO(vmcoreinfo_dev),
> +                            &addr, &size, &err)) {
> +            error_report_err(err);

Apologies, I should have noticed this too in the previous version. After
you print and free the error with error_report_err(), you should also
null the "err" variable. The dump_init() function goes on to receive
further errors into "err", and if "err" is not NULL at that point, two
things can happen:

- if a function uses error_propagate() into "err", then "err" will
appear to have been set earlier, and error_propagate() will drop the new
error.

- if error_setg() or similar is used instead, then that will trip an asse=
rt.

> +        } else if (size < note_head_size || size > MAX_VMCOREINFO_SIZE=
) {
> +            error_report("vmcoreinfo size is invalid: %u", size);

Consider using "%"PRIu32 for stylistic reasons, although in practice %u
is perfectly fine for uint32_t (since uint32_t *is* "unsigned int").

> +        } else {
> +            s->vmcoreinfo =3D g_malloc(size + 1); /* +1 for adding \0 =
*/
> +            cpu_physical_memory_read(addr, s->vmcoreinfo, size);
> +
> +            get_note_sizes(s, s->vmcoreinfo, NULL, &name_size, &desc_s=
ize);

So, to answer your earlier question, please check both "name_size" and
"desc_size" individually against MAX_VMCOREINFO_SIZE. (While preserving
the cumulative size check below, of course.) This is simple enough and
ensures neither the roundings nor the additions can overflow later.

If any of these checks fails, you'll have to free and null s->vmcoreinfo
here too.

The rest looks good!

Thanks!
Laszlo

> +            s->vmcoreinfo_size =3D ELF_NOTE_SIZE(note_head_size, name_=
size,
> +                                               desc_size);
> +            if (s->vmcoreinfo_size > size) {
> +                error_report("Invalid vmcoreinfo header, size mismatch=
");
> +                g_free(s->vmcoreinfo);
> +                s->vmcoreinfo =3D NULL;
> +            } else {
> +                vmcoreinfo_update_phys_base(s);
> +                s->note_size +=3D s->vmcoreinfo_size;
> +            }
> +        }
> +    }
> +
>      /* get memory mapping */
>      if (paging) {
>          qemu_get_guest_memory_mapping(&s->list, &s->guest_phys_blocks,=
 &err);
>=20
