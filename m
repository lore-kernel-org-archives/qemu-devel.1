Received: from eggs.gnu.org ([2001:4830:134:3::10]:45579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dNzOS-0001Mi-CK
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 06:31:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dNzOP-0000Ez-79
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 06:31:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36094)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dNzOO-0000Eq-Vt
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 06:31:17 -0400
References: <CAFEAcA90vjbr=CM9i9m7-PdN0NB=MV8W0+wsG9UrNNR+KENsmA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d947c58b-d388-c432-0f40-b019af88c60a@redhat.com>
Date: Thu, 22 Jun 2017 12:31:11 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA90vjbr=CM9i9m7-PdN0NB=MV8W0+wsG9UrNNR+KENsmA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] qemu_chr_fe_add_watch interaction with VM
 start/stop/migrate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>



On 22/06/2017 12:09, Peter Maydell wrote:
> For instance, suppose my UART tries to write to the chardev but
> can't, so it registers a callback with qemu_chr_fe_add_watch().
> Then the user stops the VM. Does the chardev UI guarantee that
> my callback won't get called until the user restarts the VM,
> or does my callback function have to do something to say "don't
> actually update the emulation state if we're stopped"?
> If the user then restarts the VM, do I need to do something to
> retry the chardev write?

Currently, chardev code runs normally between stop and start.

> For migration, if we're migrating in the state where I have a
> pending character I'd like to write to the chardev, what do I need
> to do on the destination side? Do I need to call qemu_chr_fe_add_watch
> in the post-load function, or is this too early and I need to do
> something to call it when the destination VM is actually restarted?

Post-load is fine.  There could be interesting interactions with
interrupts, but these are not specific to character device backends
(real-time clocks are another example).  So boards should create
interrupt controllers and distributors as soon as possible.

On the save side, when migration is about to finish, the mig thread
takes the I/O thread lock, so chardevs cannot run anymore at that point.

> More generally, am I guaranteed that my qemu_chr_fe_add_watch()
> callbacks are only called with the iothread mutex held (ie that
> I don't need to worry about races between device model functions
> called from the guest and the callbacks) ?

Yes.  Chardev backends can be written to outside the iothread mutex, but
callbacks are always protected by the iothread mutex unless mentioned
specifically by the documentation and even then, only if you run in your
own IOThread.

> There are I think similar questions about the read handler and event
> handler functions that every UART model registers with the
> qemu_chr_fe_set_handlers function: are those only called when the
> VM is actually running, or is special casing required for "called
> when the VM is stopped?".

No special casing is currently done by the other backends.  It seems to
work fine in practice...

> And one that I think is true but we don't document: is it the case
> that the chardev layer guarantees not to call the chardev's IOReadHandl=
er
> unless its IOCanReadHandler has returned OK?

Yes, and no more bytes than the can_read handler has told him to return.

Paolo

> These all seem like things it would be nice to have documented in
> include/chardev/char-fe.h :-)  What I would like the answer to be
> (as far as is possible) is "the chardev layer handles these issues
> so the frontends don't need to"...
