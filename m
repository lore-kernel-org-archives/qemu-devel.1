Received: from eggs.gnu.org ([2001:4830:134:3::10]:33536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eswierk@skyportsystems.com>) id 1cWv1I-00061W-3j
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 20:08:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eswierk@skyportsystems.com>) id 1cWv1D-0006Y8-BK
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 20:08:04 -0500
Received: from mail-ua0-x22c.google.com ([2607:f8b0:400c:c08::22c]:33592)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <eswierk@skyportsystems.com>)
	id 1cWv1D-0006X3-6q
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 20:07:59 -0500
Received: by mail-ua0-x22c.google.com with SMTP id i68so194727835uad.0
	for <qemu-devel@nongnu.org>; Thu, 26 Jan 2017 17:07:57 -0800 (PST)
MIME-Version: 1.0
From: Ed Swierk <eswierk@skyportsystems.com>
Date: Thu, 26 Jan 2017 17:07:16 -0800
Message-ID: <CAO_EM_kS-aGQdvPEO+7pkFWHOSiu8XMpZSduS=gPgUsDwJd9ig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] char: Logging serial pty output when disconnected
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: libvir-list@redhat.com

Interactive access to a guest serial console can be enabled by hooking
the serial device to a pty backend, e.g. -device
isa-serial,chardev=cs0 -chardev pty,id=cs0. With libvirt this can be
configured via <console type='pty'><target type='serial'
port='0'/></console>.

Output from the same serial device can also be logged to a file by
adding logfile=/somefile to the -chardev option (<log file=/somefile/>
in libvirt).

Unfortunately output gets logged only when a client like virsh console
is connected to the pty; otherwise qemu drops it on the floor. This
makes chardev logging much less useful than it could be for debugging
guest problems after the fact.

Currently qemu_chr_fe_write() calls qemu_chr_fe_write_log() only for
data consumed by the backend chr_write function. With the pty backend,
pty_chr_write() returns 0 indicating that the data was not consumed
when the pty is disconnected. Simply changing it to return len instead
of 0 tricks the caller into logging the data even when the pty is
disconnected. I don't know what problems this might cause, but one
data point is that tcp_chr_write() already happens to work this way.

Alternatively, qemu_chr_fe_write() could be modified to log everything
passed to it, regardless of how much data chr_write claims to have
consumed. The trouble is that the serial device retries writing
unconsumed data, so when the pty is disconnected you'd see every
character duplicated 4 times in the log file.

Any opinions on either approach, or other suggestions? If there are no
objections to the first one, I'll prepare a patch.

--Ed
