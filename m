Received: from eggs.gnu.org ([209.51.188.92]:45959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <r.bolshakov@yadro.com>) id 1gxCc4-0001UM-8S
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 10:19:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <r.bolshakov@yadro.com>) id 1gxCc2-00063T-Ia
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 10:19:44 -0500
Received: from mta-01.yadro.com ([89.207.88.251]:33172)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <r.bolshakov@yadro.com>)
	id 1gxCc1-0004Oe-OJ
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 10:19:42 -0500
Date: Fri, 22 Feb 2019 18:19:10 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
Message-ID: <20190222151910.io5pvf6u3kp3axns@SPB-NB-133.local>
References: <20190214102816.3393-1-peter.maydell@linaro.org>
	<20190214102816.3393-2-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190214102816.3393-2-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v2 1/7] ui/cocoa: Ensure we have the
 iothread lock when calling into QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, patches@linaro.org, John Arbuckle <programmingkidx@gmail.com>, Berkus Decker <berkus@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Ben Hekster <ben.hekster@foghorn.io>, BALATON Zoltan <balaton@eik.bme.hu>

On Thu, Feb 14, 2019 at 10:28:10AM +0000, Peter Maydell wrote:
> The Cocoa UI should run on the main thread; this is enforced
> in OSX Mojave. In order to be able to run on the main thread,
> we need to make sure we hold the iothread lock whenever we
> call into various QEMU UI midlayer functions.
>

Hi Peter,

I wonder if qmp_stop and qmp_cont calls should be made in locked context
within pauseQEMU and resumeQEMU methods, respectively?

I also think it's better to clarify that the reason of the commit is not
Mojave enforcing usage of event loop in main thread but an improvement
of event processing in Cocoa UI, because Cocoa UI works on Mojave.

As of now qemu main loop and Cocoa events processing is done in the same
thread. And you can see from below that invocation of the qemu_main blocks
Cocoa event loop [NSApp run] in applicationDidFinishLaunching as qemu_main
doesn't quit.

Here's a backtrace that shows lockup of the primary Cocoa event loop:
(lldb) b cocoa_refresh
Breakpoint 1: where = qemu-system-x86_64`cocoa_refresh + 12 at cocoa.m:1634, address = 0x0000000109a03a0c
(lldb) c
Process 46179 resuming
Process 46179 stopped
* thread #1, queue = 'com.apple.main-thread', stop reason = breakpoint 1.1
    frame #0: 0x0000000109a03a0c qemu-system-x86_64`cocoa_refresh(dcl=0x00007f914eccefe0) at cocoa.m:1634
   1631
   1632 static void cocoa_refresh(DisplayChangeListener *dcl)
   1633 {
-> 1634     NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
   1635
   1636     COCOA_DEBUG("qemu_cocoa: cocoa_refresh\n");
   1637     graphic_hw_update(NULL);
Target 0: (qemu-system-x86_64) stopped.
(lldb) bt
* thread #1, queue = 'com.apple.main-thread', stop reason = breakpoint 1.1
  * frame #0: 0x0000000109a03a0c qemu-system-x86_64`cocoa_refresh(dcl=0x00007f914eccefe0) at cocoa.m:1634
    frame #1: 0x00000001099f6888 qemu-system-x86_64`dpy_refresh(s=0x00007f915074cbd0) at console.c:1622
    frame #2: 0x00000001099f66dd qemu-system-x86_64`gui_update(opaque=0x00007f915074cbd0) at console.c:205
    frame #3: 0x0000000109ba6009 qemu-system-x86_64`timerlist_run_timers(timer_list=0x00007f915070c390) at qemu-timer.c:574
    frame #4: 0x0000000109ba60e0 qemu-system-x86_64`qemu_clock_run_timers(type=QEMU_CLOCK_REALTIME) at qemu-timer.c:588
    frame #5: 0x0000000109ba662a qemu-system-x86_64`qemu_clock_run_all_timers at qemu-timer.c:708
    frame #6: 0x0000000109ba6b8f qemu-system-x86_64`main_loop_wait(nonblocking=0) at main-loop.c:521
    frame #7: 0x0000000109760464 qemu-system-x86_64`main_loop at vl.c:1923
    frame #8: 0x000000010975b624 qemu-system-x86_64`qemu_main(argc=5, argv=0x00007ffee66a0688, envp=0x00007ffee66a06b8) at vl.c:4578
    frame #9: 0x00000001099ffef9 qemu-system-x86_64`-[QemuCocoaAppController startEmulationWithArgc:argv:](self=0x00007f914ee05e10, _cmd="startEmulationWithArgc:argv:", argc=5, argv=0x00007ffee66a0688) at cocoa.m:1135
    frame #10: 0x00000001099ffd97 qemu-system-x86_64`-[QemuCocoaAppController applicationDidFinishLaunching:](self=0x00007f914ee05e10, _cmd="applicationDidFinishLaunching:", note=@"NSApplicationDidFinishLaunchingNotification") at cocoa.m:1087
    frame #11: 0x00007fff46bd5632 CoreFoundation`__CFNOTIFICATIONCENTER_IS_CALLING_OUT_TO_AN_OBSERVER__ + 12
    frame #12: 0x00007fff46bd55ac CoreFoundation`___CFXRegistrationPost_block_invoke + 63
    frame #13: 0x00007fff46bd54cd CoreFoundation`_CFXRegistrationPost + 398
    frame #14: 0x00007fff46bdd929 CoreFoundation`___CFXNotificationPost_block_invoke + 87
    frame #15: 0x00007fff46b450ca CoreFoundation`-[_CFXNotificationRegistrar find:object:observer:enumerator:] + 1633
    frame #16: 0x00007fff46b4448d CoreFoundation`_CFXNotificationPost + 742
    frame #17: 0x00007fff48ecca7b Foundation`-[NSNotificationCenter postNotificationName:object:userInfo:] + 66
    frame #18: 0x00007fff440c964a AppKit`-[NSApplication _postDidFinishNotification] + 313
    frame #19: 0x00007fff440c8f6e AppKit`-[NSApplication _sendFinishLaunchingNotification] + 209
    frame #20: 0x00007fff440c68c8 AppKit`-[NSApplication(NSAppleEventHandling) _handleAEOpenEvent:] + 552
    frame #21: 0x00007fff440c6517 AppKit`-[NSApplication(NSAppleEventHandling) _handleCoreEvent:withReplyEvent:] + 690
    frame #22: 0x00007fff48f17144 Foundation`-[NSAppleEventManager dispatchRawAppleEvent:withRawReply:handlerRefCon:] + 287
    frame #23: 0x00007fff48f16fc0 Foundation`_NSAppleEventManagerGenericHandler + 102
    frame #24: 0x00007fff47dfcb93 AE`aeDispatchAppleEvent(AEDesc const*, AEDesc*, unsigned int, unsigned char*) + 1855
    frame #25: 0x00007fff47dfc3fd AE`dispatchEventAndSendReply(AEDesc const*, AEDesc*) + 41
    frame #26: 0x00007fff47dfc2d5 AE`aeProcessAppleEvent + 439
    frame #27: 0x00007fff45e1110e HIToolbox`AEProcessAppleEvent + 55
    frame #28: 0x00007fff440c2644 AppKit`_DPSNextEvent + 1734
    frame #29: 0x00007fff440c1102 AppKit`-[NSApplication(NSEvent) _nextEventMatchingEventMask:untilDate:inMode:dequeue:] + 1362
    frame #30: 0x00007fff440bb165 AppKit`-[NSApplication run] + 699
    frame #31: 0x0000000109a03041 qemu-system-x86_64`main(argc=5, argv=0x00007ffee66a0688) at cocoa.m:1589
    frame #32: 0x00007fff73dc2ed9 libdyld.dylib`start + 1
    frame #33: 0x00007fff73dc2ed9 libdyld.dylib`start + 1

Each millisecond cocoa_refresh gets called by display handler. The function
extracts all available events from the cocoa event queue and dispatches them to
handleEvent:

        event = [NSApp nextEventMatchingMask:NSEventMaskAny untilDate:distantPast
                        inMode: NSDefaultRunLoopMode dequeue:YES];
        if (event != nil) {
            [cocoaView handleEvent:event];
        }

handleEvent enqueues keyboard and mouse events into ps2 queue and the
other events are enqueued to Cocoa event queue. I'm curious what happens
to the events that are enqueued with:
	[NSApp sendEvent:event];

Perhaps the events are enqueued in handleEvent over and over and never
get out of the event queue. And there could be a chance of the event
queue overrun.

--
Thanks,
Roman
