Received: from eggs.gnu.org ([209.51.188.92]:54569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1goLlq-0002Zd-Ix
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 00:17:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1goLed-00061l-Nk
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 00:09:48 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:37159)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1goLed-00060w-7v
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 00:09:47 -0500
Received: by mail-pf1-x441.google.com with SMTP id y126so9120488pfb.4
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 21:09:47 -0800 (PST)
References: <20190107183946.7230-1-clg@kaod.org>
	<20190107183946.7230-9-clg@kaod.org>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <c916f6f3-7f5b-fa87-3343-f65cfc1da29e@ozlabs.ru>
Date: Tue, 29 Jan 2019 16:09:40 +1100
MIME-Version: 1.0
In-Reply-To: <20190107183946.7230-9-clg@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 08/13] spapr/rtas: modify
 spapr_rtas_register() to remove RTAS handlers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org



On 08/01/2019 05:39, Cédric Le Goater wrote:
> Removing RTAS handlers will become necessary when the new pseries
> machine supporting multiple interrupt mode is introduced.
> 
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>  include/hw/ppc/spapr.h | 4 ++++
>  hw/ppc/spapr_rtas.c    | 2 +-
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 9e01a5a12e4a..9a6d015b9cf5 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -657,6 +657,10 @@ typedef void (*spapr_rtas_fn)(PowerPCCPU *cpu, sPAPRMachineState *sm,
>                                uint32_t nargs, target_ulong args,
>                                uint32_t nret, target_ulong rets);
>  void spapr_rtas_register(int token, const char *name, spapr_rtas_fn fn);
> +static inline void spapr_rtas_unregister(int token)
> +{
> +    spapr_rtas_register(token, NULL, NULL);
> +}

The new helper is not used anywhere.


>  target_ulong spapr_rtas_call(PowerPCCPU *cpu, sPAPRMachineState *sm,
>                               uint32_t token, uint32_t nargs, target_ulong args,
>                               uint32_t nret, target_ulong rets);
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index d6a0952154ac..e005d5d08151 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -404,7 +404,7 @@ void spapr_rtas_register(int token, const char *name, spapr_rtas_fn fn)
>  
>      token -= RTAS_TOKEN_BASE;
>  
> -    assert(!rtas_table[token].name);
> +    assert(!name || !rtas_table[token].name);


but allowing name==NULL is.


>  
>      rtas_table[token].name = name;
>      rtas_table[token].fn = fn;
> 

-- 
Alexey
