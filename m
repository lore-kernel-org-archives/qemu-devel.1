Received: from eggs.gnu.org ([2001:4830:134:3::10]:43421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dQr8v-0002ZK-Ho
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 04:19:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dQr8r-0000iH-Fi
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 04:19:09 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:34392)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dQr8r-0000gT-Ba
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 04:19:05 -0400
Received: by mail-qt0-x243.google.com with SMTP id m54so11685406qtb.1
	for <qemu-devel@nongnu.org>; Fri, 30 Jun 2017 01:19:03 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1498768109-4092-1-git-send-email-cota@braap.org>
	<1498768109-4092-7-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <736ed9fa-219f-64e0-70ba-9e5ef1b63b14@twiddle.net>
Date: Fri, 30 Jun 2017 01:18:58 -0700
MIME-Version: 1.0
In-Reply-To: <1498768109-4092-7-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 6/7] [XXX] tcg: make TCGContext thread-local
 for softmmu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org

On 06/29/2017 01:28 PM, Emilio G. Cota wrote:
> This will allow us to generate TCG code in parallel.
> 
> User-mode is kept out of this: contention due to concurrent translation
> is more commonly found in full-system mode (e.g. booting a many-core guest).
> 
> XXX: For now, only convert arm/a64, since these are the only guests that
> have proper MTTCG support.

Not true.  TCG_GUEST_DEFAULT_MO suggests we have 4.

> XXX: This is calling prologue_init once per vCPU, i.e. each TCGContext
>       gets a different prologue/epilogue (all of them with the same
>       contents though). Far from ideal, but for an experiment it
>       "should" work, right?

Um... sure.  But surely there's a better way.  Perhaps copying the main 
thread's tcg_ctx?  That'd be after prologue, and target globals are created. 
That would avoid the need to make all the target cpu_* globals be thread-local, 
for instance.

Of course, now that I think of it, this implies that my tcg patches to use 
pointers instead of indicies is not the Way Forward...

>   /* Share the TCG temporaries common between 32 and 64 bit modes.  */
> -extern TCGv_env cpu_env;
> -extern TCGv_i32 cpu_NF, cpu_ZF, cpu_CF, cpu_VF;
> -extern TCGv_i64 cpu_exclusive_addr;
> -extern TCGv_i64 cpu_exclusive_val;
> +extern TCG_THREAD TCGv_env cpu_env;
> +extern TCG_THREAD TCGv_i32 cpu_NF, cpu_ZF, cpu_CF, cpu_VF;
> +extern TCG_THREAD TCGv_i64 cpu_exclusive_addr;
> +extern TCG_THREAD TCGv_i64 cpu_exclusive_val;

It would be Really Good if we could avoid this in the end.
I see that it's the quickest way to test for now though.

> @@ -887,7 +893,7 @@ typedef struct TCGOpDef {
>   #endif
>   } TCGOpDef;
>   
> -extern TCGOpDef tcg_op_defs[];
> +extern TCG_THREAD TCGOpDef tcg_op_defs[];

Why?  It's constant after startup.


r~
