Received: from eggs.gnu.org ([2001:4830:134:3::10]:52801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1fNtm3-0002qA-RS
	for qemu-devel@nongnu.org; Wed, 30 May 2018 01:35:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1fNtm2-0001aE-PT
	for qemu-devel@nongnu.org; Wed, 30 May 2018 01:35:51 -0400
MIME-Version: 1.0
Sender: joel.stan@gmail.com
In-Reply-To: <20180529062838.20556-1-clg@kaod.org>
References: <20180529062838.20556-1-clg@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 30 May 2018 15:05:26 +0930
Message-ID: <CACPK8Xe9a5q5tvFJ=Q0ArkDnf1-e=cW+bVY6a-peD7hpyLn_jw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 29 May 2018 at 15:58, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> Hello,
>
> Here is a couple of enhancements and fixes for the ftgmac100 NIC used
> on the Aspeed SoC. It includes VLAN and multicast support.
>
> Following is an assorted set of changes for the NC-SI backend also
> used on the Aspeed SoC when soldered on OpenPOWER boards. These fix a
> few problems found when running OpenBMC on aspeed QEMU machines.
>
> Thanks,
>
> C=C3=A9dric.
>
> C=C3=A9dric Le Goater (6):
>   ftgmac100: compute maximum frame size depending on the protocol
>   ftgmac100: add IEEE 802.1Q VLAN support
>   net/ftgmac100: fix multicast hash routine
>   slirp/ncsi: fix "Get Version ID" payload length
>   slirp/ncsi: add a "Get Parameter" response
>   slirp/ncsi: add checksum support

I tested these with -M palmetto-bmc and linux-next as the guest, and
networking appeared to work fine. For the series:

Tested-by: Joel Stanley <joel@jms.id.au>

One question I had. I get these messages on boot:

[    1.184472] ftgmac100 1e660000.ethernet: Read MAC address
52:54:00:12:34:56 from chip
[    1.184751] ftgmac100 1e660000.ethernet: Using NCSI interface
[    1.197107] ftgmac100 1e660000.ethernet eth0: irq 19, mapped at b30b8905
[    1.904237] ftgmac100 1e660000.ethernet eth0: NCSI: Handler for
packet type 0x82 returned -19
[    1.905682] ftgmac100 1e660000.ethernet eth0: NCSI: Handler for
packet type 0x82 returned -19
[    1.905943] ftgmac100 1e660000.ethernet eth0: NCSI: Handler for
packet type 0x82 returned -19
[    1.906182] ftgmac100 1e660000.ethernet eth0: NCSI: Handler for
packet type 0x82 returned -19
[    1.906415] ftgmac100 1e660000.ethernet eth0: NCSI: Handler for
packet type 0x82 returned -19
[    1.906643] ftgmac100 1e660000.ethernet eth0: NCSI: Handler for
packet type 0x82 returned -19
[    1.906873] ftgmac100 1e660000.ethernet eth0: NCSI: Handler for
packet type 0x82 returned -19
[    1.907103] ftgmac100 1e660000.ethernet eth0: NCSI: Handler for
packet type 0x82 returned -19
[    2.024094] ftgmac100 1e660000.ethernet eth0: NCSI: configuring channel =
0
[    2.025428] ftgmac100 1e660000.ethernet eth0: NCSI: channel 0 config don=
e
[    2.025544] ftgmac100 1e660000.ethernet eth0: NCSI: No more
channels to process
[    2.025608] ftgmac100 1e660000.ethernet eth0: NCSI interface up


Comparing to hardware, I see:

[    4.071159] ftgmac100 1e660000.ethernet: Read MAC address
98:be:94:83:00:ad from chip
[    4.079024] ftgmac100 1e660000.ethernet: Using NCSI interface
[    4.085976] ftgmac100 1e660000.ethernet eth0: irq 19, mapped at a0963000
[   40.670099] ftgmac100 1e660000.ethernet eth0: NCSI: Handler for
packet type 0x82 returned -19
[   43.852036] ftgmac100 1e660000.ethernet eth0: NCSI: configuring channel =
1
[   43.877060] ftgmac100 1e660000.ethernet eth0: NCSI: channel 1 config don=
e
[   43.877093] ftgmac100 1e660000.ethernet eth0: NCSI: No more
channels to process
[   43.877112] ftgmac100 1e660000.ethernet eth0: NCSI interface up

Is it expected that we get multiple ENODEVs for packet type 0x82 in qemu?

Cheers,

Joel
