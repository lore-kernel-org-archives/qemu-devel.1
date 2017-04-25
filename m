Received: from eggs.gnu.org ([2001:4830:134:3::10]:49442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d32S8-0005Ek-QM
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 11:32:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d32S4-0005P4-2C
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 11:32:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34290)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1d32S3-0005Oh-PK
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 11:32:27 -0400
Date: Tue, 25 Apr 2017 16:32:22 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170425153222.GH2103@work-vm>
References: <20170425104116.31435-1-dgilbert@redhat.com>
	<CAFEAcA8yQXV3414cv72Nq7HVoXTgjR40HQWGFzK_+T_=h_Bykw@mail.gmail.com>
	<726c98c5-7e63-417a-ea48-ae2737d50cdc@redhat.com>
	<CAFEAcA_y+HBkFxs5bFavptvB96AfL3F+A33fyuaWc+-Cd3QuOA@mail.gmail.com>
	<CAFEAcA-nsC-sFLTqDB1VscH5GajQw65Jq2RN8Y9TAoLE=aL65A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-nsC-sFLTqDB1VscH5GajQw65Jq2RN8Y9TAoLE=aL65A@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 0/4] hmp queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

* Peter Maydell (peter.maydell@linaro.org) wrote:
> On 25 April 2017 at 16:05, Peter Maydell <peter.maydell@linaro.org> wrote:
> >         info jit
> > qemu: qemu_mutex_lock: Invalid argument
> 
> Repro without the qtest machinery:
> 
> $ lldb -- ./aarch64-softmmu/qemu-system-aarch64 -M n810 -s -S -monitor
> stdio -machine accel=qtest
> 
> then run and type 'info jit' at the monitor prompt.
> Backtrace:
> 
> * thread #1: tid = 0x66a715, 0x00007fffd1931d42
> libsystem_kernel.dylib`__pthread_kill + 10, queue =
> 'com.apple.main-thread', stop reason = signal SIGABRT
>   * frame #0: 0x00007fffd1931d42 libsystem_kernel.dylib`__pthread_kill + 10
>     frame #1: 0x00007fffd1a1f5bf libsystem_pthread.dylib`pthread_kill + 90
>     frame #2: 0x00007fffd1897420 libsystem_c.dylib`abort + 129
>     frame #3: 0x000000010041bd05
> qemu-system-aarch64`error_exit(err=<unavailable>, msg=<unavailable>) +
> 53 at qemu-thread-posix.c:35
>     frame #4: 0x000000010041bd4d
> qemu-system-aarch64`qemu_mutex_lock(mutex=<unavailable>) + 29 at
> qemu-thread-posix.c:62
>     frame #5: 0x0000000100010c7c qemu-system-aarch64`dump_exec_info
> [inlined] tb_lock + 12 at translate-all.c:167
>     frame #6: 0x0000000100010c70
> qemu-system-aarch64`dump_exec_info(f=0x00000001020b6a10,
> cpu_fprintf=(qemu-system-aarch64`monitor_fprintf at monitor.c:376)) +
> 48 at translate-all.c:1869
>     frame #7: 0x0000000100048ec9

OK, that looks like a real bug to me, in the KVM case it should fail
the same way; if I understand correctly the tb_lock only gets init'd
during code_gen_alloc called from tcg_init.

'info jit' needs fixing.

Dave

> qemu-system-aarch64`hmp_info_jit(mon=0x00000001020b6a10,
> qdict=<unavailable>) + 25 at monitor.c:1089
>     frame #8: 0x0000000100043ae5
> qemu-system-aarch64`handle_hmp_command(mon=0x00000001020b6a10,
> cmdline=<unavailable>) + 3589 at monitor.c:3104
>     frame #9: 0x000000010004262e
> qemu-system-aarch64`monitor_command_cb(opaque=0x00000001020b6a10,
> cmdline=<unavailable>, readline_opaque=<unavailable>) + 30 at
> monitor.c:3902
>     frame #10: 0x000000010042d355
> qemu-system-aarch64`readline_handle_byte(rs=0x00000001028f4400,
> ch=<unavailable>) + 3285 at readline.c:393
>     frame #11: 0x0000000100046adc
> qemu-system-aarch64`monitor_read(opaque=<unavailable>, buf="\n",
> size=1) + 60 at monitor.c:3885
>     frame #12: 0x00000001003c3cd3
> qemu-system-aarch64`fd_chr_read(chan=<unavailable>,
> cond=<unavailable>, opaque=<unavailable>) + 179 at char-fd.c:66
>     frame #13: 0x00000001010b60bd
> libglib-2.0.0.dylib`g_main_context_dispatch + 460
>     frame #14: 0x00000001004193a1 qemu-system-aarch64`main_loop_wait
> [inlined] glib_pollfds_poll + 545 at main-loop.c:213
>     frame #15: 0x0000000100419364 qemu-system-aarch64`main_loop_wait
> [inlined] os_host_main_loop_wait(timeout=<unavailable>) + 67 at
> main-loop.c:261
>     frame #16: 0x0000000100419321
> qemu-system-aarch64`main_loop_wait(nonblocking=<unavailable>) + 417 at
> main-loop.c:517
>     frame #17: 0x000000010019a74f qemu-system-aarch64`qemu_main
> [inlined] main_loop + 48 at vl.c:1898
>     frame #18: 0x000000010019a71f
> qemu-system-aarch64`qemu_main(argc=<unavailable>, argv=<unavailable>,
> envp=<unavailable>) + 18623 at vl.c:4709
>     frame #19: 0x000000010033d4ce
> qemu-system-aarch64`-[QemuCocoaAppController
> startEmulationWithArgc:argv:](self=<unavailable>, _cmd=<unavailable>,
> argc=<unavailable>, argv=<unavailable>) + 30 at cocoa.m:978
>     frame #20: 0x00007fffbbb0252c
> CoreFoundation`__CFNOTIFICATIONCENTER_IS_CALLING_OUT_TO_AN_OBSERVER__
> + 12
>     frame #21: 0x00007fffbbb0242b CoreFoundation`_CFXRegistrationPost + 427
>     frame #22: 0x00007fffbbb02192
> CoreFoundation`___CFXNotificationPost_block_invoke + 50
>     frame #23: 0x00007fffbbac0772
> CoreFoundation`-[_CFXNotificationRegistrar
> find:object:observer:enumerator:] + 2018
>     frame #24: 0x00007fffbbabf75b CoreFoundation`_CFXNotificationPost + 667
>     frame #25: 0x00007fffbd500997 Foundation`-[NSNotificationCenter
> postNotificationName:object:userInfo:] + 66
>     frame #26: 0x00007fffb9729b1f AppKit`-[NSApplication
> _postDidFinishNotification] + 297
>     frame #27: 0x00007fffb9729884 AppKit`-[NSApplication
> _sendFinishLaunchingNotification] + 208
>     frame #28: 0x00007fffb95ecbe9
> AppKit`-[NSApplication(NSAppleEventHandling) _handleAEOpenEvent:] +
> 552
>     frame #29: 0x00007fffb95ec83b
> AppKit`-[NSApplication(NSAppleEventHandling)
> _handleCoreEvent:withReplyEvent:] + 661
>     frame #30: 0x00007fffbd54be1d Foundation`-[NSAppleEventManager
> dispatchRawAppleEvent:withRawReply:handlerRefCon:] + 290
>     frame #31: 0x00007fffbd54bc97
> Foundation`_NSAppleEventManagerGenericHandler + 102
>     frame #32: 0x00007fffbc950f26 AE`aeDispatchAppleEvent(AEDesc
> const*, AEDesc*, unsigned int, unsigned char*) + 544
>     frame #33: 0x00007fffbc950c9d AE`dispatchEventAndSendReply(AEDesc
> const*, AEDesc*) + 39
>     frame #34: 0x00007fffbc950ba9 AE`aeProcessAppleEvent + 312
>     frame #35: 0x00007fffbb05dddf HIToolbox`AEProcessAppleEvent + 55
>     frame #36: 0x00007fffb95e80ed AppKit`_DPSNextEvent + 1833
>     frame #37: 0x00007fffb9d6385e AppKit`-[NSApplication(NSEvent)
> _nextEventMatchingEventMask:untilDate:inMode:dequeue:] + 2796
>     frame #38: 0x00007fffb95dc7ab AppKit`-[NSApplication run] + 926
>     frame #39: 0x000000010033ee44
> qemu-system-aarch64`main(argc=<unavailable>, argv=<unavailable>) +
> 2212 at cocoa.m:1368
>     frame #40: 0x00007fffd1803235 libdyld.dylib`start + 1
>     frame #41: 0x00007fffd1803235 libdyld.dylib`start + 1
> 
> 
> I don't think it makes a great deal of sense to be able to call into
> the TCG dump_exec_info() statistics routine if we never initialized
> the TCG accelerator (because we're using -accel=qtest). Not sure
> it makes much sense if -accel=kvm, for that matter...
> 
> thanks
> -- PMM
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
