Received: from eggs.gnu.org ([2001:4830:134:3::10]:38246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1faxAo-0004rg-8w
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 01:51:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1faxAl-0007Q1-61
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 01:51:22 -0400
Received: from mail.ispras.ru ([83.149.199.45]:58368)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1faxAk-0007HQ-OO
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 01:51:19 -0400
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20180614193147.29680-15-richard.henderson@linaro.org>
	<000601d40f7a$4be320b0$e3a96210$@ru>
	<20180629184832.GB14726@flamenco>
	<000901d411c8$d3bfc9c0$7b3f5d40$@ru>
	<20180702195234.GB20840@flamenco>
	<000601d41290$205c56a0$611503e0$@ru>
	<20180704193808.GA32390@flamenco>
In-Reply-To: <20180704193808.GA32390@flamenco>
Date: Thu, 5 Jul 2018 08:51:20 +0300
Message-ID: <000001d41424$32d36540$987a2fc0$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: ru
Subject: Re: [Qemu-devel] [PULL,
 14/18] translate-all: discard TB when tb_link_page returns an
 existing matching TB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "'Emilio G. Cota'" <cota@braap.org>
Cc: 'Richard Henderson' <richard.henderson@linaro.org>, qemu-devel@nongnu.org, peter.maydell@linaro.org

> From: Emilio G. Cota [mailto:cota@braap.org]
> On Tue, Jul 03, 2018 at 08:38:52 +0300, Pavel Dovgalyuk wrote:
> > > From: Emilio G. Cota [mailto:cota@braap.org]
> > > On Mon, Jul 02, 2018 at 08:52:14 +0300, Pavel Dovgalyuk wrote:
> > > > The same failure can be reproduced with linux-0.2.img, which was
> > > > downloaded from QEMU site.
> > > > I can't find it now, but I can upload this file if needed.
> > >
> > > Please upload it somewhere and share the full QEMU invocation
> > > needed to replicate.
> >
> > https://github.com/Dovgalyuk/qemu-images/blob/master/linux-0.2.img
> >
> > qemu-system-i386 -drive file=images/linux-0.2.img,if=none,snapshot,id=img -drive
> > driver=blkreplay,if=none,id=rr,image=img -device ide-hd,drive=rr -net none -icount
> > shift=5,rr=record,rrfile=linux02.rr
> 
> The appended patch fixes it for me. Can you please test on your
> windows image?
> 
> The rationale is to honour CF_NOCACHE, so that we always return
> a new TB from tb_gen_code.

Works for me, thank you.

Tested-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

Pavel Dovgalyuk

> 
> ---
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index 170b957..49d77fa 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -1446,7 +1446,8 @@ static void do_tb_phys_invalidate(TranslationBlock *tb, bool
> rm_from_page_list)
>      phys_pc = tb->page_addr[0] + (tb->pc & ~TARGET_PAGE_MASK);
>      h = tb_hash_func(phys_pc, tb->pc, tb->flags, tb_cflags(tb) & CF_HASH_MASK,
>                       tb->trace_vcpu_dstate);
> -    if (!qht_remove(&tb_ctx.htable, tb, h)) {
> +    if (!(tb->cflags & CF_NOCACHE) &&
> +        !qht_remove(&tb_ctx.htable, tb, h)) {
>          return;
>      }
> 
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
