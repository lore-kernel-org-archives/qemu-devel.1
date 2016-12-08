Received: from eggs.gnu.org ([2001:4830:134:3::10]:60581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cF2tW-0005VA-TS
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 12:54:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cF2tT-0004un-50
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 12:54:10 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34331)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cF2tS-0004pj-Ur
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 12:54:07 -0500
Received: by mail-wm0-f68.google.com with SMTP id g23so5061495wme.1
	for <qemu-devel@nongnu.org>; Thu, 08 Dec 2016 09:53:45 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20161206205627.8443-1-bobby.prani@gmail.com>
	<20161206205627.8443-2-bobby.prani@gmail.com>
	<87a8c8yvxh.fsf@linaro.org> <8760mv92bd.fsf@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1b64ff62-171d-c419-e31e-f216df15ffc7@redhat.com>
Date: Thu, 8 Dec 2016 18:52:27 +0100
MIME-Version: 1.0
In-Reply-To: <8760mv92bd.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 1/3] tcg: Release tb_lock in the order
 acquired
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pranith Kumar <bobby.prani@gmail.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: mst@redhat.com, cota@braap.org, qemu-devel@nongnu.org, rth@twiddle.net



On 07/12/2016 16:38, Pranith Kumar wrote:
> 
> Hi Alex,
> 
> Alex Bennée writes:
> 
>>
>> Do you have any numbers for this? The main reason being we are trying to
>> avoid bouncing the lock too much and while this is cleaner it could
>> cause more contention.
> 
> I did not really consider performance while cleaning this up. However, I
> looked closer and I think we can remove the tb lock acquisition while adding
> the jump by using atomics. I've attached the patch below. This should remove
> any concern for a negative performance impact.
> 
> I will include this patch if you think it's okay.

I don't like this, it's too tricky.  You'd have to prove that it's
correct and that it keeps the list consistent.  There's nothing wrong in
locking like

	lock(L1)
	lock(L2)
	unlock(L1)
	unlock(L2)

so I'm not sure I see the point of this patch.

Paolo

> Thanks,
> 
> diff --git a/cpu-exec.c b/cpu-exec.c
> index 13cb15de0e..93debe64b6 100644
> --- a/cpu-exec.c
> +++ b/cpu-exec.c
> @@ -365,9 +365,7 @@ static inline TranslationBlock *tb_find(CPUState *cpu,
>      /* See if we can patch the calling TB. */
>      if (last_tb && !qemu_loglevel_mask(CPU_LOG_TB_NOCHAIN)) {
>          if (!tb->invalid) {
> -            tb_lock();
>              tb_add_jump(last_tb, tb_exit, tb);
> -            tb_unlock();
>          }
>      }
>      return tb;
> diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
> index 84a3240df6..60597cb07e 100644
> --- a/include/exec/exec-all.h
> +++ b/include/exec/exec-all.h
> @@ -336,7 +336,7 @@ static inline void tb_set_jmp_target(TranslationBlock *tb,
>  static inline void tb_add_jump(TranslationBlock *tb, int n,
>                                 TranslationBlock *tb_next)
>  {
> -    if (tb->jmp_list_next[n]) {
> +    if (atomic_cmpxchg(&tb->jmp_list_next[n], 0, tb_next->jmp_list_first)) {
>          /* Another thread has already done this while we were
>           * outside of the lock; nothing to do in this case */
>          return;
> @@ -351,7 +351,6 @@ static inline void tb_add_jump(TranslationBlock *tb, int n,
>      tb_set_jmp_target(tb, n, (uintptr_t)tb_next->tc_ptr);
>  
>      /* add in TB jmp circular list */
> -    tb->jmp_list_next[n] = tb_next->jmp_list_first;
>      tb_next->jmp_list_first = (uintptr_t)tb | n;
>  }
>  
> 
