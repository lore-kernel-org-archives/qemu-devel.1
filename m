Received: from eggs.gnu.org ([2001:4830:134:3::10]:53844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton@lastline.com>) id 1dZpKC-0000CQ-Ao
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 22:11:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton@lastline.com>) id 1dZpKB-0002wp-8N
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 22:11:52 -0400
Received: from mail-qt0-x22a.google.com ([2607:f8b0:400d:c0d::22a]:37965)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <anton@lastline.com>) id 1dZpKB-0002wD-2p
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 22:11:51 -0400
Received: by mail-qt0-x22a.google.com with SMTP id t37so25776846qtg.5
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 19:11:48 -0700 (PDT)
MIME-Version: 1.0
From: Anton Malyshenok <anton@lastline.com>
Date: Mon, 24 Jul 2017 19:11:47 -0700
Message-ID: <CAEgyHnFCLW-XH9TWWFfM44TxZsk9ev+4DVrGAA=t1mifUuYJZg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Software breakpoints in QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hello QEMU developers,
I'm trying to understand how QEMU software breakpoints work, but I get
stuck in one use-case.
Basically when you call kvm_insert_breakpoint for virtual_address1, it will
look if there is already breakpoint descriptor
in cpu->kvm_state->kvm_sw_breakpoints at virtual_address1. And if nothing
found it will install breakpoint or increment ref counter for an existing
descriptor otherwise. To install breakpoint it basically writes int3
instruction to guest physical memory, ignoring copy-on-write or other
attributes of the page.
The problem arise when you have shared memory between processes. This
mechanism only works if shared memory is pointed by the same virtual
address in all the processes. But it will case unhandled exception in a
guest process if there are 2 different virtual addresses corresponding to
the same physical address. So in this case if we install breakpoint in one
of those virtual addresses, int3 instruction will be written to physical
address pointed by 2 (or more) different virtual addreses, but only one
breakpoint descriptor will be created. Crash happens when breakpoint
triggers at virtual address for which there is no breakpoint descriptor.

Do I understand in correctly, or I'm missing something?

Looking forward to your answer,
Anton
