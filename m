Received: from eggs.gnu.org ([2001:4830:134:3::10]:49443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ewpP1-0007RW-72
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 09:28:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ewpOy-0003vI-0o
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 09:28:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36236 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ewpOx-0003v4-QV
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 09:28:07 -0400
Date: Fri, 16 Mar 2018 13:27:54 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180316132754.GJ3066@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <CAFEAcA-6vww4nUWmq1je1xq1HsAcQ08+AD_kccOCPjLTQjG7xw@mail.gmail.com>
	<CAFEAcA_M5rD_mrkEPwyyaNah=YJvn8QSKiWs6ExKVynB0Whc-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA_M5rD_mrkEPwyyaNah=YJvn8QSKiWs6ExKVynB0Whc-Q@mail.gmail.com>
Subject: Re: [Qemu-devel] tpm-tis-test and tpm-crb-test crash on OSX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Berger <stefanb@linux.vnet.ibm.com>

On Fri, Mar 16, 2018 at 01:24:53PM +0000, Peter Maydell wrote:
> On 16 March 2018 at 13:12, Peter Maydell <peter.maydell@linaro.org> wrote:
> > On OSX host, I noticed that tpm-tis-test and tpm-crb-test
> > both crash on OSX, hitting an error_abort case:
> >
> > (lldb) run
> > Process 65115 launched:
> > '/Users/pm215/src/qemu-for-merges/build/all/tests/tpm-tis-test'
> > (x86_64)
> > /i386/tpm-tis/test_check_localities: OK
> > /i386/tpm-tis/test_check_access_reg: OK
> > /i386/tpm-tis/test_check_access_reg_seize: OK
> > /i386/tpm-tis/test_check_access_reg_release: OK
> > /i386/tpm-tis/test_check_transmit: OK
> > Unexpected error in qio_channel_socket_readv() at
> > /Users/pm215/src/qemu-for-merges/io/channel-socket.c:494:
> > Unable to read from socket: Bad file descriptor
> >
> > Here's a backtrace from tpm-tis-test:
> 
> Dan suggested a race condition, which prompted me to get an
> all-threads backtrace:
> 
>   thread #1: tid = 0xb50f19, 0x00007fff7eb97502
> libsystem_kernel.dylib`__wait4 + 10, queue = 'com.apple.main-thread'
>     frame #0: 0x00007fff7eb97502 libsystem_kernel.dylib`__wait4 + 10
>     frame #1: 0x000000010001b303 tpm-tis-test`qtest_quit [inlined]
> kill_qemu(s=<unavailable>) + 99 at libqtest.c:107
>     frame #2: 0x000000010001b2df
> tpm-tis-test`qtest_quit(s=0x0000000100404c60) + 63 at libqtest.c:280
>     frame #3: 0x0000000100001bd1 tpm-tis-test`main [inlined] qtest_end
> + 9 at libqtest.h:555
>     frame #4: 0x0000000100001bc8 tpm-tis-test`main(argc=<unavailable>,
> argv=<unavailable>) + 520 at tpm-tis-test.c:477
>     frame #5: 0x00007fff7ea47115 libdyld.dylib`start + 1
>     frame #6: 0x00007fff7ea47115 libdyld.dylib`start + 1
> 
>   thread #3: tid = 0xb50f4a, 0x00007fff7eb977d2
> libsystem_kernel.dylib`close + 10
>     frame #0: 0x00007fff7eb977d2 libsystem_kernel.dylib`close + 10
>     frame #1: 0x0000000100007def
> tpm-tis-test`qio_channel_socket_close(ioc=<unavailable>,
> errp=0x000000010006c930) + 63 at channel-socket.c:693
>     frame #2: 0x00000001000039f9
> tpm-tis-test`tpm_emu_ctrl_thread(data=0x00007ffeefbff0e8) + 713 at
> tpm-emu.c:128
>     frame #3: 0x00000001001b2ec0 libglib-2.0.0.dylib`g_thread_create_proxy + 191
>     frame #4: 0x00007fff7ecd26c1 libsystem_pthread.dylib`_pthread_body + 340
>     frame #5: 0x00007fff7ecd256d libsystem_pthread.dylib`_pthread_start + 377
>     frame #6: 0x00007fff7ecd1c5d libsystem_pthread.dylib`thread_start + 13
> 
> * thread #2: tid = 0xb50f50, 0x00007fff7eb96e3e
> libsystem_kernel.dylib`__pthread_kill + 10
>   * frame #0: 0x00007fff7eb96e3e libsystem_kernel.dylib`__pthread_kill + 10
>     frame #1: 0x00007fff7ecd5150 libsystem_pthread.dylib`pthread_kill + 333
>     frame #2: 0x00007fff7eaf3312 libsystem_c.dylib`abort + 127
>     frame #3: 0x0000000100043431 tpm-tis-test`error_setv [inlined]
> error_handle_fatal(errp=<unavailable>) + 43 at error.c:38
>     frame #4: 0x0000000100043406
> tpm-tis-test`error_setv(errp=<unavailable>, src=<unavailable>,
> line=<unavailable>, func=<unavailable>,
> err_class=ERROR_CLASS_GENERIC_ERROR, fmt=<unavailable>,
> ap=<unavailable>, suffix=<unavailable>) + 246 at error.c:71
>     frame #5: 0x00000001000435db
> tpm-tis-test`error_setg_errno_internal(errp=0x000000010006c930,
> src="/Users/pm215/src/qemu-for-merges/io/channel-socket.c", line=494,
> func="qio_channel_socket_readv", os_errno=<unavailable>, fmt="Unable
> to read from socket") + 219 at error.c:111
>     frame #6: 0x0000000100007ba5
> tpm-tis-test`qio_channel_socket_readv(ioc=<unavailable>,
> iov=<unavailable>, niov=<unavailable>, fds=0x0000000000000000,
> nfds=0x0000000000000000, errp=0x000000010006c930) + 341 at
> channel-socket.c:493
>     frame #7: 0x0000000100004717 tpm-tis-test`qio_channel_read
> [inlined] qio_channel_readv_full(ioc=0x00000001007006b0,
> iov=<unavailable>, niov=1, fds=<unavailable>, nfds=<unavailable>,
> errp=0x000000010006c930) + 62 at channel.c:65
>     frame #8: 0x00000001000046d9
> tpm-tis-test`qio_channel_read(ioc=0x00000001007006b0,
> buf=<unavailable>, buflen=<unavailable>, errp=<unavailable>) + 41 at
> channel.c:216
>     frame #9: 0x0000000100003dd1
> tpm-tis-test`tpm_emu_tpm_thread(data=0x00007ffeefbff0e8) + 241 at
> tpm-emu.c:41
>     frame #10: 0x00000001001b2ec0
> libglib-2.0.0.dylib`g_thread_create_proxy + 191
>     frame #11: 0x00007fff7ecd26c1 libsystem_pthread.dylib`_pthread_body + 340
>     frame #12: 0x00007fff7ecd256d libsystem_pthread.dylib`_pthread_start + 377
>     frame #13: 0x00007fff7ecd1c5d libsystem_pthread.dylib`thread_start + 13
> 
> 
> My guess is that the problem here is that the tpm_emu_ctrl_thread (thread 3) is
> forcibly closing the channel, which causes the tpm_emu_thread (thread 2)
> to abort because its read returned an error.

At least the tpm_emu_tpm_thread() there is only something in the test
suite, so the real system emulator code isn't at risk of crashing.

Feels like the thread simply should *not* use error_abort, and instead
have a more graceful way to exit when the socket closes

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
