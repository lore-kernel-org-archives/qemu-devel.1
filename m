Received: from eggs.gnu.org ([2001:4830:134:3::10]:40359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cq5B7-0003Kp-F0
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 17:49:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cq5B4-0003xG-EV
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 17:49:25 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:35935)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cq5B4-0003wl-9V
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 17:49:22 -0400
Received: by mail-pg0-x241.google.com with SMTP id 81so13969488pgh.3
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 14:49:21 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170320153441.2181-1-alex.bennee@linaro.org>
	<20170320153441.2181-2-alex.bennee@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <0c1e289a-d541-dc30-3e64-e920241ff8ac@twiddle.net>
Date: Tue, 21 Mar 2017 07:49:12 +1000
MIME-Version: 1.0
In-Reply-To: <20170320153441.2181-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 1/3] cputlb: ensure tbl_set_dirty1
 updates addr_write atomically
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, mttcg@greensocs.com, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com, Peter Crosthwaite <crosthwaite.peter@gmail.com>

On 03/21/2017 01:34 AM, Alex Bennée wrote:
> This was an oversight when the rest of cputlb was being updated. As
> before it falls back to the non-atomic version when the host can't
> support wider-than-bus atomics.
>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  cputlb.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/cputlb.c b/cputlb.c
> index f5d056cc08..0d52e45dfd 100644
> --- a/cputlb.c
> +++ b/cputlb.c
> @@ -540,9 +540,17 @@ void tlb_reset_dirty(CPUState *cpu, ram_addr_t start1, ram_addr_t length)
>
>  static inline void tlb_set_dirty1(CPUTLBEntry *tlb_entry, target_ulong vaddr)
>  {
> +#if TCG_OVERSIZED_GUEST
>      if (tlb_entry->addr_write == (vaddr | TLB_NOTDIRTY)) {
>          tlb_entry->addr_write = vaddr;
>      }
> +#else
> +    uintptr_t orig_addr = atomic_mb_read(&tlb_entry->addr_write);
> +
> +    if (orig_addr == (vaddr | TLB_NOTDIRTY)) {
> +        atomic_cmpxchg(&tlb_entry->addr_write, orig_addr, vaddr);
> +    }

What's the state machine here?  How can the per-cpu tlb change in a way other 
than dirty->clean / clean->dirty?  AFAIK, we shouldn't be swapping out the tlb 
entry to somthing completely different.

So how does cmpxchg improve over atomic_write?


r~
