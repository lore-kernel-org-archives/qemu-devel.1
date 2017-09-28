Received: from eggs.gnu.org ([2001:4830:134:3::10]:59366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dxQmg-0001Uo-Ag
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 00:50:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dxQmc-0003Fa-DZ
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 00:50:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49464)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dxQmc-0003FQ-7K
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 00:50:46 -0400
References: <20170927170027.8539-1-david@redhat.com>
	<20170927170027.8539-3-david@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <466fa6a0-ac91-66aa-aabb-a15a8ac62e0f@redhat.com>
Date: Thu, 28 Sep 2017 06:50:39 +0200
MIME-Version: 1.0
In-Reply-To: <20170927170027.8539-3-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC 2/3] s390x/tcg: low-address protection
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: cohuck@redhat.com, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <richard.henderson@linaro.org>

On 27.09.2017 19:00, David Hildenbrand wrote:
> This is a neat way to implement low address protection, whereby
> only the first 512 bytes of the first two pages (each 4096 bytes) of
> every address space are protected.
> 
> Store a tec of 0 for the access exception, this is what is defined by
> Enhanced Suppression on Protection in case of a low address protection
> (Bit 61 set to 0, rest undefined).
> 
> We have to make sure to to pass the access address, not the masked page
> address into mmu_translate*().
> 
> Drop the check from testblock. So we can properly test this via
> kvm-unit-tests.
> 
> This will check every access going through one of the MMUs.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/excp_helper.c |  3 +-
>  target/s390x/mem_helper.c  |  8 ----
>  target/s390x/mmu_helper.c  | 96 +++++++++++++++++++++++++++++-----------------
>  3 files changed, 62 insertions(+), 45 deletions(-)
[...]
> diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
> index 9daa0fd8e2..44a15449d2 100644
> --- a/target/s390x/mmu_helper.c
> +++ b/target/s390x/mmu_helper.c
> @@ -106,6 +106,37 @@ static void trigger_page_fault(CPUS390XState *env, target_ulong vaddr,
>      trigger_access_exception(env, type, ilen, tec);
>  }
>  
> +/* check whether the address would be proteted by Low-Address Protection */
> +static bool is_low_address(uint64_t addr)
> +{
> +    return addr < 512 || (addr >= 4096 && addr < 4607);
> +}

I like the check from the kernel sources better:

static inline int is_low_address(unsigned long ga)
{
    /* Check for address ranges 0..511 and 4096..4607 */
    return (ga & ~0x11fful) == 0;
}

... that might result in slightly faster code (depending on the
compiler, of course).

 Thomas
