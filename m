Received: from eggs.gnu.org ([2001:4830:134:3::10]:46343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dU6zJ-0004R1-3r
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 03:50:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dU6zD-0002zI-VK
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 03:50:40 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:53155)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dU6zD-0002vK-Nz
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 03:50:35 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Sun,  9 Jul 2017 03:49:52 -0400
Message-Id: <1499586614-20507-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH 00/22] tcg: per-thread TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>

Original RFC here:
  https://lists.nongnu.org/archive/html/qemu-devel/2017-06/msg06874.html

I included Richard's feedback (Thanks!) from the original RFC, and
added quite a few things. This is now a proper PATCHset since it is
a lot more mature.

Highlights:
- It works! I tested single/multi-threaded arm, aarch64 and alpha softmmu
  with various -smp's (up to 120 on aarch64) and -tb-size's.
  Also tested x86_64-linux-user with multi-threaded code. valgrind's
  drd shows no obvious issues (it doesn't swallow C11 atomics, so it
  spits out a lot of false positives though). Have not tested on a
  non-x86 host, but given the audit I did of global non-const variables
  (see commit message in patch 21), it should be OK.

- Region-based allocation to maximize code_gen_buffer utilization.
  See patch 20.

- Patches 1-8 are unrelated fixes, but I'm keeping them as part of this
  series to avoid merge headaches later on.

- Performance-wise we get a 20% improvement when booting+shutting down
  debian-arm with MTTCG and -smp 8 (see patch 22). Not bad! This is due
  to not holding tb_lock during code translation, although the fact that
  we still have to take it after every translation remains a scalability
  issue. But before focusing on that, I'd like to get this reviewed.

I broke down features as much as possible, so that we do not end up
with a "per-thread TCG" megapatch.

The series applies on top of the current master (b11365867568).

Thanks,

		Emilio
