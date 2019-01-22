Received: from eggs.gnu.org ([209.51.188.92]:41942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gm10x-0000s8-MW
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:43:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gm10o-0002Vp-PS
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:43:07 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:43509)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gm10n-0002T2-QD
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:43:02 -0500
Received: by mail-wr1-x444.google.com with SMTP id r10so28552595wrs.10
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 10:43:00 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Jan 2019 18:18:20 +0000
Message-Id: <20190122181822.1505-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 0/2] slirp: fix -Waddress-of-packed-member
 warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jan Kiszka <jan.kiszka@siemens.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

These patches fix the clang -Waddress-of-packed-member warnings
in the slirp code. For slirp, the structs marked as packed
are already naturally packed/aligned, so adding the 'packed'
attribute doesn't change their layout but means the compiler
has to assume they might be misaligned. Instead, for the structs
which map to on-the-wire packet formats, we add build time
assertions that they have the sizes we think they should.

The 'struct ipq' and 'struct ipasfrag' aren't on-the-wire
packet representations, so it's not clear why they were
marked packed in the first place. (They contain host pointers
and so have a size that depends on the host.) Here we just
assert the only thing that's documented as a layout restriction:
that struct ipq's frag_link and struct ipasfrag's ipf_link
are at the same offset.

Together, this fixes all the -Waddress-of-packed-member warnings
in slirp, which I think was the only set remaining without
patches at least being on-list. (Some of the block/ warning fixes
are still working their way through the relevant trees.)

thanks
-- PMM

Peter Maydell (2):
  slirp: Avoid marking naturally packed structs as QEMU_PACKED
  slirp: Don't mark struct ipq or struct ipasfrag as packed

 slirp/ip.h       |  7 +++++--
 slirp/ip6.h      | 12 ++++++++++--
 slirp/ip6_icmp.h | 20 +++++++++++++++-----
 3 files changed, 30 insertions(+), 9 deletions(-)

-- 
2.20.1
