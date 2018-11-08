Received: from eggs.gnu.org ([2001:4830:134:3::10]:49677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gKhtu-0008Ma-Ew
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 05:51:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gKhts-0007JM-9I
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 05:51:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37508)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1gKhtr-0007Ii-Sq
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 05:51:00 -0500
Date: Thu, 8 Nov 2018 10:50:57 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20181108105057.GG17083@stefanha-x1.localdomain>
References: <20181105104524.933-1-jusual@mail.ru>
	<CAFEAcA9fy0xJM18+ktEpvAfZdXpkDLrjy6i1+Y0X1WNkN_jATg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Fnm8lRGFTVS/3GuM"
Content-Disposition: inline
In-Reply-To: <CAFEAcA9fy0xJM18+ktEpvAfZdXpkDLrjy6i1+Y0X1WNkN_jATg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v3] tests/microbit-test: Check nRF51 UART
 functionality
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Julia Suvorova <jusual@mail.ru>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Steffen =?iso-8859-1?Q?G=F6rtz?= <mail@steffen-goertz.de>, Thomas Huth <thuth@redhat.com>


--Fnm8lRGFTVS/3GuM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 05, 2018 at 05:54:25PM +0000, Peter Maydell wrote:
> On 5 November 2018 at 10:45, Julia Suvorova <jusual@mail.ru> wrote:
> > Some functional tests for:
> >     Basic reception/transmittion
> >     Suspending
> >     INTEN* registers
> >
> > Based-on: <20181031002526.14262-1-contrib@steffen-goertz.de>
> > Signed-off-by: Julia Suvorova <jusual@mail.ru>
> > ---
> > This patch was part of nRF51 UART patchset, but wasn't included in the =
latest
> > revision. Due to upcoming loader fixes, we need this test instead of
> > boot-serial-test, which doesn't support -device loader.
> >
> > v3:
> >     * Fix directory leak [Stefan]
> >
> >  tests/microbit-test.c | 109 +++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 107 insertions(+), 2 deletions(-)
> >
> > diff --git a/tests/microbit-test.c b/tests/microbit-test.c
> > index ab319eb466..23d343cfdd 100644
> > --- a/tests/microbit-test.c
> > +++ b/tests/microbit-test.c
> > @@ -21,9 +21,87 @@
> >  #include "hw/arm/nrf51.h"
> >  #include "hw/nvram/nrf51_nvm.h"
> >  #include "hw/gpio/nrf51_gpio.h"
> > +#include "hw/char/nrf51_uart.h"
> > +
> > +#include <sys/socket.h>
> > +#include <sys/un.h>
> >
> >  #define FLASH_SIZE          (256 * NRF51_PAGE_SIZE)
> >
> > +static bool wait_for_event(uint32_t event_addr)
> > +{
> > +    int i;
> > +
> > +    for (i =3D 0; i < 1000; i++) {
> > +        if (readl(event_addr) =3D=3D 1) {
> > +            writel(event_addr, 0x00);
> > +            return true;
> > +        }
> > +        g_usleep(10000);
>=20
> Hmm, is this the right way to wait for a device model?
> I thought there was a qtest thing to say "advance the
> time in the QEMU under test" and otherwise its internal
> clock won't tick.

This function is used to wait for QEMU device emulation to report events
triggered by external I/O (the UNIX domain socket).  I think vm_clock is
unrelated to this.

We could rely on the fact that qtest runs in the main loop where the
UNIX domain socket is also processed.  In other words, it shouldn't take
more than a small constant N of event loop iterations (i.e. qtest
commands) before the UNIX domain socket has been processed and the UART
updates its event registers.  g_usleep() seems nicer than making that
assumption though...

--Fnm8lRGFTVS/3GuM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJb5BURAAoJEJykq7OBq3PIX48H/1e7FvJEAHkhaLUwK/dIffdS
S6Cucx6dFMHyol7QQ856GPauPWHhCylldb/pYa3IJUZwLLEMbSytELXaeydIfdAa
6B8o5CWG7qi+JRcNKigRBg8U5NLJJAHzQiPqIOqVafemO2HCbWsmegaFTbPze/3Y
pegKCjgGuYPLIrlxtLDoWGvmYh0sqk7WDYeKc70+xz9kON53zSIVzDQKcdfRcohD
HYRIeV64rOELLONtNAPsJEaotHCmIJLYUpTUCYal/A2pGOMssCmK6CMvT0153DyD
ojJoQ28hesvAtzcyUXZDQLw1AZEiBJJRYQ5/2Bw7VCO1TDcDWKqR+BRCoF0Jc28=
=9vBe
-----END PGP SIGNATURE-----

--Fnm8lRGFTVS/3GuM--
