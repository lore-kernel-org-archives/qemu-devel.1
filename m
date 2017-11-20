Received: from eggs.gnu.org ([2001:4830:134:3::10]:32969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eGtdu-0003bj-TS
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 16:30:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eGtdr-0004Sq-NW
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 16:30:14 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:37440)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eGtdr-0004RT-Gd
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 16:30:11 -0500
Received: by mail-wm0-x243.google.com with SMTP id v186so21455344wma.2
	for <qemu-devel@nongnu.org>; Mon, 20 Nov 2017 13:30:11 -0800 (PST)
References: <1511201308-23580-1-git-send-email-peter.maydell@linaro.org>
	<1511201308-23580-3-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a7d9b8b2-df18-c0c1-a4b2-011b303eb0cf@linaro.org>
Date: Mon, 20 Nov 2017 22:30:07 +0100
MIME-Version: 1.0
In-Reply-To: <1511201308-23580-3-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 for-2.11 2/2] accel/tcg: Handle atomic
 accesses to notdirty memory correctly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Stuart Monteith <stuart.monteith@linaro.org>

On 11/20/2017 07:08 PM, Peter Maydell wrote:
> To do a write to memory that is marked as notdirty, we need
> to invalidate any TBs we have cached for that memory, and
> update the cpu physical memory dirty flags for VGA and migration.
> The slowpath code in notdirty_mem_write() does all this correctly,
> but the new atomic handling code in atomic_mmu_lookup() doesn't
> do anything at all, it just clears the dirty bit in the TLB.
> 
> The effect of this bug is that if the first write to a notdirty
> page for which we have cached TBs is by a guest atomic access,
> we fail to invalidate the TBs and subsequently will execute
> incorrect code. This can be seen by trying to run 'javac' on AArch64.
> 
> Use the new notdirty_call_before() and notdirty_call_after()
> functions to correctly handle the update to notdirty memory
> in the atomic codepath.
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  accel/tcg/atomic_template.h | 12 ++++++++++++
>  accel/tcg/cputlb.c          | 38 +++++++++++++++++++++++++-------------
>  accel/tcg/user-exec.c       |  1 +
>  3 files changed, 38 insertions(+), 13 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
