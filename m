Received: from eggs.gnu.org ([209.51.188.92]:51213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gzmMk-0005ol-Oy
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 12:54:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gzmMj-0000Xx-RV
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 12:54:34 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:40357)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gzmMj-0000Wl-6O
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 12:54:33 -0500
Received: by mail-pl1-x644.google.com with SMTP id bj4so11817868plb.7
	for <qemu-devel@nongnu.org>; Fri, 01 Mar 2019 09:54:33 -0800 (PST)
References: <20190301115413.27153-1-david@redhat.com>
	<20190301115413.27153-28-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <bccdbc0a-1dd9-5675-557a-15e69058ef9d@linaro.org>
Date: Fri, 1 Mar 2019 09:54:27 -0800
MIME-Version: 1.0
In-Reply-To: <20190301115413.27153-28-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 27/32] s390x/tcg: Provide probe_write
 helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>

On 3/1/19 3:54 AM, David Hildenbrand wrote:
> Instead of checking e.g. the first access on every touched page, we should
> check the actual access, otherwise we might get false positives when Low
> Address Protection (LAP) is active. As probe_write() can only deal with
> accesses to one page, we have to loop.
> 
> Use i64 for the length, although not needed - easier to reuse
> TCG temps we already have in the translation functions where this will
> be used. Also allow it to be used from other helpers.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/helper.h     |  1 +
>  target/s390x/internal.h   |  2 ++
>  target/s390x/mem_helper.c | 21 +++++++++++++++++++++
>  3 files changed, 24 insertions(+)
> 
> diff --git a/target/s390x/helper.h b/target/s390x/helper.h
> index 577edb384f..e2710f4fb3 100644
> --- a/target/s390x/helper.h
> +++ b/target/s390x/helper.h
> @@ -123,6 +123,7 @@ DEF_HELPER_4(cu42, i32, env, i32, i32, i32)
>  DEF_HELPER_5(msa, i32, env, i32, i32, i32, i32)
>  DEF_HELPER_FLAGS_1(stpt, TCG_CALL_NO_RWG, i64, env)
>  DEF_HELPER_FLAGS_1(stck, TCG_CALL_NO_RWG_SE, i64, env)
> +DEF_HELPER_FLAGS_3(probe_write_access, TCG_CALL_NO_WG, void, env, i64, i64)
>  
>  /* === Vector Support Instructions === */
>  DEF_HELPER_FLAGS_4(vll, TCG_CALL_NO_WG, void, env, ptr, i64, i64)
> diff --git a/target/s390x/internal.h b/target/s390x/internal.h
> index 7baf0e2404..848d6c36d0 100644
> --- a/target/s390x/internal.h
> +++ b/target/s390x/internal.h
> @@ -386,6 +386,8 @@ void ioinst_handle_sal(S390CPU *cpu, uint64_t reg1, uintptr_t ra);
>  
>  /* mem_helper.c */
>  target_ulong mmu_real2abs(CPUS390XState *env, target_ulong raddr);
> +void probe_write_access(CPUS390XState *env, uint64_t addr, uint64_t len,
> +                        uintptr_t ra);
>  
>  
>  /* mmu_helper.c */
> diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
> index a506d9ef99..efd5256ebf 100644
> --- a/target/s390x/mem_helper.c
> +++ b/target/s390x/mem_helper.c
> @@ -2623,3 +2623,24 @@ uint32_t HELPER(cu42)(CPUS390XState *env, uint32_t r1, uint32_t r2, uint32_t m3)
>      return convert_unicode(env, r1, r2, m3, GETPC(),
>                             decode_utf32, encode_utf16);
>  }
> +
> +void probe_write_access(CPUS390XState *env, uint64_t addr, uint64_t len,
> +                        uintptr_t ra)
> +{
> +#ifndef CONFIG_USER_ONLY
> +    /* test the actual access, not just any access to the page due to LAP */
> +    while (len) {
> +        uint64_t curlen = MIN(TARGET_PAGE_SIZE - (addr % TARGET_PAGE_SIZE),
> +                              len);

pagelen = -(addr | TARGET_PAGE_MASK);
curlen = MIN(pagelen, len);

> +
> +        probe_write(env, addr, curlen, cpu_mmu_index(env, false), ra);
> +        addr = wrap_address(env, addr + curlen);
> +        len -= curlen;
> +    }
> +#endif

That's annoying.  I thought we defined probe_write for user-only as well.

The user-only version would look something like

  uint64_t end = addr + len - 1;

  if (!h2g_valid(addr) ||
      !h2g_valid(end) ||
      page_check_range(addr, len, PAGE_WRITE) < 0) {
    // raise PGM_ADDRESSING
  }

Ah, I see why -- there's no user-only equivalent of tlb_fill with which to
produce the exception in the failure case.


r~
