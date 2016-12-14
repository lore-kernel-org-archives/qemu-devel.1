Received: from eggs.gnu.org ([2001:4830:134:3::10]:56552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cHCpo-0004Mg-V6
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 11:55:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cHCpj-0004BD-3t
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 11:55:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38890)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cHCpi-0004Ac-UZ
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 11:55:11 -0500
References: <1481732391-882-1-git-send-email-vlad.lungu@windriver.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ef1f3b2a-d206-7082-3227-423e0d9d9619@redhat.com>
Date: Wed, 14 Dec 2016 17:55:07 +0100
MIME-Version: 1.0
In-Reply-To: <1481732391-882-1-git-send-email-vlad.lungu@windriver.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] multiboot: copy the cmdline verbatim
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vlad Lungu <vlad.lungu@windriver.com>, qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, rth@twiddle.net



On 14/12/2016 17:19, Vlad Lungu wrote:
> get_opt_value() truncates the value at the first comma.
> Use memcpy() instead.

Looks good since get_opt_value is already used by the caller.  Have you
tested this with multiple initrd modules too?

Paolo

> Signed-off-by: Vlad Lungu <vlad.lungu@windriver.com>
> ---
>  hw/i386/multiboot.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/i386/multiboot.c b/hw/i386/multiboot.c
> index 387caa6..b4495ad 100644
> --- a/hw/i386/multiboot.c
> +++ b/hw/i386/multiboot.c
> @@ -109,7 +109,7 @@ static uint32_t mb_add_cmdline(MultibootState *s, const char *cmdline)
>      hwaddr p = s->offset_cmdlines;
>      char *b = (char *)s->mb_buf + p;
>  
> -    get_opt_value(b, strlen(cmdline) + 1, cmdline);
> +    memcpy(b, cmdline, strlen(cmdline) + 1);
>      s->offset_cmdlines += strlen(b) + 1;
>      return s->mb_buf_phys + p;
>  }
> 
