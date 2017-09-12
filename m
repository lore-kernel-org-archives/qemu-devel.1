Received: from eggs.gnu.org ([2001:4830:134:3::10]:51353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1droF0-0000Gp-Ly
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 12:40:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1droEz-00082W-Aj
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 12:40:50 -0400
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:45891)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1droEz-00081a-2c
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 12:40:49 -0400
Received: by mail-wm0-x22e.google.com with SMTP id f199so61777203wme.0
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 09:40:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <ca218563-0789-f11d-fa7b-895998a1a84d@amsat.org>
References: <1505232834-20890-1-git-send-email-peter.maydell@linaro.org>
	<ca218563-0789-f11d-fa7b-895998a1a84d@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Sep 2017 17:40:27 +0100
Message-ID: <CAFEAcA8BgKzRpK8gQRUZ7qOJkpS-yQkYpxt=1pq-FuT7XXB5vQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] mps2-an511: Fix wiring of UART overflow
 interrupt lines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-stable <qemu-stable@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, qemu-arm <qemu-arm@nongnu.org>

On 12 September 2017 at 17:22, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
> wrote:
> (CC'ed qemu-arm)
>
> Hi Peter,
>
> On 09/12/2017 01:13 PM, Peter Maydell wrote:
>>
>> Fix an error that meant we were wiring every UART's overflow
>> interrupts into the same inputs 0 and 1 of the OR gate,
>> rather than giving each its own input.
>
>
> oops tricky to catch
>
>>
>> Cc: qemu-stable@nongnu.org
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>   hw/arm/mps2.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
>> index abb0ab6..769cff8 100644
>> --- a/hw/arm/mps2.c
>> +++ b/hw/arm/mps2.c
>
>
>         /* The overflow IRQs for all UARTs are ORed together.
>          * Tx and Rx IRQs for each UART are ORed together.
>          */
>
> can you update this comment?

The comment is correct. "txrx_orgate_dev" is a 2-input OR gate,
which we create one of per UART. It ORs together the TX IRQ
and the RX IRQ. "orgate_dev" is a 10-input OR gate, which ORs
together the TX overflow IRQ and the RX overflow IRQ from each
UART. The bug here is just that we were using the wrong input
pins on orgate_dev.

thanks
-- PMM
