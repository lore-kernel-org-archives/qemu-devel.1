Received: from eggs.gnu.org ([2001:4830:134:3::10]:45434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fijru-0004pQ-3U
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 13:16:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fijrr-0005Ro-0R
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 13:16:02 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:40316)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fijrq-0005RX-MQ
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 13:15:58 -0400
Received: by mail-pg1-x541.google.com with SMTP id x5-v6so1551418pgp.7
	for <qemu-devel@nongnu.org>; Thu, 26 Jul 2018 10:15:58 -0700 (PDT)
References: <153258768962.6738.11319866502689416568.stgit@dhcp-9-109-246-16>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4671a0f0-e399-6187-3205-994f663fa260@linaro.org>
Date: Thu, 26 Jul 2018 10:15:53 -0700
MIME-Version: 1.0
In-Reply-To: <153258768962.6738.11319866502689416568.stgit@dhcp-9-109-246-16>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: ppc64: don't use volatile
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
Cc: qemu-devel@nongnu.org

On 07/25/2018 11:48 PM, Shivaprasad G Bhat wrote:
> r11 is a volatile register on PPC as per calling conventions.
> The safe_syscall code uses it to check if the signal_pending
> is set during the safe_syscall. When a syscall is interrupted
> on return from signal handling, the r11 might be corrupted
> before we retry the syscall leading to a crash. The registers
> r0-r13 are not to be used here as they have
> volatile/designated/reserved usages. Change the code to use
> r14 which is non-volatile and is appropriate for local use in
> safe_syscall.
> 
> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.vnet.ibm.com>
> ---
> Steps to reproduce:
> On PPC host, issue `qemu-ppc64le /usr/bin/cc -E -`
> Attempt Ctrl-C, the issue is reproduced.
> 
> Reference:
> https://refspecs.linuxfoundation.org/ELF/ppc64/PPC-elf64abi-1.9.html#REG
> 
>  linux-user/host/ppc64/safe-syscall.inc.S |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/linux-user/host/ppc64/safe-syscall.inc.S b/linux-user/host/ppc64/safe-syscall.inc.S
> index d30050a67c..b0cbbe6a69 100644
> --- a/linux-user/host/ppc64/safe-syscall.inc.S
> +++ b/linux-user/host/ppc64/safe-syscall.inc.S
> @@ -49,7 +49,7 @@ safe_syscall_base:
>  	 *               and returns the result in r3
>  	 * Shuffle everything around appropriately.
>  	 */
> -	mr	11, 3	/* signal_pending */
> +	mr	14, 3	/* signal_pending */

I do see that I was incorrect in assuming that r11 would be unmodified.  But
you can't simply write to a call-saved register -- you must preserve its value
for the caller.

Saving the value requires that you find some space on, or create, a stack
frame.  Note that there are two different conventions for _CALL_AIX and
_CALL_ELF==2.


r~
