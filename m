Received: from eggs.gnu.org ([2001:4830:134:3::10]:38635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cjank-0000B0-IS
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 19:10:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cjanj-0008QY-E4
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 19:10:28 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1488491046-2549-1-git-send-email-armbru@redhat.com>
	<1488491046-2549-7-git-send-email-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <76a2fbc7-f205-0137-7f1a-7b597e2a483e@amsat.org>
Date: Thu, 2 Mar 2017 21:10:17 -0300
MIME-Version: 1.0
In-Reply-To: <1488491046-2549-7-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 06/15] sheepdog: Don't truncate long VDI
 name in _open(), _create()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mitake.hitoshi@lab.ntt.co.jp, jcody@redhat.com, qemu-block@nongnu.org, namei.unix@gmail.com

On 03/02/2017 06:43 PM, Markus Armbruster wrote:
> sd_parse_uri() truncates long VDI names silently.  Reject them
> instead.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  block/sheepdog.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/block/sheepdog.c b/block/sheepdog.c
> index deb110e..72a52a6 100644
> --- a/block/sheepdog.c
> +++ b/block/sheepdog.c
> @@ -985,7 +985,9 @@ static int sd_parse_uri(BDRVSheepdogState *s, const char *filename,
>          ret = -EINVAL;
>          goto out;
>      }
> -    pstrcpy(vdi, SD_MAX_VDI_LEN, uri->path + 1);
> +    if (g_strlcpy(vdi, uri->path + 1, SD_MAX_VDI_LEN) >= SD_MAX_VDI_LEN) {
> +        goto out;
> +    }
>
>      qp = query_params_parse(uri->query);
>      if (qp->n > 1 || (s->is_unix && !qp->n) || (!s->is_unix && qp->n)) {
>
