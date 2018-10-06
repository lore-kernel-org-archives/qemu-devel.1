Received: from eggs.gnu.org ([2001:4830:134:3::10]:34513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g8uOA-0000Ad-6d
	for qemu-devel@nongnu.org; Sat, 06 Oct 2018 17:45:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g8uO8-0007Ip-7j
	for qemu-devel@nongnu.org; Sat, 06 Oct 2018 17:45:30 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:33639)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1g8uO8-00075Q-29
	for qemu-devel@nongnu.org; Sat, 06 Oct 2018 17:45:28 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Sat,  6 Oct 2018 17:45:02 -0400
Message-Id: <20181006214508.5331-1-cota@braap.org>
Subject: [Qemu-devel] [RFC 0/6] Dynamic TLB sizing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Pranith Kumar <bobby.prani@gmail.com>, Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

After reading this paper [1], I wondered whether how far one
could push the idea of dynamic TLB resizing. We discussed
it briefly in this thread:

 https://lists.gnu.org/archive/html/qemu-devel/2018-09/msg02340.html

Since then, (1) rth helped me (thanks!) with TCG backend code,
and (2) I've abandoned the idea of substituting malloc
for memset, and instead focused on dynamically resizing the
TLBs. The rationale is that if a process touches a lot of
memory, having a large TLB will pay off, since the perf
gains will dwarf the increased cost of flushing via memset.

This series shows that the indirection necessary to do this
does not cause a perf decrease, at least for x86_64 hosts.

This series is incomplete, since it only implements changes
to the i386 backend, and it probably only works on x86_64.
But the whole point is to (1) see whether the performance gains
are worth it, and (2) discuss how crazy this approach is. I was
looking for things to break badly, but so far I've found no obvious
issues. But there might be some assumptions about the TLB size
baked in the code that I might have missed, so please point those
out if they exist.

Performance numbers are in the last patch.

You can fetch this series from:
  https://github.com/cota/qemu/tree/tlb-dyn

Note that it applies on top of my tlb-lock-v3 series:
  https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg01087.html

Thanks,

		Emilio

[1] "Optimizing Memory Translation Emulation in Full System Emulators",
Tong et al, TACO'15 https://dl.acm.org/citation.cfm?id=2686034
