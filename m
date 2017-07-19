Received: from eggs.gnu.org ([2001:4830:134:3::10]:59483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXdTx-00053t-F9
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 21:08:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXdTs-0000pn-Md
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 21:08:53 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:36086)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXdTs-0000pg-GT
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 21:08:48 -0400
Received: by mail-qt0-x241.google.com with SMTP id l55so4430012qtl.3
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 18:08:48 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <201707190822419393994@zte.com.cn>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <d53318a2-1297-0592-b755-7c7fda3cc4ce@twiddle.net>
Date: Tue, 18 Jul 2017 15:08:40 -1000
MIME-Version: 1.0
In-Reply-To: <201707190822419393994@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 00/45] tcg: support for multiple TCG
 contexts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jiang.biao2@zte.com.cn, cota@braap.org
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 07/18/2017 02:22 PM, jiang.biao2@zte.com.cn wrote:
> Seeing your work on multiple TCG, it seems that it has some kind of connection 
> with the  MTTCG feature,
> 
> but I do not figure out how they are connected in detail.
> 
> Could you pls help to confirm the following questions:
> 
>  1.
> 
>     what is the relationship between your patches and the MTTCG feature
>     mentioned by https://lwn.net/Articles/697265/?


The current MTTCG feature is in QEMU mainline.  It allows parallel execution of 
translated code in both system mode.  It does *not* allow parallel translation 
-- all translation is done with tb_lock held.

Note that we *always* have parallel execution in user mode.  However, this can 
and does lead to problems.  See below.

This patch set allows parallel translation in system mode.  This is shown to 
improve the overall throughput.  It does *not* allow parallel translation in 
user mode.  Firstly because user mode already shares more translations between 
threads (because it is running a single executable), and so the translation 
routines are not high in the profile.  Secondly because there are additional 
locking problems due to the fact that we have no bound on the number of user 
threads.


>  2.
> 
>     What is the current status of the development of the MTTCG feature?

MTTCG has only been enabled on a few targets: alpha, arm, ppc64.
Look for "mttcg=yes" in configure.

In order for MTTCG to be enabled, the target must be adjusted so that
(1) all atomic instructions are implemented with atomic tcg operations,
(2) define TCG_GUEST_DEFAULT_MO to indicate any barriers implied by
     normal memory operations by the target architecture.

For target/mips, neither of these things are complete.

MTTCG has only been enabled on one host: i386.
Look for TCG_TARGET_DEFAULT_MO in tcg/*/tcg-target.h.

In order for MTTCG to be enabled, the target memory order must not be stronger 
than the host memory order.  Since i386 has a very strong host memory order, it 
is easy for it to emulate any guest.  When the host has a weak memory order, we 
need to add the additional barriers that are implied by the target.  This is 
work that has not been done.

I am not sure why we have not already added this definition to all of the other 
tcg hosts.  I think this is just oversight, since almost everyone uses x86_64 
linux as the host for testing tcg.  However, since all of the supported targets 
have weak memory orders we ought to be able to support them with any host.


>  3.
> 
>     Is there any problem with the multithread programme running with linux-user
>     qemu mode? would the situation be improved with  the MTTCG feature?
> 
>     We need to use linux-user mode qemu to run multithread app, but there seems
>     to be many problem.

For user mode, we should still follow the rules for MTTCG, but we do not. 
Instead we take it on faith that they have been and execute the code in 
parallel anyway.  This faith is often misplaced and it does mean that 
unsupported targets execute user mode code incorrectly.


r~
