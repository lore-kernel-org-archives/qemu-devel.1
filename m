Received: from eggs.gnu.org ([2001:4830:134:3::10]:60560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cj946-0001ik-8c
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 13:33:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cj943-0002LF-2O
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 13:33:30 -0500
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:37213)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cj942-0002Kr-R8
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 13:33:27 -0500
Received: by mail-wm0-x231.google.com with SMTP id n11so6420818wma.0
	for <qemu-devel@nongnu.org>; Wed, 01 Mar 2017 10:33:26 -0800 (PST)
References: <CAFEAcA_KVG19uhPuBUNx4ySmebnL1Hit6=HUX9ug0FkBFMwasg@mail.gmail.com>
	<877f492ppx.fsf@linaro.org>
	<e28337d0-d572-cd9a-3f45-0ecc074c32c9@ilande.co.uk>
	<874lzd2mp7.fsf@linaro.org>
	<9efa47c0-2a5f-0229-7e27-97a0142ff22d@ilande.co.uk>
	<871suh2ff3.fsf@linaro.org>
	<99624def-1c99-48f9-2ad3-c93e21956dd6@ilande.co.uk>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <99624def-1c99-48f9-2ad3-c93e21956dd6@ilande.co.uk>
Date: Wed, 01 Mar 2017 18:33:26 +0000
Message-ID: <87zih426fd.fsf@linaro.org>
MIME-Version: 1.0
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
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>


Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> writes:

> On 01/03/17 15:19, Alex Bennée wrote:
>
>> Actually looking at where cpu_check_irq is I've pushed the BQL wraps
>> higher up:
>>
>>   https://github.com/stsquad/qemu/commit/f52e01bf4d3415ce4fad54cbb491f6c30a8e1903
>>
>> The reasoning is HW emulation code can expect to be run under the BQL.
>> Anything triggered by MMIO for example will automatically have the lock.
>> The problem is helpers which trigger hardware actions (ARM has ARM_CP_IO
>> for this). We talk about this in the design document:
>>
>>   http://git.qemu-project.org/?p=qemu.git;a=blob;f=docs/multi-thread-tcg.txt;h=a99b4564c6258576acfa141f51f4b80131969519;hb=HEAD#l201
>>
>>> I ran out of time yesterday to run through all my SPARC64 tests, however
>>> if this is the case then the issue will definitely appear in
>>> qemu-system-sparc64 which seems to be supported by people seeing
>>> intermittent failures in prom-env-test.
>>
>> So I made the change to both sparc and sparc64 in the above commit.
>>
>> I haven't managed to run into the intermittent trigger yet. How do I run
>> the test directly?
>>
>>   make tests/prom-env-test
>>
>> Just makes the test case and
>>
>>   ./tests/prom-env-test
>> **
>> ERROR:tests/libqtest.c:589:qtest_get_arch: assertion failed: (qemu != NULL)
>> Aborted (core dumped)
>
> Yeah, I couldn't work out how to run a single test either so ended up
> cycling through a complete set of "make check" runs in order to try and
> provoke the assert(), and despite all this I was still unable to
> reproduce the "make check" error locally.
>
> Fortunately with the debian-40r4a-sparc-netinst.iso I was able to
> reproduce it fairly easily under qemu-system-sparc so I'd suggest that
> you go that route. If you can't find anywhere that hosts that particular
> image for testing, do contact me off-list and I'll temporarily upload it
> somewhere for you.

It's OK I reproduced with the current etch iso. I have a patch in my
tree that seems to work. I'll post once I've checked for any other
places that need it.

--
Alex Bennée
