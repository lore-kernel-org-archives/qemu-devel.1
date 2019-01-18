Received: from eggs.gnu.org ([209.51.188.92]:41512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gkTze-0004XZ-1m
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 08:15:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gkTzR-0006Xt-O0
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 08:15:21 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39864)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gkTzR-0006PO-2H
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 08:15:17 -0500
Received: by mail-wm1-f66.google.com with SMTP id y8so4446887wmi.4
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 05:15:09 -0800 (PST)
References: <1547732292-14021-1-git-send-email-thuth@redhat.com>
	<CAFEAcA-q4T4B+rxZj+734W6K5R5jHB0AW2rFKDQKgwB_oacmVw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <adf15088-93e0-8cf5-988b-067afe39f6e1@redhat.com>
Date: Fri, 18 Jan 2019 14:15:06 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-q4T4B+rxZj+734W6K5R5jHB0AW2rFKDQKgwB_oacmVw@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Corey Minyard <cminyard@mvista.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Li Qiang <liq3ea@163.com>, Greg Kurz <groug@kaod.org>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 1/18/19 12:47 PM, Peter Maydell wrote:
> On Thu, 17 Jan 2019 at 13:38, Thomas Huth <thuth@redhat.com> wrote:
>>
>>  Hi Peter!
>>
>> The following changes since commit 6f2f34177a25bffd6fd92a05e6e66c8d22d97094:
>>
>>   Merge remote-tracking branch 'remotes/thibault/tags/samuel-thibault' into staging (2019-01-15 18:32:57 +0000)
>>
>> are available in the git repository at:
>>
>>   https://gitlab.com/huth/qemu.git tags/pull-request-2019-01-17
>>
>> for you to fetch changes up to 3f0832c85380321ef697d64342b389648f8abb1c:
>>
>>   tests/hexloader-test: Don't pass -nographic to the QEMU under test (2019-01-17 14:25:12 +0100)
>>
>> ----------------------------------------------------------------
>> - Remove deprecated "ivshmem" legacy device
>> - Bug fix for vhost-user-test
>> - Use more CONFIG Makefile switches for qtests
>> - Get rid of global_qtests in some more qtests
>> - typedef cleanups
>> - Fixes for compiling with Clang
>> - Force C standard to gnu99
>> ----------------------------------------------------------------
> 
> In the netbsd VM, the ipmi-bt-test is consistently failing:
> 
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> QTEST_QEMU_BINARY=i386-softmmu
> /qemu-system-i386 QTEST_QEMU_IMG=qemu-img tests/ipmi-bt-test -m=quick
> -k --tap < /dev/null | ./s
> cripts/tap-driver.pl --test-name="ipmi-bt-test"
> **
> ERROR:tests/ipmi-bt-test.c:319:test_connect: assertion failed: (rv == 1)
> ERROR - too few tests run (expected 4, got 0)
> [1]   Abort trap (core dumped) MALLOC_PERTURB_=... |
>       Done(1)                 ./scripts/tap-dr...
> /var/tmp/qemu-test.7opHvo/tests/Makefile.include:856: recipe for
> target 'check-qtest-i386' faile
> d
> gmake: *** [check-qtest-i386] Error 1
> gmake: *** Waiting for unfinished jobs....
> 
> 
> This has been kind of intermittent for a while, I've seen
> it on-and-off, but with this pullreq it's failed four times
> in a row, so maybe something in here is making it less
> intermittent.

This file does:

    qtest_add_func("/ipmi/extern/connect", test_connect);
    qtest_add_func("/ipmi/extern/bt_base", test_bt_base);
    qtest_add_func("/ipmi/extern/bt_enable_irq", test_enable_irq);
    qtest_add_func("/ipmi/extern/bt_base_irq", test_bt_base);
    ret = g_test_run();

The first "test" test_connect() binds emu_lfd, the 2nd test
test_bt_base() calls bt_cmd() which also use emu_lfd... could it be unbound?
This is racy, since (from g_test_run() doc):

"In general, the tests and sub-suites within each suite are run in the
order in which they are defined. [...]
However, you should never make the actual result of a test depend on the
order that tests are run in. If you need to ensure that some particular
code runs before or after a given test case, use g_test_add(), which
lets you specify setup and teardown functions."
