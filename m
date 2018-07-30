Received: from eggs.gnu.org ([2001:4830:134:3::10]:34439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fk7X7-0000gV-3D
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 08:44:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fk7X4-0006fU-1k
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 08:44:17 -0400
Received: from mail-vk0-x242.google.com ([2607:f8b0:400c:c05::242]:39609)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fk7X3-0006f8-Ta
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 08:44:13 -0400
Received: by mail-vk0-x242.google.com with SMTP id e139-v6so5622183vkf.6
	for <qemu-devel@nongnu.org>; Mon, 30 Jul 2018 05:44:13 -0700 (PDT)
References: <153294521235.6959.12520498748431693809.stgit@dhcp-9-109-246-16>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4a633022-d560-a704-e143-928b8467f09c@linaro.org>
Date: Mon, 30 Jul 2018 08:44:07 -0400
MIME-Version: 1.0
In-Reply-To: <153294521235.6959.12520498748431693809.stgit@dhcp-9-109-246-16>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] linux-user: ppc64: don't use volatile
 register during safe_syscall
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shivaprasad G Bhat <sbhat@linux.vnet.ibm.com>, dgibson@redhat.com, riku.voipio@iki.fi, laurent@vivier.eu
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 07/30/2018 06:09 AM, Shivaprasad G Bhat wrote:
> r11 is a volatile register on PPC as per calling conventions.
> The safe_syscall code uses it to check if the signal_pending
> is set during the safe_syscall. When a syscall is interrupted
> on return from signal handling, the r11 might be corrupted
> before we retry the syscall leading to a crash. The registers
> r0-r13 are not to be used here as they have
> volatile/designated/reserved usages.
> 
> Change the code to use r14 which is non-volatile.
> Use SP+16 which is a slot for LR, for save/restore of previous value
> of r14. SP+16 can be used, as LR is preserved across the syscall.
> 
> Steps to reproduce:
> On PPC host, issue `qemu-x86_64 /usr/bin/cc -E -`
> Attempt Ctrl-C, the issue is reproduced.
> 
> Reference:
> https://refspecs.linuxfoundation.org/ELF/ppc64/PPC-elf64abi-1.9.html#REG
> https://openpowerfoundation.org/wp-content/uploads/2016/03/ABI64BitOpenPOWERv1.1_16July2015_pub4.pdf
> 
> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.vnet.ibm.com>

This does fix the bug, so
Tested-by: Richard Henderson <richard.henderson@linaro.org>

But we can do slightly better:

> @@ -49,7 +49,8 @@ safe_syscall_base:
>  	 *               and returns the result in r3
>  	 * Shuffle everything around appropriately.
>  	 */
> -	mr	11, 3	/* signal_pending */
> +	std     14, 16(1) /* Preserve r14 in SP+16 */

Above this context, we have a .cfi_startproc directive, which indicates we are
providing unwind information for this function (trivial up to this point).

To preserve that, you need to add

	.cfi_offset 14, 16

right here, indicating r14 is saved 16 bytes "up" the stack frame.

Since this portion of the stack frame is allocated by the caller, this saved
value remains valid through the end of the function, so we do not need to do
anything at the points where the value is restored.

>  safe_syscall_end:
> +	ld 14, 16(1) /* restore r14 to its original value */
>  	/* code path when we did execute the syscall */

Swap these two lines.

With those two changes,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
