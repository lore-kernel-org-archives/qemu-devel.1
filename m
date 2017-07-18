Received: from eggs.gnu.org ([2001:4830:134:3::10]:49576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXL0f-0004vX-3u
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 01:25:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXL0c-00071l-07
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 01:25:25 -0400
Received: from mail-pg0-x22a.google.com ([2607:f8b0:400e:c05::22a]:33249)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXL0b-00071J-Qp
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 01:25:21 -0400
Received: by mail-pg0-x22a.google.com with SMTP id k14so6338199pgr.0
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 22:25:21 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1500235468-15341-1-git-send-email-cota@braap.org>
	<1500235468-15341-46-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <04004f7a-0e84-1b51-bc93-97c70213541d@twiddle.net>
Date: Mon, 17 Jul 2017 19:25:14 -1000
MIME-Version: 1.0
In-Reply-To: <1500235468-15341-46-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 45/45] tcg: enable multiple TCG contexts
 in softmmu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org

On 07/16/2017 10:04 AM, Emilio G. Cota wrote:
> +
> +    /* claim the first free pointer in tcg_ctxs and increment n_tcg_ctxs */
> +    for (i = 0; i < smp_cpus; i++) {
> +        if (atomic_cmpxchg(&tcg_ctxs[i], NULL, s) == NULL) {
> +            unsigned int n;
> +
> +            n = atomic_fetch_inc(&n_tcg_ctxs);

Surely this is too much effort.  The increment on n_tcg_ctxs is sufficient to 
produce an index for assignment.  We never free the contexts...

Which also suggests that it might be better to avoid an indirection in tcg_ctxs 
and allocate all of the structures in one big block?  I.e.

TCGContext *tcg_ctxs;

// At the end of tcg_context_init.
#ifdef CONFIG_USER_ONLY
     tcg_ctxs = s;
#else
     // No need to zero; we'll completely overwrite each structure
     // during tcg_register_thread.
     tcg_ctxs = g_new(TCGContext, smp_cpus);
#endif


r~
