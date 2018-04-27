Received: from eggs.gnu.org ([2001:4830:134:3::10]:37491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fC1yZ-0005Qj-PM
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 07:55:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fC1yY-0008TD-O0
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 07:55:43 -0400
Received: from mail-oi0-x22b.google.com ([2607:f8b0:4003:c06::22b]:41218)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fC1yY-0008Sp-I8
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 07:55:42 -0400
Received: by mail-oi0-x22b.google.com with SMTP id 11-v6so1321755ois.8
	for <qemu-devel@nongnu.org>; Fri, 27 Apr 2018 04:55:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180213040809.26021-21-f4bug@amsat.org>
References: <20180213040809.26021-1-f4bug@amsat.org>
	<20180213040809.26021-21-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Apr 2018 12:55:21 +0100
Message-ID: <CAFEAcA_r2WNVEkE5-p+VuH8f1XnDzHMkUNgNSMrV1ZTkHv4=AQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v13 20/30] sdbus: add trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Fam Zheng <famz@redhat.com>

On 13 February 2018 at 04:07, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

> @@ -39,6 +45,7 @@ int sdbus_do_command(SDBus *sdbus, SDRequest *req, uint=
8_t *response)
>  {
>      SDState *card =3D get_card(sdbus);
>
> +    trace_sdbus_command(sdbus_name(sdbus), req->cmd, req->arg, req->crc)=
;
>      if (card) {
>          SDCardClass *sc =3D SD_CARD_GET_CLASS(card);

Hi -- as a result of this trace event being added, we now get
warnings from Coverity that it might use uninitialized data
(CID1386074, CID1390571, CID1386072, CID1386076). This is because not
all of our SD
controllers bother to initialize req->crc, because up til now
nothing in the SD code looks at it. (I think at least bcm2835_sdhost.c
sdhci.c and ssi-sd.c do this).

Could you have a look at this, please? I think there are
three plausible lines of approach:

(1) just don't bother to trace the CRC field
(2) make bcm2835_sdhost.c, sdhci.c, ssi-sd.c set crc to 0 like
omap and pxa2xx already do
(3) "proper" implementation of CRC, so that an sd controller
can either (a) mark the SDRequest as "no CRC" and have
sd_req_crc_validate() always pass, or (b) mark the SDRequest
as having a CRC and have sd_req_crc_validate() actually
do the check which it currently stubs out with "return 0"

(3 is because it doesn't seem very sensible to spend time
calculating a CRC just to test it against a CRC calculated
a little bit later on; but we don't really want to drop the
CRC stuff entirely because on some controllers like
milkymist-memcard.c the CRC byte comes from the guest and
we'd ideally like to check it.)

I don't have a strong preference for which of 1/2/3 we do.

PS: CID1005332 is the coverity issue for "sd_req_crc_validate
stubs out its check code with 'return 0' leaving a line of
unreachable code".

thanks
-- PMM
