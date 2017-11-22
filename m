Received: from eggs.gnu.org ([2001:4830:134:3::10]:52852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1eHbaQ-0002YK-Nf
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 15:25:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1eHbaP-0006Zw-Ra
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 15:25:34 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8H=tSbr4hdz5eDqHPkmDx0qvuRNdttim3m1JB0YqPUnQ@mail.gmail.com>
References: <20171106154813.19936-1-andrew.smirnov@gmail.com>
	<20171106154813.19936-8-andrew.smirnov@gmail.com>
	<CAFEAcA8H=tSbr4hdz5eDqHPkmDx0qvuRNdttim3m1JB0YqPUnQ@mail.gmail.com>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Wed, 22 Nov 2017 12:25:30 -0800
Message-ID: <CAHQ1cqEVbbKzRD6O9SU2idMeRwi+tqB2h1eVz=QOyH1+e76=9Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 07/30] imx_fec: Add support for multiple
 Tx DMA rings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>, Andrey Yurovsky <yurovsky@gmail.com>

On Tue, Nov 21, 2017 at 9:44 AM, Peter Maydell <peter.maydell@linaro.org> w=
rote:
> On 6 November 2017 at 15:47, Andrey Smirnov <andrew.smirnov@gmail.com> wr=
ote:
>> More recent version of the IP block support more than one Tx DMA ring,
>> so add the code implementing that feature.
>>
>> Cc: Peter Maydell <peter.maydell@linaro.org>
>> Cc: Jason Wang <jasowang@redhat.com>
>> Cc: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> Cc: qemu-devel@nongnu.org
>> Cc: qemu-arm@nongnu.org
>> Cc: yurovsky@gmail.com
>> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
>
>>  static const VMStateDescription vmstate_imx_eth =3D {
>>      .name =3D TYPE_IMX_FEC,
>> -    .version_id =3D 2,
>> -    .minimum_version_id =3D 2,
>> +    .version_id =3D 3,
>> +    .minimum_version_id =3D 3,
>>      .fields =3D (VMStateField[]) {
>>          VMSTATE_UINT32_ARRAY(regs, IMXFECState, ENET_MAX),
>>          VMSTATE_UINT32(rx_descriptor, IMXFECState),
>> -        VMSTATE_UINT32(tx_descriptor, IMXFECState),
>> -
>> +        VMSTATE_UINT32_ARRAY(tx_descriptor, IMXFECState, ENET_TX_RING_N=
UM),
>> +        VMSTATE_UINT32(tx_ring_num, IMXFECState),
>>          VMSTATE_UINT32(phy_status, IMXFECState),
>>          VMSTATE_UINT32(phy_control, IMXFECState),
>>          VMSTATE_UINT32(phy_advertise, IMXFECState),
>
> tx_ring_num is constant for any particular instantiation of the device,
> so you don't need to put it in the vmstate.
>
> It's pretty trivial to make this vmstate compatible with the old
> ones for the existing single-tx-descriptor devices, so we might as well:
>
> /* Versions of this device with more than one TX descriptor
>  * save the 2nd and 3rd descriptors in a subsection, to maintain
>  * migration compatibility with previous versions of the device
>  * that only supported a single descriptor.
>  */
> static bool txdescs_needed(void *opaque) {
>     IMXFECState *s =3D opaque;
>
>     return s->tx_ring_num > 1;
> }
>
> static const VMStateDescription vmstate_imx_eth_txdescs =3D {
>     .name =3D "imx.fec/txdescs",
>     .version_id =3D 1,
>     .minimum_version_id =3D 1,
>     .needed =3D txdescs_needed,
>     .fields =3D (VMStateField[]) {
>          VMSTATE_UINT32(tx_descriptor[1], IMXFECState),
>          VMSTATE_UINT32(tx_descriptor[2], IMXFECState),
>          VMSTATE_END_OF_LIST()
>     }
> };
>
> and then add this to the vmx_state_eth at the end:
>     .subsections =3D (const VMStateDescription*[]) {
>          &vmstate_imx_eth_txdescs,
>          NULL
>     }
>
> Then you don't need to bump version_id/minimum_version_id on the
> vmstate_imx_eth struct.
>

Cool, sounds good. Will add that to the patch in v4.

>> @@ -791,6 +821,7 @@ static void imx_eth_write(void *opaque, hwaddr offse=
t, uint64_t value,
>>                             unsigned size)
>>  {
>>      IMXFECState *s =3D IMX_FEC(opaque);
>> +    const bool single_tx_ring =3D s->tx_ring_num !=3D 3;
>
> This looks odd -- I would have expected "single_tx_ring =3D
> s->tx_ring_num =3D=3D 1" ...

AFAIK the HW that's out there will have either 3 or 1 Tx ring, so
that's why I wrote it this way. I'll change the logic to the way your
suggest to avoid surprising the reader.

Thanks,
Andrey Smirnov
