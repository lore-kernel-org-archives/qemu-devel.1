Received: from eggs.gnu.org ([2001:4830:134:3::10]:52812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <max@m00nbsd.net>) id 1gVvJd-0006Bx-BU
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 04:23:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <max@m00nbsd.net>) id 1gVvJa-0003AT-7m
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 04:23:57 -0500
Received: from 9.mo7.mail-out.ovh.net ([46.105.60.248]:51631)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <max@m00nbsd.net>) id 1gVvJa-00038n-0k
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 04:23:54 -0500
Received: from player793.ha.ovh.net (unknown [10.109.146.132])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id 985F2ECBAF
	for <qemu-devel@nongnu.org>; Sun,  9 Dec 2018 10:23:45 +0100 (CET)
Received: from m00nbsd.net (91-163-239-65.subs.proxad.net [91.163.239.65])
	(Authenticated sender: max@m00nbsd.net)
	by player793.ha.ovh.net (Postfix) with ESMTPSA id 1DEA5BCD236
	for <qemu-devel@nongnu.org>; Sun,  9 Dec 2018 09:23:45 +0000 (UTC)
From: Maxime Villard <max@m00nbsd.net>
Message-ID: <afa2b9f1-f59a-6793-261f-39dac7ec78f5@m00nbsd.net>
Date: Sun, 9 Dec 2018 10:23:36 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] Question about the pc.bios mapping on x86
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi,
I am developing Qemu support for an accelerator, and I'm facing the following
situation:

The accelerator has a MemoryListener, with a region_add function. Qemu calls
region_add a certain number of times. At one point it wants to map pc.bios,
but the HVA it wants pc.bios mapped at happens to be already occupied by a
mapping done previously.

Typically, a previous call to region_add created a mapping entry with
	[HVA=0x...A2F000 GPA=0xFFFC0000 SIZE=0x40000]
and now Qemu calls region_add to create the pc.bios entry with
	[HVA=0x...A4F000 GPA=0x000E0000 SIZE=0x20000]
As you can see the higher half of the previous HVA mapping collides.

My question is the following: what is the expected behavior here? Is it to
munmap the HVA that collides and remap it to GPA=0xE0000? Is it to duplicate
the content pointed to by the colliding HVA into the new GPA?

I have tested a few combinations, but I can't seem to find the right one, so
I prefer to ask directly to clear the confusion.

Sorry if this is a stupid question, but I didn't find a clear explanation
of the expected behavior.

Thanks
