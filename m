Received: from eggs.gnu.org ([2001:4830:134:3::10]:33428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fQuzx-0004jj-R1
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 09:30:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fQuzu-0001Cn-KB
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 09:30:41 -0400
Received: from 9.mo68.mail-out.ovh.net ([46.105.78.111]:38910)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fQuzu-00011a-Dz
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 09:30:38 -0400
Received: from player796.ha.ovh.net (unknown [10.109.120.5])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 533ACE6EE4
	for <qemu-devel@nongnu.org>; Thu,  7 Jun 2018 15:30:28 +0200 (CEST)
References: <20180530061711.23673-1-clg@kaod.org>
	<20180530061711.23673-3-clg@kaod.org>
	<CAFEAcA-=ViCUNBj3H6q0h-=k5ROG=RKy50TRFVd_9aNPiu7Fdw@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <e9021749-fcb8-a9d3-1cdd-396bc7d68fc2@kaod.org>
Date: Thu, 7 Jun 2018 15:30:22 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-=ViCUNBj3H6q0h-=k5ROG=RKy50TRFVd_9aNPiu7Fdw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/4] ftgmac100: add IEEE 802.1Q VLAN
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Jason Wang <jasowang@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 06/07/2018 02:41 PM, Peter Maydell wrote:
> On 30 May 2018 at 07:17, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>> The ftgmac100 NIC supports VLAN tag insertion and the MAC engine also
>> has a control to remove VLAN tags from received packets.
>>
>> The VLAN control bits and VLAN tag information are contained in the
>> second word of the transmit and receive descriptors. The Insert VLAN
>> bit and the VLAN Tag available bit are only valid in the first segment
>> of the packet.
>>
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>=20
>> +        /* Check for VLAN */
>> +        if (bd.des0 & FTGMAC100_TXDES0_FTS &&
>> +            bd.des1 & FTGMAC100_TXDES1_INS_VLANTAG &&
>> +            be16_to_cpu(PKT_GET_ETH_HDR(ptr)->h_proto) !=3D ETH_P_VLA=
N) {
>=20
> This is kind of bogus because there's no guarantee that h_proto here
> is sufficiently aligned to do a halfword load. However this is
> a problem common to all the PKT_GET_* macros so we should probably
> attack it separately to this series.
>=20
> Getting the ethernet h_proto field seems common enough that
> something like
>=20
> static inline uint16_t eth_get_proto(uint8_t *pkt)
> {
>     return lduw_be_p(&PKT_GET_ETH_HDR(pkt)->h_proto);
> }
>=20
> would be handy in eth.h.

yes. There are a few candidates :

hw/net/virtio-net.c:        int vid =3D lduw_be_p(ptr + 14) & 0xfff;
hw/net/e1000e_core.c:        uint16_t vid =3D lduw_be_p(buf + 14);
hw/net/rtl8139.c:            lduw_be_p(&buf[ETH_ALEN * 2]) =3D=3D ETH_P_V=
LAN) {
hw/net/e1000x_common.c:    uint16_t eth_proto =3D lduw_be_p(buf + 12);
hw/net/e1000.c:        uint16_t vid =3D lduw_be_p(buf + 14);
hw/net/e1000.c:        vlan_special =3D cpu_to_le16(lduw_be_p(filter_buf =
+ 14));

Thanks,

C.=20

> Anyway, I've applied this series to target-arm.next.
>=20
> thanks
> -- PMM
>=20
