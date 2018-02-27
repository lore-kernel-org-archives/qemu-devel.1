Received: from eggs.gnu.org ([2001:4830:134:3::10]:48961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eqnsR-0002mL-0K
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 17:37:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eqnsP-0005nU-Um
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 17:37:39 -0500
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:33839)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1eqnsP-0005mv-Lc
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 17:37:37 -0500
Received: by mail-lf0-x241.google.com with SMTP id l191so661615lfe.1
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 14:37:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170922171323.10348-5-f4bug@amsat.org>
References: <20170922171323.10348-1-f4bug@amsat.org>
	<20170922171323.10348-5-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 27 Feb 2018 14:37:05 -0800
Message-ID: <CAKmqyKNu7hLWkwYWu=70fJSkMG33mZH=mFXgg-OROsqu5vwOTQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 4/7] hw/mdio: Mask out read-only bits.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Grant Likely <grant.likely@arm.com>, Jason Wang <jasowang@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Fri, Sep 22, 2017 at 10:13 AM, Philippe Mathieu-Daud=C3=A9
<f4bug@amsat.org> wrote:
> From: Grant Likely <grant.likely@arm.com>
>
> The RST and ANEG_RST bits are commands, not settings. An operating
> system will get confused (or at least u-boot does) if those bits remain
> set after writing to them. Therefore, mask them out on write.
>
> Similarly, no bits in the ID1, ID2, and remote capability registers are
> writeable; so mask them out also.
>
> Signed-off-by: Grant Likely <grant.likely@arm.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> [PMD: just rebased]
> ---
>  include/hw/net/mdio.h |  1 +
>  hw/net/mdio.c         | 16 ++++++++++++----
>  2 files changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/include/hw/net/mdio.h b/include/hw/net/mdio.h
> index b3b4f497c0..ed1879a728 100644
> --- a/include/hw/net/mdio.h
> +++ b/include/hw/net/mdio.h
> @@ -53,6 +53,7 @@
>
>  struct qemu_phy {
>      uint32_t regs[NUM_PHY_REGS];
> +    const uint16_t *regs_readonly_mask; /* 0=3Dwritable, 1=3Dread-only *=
/
>
>      int link;
>
> diff --git a/hw/net/mdio.c b/hw/net/mdio.c
> index 33bfbb4623..89a6a3a590 100644
> --- a/hw/net/mdio.c
> +++ b/hw/net/mdio.c
> @@ -109,17 +109,24 @@ static unsigned int mdio_phy_read(struct qemu_phy *=
phy, unsigned int req)
>
>  static void mdio_phy_write(struct qemu_phy *phy, unsigned int req, unsig=
ned int data)
>  {
> -    int regnum;
> +    int regnum =3D req & 0x1f;
> +    uint16_t mask =3D phy->regs_readonly_mask[regnum];
>
> -    regnum =3D req & 0x1f;
> -    D(printf("%s reg[%d] =3D %x\n", __func__, regnum, data));
> +    D(printf("%s reg[%d] =3D %x; mask=3D%x\n", __func__, regnum, data, m=
ask));
>      switch (regnum) {
>      default:
> -        phy->regs[regnum] =3D data;
> +        phy->regs[regnum] =3D (phy->regs[regnum] & mask) | (data & ~mask=
);
>          break;
>      }
>  }
>
> +static const uint16_t default_readonly_mask[32] =3D {
> +    [PHY_CTRL] =3D PHY_CTRL_RST | PHY_CTRL_ANEG_RST,
> +    [PHY_ID1] =3D 0xffff,
> +    [PHY_ID2] =3D 0xffff,
> +    [PHY_LP_ABILITY] =3D 0xffff,
> +};

This is what the register API is really good at :)

Overall this looks fine, can we use a macro for the 32 though and then
protect accesses with an assert() or if()?

Alistair

> +
>  void mdio_phy_init(struct qemu_phy *phy, uint16_t id1, uint16_t id2)
>  {
>      phy->regs[PHY_CTRL] =3D 0x3100;
> @@ -128,6 +135,7 @@ void mdio_phy_init(struct qemu_phy *phy, uint16_t id1=
, uint16_t id2)
>      phy->regs[PHY_ID2] =3D id2;
>      /* Autonegotiation advertisement reg. */
>      phy->regs[PHY_AUTONEG_ADV] =3D 0x01e1;
> +    phy->regs_readonly_mask =3D default_readonly_mask;
>      phy->link =3D 1;
>
>      phy->read =3D mdio_phy_read;
> --
> 2.14.1
>
>
