Received: from eggs.gnu.org ([209.51.188.92]:52588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gnoVR-0005I6-8H
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 12:46:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gnoVQ-0002wO-JI
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 12:46:05 -0500
References: <20190127090306.30826-1-mark.cave-ayland@ilande.co.uk>
	<20190127090306.30826-3-mark.cave-ayland@ilande.co.uk>
	<alpine.BSF.2.21.9999.1901271251060.35973@zero.eik.bme.hu>
	<3dc12858-4254-9da1-7eb2-309948d0d376@ilande.co.uk>
	<5ea37d08-91f6-33cc-b220-f1a96796d794@linaro.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <897875e0-fc56-c280-0cd0-c7e0dac04fa1@ilande.co.uk>
Date: Sun, 27 Jan 2019 17:45:54 +0000
MIME-Version: 1.0
In-Reply-To: <5ea37d08-91f6-33cc-b220-f1a96796d794@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v3 2/8] target/ppc: rework
 vmrg{l, h}{b, h, w} instructions to use Vsr* macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au

On 27/01/2019 17:26, Richard Henderson wrote:

> On 1/27/19 7:19 AM, Mark Cave-Ayland wrote:
>> Could this make the loop slower? I certainly haven't noticed any obvious
>> performance difference during testing (OS X uses merge quite a bit for
>> display rendering), and I'd hope that with a good compiler and modern branch
>> prediction then any effect here would be negligible.
>
> I would expect the i < n/2 loop to be faster, because the assignments are
> unconditional.  FWIW.

Do you have any idea as to how much faster? Is it something that would show up as
significant within the context of QEMU?

As well as eliminating the HI_IDX/LO_IDX constants I do find the updated version much
easier to read, so I would prefer to keep it if possible. What about unrolling the
loop into 2 separate ones e.g.

    for (i = 0; i < ARRAY_SIZE(r->element); i+=2) {
        result.access(i) = a->access(i >> 1);
    }

    for (i = 1; i < ARRAY_SIZE(r->element); i+=2) {
        result.access(i) = b->access(i >> 1);
    }

Would you expect this to perform better than the version proposed in the patchset?


ATB,

Mark.
