Received: from eggs.gnu.org ([209.51.188.92]:40931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ml@kernelobjects.org>) id 1hMWll-0003RK-S0
	for qemu-devel@nongnu.org; Fri, 03 May 2019 07:54:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ml@kernelobjects.org>) id 1hMWlk-0000HS-SE
	for qemu-devel@nongnu.org; Fri, 03 May 2019 07:54:25 -0400
Received: from mail.kernelobjects.org ([5.189.137.180]:28880)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ml@kernelobjects.org>) id 1hMWlk-0000Dr-M7
	for qemu-devel@nongnu.org; Fri, 03 May 2019 07:54:24 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.kernelobjects.org (Postfix) with ESMTP id 7ABAF2A09C0
	for <qemu-devel@nongnu.org>; Fri,  3 May 2019 13:47:16 +0200 (CEST)
Received: from mail.kernelobjects.org ([127.0.0.1])
	by localhost (mail.kernelobjects.org [127.0.0.1]) (amavisd-new,
	port 10024) with ESMTP id 5nP4tGviNXgs for <qemu-devel@nongnu.org>;
	Fri,  3 May 2019 13:47:15 +0200 (CEST)
Received: from mlombardo-mac.infra.h26.intra (unknown [89.244.26.92])
	by mail.kernelobjects.org (Postfix) with ESMTPSA id D178F2A02C5
	for <qemu-devel@nongnu.org>; Fri,  3 May 2019 13:47:15 +0200 (CEST)
From: Mario <ml@kernelobjects.org>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Message-Id: <8C02D03E-96CD-414F-BC2C-C59972B26F94@kernelobjects.org>
Date: Fri, 3 May 2019 13:47:15 +0200
Subject: [Qemu-devel] Request for comment - dynamic VNC keyboard mapping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi all,

I have a question related to the VNC server keyboard settings. Currently =
the user of qemu has to decide before VM startup which language is used =
for VNC keyboard mapping. If no keyboard is configured, the en-us =
keyboard will be loaded for keysym to scancode conversion. A later =
reconfiguration of the keyboard is not possible at present.

So here is my idea:

The VNC Display context stores a list of loaded keyboards (like =
vs->vd->kbds). If no keyboard was specified, at least the default will =
be added to the list ("en-us"?). If a client connects, a copy of the =
(latest configured) pointer will be stored within the VncState =
structure. For any keys sent by this client the own keyboard reference =
will be used.

As (in theory) every VNC client may have a differen keyboard layout, in =
my point of view it makes sense to attach the keyboard used for =
keysym2scancode() to the client context rather to the VNC server =
context. However as (most likely) all clients do have the same keyboard =
mapping it would be an overhead to parse and store the mapping list each =
time the client connects.

Now in my idea two mechanisms may change the behavior of the client =
keyboard.

1.) a qmp command was sent, that sets /configures for a =
particular/default keyboard.
2.) within the VNC protocol a =
"VNC_MSG_CLIENT_QEMU/VNC_MSG_CLIENT_QEMU_EXT_KEYBOARD_LAYOUT" message =
arrives

If the new keyboard was not already loaded and stored inside =
vs->vd->kbds , qemu initializes the new mapping. The affected VNC client =
(VncState) again stores the reference only.

This enables switching the keyboard layout during runtime as well as =
using multiple different keyboard layouts at atime.

Together with a corresponding patch I would also add a patch for =
libvncclient to have a reference implmentation for the integrated =
keyboard layout switching.

What are your thoughts about this kind of improvement?

Thanks,
Mario=
