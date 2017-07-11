Received: from eggs.gnu.org ([2001:4830:134:3::10]:54374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dUq7j-0003qw-5R
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 04:02:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dUq7g-0003Db-2t
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 04:02:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44476)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dUq7f-0003CB-T4
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 04:02:20 -0400
References: <1499586614-20507-1-git-send-email-cota@braap.org>
	<1499586614-20507-22-git-send-email-cota@braap.org>
	<e69fe832-f4e8-f59d-e0dd-3472f498c04e@redhat.com>
	<20170710211446.GA25777@flamenco>
	<790239404.15218867.1499722387288.JavaMail.zimbra@redhat.com>
	<20170710221314.GA1051@flamenco>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20c29ea2-4264-a7dd-713d-d28855079a2d@redhat.com>
Date: Tue, 11 Jul 2017 10:02:16 +0200
MIME-Version: 1.0
In-Reply-To: <20170710221314.GA1051@flamenco>
Content-Type: text/plain; charset=utf-8
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
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

On 11/07/2017 00:13, Emilio G. Cota wrote:
> On Mon, Jul 10, 2017 at 17:33:07 -0400, Paolo Bonzini wrote:
>>
>>> I agree that it would be nice to have the same mechanism for all.
>>>
>>> The main hurdle I see is how to allow for concurrent code generation while
>>> minimizing flushes of the single, fixed-size[*] code_gen_buffer.
>>> In user-mode this is tricky because there is no way to bound the number
>>> of threads that might be spawned by the guest code (I don't think reading
>>> /proc/sys/kernel/threads-max is a viable solution here).
>>>
>>> Switching to a "__thread *tcg_ctx_ptr" model will help minimize
>>> user-mode/softmmu differences though. The only remaining difference would be
>>> that user-mode would need tb_lock() around tb_gen_code, whereas softmmu
>>> wouldn't, but everything else would be the same.
>>
>> Hmm, tb_gen_code is already protected by mmap_lock in linux-user, so you wouldn't
>> get any parallelism.  On the other hand, you could just say that the fixed-size
>> code_gen_buffer is protected by mmap_lock, which doesn't exist for softmmu.
> 
> Yes. tb_lock/mmap_lock, or like they're called in some asserts, memory_lock.
> 
> A way to get some parallelism in user-mode given the constraints
> would be to share regions among TCG threads. Threads would still need to take
> a per-region lock, but it wouldn't be a global lock so that would scale better.
> 
> I'm not sure we really need that much parallelism for code generation in user-mode,
> though. So I wouldn't focus on this until seeing benchmarks that have a clear
> bottleneck due to "memory_lock".

I agree.  Still, we could minimize the differences by protecting
tb_gen_code only with mmap_lock, instead of mmap_lock+tb_lock.

Paolo
