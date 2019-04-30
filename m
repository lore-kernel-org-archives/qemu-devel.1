Received: from eggs.gnu.org ([209.51.188.92]:58654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hLZuV-0002ix-R0
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 17:03:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hLZuU-0001tK-B3
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 17:03:31 -0400
MIME-Version: 1.0
References: <cover.1556650594.git.alistair.francis@wdc.com>
	<6bfa446eb7c351b5d867eb4158198231af724b11.1556650594.git.alistair.francis@wdc.com>
	<d4dd0758-64af-e249-1f1b-b52af014b404@vivier.eu>
In-Reply-To: <d4dd0758-64af-e249-1f1b-b52af014b404@vivier.eu>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 30 Apr 2019 14:01:35 -0700
Message-ID: <CAKmqyKNx2r93-ASC0dAZJvu_36dV69sRj92-m6G9zXqLdc2sag@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 5/5] linux-user/elfload: Fix GCC 9 build
 warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kraxel@redhat.com" <kraxel@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>

On Tue, Apr 30, 2019 at 1:36 PM Laurent Vivier <laurent@vivier.eu> wrote:
>
> Le 30/04/2019 =C3=A0 22:09, Alistair Francis a =C3=A9crit :
> > Fix this warning when building with GCC9 on Fedora 30:
> > In function =E2=80=98strncpy=E2=80=99,
> >     inlined from =E2=80=98fill_psinfo=E2=80=99 at /home/alistair/qemu/l=
inux-user/elfload.c:3208:12,
> >     inlined from =E2=80=98fill_note_info=E2=80=99 at /home/alistair/qem=
u/linux-user/elfload.c:3390:5,
> >     inlined from =E2=80=98elf_core_dump=E2=80=99 at /home/alistair/qemu=
/linux-user/elfload.c:3539:9:
> > /usr/include/bits/string_fortified.h:106:10: error: =E2=80=98__builtin_=
strncpy=E2=80=99 specified bound 16 equals destination size [-Werror=3Dstri=
ngop-truncation]
> >   106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos (=
__dest));
> >       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >  linux-user/elfload.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> > index c1a26021f8..cbb7fc10fa 100644
> > --- a/linux-user/elfload.c
> > +++ b/linux-user/elfload.c
> > @@ -3206,7 +3206,7 @@ static int fill_psinfo(struct target_elf_prpsinfo=
 *psinfo, const TaskState *ts)
>
>        /*
>         * Using strncpy here is fine: at max-length,
> >       * this field is not NUL-terminated.
> >       */>      (void) strncpy(psinfo->pr_fname, base_filename,
> > -                   sizeof(psinfo->pr_fname));
> > +                   sizeof(psinfo->pr_fname) - 1);
>
> Read the comment above :)

GCC can't read the comment though. The only other option I can think
of is using a pragma, which I avoided using unless I had to. Would you
prefer a pragma here? Or do you have a better solution?

>
> >
> >      g_free(base_filename);
> >      bswap_psinfo(psinfo);
> > @@ -3389,7 +3389,7 @@ static int fill_note_info(struct elf_note_info *i=
nfo,
> >                sizeof (*info->prstatus), info->prstatus);
> >      fill_psinfo(info->psinfo, ts);
> >      fill_note(&info->notes[1], "CORE", NT_PRPSINFO,
> > -              sizeof (*info->psinfo), info->psinfo);
> > +              sizeof(*info->psinfo) - 1, info->psinfo);
>
> Why?

Same issue as above.

Alistair

>
> >      fill_auxv_note(&info->notes[2], ts);
> >      info->numnote =3D 3;
> >
> >
>
> Thanks,
> Laurent
