Received: from eggs.gnu.org ([2001:4830:134:3::10]:60217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fNuYl-0006mc-Pz
	for qemu-devel@nongnu.org; Wed, 30 May 2018 02:26:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fNuYg-0004QG-SV
	for qemu-devel@nongnu.org; Wed, 30 May 2018 02:26:11 -0400
Received: from 2.mo179.mail-out.ovh.net ([178.33.250.45]:53671)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fNuYg-0004Ph-L3
	for qemu-devel@nongnu.org; Wed, 30 May 2018 02:26:06 -0400
Received: from player792.ha.ovh.net (unknown [10.109.105.106])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 46C0FC914F
	for <qemu-devel@nongnu.org>; Wed, 30 May 2018 08:26:05 +0200 (CEST)
References: <20180529062838.20556-1-clg@kaod.org>
	<CACPK8Xe9a5q5tvFJ=Q0ArkDnf1-e=cW+bVY6a-peD7hpyLn_jw@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <8363faf8-d2a2-d042-e8f3-6d702d848745@kaod.org>
Date: Wed, 30 May 2018 08:25:59 +0200
MIME-Version: 1.0
In-Reply-To: <CACPK8Xe9a5q5tvFJ=Q0ArkDnf1-e=cW+bVY6a-peD7hpyLn_jw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/6] ftgmac100 and NC-SI enhancements for
 the Aspeed SoC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Joel Stanley <joel@jms.id.au>
Cc: qemu-arm <qemu-arm@nongnu.org>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 05/30/2018 07:35 AM, Joel Stanley wrote:
> On 29 May 2018 at 15:58, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>> Hello,
>>
>> Here is a couple of enhancements and fixes for the ftgmac100 NIC used
>> on the Aspeed SoC. It includes VLAN and multicast support.
>>
>> Following is an assorted set of changes for the NC-SI backend also
>> used on the Aspeed SoC when soldered on OpenPOWER boards. These fix a
>> few problems found when running OpenBMC on aspeed QEMU machines.
>>
>> Thanks,
>>
>> C=C3=A9dric.
>>
>> C=C3=A9dric Le Goater (6):
>>   ftgmac100: compute maximum frame size depending on the protocol
>>   ftgmac100: add IEEE 802.1Q VLAN support
>>   net/ftgmac100: fix multicast hash routine
>>   slirp/ncsi: fix "Get Version ID" payload length
>>   slirp/ncsi: add a "Get Parameter" response
>>   slirp/ncsi: add checksum support
>=20
> I tested these with -M palmetto-bmc and linux-next as the guest, and
> networking appeared to work fine. For the series:
>=20
> Tested-by: Joel Stanley <joel@jms.id.au>
>=20
> One question I had. I get these messages on boot:
>=20
> [    1.184472] ftgmac100 1e660000.ethernet: Read MAC address
> 52:54:00:12:34:56 from chip
> [    1.184751] ftgmac100 1e660000.ethernet: Using NCSI interface
> [    1.197107] ftgmac100 1e660000.ethernet eth0: irq 19, mapped at b30b=
8905
> [    1.904237] ftgmac100 1e660000.ethernet eth0: NCSI: Handler for
> packet type 0x82 returned -19
> [    1.905682] ftgmac100 1e660000.ethernet eth0: NCSI: Handler for
> packet type 0x82 returned -19
> [    1.905943] ftgmac100 1e660000.ethernet eth0: NCSI: Handler for
> packet type 0x82 returned -19
> [    1.906182] ftgmac100 1e660000.ethernet eth0: NCSI: Handler for
> packet type 0x82 returned -19
> [    1.906415] ftgmac100 1e660000.ethernet eth0: NCSI: Handler for
> packet type 0x82 returned -19
> [    1.906643] ftgmac100 1e660000.ethernet eth0: NCSI: Handler for
> packet type 0x82 returned -19
> [    1.906873] ftgmac100 1e660000.ethernet eth0: NCSI: Handler for
> packet type 0x82 returned -19
> [    1.907103] ftgmac100 1e660000.ethernet eth0: NCSI: Handler for
> packet type 0x82 returned -19
> [    2.024094] ftgmac100 1e660000.ethernet eth0: NCSI: configuring chan=
nel 0
> [    2.025428] ftgmac100 1e660000.ethernet eth0: NCSI: channel 0 config=
 done
> [    2.025544] ftgmac100 1e660000.ethernet eth0: NCSI: No more
> channels to process
> [    2.025608] ftgmac100 1e660000.ethernet eth0: NCSI interface up
>=20
>=20
> Comparing to hardware, I see:
>=20
> [    4.071159] ftgmac100 1e660000.ethernet: Read MAC address
> 98:be:94:83:00:ad from chip
> [    4.079024] ftgmac100 1e660000.ethernet: Using NCSI interface
> [    4.085976] ftgmac100 1e660000.ethernet eth0: irq 19, mapped at a096=
3000
> [   40.670099] ftgmac100 1e660000.ethernet eth0: NCSI: Handler for
> packet type 0x82 returned -19
> [   43.852036] ftgmac100 1e660000.ethernet eth0: NCSI: configuring chan=
nel 1
> [   43.877060] ftgmac100 1e660000.ethernet eth0: NCSI: channel 1 config=
 done
> [   43.877093] ftgmac100 1e660000.ethernet eth0: NCSI: No more
> channels to process
> [   43.877112] ftgmac100 1e660000.ethernet eth0: NCSI interface up
>=20
> Is it expected that we get multiple ENODEVs for packet type 0x82 in qem=
u?
=20
When the NSCI probing is done in Linux, 8 deselect packages requests
are sent and QEMU answers them all. I wonder what the real HW does.


Something to check.

Cheers,

C.
