Received: from eggs.gnu.org ([2001:4830:134:3::10]:35299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dQYrP-0000Yu-Iu
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 08:47:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dQYrJ-0004pN-Rr
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 08:47:51 -0400
Received: from mail-lf0-x22d.google.com ([2a00:1450:4010:c07::22d]:35801)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dQYrJ-0004o0-3E
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 08:47:45 -0400
Received: by mail-lf0-x22d.google.com with SMTP id b207so52085019lfg.2
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 05:47:44 -0700 (PDT)
MIME-Version: 1.0
References: <20170601130325.6433-1-marcandre.lureau@redhat.com>
	<20170601130325.6433-3-marcandre.lureau@redhat.com>
	<15371905-5159-4e02-284e-08bc636f740d@redhat.com>
	<CAJ+F1C+4sY8SKkJO6PuYgbDv0A5GThAkcpFAS9TExmJgWdCJTg@mail.gmail.com>
	<6aace2e0-6a8c-bcf6-af88-07b59faabc03@redhat.com>
In-Reply-To: <6aace2e0-6a8c-bcf6-af88-07b59faabc03@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 29 Jun 2017 12:47:32 +0000
Message-ID: <CAJ+F1CLj39T3DhRQWuwzPe5VE716FW6VE=msXVqHZEDkZseEGg@mail.gmail.com>
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
Cc: qiaonuohan@cn.fujitsu.com, anderson@redhat.com, Drew Jones <drjones@redhat.com>

Hi Laszlo,

On Tue, Jun 6, 2017 at 4:21 PM Laszlo Ersek <lersek@redhat.com> wrote:

> Adding Drew
>
>
> On 06/02/17 13:13, Marc-Andr=C3=A9 Lureau wrote:
> > HI
> >
> > On Thu, Jun 1, 2017 at 10:38 PM Laszlo Ersek <lersek@redhat.com> wrote:
> >
> >> On 06/01/17 15:03, Marc-Andr=C3=A9 Lureau wrote:
> >>> Read vmcoreinfo note from guest memory when dump_info provides the
> >>> address, and write it as an ELF note in the dump.
> >>>
> >>> NUMBER(phys_base) in vmcoreinfo has only been recently introduced in
> >>> Linux 4.10 ("kexec: export the value of phys_base instead of symbol
> >>> address").
>
> I think it would be best to name commit 401721ecd1dc by hash too.
>
>
ok


> > To accomadate for older kernels, modify the vmcoreinfo to add
>
> s/accomadate/accommodate/
>

ok

>
> >>> the new fields and help newer crash that will use it.
> >>
> >> I think here you mean
> >>
> >>   modify the DumpState structure
> >>
> >> rather than
> >>
> >>   modify the vmcoreinfo
> >>
> >
> > No it's actually the content of the vmcoreinfo that is modified.
>
> OK: *what* is vmcoreinfo? Is that a structure in some program? Is it the
> file "/sys/kernel/vmcoreinfo"?
>
> The only reference to "vmcoreinfo" that I see in current QEMU is the
> "offset_vmcoreinfo" / "size_vmcoreinfo" fields in
> "include/sysemu/dump.h", in the KdumpSubHeader32 and KdumpSubHeader64
> fields. They are never populated.
>
> I guess I would understand your above sentence ("to accommodate older
> kernels...") if I knew a thing about "vmcoreinfo". I checked the kernel
> commit, and it looks like a new field is added to some kernel structure
> (or, maybe, the type of a field is changed).
>
> Are you saying that, in QEMU, when we dump older kernels, we're going to
> synthesize this field (or field type) manually? If so: what from?
>

Initially, I added support in qemu-ga to compute phys_base more accurately
than the guessed value in qemu. Then Dave Anderson suggested to use
VMCOREINFO value instead, and add it there (in the appended ELF note too)
if not present to help the tools.

But my latest iteration simply all this, and just relies on VMCOREINFO
value has being the most trustable value, that we can spread in other
places if necessary.


>
> >>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >>> ---
> >>>  include/sysemu/dump.h |   2 +
> >>>  dump.c                | 133
> >> ++++++++++++++++++++++++++++++++++++++++++++++++++
> >>>  2 files changed, 135 insertions(+)
> >>>
> >>> diff --git a/include/sysemu/dump.h b/include/sysemu/dump.h
> >>> index 2672a15f8b..b8a7a1e41d 100644
> >>> --- a/include/sysemu/dump.h
> >>> +++ b/include/sysemu/dump.h
> >>> @@ -192,6 +192,8 @@ typedef struct DumpState {
> >>>                                    * this could be used to calculate
> >>>                                    * how much work we have
> >>>                                    * finished. */
> >>> +    uint8_t *vmcoreinfo;
> >>
> >> Can you document that this is an ELF note?
> >>
> >
> > ok
> >
> >
> >>
> >>> +    size_t vmcoreinfo_size;
> >>>  } DumpState;
> >>>
> >>>  uint16_t cpu_to_dump16(DumpState *s, uint16_t val);
> >>> diff --git a/dump.c b/dump.c
> >>> index bdf3270f02..6911ffad8b 100644
> >>> --- a/dump.c
> >>> +++ b/dump.c
> >>> @@ -27,6 +27,7 @@
> >>>  #include "qapi/qmp/qerror.h"
> >>>  #include "qmp-commands.h"
> >>>  #include "qapi-event.h"
> >>> +#include "qemu/error-report.h"
> >>>
> >>>  #include <zlib.h>
> >>>  #ifdef CONFIG_LZO
> >>> @@ -88,6 +89,8 @@ static int dump_cleanup(DumpState *s)
> >>>              qemu_mutex_unlock_iothread();
> >>>          }
> >>>      }
> >>> +    g_free(s->vmcoreinfo);
> >>> +    s->vmcoreinfo =3D NULL;
> >>>
> >>>      return 0;
> >>>  }
> >>
> >> I vaguely feel that this should be moved in front of resuming VM
> >> execution. I don't have a strong reason, just consistency with the res=
t
> >> of the cleanup.
> >>
> >
> > You mean before vm_start(), ok that makes sense (although I doubt dump
> can
> > be reentered as long as the status isn't changed).
> >
> >> @@ -238,6 +241,19 @@ static inline int cpu_index(CPUState *cpu)
> >>>      return cpu->cpu_index + 1;
> >>>  }
> >>>
> >>> +static void write_vmcoreinfo_note(WriteCoreDumpFunction f, DumpState
> *s,
> >>> +                                  Error **errp)
> >>> +{
> >>> +    int ret;
> >>> +
> >>> +    if (s->vmcoreinfo) {
> >>> +        ret =3D f(s->vmcoreinfo, s->vmcoreinfo_size, s);
> >>> +        if (ret < 0) {
> >>> +            error_setg(errp, "dump: failed to write vmcoreinfo");
> >>> +        }
> >>> +    }
> >>> +}
> >>> +
> >>>  static void write_elf64_notes(WriteCoreDumpFunction f, DumpState *s,
> >>>                                Error **errp)
> >>>  {
> >>> @@ -261,6 +277,8 @@ static void write_elf64_notes(WriteCoreDumpFuncti=
on
> >> f, DumpState *s,
> >>>              return;
> >>>          }
> >>>      }
> >>> +
> >>> +    write_vmcoreinfo_note(f, s, errp);
> >>>  }
> >>>
> >>>  static void write_elf32_note(DumpState *s, Error **errp)
> >>> @@ -306,6 +324,8 @@ static void write_elf32_notes(WriteCoreDumpFuncti=
on
> >> f, DumpState *s,
> >>>              return;
> >>>          }
> >>>      }
> >>> +
> >>> +    write_vmcoreinfo_note(f, s, errp);
> >>>  }
> >>>
> >>>  static void write_elf_section(DumpState *s, int type, Error **errp)
> >>> @@ -717,6 +737,50 @@ static int buf_write_note(const void *buf, size_=
t
> >> size, void *opaque)
> >>>      return 0;
> >>>  }
> >>>
> >>> +static void get_note_sizes(DumpState *s, const void *note,
> >>> +                           uint64_t *note_head_size,
> >>> +                           uint64_t *name_size,
> >>> +                           uint64_t *desc_size)
> >>> +{
> >>
> >> I'm not happy that I have to reverse engineer what this function does.
> >> Please document it in the commit message and/or in a function-level
> >> comment, especially regarding the actual permitted types of *note.
> >>
> >>
> > ok, would that help?:
> >  /*
> >  * This function retrieves various sizes from an elf header.
> >  *
> >  * @note has to be a valid ELF note. The return sizes are unmodified
> >  * (not padded or rounded up to be multiple of 4).
> >  */
>
> Sounds good, thanks.
>
> >
> >> Very similar functionality exists in "target/i386/arch_dump.c" already=
.
> >> Is there a (remote) possibility to extract / refactor / share code?
> >>
> >>
> > Although the 2 functions share a few similarities, since they compute
> > various sizes based on elf class, they are actually quite different. I
> > don't see an easy way to refactor in a common function that would make
> > sense.
>
> OK.
>
> >
> >> +    uint64_t note_head_sz;
> >>> +    uint64_t name_sz;
> >>> +    uint64_t desc_sz;
> >>> +
> >>> +    if (s->dump_info.d_class =3D=3D ELFCLASS64) {
> >>
> >> Ugh, this is extremely confusing. This refers to DumpState.dump_info,
> >> which has type ArchDumpInfo. But in the previous patch we also introdu=
ce
> >> a global "dump_info" variable, of type DumpInfo.
> >>
> >
> >> Worse, ArchDumpInfo already has a field called "phys_base" (comment:
> >> "The target's physmem base"), and it's even filled in in
> >> "target/arm/arch_dump.c", function cpu_get_dump_info():
> >>
> >> /* Take a best guess at the phys_base. If we get it wrong then crash
> >>  * will need '--machdep phys_offset=3D<phys-offset>' added to its comm=
and
> >>  * line, which isn't any worse than assuming we can use zero, but bein=
g
> >>  * wrong. This is the same algorithm the crash utility uses when
> >>  * attempting to guess as it loads non-dumpfile formatted files.
> >>  */
> >>
> >> Looks like we already have some overlapping code / functionality for
> >> this, for the ARM target?
> >>
> >> Sorry, I'm totally lost. It must have been years since I last looked a=
t
> >> this code. I guess my comments might not make much sense, even.
> >>
> >>
> > I see it can be confusing but the explanation is quite simple.
> >
> > DumpInfo is global, and may be populated (hopefully accurately) by
> various
> > means.
>
> More precisely, the *DumpState* (not DumpInfo) structure is supposed to
> carry information over a single invocation of the dump command. It
> happens to be the case that we also have a single global variable of
> that type, so that the monitor commands can find it (I guess?) when dump
> is launched into the background.
>
> (See, the fact that you mistyped "DumpState" as "DumpInfo" is the best
> evidence that this code is horribly confusing. That's not your fault at
> all, of course! But it's all the more important to write detailed commit
> messages and/or fix up some comments too.)
>
> Ahhh, wait, here you mean DumpInfo as introduced by *this* patch set
> (patch #1). In that sense, DumpInfo is global to the full lifetime of
> the guest.
>
> This is incredibly confusing. Please give "DumpInfo" and "dump_info" a
> much longer and better name. Like "VmcoreDetailsFromGuest", or
> "GuestReportedVmcoreDetails" or whatever.
>
>
This is gone in the last iteration, since I dropped qemu-ga approach. I'll
send the new version using vmcoreinfo device only.

>
> > DumpState and ArchDumpInfo is populated when starting a dump.
> > cpu_get_dump_info() make a best guess at phys_base on arm.
>
> OK, I see that now, thanks. When dump_init() runs, "s" refers to
> "dump_state_global" (of type DumpState). And, we have
>
> dump_init()
>   cpu_get_dump_info(&s->dump_info, ...)
>
> where "s->dump_info" is of type ArchDumpInfo.
>
> Alas, this field name conflicts badly (for human comprehension) with the
> "dump_info" global variable name introduced in patch #1 (see my gripe
> above).
>
> > After this call, dump_init() will override phys_base with the global
> > dump_info.phys_base which should be correct if it exists.
>
> (So this is not the current code, this is about what this patch does. OK.=
)
>
> >
> > Do you have a suggestion on how to make this clearer beside adding some
> > comments?
> >
> > Should we rename DumpState.dump_info to DumpState_arch_dump_info to avo=
id
> > the confusion?
>
> Yes, please do *all* of this. When information is overwritten with more
> exact info, or from a better source, or with info having higher
> priority, that should be documented in the code, in the commit message.
> And, the rename you suggest is also a good idea.
>
>
> Here's another piece I find confusing. In dump_init(), we have a comment
> saying:
>
>     /* get dump info: endian, class and architecture.
>      * If the target architecture is not supported, cpu_get_dump_info()
> will
>      * return -1.
>      */
>     ret =3D cpu_get_dump_info(&s->dump_info, &s->guest_phys_blocks);
>
> The comment (and the function name) suggest that cpu_get_dump_info()
> collects only three dump details (endianness, class, architecture), and
> that those depend on only on CPU state. This text goes back to initial
> dump commit 783e9b4826b9 ("introduce a new monitor command
> 'dump-guest-memory' to dump guest's memory", 2012-05-07).
>
> Today, this comment is stale. See the cpu_get_dump_info()
> implementations in:
>
> - target/s390x/arch_dump.c: the original comment holds.
> - target/ppc/arch_dump.c: the original comment holds.
> - target/i386/arch_dump.c: the function name does not match, because
> beyond CPU state, the memory map is consulted too
> - target/arm/arch_dump.c: the function name does not match, because in
> addition to CPU state, the memory map is consulted too. Also, the
> information collected goes beyond endianness / class / architecture, we
> populate "page_size" and "phys_base" too.
>
> These changes seem to be related to Drew's work from commit f1cd483004da
> ("qapi-schema: dump-guest-memory: Improve text", 2016-01-11) through
> commit ade0d0c0d3a0 ("target-arm: dump-guest-memory: add vfp notes for
> arm", 2016-01-11), inclusive. I think we should now remove the explicit
> references to "endian, class and architecture"; we should rather say
> "try to collect a bunch of crash & ELF related info from guest CPU state
> and physical memory map".
>
> >> Please post a version 3, with as detailed as possible commit messages,
> >> explaining your entire thought process, the data flow, how this featur=
e
> >> fits into the old code, and all the modifications. Personally at least=
,
> >> I need a complete re-introduction to this, to make heads or tails of
> >> your changes.
> >>
> >> I mean I certainly don't *insist* on reviewing this code, it's just th=
at
> >> if you'd like me to comment on it, you'll have to document all the
> >> investigative work you've done before / while writing it.
> >>
> >
> >
> > The flow is as follow:
> >
> > - by some means (guest agent, dedicated device etc), the guest populate=
s
> > the DumpInfo structure with various details, such as phys_base and the
> > content of /sys/kernel/vmcoreinfo
>
> OK.
>
> >
> > - during dump, if dump_info.phys_base has been populated, it takes
> > precedence over previously guessed value
>
> Well, chronologically, the guessing occurs *after* the guest agent or
> dedicated device told QEMU the definitive phys_base.
>
> So I guess we could improve things a bit (for human comprehension) if
> cpu_get_dump_info() were told not to guess phys_base if we already have
> it from a better source. Or else, separate out the phys_base guessing
> from cpu_get_dump_info() as first step, and then use it as a fallback,
> if we have no better source of information.
>
> >
> > - during dump, if dump_info.vmcoreinfo is populated, parse the phys
> address
> > and size of the vmcoreinfo ELF note
>
> So you're saying that "/sys/kernel/vmcoreinfo" is already formatted as
> an ELF note?
>
> Ah, no. Apparently, "/sys/kernel/vmcoreinfo" is a text file which tells
> you where to read guest memory, to grab that ELF note.
>
> The "DumpInfo.vmcoreinfo" field should be documented much better. The
> comment currently says "the content of /sys/kernel/vmcoreinfo on Linux",
> which doesn't tell me anything at all, because I don't know what that
> file contains.
>
>
gone


> >
> > - check the ELF note header and size. If invalid, don't dump it. The si=
ze
> > is 4-byte aligned.
>
> OK.
>
> >
> > - vmcoreinfo_add_phys_base() will check if NUMBER(phys_base)=3D is pres=
ent,
> > if not, modify the note to add it.
>
> Wow!!! We're reaching a new height of confusion here. So you are saying
> that we actually have *three* sources for phys_base, namely (in order of
> increasing importance):
>
> (1) whatever cpu_get_dump_info() guesses, based on QEMU target arch
> (2) whatever the guest agent or guest ACPI device tells us, via
> DumpInfo.phys_base
> (3) whatever the guest kernel's own "vmcoreinfo" ELF note tells us,
> which we read directly from guest memory, using the address and size
> found in the guest's "/sys/kernel/vmcoreinfo" file.
>
> Furthermore, dependent on the output format that we produce for "crash"
> (ELF vs. kdump-compressed), we output either *one* piece of phys_base
> information in the dump, or *two*:
>
> * If the output format is ELF, we produce one "phys_base" instance,
> namely on the following call path:
>
>   dump_process()
>     create_vmcore()
>       dump_begin()
>         write_elf32_notes() | write_elf64_notes()
>           write_vmcoreinfo_note()
>
> * If the output format is kdump-compressed, we produce *two* "phys_base"
> instances, namely on the following call tree:
>
>   dump_process()
>     create_kdump_vmcore()
>       write_dump_header()
>         create_header32() | create_header64()
>           kh->phys_base =3D ... s->dump_info.phys_base ...
>           write_buffer()                      <-- instance #1 written
>           ...
>           write_elf32_notes() | write_elf64_notes()
>             write_vmcoreinfo_note()
>           write_buffer()                      <-- instance #2 written
>
> This is because in the second case (=3D kdump-compressed format), the
> KdumpSubHeader32 / KdumpSubHeader64 structures already contain
> "phys_base" themselves.
>
> Worst of all, the two pieces of "phys_base" info that we provide can
> even conflict. Imagine the case when the guest kernel offers -- via
> method (3) -- its own vmcoreinfo ELF note, complete with "phys_base".
> That means we're going to write it out verbatim as instance #2. Now
> assume that via methods (1) or (2), we also collect a *different*
> phys_base value. This value will be written out as instance #1. And then
> "crash" will encounter conflicting "phys_base" values.
>
>
> ... Looking at patch #3, I'm getting *even more* confused (if that is
> possible). It seems that there you populate the "offset_vmcoreinfo" /
> "size_vmcoreinfo" fields that I mentioned near the top, and then write
> out a *third* instance of the "phys_base" information (as a complete
> vmcoreinfo note), right before you write out the exact same note anyway,
> marked as "instance #2" above.
>
> I think you may have missed that write_elf32_notes() and
> write_elf64_notes() are called *both* for ELF-formatted dumps *and* for
> kdump-compressed dumps.
>
>
No, I didn't miss that, there is an explicit field in kdump header for the
location of the ELF PT_NOTE, and that's what I populated, along with the
rest of the elf notes.


> ... So, I don't think this is "quite simple" :(
>
> If my opinion matters, I'd like to see the following:
>
> (i) a clear definition, in documentation (commit message and code
> comments), of *priorities* between the phys_base sources.
>
>
It's now as simple as: qemu initially guesses the value, then checks if
vmcoreinfo has a more accurate value. We could refactor the code to avoid
the initial guessing, but the gain is very minimal at this point.


> (ii) currently the priorities are not implemented correctly. See my
> example above: "s->dump_info.phys_base" is not refreshed from the
> kernel's own vmcoreinfo ELF note, if the latter also contains
> "phys_base". This is a problem because we pass both of these instances
> to "crash", if the output format is kdump-compressed.
>

Crash has to deal with potentially conflicting values anyway, given there
are potentially multiple sources.

In qemu, we can make sure it's the same value. Last iteration does that


>
> (iii) writing out the vmcoreinfo note in write_elf32_notes() /
> write_elf64_notes() is inappropriate, because this way the same code
> will be invoked for the kdump formats too, which is wrong. The right
> place to call write_vmcoreinfo_note() is near the end of dump_begin(),
> after the 32/64 bit branches end, where it will run only for the ELF
> format.
>

No, we want vmcoreinfo notes in kdump too.


>
> (iv) I think it would be worth investigating whether we can produce
> *exactly one* phys_base hint for crash, regardless of the output format
> (ELF vs. kdump-compressed). Bullet (iii) above covers the ELF case -- in
> the ELF case, there really may not be a way around writing a full
> vmcoreinfo note. However, in the kdump case, we already write
> "phys_base" as part of KdumpSubHeader32 / KdumpSubHeader64 -- so how
> about dropping the third patch in the series, and synching the guest
> kernel's vmcoreinfo note (the phys_base field thereof) to
> "s->dump_info.phys_base" instead?
>
>
The best value is the one from VMCOREINFO, so s->dump_info.phys_base will
be updated, as explained earlier.


> This would also be helpful because it would make the
> "s->dump_info.phys_base" field the master location of phys_base:
> - highest priority: set from the guest kernel vmcoreinfo note, if that
> note exists, is valid, and provides the value.
> - mid priority: otherwise, set from the direct value reported by the
> guest agent or by the ACPI device
> - low priority: otherwise, let cpu_get_dump_info() guess it.
>
> Some more comments below (more superficial in nature):
>
> >
> > - modify s->note_size to account for vmcoreinfo note size
> >
> > - write_vmcoreinfo_note() when writing all the populated notes.
> >
> > Please ask any question to help you clarify this patch.
> >
> > thanks
> >
> >
> >>
> >>> +        const Elf64_Nhdr *hdr =3D note;
> >>> +        note_head_sz =3D sizeof(Elf64_Nhdr);
> >>> +        name_sz =3D hdr->n_namesz;
> >>> +        desc_sz =3D hdr->n_descsz;
> >>> +    } else {
> >>> +        const Elf32_Nhdr *hdr =3D note;
> >>> +        note_head_sz =3D sizeof(Elf32_Nhdr);
> >>> +        name_sz =3D hdr->n_namesz;
> >>> +        desc_sz =3D hdr->n_descsz;
> >>> +    }
> >>> +
> >>> +    if (note_head_size) {
> >>> +        *note_head_size =3D note_head_sz;
> >>> +    }
> >>> +    if (name_size) {
> >>> +        *name_size =3D name_sz;
> >>> +    }
> >>> +    if (desc_size) {
> >>> +        *desc_size =3D desc_sz;
> >>> +    }
> >>> +}
> >>> +
> >>> +static void set_note_desc_size(DumpState *s, void *note,
> >>> +                               uint64_t desc_size)
> >>> +{
> >>> +    if (s->dump_info.d_class =3D=3D ELFCLASS64) {
> >>> +        Elf64_Nhdr *hdr =3D note;
> >>> +        hdr->n_descsz =3D desc_size;
> >>> +    } else {
> >>> +        Elf32_Nhdr *hdr =3D note;
> >>> +        hdr->n_descsz =3D desc_size;
> >>> +    }
> >>> +}
> >>> +
> >>>  /* write common header, sub header and elf note to vmcore */
> >>>  static void create_header32(DumpState *s, Error **errp)
> >>>  {
> >>> @@ -1491,6 +1555,42 @@ static int64_t dump_calculate_size(DumpState *=
s)
> >>>      return total;
> >>>  }
> >>>
> >>> +static void vmcoreinfo_add_phys_base(DumpState *s)
> >>> +{
> >>> +    uint64_t size, note_head_size, name_size;
> >>> +    char **lines, *physbase =3D NULL;
> >>> +    uint8_t *newvmci, *vmci;
> >>> +    size_t i;
> >>> +
> >>> +    get_note_sizes(s, s->vmcoreinfo, &note_head_size, &name_size,
> >> &size);
> >>> +    note_head_size =3D ((note_head_size + 3) / 4) * 4;
>
> Can we replace these awkward roundings with ROUND_UP()?
>
> ROUND_UP() works only with powers of two (the more general version is
> QEMU_ALIGN_UP()), but here we're rounding up to a multiple of four, so
> ROUND_UP() should be fine.
>
> In fact I might even be calling for a separate patch that convers the
> rest of these roundings in the dump code to ROUND_UP.
>

ok (this and other similar remarks triggered my work on clang tools btw,
https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg05034.html)


> It's up to you.
>
> >>> +    name_size =3D ((name_size + 3) / 4) * 4;
> >>> +    vmci =3D s->vmcoreinfo + note_head_size + name_size;
> >>> +    *(vmci + size) =3D '\0';
> >>> +    lines =3D g_strsplit((char *)vmci, "\n", -1);
> >>> +    for (i =3D 0; lines[i]; i++) {
> >>> +        if (g_str_has_prefix(lines[i], "NUMBER(phys_base)=3D")) {
> >>> +            goto end;
> >>> +        }
> >>> +    }
> >>> +
> >>> +    physbase =3D g_strdup_printf("\nNUMBER(phys_base)=3D%ld",
> >>> +                               s->dump_info.phys_base);
> >>> +    s->vmcoreinfo_size =3D
> >>> +        ((note_head_size + name_size + size + strlen(physbase) + 3) =
/
> >> 4) * 4;
> >>> +
> >>> +    newvmci =3D g_malloc(s->vmcoreinfo_size);
> >>> +    memcpy(newvmci, s->vmcoreinfo, note_head_size + name_size + size=
 -
> >> 1);
> >>> +    memcpy(newvmci + note_head_size + name_size + size - 1, physbase=
,
> >>> +           strlen(physbase) + 1);
> >>> +    g_free(s->vmcoreinfo);
> >>> +    s->vmcoreinfo =3D newvmci;
> >>> +    set_note_desc_size(s, s->vmcoreinfo, size + strlen(physbase));
> >>> +
> >>> +end:
> >>> +    g_strfreev(lines);
> >>> +}
> >>> +
> >>>  static void dump_init(DumpState *s, int fd, bool has_format,
> >>>                        DumpGuestMemoryFormat format, bool paging, boo=
l
> >> has_filter,
> >>>                        int64_t begin, int64_t length, Error **errp)
> >>> @@ -1566,6 +1666,39 @@ static void dump_init(DumpState *s, int fd, bo=
ol
> >> has_format,
> >>>          goto cleanup;
> >>>      }
> >>>
> >>> +    if (dump_info.has_phys_base) {
> >>> +        s->dump_info.phys_base =3D dump_info.phys_base;
> >>> +    }
> >>> +    if (dump_info.vmcoreinfo) {
> >>> +        uint64_t addr, size, note_head_size, name_size, desc_size;
> >>> +        int count =3D sscanf(dump_info.vmcoreinfo, "%" PRIx64 " %"
> PRIx64,
> >>> +                           &addr, &size);
>
> sscanf() must not be used with untrusted input (which guest kernel data
> definitely is). Please see:
>
> http://pubs.opengroup.org/onlinepubs/9699919799/functions/sscanf.html
>
>     Unless assignment suppression was indicated by a '*', the result of
>     the conversion shall be placed in the object pointed to by the first
>     argument following the format argument that has not already received
>     a conversion result if the conversion specification is introduced by
>     %, [CX] [Option Start] or in the nth argument if introduced by the
>     character sequence "%n$". [Option End] If this object does not have
>     an appropriate type, or if the result of the conversion cannot be
>                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>     represented in the space provided, the behavior is undefined.
>     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
> You get undefined behavior if the guest kernel presents, say, the
> following in /sys/kernel/vmcoreinfo:
>
> 99999999999999999999999999999999999999999999999999999999999999999999 1
>
> (As a side point, for the fscanf() family of functions, the conversion
> specifier macros aren't PRIxN-style but SCNxN style:
>
> http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/inttypes.h.html
> )
>
> So, instead of sscanf(), please call qemu_strtou64() twice in
> succession. The first invocation will tell you (if it succeeds, that
> is), where to start the second invocation.
>

This is gone, vmcoreinfo device provides direct values.


>
> Thanks,
> Laszlo
>
> >>> +        if (count !=3D 2) {
> >>> +            /* non fatal error */
> >>> +            error_report("Failed to parse vmcoreinfo");
> >>> +        } else {
> >>> +            assert(!s->vmcoreinfo);
> >>> +            s->vmcoreinfo =3D g_malloc(size);
> >>> +            cpu_physical_memory_read(addr, s->vmcoreinfo, size);
> >>> +
> >>> +            get_note_sizes(s, s->vmcoreinfo,
> >>> +                           &note_head_size, &name_size, &desc_size);
> >>> +            s->vmcoreinfo_size =3D ((note_head_size + 3) / 4 +
> >>> +                                  (name_size + 3) / 4 +
> >>> +                                  (desc_size + 3) / 4) * 4;
> >>> +            if (s->vmcoreinfo_size > size) {
> >>> +                error_report("Invalid vmcoreinfo header, size
> >> mismatch");
> >>> +                g_free(s->vmcoreinfo);
> >>> +                s->vmcoreinfo =3D NULL;
> >>> +            } else {
> >>> +                if (dump_info.has_phys_base) {
> >>> +                    vmcoreinfo_add_phys_base(s);
> >>> +                }
> >>> +                s->note_size +=3D s->vmcoreinfo_size;
> >>> +            }
> >>> +        }
> >>> +    }
> >>> +
> >>>      /* get memory mapping */
> >>>      if (paging) {
> >>>          qemu_get_guest_memory_mapping(&s->list, &s->guest_phys_block=
s,
> >> &err);
> >>>
> >>
> >>
> >> --
> > Marc-Andr=C3=A9 Lureau
> >
>
> --
Marc-Andr=C3=A9 Lureau
