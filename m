Received: from eggs.gnu.org ([2001:4830:134:3::10]:40536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dNz3T-00022k-Vl
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 06:09:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dNz3S-0000Ho-Ru
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 06:09:39 -0400
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:36128)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dNz3S-0000Gr-LA
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 06:09:38 -0400
Received: by mail-wr0-x22f.google.com with SMTP id c11so16469343wrc.3
	for <qemu-devel@nongnu.org>; Thu, 22 Jun 2017 03:09:38 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Jun 2017 11:09:16 +0100
Message-ID: <CAFEAcA90vjbr=CM9i9m7-PdN0NB=MV8W0+wsG9UrNNR+KENsmA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] qemu_chr_fe_add_watch interaction with VM
 start/stop/migrate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>

Hi; I'm currently writing a UART device model, and I want to make
it avoid using the deprecated qemu_chr_fe_write_all() (in the same
way that the hw/char/cadence_uart.c code does, by using
qemu_chr_fe_write() and then registering a callback with
qemu_chr_fe_add_watch() if the write doesn't manage to send data).

I have some code that seems to work, but I'm not sure about how the
chardev frontend callbacks interact with VM start, stop and migration.

For instance, suppose my UART tries to write to the chardev but
can't, so it registers a callback with qemu_chr_fe_add_watch().
Then the user stops the VM. Does the chardev UI guarantee that
my callback won't get called until the user restarts the VM,
or does my callback function have to do something to say "don't
actually update the emulation state if we're stopped"?
If the user then restarts the VM, do I need to do something to
retry the chardev write?

For migration, if we're migrating in the state where I have a
pending character I'd like to write to the chardev, what do I need
to do on the destination side? Do I need to call qemu_chr_fe_add_watch
in the post-load function, or is this too early and I need to do
something to call it when the destination VM is actually restarted?

More generally, am I guaranteed that my qemu_chr_fe_add_watch()
callbacks are only called with the iothread mutex held (ie that
I don't need to worry about races between device model functions
called from the guest and the callbacks) ?

There are I think similar questions about the read handler and event
handler functions that every UART model registers with the
qemu_chr_fe_set_handlers function: are those only called when the
VM is actually running, or is special casing required for "called
when the VM is stopped?".

And one that I think is true but we don't document: is it the case
that the chardev layer guarantees not to call the chardev's IOReadHandler
unless its IOCanReadHandler has returned OK?

These all seem like things it would be nice to have documented in
include/chardev/char-fe.h :-)  What I would like the answer to be
(as far as is possible) is "the chardev layer handles these issues
so the frontends don't need to"...

thanks
-- PMM
