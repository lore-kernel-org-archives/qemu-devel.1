Received: from eggs.gnu.org ([209.51.188.92]:55809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gnopz-0001GO-0e
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 13:07:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gnopx-0005nS-QF
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 13:07:18 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:38352)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gnopx-0005mR-Ae
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 13:07:17 -0500
Received: by mail-pl1-x643.google.com with SMTP id e5so6727880plb.5
	for <qemu-devel@nongnu.org>; Sun, 27 Jan 2019 10:07:17 -0800 (PST)
References: <20190127090306.30826-1-mark.cave-ayland@ilande.co.uk>
	<20190127090306.30826-3-mark.cave-ayland@ilande.co.uk>
	<alpine.BSF.2.21.9999.1901271251060.35973@zero.eik.bme.hu>
	<3dc12858-4254-9da1-7eb2-309948d0d376@ilande.co.uk>
	<5ea37d08-91f6-33cc-b220-f1a96796d794@linaro.org>
	<897875e0-fc56-c280-0cd0-c7e0dac04fa1@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3f43ac97-26d0-98b3-a8b4-8102acb73457@linaro.org>
Date: Sun, 27 Jan 2019 10:07:12 -0800
MIME-Version: 1.0
In-Reply-To: <897875e0-fc56-c280-0cd0-c7e0dac04fa1@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au

On 1/27/19 9:45 AM, Mark Cave-Ayland wrote:
>> I would expect the i < n/2 loop to be faster, because the assignments are
>> unconditional.  FWIW.
> 
> Do you have any idea as to how much faster? Is it something that would show
> up as significant within the context of QEMU?

I don't have any numbers on that, no.

> As well as eliminating the HI_IDX/LO_IDX constants I do find the updated
> version much easier to read, so I would prefer to keep it if possible.
> What about unrolling the loop into 2 separate ones...

I doubt that would be helpful.

I would think that

#define VMRG_DO(name, access, ofs)
...
    int i, half = ARRAY_SIZE(r->access(0)) / 2;
...
    for (i = 0; i < half; i++) {
        result.access(2 * i + 0) = a->access(i + ofs);
        result.access(2 * i + 1) = b->access(i + ofs);
    }

where OFS = 0 for HI and half for LO is best.  I find it quite readable, and it
avoids duplicating code between LO and HI as you're currently doing.


r~
