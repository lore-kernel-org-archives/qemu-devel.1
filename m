Received: from eggs.gnu.org ([2001:4830:134:3::10]:41639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ilg@livius.net>) id 1cFkL3-0004sB-VZ
	for Qemu-devel@nongnu.org; Sat, 10 Dec 2016 11:17:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ilg@livius.net>) id 1cFkKz-0006GE-0s
	for Qemu-devel@nongnu.org; Sat, 10 Dec 2016 11:17:29 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33167)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ilg@livius.net>) id 1cFkKy-0006Fr-M4
	for Qemu-devel@nongnu.org; Sat, 10 Dec 2016 11:17:24 -0500
Received: by mail-wm0-f65.google.com with SMTP id u144so2307628wmu.0
	for <Qemu-devel@nongnu.org>; Sat, 10 Dec 2016 08:17:24 -0800 (PST)
Received: from [172.16.62.12] ([109.99.239.84])
	by smtp.gmail.com with ESMTPSA id w8sm26385385wmw.4.2016.12.10.08.16.22
	for <Qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 10 Dec 2016 08:16:22 -0800 (PST)
From: Liviu Ionescu <ilg@livius.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 10.1 \(3251\))
Message-Id: <6BBB3038-0389-4221-9A41-63800F3FF514@livius.net>
Date: Sat, 10 Dec 2016 18:16:20 +0200
Subject: [Qemu-devel] experience with SDL2, event loop & main thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developer <Qemu-devel@nongnu.org>

given the reported problems with the SDL integration, here are some =
things I learned while updating GNU ARM Eclipse QEMU to use SDL2 (SDL1 =
is already issuing various warnings when running on macOS 10.12, and =
anyway it has several limitations).

---

initially I expected that the project requires just a simple build =
script update, but it was much more, I had to completely restructure the =
graphical code.

in short, the main problem is the competition/contradiction in using the =
main thread in QEMU.

by tradition, graphical systems and multi-theaded applications do not =
make good friends, because graphical systems expect to run only on the =
application's main thread.

SDL2 is not an exception; at least on macOS (Cocoa) and GNU/Linux =
(openGL), all my attempts to run the graphical event loop on another =
thread failed with horrible exceptions.


but running the event loop on the main thread is not enough, all =
graphical primitives must be called from the main thread.=20

in QEMU this creates a problem, since normally graphic updates are =
triggered by the emulated peripherals, which run on the specific =
emulator thread (for example, in GNU ARM Eclipse QEMU case, for emulated =
LEDs, GPIO pin changes alternate a rectangle on the board picture).

there might be specific primitives/configurations/platforms where this =
rule can be relaxed, but the only portable, trouble free, solution is to =
run everything on the main thread (SDL window creation, draw primitives, =
event loop, and window destruction).


unfortunately this collides with QEMU use of the main thread to pump the =
I/O event loop.=20

there are two possible solutions:

- move the qemu initialisations and I/O event loop on a new thread, and =
free the main thread exclusively for the SDL event loop (which can now =
block waiting for events)
- keep the qemu initialisations and the I/O event loop on the main =
thread and schedule a timer every few milliseconds to poll if new =
graphical events are in the queue.


the first solution is obviously the most efficient, since the graphical =
thread does not consume resources when the there is no graphical =
activity, and reaction speed to graphical updates is as good as =
possible. (unfortunately this solution currently does not work on =
windows)


the second solution, which uses a timer to schedule a poll routine every =
few milliseconds (for example every 10 ms), is much more inefficient, =
and adds a small delay to all graphical displays. the timer routine is =
scheduled to run on the main thread, so the condition to run the =
graphical event loop on the main thread is satisfied.


fyi, this inefficient second solution, with a timer, is currently used =
by the qemu graphical consoles.


to guarantee that all graphical primitives will be invoked only from the =
main thread, calls should not be performed from the actual location =
(usually the emulator tcg thread), but must be queued as user events and =
deferred to the main thread, possibly using user events in the graphical =
event loop; for example:

    case SDL_USEREVENT:

        // User events, enqueued with SDL_PushEvent().
        switch (event->user.code) {

        case GRAPHIC_EVENT_BOARD_INIT:
            board_graphic_context =3D (BoardGraphicContext *) =
event->user.data1;

            if (!cortexm_graphic_board_is_graphic_context_initialised(
                    board_graphic_context)) {
                cortexm_graphic_board_init_graphic_context(
                        board_graphic_context);
            }
            break;

        case GRAPHIC_EVENT_LED_INIT:
            state =3D (GPIOLEDState *) event->user.data1;

            if (!cortexm_graphic_led_is_graphic_context_initialised(
                    &(state->led_graphic_context))) {
                cortexm_graphic_led_init_graphic_context(
                        state->board_graphic_context,
                        &(state->led_graphic_context), =
state->colour.red,
                        state->colour.green, state->colour.blue);
            }
            break;

        case GRAPHIC_EVENT_LED_TURN:
            state =3D (GPIOLEDState *) event->user.data1;
            is_on =3D (bool) event->user.data2;

            cortexm_graphic_led_turn(state->board_graphic_context,
                    &(state->led_graphic_context), is_on);
            break;

	// ...

        default:
            fprintf(stderr, "Unimplemented user event %d\n", =
event->user.code);
        }
        break;



special care must be observed for window destruction at program =
termination.

the SDL manuals recommend adding an atexit(SDL_Quit), but this isn't as =
simple as it looks, because the SDL_Quit must be executed also on the =
main thread, while the registered atexit() functions are executed on the =
context of the thread that calls exit(). (trying to run SDL_Quit on =
another thread hangs on Windows).

in practical terms, this means that exit() can be called only from the =
main thread. calls from different threads should be replaced with code =
to push a user event on the graphical loop, and perform the quit on the =
event loop.


one problematic such case is the semihosting exit. the semihosting code =
is executed on the emulator thread, so it cannot directly call exit. =
enqueuing the event is simple, but this code is executed with the io =
mutex locked, so the I/O loop is not running, and the timer will not =
schedule graphical polls. my workaround was to call =
`qemu_mutex_unlock_iothread()` to unlock the mutex, and wait for the =
program to terminate. this might not be the right solution, but seems =
functional.

---

conclusions:

- the graphical event loop and all graphical primitives must be called =
from the main thread context
- in qemu this is not possible directly; an inefficient but functional =
solution uses a timer programmed to call a function every few =
milliseconds, to poll the event loop. (if the qemu I/O event loop is =
executed on the main thread, the timer function will be called from the =
main thread context)
- all graphical operations initiated by the all other thread (like the =
emulator thread), must be deferred (in SDL using user events) to the =
graphical event loop
- a function to run graphical destruction must be registered with =
atexit()
- only the main thread can call exit(), to ensure the destruction =
functions are not called from other threads
- exiting from other threads must be also deferred to the main thread, =
possibly with unlocking a mutex.


I hope that helps,

Liviu
