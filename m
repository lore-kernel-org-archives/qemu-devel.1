Received: from eggs.gnu.org ([2001:4830:134:3::10]:35030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danix800@gmail.com>) id 1eHNBd-0005TL-MV
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 00:03:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danix800@gmail.com>) id 1eHNBc-00082d-0G
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 00:03:01 -0500
Received: from mail-it0-x242.google.com ([2607:f8b0:4001:c0b::242]:45848)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <danix800@gmail.com>) id 1eHNBb-00082W-Pm
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 00:02:59 -0500
Received: by mail-it0-x242.google.com with SMTP id x13so4733247iti.4
	for <qemu-devel@nongnu.org>; Tue, 21 Nov 2017 21:02:59 -0800 (PST)
MIME-Version: 1.0
From: Ding Fei <danix800@gmail.com>
Date: Wed, 22 Nov 2017 13:02:58 +0800
Message-ID: <CAPVVTEDB_846TRwzZh6XEqbRxpTSDiZ0iH7wTw4Q+dck-ec1mA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Why qemu with kvm enabled can boot kernel even if
 identity page map is not set correctly?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi all. Firstly, sorry if it's the wrong place to ask such a question!

In the early stages of boot process, kernel need identity mapped page
setup when switching gdt

[https://github.com/torvalds/linux/blob/ed30b147e1f6e396e70a52dbb6c7d66befedd786/arch/x86/kernel/head_64.S#L133-L137]

as code here

[https://github.com/torvalds/linux/blob/ed30b147e1f6e396e70a52dbb6c7d66befedd786/arch/x86/kernel/head64.c#L98-L138]

implies. That's why the first few entries of early_dynamic_pgts are
set to map the kernel text range [_text, _end].
But as we discussed about the role of these entries, we delete them

[https://github.com/torvalds/linux/blob/ed30b147e1f6e396e70a52dbb6c7d66befedd786/arch/x86/kernel/head64.c#L98-L138]

and recompile the kernel, then test it on qemu. Without '-enable-kvm'
option the kernel won't boot as we expected,
but with kvm option on, the kernel can boot and everything runs well,
really to our surprise.

So I guess there are something under the hood done by kvm, which
doesn't obey the rules of
how a real physical machine behaves.

I've setup a debug environment that the page table mis-configed kernel
runs inside qemu, which nested inside
vmware workstation with EPT enabled, and gdb on the host to debug the
kernel kvm of vmware kernel.

But without any luck I've spent a whole day try to catch what is
happening inside kvm, I still can't figure out the
real magic point that jump through the broken page table. It seems
that the code just jumps randomly.

Can anyone confirm what we've observed? Is it designed to be like that?
Any details or explanation would be really appreciated!

-- 
Best Regards

Ding Fei
E-mail: danix800@gmail.com
