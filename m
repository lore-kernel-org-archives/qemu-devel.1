Received: from eggs.gnu.org ([2001:4830:134:3::10]:46232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dDNn1-0000aM-EL
	for qemu-devel@nongnu.org; Wed, 24 May 2017 00:20:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dDNn0-000836-LM
	for qemu-devel@nongnu.org; Wed, 24 May 2017 00:20:51 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170522211205.14265-1-hpoussin@reactos.org>
	<20170522211205.14265-13-hpoussin@reactos.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9c9796c5-1bdf-88e5-04a7-85b0f98095c7@amsat.org>
Date: Wed, 24 May 2017 01:20:42 -0300
MIME-Version: 1.0
In-Reply-To: <20170522211205.14265-13-hpoussin@reactos.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 12/13] vvfat: handle KANJI lead byte 0xe5
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

You explained in the cover "fix problems detected by disk checking 
utilities in read-only mode", do you think it would be doable to have 
unit-tests for those corner cases?

On 05/22/2017 06:12 PM, Hervé Poussineau wrote:
> Specification: "FAT: General overview of on-disk format" v1.03, page 23
> Signed-off-by: Hervé Poussineau <hpoussin@reactos.org>
> ---
>  block/vvfat.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/block/vvfat.c b/block/vvfat.c
> index 5376659010..53e8faa54c 100644
> --- a/block/vvfat.c
> +++ b/block/vvfat.c
> @@ -590,6 +590,10 @@ static direntry_t *create_short_filename(BDRVVVFATState *s,
>          }
>      }
>
> +    if (entry->name[0] == 0xe5) {

This deserves a comment, and a #define would also be welcomed.

> +        entry->name[0] = 0x05;
> +    }
> +
>      /* numeric-tail generation */
>      for (j = 0; j < 8; j++) {
>          if (entry->name[j] == ' ') {
> @@ -710,8 +714,6 @@ static inline void init_fat(BDRVVVFATState* s)
>
>  }
>
> -/* TODO: in create_short_filename, 0xe5->0x05 is not yet handled! */
> -/* TODO: in parse_short_filename, 0x05->0xe5 is not yet handled! */
>  static inline direntry_t* create_short_and_long_name(BDRVVVFATState* s,
>          unsigned int directory_start, const char* filename, int is_dot)
>  {
> @@ -1744,6 +1746,9 @@ static int parse_short_name(BDRVVVFATState* s,
>      } else
>          lfn->name[i + j + 1] = '\0';
>
> +    if (lfn->name[0] == 0x05) {
> +        lfn->name[0] = 0xe5;
> +    }
>      lfn->len = strlen((char*)lfn->name);
>
>      return 0;
>
