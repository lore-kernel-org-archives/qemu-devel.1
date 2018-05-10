Received: from eggs.gnu.org ([2001:4830:134:3::10]:41797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fGnLO-00063a-4Z
	for qemu-devel@nongnu.org; Thu, 10 May 2018 11:18:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fGnLM-0001M4-W5
	for qemu-devel@nongnu.org; Thu, 10 May 2018 11:18:58 -0400
Received: from mail-oi0-x231.google.com ([2607:f8b0:4003:c06::231]:44388)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fGnLM-0001Lj-Qz
	for qemu-devel@nongnu.org; Thu, 10 May 2018 11:18:56 -0400
Received: by mail-oi0-x231.google.com with SMTP id e80-v6so2063946oig.11
	for <qemu-devel@nongnu.org>; Thu, 10 May 2018 08:18:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180509034658.26455-1-f4bug@amsat.org>
References: <20180509034658.26455-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 May 2018 16:18:35 +0100
Message-ID: <CAFEAcA-LX2NfmZ_03O0XvtThbZ6Sa2SfTAFCneXyCghEousx3w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 00/14] sdcard: Proper implementation of
 CRC7
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Alistair Francis <alistair@alistair23.me>

On 9 May 2018 at 04:46, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote=
:
> Hi,
>
> This series emerged after last Coverity scan and Peter suggestion in:
> http://lists.nongnu.org/archive/html/qemu-devel/2018-04/msg05046.html
>
>     (3) "proper" implementation of CRC, so that an sd controller
>     can either (a) mark the SDRequest as "no CRC" and have
>     sd_req_crc_validate() always pass, or (b) mark the SDRequest
>     as having a CRC and have sd_req_crc_validate() actually
>     do the check which it currently stubs out with "return 0"
>
> - Coverity issues fixed
> - new functions documented
> - qtests added
>
> This series would be much smaller without qtests (less refactor and code
> movement), but I feel more confident having them passing :)

This series isn't going in the direction I expected.

We have two cases:
 (1) we model an SD controller which in hardware calculates its
     own checksums. Most of our SD controllers are like that.
     Since in QEMU there is no chance of data corruption between
     the controller and the card, there's no point in calculating
     a checksum by calling a function, and then checking that we
     get the same result a few function calls later when we call
     the exact same function in the SD card model. So we should
     just unconditionally say "no checksum provided" in the
     SDRequest struct the controller fills in, and then skip
     the check in the card model.
 (2) we model an SD controller which leaves the checksum calculation
     to guest software. The only one of these we have that I know
     of is milkymist-memcard. In this case, the checksum is calculated
     by guest software, and so we do want to check it in the SD
     card model. So the controller should fill in the CRC field
     in SDRequest, and set the flag in SDRequest to say "checksum
     provided".

We don't need to provide a property on the device or the
card objects to control this behaviour, for either case.

I'm not clear why this patchset has removed the SDRequest struct
in favour of a raw buffer, either: that makes it harder to just
say "this request doesn't have a checksum you need to check".

thanks
-- PMM
