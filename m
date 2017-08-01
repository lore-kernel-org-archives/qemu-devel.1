Received: from eggs.gnu.org ([2001:4830:134:3::10]:35792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew@aj.id.au>) id 1dcOrN-0000DM-Hl
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 00:32:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew@aj.id.au>) id 1dcOrK-0001qf-32
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 00:32:45 -0400
Message-ID: <1501561942.5179.34.camel@aj.id.au>
From: Andrew Jeffery <andrew@aj.id.au>
Date: Tue, 01 Aug 2017 14:02:22 +0930
In-Reply-To: <a2f01f69-13cb-dcb9-6dcb-e5ccc3bb504d@amsat.org>
References: <20170801010425.25778-1-andrew@aj.id.au>
	<a2f01f69-13cb-dcb9-6dcb-e5ccc3bb504d@amsat.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-mw8h11HAz22QEgQhmKe5"
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH] watchdog: wdt_aspeed: Add
 support for the reset width register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, openbmc@lists.ozlabs.org, qemu-devel@nongnu.org, joel@jms.id.au, clg@kaod.org


--=-mw8h11HAz22QEgQhmKe5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Phil,

On Tue, 2017-08-01 at 00:23 -0300, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Andrew,
>=20
> On 07/31/2017 10:04 PM, Andrew Jeffery wrote:
> > The reset width register controls how the pulse on the SoC's WDTRST{1,2=
}
> > pins behaves. A pulse is emitted if the external reset bit is set in
> > WDT_CTRL. WDT_RESET_WIDTH requires magic bit patterns to configure both
> > push-pull/open-drain and active-high/active-low behaviours and thus
> > needs some special handling in the write path.
>=20
> I wanted to verify the datashit but it seems to unavailable, looking ther=
e:
> https://www.verical.com/datasheet/aspeed-technology-inc-interface-misc-as=
t2050a3-gp-4078885.pdf
>=20
> Can you point out which cpu model you are modeling and where to get this=
=C2=A0
> watchdog datashit please? You might also add this to the header, for the=
=C2=A0
> next one looking at this file :)

The watchdog model is common to at least the Aspeed AST2400- and
AST2500- SoC families, which I have datasheets for. However, they are
not available to the public and therefore (unfortunately) I can't point
you to them. You may be able to access them if you have appropriate
arrangements with Aspeed.

Regarding the features exposed by the patch, configuration of the
electrical properties of the  external reset signal is only provided in
the AST2500's watchdog IP, but the bits used in the reset width
register are marked as reserved on the AST2400. Therefore I thought it
was reasonable not to guard them behind some kind of revision test.

>=20
> >=20
> > > > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > ---
> > I understand that we're in stabilisation mode, but I thought I'd send t=
his out
> > to provoke any feedback. Happy to resend after the 2.10 release if requ=
ired.
>=20
> you can subject it "PATCH for 2.11" so ppl testing/closing 2.10 can keep=
=C2=A0
> focused but still queue your mail for when 2.10 release is out.

Thanks for the tip.

>=20
> >=20
> > =C2=A0 hw/watchdog/wdt_aspeed.c | 47 ++++++++++++++++++++++++++++++++++=
+++----------
> > =C2=A0 1 file changed, 37 insertions(+), 10 deletions(-)
> >=20
> > diff --git a/hw/watchdog/wdt_aspeed.c b/hw/watchdog/wdt_aspeed.c
> > index 8bbe579b6b66..4ef1412e99fc 100644
> > --- a/hw/watchdog/wdt_aspeed.c
> > +++ b/hw/watchdog/wdt_aspeed.c
> > @@ -14,10 +14,10 @@
> > =C2=A0 #include "qemu/timer.h"
> > =C2=A0 #include "hw/watchdog/wdt_aspeed.h"
> > =C2=A0=C2=A0
> > -#define WDT_STATUS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(0x00 / 4)
> > -#define WDT_RELOAD_VALUE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0(0x04 / 4)
> > -#define WDT_RESTART=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0(0x08 / 4)
> > -#define WDT_CTRL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(0x0C / 4)
> > +#define WDT_STATUS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0(0x00 / 4)
> > +#define WDT_RELOAD_VALUE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(0x04 / 4)
> > +#define WDT_RESTART=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
(0x08 / 4)
> > +#define WDT_CTRL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0(0x0C / 4)
> > =C2=A0 #define=C2=A0=C2=A0=C2=A0WDT_CTRL_RESET_MODE_SOC=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0(0x00 << 5)
> > =C2=A0 #define=C2=A0=C2=A0=C2=A0WDT_CTRL_RESET_MODE_FULL_CHIP (0x01 << =
5)
> > =C2=A0 #define=C2=A0=C2=A0=C2=A0WDT_CTRL_1MHZ_CLK=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0BIT(4)
> > @@ -25,12 +25,21 @@
> > =C2=A0 #define=C2=A0=C2=A0=C2=A0WDT_CTRL_WDT_INTR=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0BIT(2)
> > =C2=A0 #define=C2=A0=C2=A0=C2=A0WDT_CTRL_RESET_SYSTEM=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0BIT(1)
> > =C2=A0 #define=C2=A0=C2=A0=C2=A0WDT_CTRL_ENABLE=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0BIT(0)
> > +#define WDT_RESET_WIDTH=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(0x18 / 4)
> > +#define=C2=A0=C2=A0=C2=A0WDT_RESET_WIDTH_ACTIVE_HIGH=C2=A0=C2=A0=C2=A0=
BIT(31)
> > +#define=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0WDT_POLARITY_MASK=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(0xFF << 24)
> > +#define=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0WDT_ACTIVE_HIGH_MAGIC=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(0xA5 << 24)
> > +#define=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0WDT_ACTIVE_LOW_MAGIC=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(0x5A << 24)
> > +#define=C2=A0=C2=A0=C2=A0WDT_RESET_WIDTH_PUSH_PULL=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0BIT(30)
> > +#define=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0WDT_DRIVE_TYPE_MASK=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(0xFF << 24)
> > +#define=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0WDT_PUSH_PULL_MAGIC=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(0xA8 << 24)
> > +#define=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0WDT_OPEN_DRAIN_MAGIC=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(0x8A << 24)
> > +#define=C2=A0=C2=A0=C2=A0WDT_RESET_WIDTH_DURATION=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A00xFFF;
>=20
> Which model? the AST2050 seems to be 0xff.

Ah, good catch, this is also the case in the AST2400. The AST2500
extends this field. Host code for the AST2400 and AST2050 *shouldn't*
set any greater values; is it worth enforcing?

>=20
> > =C2=A0=C2=A0
> > -#define WDT_TIMEOUT_STATUS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(0x10 / =
4)
> > -#define WDT_TIMEOUT_CLEAR=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(0x=
14 / 4)
> > -#define WDT_RESET_WDITH=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0(0x18 / 4)
> > +#define WDT_TIMEOUT_STATUS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(0x10 / 4)
> > +#define WDT_TIMEOUT_CLEAR=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(0x14 / 4)
> > =C2=A0=C2=A0
> > -#define WDT_RESTART_MAGIC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x4=
755
> > +#define WDT_RESTART_MAGIC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x4755
> > =C2=A0=C2=A0
> > =C2=A0 static bool aspeed_wdt_is_enabled(const AspeedWDTState *s)
> > =C2=A0 {
> > @@ -55,9 +64,10 @@ static uint64_t aspeed_wdt_read(void *opaque, hwaddr=
 offset, unsigned size)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0case WDT_CTRL:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return s->r=
egs[WDT_CTRL];
> > +=C2=A0=C2=A0=C2=A0=C2=A0case WDT_RESET_WIDTH:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return s->regs[WDT_RES=
ET_WIDTH];
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0case WDT_TIMEOUT_STATUS:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0case WDT_TIMEOUT_CLEAR:
> > -=C2=A0=C2=A0=C2=A0=C2=A0case WDT_RESET_WDITH:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0qemu_log_ma=
sk(LOG_UNIMP,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
"%s: uninmplemented read at offset 0x%" HWADDR_PRIx "\n",
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
__func__, offset);
> > @@ -119,9 +129,25 @@ static void aspeed_wdt_write(void *opaque, hwaddr =
offset, uint64_t data,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0timer_del(s->timer);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0break;
> > +=C2=A0=C2=A0=C2=A0=C2=A0case WDT_RESET_WIDTH:
> > +=C2=A0=C2=A0=C2=A0=C2=A0{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0uint32_t property =3D =
data & WDT_POLARITY_MASK;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (property =3D=3D WD=
T_ACTIVE_HIGH_MAGIC) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0s->regs[WDT_RESET_WIDTH] |=3D WDT_RESET_WIDTH_ACTIVE_HIGH;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0} else if (property =
=3D=3D WDT_ACTIVE_LOW_MAGIC) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0s->regs[WDT_RESET_WIDTH] &=3D ~WDT_RESET_WIDTH_ACTIVE_HIGH;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0} else if (property =
=3D=3D WDT_PUSH_PULL_MAGIC) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0s->regs[WDT_RESET_WIDTH] |=3D WDT_RESET_WIDTH_PUSH_PULL;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0} else if (property =
=3D=3D WDT_OPEN_DRAIN_MAGIC) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0s->regs[WDT_RESET_WIDTH] &=3D ~WDT_RESET_WIDTH_PUSH_PULL;
>=20
> } else {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0qemu_log_mask(LOG_GUEST_ERROR, ...
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}

=46rom the datasheet: "For others value, this bit will keep old value
without change." So it is not a guest error to write a value not
matching the cases above.

>=20
> Anyway I'm not sure about this if().
> Usually watchdogs have a state machine, if you don't do all unlock steps=
=C2=A0
> ordered, the SM get reset. This is why magic is involved, else you could=
=C2=A0
> use it as a regular register.
> I'd expect a guest writing ACTIVE_HIGH_MAGIC then PUSH_PULL_MAGIC to not=
=C2=A0
> modify the RESET_WIDTH register, since the correct behavior would be to=
=C2=A0
> write ordered RESTART_MAGIC, then HIGH_MAGIC, then LOW_MAGIC and finally=
=C2=A0
> the PULL/DRAIN change, but I'm just trying to model this wdg in my head=
=C2=A0
> without having study the DS so you can't rely on my comments :)

Well, given I have it handy, I think the behaviour of the hardware
resolves this query:

root@romulus:~# devmem 0x1e785018
0x000000FF
root@romulus:~# devmem 0x1e785018 32 0xa80000ff
root@romulus:~# devmem 0x1e785018
0x400000FF
root@romulus:~# devmem 0x1e785018 32 0x8a0000ff
root@romulus:~# devmem 0x1e785018
0x000000FF
root@romulus:~# devmem 0x1e785018 32 0xa50000ff
root@romulus:~# devmem 0x1e785018
0x800000FF
root@romulus:~# devmem 0x1e785018 32 0x5a0000ff
root@romulus:~# devmem 0x1e785018
0x000000FF
root@romulus:~# devmem 0x1e785018 32 0xa80000ff
root@romulus:~# devmem
0x1e785018 32 0xa50000ff
root@romulus:~# devmem 0x1e785018
0xC00000FF
root
@romulus:~# devmem 0x1e785018 32 0x5a0000ff
root@romulus:~# devmem
0x1e785018 32 0x8a0000ff
root@romulus:~# devmem 0x1e785018
0x000000FF
root@romulus:~# devmem 0x1e785018 32 0xa50000ff
root@romulus:~# devmem 0x1e785018
0x800000FF
root@romulus:~# devmem 0x1e785018 32 0x000a5a5a
root@romulus:~# devmem
0x1e785018
0x800A5A5A
root@romulus:~# devmem 0x1e785018 32 0x5a0000ff
root@romulus:~# devmem 0x1e785018
0x000000FF

Bear in mind the driver is loaded, so maybe it's messing with the test,
but I haven't seen any indication to the contrary.

>=20
> Also it seems unsafe to modify that kind of property while the watchdog=
=C2=A0
> is running, usually you disable it before modifying it, else while=C2=A0
> running changes are automagically ignored.

But that's a host-code problem, right? I don't see any hardware
restriction noted in the datasheet along these lines.

>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0s->regs[WDT_RESET_WIDT=
H] &=3D ~WDT_RESET_WIDTH_DURATION;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0s->regs[WDT_RESET_WIDT=
H] |=3D data & WDT_RESET_WIDTH_DURATION;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0break;
> > +=C2=A0=C2=A0=C2=A0=C2=A0}
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0case WDT_TIMEOUT_STATUS:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0case WDT_TIMEOUT_CLEAR:
> > -=C2=A0=C2=A0=C2=A0=C2=A0case WDT_RESET_WDITH:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0qemu_log_ma=
sk(LOG_UNIMP,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
"%s: uninmplemented write at offset 0x%" HWADDR_PRIx "\n",
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
__func__, offset);
> > @@ -167,6 +193,7 @@ static void aspeed_wdt_reset(DeviceState *dev)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0s->regs[WDT_RELOAD_VALUE] =3D 0x03E=
F1480;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0s->regs[WDT_RESTART] =3D 0;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0s->regs[WDT_CTRL] =3D 0;
> > +=C2=A0=C2=A0=C2=A0=C2=A0s->regs[WDT_RESET_WIDTH] =3D 0XFF;
>=20
> why different than your define WDT_RESET_WIDTH_DURATION?

Maybe WDT_RESET_WIDTH_DURATION is poorly named, but it's a mask, not a
value. The 0xFF here (somehow I got an upper-case X in there) is the
default value for the register as documented in both the AST2400 and
AST2500 datasheets. However, this *has* lead me to discover that I've
defined the WDT_RESET_WIDTH_DURATION mask too narrow for the AST2500,
it should be 0xFFFFF (19:0). The AST2400 datasheet documents the field
as 7:0 (0xFF).

I'll respin, taking into account the 2.11 note above, unless you have
any more comments.

Thanks for taking a look!

Andrew

> > =C2=A0=C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0timer_del(s->timer);
> > =C2=A0 }
> >=20
>=20
> Regards,
>=20
> Phil.
--=-mw8h11HAz22QEgQhmKe5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJZgARWAAoJEJ0dnzgO5LT5yzoP/A/dsr7O61gySJwGn3+TGSsF
DmyLfDlDzPpG2vHpG+lE/ipgd0hnnkXF3JakEfpfDfR1Oj0fayrF1NfGVIHFpoTz
kAlsztmg6mZssDHraPTmBON2cftPN1+rT4mX96XCWJRN072CNY/MTSAG9xVm7ph4
yYi6hkX7cQA9hozTNOSJV0KIsBkH3vJBbxSN8NG/0/M24KghYOzLagOs3Od+63ES
A2HDfAISniXpXeuvWWuNb46ZMSuMJTJoV8PBp8VT8SIkF5aKgT0vJQouJE7JkAAu
DU3f+cbmBslXL6ZLlzS4uFK2K9XCD4FPCCbJi66UJiQnmIACa6NJZiKol4eXyy7P
yQB1+bNPzsOxf2jI866Q5JsTxIclhWBYXTW0OQ4E0iPlJpVCFctEMiKwNn7/C+y6
WdN54SbPJn/8TLpepd7lehg4yN3XLchWzowCgYUhyeOkGny7gYmWt2fl0ZXoCWhe
j0w/+1zc9ZxRvak+X74pyFQ9AsyJqhRdtt7e8D0GVpBCLr/OJX0JNDRreyT+mpBp
deAwgVEx4EJ6AQc7H76Y6nnqBOz6hm8UI0QK/X/3EXsUL9sx6h5FT5LD39u0U7r+
W2HbduAEIM4Z22arM/Cqq+NgkYANhYd9KngSIbETLvDQMKJ0dnvWewrKjEH5URqb
I4qzEZb+utZmwyyA64ky
=AWxP
-----END PGP SIGNATURE-----

--=-mw8h11HAz22QEgQhmKe5--
