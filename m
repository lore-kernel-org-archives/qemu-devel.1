Received: from eggs.gnu.org ([2001:4830:134:3::10]:48082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXEv1-0003be-UE
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 18:55:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXEuy-0003WA-Sp
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 18:55:12 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:35253)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXEuy-0003Vs-O4
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 18:55:08 -0400
Received: by mail-qk0-x241.google.com with SMTP id z22so508355qka.2
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 15:55:08 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1500235468-15341-1-git-send-email-cota@braap.org>
	<1500235468-15341-11-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <92056605-c95b-b19b-0216-5d83be64e13d@twiddle.net>
Date: Mon, 17 Jul 2017 12:55:03 -1000
MIME-Version: 1.0
In-Reply-To: <1500235468-15341-11-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 10/45] translate-all: guarantee that
 tb_hash only holds valid TBs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org

On 07/16/2017 10:03 AM, Emilio G. Cota wrote:
> @@ -1073,13 +1073,17 @@ void tb_phys_invalidate(TranslationBlock *tb, tb_page_addr_t page_addr)
>   
>       assert_tb_locked();
>   
> -    atomic_set(&tb->invalid, true);
> -
>       /* remove the TB from the hash list */
>       phys_pc = tb->page_addr[0] + (tb->pc & ~TARGET_PAGE_MASK);
>       h = tb_hash_func(phys_pc, tb->pc, tb->flags, tb->trace_vcpu_dstate);
>       qht_remove(&tcg_ctx.tb_ctx.htable, tb, h);
>   
> +    /*
> +     * Mark the TB as invalid *after* it's been removed from tb_hash, which
> +     * eliminates the need to check this bit on lookups.
> +     */
> +    tb->invalid = true;

I believe you need atomic_store_release here.  Previously we were relying on 
the lock acquisition in qht_remove to provide the required memory barrier.

We definitely need to make sure this reaches memory before we zap the TB in the 
CPU_FOREACH loop.


r~
