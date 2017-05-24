Received: from eggs.gnu.org ([2001:4830:134:3::10]:45642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dDNjY-0007bb-4k
	for qemu-devel@nongnu.org; Wed, 24 May 2017 00:17:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dDNjX-0006p0-24
	for qemu-devel@nongnu.org; Wed, 24 May 2017 00:17:16 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170522211205.14265-1-hpoussin@reactos.org>
	<20170522211205.14265-10-hpoussin@reactos.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1de94c5a-7361-d799-07bf-c2cdc5403935@amsat.org>
Date: Wed, 24 May 2017 01:17:05 -0300
MIME-Version: 1.0
In-Reply-To: <20170522211205.14265-10-hpoussin@reactos.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 09/13] vvfat: correctly create base
 short names for non-ASCII filenames
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Hi Hervé,

On 05/22/2017 06:12 PM, Hervé Poussineau wrote:
> More specifically, create short name from filename and change blacklist of
> invalid chars to whitelist of valid chars.
>
> Windows 9x also now correctly see long file names of filenames containing a space,
> but Scandisk still complains about mismatch between SFN and LFN.
>
> Specification: "FAT: General overview of on-disk format" v1.03, pages 30-31
> Signed-off-by: Hervé Poussineau <hpoussin@reactos.org>
> ---
>  block/vvfat.c | 105 ++++++++++++++++++++++++++++++++++++++++++----------------
>  1 file changed, 77 insertions(+), 28 deletions(-)
>
> diff --git a/block/vvfat.c b/block/vvfat.c
> index d34241da17..3cb65493cd 100644
> --- a/block/vvfat.c
> +++ b/block/vvfat.c
> @@ -516,6 +516,81 @@ static void set_begin_of_direntry(direntry_t* direntry, uint32_t begin)
>      direntry->begin_hi = cpu_to_le16((begin >> 16) & 0xffff);
>  }
>
> +static uint8_t to_valid_short_char(gunichar c)
> +{
> +    c = g_unichar_toupper(c);
> +    if ((c >= '0' && c <= '9') ||
> +        (c >= 'A' && c <= 'Z') ||
> +        strchr("$%'-_@~`!(){}^#&", c) != 0) {
> +        return c;
> +    } else {
> +        return 0;
> +    }
> +}
> +
> +static direntry_t *create_short_filename(BDRVVVFATState *s,
> +                                         const char *filename)
> +{
> +    int i, j = 0;
> +    direntry_t *entry = array_get_next(&(s->directory));
> +    const gchar *p, *last_dot = NULL;
> +    gunichar c;
> +    bool lossy_conversion = false;

What is the purpose of this variable? Do you plan to use it later or it 
is just for debugging?

> +    char tail[11];

This also looks like old debug code...

> +
> +    if (!entry) {
> +        return NULL;
> +    }
> +    memset(entry->name, 0x20, sizeof(entry->name));
> +
> +    /* copy filename and search last dot */
> +    for (p = filename; ; p = g_utf8_next_char(p)) {
> +        c = g_utf8_get_char(p);
> +        if (c == '\0') {
> +            break;
> +        } else if (c == '.') {
> +            if (j == 0) {
> +                /* '.' at start of filename */
> +                lossy_conversion = true;
> +            } else {
> +                if (last_dot) {
> +                    lossy_conversion = true;
> +                }
> +                last_dot = p;
> +            }
> +        } else if (!last_dot) {
> +            /* first part of the name; copy it */
> +            uint8_t v = to_valid_short_char(c);
> +            if (j < 8 && v) {
> +                entry->name[j++] = v;
> +            } else {
> +                lossy_conversion = true;
> +            }
> +        }
> +    }
> +
> +    /* copy extension (if any) */
> +    if (last_dot) {
> +        j = 0;
> +        for (p = g_utf8_next_char(last_dot); ; p = g_utf8_next_char(p)) {
> +            c = g_utf8_get_char(p);
> +            if (c == '\0') {
> +                break;
> +            } else {
> +                /* extension; copy it */
> +                uint8_t v = to_valid_short_char(c);
> +                if (j < 3 && v) {
> +                    entry->name[8 + (j++)] = v;
> +                } else {
> +                    lossy_conversion = true;
> +                }
> +            }
> +        }
> +    }
> +    (void)lossy_conversion;
> +    return entry;
> +}
> +
>  /* fat functions */
>
>  static inline uint8_t fat_chksum(const direntry_t* entry)
> @@ -614,7 +689,7 @@ static inline void init_fat(BDRVVVFATState* s)
>  static inline direntry_t* create_short_and_long_name(BDRVVVFATState* s,
>          unsigned int directory_start, const char* filename, int is_dot)
>  {
> -    int i,j,long_index=s->directory.next;
> +    int long_index = s->directory.next;
>      direntry_t* entry = NULL;
>      direntry_t* entry_long = NULL;
>
> @@ -626,33 +701,7 @@ static inline direntry_t* create_short_and_long_name(BDRVVVFATState* s,
>      }
>
>      entry_long=create_long_filename(s,filename);
> -
> -    i = strlen(filename);
> -    for(j = i - 1; j>0  && filename[j]!='.';j--);
> -    if (j > 0)
> -        i = (j > 8 ? 8 : j);
> -    else if (i > 8)
> -        i = 8;
> -
> -    entry=array_get_next(&(s->directory));
> -    memset(entry->name, 0x20, sizeof(entry->name));
> -    memcpy(entry->name, filename, i);
> -
> -    if (j > 0) {
> -        for (i = 0; i < 3 && filename[j + 1 + i]; i++) {
> -            entry->name[8 + i] = filename[j + 1 + i];
> -        }
> -    }
> -
> -    /* upcase & remove unwanted characters */
> -    for(i=10;i>=0;i--) {
> -        if(i==10 || i==7) for(;i>0 && entry->name[i]==' ';i--);
> -        if(entry->name[i]<=' ' || entry->name[i]>0x7f
> -                || strchr(".*?<>|\":/\\[];,+='",entry->name[i]))
> -            entry->name[i]='_';
> -        else if(entry->name[i]>='a' && entry->name[i]<='z')
> -            entry->name[i]+='A'-'a';
> -    }
> +    entry = create_short_filename(s, filename);
>
>      /* mangle duplicates */
>      while(1) {
>
