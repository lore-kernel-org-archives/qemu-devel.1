Received: from eggs.gnu.org ([2001:4830:134:3::10]:60851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1de4Br-00078E-NW
	for qemu-devel@nongnu.org; Sat, 05 Aug 2017 14:52:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1de4Bq-0005Ux-F9
	for qemu-devel@nongnu.org; Sat, 05 Aug 2017 14:52:47 -0400
MIME-Version: 1.0
In-Reply-To: <20170522211205.14265-11-hpoussin@reactos.org>
References: <20170522211205.14265-1-hpoussin@reactos.org>
	<20170522211205.14265-11-hpoussin@reactos.org>
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Sat, 5 Aug 2017 14:52:13 -0400
Message-ID: <CAJhHMCAZjtSZ9bVP8ARuex=kEUox=ed__LdEe39a6-gY7oKggQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 10/13] vvfat: correctly generate
 numeric-tail of short file names
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, "open list:Block I/O path" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

FYI,

This commit breaks the build with gcc-7:

  CC      block/vvfat.o
qemu/block/vvfat.c: In function =E2=80=98read_directory=E2=80=99:
qemu/block/vvfat.c:605:37: error: =E2=80=98__builtin___sprintf_chk=E2=80=99=
 may write
a terminating nul past the end of the destination
[-Werror=3Dformat-overflow=3D]
             int len =3D sprintf(tail, "~%d", i);
                                     ^~~~~
In file included from /usr/include/stdio.h:938:0,
                 from qemu/include/qemu/osdep.h:68,
                 from qemu/block/vvfat.c:25:
/usr/include/x86_64-linux-gnu/bits/stdio2.h:33:10: note:
=E2=80=98__builtin___sprintf_chk=E2=80=99 output between 3 and 12 bytes int=
o a
destination of size 11
   return __builtin___sprintf_chk (__s, __USE_FORTIFY_LEVEL - 1,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
       __bos (__s), __fmt, __va_arg_pack ());
       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
qemu/rules.mak:66: recipe for target 'block/vvfat.o' failed
make: *** [block/vvfat.o] Error 1


Thanks,

On Mon, May 22, 2017 at 5:12 PM, Herv=C3=A9 Poussineau <hpoussin@reactos.or=
g> wrote:
> More specifically:
> - try without numeric-tail only if LFN didn't have invalid short chars
> - start at ~1 (instead of ~0)
> - handle case if numeric tail is more than one char (ie > 10)
>
> Windows 9x Scandisk doesn't see anymore mismatches between short file nam=
es and
> long file names for non-ASCII filenames.
>
> Specification: "FAT: General overview of on-disk format" v1.03, page 31
> Signed-off-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
> ---
>  block/vvfat.c | 62 ++++++++++++++++++++++++++++-------------------------=
------
>  1 file changed, 29 insertions(+), 33 deletions(-)
>
> diff --git a/block/vvfat.c b/block/vvfat.c
> index 3cb65493cd..414bca6dee 100644
> --- a/block/vvfat.c
> +++ b/block/vvfat.c
> @@ -529,7 +529,8 @@ static uint8_t to_valid_short_char(gunichar c)
>  }
>
>  static direntry_t *create_short_filename(BDRVVVFATState *s,
> -                                         const char *filename)
> +                                         const char *filename,
> +                                         unsigned int directory_start)
>  {
>      int i, j =3D 0;
>      direntry_t *entry =3D array_get_next(&(s->directory));
> @@ -587,8 +588,32 @@ static direntry_t *create_short_filename(BDRVVVFATSt=
ate *s,
>              }
>          }
>      }
> -    (void)lossy_conversion;
> -    return entry;
> +
> +    /* numeric-tail generation */
> +    for (j =3D 0; j < 8; j++) {
> +        if (entry->name[j] =3D=3D ' ') {
> +            break;
> +        }
> +    }
> +    for (i =3D lossy_conversion ? 1 : 0; i < 999999; i++) {
> +        direntry_t *entry1;
> +        if (i > 0) {
> +            int len =3D sprintf(tail, "~%d", i);
> +            memcpy(entry->name + MIN(j, 8 - len), tail, len);
> +        }
> +        for (entry1 =3D array_get(&(s->directory), directory_start);
> +             entry1 < entry; entry1++) {
> +            if (!is_long_name(entry1) &&
> +                !memcmp(entry1->name, entry->name, 11)) {
> +                break; /* found dupe */
> +            }
> +        }
> +        if (entry1 =3D=3D entry) {
> +            /* no dupe found */
> +            return entry;
> +        }
> +    }
> +    return NULL;
>  }
>
>  /* fat functions */
> @@ -701,36 +726,7 @@ static inline direntry_t* create_short_and_long_name=
(BDRVVVFATState* s,
>      }
>
>      entry_long=3Dcreate_long_filename(s,filename);
> -    entry =3D create_short_filename(s, filename);
> -
> -    /* mangle duplicates */
> -    while(1) {
> -        direntry_t* entry1=3Darray_get(&(s->directory),directory_start);
> -        int j;
> -
> -        for(;entry1<entry;entry1++)
> -            if(!is_long_name(entry1) && !memcmp(entry1->name,entry->name=
,11))
> -                break; /* found dupe */
> -        if(entry1=3D=3Dentry) /* no dupe found */
> -            break;
> -
> -        /* use all 8 characters of name */
> -        if(entry->name[7]=3D=3D' ') {
> -            int j;
> -            for(j=3D6;j>0 && entry->name[j]=3D=3D' ';j--)
> -                entry->name[j]=3D'~';
> -        }
> -
> -        /* increment number */
> -        for(j=3D7;j>0 && entry->name[j]=3D=3D'9';j--)
> -            entry->name[j]=3D'0';
> -        if(j>0) {
> -            if(entry->name[j]<'0' || entry->name[j]>'9')
> -                entry->name[j]=3D'0';
> -            else
> -                entry->name[j]++;
> -        }
> -    }
> +    entry =3D create_short_filename(s, filename, directory_start);
>
>      /* calculate checksum; propagate to long name */
>      if(entry_long) {
> --
> 2.11.0
>
>

--=20
Pranith
