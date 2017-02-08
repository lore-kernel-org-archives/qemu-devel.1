Received: from eggs.gnu.org ([2001:4830:134:3::10]:58693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eswierk@skyportsystems.com>) id 1cbVBo-0002EE-AY
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 11:33:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eswierk@skyportsystems.com>) id 1cbVBk-0005Z4-Cz
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 11:33:52 -0500
Received: from mail-ua0-x234.google.com ([2607:f8b0:400c:c08::234]:36289)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <eswierk@skyportsystems.com>)
	id 1cbVBk-0005Yf-85
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 11:33:48 -0500
Received: by mail-ua0-x234.google.com with SMTP id 96so113377207uaq.3
	for <qemu-devel@nongnu.org>; Wed, 08 Feb 2017 08:33:46 -0800 (PST)
MIME-Version: 1.0
From: Ed Swierk <eswierk@skyportsystems.com>
Date: Wed, 8 Feb 2017 08:33:05 -0800
Message-ID: <CAO_EM_m9Z7WcxRZthAGgeDgJ6UuwKXwAOEH7NC2=hL8Cd4jABg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] virtio-scsi-pci iothread spins at 100%
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, stefanha@redhat.com

Recently I noticed that when I configure a virtio-scsi-pci device
using an iothread, as soon as the guest virtio-scsi driver loads, the
iothread spins at 100%:

  -object iothread,id=iothread1 -device virtio-scsi-pci,iothread=iothread1

This occurs whether or not a disk is attached, with either
poll-max-ns=0 or poll-max-ns=32768, and with Linux 3.13, 4.1 and 4.4
guests. The iothread stops spinning as soon as the guest driver is
unloaded.

I bisected the issue to commit 684e508c23d28af8d6ed2c62738a0f60447c8274:

  aio: add .io_poll_begin/end() callbacks

It doesn't seem to affect performance, but obviously consuming CPU
cycles when there's no disk attached is undesirable. Is this an
expected side effect of implementing iothread polling? Is there a way
to revert to the old non-polling behavior?

--Ed
