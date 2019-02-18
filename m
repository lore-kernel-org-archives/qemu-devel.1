Received: from eggs.gnu.org ([209.51.188.92]:53214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gvqgu-0007Vb-Gt
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 16:43:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gvqgt-00061d-PS
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 16:43:08 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40630)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gvqgt-00060y-Il
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 16:43:07 -0500
Received: by mail-wm1-f68.google.com with SMTP id t15so510007wmi.5
	for <qemu-devel@nongnu.org>; Mon, 18 Feb 2019 13:43:07 -0800 (PST)
References: <1550503897-31141-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1550503897-31141-2-git-send-email-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9e3cf8fe-1225-5c4b-0679-db99f5471333@redhat.com>
Date: Mon, 18 Feb 2019 22:43:05 +0100
MIME-Version: 1.0
In-Reply-To: <1550503897-31141-2-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/7] hw/misc: mips_itu: Fix 32/64 bit issue
 in a line involving shift operator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: arikalo@wavecomp.com, peter.maydell@linaro.org, amarkovic@wavecomp.com, aurelien@aurel32.net

On 2/18/19 4:31 PM, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> Fix 32/64 bit issue in a line involving shift operator. "1 << ..."
> calculation of size is done as a 32-bit signed integer which may
> then be unintentionally sign-extended into the 64-bit result. The
> problem was discovered by Coverity (CID 1398648). Using "1ULL"
> instead of "1" on the LHS of the shift fixes this problem.
> 
> Reproted-by: Peter Maydell <peter.maydell@linaro.org>

Reported-by

> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/misc/mips_itu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/misc/mips_itu.c b/hw/misc/mips_itu.c
> index 1257d8f..3afdbe6 100644
> --- a/hw/misc/mips_itu.c
> +++ b/hw/misc/mips_itu.c
> @@ -94,7 +94,7 @@ void itc_reconfigure(MIPSITUState *tag)
>  
>      if (tag->saar_present) {
>          address = ((*(uint64_t *) tag->saar) & 0xFFFFFFFFE000ULL) << 4;
> -        size = 1 << ((*(uint64_t *) tag->saar >> 1) & 0x1f);
> +        size = 1ULL << ((*(uint64_t *) tag->saar >> 1) & 0x1f);
>          is_enabled = *(uint64_t *) tag->saar & 1;
>      }
>  
> 
