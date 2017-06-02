Received: from eggs.gnu.org ([2001:4830:134:3::10]:34523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dGkW4-0002iR-So
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 07:13:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dGkW1-0008Dq-Si
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 07:13:16 -0400
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:36489)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dGkW1-0008Cr-CF
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 07:13:13 -0400
Received: by mail-lf0-x244.google.com with SMTP id h4so6425516lfj.3
	for <qemu-devel@nongnu.org>; Fri, 02 Jun 2017 04:13:13 -0700 (PDT)
MIME-Version: 1.0
References: <20170601130325.6433-1-marcandre.lureau@redhat.com>
	<20170601130325.6433-3-marcandre.lureau@redhat.com>
	<15371905-5159-4e02-284e-08bc636f740d@redhat.com>
In-Reply-To: <15371905-5159-4e02-284e-08bc636f740d@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 02 Jun 2017 11:13:00 +0000
Message-ID: <CAJ+F1C+4sY8SKkJO6PuYgbDv0A5GThAkcpFAS9TExmJgWdCJTg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org
Cc: qiaonuohan@cn.fujitsu.com, anderson@redhat.com

HI

On Thu, Jun 1, 2017 at 10:38 PM Laszlo Ersek <lersek@redhat.com> wrote:

> On 06/01/17 15:03, Marc-Andr=C3=A9 Lureau wrote:
> > Read vmcoreinfo note from guest memory when dump_info provides the
> > address, and write it as an ELF note in the dump.
> >
> > NUMBER(phys_base) in vmcoreinfo has only been recently introduced in
> > Linux 4.10 ("kexec: export the value of phys_base instead of symbol
> > address"). To accomadate for older kernels, modify the vmcoreinfo to ad=
d
> > the new fields and help newer crash that will use it.
>
> I think here you mean
>
>   modify the DumpState structure
>
> rather than
>
>   modify the vmcoreinfo
>

No it's actually the content of the vmcoreinfo that is modified.


>
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  include/sysemu/dump.h |   2 +
> >  dump.c                | 133
> ++++++++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 135 insertions(+)
> >
> > diff --git a/include/sysemu/dump.h b/include/sysemu/dump.h
> > index 2672a15f8b..b8a7a1e41d 100644
> > --- a/include/sysemu/dump.h
> > +++ b/include/sysemu/dump.h
> > @@ -192,6 +192,8 @@ typedef struct DumpState {
> >                                    * this could be used to calculate
> >                                    * how much work we have
> >                                    * finished. */
> > +    uint8_t *vmcoreinfo;
>
> Can you document that this is an ELF note?
>

ok


>
> > +    size_t vmcoreinfo_size;
> >  } DumpState;
> >
> >  uint16_t cpu_to_dump16(DumpState *s, uint16_t val);
> > diff --git a/dump.c b/dump.c
> > index bdf3270f02..6911ffad8b 100644
> > --- a/dump.c
> > +++ b/dump.c
> > @@ -27,6 +27,7 @@
> >  #include "qapi/qmp/qerror.h"
> >  #include "qmp-commands.h"
> >  #include "qapi-event.h"
> > +#include "qemu/error-report.h"
> >
> >  #include <zlib.h>
> >  #ifdef CONFIG_LZO
> > @@ -88,6 +89,8 @@ static int dump_cleanup(DumpState *s)
> >              qemu_mutex_unlock_iothread();
> >          }
> >      }
> > +    g_free(s->vmcoreinfo);
> > +    s->vmcoreinfo =3D NULL;
> >
> >      return 0;
> >  }
>
> I vaguely feel that this should be moved in front of resuming VM
> execution. I don't have a strong reason, just consistency with the rest
> of the cleanup.
>

You mean before vm_start(), ok that makes sense (although I doubt dump can
be reentered as long as the status isn't changed).

> @@ -238,6 +241,19 @@ static inline int cpu_index(CPUState *cpu)
> >      return cpu->cpu_index + 1;
> >  }
> >
> > +static void write_vmcoreinfo_note(WriteCoreDumpFunction f, DumpState *=
s,
> > +                                  Error **errp)
> > +{
> > +    int ret;
> > +
> > +    if (s->vmcoreinfo) {
> > +        ret =3D f(s->vmcoreinfo, s->vmcoreinfo_size, s);
> > +        if (ret < 0) {
> > +            error_setg(errp, "dump: failed to write vmcoreinfo");
> > +        }
> > +    }
> > +}
> > +
> >  static void write_elf64_notes(WriteCoreDumpFunction f, DumpState *s,
> >                                Error **errp)
> >  {
> > @@ -261,6 +277,8 @@ static void write_elf64_notes(WriteCoreDumpFunction
> f, DumpState *s,
> >              return;
> >          }
> >      }
> > +
> > +    write_vmcoreinfo_note(f, s, errp);
> >  }
> >
> >  static void write_elf32_note(DumpState *s, Error **errp)
> > @@ -306,6 +324,8 @@ static void write_elf32_notes(WriteCoreDumpFunction
> f, DumpState *s,
> >              return;
> >          }
> >      }
> > +
> > +    write_vmcoreinfo_note(f, s, errp);
> >  }
> >
> >  static void write_elf_section(DumpState *s, int type, Error **errp)
> > @@ -717,6 +737,50 @@ static int buf_write_note(const void *buf, size_t
> size, void *opaque)
> >      return 0;
> >  }
> >
> > +static void get_note_sizes(DumpState *s, const void *note,
> > +                           uint64_t *note_head_size,
> > +                           uint64_t *name_size,
> > +                           uint64_t *desc_size)
> > +{
>
> I'm not happy that I have to reverse engineer what this function does.
> Please document it in the commit message and/or in a function-level
> comment, especially regarding the actual permitted types of *note.
>
>
ok, would that help?:
 /*
 * This function retrieves various sizes from an elf header.
 *
 * @note has to be a valid ELF note. The return sizes are unmodified
 * (not padded or rounded up to be multiple of 4).
 */

> Very similar functionality exists in "target/i386/arch_dump.c" already.
> Is there a (remote) possibility to extract / refactor / share code?
>
>
Although the 2 functions share a few similarities, since they compute
various sizes based on elf class, they are actually quite different. I
don't see an easy way to refactor in a common function that would make
sense.

> +    uint64_t note_head_sz;
> > +    uint64_t name_sz;
> > +    uint64_t desc_sz;
> > +
> > +    if (s->dump_info.d_class =3D=3D ELFCLASS64) {
>
> Ugh, this is extremely confusing. This refers to DumpState.dump_info,
> which has type ArchDumpInfo. But in the previous patch we also introduce
> a global "dump_info" variable, of type DumpInfo.
>

Worse, ArchDumpInfo already has a field called "phys_base" (comment:
> "The target's physmem base"), and it's even filled in in
> "target/arm/arch_dump.c", function cpu_get_dump_info():
>
> /* Take a best guess at the phys_base. If we get it wrong then crash
>  * will need '--machdep phys_offset=3D<phys-offset>' added to its command
>  * line, which isn't any worse than assuming we can use zero, but being
>  * wrong. This is the same algorithm the crash utility uses when
>  * attempting to guess as it loads non-dumpfile formatted files.
>  */
>
> Looks like we already have some overlapping code / functionality for
> this, for the ARM target?
>
> Sorry, I'm totally lost. It must have been years since I last looked at
> this code. I guess my comments might not make much sense, even.
>
>
I see it can be confusing but the explanation is quite simple.

DumpInfo is global, and may be populated (hopefully accurately) by various
means.

DumpState and ArchDumpInfo is populated when starting a dump.
cpu_get_dump_info() make a best guess at phys_base on arm.

After this call, dump_init() will override phys_base with the global
dump_info.phys_base which should be correct if it exists.

Do you have a suggestion on how to make this clearer beside adding some
comments?

Should we rename DumpState.dump_info to DumpState_arch_dump_info to avoid
the confusion?


> Please post a version 3, with as detailed as possible commit messages,
> explaining your entire thought process, the data flow, how this feature
> fits into the old code, and all the modifications. Personally at least,
> I need a complete re-introduction to this, to make heads or tails of
> your changes.
>
> I mean I certainly don't *insist* on reviewing this code, it's just that
> if you'd like me to comment on it, you'll have to document all the
> investigative work you've done before / while writing it.
>


The flow is as follow:

- by some means (guest agent, dedicated device etc), the guest populates
the DumpInfo structure with various details, such as phys_base and the
content of /sys/kernel/vmcoreinfo

- during dump, if dump_info.phys_base has been populated, it takes
precedence over previously guessed value

- during dump, if dump_info.vmcoreinfo is populated, parse the phys address
and size of the vmcoreinfo ELF note

- check the ELF note header and size. If invalid, don't dump it. The size
is 4-byte aligned.

- vmcoreinfo_add_phys_base() will check if NUMBER(phys_base)=3D is present,
if not, modify the note to add it.

- modify s->note_size to account for vmcoreinfo note size

- write_vmcoreinfo_note() when writing all the populated notes.

Please ask any question to help you clarify this patch.

thanks


>
> > +        const Elf64_Nhdr *hdr =3D note;
> > +        note_head_sz =3D sizeof(Elf64_Nhdr);
> > +        name_sz =3D hdr->n_namesz;
> > +        desc_sz =3D hdr->n_descsz;
> > +    } else {
> > +        const Elf32_Nhdr *hdr =3D note;
> > +        note_head_sz =3D sizeof(Elf32_Nhdr);
> > +        name_sz =3D hdr->n_namesz;
> > +        desc_sz =3D hdr->n_descsz;
> > +    }
> > +
> > +    if (note_head_size) {
> > +        *note_head_size =3D note_head_sz;
> > +    }
> > +    if (name_size) {
> > +        *name_size =3D name_sz;
> > +    }
> > +    if (desc_size) {
> > +        *desc_size =3D desc_sz;
> > +    }
> > +}
> > +
> > +static void set_note_desc_size(DumpState *s, void *note,
> > +                               uint64_t desc_size)
> > +{
> > +    if (s->dump_info.d_class =3D=3D ELFCLASS64) {
> > +        Elf64_Nhdr *hdr =3D note;
> > +        hdr->n_descsz =3D desc_size;
> > +    } else {
> > +        Elf32_Nhdr *hdr =3D note;
> > +        hdr->n_descsz =3D desc_size;
> > +    }
> > +}
> > +
> >  /* write common header, sub header and elf note to vmcore */
> >  static void create_header32(DumpState *s, Error **errp)
> >  {
> > @@ -1491,6 +1555,42 @@ static int64_t dump_calculate_size(DumpState *s)
> >      return total;
> >  }
> >
> > +static void vmcoreinfo_add_phys_base(DumpState *s)
> > +{
> > +    uint64_t size, note_head_size, name_size;
> > +    char **lines, *physbase =3D NULL;
> > +    uint8_t *newvmci, *vmci;
> > +    size_t i;
> > +
> > +    get_note_sizes(s, s->vmcoreinfo, &note_head_size, &name_size,
> &size);
> > +    note_head_size =3D ((note_head_size + 3) / 4) * 4;
> > +    name_size =3D ((name_size + 3) / 4) * 4;
> > +    vmci =3D s->vmcoreinfo + note_head_size + name_size;
> > +    *(vmci + size) =3D '\0';
> > +    lines =3D g_strsplit((char *)vmci, "\n", -1);
> > +    for (i =3D 0; lines[i]; i++) {
> > +        if (g_str_has_prefix(lines[i], "NUMBER(phys_base)=3D")) {
> > +            goto end;
> > +        }
> > +    }
> > +
> > +    physbase =3D g_strdup_printf("\nNUMBER(phys_base)=3D%ld",
> > +                               s->dump_info.phys_base);
> > +    s->vmcoreinfo_size =3D
> > +        ((note_head_size + name_size + size + strlen(physbase) + 3) /
> 4) * 4;
> > +
> > +    newvmci =3D g_malloc(s->vmcoreinfo_size);
> > +    memcpy(newvmci, s->vmcoreinfo, note_head_size + name_size + size -
> 1);
> > +    memcpy(newvmci + note_head_size + name_size + size - 1, physbase,
> > +           strlen(physbase) + 1);
> > +    g_free(s->vmcoreinfo);
> > +    s->vmcoreinfo =3D newvmci;
> > +    set_note_desc_size(s, s->vmcoreinfo, size + strlen(physbase));
> > +
> > +end:
> > +    g_strfreev(lines);
> > +}
> > +
> >  static void dump_init(DumpState *s, int fd, bool has_format,
> >                        DumpGuestMemoryFormat format, bool paging, bool
> has_filter,
> >                        int64_t begin, int64_t length, Error **errp)
> > @@ -1566,6 +1666,39 @@ static void dump_init(DumpState *s, int fd, bool
> has_format,
> >          goto cleanup;
> >      }
> >
> > +    if (dump_info.has_phys_base) {
> > +        s->dump_info.phys_base =3D dump_info.phys_base;
> > +    }
> > +    if (dump_info.vmcoreinfo) {
> > +        uint64_t addr, size, note_head_size, name_size, desc_size;
> > +        int count =3D sscanf(dump_info.vmcoreinfo, "%" PRIx64 " %" PRI=
x64,
> > +                           &addr, &size);
> > +        if (count !=3D 2) {
> > +            /* non fatal error */
> > +            error_report("Failed to parse vmcoreinfo");
> > +        } else {
> > +            assert(!s->vmcoreinfo);
> > +            s->vmcoreinfo =3D g_malloc(size);
> > +            cpu_physical_memory_read(addr, s->vmcoreinfo, size);
> > +
> > +            get_note_sizes(s, s->vmcoreinfo,
> > +                           &note_head_size, &name_size, &desc_size);
> > +            s->vmcoreinfo_size =3D ((note_head_size + 3) / 4 +
> > +                                  (name_size + 3) / 4 +
> > +                                  (desc_size + 3) / 4) * 4;
> > +            if (s->vmcoreinfo_size > size) {
> > +                error_report("Invalid vmcoreinfo header, size
> mismatch");
> > +                g_free(s->vmcoreinfo);
> > +                s->vmcoreinfo =3D NULL;
> > +            } else {
> > +                if (dump_info.has_phys_base) {
> > +                    vmcoreinfo_add_phys_base(s);
> > +                }
> > +                s->note_size +=3D s->vmcoreinfo_size;
> > +            }
> > +        }
> > +    }
> > +
> >      /* get memory mapping */
> >      if (paging) {
> >          qemu_get_guest_memory_mapping(&s->list, &s->guest_phys_blocks,
> &err);
> >
>
>
> --
Marc-Andr=C3=A9 Lureau
