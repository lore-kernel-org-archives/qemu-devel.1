Received: from eggs.gnu.org ([209.51.188.92]:40094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1goRmm-0004CM-PS
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 06:42:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1goRmm-0003EP-3O
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 06:42:36 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:43608)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1goRmj-0003Dm-TI
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 06:42:34 -0500
Received: by mail-ot1-x343.google.com with SMTP id a11so17550727otr.10
	for <qemu-devel@nongnu.org>; Tue, 29 Jan 2019 03:42:31 -0800 (PST)
MIME-Version: 1.0
References: <20190124141147.8416-1-stefanha@redhat.com>
	<CAFEAcA_NBtWFZi8G8goXrX0OHHeHheW6MK3W9ByHVi1DNX3JWw@mail.gmail.com>
In-Reply-To: <CAFEAcA_NBtWFZi8G8goXrX0OHHeHheW6MK3W9ByHVi1DNX3JWw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 Jan 2019 11:42:19 +0000
Message-ID: <CAFEAcA-62rkQ4AQ1FQD3C4qn8tfxREu6BJuAdfw+VS95zS3Ung@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] tests/microbit-test: Add tests for nRF51
 NVMC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Steffen_G=C3=B6rtz?= <contrib@steffen-goertz.de>, Jim Mussared <jim@groklearning.com>, Thomas Huth <thuth@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>, Julia Suvorova <jusual@mail.ru>, Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>

On Mon, 28 Jan 2019 at 19:01, Peter Maydell <peter.maydell@linaro.org> wrote:
> This assertion fails on PPC64 hosts:
> ERROR:/home/pm215/qemu/tests/microbit-test.c:181:fill_and_erase:
> assertion failed (qtest_readl(qts, base + i * 4) == i): (16777216 ==
> 1)
>
> I suspect an endianness issue, given that 16777216 is 0x0100_0000.
> The test looks OK, though -- a word write ought to come back
> the same on a word read -- so maybe it's in the implementation?

The problem here is that the read path goes directly to the
underlying host memory, but the write path goes via the
flash_write() function, and the two disagree about the
representation of the underlying storage.

I think that declaring s->storage to be a uint32_t* is a mistake --
the underlying RAM needs to be treated as a byte array, not as an
array of host-endian-order 32-bit words (because the direct-to-RAM
path effectively treats it as a byte array). Then, since the
flash_write() function is part of a DEVICE_LITTLE_ENDIAN
MemoryRegionOps, its 'value' argument is a 32-bit LE value, and
it should do the modification of s->storage via something like
   oldval = ldl_le_p(s->storage + offset);
   oldval &= value;
   stl_le_p(s->storage + offset, oldval);

Another reference to s->storage also simplifies when we fix its
type: s->storage + value / 4 becomes just s->storage + value.

NB: untested!

thanks
-- PMM
