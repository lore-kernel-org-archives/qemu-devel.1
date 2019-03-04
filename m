Received: from eggs.gnu.org ([209.51.188.92]:37354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.weiyang@gmail.com>) id 1h0v1k-0000o4-99
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 16:21:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.weiyang@gmail.com>) id 1h0v1i-0004aT-FU
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 16:21:36 -0500
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:40699)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.weiyang@gmail.com>)
	id 1h0v1g-0004Ry-Dm
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 16:21:34 -0500
Received: by mail-ed1-x544.google.com with SMTP id 10so5440584eds.7
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 13:21:30 -0800 (PST)
Date: Mon, 4 Mar 2019 21:21:27 +0000
From: Wei Yang <richard.weiyang@gmail.com>
Message-ID: <20190304212127.kp4vhxyw3hgmidw7@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20190304065102.26447-1-richardw.yang@linux.intel.com>
	<a50bcc5d-a2ae-3431-23dd-3051892ca3ba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a50bcc5d-a2ae-3431-23dd-3051892ca3ba@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] exec.c: remove an unnecessary condition in
 flatview_add_to_dispatch()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Wei Yang <richardw.yang@linux.intel.com>, qemu-devel@nongnu.org, rth@twiddle.net

On Mon, Mar 04, 2019 at 10:55:39AM +0100, Paolo Bonzini wrote:
>On 04/03/19 07:51, Wei Yang wrote:
>> flatview_add_to_dispatch() registers page based on the condition of
>> *section*, which may looks like this:
>> 
>>     |s|PPPPPPP|s|
>> 
>> where s stands for subpage and P for page.
>> 
>> The procedure of this function could be described as:
>> 
>>     - register first subpage
>>     - register page
>>     - register last subpage
>> 
>> This means only the first offset_within_address_space could be not
>> TARGET_PAGE_SIZE aligned. During the wile loop, this will not happen.
>> 
>> This patch just removes the unnecessary condition and adds some comment
>> to clarify it.
>> 
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>
>Good point!
>
>Here's another way to write it without a while loop at all:
>

Yes, you are right. We can do this without loop.

>diff --git a/exec.c b/exec.c
>index cb09c531a7..e85e3d9fb8 100644
>--- a/exec.c
>+++ b/exec.c
>@@ -1601,33 +1601,37 @@ static void register_multipage(FlatView *fv,
> 
> void flatview_add_to_dispatch(FlatView *fv, MemoryRegionSection *section)
> {
>-    MemoryRegionSection now = *section, remain = *section;
>+    MemoryRegionSection remain = *section;
>     Int128 page_size = int128_make64(TARGET_PAGE_SIZE);
> 
>     if (now.offset_within_address_space & ~TARGET_PAGE_MASK) {
>+        MemoryRegionSection now = remain;
>         uint64_t left = TARGET_PAGE_ALIGN(now.offset_within_address_space)
>                        - now.offset_within_address_space;
> 
>         now.size = int128_min(int128_make64(left), now.size);
>         register_subpage(fv, &now);
>-    } else {
>-        now.size = int128_zero();
>-    }
>-    while (int128_ne(remain.size, now.size)) {
>+        if (int128_eq(remain.size, now.size)) {
>+            return;
>+        }
>         remain.size = int128_sub(remain.size, now.size);
>         remain.offset_within_address_space += int128_get64(now.size);
>         remain.offset_within_region += int128_get64(now.size);
>-        now = remain;
>-        if (int128_lt(remain.size, page_size)) {
>-            register_subpage(fv, &now);
>-        } else if (remain.offset_within_address_space & ~TARGET_PAGE_MASK) {
>-            now.size = page_size;
>-            register_subpage(fv, &now);
>-        } else {
>-            now.size = int128_and(now.size, int128_neg(page_size));
>-            register_multipage(fv, &now);
>+    }
>+
>+    if (int128_ge(remain.size, page_size)) {
>+        MemoryRegionSection now = remain;
>+        now.size = int128_and(now.size, int128_neg(page_size));
>+        register_multipage(fv, &now);
>+        if (int128_eq(remain.size, now.size)) {
>+            return;
>         }
>+        remain.size = int128_sub(remain.size, now.size);
>+        remain.offset_within_address_space += int128_get64(now.size);
>+        remain.offset_within_region += int128_get64(now.size);
>     }
>+
>+    register_subpage(fv, &remain);
> }
> 
> void qemu_flush_coalesced_mmio_buffer(void)
>
>There are a handful of duplicated lines, but overall I think it's
>even clearer.
>
>Paolo
>
>> ---
>>  exec.c | 19 ++++++++++++++++---
>>  1 file changed, 16 insertions(+), 3 deletions(-)
>> 
>> diff --git a/exec.c b/exec.c
>> index 518064530b..e6221d52ba 100644
>> --- a/exec.c
>> +++ b/exec.c
>> @@ -1599,12 +1599,26 @@ static void register_multipage(FlatView *fv,
>>      phys_page_set(d, start_addr >> TARGET_PAGE_BITS, num_pages, section_index);
>>  }
>>  
>> +/*
>> + * The range in *section* may look like this:
>> + *
>> + *      |s|PPPPPPP|s|
>> + *
>> + * where s stands for subpage and P for page.
>> + *
>> + * The procedure in following function could be described as:
>> + *
>> + * - register first subpage
>> + * - register page
>> + * - register last subpage
>> + */
>>  void flatview_add_to_dispatch(FlatView *fv, MemoryRegionSection *section)
>>  {
>>      MemoryRegionSection now = *section, remain = *section;
>>      Int128 page_size = int128_make64(TARGET_PAGE_SIZE);
>>  
>>      if (now.offset_within_address_space & ~TARGET_PAGE_MASK) {
>> +        /* register first subpage */
>>          uint64_t left = TARGET_PAGE_ALIGN(now.offset_within_address_space)
>>                         - now.offset_within_address_space;
>>  
>> @@ -1619,11 +1633,10 @@ void flatview_add_to_dispatch(FlatView *fv, MemoryRegionSection *section)
>>          remain.offset_within_region += int128_get64(now.size);
>>          now = remain;
>>          if (int128_lt(remain.size, page_size)) {
>> -            register_subpage(fv, &now);
>> -        } else if (remain.offset_within_address_space & ~TARGET_PAGE_MASK) {
>> -            now.size = page_size;
>> +            /* register last subpage */
>>              register_subpage(fv, &now);
>>          } else {
>> +            /* register page */
>>              now.size = int128_and(now.size, int128_neg(page_size));
>>              register_multipage(fv, &now);
>>          }
>> 
>

You want me to send v2 with this version? or you would do it by
yourself?

-- 
Wei Yang
Help you, Help me
