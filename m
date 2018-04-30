Received: from eggs.gnu.org ([2001:4830:134:3::10]:39393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1fD9Be-0005Cy-2K
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 09:49:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1fD9BZ-0006H0-6I
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 09:49:50 -0400
Received: from mail-bl2nam02on0061.outbound.protection.outlook.com
	([104.47.38.61]:48817
	helo=NAM02-BL2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <edgari@xilinx.com>) id 1fD9BY-0006GX-RO
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 09:49:45 -0400
Date: Mon, 30 Apr 2018 15:49:29 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Message-ID: <20180430134929.edf3vsx4csvsydxi@toto>
References: <20180213040809.26021-1-f4bug@amsat.org>
	<20180213040809.26021-21-f4bug@amsat.org>
	<CAFEAcA_r2WNVEkE5-p+VuH8f1XnDzHMkUNgNSMrV1ZTkHv4=AQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAFEAcA_r2WNVEkE5-p+VuH8f1XnDzHMkUNgNSMrV1ZTkHv4=AQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v13 20/30] sdbus: add trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, Fam Zheng <famz@redhat.com>

On Fri, Apr 27, 2018 at 12:55:21PM +0100, Peter Maydell wrote:
> On 13 February 2018 at 04:07, Philippe Mathieu-Daud=E9 <f4bug@amsat.org> =
wrote:
> > Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> > Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
>=20
> > @@ -39,6 +45,7 @@ int sdbus_do_command(SDBus *sdbus, SDRequest *req, ui=
nt8_t *response)
> >  {
> >      SDState *card =3D get_card(sdbus);
> >
> > +    trace_sdbus_command(sdbus_name(sdbus), req->cmd, req->arg, req->cr=
c);
> >      if (card) {
> >          SDCardClass *sc =3D SD_CARD_GET_CLASS(card);
>=20
> Hi -- as a result of this trace event being added, we now get
> warnings from Coverity that it might use uninitialized data
> (CID1386074, CID1390571, CID1386072, CID1386076). This is because not
> all of our SD
> controllers bother to initialize req->crc, because up til now
> nothing in the SD code looks at it. (I think at least bcm2835_sdhost.c
> sdhci.c and ssi-sd.c do this).
>=20
> Could you have a look at this, please? I think there are
> three plausible lines of approach:
>=20
> (1) just don't bother to trace the CRC field
> (2) make bcm2835_sdhost.c, sdhci.c, ssi-sd.c set crc to 0 like
> omap and pxa2xx already do

Hi,

Philippe, any opinion here?

Otherwise I suggest we do #2 right away to avoid the warnings
until someone cares enough to implement #3...

Cheers,
Edgar



> (3) "proper" implementation of CRC, so that an sd controller
> can either (a) mark the SDRequest as "no CRC" and have
> sd_req_crc_validate() always pass, or (b) mark the SDRequest
> as having a CRC and have sd_req_crc_validate() actually
> do the check which it currently stubs out with "return 0"
>=20
> (3 is because it doesn't seem very sensible to spend time
> calculating a CRC just to test it against a CRC calculated
> a little bit later on; but we don't really want to drop the
> CRC stuff entirely because on some controllers like
> milkymist-memcard.c the CRC byte comes from the guest and
> we'd ideally like to check it.)
>=20
> I don't have a strong preference for which of 1/2/3 we do.
>=20
> PS: CID1005332 is the coverity issue for "sd_req_crc_validate
> stubs out its check code with 'return 0' leaving a line of
> unreachable code".
>=20
> thanks
> -- PMM
