Received: from eggs.gnu.org ([209.51.188.92]:41841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gkYqp-0003Hm-H6
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 13:26:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gkYqn-0007m7-MQ
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 13:26:43 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40409)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gkYqn-0007eq-Fr
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 13:26:41 -0500
Received: by mail-wr1-f68.google.com with SMTP id p4so16223166wrt.7
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 10:26:36 -0800 (PST)
References: <1547732292-14021-1-git-send-email-thuth@redhat.com>
	<CAFEAcA-q4T4B+rxZj+734W6K5R5jHB0AW2rFKDQKgwB_oacmVw@mail.gmail.com>
	<CAFEAcA-xfLEEW6qrcoHPsyxt1QGMwJ7ez_TKTTpUX1LA6zDFOw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <408291c7-e4ba-d9a4-bfd6-cd27aebb7354@redhat.com>
Date: Fri, 18 Jan 2019 19:26:33 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-xfLEEW6qrcoHPsyxt1QGMwJ7ez_TKTTpUX1LA6zDFOw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL v3 00/28] ivshmem deprecation, qtests,
 typedefs and gnu99
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Li Qiang <liq3ea@163.com>, Greg Kurz <groug@kaod.org>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 1/18/19 3:20 PM, Peter Maydell wrote:
> On Fri, 18 Jan 2019 at 11:47, Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> On Thu, 17 Jan 2019 at 13:38, Thomas Huth <thuth@redhat.com> wrote:
>>>
>>>  Hi Peter!
>>>
>>> The following changes since commit 6f2f34177a25bffd6fd92a05e6e66c8d22d97094:
>>>
>>>   Merge remote-tracking branch 'remotes/thibault/tags/samuel-thibault' into staging (2019-01-15 18:32:57 +0000)
>>>
>>> are available in the git repository at:
>>>
>>>   https://gitlab.com/huth/qemu.git tags/pull-request-2019-01-17
>>>
>>> for you to fetch changes up to 3f0832c85380321ef697d64342b389648f8abb1c:
>>>
>>>   tests/hexloader-test: Don't pass -nographic to the QEMU under test (2019-01-17 14:25:12 +0100)
>>>
>>> ----------------------------------------------------------------
>>> - Remove deprecated "ivshmem" legacy device
>>> - Bug fix for vhost-user-test
>>> - Use more CONFIG Makefile switches for qtests
>>> - Get rid of global_qtests in some more qtests
>>> - typedef cleanups
>>> - Fixes for compiling with Clang
>>> - Force C standard to gnu99
>>> ----------------------------------------------------------------
>>
>> In the netbsd VM, the ipmi-bt-test is consistently failing:
>>
>> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
>> QTEST_QEMU_BINARY=i386-softmmu
>> /qemu-system-i386 QTEST_QEMU_IMG=qemu-img tests/ipmi-bt-test -m=quick
>> -k --tap < /dev/null | ./s
>> cripts/tap-driver.pl --test-name="ipmi-bt-test"
>> **
>> ERROR:tests/ipmi-bt-test.c:319:test_connect: assertion failed: (rv == 1)
>> ERROR - too few tests run (expected 4, got 0)
>> [1]   Abort trap (core dumped) MALLOC_PERTURB_=... |
>>       Done(1)                 ./scripts/tap-dr...
>> /var/tmp/qemu-test.7opHvo/tests/Makefile.include:856: recipe for
>> target 'check-qtest-i386' faile
>> d
>> gmake: *** [check-qtest-i386] Error 1
>> gmake: *** Waiting for unfinished jobs....
>>
>>
>> This has been kind of intermittent for a while, I've seen
>> it on-and-off, but with this pullreq it's failed four times
>> in a row, so maybe something in here is making it less
>> intermittent.
> 
> I tried the "raise the timeout" change you suggested on IRC.
> That gave me a pass the first time around but the same failure
> second time I tried it:
> 
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> QTEST_QEMU_BINARY=i386-softmmu/qemu-system-i386
> QTEST_QEMU_IMG=qemu-img tests/ipmi-bt-test -m=quick -k --tap <
> /dev/null | ./scripts/tap-driver.pl --test-name="ipmi-bt-test"
> **
> ERROR:tests/ipmi-bt-test.c:319:test_connect: assertion failed: (rv == 1)
> ERROR - too few tests run (expected 4, got 0)
> [1]   Abort trap (core dumped) MALLOC_PERTURB_=... |
>       Done(1)                 ./scripts/tap-dr...
> /var/tmp/qemu-test.TATvqX/tests/Makefile.include:856: recipe for
> target 'check-qtest-i386' failed

I guess I finally figured it out, the test binds IPv4 and on the NetBSD
VM, 'localhost' resolves as IPv6 so the guest can't connect to the test.

I'm not sure what's the best way to fix this (yet), meanwhile the tests
succeed using:

-- >8 --
     global_qtest = qtest_initf(
-        " -chardev socket,id=ipmi0,host=localhost,port=%d,reconnect=10"
+        " -chardev socket,id=ipmi0,host=127.0.0.1,port=%d,reconnect=10"
         " -device ipmi-bmc-extern,chardev=ipmi0,id=bmc0"
---

Regards,

Phil.
