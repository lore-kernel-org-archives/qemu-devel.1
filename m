Received: from eggs.gnu.org ([2001:4830:134:3::10]:49764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cHAhS-0001sv-V0
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 09:38:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cHAhO-0000qz-Gm
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 09:38:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46582)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cHAhO-0000qe-B0
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 09:38:26 -0500
Date: Wed, 14 Dec 2016 12:38:23 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20161214143823.GH3808@thinpad.lan.raisama.net>
References: <8d6ae82b-a3f8-7fce-de47-d338242d25f0@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d6ae82b-a3f8-7fce-de47-d338242d25f0@windriver.com>
Subject: Re: [Qemu-devel] [PATCH] multiboot: copy the cmdline verbatim
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vlad Lungu <vlad.lungu@windriver.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net

On Wed, Dec 14, 2016 at 03:35:29PM +0200, Vlad Lungu wrote:
> 
> get_opt_value() truncates the value at the first comma
> Use memcpy() instead
> 
> Signed-off-by: Vlad Lungu <vlad.lungu@windriver.com>

Your patch is corrupted. I suggest using git-send-email instead
of Thunderbird, but you might want to take a look at:
http://kb.mozillazine.org/Plain_text_e-mail_-_Thunderbird#Completely_plain_email

> ---
>  hw/i386/multiboot.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/i386/multiboot.c b/hw/i386/multiboot.c
> index 387caa6..b4495ad 100644
> --- a/hw/i386/multiboot.c
> +++ b/hw/i386/multiboot.c
> @@ -109,7 +109,7 @@ static uint32_t mb_add_cmdline(MultibootState *s, const
> char *cmdline)
>      hwaddr p = s->offset_cmdlines;
>      char *b = (char *)s->mb_buf + p;
> 
> -    get_opt_value(b, strlen(cmdline) + 1, cmdline);

One caller of mb_add_cmdline() relies on get_opt_value() to allow
multiple initrd modules to be specified on the command-line. But:
* The caller already splits the string manually by adding a null
  terminator;
* The caller is already broken if filenames contain "," (because
  it doesn't handle ",," escaping)
so it won't be affected by the change, and it would need to
handle escaping before calling mb_add_cmdline() anyway.

The other caller of mb_add_cmdline() (kcmdline) doesn't need
option splitting/parsing.

So, not using get_opt_value() here makes sense.

But:

> +    memcpy(b, cmdline, strlen(cmdline) + 1);

This is equivalent to strcpy(), and it is ignoring the size of
mb_buf.

The existing code looks very dangerous: the size of mb_buf is
calculated based on the image contents, and then it doesn't check
the buffer size before writing to it.

>      s->offset_cmdlines += strlen(b) + 1;
>      return s->mb_buf_phys + p;
>  }
> -- 
> 1.9.1
> 
> 

-- 
Eduardo
