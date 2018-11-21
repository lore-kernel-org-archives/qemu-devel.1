Received: from eggs.gnu.org ([2001:4830:134:3::10]:46323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gPUBP-00060v-MM
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 10:12:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gPUBO-000491-Bn
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 10:12:51 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:39744)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gPUBM-00041u-Cf
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 10:12:49 -0500
Received: by mail-oi1-x244.google.com with SMTP id 192-v6so4793533oii.6
	for <qemu-devel@nongnu.org>; Wed, 21 Nov 2018 07:12:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA983Q16B8y1j3msg31BtM5LXhUcB5ouyg6Dp1y-aUaDpw@mail.gmail.com>
References: <D965412A-A975-4660-BEC5-6FBF34E35C45@gmail.com>
	<CAFEAcA983Q16B8y1j3msg31BtM5LXhUcB5ouyg6Dp1y-aUaDpw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 21 Nov 2018 15:12:25 +0000
Message-ID: <CAFEAcA8WMh8AnD8X5eMz7YX_c5z0Aw8_ydZ-0poY5Sv9mnxUHw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] Fix for crashes and non-responsive UI on
 macOS Mojave
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Berkus Decker <berkus@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

(Hi Gerd -- I have a question at the bottom of this email
about the thread/locking semantics of the UI midlayer...)

On 20 November 2018 at 12:59, Peter Maydell <peter.maydell@linaro.org> wrot=
e:
> On 11 November 2018 at 21:24, Berkus Decker <berkus@gmail.com> wrote:
>> It seems that Cocoa checks are stricter on Mojave and some callbacks tha=
t worked from non-GUI thread on High Sierra are no longer working.
>>
>> The fixes included here are:
>>
>> * Deferring qemu_main() to another thread so that the actual main thread=
 is reserved for the Cocoa UI; it also removes blocking from applicationDid=
FinishLoading: delegate. I beleive this alone caused complete UI blockage o=
n Mojave.
>> * Deferring UI-related updates in callbacks to the UI thread using invok=
eOnMainThread helper function. This function uses DDInvocationGrabber objec=
t courtesy of Dave Dribin, licensed under MIT license.
>> Here=E2=80=99s relevant blog post for his code: https://www.dribin.org/d=
ave/blog/archives/2008/05/22/invoke_on_main_thread/
>>
>> NSInvocation is used here instead of plain performSelectorOnMainThread:w=
ithObject:waitUntilDone: because we want to be able to pass non-id types to=
 the handlers.
>>
>> These changes are ought to work on OSX 10.6, although I don=E2=80=99t ha=
ve a machine handy to test it.
>>
>> Fixes https://bugs.launchpad.net/qemu/+bug/1802684
>
> Hi; thanks for these patches. I haven't tried running them yet
> (I should be able to get to that tomorrow)

On High Sierra this does run for me, but seems to
introduce a bug:

 * Run qemu-system-x86_64 with no arguments
 * Let the BIOS get to the "No bootable devices" message
 * Press a key in the QEMU window

QEMU hits an assert:
ERROR:/Users/pm215/src/qemu/accel/tcg/tcg-all.c:42:tcg_handle_interrupt:
assertion failed: (qemu_mutex_iothread_locked())

with this backtrace:

* thread #1, queue =3D 'com.apple.main-thread', stop reason =3D signal SIGA=
BRT
  * frame #0: 0x00007fff7b123b66 libsystem_kernel.dylib`__pthread_kill + 10
    frame #1: 0x00007fff7b2ee080 libsystem_pthread.dylib`pthread_kill + 333
    frame #2: 0x00007fff7b07f1ae libsystem_c.dylib`abort + 127
    frame #3: 0x00000001014f7f19 libglib-2.0.0.dylib`g_assertion_message + =
407
    frame #4: 0x00000001014f7f77
libglib-2.0.0.dylib`g_assertion_message_expr + 94
    frame #5: 0x00000001000a3509
qemu-system-x86_64`tcg_handle_interrupt(cpu=3D0x0000000103883200,
mask=3D2) at tcg-all.c:42
    frame #6: 0x00000001000e8222
qemu-system-x86_64`cpu_interrupt(cpu=3D0x0000000103883200, mask=3D2) at
cpu.h:855
    frame #7: 0x00000001000e70ca
qemu-system-x86_64`apic_local_deliver(s=3D0x0000000101e40010, vector=3D3)
at apic.c:156
    frame #8: 0x00000001000e6f71
qemu-system-x86_64`apic_deliver_pic_intr(dev=3D0x0000000101e40010,
level=3D1) at apic.c:173
    frame #9: 0x000000010010ff9e
qemu-system-x86_64`pic_irq_request(opaque=3D0x0000000000000000, irq=3D0,
level=3D1) at pc.c:195
    frame #10: 0x0000000100297f3b
qemu-system-x86_64`qemu_set_irq(irq=3D0x0000000101cdac30, level=3D1) at
irq.c:45
    frame #11: 0x000000010030073a
qemu-system-x86_64`qemu_irq_raise(irq=3D0x0000000101cdac30) at irq.h:16
    frame #12: 0x00000001003006ad
qemu-system-x86_64`pic_update_irq(s=3D0x0000000101cdada0) at i8259.c:111
    frame #13: 0x0000000100300d1c
qemu-system-x86_64`pic_set_irq(opaque=3D0x0000000101cdada0, irq=3D1,
level=3D1) at i8259.c:153
    frame #14: 0x0000000100297f3b
qemu-system-x86_64`qemu_set_irq(irq=3D0x0000000101cdbf50, level=3D1) at
irq.c:45
    frame #15: 0x000000010010cad8
qemu-system-x86_64`gsi_handler(opaque=3D0x0000000101cc7760, n=3D1,
level=3D1) at pc.c:118
    frame #16: 0x0000000100297f3b
qemu-system-x86_64`qemu_set_irq(irq=3D0x0000000101cc7410, level=3D1) at
irq.c:45
    frame #17: 0x00000001002fa162
qemu-system-x86_64`kbd_update_irq(s=3D0x0000000101e5cef8) at pckbd.c:181
    frame #18: 0x00000001002f967f
qemu-system-x86_64`kbd_update_kbd_irq(opaque=3D0x0000000101e5cef8,
level=3D1) at pckbd.c:193
    frame #19: 0x00000001002fa603
qemu-system-x86_64`ps2_queue(s=3D0x0000000101e5e490, b=3D22) at ps2.c:213
    frame #20: 0x00000001002fadd4
qemu-system-x86_64`ps2_put_keycode(opaque=3D0x0000000101e5e490,
keycode=3D60) at ps2.c:267
    frame #21: 0x00000001002fd10f
qemu-system-x86_64`ps2_keyboard_event(dev=3D0x0000000101e5e490,
src=3D0x0000000000000000, evt=3D0x0000000101af02c0) at ps2.c:470
    frame #22: 0x0000000100491e2c
qemu-system-x86_64`qemu_input_event_send_impl(src=3D0x0000000000000000,
evt=3D0x0000000101af02c0) at input.c:346
    frame #23: 0x000000010046c8d5
qemu-system-x86_64`replay_input_event(src=3D0x0000000000000000,
evt=3D0x0000000101af02c0) at replay-input.c:128
    frame #24: 0x0000000100491d5b
qemu-system-x86_64`qemu_input_event_send(src=3D0x0000000000000000,
evt=3D0x0000000101af02c0) at input.c:375
    frame #25: 0x0000000100492297
qemu-system-x86_64`qemu_input_event_send_key(src=3D0x0000000000000000,
key=3D0x00000001159037f0, down=3Dtrue) at input.c:419
    frame #26: 0x0000000100491c71
qemu-system-x86_64`qemu_input_event_send_key_qcode(src=3D0x0000000000000000=
,
q=3DQ_KEY_CODE_U, down=3Dtrue) at input.c:441
    frame #27: 0x0000000100496a0b qemu-system-x86_64`-[QemuCocoaView
handleEvent:](self=3D0x0000000101c2eef0, _cmd=3D"handleEvent:",
event=3D0x0000000101cebdf0) at cocoa.m:767
    frame #28: 0x0000000100495b4e qemu-system-x86_64`-[QemuCocoaView
refresh](self=3D0x0000000101c2eef0, _cmd=3D"refresh") at cocoa.m:541
    frame #29: 0x00007fff5301139c CoreFoundation`__invoking___ + 140
    frame #30: 0x00007fff53011270 CoreFoundation`-[NSInvocation invoke] + 3=
20
    frame #31: 0x00007fff551730b5 Foundation`__NSThreadPerformPerform + 334
    frame #32: 0x00007fff53031be1
CoreFoundation`__CFRUNLOOP_IS_CALLING_OUT_TO_A_SOURCE0_PERFORM_FUNCTION__
+ 17
    frame #33: 0x00007fff530e94bc CoreFoundation`__CFRunLoopDoSource0 + 108
    frame #34: 0x00007fff53014b90 CoreFoundation`__CFRunLoopDoSources0 + 20=
8
    frame #35: 0x00007fff5301400d CoreFoundation`__CFRunLoopRun + 1293
    frame #36: 0x00007fff53013867 CoreFoundation`CFRunLoopRunSpecific + 487
    frame #37: 0x00007fff522f3d96 HIToolbox`RunCurrentEventLoopInMode + 286
    frame #38: 0x00007fff522f3b06 HIToolbox`ReceiveNextEventCommon + 613
    frame #39: 0x00007fff522f3884
HIToolbox`_BlockUntilNextEventMatchingListInModeWithFilter + 64
    frame #40: 0x00007fff505a3a73 AppKit`_DPSNextEvent + 2085
    frame #41: 0x00007fff50d39e34 AppKit`-[NSApplication(NSEvent)
_nextEventMatchingEventMask:untilDate:inMode:dequeue:] + 3044
    frame #42: 0x00007fff50598885 AppKit`-[NSApplication run] + 764
    frame #43: 0x000000010049aac1 qemu-system-x86_64`main(argc=3D1,
argv=3D0x00007ffeefbffa40) at cocoa.m:1575
    frame #44: 0x00007fff7afd3015 libdyld.dylib`start + 1

Something somewhere in this call chain should have taken
the iothread lock, I assume, but I'm not sure where.

Gerd -- what are the rules of the UI subsystem regarding
multiple threads, and what threads are allowed to call
UI functions like qemu_input_event_send_key_qcode(),
from which threads, and whether they need to eg hold
the iothread lock when they do so? There's no
documentation on these functions in include/ui/input.h.

(To fix a problem on OSX Mojave this patchset has moved
which thread the UI executes on, so it is now always
the main thread and not the thread which calls
the QemuDisplay 'init' callback. That seems to break
an implicit assumption in the UI layer.)

thanks
-- PMM
