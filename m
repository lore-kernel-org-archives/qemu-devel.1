Received: from eggs.gnu.org ([2001:4830:134:3::10]:47076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jreiser@bitwagon.com>) id 1duiau-000809-TF
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 13:15:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jreiser@bitwagon.com>) id 1duias-00010T-61
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 13:15:28 -0400
Received: from bitwagon.com ([74.82.39.175]:49415)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jreiser@bitwagon.com>)
	id 1duias-0000zi-0b
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 13:15:26 -0400
Received: from f25e64.local ([24.21.156.164]) by bitwagon.com
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 10:05:36 -0700
References: <4d10cdd2-233c-46ac-926b-d4254b017c78@bitwagon.com>
	<CAFEAcA82LzXcT6BoAoAuD3XtmO6+hehwWd=Jno1DXZd5qEuYcw@mail.gmail.com>
	<CAFEAcA85ZRSgbpSQSFXO+u_jyZrv_4XHcpviP1W1TzYnGcYpUQ@mail.gmail.com>
From: John Reiser <jreiser@bitwagon.com>
Message-ID: <cf804325-c982-c07d-b88c-5d069252f76f@bitwagon.com>
Date: Wed, 20 Sep 2017 10:05:36 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA85ZRSgbpSQSFXO+u_jyZrv_4XHcpviP1W1TzYnGcYpUQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] qemu-arm SIGSEGV for self-modifying code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

Thanks for your reply, Peter.  [I fixed my typo in the Subject: field of the header.]

>>> [Moving here from  https://bugzilla.redhat.com/show_bug.cgi?id=1493304 ]
>>>
>>> qemu-arm from qemu-user-2.10.0-1.fc27.x86_64 (thus emulating 32-bit ARM on
>>> x86_64)
>>> generates SIGSEGV when code modifies a never-previously executed instruction
>>> that is on a writable page and is 848 bytes ahead of pc.
>>> A real armv7l processor allows this and executes as desired.
>>> Why the difference?  How can it be changed?  Where is the documentation?
>>> The memory region in question is allocated via
>>
>>> mmap2(0xf7000000,228092,PROT_EXEC|PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_ANONYMOUS|MAP_FIXED,-1,0)
>>> = 0xf7000000
>>> [and not changed via mprotect()] and written once to contain:
>>> =====
>>> 0xf703704c:
>>>          ldr r2,mflg_here  // pc+856
>>>          orr r2,r2,r3  @ modify the instruction
>>> =>      str r2,mflg_here  // pc+848    the faulting instruction
>>>
>>>       [[snip about 848 bytes containing instructions only]]
>>>
>>> 0xf70373ac:
>>>    mflg_here:  // The next instruction is re-written once.
>>>          orr r3,r3,#0  @ flags |= MAP_{PRIVATE|ANON}  [QNX vs Linux]
>>
>> Is your guest program correctly performing the necessary cache
>> maintenance operations
> 
> ...wait, I think I misread your bug report. You get the SEGV
> on the store to the code, before it even gets to trying to
> execute it?

Yes, the SEGV occurs on the store, "long" before the re-written instruction ever is executed
(848 bytes in space, at least a thousand instructions in time.)
The region between the 'str' and the re-written instruction contains more than a dozen
branches (conditional, unconditional, subroutine calls) and several 'svc' system calls.

The execution sequence is:
   Use mmap2() to allocate 228092 bytes of new pages with read+write+execute permission.
   Generate code into those pages, writing each byte once in order, including at 'mflg_here'.
   Jump to 0xf703704c which is 0x3704c into the new region.  This is the first-ever
     execution in the new region.
   Immediately read-modify-write the instruction at 'mflg_here', which is 0x373ac bytes
     into the region and 848 bytes ahead of the pc.
   SIGSEGV at the 'str' of the read-modify-write.

The qemu-arm generated x86_64 code in the vicinity of the SIGSEGV is
=====
    0x55555599364c <static_code_gen_buffer+13308>:	mov    $0xf70373ac,%ebp
    0x555555993651 <static_code_gen_buffer+13313>:	mov    %gs:0x0(%ebp),%ebp
    0x555555993656 <static_code_gen_buffer+13318>:	mov    0xc(%r14),%ebx
    0x55555599365a <static_code_gen_buffer+13322>:	or     %ebx,%ebp
    0x55555599365c <static_code_gen_buffer+13324>:	mov    %ebp,0x8(%r14)
    0x555555993660 <static_code_gen_buffer+13328>:	mov    $0xf70373ac,%ebx
=> 0x555555993665 <static_code_gen_buffer+13333>:	mov    %ebp,%gs:(%ebx)
    0x555555993669 <static_code_gen_buffer+13337>:	mov    0x34(%r14),%ebp
    0x55555599366d <static_code_gen_buffer+13341>:	mov    %gs:0x0(%ebp),%ebx
    0x555555993672 <static_code_gen_buffer+13346>:	mov    %ebx,0x10(%r14)
(gdb) info reg
rax            0x1	1
rbx            0xf70373ac	4144198572
rcx            0x0	0
rdx            0x55555597b880	93824996587648
rsi            0x555555993640	93824996685376
rdi            0x5555582b6290	93825039819408
rbp            0xe3833022	0xe3833022
rsp            0x7fffffffd2c0	0x7fffffffd2c0
r8             0x0	0
r9             0x0	0
r10            0x55555597b7f0	93824996587504
r11            0x206	518
r12            0x555555993640	93824996685376
r13            0xf703704c	4144197708
r14            0x5555582b6290	93825039819408
r15            0x5555582ae5b8	93825039787448
rip            0x555555993665	0x555555993665 <static_code_gen_buffer+13333>
eflags         0x10286	[ PF SF IF RF ]
cs             0x33	51
ss             0x2b	43
ds             0x0	0
es             0x0	0
fs             0x0	0
gs             0x0	0
=====
Unfortunately gdb does not show the correct value of segment register %gs.
/proc/{qemu-arm}/maps shows no mapping at any address less than 4GiB, yet the x86_64 code
    0x55555599364c <static_code_gen_buffer+13308>:	mov    $0xf70373ac,%ebp
    0x555555993651 <static_code_gen_buffer+13313>:	mov    %gs:0x0(%ebp),%ebp
did perform a successful fetch from %gs:0xf70373ac.  The value 0xe3833022 in %ebp
is the correct new (modified by the OR) contents to be stored into address 0xf70373ac.


Environment variation:
    SIGSEGV with qemu-user-2.7.1-7.fc25.x86_64   under kernel 4.12.11-200.fc25.x86_64
    SIGSEGV with qemu-user-2.9.1-1.fc26.x86_64   under kernel 4.12.13-300.fc26.x86_64
    SIGSEGV with qemu-user-2.10.0-1.fc27.x86_64  under kernel 4.13.2-300.fc27.x86_64
    SIGSEGV with qemu-user 1:2.1+dfsg-12+deb8u6  under kernel 3.16.43-2+deb8u3 (x86_64)
       All SIGSEGV are cross-architecture emulation: running qemu-arm on x86_64.

    Success with qemu-user-2.10.0-1.fc27.armv7hl under kernel 4.13.2-300.fc27.armv7hl
       This success is "native emulation": running qemu-arm on armv7hl.

-- 
John
