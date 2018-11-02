Received: from eggs.gnu.org ([2001:4830:134:3::10]:51122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gIXUs-0007sg-11
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 07:20:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gIXUr-0004SS-9c
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 07:20:13 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:40738)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gIXUo-0004L4-Nd
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 07:20:11 -0400
Received: by mail-oi1-x244.google.com with SMTP id u130-v6so1278308oie.7
	for <qemu-devel@nongnu.org>; Fri, 02 Nov 2018 04:20:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <3f9658de-e86f-9e6a-3f81-64ddbeccc0a7@ilande.co.uk>
References: <20181101161758.12300-1-peter.maydell@linaro.org>
	<3f9658de-e86f-9e6a-3f81-64ddbeccc0a7@ilande.co.uk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Nov 2018 11:19:48 +0000
Message-ID: <CAFEAcA-f_XgMY=D1udLJtV-j34kqTWK0N+w-8YXeSgPf5SfCSQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-3.1] hw/ppc/mac_newworld: Free
 openpic_irqs array after use
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>

On 2 November 2018 at 11:14, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
> On 01/11/2018 16:17, Peter Maydell wrote:
>
>> In ppc_core99_init(), we allocate an openpic_irqs array, which
>> we then use to collect up the various qemu_irqs which we're
>> going to connect to the interrupt controller. Once we've
>> called sysbus_connect_irq() to connect them all up, the
>> array is no longer required, but we forgot to free it.
>>
>> Since board init is only run once at startup, the memory
>> leak is not a significant one.
>>
>> Spotted by Coverity: CID 1192916.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>  hw/ppc/mac_newworld.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
>> index a630cb81cd8..14273a123e5 100644
>> --- a/hw/ppc/mac_newworld.c
>> +++ b/hw/ppc/mac_newworld.c
>> @@ -303,6 +303,7 @@ static void ppc_core99_init(MachineState *machine)
>>              sysbus_connect_irq(s, k++, openpic_irqs[i][j]);
>>          }
>>      }
>> +    g_free(openpic_irqs);
>>
>>      if (PPC_INPUT(env) == PPC_FLAGS_INPUT_970) {
>>          /* 970 gets a U3 bus */
>>
>
> Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>
> I did notice the generation of this 2D array for the OpenPIC controller whilst
> converting the Mac machines over to qdev, but wasn't exactly sure what to do here so
> I left it.

In some sense the array isn't really necessary at all -- instead
of "fill in array with things; create PIC; sysbus_connect_irq from array"
you could just do "create PIC; sysbus_connect_irq to things".
But for this patch I opted to just free the memory rather than
attempt more complicated refactoring.

thanks
-- PMM
