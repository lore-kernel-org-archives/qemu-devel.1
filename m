Received: from eggs.gnu.org ([2001:4830:134:3::10]:37927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fixhJ-0001T5-2N
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 04:02:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fixhF-00065a-W6
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 04:02:01 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:37999)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fixhF-00064h-KM
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 04:01:57 -0400
References: <153258768962.6738.11319866502689416568.stgit@dhcp-9-109-246-16>
	<4671a0f0-e399-6187-3205-994f663fa260@linaro.org>
	<db84d8c9-fab0-a1eb-7cd8-a154a2a76b10@vivier.eu>
	<f8f59cca-86e6-2a42-3184-faddd51e5424@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <8ffbfbb7-cb4b-665f-ace7-d890c75d14a8@vivier.eu>
Date: Fri, 27 Jul 2018 10:01:06 +0200
MIME-Version: 1.0
In-Reply-To: <f8f59cca-86e6-2a42-3184-faddd51e5424@linaro.org>
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

Le 27/07/2018 à 06:47, Richard Henderson a écrit :
> On 07/26/2018 10:39 AM, Laurent Vivier wrote:
>> Le 26/07/2018 à 19:15, Richard Henderson a écrit :
>>> On 07/25/2018 11:48 PM, Shivaprasad G Bhat wrote:
>>>> r11 is a volatile register on PPC as per calling conventions.
>>>> The safe_syscall code uses it to check if the signal_pending
>>>> is set during the safe_syscall. When a syscall is interrupted
>>>> on return from signal handling, the r11 might be corrupted
>>>> before we retry the syscall leading to a crash. The registers
>>>> r0-r13 are not to be used here as they have
>>>> volatile/designated/reserved usages. Change the code to use
>>>> r14 which is non-volatile and is appropriate for local use in
>>>> safe_syscall.
>>>>
>>>> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.vnet.ibm.com>
>>>> ---
>>>> Steps to reproduce:
>>>> On PPC host, issue `qemu-ppc64le /usr/bin/cc -E -`
>>>> Attempt Ctrl-C, the issue is reproduced.
>>>>
>>>> Reference:
>>>> https://refspecs.linuxfoundation.org/ELF/ppc64/PPC-elf64abi-1.9.html#REG
>>>>
>>>>  linux-user/host/ppc64/safe-syscall.inc.S |    4 ++--
>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/linux-user/host/ppc64/safe-syscall.inc.S b/linux-user/host/ppc64/safe-syscall.inc.S
>>>> index d30050a67c..b0cbbe6a69 100644
>>>> --- a/linux-user/host/ppc64/safe-syscall.inc.S
>>>> +++ b/linux-user/host/ppc64/safe-syscall.inc.S
>>>> @@ -49,7 +49,7 @@ safe_syscall_base:
>>>>  	 *               and returns the result in r3
>>>>  	 * Shuffle everything around appropriately.
>>>>  	 */
>>>> -	mr	11, 3	/* signal_pending */
>>>> +	mr	14, 3	/* signal_pending */
>>>
>>> I do see that I was incorrect in assuming that r11 would be unmodified.  But
>>> you can't simply write to a call-saved register -- you must preserve its value
>>> for the caller.
>>>
>>> Saving the value requires that you find some space on, or create, a stack
>>> frame.  Note that there are two different conventions for _CALL_AIX and
>>> _CALL_ELF==2.
>>
>> Can we guess the syscall ('sc') will not modify neither r11 nor r14...
> 
> But sc does modify r11.
> 
>         li      r11,0
>         std     r11,GPR9(r1)
>         std     r11,GPR10(r1)
>         std     r11,GPR11(r1)
> 
> (Incidentally, unless I'm misreading, the kernel could have saved r11 with
> exactly as much effort as it took to clobber it to zero.  That's just rude.)
> 
>> but the function caller expects that r11 is not modified because it's the
>> environment pointer
> 
> Huh?  What do you think an "environment pointer" is in this context?

It's the comment for r11 in the section "2.2.1.1 Register Roles" of the
document.

> In the ppc64 abi, r11 is one of the ones that are clobbered by plt entries; it
> is not special in any way except as a scratch.
> 
>> and saves r14 because it's one of its local
>> variable it knows it has to preserve?
> 
> Huh?  The caller of safe_syscall does not save r14, and does not expect it
> clobbered.

Yes, you're right. The callee has to save nonvolatile registers, and r14
is a nonvolatile register. And r11 is volatile, it's why it can be
modified by sc.

I should read the doc more carefully.

Thanks,
Laurent
