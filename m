Received: from eggs.gnu.org ([2001:4830:134:3::10]:41280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fivAq-0001ri-6Y
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 01:20:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fivAl-00023F-Nm
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 01:20:19 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:36334)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fivAl-00022f-7E
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 01:20:15 -0400
Received: by mail-pg1-x542.google.com with SMTP id s7-v6so2530465pgv.3
	for <qemu-devel@nongnu.org>; Thu, 26 Jul 2018 22:20:15 -0700 (PDT)
References: <153259340275.5529.15876484471761179518.stgit@dhcp-9-109-246-16>
	<20180727031348.GD3694@umbus.fritz.box>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c162e499-1429-7863-4a1a-58cfbb4d3057@linaro.org>
Date: Thu, 26 Jul 2018 22:20:11 -0700
MIME-Version: 1.0
In-Reply-To: <20180727031348.GD3694@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2] linux-user: ppc64: don't use
 volatile register during safe_syscall
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Shivaprasad G Bhat <sbhat@linux.vnet.ibm.com>
Cc: dgibson@redhat.com, riku.voipio@iki.fi, laurent@vivier.eu, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 07/26/2018 08:13 PM, David Gibson wrote:
> On Thu, Jul 26, 2018 at 01:56:19PM +0530, Shivaprasad G Bhat wrote:
>> r11 is a volatile register on PPC as per calling conventions.
>> The safe_syscall code uses it to check if the signal_pending
>> is set during the safe_syscall. When a syscall is interrupted
>> on return from signal handling, the r11 might be corrupted
>> before we retry the syscall leading to a crash. The registers
>> r0-r13 are not to be used here as they have
>> volatile/designated/reserved usages. Change the code to use
>> r14 which is non-volatile and is appropriate for local use in
>> safe_syscall.
>>
>> Steps to reproduce:
>> On PPC host, issue `qemu-x86_64 /usr/bin/cc -E -`
>> Attempt Ctrl-C, the issue is reproduced.
>>
>> Reference:
>> https://refspecs.linuxfoundation.org/ELF/ppc64/PPC-elf64abi-1.9.html#REG
>>
>> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.vnet.ibm.com>
>> Tested-by: Laurent Vivier <laurent@vivier.eu>
>> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> 
> Applied to ppc-for-3.0.

No please!  r14 is a call-saved register and needs saving before clobbering.


r~
