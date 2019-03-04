Received: from eggs.gnu.org ([209.51.188.92]:48933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1h0kSW-00034E-M3
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 05:04:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1h0kSQ-000750-VF
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 05:04:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:23638)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1h0kSK-0006rh-8M
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 05:04:20 -0500
References: <20190304065102.26447-1-richardw.yang@linux.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a50bcc5d-a2ae-3431-23dd-3051892ca3ba@redhat.com>
Date: Mon, 4 Mar 2019 10:55:39 +0100
MIME-Version: 1.0
In-Reply-To: <20190304065102.26447-1-richardw.yang@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Wei Yang <richardw.yang@linux.intel.com>, qemu-devel@nongnu.org
Cc: rth@twiddle.net

On 04/03/19 07:51, Wei Yang wrote:
> flatview_add_to_dispatch() registers page based on the condition of
> *section*, which may looks like this:
> 
>     |s|PPPPPPP|s|
> 
> where s stands for subpage and P for page.
> 
> The procedure of this function could be described as:
> 
>     - register first subpage
>     - register page
>     - register last subpage
> 
> This means only the first offset_within_address_space could be not
> TARGET_PAGE_SIZE aligned. During the wile loop, this will not happen.
> 
> This patch just removes the unnecessary condition and adds some comment
> to clarify it.
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>

Good point!

Here's another way to write it without a while loop at all:

diff --git a/exec.c b/exec.c
index cb09c531a7..e85e3d9fb8 100644
--- a/exec.c
+++ b/exec.c
@@ -1601,33 +1601,37 @@ static void register_multipage(FlatView *fv,
 
 void flatview_add_to_dispatch(FlatView *fv, MemoryRegionSection *section)
 {
-    MemoryRegionSection now = *section, remain = *section;
+    MemoryRegionSection remain = *section;
     Int128 page_size = int128_make64(TARGET_PAGE_SIZE);
 
     if (now.offset_within_address_space & ~TARGET_PAGE_MASK) {
+        MemoryRegionSection now = remain;
         uint64_t left = TARGET_PAGE_ALIGN(now.offset_within_address_space)
                        - now.offset_within_address_space;
 
         now.size = int128_min(int128_make64(left), now.size);
         register_subpage(fv, &now);
-    } else {
-        now.size = int128_zero();
-    }
-    while (int128_ne(remain.size, now.size)) {
+        if (int128_eq(remain.size, now.size)) {
+            return;
+        }
         remain.size = int128_sub(remain.size, now.size);
         remain.offset_within_address_space += int128_get64(now.size);
         remain.offset_within_region += int128_get64(now.size);
-        now = remain;
-        if (int128_lt(remain.size, page_size)) {
-            register_subpage(fv, &now);
-        } else if (remain.offset_within_address_space & ~TARGET_PAGE_MASK) {
-            now.size = page_size;
-            register_subpage(fv, &now);
-        } else {
-            now.size = int128_and(now.size, int128_neg(page_size));
-            register_multipage(fv, &now);
+    }
+
+    if (int128_ge(remain.size, page_size)) {
+        MemoryRegionSection now = remain;
+        now.size = int128_and(now.size, int128_neg(page_size));
+        register_multipage(fv, &now);
+        if (int128_eq(remain.size, now.size)) {
+            return;
         }
+        remain.size = int128_sub(remain.size, now.size);
+        remain.offset_within_address_space += int128_get64(now.size);
+        remain.offset_within_region += int128_get64(now.size);
     }
+
+    register_subpage(fv, &remain);
 }
 
 void qemu_flush_coalesced_mmio_buffer(void)

There are a handful of duplicated lines, but overall I think it's
even clearer.

Paolo

> ---
>  exec.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/exec.c b/exec.c
> index 518064530b..e6221d52ba 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -1599,12 +1599,26 @@ static void register_multipage(FlatView *fv,
>      phys_page_set(d, start_addr >> TARGET_PAGE_BITS, num_pages, section_index);
>  }
>  
> +/*
> + * The range in *section* may look like this:
> + *
> + *      |s|PPPPPPP|s|
> + *
> + * where s stands for subpage and P for page.
> + *
> + * The procedure in following function could be described as:
> + *
> + * - register first subpage
> + * - register page
> + * - register last subpage
> + */
>  void flatview_add_to_dispatch(FlatView *fv, MemoryRegionSection *section)
>  {
>      MemoryRegionSection now = *section, remain = *section;
>      Int128 page_size = int128_make64(TARGET_PAGE_SIZE);
>  
>      if (now.offset_within_address_space & ~TARGET_PAGE_MASK) {
> +        /* register first subpage */
>          uint64_t left = TARGET_PAGE_ALIGN(now.offset_within_address_space)
>                         - now.offset_within_address_space;
>  
> @@ -1619,11 +1633,10 @@ void flatview_add_to_dispatch(FlatView *fv, MemoryRegionSection *section)
>          remain.offset_within_region += int128_get64(now.size);
>          now = remain;
>          if (int128_lt(remain.size, page_size)) {
> -            register_subpage(fv, &now);
> -        } else if (remain.offset_within_address_space & ~TARGET_PAGE_MASK) {
> -            now.size = page_size;
> +            /* register last subpage */
>              register_subpage(fv, &now);
>          } else {
> +            /* register page */
>              now.size = int128_and(now.size, int128_neg(page_size));
>              register_multipage(fv, &now);
>          }
> 
