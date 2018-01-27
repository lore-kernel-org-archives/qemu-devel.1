Received: from eggs.gnu.org ([2001:4830:134:3::10]:51413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anatoly.trosinenko@gmail.com>) id 1efQrb-0001KH-AZ
	for qemu-devel@nongnu.org; Sat, 27 Jan 2018 08:49:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anatoly.trosinenko@gmail.com>) id 1efQrW-0001mF-Ed
	for qemu-devel@nongnu.org; Sat, 27 Jan 2018 08:49:47 -0500
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:46046)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <anatoly.trosinenko@gmail.com>)
	id 1efQrW-0001lc-77
	for qemu-devel@nongnu.org; Sat, 27 Jan 2018 08:49:42 -0500
Received: by mail-lf0-x242.google.com with SMTP id x196so4009300lfd.12
	for <qemu-devel@nongnu.org>; Sat, 27 Jan 2018 05:49:41 -0800 (PST)
From: Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
Date: Sat, 27 Jan 2018 16:49:07 +0300
Message-Id: <20180127134908.24095-1-anatoly.trosinenko@gmail.com>
Subject: [Qemu-devel] [PATCH 0/1] Fix unaligned reads in the tcg/tci.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Weil <sw@weilnetz.de>, Anatoly Trosinenko <anatoly.trosinenko@gmail.com>

The code in tcg/tci.c reads some data from TCI bytecode through
pointer dereferencing. As far as I know unaligned reads in such a way are
undefined behavior and compiling with -fsanitize=undefined enumerated
them as such at run-time.

I have replaced such reads with invocations of ld{l,q}_he_p.
A comment in include/qemu/bswap.h:310 suggests they should be properly
translated by the compiler. I didn't added signed/unsigned casts
since bswap.h does contain separate signed/unsigned versions
for 16-bit integers but does not for 32- and 64-bit ones, so I supposed
the developers of the bswap.h already arranged everything so
integer promotions don't mess things up. I can add casts in case I'm
not right about it.

Anatoly Trosinenko (1):
  tci: eliminate UB due to unaligned reads

 tcg/tci.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

-- 
2.14.1
