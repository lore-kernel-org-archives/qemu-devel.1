Received: from eggs.gnu.org ([2001:4830:134:3::10]:36548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cipJt-000053-Ti
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 16:28:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cipJs-000184-ML
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 16:28:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50072)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1cipJs-00017o-GB
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 16:28:28 -0500
References: <CAFEAcA_KVG19uhPuBUNx4ySmebnL1Hit6=HUX9ug0FkBFMwasg@mail.gmail.com>
	<4b5d1228-fb99-6b8f-6f8b-bab42b84e7ce@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <61a443e9-2e69-149c-1c2f-7c0cd53ba6a2@redhat.com>
Date: Tue, 28 Feb 2017 22:28:23 +0100
MIME-Version: 1.0
In-Reply-To: <4b5d1228-fb99-6b8f-6f8b-bab42b84e7ce@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] intermittent make check failure:
 "tcg_handle_interrupt: assertion failed: (qemu_mutex_iothread_locked())"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>

On 28.02.2017 20:30, Thomas Huth wrote:
> On 28.02.2017 20:10, Peter Maydell wrote:
>> I got a make check failure on aarch64 host running a sparc64 test:
>>
>> TEST: tests/prom-env-test... (pid=13573)
>>   /sparc64/prom-env/sun4u:                                             **
>> ERROR:/home/pm215/qemu/translate-common.c:34:tcg_handle_interrupt:
>> assertion failed: (qemu_mutex_iothread_locked())
>> Broken pipe
>> FAIL
>> GTester: last random seed: R02Sa5fa983185fe5e65cfb5b7fcb39ed3d1
>> (pid=13579)
>> FAIL: tests/prom-env-test
>>
>> This is with commit 9514f2648ca05b3.
>>
>> It didn't reproduce on a rerun of 'make check' and it didn't
>> look like the merge in question was particularly relevant to
>> the failure, so I went ahead and pushed it to master.
>>
>> I'm (perhaps unfairly) assuming that this is fallout from MTTCG
>> landing. (prom-env-test is one of the handful of tests in
>> 'make check' that actually runs TCG code.)
> 
> Maybe worth mentioning that the prom-env test for sparc64 has just been
> enabled a couple of commits ago (6b591ad613010f13). There was an issue
> with that test for the sparc64 target last year, but IIRC it only
> affected 32-bit hosts and has been fixed, so I think/hope this is a
> different issue now...

OK, I think this is definitively not related to the prom-env test, but
to MTTCG (or something else in TCG): I can reproduce this problem
reliably when I run QEMU in s390 mode with the Moon Buggy disk image
from the QEMU advent calendar
(http://www.qemu-advent-calendar.org/2014/download/s390-moon-buggy.tar.xz):

qemu-system-s390x -nographic -kernel s390-bb.kernel \
                  -initrd s390-moon-buggy.initrd

... starts the kernel, but aborts very soon with:

ERROR:qemu/translate-common.c:34:tcg_handle_interrupt: assertion failed:
(qemu_mutex_iothread_locked())
Aborted (core dumped)

 Thomas
