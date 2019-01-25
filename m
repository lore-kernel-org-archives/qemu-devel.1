Received: from eggs.gnu.org ([209.51.188.92]:59563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gmpcF-0007s8-GV
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 19:45:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gmpbw-000503-Eg
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 19:44:46 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:40149)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1gmpbs-0004qo-Jf
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 19:44:42 -0500
Received: by mail-pf1-x443.google.com with SMTP id i12so3864007pfo.7
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 16:44:39 -0800 (PST)
References: <20190124124906.16653-1-laurent@vivier.eu>
	<20190124124906.16653-4-laurent@vivier.eu>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <f0694cd3-9d9d-8c40-d11f-022fc3b5c147@ozlabs.ru>
Date: Fri, 25 Jan 2019 11:44:30 +1100
MIME-Version: 1.0
In-Reply-To: <20190124124906.16653-4-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PULL 3/5] ppc: e6500 registers SPR 604
 twice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>, qemu-ppc@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Jon Diekema <jon.diekema@ge.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, David Gibson <david@gibson.dropbear.id.au>



On 24/01/2019 23:49, Laurent Vivier wrote:
> From: Jon Diekema <jon.diekema@ge.com>
> 
> When using the e6500 CPU, QEMU generates a fatal error after
> complaining about registering SPR 604 twice.
> 
> Building and testing with commit
> 9b2e891ec5ccdb4a7d583b77988848282606fdea shows the issue:
> 
> qemu-system-ppc64 --version
> QEMU emulator version 3.1.50 (v3.1.0-456-g9b2e891ec5-dirty)
> Copyright (c) 2003-2018 Fabrice Bellard and the QEMU Project developers
> 
> qemu-system-ppc64 -M none -cpu e6500
> Error: Trying to register SPR 604 (25c) twice !
> 
> Signed-off-by: Jon Diekema <jon.diekema@ge.com>
> Message-Id: <CALvuzg43uSodseEHjNaRcPFBKKPTY2mcppUbYgiLL=QO9RxX_Q@mail.gmail.com>
> [removed duplicated mail header in the commit message]
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  target/ppc/translate_init.inc.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
> index ade06cc773..59e0b86762 100644
> --- a/target/ppc/translate_init.inc.c
> +++ b/target/ppc/translate_init.inc.c
> @@ -4947,14 +4947,6 @@ static void init_proc_e500(CPUPPCState *env, int version)
>      }
>  
>      if (version == fsl_e6500) {
> -        spr_register(env, SPR_BOOKE_SPRG8, "SPRG8",
> -                     SPR_NOACCESS, SPR_NOACCESS,
> -                     &spr_read_generic, &spr_write_generic,
> -                     0x00000000);
> -        spr_register(env, SPR_BOOKE_SPRG9, "SPRG9",
> -                     SPR_NOACCESS, SPR_NOACCESS,
> -                     &spr_read_generic, &spr_write_generic,
> -                     0x00000000);


Out of curiosity - does every BookE board have these?


>          /* Thread identification */
>          spr_register(env, SPR_TIR, "TIR",
>                       SPR_NOACCESS, SPR_NOACCESS,
> 

-- 
Alexey
