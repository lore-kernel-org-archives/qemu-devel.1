Received: from eggs.gnu.org ([2001:4830:134:3::10]:45180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dPbY6-0001cY-Qg
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 17:27:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dPbY4-0002Zq-2m
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 17:27:58 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:35581)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dPbY3-0002Yu-QK
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 17:27:55 -0400
Received: by mail-qt0-x243.google.com with SMTP id w12so1719836qta.2
	for <qemu-devel@nongnu.org>; Mon, 26 Jun 2017 14:27:55 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1497486973-25845-1-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <0b5a4803-350b-b6e1-62a5-dfc500d03df3@twiddle.net>
Date: Mon, 26 Jun 2017 14:27:51 -0700
MIME-Version: 1.0
In-Reply-To: <1497486973-25845-1-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tcg: consistently access cpu->tb_jmp_cache
 atomically
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

On 06/14/2017 05:36 PM, Emilio G. Cota wrote:
> Some code paths can lead to atomic accesses racing with memset()
> on cpu->tb_jmp_cache, which can result in torn reads/writes
> and is undefined behaviour in C11.
> 
> These torn accesses are unlikely to show up as bugs, but from code
> inspection they seem possible. For example, tb_phys_invalidate does:
>      /* remove the TB from the hash list */
>      h = tb_jmp_cache_hash_func(tb->pc);
>      CPU_FOREACH(cpu) {
>          if (atomic_read(&cpu->tb_jmp_cache[h]) == tb) {
>              atomic_set(&cpu->tb_jmp_cache[h], NULL);
>          }
>      }
> Here atomic_set might race with a concurrent memset (such as the
> ones scheduled via "unsafe" async work, e.g. tlb_flush_page) and
> therefore we might end up with a torn pointer (or who knows what,
> because we are under undefined behaviour).
> 
> This patch converts parallel accesses to cpu->tb_jmp_cache to use
> atomic primitives, thereby bringing these accesses back to defined
> behaviour. The price to pay is to potentially execute more instructions
> when clearing cpu->tb_jmp_cache, but given how infrequently they happen
> and the small size of the cache, the performance impact I have measured
> is within noise range when booting debian-arm.
> 
> Note that under "safe async" work (e.g. do_tb_flush) we could use memset
> because no other vcpus are running. However I'm keeping these accesses
> atomic as well to keep things simple and to avoid confusing analysis
> tools such as ThreadSanitizer.
> 
> Signed-off-by: Emilio G. Cota<cota@braap.org>
> ---
>   cputlb.c          |  4 ++--
>   include/qom/cpu.h | 11 ++++++++++-
>   qom/cpu.c         |  5 +----
>   translate-all.c   | 25 ++++++++++++-------------
>   4 files changed, 25 insertions(+), 20 deletions(-)

Applied, thanks.


r~
