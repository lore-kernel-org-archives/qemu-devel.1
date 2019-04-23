Received: from eggs.gnu.org ([209.51.188.92]:57824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1hIrWK-0001It-8g
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 05:15:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1hIrWH-0002jg-BS
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 05:15:20 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:45606)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1hIrWG-0002iT-I7
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 05:15:17 -0400
Received: by mail-oi1-x241.google.com with SMTP id y84so10665091oia.12
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 02:15:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190418161311.24197-1-stefanha@redhat.com>
	<21091c08-02cf-52de-6d7c-2031dfd38cd5@redhat.com>
	<20190423084349.GA32465@stefanha-x1.localdomain>
In-Reply-To: <20190423084349.GA32465@stefanha-x1.localdomain>
From: Li Qiang <liq3ea@gmail.com>
Date: Tue, 23 Apr 2019 17:14:38 +0800
Message-ID: <CAKXe6SLjfyZQRJ12tRKq6k_aGZQpZsuC9hf-fdH6Hc2f4p_0EA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] security.rst: add Security Guide to
 developer docs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, Eduardo Otubo <otubo@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>

Stefan Hajnoczi <stefanha@redhat.com> =E4=BA=8E2019=E5=B9=B44=E6=9C=8823=E6=
=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=884:49=E5=86=99=E9=81=93=EF=BC=9A

> On Thu, Apr 18, 2019 at 06:47:18PM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
> > On 4/18/19 6:13 PM, Stefan Hajnoczi wrote:
> > > +Virtualization Use Case
> > > +~~~~~~~~~~~~~~~~~~~~~~~
> > > +The virtualization use case covers cloud and virtual private server
> (VPS)
> > > +hosting, as well as traditional data center and desktop
> virtualization.  These
> > > +use cases rely on hardware virtualization extensions to execute gues=
t
> code
> > > +safely on the physical CPU at close-to-native speed.
> > > +
> > > +The following entities are **untrusted**, meaning that they may be
> buggy or
> > > +malicious:
> > > +
> > > +* Guest
> > > +* User-facing interfaces (e.g. VNC, SPICE, WebSocket)
> > > +* Network protocols (e.g. NBD, live migration)
> > > +* User-supplied files (e.g. disk images, kernels, device trees)
> >
> > What about pass-thru USB/PCI devices?
>
> Can you give a real-world example?
>
>

Maybe Philippe means qemu maybe interact with the  malicious USB/PCI
devices.
Just like usb-fuzzer recently added to syzkaller.

I'm not sure how much qemu communicate with the real device in
pass-thru(VFIO?).
If there are too much, it may be take consideration.


Thanks,
Li Qiang



> > > +Guest Isolation
> > > +~~~~~~~~~~~~~~~
> > > +Guest isolation is the confinement of guest code to the virtual
> machine.  When
> > > +guest code gains control of execution on the host this is called
> escaping the
> > > +virtual machine.  Isolation also includes resource limits such as
> CPU, memory,
> > > +disk, or network throttling.  Guests must be unable to exceed their
> resource
> >
> > I'm unsure but I'd have written "... such as throttling of CPU, memory,
> > disk or network".
>
> Will change in v2.
>
> > > +Unexpected Device Accesses
> > > +~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > +The guest may access device registers in unusual orders or at
> unexpected
> > > +moments.  Device emulation code must not assume that the guest
> follows the
> > > +typical "theory of operation" presented in driver writer manuals.
> The guest
> > > +may make nonsense accesses to device registers such as starting
> operations
> > > +before the device has been fully initialized.
> > > +
> > > +A related issue is that device emulation code must be prepared for
> unexpected
> > > +device register accesses while asynchronous operations are in
> progress.  A
> > > +well-behaved guest might wait for a completion interrupt before
> accessing
> > > +certain device registers.  Device emulation code must handle the cas=
e
> where the
> > > +guest overwrites registers or submits further requests before an
> ongoing
> > > +request completes.  Unexpected accesses must not cause memory
> corruption or
> > > +leaks in QEMU.
> >
> > Might worth to tell such unexpected accesses might be logged with
> > 'qemu_log_mask(LOG_GUEST_ERROR, ...) and audited with -d guest_errors?
>
> Will add in v2.
>
> Stefan
>
