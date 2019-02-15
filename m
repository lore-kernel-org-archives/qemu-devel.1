Received: from eggs.gnu.org ([209.51.188.92]:39757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1guRmS-0000OH-N6
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 19:55:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1guRaP-0006uA-My
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 19:42:38 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:55281)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1guRaP-0006rk-6b
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 19:42:37 -0500
Date: Fri, 15 Feb 2019 01:42:32 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <CAFEAcA_hQVwGJoK17TzqcejiG+ycnt8rEAYwZ2Tub=H9Myj_Sw@mail.gmail.com>
Message-ID: <alpine.BSF.2.21.9999.1902150134350.41761@zero.eik.bme.hu>
References: <20190214102816.3393-1-peter.maydell@linaro.org>
	<20190214102816.3393-6-peter.maydell@linaro.org>
	<alpine.BSF.2.21.9999.1902141745470.64316@zero.eik.bme.hu>
	<CAFEAcA_hQVwGJoK17TzqcejiG+ycnt8rEAYwZ2Tub=H9Myj_Sw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH v2 5/7] ui/cocoa: Don't call NSApp
 sendEvent directly from handleEvent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, John Arbuckle <programmingkidx@gmail.com>, Roman Bolshakov <r.bolshakov@yadro.com>, Berkus Decker <berkus@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Ben Hekster <ben.hekster@foghorn.io>

On Thu, 14 Feb 2019, Peter Maydell wrote:
> On Thu, 14 Feb 2019 at 17:04, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>>> -- (void) handleEvent:(NSEvent *)event
>>> +- (bool) handleEvent:(NSEvent *)event
>>> {
>>> -    with_iothread_lock(^{
>>> -        [self handleEventLocked:event];
>>> +    return bool_with_iothread_lock(^{
>>> +        return [self handleEventLocked:event];
>>>     });
>>> }
>>
>> If this is only ever used for this one method, wouldn't it be easier to
>> move locking to the method below (even with some goto after setting a ret
>> variable to unlock at the end of the method where now it returns in the
>> middle, but maybe it could even be done without goto as the whole code is
>> one big switch that can be exited with break and an if that can be skipped
>> by a flag)? That may be easier to follow than this method within block
>> within method and then you wouldn't need bool_with_iothread_lock and
>> neither handleEvent. Unless there's something I'm missing which makes this
>> convoluted way needed.
>
> The aim was to avoid having to do changes to handleEvent's code flow
> in order to do "run it with the lock held"; it also means that the
> invariant "we always unlock the lock" is easy to confirm, whereas
> if you do the lock/unlock inside a single handleEvent method you have
> to look for whether it was done right in early-exit cases. It's
> a bit less of a convincing argument than it was in v1 (where we were
> making no changes to handleEvent at all other than wrapping it in a
> lock), but I think it still makes sense this way.

I thought of something like below which to me is simpler than your 
proposal and makes less changes to the original but feel free to choose 
whichever you like, I don't mind either way.

But the comment about sendEvent near the end is now outdated after either 
patch so you may want to update that even in your patch.

Regards,
BALATON Zoltan

diff --git a/ui/cocoa.m b/ui/cocoa.m
index 4727f9c392..de6606e017 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -132,9 +132,8 @@
 QemuSemaphore display_init_sem;
 QemuSemaphore app_started_sem;

-// Utility functions to run specified code block with iothread lock held
+// Utility function to run specified code block with iothread lock held
 typedef void (^CodeBlock)(void);
-typedef bool (^BoolCodeBlock)(void);

 static void with_iothread_lock(CodeBlock block)
 {
@@ -148,21 +147,6 @@ static void with_iothread_lock(CodeBlock block)
     }
 }

-static bool bool_with_iothread_lock(BoolCodeBlock block)
-{
-    bool locked = qemu_mutex_iothread_locked();
-    bool val;
- 
-    if (!locked) {
-        qemu_mutex_lock_iothread();
-    }
-    val = block();
-    if (!locked) {
-        qemu_mutex_unlock_iothread();
-    }
-    return val;
-}
-
 // Mac to QKeyCode conversion
 const int mac_to_qkeycode_map[] = {
     [kVK_ANSI_A] = Q_KEY_CODE_A,
@@ -341,7 +325,6 @@ - (void) ungrabMouse;
 - (void) toggleFullScreen:(id)sender;
 - (void) handleMonitorInput:(NSEvent *)event;
 - (bool) handleEvent:(NSEvent *)event;
-- (bool) handleEventLocked:(NSEvent *)event;
 - (void) setAbsoluteEnabled:(BOOL)tIsAbsoluteEnabled;
 /* The state surrounding mouse grabbing is potentially confusing.
  * isAbsoluteEnabled tracks qemu_input_is_absolute() [ie "is the emulated
@@ -689,15 +672,15 @@ - (void) handleMonitorInput:(NSEvent *)event

 - (bool) handleEvent:(NSEvent *)event
 {
-    return bool_with_iothread_lock(^{
-        return [self handleEventLocked:event];
-    });
-}
-
-- (bool) handleEventLocked:(NSEvent *)event
-{
-    /* Return true if we handled the event, false if it should be given to OSX */
     COCOA_DEBUG("QemuCocoaView: handleEvent\n");
+    /* Return true if we handled the event, false if it should be given to OSX */
+    bool handled = true;
+    bool locked = qemu_mutex_iothread_locked();
+    if (!locked) {
+        qemu_mutex_lock_iothread();
+    }
+    /* Make sure to release lock so don't return before the end */
+
     int buttons = 0;
     int keycode = 0;
     bool mouse_event = false;
@@ -767,7 +750,8 @@ - (bool) handleEventLocked:(NSEvent *)event
                 if (keycode == Q_KEY_CODE_F) {
                     switched_to_fullscreen = true;
                 }
-                return false;
+                handled = false;
+                goto unlock;
             }

             // default
@@ -782,12 +766,12 @@ - (bool) handleEventLocked:(NSEvent *)event
                         // enable graphic console
                         case '1' ... '9':
                             console_select(key - '0' - 1); /* ascii math */
-                            return true;
+                            goto unlock;

                         // release the mouse grab
                         case 'g':
                             [self ungrabMouse];
-                            return true;
+                            goto unlock;
                     }
                 }
             }
@@ -804,7 +788,7 @@ - (bool) handleEventLocked:(NSEvent *)event
             // don't pass the guest a spurious key-up if we treated this
             // command-key combo as a host UI action
             if (!isMouseGrabbed && ([event modifierFlags] & NSEventModifierFlagCommand)) {
-                return true;
+                goto unlock;
             }

             if (qemu_console_is_graphic(NULL)) {
@@ -898,16 +882,16 @@ - (bool) handleEventLocked:(NSEvent *)event
             mouse_event = false;
             break;
         default:
-            return false;
+            handled = false;
+            goto unlock;
     }

     if (mouse_event) {
         /* Don't send button events to the guest unless we've got a
          * mouse grab or window focus. If we have neither then this event
          * is the user clicking on the background window to activate and
-         * bring us to the front, which will be done by the sendEvent
-         * call below. We definitely don't want to pass that click through
-         * to the guest.
+         * bring us to the front, which will be done by sendEvent.
+         * We definitely don't want to pass that click through to the guest.
          */
         if ((isMouseGrabbed || [[self window] isKeyWindow]) &&
             (last_buttons != buttons)) {
@@ -934,11 +918,16 @@ - (bool) handleEventLocked:(NSEvent *)event
                 qemu_input_queue_rel(dcl->con, INPUT_AXIS_Y, (int)[event deltaY]);
             }
         } else {
-            return false;
+            handled = false;
+            goto unlock;
         }
         qemu_input_event_sync();
     }
-    return true;
+unlock:
+    if (!locked) {
+        qemu_mutex_unlock_iothread();
+    }
+    return handled;
 }

 - (void) grabMouse
