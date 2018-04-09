Received: from eggs.gnu.org ([2001:4830:134:3::10]:58770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f5Y6q-0003hV-Rc
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 10:49:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f5Y6p-0003yL-SR
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 10:49:28 -0400
References: <20180409140714.26841-1-peter.maydell@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <0df7ebc7-421b-3ee7-bc45-4aafa3801009@vivier.eu>
Date: Mon, 9 Apr 2018 16:48:57 +0200
MIME-Version: 1.0
In-Reply-To: <20180409140714.26841-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-2.12] linux-user/signal.c: Ensure
 AArch64 signal frame isn't too small
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Richard Henderson <rth@twiddle.net>, Richard Henwood <richard.henwood@arm.com>, Riku Voipio <riku.voipio@iki.fi>

Le 09/04/2018 à 16:07, Peter Maydell a écrit :
> The AArch64 signal frame design was extended for SVE in commit
> 8c5931de0ac77388096d79ceb, so that instead of having a fixed setup we
> now add various records to the frame, with some of them possibly
> overflowing into an extra space outside the original 4K reserved
> block in the target_sigcontext.  However, we failed to ensure that we
> always at least allocate the 4K reserved block.  This is ABI, and
> some userspace programs rely on it.  In particular the dash shell
> would segfault if the frame wasn't as big enough.
> 
> (Compare the kernel's sigframe_size() function in
> arch/arm64/kernel/signal.c.)
> 
> Reported-by: Richard Henwood <richard.henwood@arm.com>
> Fixes: https://bugs.launchpad.net/bugs/1761535
> Fixes: 8c5931de0ac77388096d79ceb
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  linux-user/signal.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/linux-user/signal.c b/linux-user/signal.c
> index 046d4c8aa0..8d9e6e8410 100644
> --- a/linux-user/signal.c
> +++ b/linux-user/signal.c
> @@ -1850,6 +1850,12 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
>      fr_ofs = layout.total_size;
>      layout.total_size += sizeof(struct target_rt_frame_record);
>  
> +    /* We must always provide at least the standard 4K reserved space,
> +     * even if we don't use all of it (this is part of the ABI)
> +     */
> +    layout.total_size = MAX(layout.total_size,
> +                            sizeof(struct target_rt_sigframe));
> +
>      frame_addr = get_sigframe(ka, env, layout.total_size);
>      trace_user_setup_frame(env, frame_addr);
>      if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 0)) {
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
