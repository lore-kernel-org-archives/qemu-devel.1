Received: from eggs.gnu.org ([2001:4830:134:3::10]:42544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1dHn0P-0004GF-Eg
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 04:04:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1dHn0K-0001IE-FU
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 04:04:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37492)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>) id 1dHn0K-0001Ht-5c
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 04:04:48 -0400
Date: Mon, 5 Jun 2017 10:04:37 +0200
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20170605080437.zitza53wv7njn7ow@kamzik.brq.redhat.com>
References: <20170601130325.6433-1-marcandre.lureau@redhat.com>
	<20170601130325.6433-3-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170601130325.6433-3-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/4] dump: add vmcoreinfo ELF note
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, anderson@redhat.com, qiaonuohan@cn.fujitsu.com, lersek@redhat.com

On Thu, Jun 01, 2017 at 05:03:23PM +0400, Marc-Andr=E9 Lureau wrote:
> Read vmcoreinfo note from guest memory when dump_info provides the
> address, and write it as an ELF note in the dump.
>=20
> NUMBER(phys_base) in vmcoreinfo has only been recently introduced in
> Linux 4.10 ("kexec: export the value of phys_base instead of symbol
> address"). To accomadate for older kernels, modify the vmcoreinfo to ad=
d
> the new fields and help newer crash that will use it.
>=20
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/sysemu/dump.h |   2 +
>  dump.c                | 133 ++++++++++++++++++++++++++++++++++++++++++=
++++++++
>  2 files changed, 135 insertions(+)
>=20
> diff --git a/include/sysemu/dump.h b/include/sysemu/dump.h
> index 2672a15f8b..b8a7a1e41d 100644
> --- a/include/sysemu/dump.h
> +++ b/include/sysemu/dump.h
> @@ -192,6 +192,8 @@ typedef struct DumpState {
>                                    * this could be used to calculate
>                                    * how much work we have
>                                    * finished. */
> +    uint8_t *vmcoreinfo;
> +    size_t vmcoreinfo_size;
>  } DumpState;
> =20
>  uint16_t cpu_to_dump16(DumpState *s, uint16_t val);
> diff --git a/dump.c b/dump.c
> index bdf3270f02..6911ffad8b 100644
> --- a/dump.c
> +++ b/dump.c
> @@ -27,6 +27,7 @@
>  #include "qapi/qmp/qerror.h"
>  #include "qmp-commands.h"
>  #include "qapi-event.h"
> +#include "qemu/error-report.h"
> =20
>  #include <zlib.h>
>  #ifdef CONFIG_LZO
> @@ -88,6 +89,8 @@ static int dump_cleanup(DumpState *s)
>              qemu_mutex_unlock_iothread();
>          }
>      }
> +    g_free(s->vmcoreinfo);
> +    s->vmcoreinfo =3D NULL;
> =20
>      return 0;
>  }
> @@ -238,6 +241,19 @@ static inline int cpu_index(CPUState *cpu)
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
> @@ -261,6 +277,8 @@ static void write_elf64_notes(WriteCoreDumpFunction=
 f, DumpState *s,
>              return;
>          }
>      }
> +
> +    write_vmcoreinfo_note(f, s, errp);
>  }
> =20
>  static void write_elf32_note(DumpState *s, Error **errp)
> @@ -306,6 +324,8 @@ static void write_elf32_notes(WriteCoreDumpFunction=
 f, DumpState *s,
>              return;
>          }
>      }
> +
> +    write_vmcoreinfo_note(f, s, errp);
>  }
> =20
>  static void write_elf_section(DumpState *s, int type, Error **errp)
> @@ -717,6 +737,50 @@ static int buf_write_note(const void *buf, size_t =
size, void *opaque)
>      return 0;
>  }
> =20
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
> +        name_sz =3D hdr->n_namesz;
> +        desc_sz =3D hdr->n_descsz;
> +    } else {
> +        const Elf32_Nhdr *hdr =3D note;
> +        note_head_sz =3D sizeof(Elf32_Nhdr);
> +        name_sz =3D hdr->n_namesz;
> +        desc_sz =3D hdr->n_descsz;
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
> +static void set_note_desc_size(DumpState *s, void *note,
> +                               uint64_t desc_size)
> +{
> +    if (s->dump_info.d_class =3D=3D ELFCLASS64) {
> +        Elf64_Nhdr *hdr =3D note;
> +        hdr->n_descsz =3D desc_size;
> +    } else {
> +        Elf32_Nhdr *hdr =3D note;
> +        hdr->n_descsz =3D desc_size;
> +    }
> +}
> +
>  /* write common header, sub header and elf note to vmcore */
>  static void create_header32(DumpState *s, Error **errp)
>  {
> @@ -1491,6 +1555,42 @@ static int64_t dump_calculate_size(DumpState *s)
>      return total;
>  }
> =20
> +static void vmcoreinfo_add_phys_base(DumpState *s)
> +{
> +    uint64_t size, note_head_size, name_size;
> +    char **lines, *physbase =3D NULL;
> +    uint8_t *newvmci, *vmci;
> +    size_t i;
> +
> +    get_note_sizes(s, s->vmcoreinfo, &note_head_size, &name_size, &siz=
e);
> +    note_head_size =3D ((note_head_size + 3) / 4) * 4;
> +    name_size =3D ((name_size + 3) / 4) * 4;

I'd prefer to replace all the + 3 / 4 * 4 stuff with ROUND_UP()

> +    vmci =3D s->vmcoreinfo + note_head_size + name_size;

How about using another size variable (e.g. sz) =3D note_head_size + name=
_size

> +    *(vmci + size) =3D '\0';
> +    lines =3D g_strsplit((char *)vmci, "\n", -1);
> +    for (i =3D 0; lines[i]; i++) {
> +        if (g_str_has_prefix(lines[i], "NUMBER(phys_base)=3D")) {
> +            goto end;
> +        }
> +    }

I don't think it should be necessary to split the info first. We can
just search the entire info for the substring '\nNUMBER(phys_base)=3D'.

> +
> +    physbase =3D g_strdup_printf("\nNUMBER(phys_base)=3D%ld",
> +                               s->dump_info.phys_base);

sz +=3D size

> +    s->vmcoreinfo_size =3D
> +        ((note_head_size + name_size + size + strlen(physbase) + 3) / =
4) * 4;
> +
> +    newvmci =3D g_malloc(s->vmcoreinfo_size);
> +    memcpy(newvmci, s->vmcoreinfo, note_head_size + name_size + size -=
 1);
> +    memcpy(newvmci + note_head_size + name_size + size - 1, physbase,
> +           strlen(physbase) + 1);
> +    g_free(s->vmcoreinfo);
> +    s->vmcoreinfo =3D newvmci;

How about using g_realloc() instead?

> +    set_note_desc_size(s, s->vmcoreinfo, size + strlen(physbase));
> +
> +end:
> +    g_strfreev(lines);
> +}
> +
>  static void dump_init(DumpState *s, int fd, bool has_format,
>                        DumpGuestMemoryFormat format, bool paging, bool =
has_filter,
>                        int64_t begin, int64_t length, Error **errp)
> @@ -1566,6 +1666,39 @@ static void dump_init(DumpState *s, int fd, bool=
 has_format,
>          goto cleanup;
>      }
> =20
> +    if (dump_info.has_phys_base) {
> +        s->dump_info.phys_base =3D dump_info.phys_base;
> +    }
> +    if (dump_info.vmcoreinfo) {
> +        uint64_t addr, size, note_head_size, name_size, desc_size;
> +        int count =3D sscanf(dump_info.vmcoreinfo, "%" PRIx64 " %" PRI=
x64,
> +                           &addr, &size);
> +        if (count !=3D 2) {
> +            /* non fatal error */
> +            error_report("Failed to parse vmcoreinfo");
> +        } else {
> +            assert(!s->vmcoreinfo);
> +            s->vmcoreinfo =3D g_malloc(size);
> +            cpu_physical_memory_read(addr, s->vmcoreinfo, size);
> +
> +            get_note_sizes(s, s->vmcoreinfo,
> +                           &note_head_size, &name_size, &desc_size);
> +            s->vmcoreinfo_size =3D ((note_head_size + 3) / 4 +
> +                                  (name_size + 3) / 4 +
> +                                  (desc_size + 3) / 4) * 4;
> +            if (s->vmcoreinfo_size > size) {
> +                error_report("Invalid vmcoreinfo header, size mismatch=
");
> +                g_free(s->vmcoreinfo);
> +                s->vmcoreinfo =3D NULL;
> +            } else {
> +                if (dump_info.has_phys_base) {
> +                    vmcoreinfo_add_phys_base(s);
> +                }
> +                s->note_size +=3D s->vmcoreinfo_size;
> +            }
> +        }
> +    }
> +
>      /* get memory mapping */
>      if (paging) {
>          qemu_get_guest_memory_mapping(&s->list, &s->guest_phys_blocks,=
 &err);
> --=20
> 2.13.0.91.g00982b8dd
>=20
>

Thanks,
drew=20
