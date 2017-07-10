Received: from eggs.gnu.org ([2001:4830:134:3::10]:46270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dUgIq-00036q-9M
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 17:33:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dUgIn-00063X-68
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 17:33:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42970)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dUgIm-00063F-Vg
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 17:33:09 -0400
Date: Mon, 10 Jul 2017 17:33:07 -0400 (EDT)
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <790239404.15218867.1499722387288.JavaMail.zimbra@redhat.com>
In-Reply-To: <20170710211446.GA25777@flamenco>
References: <1499586614-20507-1-git-send-email-cota@braap.org>
	<1499586614-20507-22-git-send-email-cota@braap.org>
	<e69fe832-f4e8-f59d-e0dd-3472f498c04e@redhat.com>
	<20170710211446.GA25777@flamenco>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>


> I agree that it would be nice to have the same mechanism for all.
> 
> The main hurdle I see is how to allow for concurrent code generation while
> minimizing flushes of the single, fixed-size[*] code_gen_buffer.
> In user-mode this is tricky because there is no way to bound the number
> of threads that might be spawned by the guest code (I don't think reading
> /proc/sys/kernel/threads-max is a viable solution here).
> 
> Switching to a "__thread *tcg_ctx_ptr" model will help minimize
> user-mode/softmmu differences though. The only remaining difference would be
> that user-mode would need tb_lock() around tb_gen_code, whereas softmmu
> wouldn't, but everything else would be the same.

Hmm, tb_gen_code is already protected by mmap_lock in linux-user, so you wouldn't
get any parallelism.  On the other hand, you could just say that the fixed-size
code_gen_buffer is protected by mmap_lock, which doesn't exist for softmmu.

Paolo
