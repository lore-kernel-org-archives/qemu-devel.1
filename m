Received: from eggs.gnu.org ([2001:4830:134:3::10]:45325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cOs4B-0002EF-KX
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 15:21:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cOs48-0000Jz-DS
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 15:21:47 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:52844)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cOs48-0000Ix-2g
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 15:21:44 -0500
References: <1482946636-3743-1-git-send-email-laurent@vivier.eu>
	<874m1e655f.fsf@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <f685953e-76d2-c632-877d-8afd4b777ce6@vivier.eu>
Date: Wed, 4 Jan 2017 21:21:22 +0100
MIME-Version: 1.0
In-Reply-To: <874m1e655f.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: always start with
 parallel_cpus set to true
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, "Emilio G . Cota" <cota@braap.org>, Riku Voipio <riku.voipio@iki.fi>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Richard Henderson <rth@twiddle.net>

Le 04/01/2017 à 19:39, Alex Bennée a écrit :
> 
> Laurent Vivier <laurent@vivier.eu> writes:
> 
>> We always need real atomics, as we can have shared memory between
>> processes.
>>
>> A good test case is the example from futex(2), futex_demo.c:
>>
>> the use case is
>>
>>     mmap(...);
>>     fork();
>>
>>     Parent and Child:
>>
>>     while(...)
>>         __sync_bool_compare_and_swap(...)
>>         ...
>>         futex(...)
>>
>> In this case we need real atomics in __sync_bool_compare_and_swap(),
>> but as parallel_cpus is set to 0, we don't have.
>>
>> We also revert "b67cb68 linux-user: enable parallel code generation on clone"
>> as parallel_cpus in unconditionally set now.
>>
>> Of course, this doesn't fix atomics that are emulated using
>> cpu_loop_exit_atomic() as we can't stop virtual CPUs from another
>> processes.
> 
> This seems a bit of a hit for something that might never get called.
> Could we not move b67cb68 out of the thread fork leg and do it for any
> fork? After all the tb_flush will ensure that all code by both parent
> and child will be using full atomics at that point?

Yes, but we can have also two processes that are neither parents nor
children trying to communicate through shared memory. We can't know...

Laurent
