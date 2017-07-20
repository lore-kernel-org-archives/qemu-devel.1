Received: from eggs.gnu.org ([2001:4830:134:3::10]:53860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dYIto-0006p7-GU
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 17:22:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dYItk-0002z9-B7
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 17:22:20 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:36281)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dYItk-0002yr-5t
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 17:22:16 -0400
Received: by mail-qt0-x241.google.com with SMTP id l55so4851783qtl.3
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 14:22:16 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1500520169-23367-1-git-send-email-cota@braap.org>
	<1500520169-23367-43-git-send-email-cota@braap.org>
	<8f18a24d-01f8-7b57-33ef-f89939acd3c6@twiddle.net>
	<20170720205041.GA8754@flamenco>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <b1ab270d-2812-a11b-a6c7-fda0b8d0b42e@twiddle.net>
Date: Thu, 20 Jul 2017 11:22:10 -1000
MIME-Version: 1.0
In-Reply-To: <20170720205041.GA8754@flamenco>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 42/43] tcg: introduce regions to split
 code_gen_buffer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org

On 07/20/2017 10:50 AM, Emilio G. Cota wrote:
> On Wed, Jul 19, 2017 at 22:04:50 -1000, Richard Henderson wrote:
>> On 07/19/2017 05:09 PM, Emilio G. Cota wrote:
>>> +    /* We do not yet support multiple TCG contexts, so use one region for now */
>>> +    n_regions = 1;
>>> +
>>> +    /* start on a page-aligned address */
>>> +    buf = QEMU_ALIGN_PTR_UP(buf, qemu_real_host_page_size);
>>> +    g_assert(buf < tcg_init_ctx.code_gen_buffer + size);
>>> +
>>> +    /* discard that initial portion */
>>> +    size -= buf - tcg_init_ctx.code_gen_buffer;
>>
>> It seems pointless wasting most of a page after the prologue when n_regions
>> == 1.  We don't really need to start on a page boundary in that case.
>>
>>> +    /* make region_size a multiple of page_size */
>>> +    region_size = size / n_regions;
>>> +    region_size = QEMU_ALIGN_DOWN(region_size, qemu_real_host_page_size);
>>
>> This division can result in a number of pages at the end of the region being
>> unused.  Is it worthwhile freeing them?  Or marking them mprotect_none along
>> with the last guard page?
> 
> Perhaps we should then enlarge both the first and last regions so that we
> fully use the buffer.

I really like the idea.  That's a lot of space recovered for 64k page hosts.

I do think we can make the computation clearer.  How about


>   static void tcg_region_assign(TCGContext *s, size_t curr_region)
>   {
> +    void *aligned = QEMU_ALIGN_PTR_UP(region.start, qemu_real_host_page_size);
>       void *buf;
> +    size_t size = region.size;
>   
> -    buf = region.buf + curr_region * (region.size + qemu_real_host_page_size);
> +    /* The beginning of the first region might not be page-aligned */
> +    if (curr_region == 0) {
> +        buf = region.start;
> +        size += aligned - buf;
> +    } else {
> +        buf = aligned + curr_region * (region.size +  qemu_real_host_page_size);
> +    }
> +    /* the last region might be larger than region.size */
> +    if (curr_region == region.n - 1) {
> +        void *aligned_end = buf + size;
> +
> +        size += region.end - qemu_real_host_page_size - aligned_end;
> +    }
>       s->code_gen_buffer = buf;
>       s->code_gen_ptr = buf;
> -    s->code_gen_buffer_size = region.size;
> -    s->code_gen_highwater = buf + region.size - TCG_HIGHWATER;
> +    s->code_gen_buffer_size = size;
> +    s->code_gen_highwater = buf + size - TCG_HIGHWATER;
>   }

static inline void tcg_region_bounds(TCGContext *s, size_t curr_region,
                                      void **pstart, void **pend)
{
   void *start, *end;

   /* ??? Maybe store "aligned" precomputed.  */
   start = QEMU_ALIGN_PTR_UP(region.start, qemu_real_host_page_size);
   /* ??? Maybe store "stride" precomputed.  */
   start += curr_region * (region.size + qemu_real_host_page_size);
   end = start + region.size;

   if (curr_region == 0) {
     start = region.start;
   }
   if (curr_region == region.n - 1) {
     end = region.end;
   }

   *pstart = start;
   *pend = end;
}

static void tcg_region_assign(TCGContext *s, size_t curr_region)
{
   void *start, *end;

   tcg_region_bounds(s, curr_region, &start, &end);

   s->code_gen_buffer = start;
   s->code_gen_ptr = start;
   s->code_gen_buffer_size = end - start;
   s->code_gen_highwater = end - TCG_HIGHWATER;
}

> @@ -409,44 +424,50 @@ static size_t tcg_n_regions(void)
>   void tcg_region_init(void)
>   {
>       void *buf = tcg_init_ctx.code_gen_buffer;
> +    void *aligned;
>       size_t size = tcg_init_ctx.code_gen_buffer_size;
> +    size_t page_size = qemu_real_host_page_size;
>       size_t region_size;
>       size_t n_regions;
>       size_t i;
> +    int rc;
>   
>       n_regions = tcg_n_regions();
>   
> -    /* start on a page-aligned address */
> -    buf = QEMU_ALIGN_PTR_UP(buf, qemu_real_host_page_size);
> -    g_assert(buf < tcg_init_ctx.code_gen_buffer + size);
> -
> -    /* discard that initial portion */
> -    size -= buf - tcg_init_ctx.code_gen_buffer;
> -
> -    /* make region_size a multiple of page_size */
> -    region_size = size / n_regions;
> -    region_size = QEMU_ALIGN_DOWN(region_size, qemu_real_host_page_size);
> +    /* The first region will be 'aligned - buf' bytes larger than the others */
> +    aligned = QEMU_ALIGN_PTR_UP(buf, page_size);
> +    g_assert(aligned < tcg_init_ctx.code_gen_buffer + size);
> +    /*
> +     * Make region_size a multiple of page_size, using aligned as the start.
> +     * As a result of this we might end up with a few extra pages at the end of
> +     * the buffer; we will assign those to the last region.
> +     */
> +    region_size = (size - (aligned - buf)) / n_regions;
> +    region_size = QEMU_ALIGN_DOWN(region_size, page_size);
>   
>       /* A region must have at least 2 pages; one code, one guard */
> -    g_assert(region_size >= 2 * qemu_real_host_page_size);
> +    g_assert(region_size >= 2 * page_size);
>   
>       /* init the region struct */
>       qemu_mutex_init(&region.lock);
>       region.n = n_regions;
> -    region.buf = buf;
> +    region.start = buf;
> +    /* page-align the end, since its last page will be a guard page */
> +    region.end = QEMU_ALIGN_PTR_DOWN(buf + size, page_size);
>       /* do not count the guard page in region.size */
> -    region.size = region_size - qemu_real_host_page_size;
> +    region.size = region_size - page_size;
>   
> -    /* set guard pages */
> -    for (i = 0; i < region.n; i++) {
> +    /* set guard pages for the first n-1 regions */
> +    for (i = 0; i < region.n - 1; i++) {
>           void *guard;
> -        int rc;
>   
> -        guard = region.buf + region.size;
> -        guard += i * (region.size + qemu_real_host_page_size);
> -        rc = qemu_mprotect_none(guard, qemu_real_host_page_size);
> +        guard = aligned + region.size + i * (region.size + page_size);
> +        rc = qemu_mprotect_none(guard, page_size);
>           g_assert(!rc);
>       }
> +    /* the last region gets the rest of the buffer */
> +    rc = qemu_mprotect_none(region.end - page_size, page_size);
> +    g_assert(!rc);

   for (i = region.n; i-- > 0; ) {
     void *start, *end;
     tcg_region_bounds(s, i, &start, &end);
     rc = qemu_mprotect_none(end, page_size);
     g_assert(rc == 0);
   }



r~
