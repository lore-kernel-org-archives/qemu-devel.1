Received: from eggs.gnu.org ([2001:4830:134:3::10]:52978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ciro.santilli@gmail.com>) id 1dFaSq-0007EP-Uv
	for qemu-devel@nongnu.org; Tue, 30 May 2017 02:17:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ciro.santilli@gmail.com>) id 1dFaSp-0008Hb-Tp
	for qemu-devel@nongnu.org; Tue, 30 May 2017 02:17:08 -0400
Received: from mail-io0-x22b.google.com ([2607:f8b0:4001:c06::22b]:33216)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ciro.santilli@gmail.com>)
	id 1dFaSp-0008HG-PO
	for qemu-devel@nongnu.org; Tue, 30 May 2017 02:17:07 -0400
Received: by mail-io0-x22b.google.com with SMTP id p24so50940360ioi.0
	for <qemu-devel@nongnu.org>; Mon, 29 May 2017 23:17:07 -0700 (PDT)
MIME-Version: 1.0
From: Ciro Santilli <ciro.santilli@gmail.com>
Date: Tue, 30 May 2017 07:16:46 +0100
Message-ID: <CAFXrp_efTq4aM+ryxfsvU9ANKW25P48wZ2hgTnjX8wN1d4EtsQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] How to inject interrupts and modify memory in QEMU
 from external asynchronous interfaces like QMP and QAPI?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I want to create models for external hardware devices.

If interrupts generation and memory modification were possible with
serialized asynchronous APIs like QMP / QAPI, then I would be able to:

- write the models in any language I want
- not need to patch QEMU source code, and keep all my changes off tree

I'm aware of in-tree devices as explained at:
https://stackoverflow.com/questions/28315265/how-to-add-a-new-device-in-qemu-source-code
which are the traditional way of doing things.

What I've found so far:

- interrupts: could only find NMI generation with the `nmi` monitor command
- IO ports: IO possible with `i` and `o` monitor commands, so I'm fine there
- main memory:
    - the ideal solution would be to map memory to host directly, but
that seems hard:
        - <http://kvm.vger.kernel.narkive.com/rto1dDqn/sharing-variables-memory-between-host-and-guest>
        - <https://www.linux-kvm.org/images/e/e8/0.11.Nahanni-CamMacdonell.pdf>
        - <http://www.fp7-save.eu/papers/SCALCOM2016.pdf>
    - memory read is possible through the `x` and `xp` monitor commands
    - could not find how to write to memory with monitor commands. But
I think the GDB API supports, so it should not be too hard to
implement.

The closest working piece of code I could find was:
<https://github.com/texane/vpcie> , which serializes PCI on both
sides, and sends it through QEMU's TCP API. But this is more
inefficient, and requires extra setup on both guest and host.

Also asked on Stack Overflow:
https://stackoverflow.com/questions/44254790/how-to-inject-interrupts-and-modify-memory-in-qemu-from-external-asynchronous-in
