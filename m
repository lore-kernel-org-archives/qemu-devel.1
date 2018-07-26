Received: from eggs.gnu.org ([2001:4830:134:3::10]:33865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fib0q-0007Tw-Ku
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 03:48:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fib0n-0005QE-Ms
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 03:48:40 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:48977)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fib0n-0005Pz-CH
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 03:48:37 -0400
References: <153258768962.6738.11319866502689416568.stgit@dhcp-9-109-246-16>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <ef4f08e5-910f-a77b-6671-996be94e3c7f@vivier.eu>
Date: Thu, 26 Jul 2018 09:48:17 +0200
MIME-Version: 1.0
In-Reply-To: <153258768962.6738.11319866502689416568.stgit@dhcp-9-109-246-16>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: Shivaprasad G Bhat <sbhat@linux.vnet.ibm.com>, dgibson@redhat.com, riku.voipio@iki.fi, richard.henderson@linaro.org
Cc: qemu-devel@nongnu.org

Le 26/07/2018 à 08:48, Shivaprasad G Bhat a écrit :
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

I think these comments should be included in the commit message.
Using the example of qemu-x86_64 on ppc64 would be less ambiguous.

I've tested on ppc64:

    qemu-x86_64 /usr/bin/cc -E -

Tested-by: Laurent Vivier <laurent@vivier.eu>

>  linux-user/host/ppc64/safe-syscall.inc.S |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

Thanks,
Laurent
