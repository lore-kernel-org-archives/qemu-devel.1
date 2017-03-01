Received: from eggs.gnu.org ([2001:4830:134:3::10]:49799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1cj6yo-0007EG-D6
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 11:19:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1cj6yl-00077Z-Nx
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 11:19:54 -0500
Received: from chuckie.co.uk ([82.165.15.123]:46327
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1cj6yl-00076p-Fz
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 11:19:51 -0500
References: <CAFEAcA_KVG19uhPuBUNx4ySmebnL1Hit6=HUX9ug0FkBFMwasg@mail.gmail.com>
	<877f492ppx.fsf@linaro.org>
	<e28337d0-d572-cd9a-3f45-0ecc074c32c9@ilande.co.uk>
	<874lzd2mp7.fsf@linaro.org>
	<9efa47c0-2a5f-0229-7e27-97a0142ff22d@ilande.co.uk>
	<871suh2ff3.fsf@linaro.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <99624def-1c99-48f9-2ad3-c93e21956dd6@ilande.co.uk>
Date: Wed, 1 Mar 2017 16:19:34 +0000
MIME-Version: 1.0
In-Reply-To: <871suh2ff3.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
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
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On 01/03/17 15:19, Alex Bennée wrote:

> Actually looking at where cpu_check_irq is I've pushed the BQL wraps
> higher up:
> 
>   https://github.com/stsquad/qemu/commit/f52e01bf4d3415ce4fad54cbb491f6c30a8e1903
> 
> The reasoning is HW emulation code can expect to be run under the BQL.
> Anything triggered by MMIO for example will automatically have the lock.
> The problem is helpers which trigger hardware actions (ARM has ARM_CP_IO
> for this). We talk about this in the design document:
> 
>   http://git.qemu-project.org/?p=qemu.git;a=blob;f=docs/multi-thread-tcg.txt;h=a99b4564c6258576acfa141f51f4b80131969519;hb=HEAD#l201
> 
>> I ran out of time yesterday to run through all my SPARC64 tests, however
>> if this is the case then the issue will definitely appear in
>> qemu-system-sparc64 which seems to be supported by people seeing
>> intermittent failures in prom-env-test.
> 
> So I made the change to both sparc and sparc64 in the above commit.
> 
> I haven't managed to run into the intermittent trigger yet. How do I run
> the test directly?
> 
>   make tests/prom-env-test
> 
> Just makes the test case and
> 
>   ./tests/prom-env-test
> **
> ERROR:tests/libqtest.c:589:qtest_get_arch: assertion failed: (qemu != NULL)
> Aborted (core dumped)

Yeah, I couldn't work out how to run a single test either so ended up
cycling through a complete set of "make check" runs in order to try and
provoke the assert(), and despite all this I was still unable to
reproduce the "make check" error locally.

Fortunately with the debian-40r4a-sparc-netinst.iso I was able to
reproduce it fairly easily under qemu-system-sparc so I'd suggest that
you go that route. If you can't find anywhere that hosts that particular
image for testing, do contact me off-list and I'll temporarily upload it
somewhere for you.


ATB,

Mark.
