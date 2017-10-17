Received: from eggs.gnu.org ([2001:4830:134:3::10]:32829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vincent.siles@gmail.com>) id 1e4OfC-0002RQ-Ks
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 05:59:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vincent.siles@gmail.com>) id 1e4OfB-0004pq-Gt
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 05:59:54 -0400
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:47060)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <vincent.siles@gmail.com>)
	id 1e4OfB-0004mw-7T
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 05:59:53 -0400
Received: by mail-wm0-x22e.google.com with SMTP id m72so2711983wmc.1
	for <qemu-devel@nongnu.org>; Tue, 17 Oct 2017 02:59:51 -0700 (PDT)
MIME-Version: 1.0
From: Vincent <vincent.siles@gmail.com>
Date: Tue, 17 Oct 2017 11:59:49 +0200
Message-ID: <CADNVbF9yTBsJ_nxAXGsgY7UoMWvNb1LBOuPzetfZniMCHfBaRw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Issue with qemu using EL3 aarch64 and EL1/0 secure in
 aarch32 short descriptors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi !
I'm porting a secure monitor & secure kernel from an ARMv7a context to
ARMv8,
using QEMU 'virt' configuration.

My current working setup is the following:


- secure monitor at aarch64 EL3, without MMU enabled
- secure kernel and applications at aarch32 EL1S/EL0S, with MMU enabled
(LPAE or
not)


I'm working on activating the MMU for the secure monitor, and I'm facing
the following issue: as soon as I update the TCR_EL3 register (even if I
don't actually turn the MMU on by updating SCTLR_EL3), my secure kernel
is OK, but my secure applications using short descriptors always trigger
prefetch abort on the first instruction. LPAE seems to work fine.

I tested the exact same code on ARM's foundation simulator, and the
short descriptor scenario is working fine, so I think there is an issue
in the management of the TCR_EL3 register, when working with EL1/EL0
aarch32 - short descriptor.

The issue seems related to [1] and [2].

Unfortunately I can't provide you yet with a small reproducible example, as
I can't advertise
our secure monitor or secure kernel code. If that's absolutely necessary,
I'll try to provide some
minimal code, but it's going to take some time.

For the record, I'm currently using qemu:

url = https://github.com/qemu/qemu.git
commit 48ae1f60d8c9a770e6da64407984d84e25253c69
Merge: 78b62d3 b867eaa
Author: Peter Maydell <peter.maydell@linaro.org>
Date:   Mon Oct 16 14:28:13 2017 +0100

Best,
V.

[1] https://lists.gnu.org/archive/html/qemu-devel/2016-06/msg02514.html
[2] https://lists.gnu.org/archive/html/qemu-devel/2016-06/msg02506.html
