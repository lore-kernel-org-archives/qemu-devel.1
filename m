Received: from eggs.gnu.org ([2001:4830:134:3::10]:34695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXgSL-00080X-S7
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:19:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXgSH-0000Er-S8
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:19:25 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:36532)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXgSH-0000Ed-Lz
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:19:21 -0400
Received: by mail-pg0-x241.google.com with SMTP id y129so5314798pgy.3
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 21:19:21 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <201707191017508680118@zte.com.cn>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <918c73df-fad9-ab4e-1ec9-3b45ef14aa2f@twiddle.net>
Date: Tue, 18 Jul 2017 18:19:12 -1000
MIME-Version: 1.0
In-Reply-To: <201707191017508680118@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 00/45] tcg: support for multiple
 TCGcontexts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jiang.biao2@zte.com.cn
Cc: cota@braap.org, qemu-devel@nongnu.org, alex.bennee@linaro.org, jiang.yong5@zte.com.cn, shi.zhongbing@zte.com.cn

On 07/18/2017 04:17 PM, jiang.biao2@zte.com.cn wrote:
> Does that mean both the MTTCG feature and this patch set are all about system
> mode, and have nothing to do with linux-user mode?

Yes.


>  > MTTCG has only been enabled on a few targets: alpha, arm, ppc64.
>  > Look for "mttcg=yes" in configure.
>  >
>  > In order for MTTCG to be enabled, the target must be adjusted so that
>  > (1) all atomic instructions are implemented with atomic tcg operations,
>  > (2) define TCG_GUEST_DEFAULT_MO to indicate any barriers implied by
>  >     normal memory operations by the target architecture.
>  >
>  > For target/mips, neither of these things are complete.
>  >
>  > MTTCG has only been enabled on one host: i386.
>  > Look for TCG_TARGET_DEFAULT_MO in tcg/*/tcg-target.h.
>  >
>  > In order for MTTCG to be enabled, the target memory order must not be stronger
>  > than the host memory order.  Since i386 has a very strong host memory order, it
>  > is easy for it to emulate any guest.  When the host has a weak memory order, we
>  > need to add the additional barriers that are implied by the target.  This is
>  > work that has not been done.
>  >
>  > I am not sure why we have not already added this definition to all of the other
>  > tcg hosts.  I think this is just oversight, since almost everyone uses x86_64
>  > linux as the host for testing tcg.  However, since all of the supported targets
>  > have weak memory orders we ought to be able to support them with any host.
> 
> In my case, I use Mips64 host and i386 target, does that mean I can not enable
> the MTTCG?

Yes.

It would be only a small amount of work to enable MTTCG for this combination. 
Since soft code freeze for QEMU 2.10 is today, that will have to happen for the 
next development window.

>  > For user mode, we should still follow the rules for MTTCG, but we do not.
>  > Instead we take it on faith that they have been and execute the code in
>  > parallel anyway.  This faith is often misplaced and it does mean that
>  > unsupported targets execute user mode code incorrectly.
> 
> What do you exactly mean about the *unsupported targets*? mips? arm? i386?

See above, where I list the supported targets and supported hosts.

> What is the main reason for the incorrectly execution of multithread app for 
> user mode?

Incorrect implementation of atomic operations and incorrect memory barriers.

> Specificly for my case(i386 target on Mips64 host in user mode),  how to 
> improved the situation?

For this specific case, the primary problem will be the implicit memory 
barriers that the i386 guest requires, but that the mips64 host does not provide.

For tcg/mips/, TCG_TARGET_DEFAULT_MO should be 0, because the mips architecture 
does not have any implicit memory ordering.  All memory barriers are explicit 
via SYNC instructions.

For target/i386, TCG_GUEST_DEFAULT_MO is TCG_MO_ALL & ~TCG_MO_ST_LD, or

	TCG_MO_LD_LD | TCG_MO_LD_ST | TCG_MO_ST_ST

which means that implicit memory barriers exist between load/load, load/store, 
store/store, but not store/load.

In order to fix this, we need to add the missing barriers to the opcode stream.

The simplest fix for this is to put a call

	tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC)

at the end of gen_ldst_i32 and gen_ldst_i64.  That should be good enough to 
make your specific case operate correctly.

A proper fix will involve (1) emitting those barriers only if the barrier is 
not implied by the host and (2) optimizing away redundant barriers.


r~
