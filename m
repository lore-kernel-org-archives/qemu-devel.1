Received: from eggs.gnu.org ([2001:4830:134:3::10]:34940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fcZVV-0001th-Er
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 12:59:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fcZVU-0003C9-8t
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 12:59:25 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:44553)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fcZVU-0003B6-2M
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 12:59:24 -0400
Received: by mail-oi0-x244.google.com with SMTP id s198-v6so37169465oih.11
	for <qemu-devel@nongnu.org>; Mon, 09 Jul 2018 09:59:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1530806837-5416-1-git-send-email-cota@braap.org>
References: <1530806837-5416-1-git-send-email-cota@braap.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Jul 2018 17:59:02 +0100
Message-ID: <CAFEAcA9otSLZzz++GJ1vVLa4k+5c7Xcdj6goSuSJ-dH+7ckwog@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] translate-all: honour CF_NOCACHE in
 tb_gen_code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Pavel Dovgalyuk <dovgaluk@ispras.ru>, Richard Henderson <richard.henderson@linaro.org>

On 5 July 2018 at 17:07, Emilio G. Cota <cota@braap.org> wrote:
> This fixes a record-replay regression introduced by 95590e2
> ("translate-all: discard TB when tb_link_page returns an existing
> matching TB", 2018-06-15). The problem is that code using CF_NOCACHE
> assumes that the TB returned from tb_gen_code is always a
> newly-generated one. This assumption, however, was broken in
> the aforementioned commit.
>
> Fix it by honouring CF_NOCACHE, so that tb_gen_code always
> returns a newly-generated TB when CF_NOCACHE is passed to it.
> Do this by avoiding the TB hash table if CF_NOCACHE is set.
>
> Reported-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> Tested-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> Signed-off-by: Emilio G. Cota <cota@braap.org>

> @@ -1604,8 +1605,6 @@ tb_link_page(TranslationBlock *tb, tb_page_addr_t phys_pc,
>  {
>      PageDesc *p;
>      PageDesc *p2 = NULL;
> -    void *existing_tb = NULL;
> -    uint32_t h;
>
>      assert_memory_lock();
>
> @@ -1625,20 +1624,25 @@ tb_link_page(TranslationBlock *tb, tb_page_addr_t phys_pc,
>          tb->page_addr[1] = -1;
>      }
>
> -    /* add in the hash table */
> -    h = tb_hash_func(phys_pc, tb->pc, tb->flags, tb->cflags & CF_HASH_MASK,
> -                     tb->trace_vcpu_dstate);
> -    qht_insert(&tb_ctx.htable, tb, h, &existing_tb);
> +    if (!(tb->cflags & CF_NOCACHE)) {
> +        void *existing_tb = NULL;
> +        uint32_t h;
>
> -    /* remove TB from the page(s) if we couldn't insert it */
> -    if (unlikely(existing_tb)) {
> -        tb_page_remove(p, tb);
> -        invalidate_page_bitmap(p);
> -        if (p2) {
> -            tb_page_remove(p2, tb);
> -            invalidate_page_bitmap(p2);
> +        /* add in the hash table */
> +        h = tb_hash_func(phys_pc, tb->pc, tb->flags, tb->cflags & CF_HASH_MASK,
> +                         tb->trace_vcpu_dstate);
> +        qht_insert(&tb_ctx.htable, tb, h, &existing_tb);
> +
> +        /* remove TB from the page(s) if we couldn't insert it */
> +        if (unlikely(existing_tb)) {
> +            tb_page_remove(p, tb);
> +            invalidate_page_bitmap(p);
> +            if (p2) {
> +                tb_page_remove(p2, tb);
> +                invalidate_page_bitmap(p2);
> +            }
> +            tb = existing_tb;
>          }
> -        tb = existing_tb;
>      }
>
>      if (p2 && p2 != p) {

Hi -- I've been having a look at getting QEMU to support execution
from MMIO regions by doing a "generate a single-insn CF_NOCACHE TB".
As part of that, rth and I ran into a question about this change:
why does tb_link_page() still add a CF_NOCACHE TB to the page lists?
That is, why does this patch guard the "add to the hash table" part
of the function, rather than just saying "return doing nothing
if CF_NOCACHE"?

I'm pretty clueless about this bit of the code, so I'm quite
probably missing something.

thanks
-- PMM
