Received: from eggs.gnu.org ([2001:4830:134:3::10]:48859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fQuEr-0008Gy-65
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 08:42:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fQuEq-0006FM-3F
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 08:42:01 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:39704)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fQuEp-0006Ex-Sz
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 08:42:00 -0400
Received: by mail-oi0-x244.google.com with SMTP id t22-v6so8458511oih.6
	for <qemu-devel@nongnu.org>; Thu, 07 Jun 2018 05:41:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180530061711.23673-3-clg@kaod.org>
References: <20180530061711.23673-1-clg@kaod.org>
	<20180530061711.23673-3-clg@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Jun 2018 13:41:38 +0100
Message-ID: <CAFEAcA-=ViCUNBj3H6q0h-=k5ROG=RKy50TRFVd_9aNPiu7Fdw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: Jason Wang <jasowang@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On 30 May 2018 at 07:17, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> The ftgmac100 NIC supports VLAN tag insertion and the MAC engine also
> has a control to remove VLAN tags from received packets.
>
> The VLAN control bits and VLAN tag information are contained in the
> second word of the transmit and receive descriptors. The Insert VLAN
> bit and the VLAN Tag available bit are only valid in the first segment
> of the packet.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

> +        /* Check for VLAN */
> +        if (bd.des0 & FTGMAC100_TXDES0_FTS &&
> +            bd.des1 & FTGMAC100_TXDES1_INS_VLANTAG &&
> +            be16_to_cpu(PKT_GET_ETH_HDR(ptr)->h_proto) !=3D ETH_P_VLAN) =
{

This is kind of bogus because there's no guarantee that h_proto here
is sufficiently aligned to do a halfword load. However this is
a problem common to all the PKT_GET_* macros so we should probably
attack it separately to this series.

Getting the ethernet h_proto field seems common enough that
something like

static inline uint16_t eth_get_proto(uint8_t *pkt)
{
    return lduw_be_p(&PKT_GET_ETH_HDR(pkt)->h_proto);
}

would be handy in eth.h.


Anyway, I've applied this series to target-arm.next.

thanks
-- PMM
