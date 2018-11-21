Received: from eggs.gnu.org ([2001:4830:134:3::10]:52236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gPWg7-0005vZ-4j
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 12:52:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gPWg6-0004Ko-CK
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 12:52:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:18730)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gPWg6-0004J8-4c
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 12:52:42 -0500
References: <1541051971-28584-1-git-send-email-liq3ea@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ac213dd7-9204-9414-599a-4ef8fd2fbcb4@redhat.com>
Date: Wed, 21 Nov 2018 18:52:33 +0100
MIME-Version: 1.0
In-Reply-To: <1541051971-28584-1-git-send-email-liq3ea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] vl: Improve error message when we can't
 load fw_cfg from file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>, armbru@redhat.com, philmd@redhat.com
Cc: qemu-devel@nongnu.org

On 01/11/18 06:59, Li Qiang wrote:
> parse_fw_cfg() reports "can't load" without further details.  Get
> the details from g_file_get_contents(), and include them in the
> error message.
> 
> Signed-off-by: Li Qiang <liq3ea@gmail.com>
> ---
>  vl.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/vl.c b/vl.c
> index 1fcacc5..f0bd899 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -2244,8 +2244,10 @@ static int parse_fw_cfg(void *opaque, QemuOpts *opts, Error **errp)
>          size = strlen(str); /* NUL terminator NOT included in fw_cfg blob */
>          buf = g_memdup(str, size);
>      } else {
> -        if (!g_file_get_contents(file, &buf, &size, NULL)) {
> -            error_setg(errp, "can't load %s", file);
> +        GError *err = NULL;
> +        if (!g_file_get_contents(file, &buf, &size, &err)) {
> +            error_setg(errp, "can't load %s: %s", file, err->message);
> +            g_error_free(err);
>              return -1;
>          }
>      }
> 

Queued, thanks.

Paolo
