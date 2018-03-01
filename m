Received: from eggs.gnu.org ([2001:4830:134:3::10]:34159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1erPGO-0006xJ-PZ
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 09:32:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1erPGN-0000Sy-QI
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 09:32:52 -0500
References: <1519898536-19027-1-git-send-email-frederic.konrad@adacore.com>
	<1625eda8-021b-b7bc-2c41-f87724b95efa@amsat.org>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <10413292-41b2-761c-9d2f-dc34c66eab9e@adacore.com>
Date: Thu, 1 Mar 2018 15:32:48 +0100
MIME-Version: 1.0
In-Reply-To: <1625eda8-021b-b7bc-2c41-f87724b95efa@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] grlib_apbuart: always
 enable tx and rx
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, mark.cave-ayland@ilande.co.uk, jcd@tribudubois.net

Hi Phil,

I see your point. But I tend to prefer modifying the uart than
having a bunch of hand assembled code in the machine.

Note that the result is the same.

Thanks,
Fred

On 03/01/2018 11:49 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Frederic,
>=20
> On 03/01/2018 07:02 AM, KONRAD Frederic wrote:
>> We often use a bootloader for this board. So lets set the uart in a st=
ate
>> which it can emit characters as if we were using a bootloader.
>>
>> Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
>> ---
>>   hw/char/grlib_apbuart.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/char/grlib_apbuart.c b/hw/char/grlib_apbuart.c
>> index bac11be..a8020ea 100644
>> --- a/hw/char/grlib_apbuart.c
>> +++ b/hw/char/grlib_apbuart.c
>> @@ -265,8 +265,8 @@ static void grlib_apbuart_reset(DeviceState *d)
>>  =20
>>       /* Transmitter FIFO and shift registers are always empty in QEMU=
 */
>>       uart->status =3D  UART_TRANSMIT_FIFO_EMPTY | UART_TRANSMIT_SHIFT=
_EMPTY;
>> -    /* Everything is off */
>> -    uart->control =3D 0;
>> +    /* Enable Tx and Rx as the bootloader would do */
>> +    uart->control =3D UART_RECEIVE_ENABLE | UART_TRANSMIT_ENABLE;
>=20
> I don't think this is the correct approach, as we want to reflect the
> real hardware behavior here.
>=20
> I think the correct QEMU-way is add a tiny asm bootloader in ram in
> leon3_generic_hw_init(), which enables the UART.
> See write_bootloader() in hw/mips/mips_fulong2e.c for example.
>=20
> Regards,
>=20
> Phil.
>=20
>>       /* Flush receive FIFO */
>>       uart->len =3D 0;
>>       uart->current =3D 0;
>>
