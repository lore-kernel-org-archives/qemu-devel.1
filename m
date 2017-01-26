Received: from eggs.gnu.org ([2001:4830:134:3::10]:35369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cWspu-0001y5-AE
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 17:48:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cWspp-0002EP-Aw
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 17:48:10 -0500
Received: from mail-vk0-x22a.google.com ([2607:f8b0:400c:c05::22a]:34840)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cWspp-0002DS-6P
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 17:48:05 -0500
Received: by mail-vk0-x22a.google.com with SMTP id x75so164911954vke.2
	for <qemu-devel@nongnu.org>; Thu, 26 Jan 2017 14:48:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1484666422.31968.74.camel@redhat.com>
References: <1484132292-21458-1-git-send-email-kraxel@redhat.com>
	<CAFEAcA-X3mXPR5GX0_Xqs6uXiv3ur6rimb4Yoeixop87ZuMaWg@mail.gmail.com>
	<1484641214.31968.26.camel@redhat.com>
	<CAFEAcA9F3UzZkM=qX=aNe2_x9mW6dt3gQsgYUbhaXRVB2FdVhw@mail.gmail.com>
	<1484666422.31968.74.camel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Jan 2017 22:47:43 +0000
Message-ID: <CAFEAcA--KOgbVFfTDAry+23F9W-qU6Xe8JmY-zej0L4BQ3h4=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] cocoa: stop using MOUSE_EVENT_*
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 17 January 2017 at 15:20, Gerd Hoffmann <kraxel@redhat.com> wrote:
> On Di, 2017-01-17 at 10:44 +0000, Peter Maydell wrote:
>> On 17 January 2017 at 08:20, Gerd Hoffmann <kraxel@redhat.com> wrote:
>> > On Mo, 2017-01-16 at 18:35 +0000, Peter Maydell wrote:
>> >> On 11 January 2017 at 10:58, Gerd Hoffmann <kraxel@redhat.com> wrote:
>> >> > No need to go the indirect route with a bitfield and mapping the bits to
>> >> > INPUT_BUTTON_*.  We can use a bool array and INPUT_BUTTON_* directly
>> >> > instead.
>> >> >
>> >> > Untested, not even compiled, due to lack of a osx^Wmacos machine.
>> >> > Test results are very welcome.
>> >>
>> >> So what does the patch gain us?
>> >
>> > I can drop MOUSE_EVENT_WHEEL* without breaking the osx build.
>>
>> Why do you want to drop it, though? It's a valid mouse event
>> type, and you're not going to drop the whole MOUSE_EVENT_* set
>> of defines, I assume, because they're used in lots of devices.
>
> Dunno where the MOUSE_EVENT_* #defines originally come from, I suspect
> from old ps2 mouse protocols, for historical reasons, simliar to the
> numeric key codes we have in qemu which are pc scancodes too.
>
> So, yes, I considered dropping them all and use hardware-specific
> #defines instead.  But it seems at least for the left/right/middle
> buttons most (all?) hardware agrees on which bit is which.  So the
> attempt to drop the button defines looks like pointless churn.

Thinking about this I think the issue here is that it's a bit
confused what the MOUSE_EVENT_* values actually are:
 * actual emulated-hardware bits (in protocol bytes fed to
   the guest) ?
 * bits used in the representation with which we feed
   events from the UI midlayer to the emulated devices ?
 * bits used in the representation where UI frontends
   feed events to the UI midlayer ?

I think cleanup here is worthwhile if we can get consistency
about how we're representing mouse events and what layers
of QEMU these #defines are relevant to.
(For instance hw/input/ps2.c should probably be using its
own private #defines since it wants the exact values that
go into the on-the-wire ps2 protocol bytes.)

I had to apply the patch below to get it to compile, though,
and I've only tested by sticking printfs in for what values
we're passing in, because I don't have any test images to
hand that actually use the mouse.

So if you have a plan for cleaning up all the current
users of MOUSE_EVENT_*, this patch is ok I guess, but
if you're not planning for instance to deal with the
uses in monitor.c and input-legacy.c then I think we
should keep the MOUSE_EVENT_WHEEL* for consistency
with the fact that the INPUT_BUTTON_* consider wheel
buttons to be buttons.


diff --git a/ui/cocoa.m b/ui/cocoa.m
index 599b899..b40ace4 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -511,9 +511,7 @@ QemuCocoaView *cocoaView;
 {
     COCOA_DEBUG("QemuCocoaView: handleEvent\n");

-    bool buttons[INPUT_BUTTON__MAX] = {
-        [ 0 ... (INPUT_BUTTON__MAX-1) ] = false;
-    };
+    bool buttons[INPUT_BUTTON__MAX] = { false };
     int keycode;
     bool mouse_event = false;
     NSPoint p = [event locationInWindow];
@@ -706,14 +704,13 @@ QemuCocoaView *cocoaView;
          * call below. We definitely don't want to pass that click through
          * to the guest.
          */
-        if ((isMouseGrabbed || [[self window] isKeyWindow]) &&
-            (last_buttons != buttons)) {
+        if ((isMouseGrabbed || [[self window] isKeyWindow])) {
             InputButton btn;

             for (btn = 0; btn < INPUT_BUTTON__MAX; btn++) {
-                if (last_button[btn] != button[btn]) {
-                    qemu_input_queue_btn(dcl->con, btn, button[btn]);
-                    last_button[btn] = button[btn];
+                if (last_buttons[btn] != buttons[btn]) {
+                    qemu_input_queue_btn(dcl->con, btn, buttons[btn]);
+                    last_buttons[btn] = buttons[btn];
                 }
             }
         }

thanks
-- PMM
