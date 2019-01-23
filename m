Received: from eggs.gnu.org ([209.51.188.92]:43212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <relkochta@gmail.com>) id 1gmQNT-0002Pc-J2
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 16:48:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <relkochta@gmail.com>) id 1gmQM7-0000a7-An
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 16:46:44 -0500
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:37812)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <relkochta@gmail.com>) id 1gmQM3-0000G7-TA
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 16:46:41 -0500
Received: by mail-qk1-x744.google.com with SMTP id g125so2028705qke.4
	for <qemu-devel@nongnu.org>; Wed, 23 Jan 2019 13:46:31 -0800 (PST)
From: Ryan El Kochta <relkochta@gmail.com>
Date: Wed, 23 Jan 2019 16:45:54 -0500
Message-Id: <20190123214555.12712-1-relkochta@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 0/1] input-linux: customizable grab toggle keys
 v5
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, kraxel@redhat.com
Cc: Ryan El Kochta <relkochta@gmail.com>

This patch adds a new option to the input-linux object:

grab-toggle=[key-combo]

The key combination can be one of the following:

* ctrl-ctrl
* alt-alt
* meta-meta
* scrolllock
* ctrl-scrolllock

The user can pick any of these key combinations. The VM's grab
of the evdev device will be toggled when the key combination is
pressed.

Any invalid setting will result in an error. No setting will
result in the current default of ctrl-ctrl.

The right and left ctrl key both work for Ctrl-Scrolllock.

If scrolllock is selected as one of the grab-toggle keys, it
will be entirely disabled and not passed to the guest at all.
This is to prevent enabling it while attempting to leave or enter
the VM. On the host, scrolllock can be disabled using xmodmap.

First, find the modifier that Scroll_Lock is bound to:

$ xmodmap -pm

Then, remove Scroll_Lock from it, replacing modX with the modifier:

$ xmodmap -e 'remove modX = Scroll_Lock'

If Scroll_Lock is not bound to any modifier, it is already disabled.

To save the changes, add them to your xinitrc.

Ryan El Kochta (1):
  input-linux: customizable grab toggle keys v5

 qapi/ui.json     | 10 ++++++++
 ui/input-linux.c | 66 +++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 73 insertions(+), 3 deletions(-)

-- 
2.20.1
