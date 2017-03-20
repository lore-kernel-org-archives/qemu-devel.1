Received: from eggs.gnu.org ([2001:4830:134:3::10]:44084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cq5EL-0004ok-7E
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 17:52:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cq5EI-00065y-6v
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 17:52:45 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:33774)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cq5EI-000652-0w
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 17:52:42 -0400
Received: by mail-pg0-x243.google.com with SMTP id 79so13325906pgf.0
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 14:52:41 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170320153441.2181-1-alex.bennee@linaro.org>
	<20170320153441.2181-3-alex.bennee@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <5c149286-f606-8b39-8b09-fcdd02ca495d@twiddle.net>
Date: Tue, 21 Mar 2017 07:52:34 +1000
MIME-Version: 1.0
In-Reply-To: <20170320153441.2181-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 2/3] user-exec: handle synchronous
 signals from QEMU gracefully
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, mttcg@greensocs.com, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com, Riku Voipio <riku.voipio@iki.fi>

On 03/21/2017 01:34 AM, Alex Bennée wrote:
> When "tcg: enable thread-per-vCPU" (commit 3725794) was merged the
> lifetime of current_cpu was changed. Previously a broken linux-user
> call might abort() which can eventually escalate into a SIGSEGV which
> would then crash qemu as it attempted to deref a NULL current_cpu.
> After commit 3725794 it would attempt to fixup state and re-start the
> run-loop and much hilarity (i.e. a looping lockup) would ensue from
> jumping into a stale jmp_env.
>
> As we can actually tell if we are in the run-loop from looking at the
> cpu->running flag we should catch this badness first and abort()
> cleanly rather than try to soldier on. There is a theoretical race
> between the flag being set and sigsetjmp refreshing the jump buffer
> but we can try really hard to not introduce crashes into that code.
>
> [LV: setgroups03 fails on powerpc LTP]
> Reported-by: Laurent Vivier <laurent@vivier.eu>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  user-exec.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
