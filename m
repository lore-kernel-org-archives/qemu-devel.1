Received: from eggs.gnu.org ([2001:4830:134:3::10]:47238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1duJKb-0007Sg-4G
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:17:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1duJKR-00076L-LA
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:16:57 -0400
Received: from mail-wr0-f178.google.com ([209.85.128.178]:57190)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1duJKR-000752-EZ
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:16:47 -0400
Received: by mail-wr0-f178.google.com with SMTP id r74so110585wrb.13
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 07:16:47 -0700 (PDT)
References: <20170919124440.30017-1-pbonzini@redhat.com>
	<CAFEAcA-PffxsdgohV3nO=bPW+ACVEAAExZoCha5eDiaR2w5O1Q@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <32e9b1dc-7f3e-93c9-ec17-6d744ffc8401@redhat.com>
Date: Tue, 19 Sep 2017 16:16:43 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-PffxsdgohV3nO=bPW+ACVEAAExZoCha5eDiaR2w5O1Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL v2 00/50] Misc patches for 2017-09-19
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

On 19/09/2017 15:47, Peter Maydell wrote:
>   LINK    tests/ptimer-test
> duplicate symbol _qemu_bh_delete in:
>     tests/ptimer-test-stubs.o
>     libqemuutil.a(async.o)
> duplicate symbol _qemu_clock_get_ns in:
>     tests/ptimer-test-stubs.o
>     libqemuutil.a(qemu-timer.o)
> duplicate symbol _timer_init_tl in:
>     tests/ptimer-test-stubs.o
>     libqemuutil.a(qemu-timer.o)
> duplicate symbol _qemu_clock_deadline_ns_all in:
>     tests/ptimer-test-stubs.o
>     libqemuutil.a(qemu-timer.o)
> duplicate symbol _timer_del in:
>     tests/ptimer-test-stubs.o
>     libqemuutil.a(qemu-timer.o)
> duplicate symbol _main_loop_tlg in:
>     tests/ptimer-test-stubs.o
>     libqemuutil.a(qemu-timer.o)
> duplicate symbol _timer_mod in:
>     tests/ptimer-test-stubs.o
>     libqemuutil.a(qemu-timer.o)
> duplicate symbol _qemu_bh_new in:
>     tests/ptimer-test-stubs.o
>     libqemuutil.a(main-loop.o)
> ld: 8 duplicate symbols for architecture x86_64
> clang: error: linker command failed with exit code 1 (use -v to see invocation)

What the patches changes is essentially

-tests/ptimer-test$(EXESUF): tests/ptimer-test.o tests/ptimer-test-stubs.o hw/core/ptimer.o libqemustub.a
+	libqemuutil.a
+tests/ptimer-test$(EXESUF): tests/ptimer-test.o tests/ptimer-test-stubs.o hw/core/ptimer.o libqemuutil.a

so I think what happens is that OS X was previously favoring a file from
libqemustub.a, while now it favors a file from libqemuutil.a, which brings
in async.o and main-loop.o.

Luckily it is pretty easy to drop libqemuutil.a from this test, which makes
sense since it provides its own mock timer subsystem:

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 0c644626e8..baa10e362d 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -618,7 +618,7 @@ tests/test-vmstate$(EXESUF): tests/test-vmstate.o \
 tests/test-timed-average$(EXESUF): tests/test-timed-average.o $(test-util-obj-y)
 tests/test-base64$(EXESUF): tests/test-base64.o \
 	libqemuutil.a
-tests/ptimer-test$(EXESUF): tests/ptimer-test.o tests/ptimer-test-stubs.o hw/core/ptimer.o $(test-util-obj-y)
+tests/ptimer-test$(EXESUF): tests/ptimer-test.o tests/ptimer-test-stubs.o hw/core/ptimer.o
 
 tests/test-logging$(EXESUF): tests/test-logging.o $(test-util-obj-y)
 
diff --git a/tests/ptimer-test-stubs.c b/tests/ptimer-test-stubs.c
index 8a1b0a336c..ca5cc3b13b 100644
--- a/tests/ptimer-test-stubs.c
+++ b/tests/ptimer-test-stubs.c
@@ -30,6 +30,10 @@ QEMUTimerListGroup main_loop_tlg;
 
 int64_t ptimer_test_time_ns;
 
+/* Do not artificially limit period - see hw/core/ptimer.c.  */
+int use_icount = 1;
+bool qtest_allowed;
+
 void timer_init_tl(QEMUTimer *ts,
                    QEMUTimerList *timer_list, int scale,
                    QEMUTimerCB *cb, void *opaque)

Paolo

> (I'll leave the rest of the merge tests running to see if they
> find anything else.)
