Received: from eggs.gnu.org ([209.51.188.92]:39205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h3WCU-0001VD-9q
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 21:27:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h3W7n-0004D1-4Z
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 21:22:35 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:46738)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1h3W7m-0004CK-QV
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 21:22:35 -0400
Received: by mail-pg1-x541.google.com with SMTP id a22so464188pgg.13
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 18:22:34 -0700 (PDT)
References: <20190311191602.25796-1-svens@stackframe.org>
	<20190311191602.25796-9-svens@stackframe.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8d051305-e26d-115c-e518-819a0835da74@linaro.org>
Date: Mon, 11 Mar 2019 18:22:30 -0700
MIME-Version: 1.0
In-Reply-To: <20190311191602.25796-9-svens@stackframe.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 08/11] target/hppa: allow multiple itlbp
 without itlba
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sven Schnelle <svens@stackframe.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

On 3/11/19 12:15 PM, Sven Schnelle wrote:
> The ODE software calls itlbp on existing TLB entries without
> calling itlba first, so this seems to be valid.
> 
> Signed-off-by: Sven Schnelle <svens@stackframe.org>
> ---
>  target/hppa/mem_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
> index 26da953185..fc1b6a4fcd 100644
> --- a/target/hppa/mem_helper.c
> +++ b/target/hppa/mem_helper.c
> @@ -277,7 +277,7 @@ void HELPER(itlbp)(CPUHPPAState *env, target_ulong addr, target_ureg reg)
>  {
>      hppa_tlb_entry *ent = hppa_find_tlb(env, addr);
>  
> -    if (unlikely(ent == NULL || ent->entry_valid)) {
> +    if (unlikely(ent == NULL)) {
>          qemu_log_mask(LOG_GUEST_ERROR, "ITLBP not following ITLBA\n");
>          return;
>      }
> 

Hmm.  Do you have a broader context for this?  Like maybe the software has just
flushed the entire TLB?  If the entry is valid, and we're not relaxing
permissions, then we might need to flush the softtlb page as well.


r~
