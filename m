Received: from eggs.gnu.org ([2001:4830:134:3::10]:33449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ePuVm-0000Pq-Jm
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:15:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ePuVl-0002Ia-NI
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:15:06 -0500
Received: from mail-ot0-x235.google.com ([2607:f8b0:4003:c0f::235]:45454)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ePuVl-0002IC-Gx
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:15:05 -0500
Received: by mail-ot0-x235.google.com with SMTP id 103so8491410otj.12
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 10:15:05 -0800 (PST)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Dec 2017 18:14:43 +0000
Message-ID: <CAFEAcA_ZQmkJ0QLCaL=sehc6bvS=yDWtsDGd=wdwZBoePEp9Vg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] MTTCG and atomicity of loads and stores from QEMU C
 helper functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Richard Henderson <rth@twiddle.net>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, "Emilio G. Cota" <cota@braap.org>

We have a fair amount of code in QEMU which is helper functions
written in C which make guest memory accesses -- the most common
case being page table walk code.

Generally in CPU architectures the accesses by things like the
page table walker have some atomicity guarantees. For instance
Arm requires that reads of translation tables are single-copy-atomic
(v8A Arm ARM rev B.a section B2.2.1). If we supported the
hardware management of the Access flag (we don't currently) that
wolud have to be an atomic read-modify-write of the descriptor
memory (section D4.4.9).

What's the right API in QEMU to do these guest memory accesses with
the required atomicity guarantees? Currently target/arm uses
address_space_ldq_le(), which turns into a ldq_he_p(), which is
a memcpy(), which I don't think is guaranteed to be a 64-bit load.
And I don't think we have an accessor function for doing an atomic
read-modify-write, do we?

[I think one of the PPC maintainers first brought this issue up on
IRC some while back, but I'm afraid I can't remember who that was.]

thanks
-- PMM
