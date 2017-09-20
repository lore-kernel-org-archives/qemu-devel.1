Received: from eggs.gnu.org ([2001:4830:134:3::10]:37513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1duekb-0006Kc-9R
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:09:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1duek5-00058d-Iv
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:09:13 -0400
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:43931)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1duek5-000570-Bi
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:08:41 -0400
Received: by mail-wr0-x234.google.com with SMTP id a43so2124733wrc.0
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 06:08:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA82LzXcT6BoAoAuD3XtmO6+hehwWd=Jno1DXZd5qEuYcw@mail.gmail.com>
References: <4d10cdd2-233c-46ac-926b-d4254b017c78@bitwagon.com>
	<CAFEAcA82LzXcT6BoAoAuD3XtmO6+hehwWd=Jno1DXZd5qEuYcw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 20 Sep 2017 11:38:05 +0100
Message-ID: <CAFEAcA85ZRSgbpSQSFXO+u_jyZrv_4XHcpviP1W1TzYnGcYpUQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] qmeu-arm SIGSEGV for self-modifying code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Reiser <jreiser@bitwagon.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 20 September 2017 at 11:21, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 20 September 2017 at 00:13, John Reiser <jreiser@bitwagon.com> wrote:
>> [Moving here from  https://bugzilla.redhat.com/show_bug.cgi?id=1493304 ]
>>
>> qemu-arm from qemu-user-2.10.0-1.fc27.x86_64 (thus emulating 32-bit ARM on
>> x86_64)
>> generates SIGSEGV when code modifies a never-previously executed instruction
>> that is on a writable page and is 848 bytes ahead of pc.
>> A real armv7l processor allows this and executes as desired.
>> Why the difference?  How can it be changed?  Where is the documentation?
>> The memory region in question is allocated via
>
>> mmap2(0xf7000000,228092,PROT_EXEC|PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_ANONYMOUS|MAP_FIXED,-1,0)
>> = 0xf7000000
>> [and not changed via mprotect()] and written once to contain:
>> =====
>> 0xf703704c:
>>         ldr r2,mflg_here  // pc+856
>>         orr r2,r2,r3  @ modify the instruction
>> =>      str r2,mflg_here  // pc+848    the faulting instruction
>>
>>      [[snip about 848 bytes containing instructions only]]
>>
>> 0xf70373ac:
>>   mflg_here:  // The next instruction is re-written once.
>>         orr r3,r3,#0  @ flags |= MAP_{PRIVATE|ANON}  [QNX vs Linux]
>
> Is your guest program correctly performing the necessary cache
> maintenance operations

...wait, I think I misread your bug report. You get the SEGV
on the store to the code, before it even gets to trying to
execute it?

thanks
-- PMM
