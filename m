Received: from eggs.gnu.org ([209.51.188.92]:41303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hEvMK-00013U-Ka
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:32:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hEvMI-00086l-N0
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:32:44 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:49093)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hEvMI-00086M-Br
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:32:42 -0400
References: <20190412121626.19829-1-berrange@redhat.com>
	<20190412121626.19829-3-berrange@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <9a7df5b1-72e1-ac35-7f06-a0652db163b1@vivier.eu>
Date: Fri, 12 Apr 2019 14:32:28 +0200
MIME-Version: 1.0
In-Reply-To: <20190412121626.19829-3-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 2/5] linux-user: avoid string truncation
 warnings in elf field copying
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Gerd Hoffmann <kraxel@redhat.com>

On 12/04/2019 14:16, Daniel P. Berrangé wrote:
> In file included from /usr/include/string.h:494,
>                  from include/qemu/osdep.h:101,
>                  from linux-user/elfload.c:2:
> In function ‘strncpy’,
>     inlined from ‘fill_psinfo’ at linux-user/elfload.c:3208:12,
>     inlined from ‘fill_note_info’ at linux-user/elfload.c:3390:5,
>     inlined from ‘elf_core_dump’ at linux-user/elfload.c:3539:9:
> /usr/include/bits/string_fortified.h:106:10: warning: ‘__builtin_strncpy’ specified bound 16 equals destination size [-Wstringop-truncation]
>   106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos (__dest));
>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> We don't require the field to be NUL terminated, so can just
> copy the lower of the string length and the target field size
> using memcpy.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  linux-user/elfload.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index c1a26021f8..caa060f7b7 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -3180,6 +3180,7 @@ static int fill_psinfo(struct target_elf_prpsinfo *psinfo, const TaskState *ts)
>  {
>      char *base_filename;
>      unsigned int i, len;
> +    size_t pathlen;
>  
>      (void) memset(psinfo, 0, sizeof (*psinfo));
>  
> @@ -3201,12 +3202,9 @@ static int fill_psinfo(struct target_elf_prpsinfo *psinfo, const TaskState *ts)
>      psinfo->pr_gid = getgid();
>  
>      base_filename = g_path_get_basename(ts->bprm->filename);
> -    /*
> -     * Using strncpy here is fine: at max-length,
> -     * this field is not NUL-terminated.
> -     */

Keep and update the comment, it explains why we don't need to add the
NUL at the end when MIN() is sizeof(psinfo->pr_fname).

> -    (void) strncpy(psinfo->pr_fname, base_filename,
> -                   sizeof(psinfo->pr_fname));
> +    pathlen = strlen(base_filename) + 1;
> +    pathlen = MIN(pathlen, sizeof(psinfo->pr_fname));
> +    memcpy(psinfo->pr_fname, base_filename, pathlen);
>  
>      g_free(base_filename);
>      bswap_psinfo(psinfo);
> 

Thanks,
Laurent
