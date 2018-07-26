Received: from eggs.gnu.org ([2001:4830:134:3::10]:53082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fikFL-0004J0-Eq
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 13:40:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fikFH-0003n0-HU
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 13:40:15 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:38229)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fikFH-0003iK-8B
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 13:40:11 -0400
References: <153258768962.6738.11319866502689416568.stgit@dhcp-9-109-246-16>
	<4671a0f0-e399-6187-3205-994f663fa260@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <db84d8c9-fab0-a1eb-7cd8-a154a2a76b10@vivier.eu>
Date: Thu, 26 Jul 2018 19:39:38 +0200
MIME-Version: 1.0
In-Reply-To: <4671a0f0-e399-6187-3205-994f663fa260@linaro.org>
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
To: Richard Henderson <richard.henderson@linaro.org>, Shivaprasad G Bhat <sbhat@linux.vnet.ibm.com>, dgibson@redhat.com, riku.voipio@iki.fi
Cc: qemu-devel@nongnu.org

Le 26/07/2018 à 19:15, Richard Henderson a écrit :
> On 07/25/2018 11:48 PM, Shivaprasad G Bhat wrote:
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
>> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.vnet.ibm.com>
>> ---
>> Steps to reproduce:
>> On PPC host, issue `qemu-ppc64le /usr/bin/cc -E -`
>> Attempt Ctrl-C, the issue is reproduced.
>>
>> Reference:
>> https://refspecs.linuxfoundation.org/ELF/ppc64/PPC-elf64abi-1.9.html#REG
>>
>>  linux-user/host/ppc64/safe-syscall.inc.S |    4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/linux-user/host/ppc64/safe-syscall.inc.S b/linux-user/host/ppc64/safe-syscall.inc.S
>> index d30050a67c..b0cbbe6a69 100644
>> --- a/linux-user/host/ppc64/safe-syscall.inc.S
>> +++ b/linux-user/host/ppc64/safe-syscall.inc.S
>> @@ -49,7 +49,7 @@ safe_syscall_base:
>>  	 *               and returns the result in r3
>>  	 * Shuffle everything around appropriately.
>>  	 */
>> -	mr	11, 3	/* signal_pending */
>> +	mr	14, 3	/* signal_pending */
> 
> I do see that I was incorrect in assuming that r11 would be unmodified.  But
> you can't simply write to a call-saved register -- you must preserve its value
> for the caller.
> 
> Saving the value requires that you find some space on, or create, a stack
> frame.  Note that there are two different conventions for _CALL_AIX and
> _CALL_ELF==2.

Can we guess the syscall ('sc') will not modify neither r11 nor r14, but
the function caller expects that r11 is not modified because it's the
environment pointer, and saves r14 because it's one of its local
variable it knows it has to preserve?

In this case, I think Shivaprasad's fix is correct.

Thanks,
Laurent
