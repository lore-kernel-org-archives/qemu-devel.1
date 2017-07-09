Received: from eggs.gnu.org ([2001:4830:134:3::10]:36163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUJcL-00086R-7e
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 17:19:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUJcG-0001YT-7B
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 17:19:49 -0400
Received: from mail-pf0-x22e.google.com ([2607:f8b0:400e:c00::22e]:36118)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dUJcG-0001YF-0Z
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 17:19:44 -0400
Received: by mail-pf0-x22e.google.com with SMTP id q86so39954568pfl.3
	for <qemu-devel@nongnu.org>; Sun, 09 Jul 2017 14:19:43 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1499586614-20507-1-git-send-email-cota@braap.org>
	<1499586614-20507-22-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <3fabc9d4-86b5-9d01-9499-3468bd2f2e5e@twiddle.net>
Date: Sun, 9 Jul 2017 11:19:37 -1000
MIME-Version: 1.0
In-Reply-To: <1499586614-20507-22-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 21/22] tcg: enable per-thread TCG for
 softmmu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org

On 07/08/2017 09:50 PM, Emilio G. Cota wrote:
> This allows us to generate TCG code in parallel. MTTCG already uses
> it, although the next commit pushes down a lock to actually
> perform parallel generation.
> 
> User-mode is kept out of this: contention due to concurrent translation
> is more commonly found in full-system mode.

Um, why do you believe that?  Are you suggesting that a multi-threaded 
user-only guest is much more likely to share TBs and do much less code 
generation total?

At the moment I think it's just a confusing distinction.  As proven by some of 
the comment adjustments you made.

> -TCGContext tcg_ctx;
> +TCG_THREAD TCGContext tcg_ctx;

This is a really large structure, and it's not needed by any of the I/O 
threads.  We're probably better off dynamically allocating this ourselves and 
do something like

__thread TCGContext *tcg_ctx_ptr;
#define tcg_ctx (*tcg_ctx_ptr)

You could then even have tcg_init_ctx be the object instead of a pointer to the 
object.

for the main thread, so you don't have to have an extra pointer to this; just 
reference it by symbol.

> -static struct tcg_temp_info temps[TCG_MAX_TEMPS];
> -static TCGTempSet temps_used;
> +static TCG_THREAD struct tcg_temp_info temps[TCG_MAX_TEMPS];
> +static TCG_THREAD TCGTempSet temps_used;


I've been meaning to dynamically allocate these for a while now.  I think that 
would be better than putting this large array in TLS.  Which, again, is not 
needed for I/O threads.


r~
