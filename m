Received: from eggs.gnu.org ([2001:4830:134:3::10]:44571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bastien.orivel@diateam.net>) id 1fJg9Q-0002Ax-HO
	for qemu-devel@nongnu.org; Fri, 18 May 2018 10:14:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bastien.orivel@diateam.net>) id 1fJg9M-0000QD-26
	for qemu-devel@nongnu.org; Fri, 18 May 2018 10:14:32 -0400
Received: from mail.virtualys.com ([178.33.44.80]:36851)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bastien.orivel@diateam.net>) id 1fJg9L-0000MS-Nr
	for qemu-devel@nongnu.org; Fri, 18 May 2018 10:14:27 -0400
From: Bastien Orivel <bastien.orivel@diateam.net>
Message-ID: <7ccfbaf3-d2bf-3527-24b0-cfeb9927afc2@diateam.net>
Date: Fri, 18 May 2018 16:14:16 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: [Qemu-devel] QEMU's SPICE server not getting leds callback when
 sending capslock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com

Hey,

I'm having troubles using the QEMU's SPICE server for remote views. When
trying to sync leds from my SPICE client to QEMU, I can see that the
caps lock keycodes are sent but the server state never gets updated
(which leads in funny behaviours like caps lock "blinking" in the guest
if the clients resyncs its state often).

That behaviour doesn't happen at all with the numlock led which does the
same thing but with different keycodes.

Here is an example of what's happening when the client tries to resync
with a capslock difference:

> Spice received: 58
> ps2_put_keycode: 88
>
> Spice received: 186
> ps2_put_keycode: 240
> ps2_put_keycode: 88
> ps2_queue: 186

And with numlock:

> Spice received: 69
> ps2_put_keycode: 119

> Spice received: 197
> ps2_put_keycode: 240
> ps2_put_keycode: 119
> ps2_queue: 197
> ps2_set_ledstate: 0
> Spice new ledstate: 0


Spice registers a callback for leds via qemu_add_led_event_handler but
it's never called for capslock. Is that a normal behaviour ? Is there
any reasons for the capslock led not to be updated ?

Regards,
Bastien
