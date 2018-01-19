Received: from eggs.gnu.org ([2001:4830:134:3::10]:42201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ecNBk-0000Ys-A8
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 22:17:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ecNBh-0003ml-4b
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 22:17:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40258)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ecNBg-0003lj-Rg
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 22:17:53 -0500
Date: Fri, 19 Jan 2018 05:17:49 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180119051309-mutt-send-email-mst@kernel.org>
References: <1516326941-11832-1-git-send-email-minyard@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1516326941-11832-1-git-send-email-minyard@acm.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] Revert "smbus: do not immediately complete
 commands"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: minyard@acm.org
Cc: qemu-devel@nongnu.org, Corey Minyard <cminyard@mvista.com>, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>

On Thu, Jan 18, 2018 at 07:55:41PM -0600, minyard@acm.org wrote:
> From: Corey Minyard <cminyard@mvista.com>
>=20
> This reverts commit 880b1ffe6ec2f0ae25cc4175716227ad275e8b8a.
>=20
> The commit being reverted says:
>=20
>     PIIX4 errata says that "immediate polling of the Host Status Regist=
er BUSY
>     bit may indicate that the SMBus is NOT busy."
>     Due to this, some code does the following steps:
>     (a) set parameters
>     (b) start command
>     (c) check for smbus busy bit set (to know that command started)
>     (d) check for smbus busy bit not set (to know that command finished=
)
>=20
>     Let (c) happen, by immediately setting the busy bit, and really exe=
cuting
>     the command when status register has been read once.
>=20
>     This fixes a problem with AMIBIOS, which can now properly initializ=
e the
>     PIIX4.
>=20
> Emulating bad hardware so badly written software will work doesn't soun=
d
> like a good idea to me.  I have patches that add interrupt capability
> to pm_smbus, but this change breaks that because the Linux driver
> starts the transaction then waits for interrupts before reading the
> status register.  That obviously won't work with these changes.
>=20
> The right way to fix this in AMIBIOS is to ignore the host busy bit
> and use the other bits in the host status register to tell if the
> transaction has completed.  Using host busy is racy, anyway, if you
> get interrupted or something while processing, you may miss step (c)
> in your algorithm and fail.
>=20
> Cc: Herv=E9 Poussineau <hpoussin@reactos.org>
> Cc: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> Signed-off-by: Corey Minyard <cminyard@mvista.com>

Would it be possible to limit the change to when guest uses
interrupts?

> ---
>  hw/i2c/pm_smbus.c | 16 +---------------
>  1 file changed, 1 insertion(+), 15 deletions(-)
>=20
> diff --git a/hw/i2c/pm_smbus.c b/hw/i2c/pm_smbus.c
> index 0d26e0f..a044dd1 100644
> --- a/hw/i2c/pm_smbus.c
> +++ b/hw/i2c/pm_smbus.c
> @@ -62,9 +62,6 @@ static void smb_transaction(PMSMBus *s)
>      I2CBus *bus =3D s->smbus;
>      int ret;
> =20
> -    assert(s->smb_stat & STS_HOST_BUSY);
> -    s->smb_stat &=3D ~STS_HOST_BUSY;
> -
>      SMBUS_DPRINTF("SMBus trans addr=3D0x%02x prot=3D0x%02x\n", addr, p=
rot);
>      /* Transaction isn't exec if STS_DEV_ERR bit set */
>      if ((s->smb_stat & STS_DEV_ERR) !=3D 0)  {
> @@ -137,13 +134,6 @@ error:
> =20
>  }
> =20
> -static void smb_transaction_start(PMSMBus *s)
> -{
> -    /* Do not execute immediately the command ; it will be
> -     * executed when guest will read SMB_STAT register */
> -    s->smb_stat |=3D STS_HOST_BUSY;
> -}
> -
>  static void smb_ioport_writeb(void *opaque, hwaddr addr, uint64_t val,
>                                unsigned width)
>  {
> @@ -159,7 +149,7 @@ static void smb_ioport_writeb(void *opaque, hwaddr =
addr, uint64_t val,
>      case SMBHSTCNT:
>          s->smb_ctl =3D val;
>          if (val & 0x40)
> -            smb_transaction_start(s);
> +            smb_transaction(s);
>          break;
>      case SMBHSTCMD:
>          s->smb_cmd =3D val;
> @@ -191,10 +181,6 @@ static uint64_t smb_ioport_readb(void *opaque, hwa=
ddr addr, unsigned width)
>      switch(addr) {
>      case SMBHSTSTS:
>          val =3D s->smb_stat;
> -        if (s->smb_stat & STS_HOST_BUSY) {
> -            /* execute command now */
> -            smb_transaction(s);
> -        }
>          break;
>      case SMBHSTCNT:
>          s->smb_index =3D 0;
> --=20
> 2.7.4
