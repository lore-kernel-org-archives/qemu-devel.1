Received: from eggs.gnu.org ([209.51.188.92]:35476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gmZaB-0001qW-Ub
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 02:37:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gmZMW-0001Zz-R6
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 02:23:45 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:37805)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1gmZMW-0001Gq-HP
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 02:23:44 -0500
Received: by mail-pf1-x444.google.com with SMTP id y126so2564424pfb.4
	for <qemu-devel@nongnu.org>; Wed, 23 Jan 2019 23:23:39 -0800 (PST)
References: <20190122170112.8706-1-farosas@linux.ibm.com>
	<20190122170112.8706-4-farosas@linux.ibm.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <d102e17e-eab4-ab77-f7ab-311fc04066c2@ozlabs.ru>
Date: Thu, 24 Jan 2019 18:23:33 +1100
MIME-Version: 1.0
In-Reply-To: <20190122170112.8706-4-farosas@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 3/3] target/ppc: Enable reporting of
 SPRs to GDB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fabiano Rosas <farosas@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, groug@kaod.org, david@gibson.dropbear.id.au



On 23/01/2019 04:01, Fabiano Rosas wrote:
> This allows reading and writing of SPRs via GDB:
> 
> (gdb) p/x $srr1
> $1 = 0x8000000002803033
> 
> (gdb) p/x $pvr
> $2 = 0x4b0201
> (gdb) set $pvr=0x4b0000
> (gdb) p/x $pvr
> $3 = 0x4b0000
> 
> They can also be shown as a group:
> (gdb) info reg spr


This does not make much sense as 3 patches, one would do it; otherwise
if there is a problem with 1/3 or 2/3 - bisect will point to 3/3
although it does not actually add new code but enables other bits.


> 
> Signed-off-by: Fabiano Rosas <farosas@linux.ibm.com>
> ---
>  target/ppc/translate_init.inc.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
> index f29ac3558a..cba0303be2 100644
> --- a/target/ppc/translate_init.inc.c
> +++ b/target/ppc/translate_init.inc.c
> @@ -10531,7 +10531,9 @@ static void ppc_cpu_class_init(ObjectClass *oc, void *data)
>  #endif
>  
>      cc->gdb_num_core_regs = 71;
> -
> +#ifndef CONFIG_USER_ONLY
> +    cc->gdb_get_dynamic_xml = ppc_gdb_get_dynamic_xml;
> +#endif
>  #ifdef USE_APPLE_GDB
>      cc->gdb_read_register = ppc_cpu_gdb_read_register_apple;
>      cc->gdb_write_register = ppc_cpu_gdb_write_register_apple;
> 

-- 
Alexey
