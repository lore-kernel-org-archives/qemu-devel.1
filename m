Received: from eggs.gnu.org ([2001:4830:134:3::10]:47093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ewpAZ-0003DD-Qg
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 09:13:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ewpAU-0005Lf-3e
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 09:13:15 -0400
Received: from mail-oi0-x233.google.com ([2607:f8b0:4003:c06::233]:37776)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ewpAT-0005LI-Sa
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 09:13:09 -0400
Received: by mail-oi0-x233.google.com with SMTP id f186so8561117oig.4
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 06:13:09 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Mar 2018 13:12:48 +0000
Message-ID: <CAFEAcA-6vww4nUWmq1je1xq1HsAcQ08+AD_kccOCPjLTQjG7xw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] tpm-tis-test and tpm-crb-test crash on OSX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>, "Daniel P. Berrange" <berrange@redhat.com>

On OSX host, I noticed that tpm-tis-test and tpm-crb-test
both crash on OSX, hitting an error_abort case:

(lldb) run
Process 65115 launched:
'/Users/pm215/src/qemu-for-merges/build/all/tests/tpm-tis-test'
(x86_64)
/i386/tpm-tis/test_check_localities: OK
/i386/tpm-tis/test_check_access_reg: OK
/i386/tpm-tis/test_check_access_reg_seize: OK
/i386/tpm-tis/test_check_access_reg_release: OK
/i386/tpm-tis/test_check_transmit: OK
Unexpected error in qio_channel_socket_readv() at
/Users/pm215/src/qemu-for-merges/io/channel-socket.c:494:
Unable to read from socket: Bad file descriptor

Here's a backtrace from tpm-tis-test:

* thread #2: tid = 0xb504cf, 0x00007fff7eb96e3e
libsystem_kernel.dylib`__pthread_kill + 10, stop reason = signal
SIGABRT
  * frame #0: 0x00007fff7eb96e3e libsystem_kernel.dylib`__pthread_kill + 10
    frame #1: 0x00007fff7ecd5150 libsystem_pthread.dylib`pthread_kill + 333
    frame #2: 0x00007fff7eaf3312 libsystem_c.dylib`abort + 127
    frame #3: 0x0000000100043431 tpm-tis-test`error_setv [inlined]
error_handle_fatal(errp=<unavailable>) + 43 at error.c:38
    frame #4: 0x0000000100043406
tpm-tis-test`error_setv(errp=<unavailable>, src=<unavailable>,
line=<unavailable>, func=<unavailable>,
err_class=ERROR_CLASS_GENERIC_ERROR, fmt=<unavailable>,
ap=<unavailable>, suffix=<unavailable>) + 246 at error.c:71
    frame #5: 0x00000001000435db
tpm-tis-test`error_setg_errno_internal(errp=0x000000010006c930,
src="/Users/pm215/src/qemu-for-merges/io/channel-socket.c", line=494,
func="qio_channel_socket_readv", os_errno=<unavailable>, fmt="Unable
to read from socket") + 219 at error.c:111
    frame #6: 0x0000000100007ba5
tpm-tis-test`qio_channel_socket_readv(ioc=<unavailable>,
iov=<unavailable>, niov=<unavailable>, fds=0x0000000000000000,
nfds=0x0000000000000000, errp=0x000000010006c930) + 341 at
channel-socket.c:493
    frame #7: 0x0000000100004717 tpm-tis-test`qio_channel_read
[inlined] qio_channel_readv_full(ioc=0x0000000100501f80,
iov=<unavailable>, niov=1, fds=<unavailable>, nfds=<unavailable>,
errp=0x000000010006c930) + 62 at channel.c:65
    frame #8: 0x00000001000046d9
tpm-tis-test`qio_channel_read(ioc=0x0000000100501f80,
buf=<unavailable>, buflen=<unavailable>, errp=<unavailable>) + 41 at
channel.c:216
    frame #9: 0x0000000100003dd1
tpm-tis-test`tpm_emu_tpm_thread(data=0x00007ffeefbff0e8) + 241 at
tpm-emu.c:41
    frame #10: 0x00000001001b2ec0
libglib-2.0.0.dylib`g_thread_create_proxy + 191
    frame #11: 0x00007fff7ecd26c1 libsystem_pthread.dylib`_pthread_body + 340
    frame #12: 0x00007fff7ecd256d libsystem_pthread.dylib`_pthread_start + 377
    frame #13: 0x00007fff7ecd1c5d libsystem_pthread.dylib`thread_start + 13

Slightly alarmingly, this doesn't result in 'make check' failing.
I think this is because the error only happens in the test's cleanup,
after all its test cases have reported a pass to the test runner.

thanks
-- PMM
