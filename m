Received: from eggs.gnu.org ([2001:4830:134:3::10]:44315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1f3nbE-0004nb-Ju
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 14:57:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1f3nbA-0007oL-O1
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 14:57:36 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:55687)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1f3nbA-0007nh-HC
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 14:57:32 -0400
Received: by mail-wm0-x229.google.com with SMTP id b127so43263549wmf.5
	for <qemu-devel@nongnu.org>; Wed, 04 Apr 2018 11:57:32 -0700 (PDT)
Date: Wed, 4 Apr 2018 20:57:29 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Message-ID: <20180404185729.GB32434@toto>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] TCG MicroBlaze 64-bit extended addressing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, peter.maydell@linaro.org, aurelien@aurel32.net

Hello,

I'm looking at adding support for MicroBlaze extended addressing
allowing 32bit cores to reach a 64-bit address space.

The ABI for MicroBlaze remains 32-bits. It's basically a PAE-like
MMU extension + a new set of extended address Load/Store instructions
for the non-MMU mode.

I'm primarily looking to implement the non-MMU mode now but it's not
entirely clear to me how to do this. It would be nice to avoid multiple
builds of microblaze and keep the address size run-time selectable.

One way I think of is to set:
#define TARGET_VIRT_ADDR_SPACE_BITS 64
#define TARGET_VIRT_ADDR_SPACE_BITS 64

And use a helper with cpu_ld_ hacks to do 64-bit loads.

If I set TARGET_LONG_BITS=64 I can avoid the helper hack but
IIUC, now all load stores need to take TCGv_i64's which
complicates things a little in the translator since we now
need to "emulate" the 32bit mode (common-case) with 64-bit addresses
(wraps and such).
Also, I'm guessing I'd need to set TARGET_ABI32 to avoid breaking
linux-user.

Does someone have any good suggestions or opinion on what the
right way is?
Am I missing something?

Cheers,
Edgar
