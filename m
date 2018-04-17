Received: from eggs.gnu.org ([2001:4830:134:3::10]:38751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f8YcB-00049G-KX
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 17:58:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f8Yc8-0007Zp-Fa
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 17:58:15 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:35548)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f8Yc8-0007Uu-9g
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 17:58:12 -0400
Received: by mail-pf0-x241.google.com with SMTP id j5so3266686pfh.2
	for <qemu-devel@nongnu.org>; Tue, 17 Apr 2018 14:58:11 -0700 (PDT)
References: <CAOuPqTFJABMcDHmQcNoNZioBBJ8RcreeevsRfh5b46ZgKZLetw@mail.gmail.com>
	<CAFEAcA8cWYPjN8sxCwzCXhNBucXyhCBMFDA-AJ2zUCr-FKLT1A@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2a15b7bf-1502-6f95-6b7e-12a2990f5a05@linaro.org>
Date: Tue, 17 Apr 2018 11:58:06 -1000
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8cWYPjN8sxCwzCXhNBucXyhCBMFDA-AJ2zUCr-FKLT1A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-arm] ARM memory barrier patch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Henry Wertz <hwertz10@gmail.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>

On 04/17/2018 11:51 AM, Peter Maydell wrote:
> On 17 April 2018 at 22:32, Henry Wertz <hwertz10@gmail.com> wrote:
>> Please find submitted a patch for ARM memory barriers.  This patch is
>> against qemu-2.12-rc2 but I do believe it should apply for anything from
>> 2.11.x to current. (the code being patched was added in for 2.11 series.)
>>
>>
>> I found with qemu 2.11.x or newer that I would get an illegal instruction
>> error running some Intel binaries on my ARM chromebook.  On investigation,
>> I found it was quitting on memory barriers.
>> qemu instruction:
>> mb $0x31
>> was translating as:
>> 0x604050cc:  5bf07ff5  blpl     #0x600250a8
>>
>> After patch it gives:
>> 0x604050cc:  f57ff05b  dmb      ish
>>
>> In short, I found INSN_DMB_ISH (memory barrier for ARMv7) appeared to be
>> correct based on online docs, but due to some endian-related shenanigans it
>> had to be byte-swapped to suit qemu; it appears INSN_DMB_MCR (memory barrier
>> for ARMv6) also should be byte swapped  (and this patch does so).
>> I have not checked for correctness of aarch64's barrier instruction.
>>
>> Signed-off-by: Henry Wertz <hwertz10@gmail.com>
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> 
> Richard, did you want to take this via the tcg tree?

Yes, I can do that.


r~
