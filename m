Received: from eggs.gnu.org ([209.51.188.92]:47566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1h1u6R-00014f-U8
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:34:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1h1u6R-000526-6B
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:34:31 -0500
References: <20190307121539.12842-1-david@redhat.com>
	<20190307121539.12842-28-david@redhat.com>
	<6caab30c-42bb-1eae-4f6b-577505764b8f@linaro.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <6a7f0375-ad6b-7bdc-c1c2-0ba1588b0d7c@redhat.com>
Date: Thu, 7 Mar 2019 15:34:27 +0100
MIME-Version: 1.0
In-Reply-To: <6caab30c-42bb-1eae-4f6b-577505764b8f@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 27/32] s390x/tcg: Provide
 probe_write_access helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>

On 07.03.19 15:10, Richard Henderson wrote:
> On 3/7/19 4:15 AM, David Hildenbrand wrote:
>> +void probe_write_access(CPUS390XState *env, uint64_t addr, uint64_t len,
>> +                        uintptr_t ra)
>> +{
>> +#ifdef CONFIG_USER_ONLY
>> +    if (!h2g_valid(addr) || !h2g_valid(addr + len - 1)) {
>> +        s390_program_interrupt(env, PGM_ADDRESSING, ILEN_AUTO, ra);
>> +    }
> 
> You need
> 
>   || page_check_range(addr, len, PAGE_WRITE) < 0
> 
> as well.

Indeed, thanks.

So it should be


+void probe_write_access(CPUS390XState *env, uint64_t addr, uint64_t len,
+                        uintptr_t ra)
+{
+#ifdef CONFIG_USER_ONLY
+    if (!h2g_valid(addr) || !h2g_valid(addr + len - 1) ||
+        page_check_range(addr, len, PAGE_WRITE) < 0) {
+        s390_program_interrupt(env, PGM_ADDRESSING, ILEN_AUTO, ra);
+    }
+#else
+    /* test the actual access, not just any access to the page due to LAP */
+    while (len) {
+        const uint64_t pagelen = -(addr | -TARGET_PAGE_MASK);
+        const uint64_t curlen = MIN(pagelen, len);
+
+        probe_write(env, addr, curlen, cpu_mmu_index(env, false), ra);
+        addr = wrap_address(env, addr + curlen);
+        len -= curlen;
+    }
+#endif
+}

Conny, I can resend if you don't feel like fixing up (or there is more to do).

-- 

Thanks,

David / dhildenb
