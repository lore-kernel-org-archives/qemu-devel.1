Received: from eggs.gnu.org ([2001:4830:134:3::10]:42684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fXV1F-0001H5-MY
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 13:11:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fXV1E-0003wV-KV
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 13:11:13 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:44269)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fXV1E-0003w8-Fz
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 13:11:12 -0400
Received: by mail-qt0-x244.google.com with SMTP id 92-v6so8152806qta.11
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 10:11:12 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1529944302-14186-1-git-send-email-cota@braap.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6c728743-f2e6-7640-923a-005361c6b6c1@amsat.org>
Date: Mon, 25 Jun 2018 14:11:07 -0300
MIME-Version: 1.0
In-Reply-To: <1529944302-14186-1-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] translate-all: fix locking of TBs whose
 two pages share the same physical page
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, Max Filippov <jcmvbkbc@gmail.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>

On 06/25/2018 01:31 PM, Emilio G. Cota wrote:
> Commit 0b5c91f ("translate-all: use per-page locking in !user-mode",
> 2018-06-15) introduced per-page locking. It assumed that the physical
> pages corresponding to a TB (at most two pages) are always distinct,
> which is wrong. For instance, an xtensa test provided by Max Filippov
> is broken by the commit, since the test maps two virtual pages
> to the same physical page:
> 
> 	virt1: 7fff, virt2: 8000
> 	phys1 6000fff, phys2 6000000
> 
> Fix it by removing the assumption from page_lock_pair.
> If the two physical page addresses are equal, we only lock
> the PageDesc once. Note that the two callers of page_lock_pair,
> namely page_unlock_tb and tb_link_page, are also updated so that
> we do not try to unlock the same PageDesc twice.
> 
> Fixes: 0b5c91f74f3c83a36f37740969df8c775c997e69
> Reported-by: Max Filippov <jcmvbkbc@gmail.com>
> Signed-off-by: Emilio G. Cota <cota@braap.org>

$ make check-tcg (qemu:debian-xtensa-cross)

Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  accel/tcg/translate-all.c | 32 +++++++++++++++++++++++++-------
>  1 file changed, 25 insertions(+), 7 deletions(-)
> 
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index f0c3fd4..8e0203e 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -669,9 +669,15 @@ static inline void page_lock_tb(const TranslationBlock *tb)
>  
>  static inline void page_unlock_tb(const TranslationBlock *tb)
>  {
> -    page_unlock(page_find(tb->page_addr[0] >> TARGET_PAGE_BITS));
> +    PageDesc *p1 = page_find(tb->page_addr[0] >> TARGET_PAGE_BITS);
> +
> +    page_unlock(p1);
>      if (unlikely(tb->page_addr[1] != -1)) {
> -        page_unlock(page_find(tb->page_addr[1] >> TARGET_PAGE_BITS));
> +        PageDesc *p2 = page_find(tb->page_addr[1] >> TARGET_PAGE_BITS);
> +
> +        if (p2 != p1) {
> +            page_unlock(p2);
> +        }
>      }
>  }
>  
> @@ -850,22 +856,34 @@ static void page_lock_pair(PageDesc **ret_p1, tb_page_addr_t phys1,
>                             PageDesc **ret_p2, tb_page_addr_t phys2, int alloc)
>  {
>      PageDesc *p1, *p2;
> +    tb_page_addr_t page1;
> +    tb_page_addr_t page2;
>  
>      assert_memory_lock();
> -    g_assert(phys1 != -1 && phys1 != phys2);
> -    p1 = page_find_alloc(phys1 >> TARGET_PAGE_BITS, alloc);
> +    g_assert(phys1 != -1);
> +
> +    page1 = phys1 >> TARGET_PAGE_BITS;
> +    page2 = phys2 >> TARGET_PAGE_BITS;
> +
> +    p1 = page_find_alloc(page1, alloc);
>      if (ret_p1) {
>          *ret_p1 = p1;
>      }
>      if (likely(phys2 == -1)) {
>          page_lock(p1);
>          return;
> +    } else if (page1 == page2) {
> +        page_lock(p1);
> +        if (ret_p2) {
> +            *ret_p2 = p1;
> +        }
> +        return;
>      }
> -    p2 = page_find_alloc(phys2 >> TARGET_PAGE_BITS, alloc);
> +    p2 = page_find_alloc(page2, alloc);
>      if (ret_p2) {
>          *ret_p2 = p2;
>      }
> -    if (phys1 < phys2) {
> +    if (page1 < page2) {
>          page_lock(p1);
>          page_lock(p2);
>      } else {
> @@ -1623,7 +1641,7 @@ tb_link_page(TranslationBlock *tb, tb_page_addr_t phys_pc,
>          tb = existing_tb;
>      }
>  
> -    if (p2) {
> +    if (p2 && p2 != p) {
>          page_unlock(p2);
>      }
>      page_unlock(p);
> 
