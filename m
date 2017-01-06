Received: from eggs.gnu.org ([2001:4830:134:3::10]:46250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cPQJf-0006QV-QF
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 03:56:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cPQJc-0008L5-Lg
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 03:56:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41324)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cPQJc-0008KS-GU
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 03:56:00 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri,  6 Jan 2017 09:55:28 +0100
Message-Id: <1483692945-9866-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 00/17] add serial wacom tablet emulation (gsoc
 2016)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: avg.tolik@gmail.com, Gerd Hoffmann <kraxel@redhat.com>

  Hi,

Finally found the time to put the wctablet code into shape.  Here comes
the patch series.

Patch #1 is the submission by Anatoli, almost unmodified.  I've only
adapted it to the recent chardev changes in the qemu code base so it
actually builds and works on current qemu.

The following patches improve the code base:
 * various cleanups (codestyle, delete unused stuff).
 * use accept_input insted of a timer.
 * use new input interface to register the driver.
 * rewrite command detection.
 * added some helper functions.
 * added trace events.

Functional changes:
 * handle line speed changes.
 * implement ST and SP commands.

See individual commit messages for more details.

Current state:
 * wacom test application works.
 * windows 3.11 driver works.
 * linux guest fails (inputattach --wacom_iv).  Probably due to '~C'
   not being implemented, that is the last command sent by linux
   before it throws an error.
 * left button acts somewhat strange.  One host side mouse click seems
   to toggle the button state inside the guest (windows 3.11).  Not sure
   whenever that is a bug in the emulation or something the guest driver
   is doing ...

cheers,
  Gerd

Anatoli Huseu1 (1):
  Add wctablet device

Gerd Hoffmann (16):
  wctablet: add wctablet_queue_output helper
  wctablet: save all chars in the query buffer
  wctablet: drop wctablet_commands_names
  wctablet: strip leading \r + \n from buffer
  wctablet: track line speed, reset on speed changes
  wctablet: operate on line speed 9600
  wctablet: drop debug code from wctablet_handler
  wctablet: add wctablet_shift_input
  wctablet: move init/detect sequence
  wctablet: revamp command parser.
  wctablet: drop timer, hook into chr->accept_input instead
  wctablet: drop DPRINTF, add trace events instead
  wctablet: misc cleanups
  wctablet: switch to new input interface
  wctablet: update file comment
  wctablet: implement ST and SP commands

 Makefile.objs            |   1 +
 backends/Makefile.objs   |   2 +-
 backends/trace-events    |  10 ++
 backends/wctablet.c      | 364 +++++++++++++++++++++++++++++++++++++++++++++++
 docs/qdev-device-use.txt |   2 +-
 qapi-schema.json         |   1 +
 qemu-char.c              |   1 +
 7 files changed, 379 insertions(+), 2 deletions(-)
 create mode 100644 backends/trace-events
 create mode 100644 backends/wctablet.c

-- 
1.8.3.1
