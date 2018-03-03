Received: from eggs.gnu.org ([2001:4830:134:3::10]:40421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anatoly.trosinenko@gmail.com>) id 1es9bV-0007FE-EO
	for qemu-devel@nongnu.org; Sat, 03 Mar 2018 11:01:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anatoly.trosinenko@gmail.com>) id 1es9bU-0006mN-Ek
	for qemu-devel@nongnu.org; Sat, 03 Mar 2018 11:01:45 -0500
MIME-Version: 1.0
In-Reply-To: <57abe9de-1258-3624-2f8a-882f1de1d19d@weilnetz.de>
References: <20180127134908.24095-1-anatoly.trosinenko@gmail.com>
	<20180127134908.24095-2-anatoly.trosinenko@gmail.com>
	<aab013fb-5ada-6ee5-d038-0277d8ef0b24@weilnetz.de>
	<CAE5jQCfxjM9ykBCes0oDhrc0B6g8AC5Se39sXBsbZo=-dKQpyg@mail.gmail.com>
	<CAE5jQCe8O3BT=6SDdm2p7J_wxgzZTcqhyS1mfnEr=4tci9fipg@mail.gmail.com>
	<efe4a642-a220-5a40-b1e0-769a4216389d@twiddle.net>
	<CAE5jQCcCA=3kkVa=5eMZs-BGAM_p4fZG+GPu1SmQMg7_sPAH5Q@mail.gmail.com>
	<57abe9de-1258-3624-2f8a-882f1de1d19d@weilnetz.de>
From: Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
Date: Sat, 3 Mar 2018 19:01:42 +0300
Message-ID: <CAE5jQCcKo_4iWaNd-+iFNjTCrhnU++GaWfkC+RmouYNufJh0eQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/1] tci: eliminate UB due to unaligned
 reads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>
Cc: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

2018-03-03 18:41 GMT+03:00 Stefan Weil <sw@weilnetz.de>:

> Am 03.03.2018 um 15:07 schrieb Anatoly Trosinenko:
> > Can rewriting TCI in such a way that every operation is aligned at 4- or
> > even 8-byte boundary fix the situation or are there some more serious
> > problems?
>
> That's my preferred solution. Are there cases which would require 8-byte
> alignment?
>

And what if create some function like

uint8_t *align_and_increment(uint8_t **ptr, int pow2) {
  size_t size = 1 << pow2;
  uint8_t *result = (uint8_t*)((((uintptr)*ptr) + size - 1) & ~(size - 1));
  *ptr = result + size;
  return result;
}

and rewrite get / put functions like this:

static uint32_t tci_read_i32(uint8_t **tb_ptr)
{
    uint32_t value = *(uint32_t *)align_and_increment(tb_ptr, 2);
    return value;
}

On one hand, it involves some slightly obscure pointer calculations
(just in one place), on the other hand, no modifications will probably
be required for TCI TCG backend or interpreter loop code (they can
still be useful for **optimizations** of bytecode size, but it should
just work as is).

--
Best regards,
Anatoly
