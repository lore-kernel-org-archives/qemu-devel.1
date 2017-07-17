Received: from eggs.gnu.org ([2001:4830:134:3::10]:60724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1dXAxR-0007uI-O1
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 14:41:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1dXAxN-0003L0-GB
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 14:41:25 -0400
References: <20170717151207.24919-1-mreitz@redhat.com>
From: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Message-ID: <c8ff1dc0-e1a1-73eb-a5d1-11ed50eff148@reactos.org>
Date: Mon, 17 Jul 2017 20:40:15 +0200
MIME-Version: 1.0
In-Reply-To: <20170717151207.24919-1-mreitz@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] block/vvfat: Fix compiler warning with gcc
 7
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>

Le 17/07/2017 à 17:12, Max Reitz a écrit :
> gcc 7 complains that the sprintf() might write a null byte beyond the
> end of the tail buffer.  That is wrong, but we can silence it by making
> i unsigned (it can never be negative anyway, see the if condition right
> before).  For some reason, this allows gcc to suddenly accurately
> calculate the range of i so we can give the tail[] array the exact size
> it needs to have (which is 8 bytes) without gcc complaining.
>
> In addition, let us convert the sprintf() to snprintf(), because that is
> always nicer, and add an assertion about the range of the return value
> afterwards so we can see that "8 - len" will never be negative and thus
> "entry->name + MIN(j, 8 - len)" will never be out of bounds.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/vvfat.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/block/vvfat.c b/block/vvfat.c
> index 6b11596..a9e207f 100644
> --- a/block/vvfat.c
> +++ b/block/vvfat.c
> @@ -549,7 +549,7 @@ static direntry_t *create_short_filename(BDRVVVFATState *s,
>      const gchar *p, *last_dot = NULL;
>      gunichar c;
>      bool lossy_conversion = false;
> -    char tail[11];
> +    char tail[8];
>
>      if (!entry) {
>          return NULL;
> @@ -614,7 +614,8 @@ static direntry_t *create_short_filename(BDRVVVFATState *s,
>      for (i = lossy_conversion ? 1 : 0; i < 999999; i++) {
>          direntry_t *entry1;
>          if (i > 0) {
> -            int len = sprintf(tail, "~%d", i);
> +            int len = snprintf(tail, sizeof(tail), "~%u", (unsigned)i);
> +            assert(len <= 7);

As i is on minimum between 0 or 1 and on maximum equal at 999999, does it work if you change the type of i from int to unsigned int?
That way, you probably won't need the cast to unsigned in the s(n)printf.

>              memcpy(entry->name + MIN(j, 8 - len), tail, len);
>          }
>          for (entry1 = array_get(&(s->directory), directory_start);
>
