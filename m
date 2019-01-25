Received: from eggs.gnu.org ([209.51.188.92]:58558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gnB01-0005QN-Tz
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 18:35:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gnAzw-0006Ts-78
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 18:34:57 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:34961)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gnAzv-0006SI-Sv
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 18:34:56 -0500
Received: by mail-pg1-x544.google.com with SMTP id s198so4825528pgs.2
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 15:34:55 -0800 (PST)
References: <1648289.tQCHxfjYn9@basile.remlab.net>
	<20190125214926.3204-2-remi@remlab.net>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5a4b45fe-0ed1-ba58-c2ff-a8d3ad78e4a8@linaro.org>
Date: Fri, 25 Jan 2019 15:34:51 -0800
MIME-Version: 1.0
In-Reply-To: <20190125214926.3204-2-remi@remlab.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/3] target/arm: actually enable PAuth in
 user mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?R=c3=a9mi_Denis-Courmont?= <remi@remlab.net>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org

On 1/25/19 1:49 PM, Rémi Denis-Courmont wrote:
> From: Remi Denis-Courmont <remi.denis.courmont@huawei.com>
> 
> This always enables IA, IB, DA and DB keys in user mode on the maximum
> CPU, in a manner that is consistent with the other CPUs. That is to say
> redefining the reset value of SCTLR_ELx registers.
> 
> Without this patch, the PAC* and AUT* instructions have no effects
> (except PACGA of course).
> 
> Signed-off-by: Remi Denis-Courmont <remi.denis.courmont@huawei.com>
> ---
>  target/arm/cpu64.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index e9bc461c36..148c103ca4 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -413,8 +413,8 @@ static void aarch64_max_initfn(Object *obj)
>                                  (void *)&apdb_bit, &error_fatal);
>  
>              /* Enable all PAC keys by default.  */
> -            cpu->env.cp15.sctlr_el[1] |= SCTLR_EnIA | SCTLR_EnIB;
> -            cpu->env.cp15.sctlr_el[1] |= SCTLR_EnDA | SCTLR_EnDB;
> +            cpu->reset_sctlr |= SCTLR_EnIA | SCTLR_EnIB;
> +            cpu->reset_sctlr |= SCTLR_EnDA | SCTLR_EnDB;

I just sent another patch for this:
http://lists.nongnu.org/archive/html/qemu-devel/2019-01/msg06737.html

This way is valid as well, but would also need to adjust the property callbacks
to modify reset_sctlr as well.

Peter, do you have a preference?


r~
