Received: from eggs.gnu.org ([2001:4830:134:3::10]:44456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gIAz4-0007zv-M8
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 07:17:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gIAyz-0004qE-Po
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 07:17:54 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:40282)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1gIAyx-0004nZ-QR
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 07:17:48 -0400
Received: by mail-wr1-x443.google.com with SMTP id i17-v6so19639182wre.7
	for <qemu-devel@nongnu.org>; Thu, 01 Nov 2018 04:17:46 -0700 (PDT)
Date: Thu, 1 Nov 2018 11:17:43 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20181101111743.GM24946@stefanha-x1.localdomain>
References: <20181031002526.14262-1-contrib@steffen-goertz.de>
	<20181031002526.14262-6-contrib@steffen-goertz.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="m+utxuhC6KVTvgNz"
Content-Disposition: inline
In-Reply-To: <20181031002526.14262-6-contrib@steffen-goertz.de>
Subject: Re: [Qemu-devel] [PATCH v3 05/13] hw/nvram/nrf51_nvm: Add nRF51
 non-volatile memories
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Steffen =?iso-8859-1?Q?G=F6rtz?= <contrib@steffen-goertz.de>
Cc: qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, Peter Maydell <peter.maydell@linaro.org>


--m+utxuhC6KVTvgNz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 30, 2018 at 08:25:19PM -0400, Steffen G=F6rtz wrote:
> +static void io_write(void *opaque, hwaddr offset, uint64_t value,
> +        unsigned int size)
> +{
> +    NRF51NVMState *s =3D NRF51_NVM(opaque);
> +
> +    switch (offset) {
> +    case NRF51_NVMC_CONFIG:
> +        s->config =3D value & NRF51_NVMC_CONFIG_MASK;
> +        break;
> +    case NRF51_NVMC_ERASEPCR0:
> +    case NRF51_NVMC_ERASEPCR1:
> +        value &=3D ~(NRF51_PAGE_SIZE - 1);
> +        if (value < (s->code_size * NRF51_PAGE_SIZE)) {
> +            address_space_write(&s->as, value, MEMTXATTRS_UNSPECIFIED,
> +                                s->empty_page, NRF51_PAGE_SIZE);
> +        }
> +        break;
> +    case NRF51_NVMC_ERASEALL:
> +        if (value =3D=3D NRF51_NVMC_ERASE) {
> +            for (uint32_t i =3D 0; i < s->code_size; i++) {
> +                address_space_write(&s->as, i * NRF51_PAGE_SIZE,
> +                MEMTXATTRS_UNSPECIFIED, s->empty_page, NRF51_PAGE_SIZE);

Indentation is off here.  One way of formatting it:

                address_space_write(&s->as, i * NRF51_PAGE_SIZE,
                                    MEMTXATTRS_UNSPECIFIED, s->empty_page,
				    NRF51_PAGE_SIZE);

> +static void nrf51_nvm_reset(DeviceState *dev)
> +{
> +    NRF51NVMState *s =3D NRF51_NVM(dev);
> +
> +    memset(s->uicr_content, '\0', sizeof(s->uicr_content));
> +}

We will zero UICR.  Does UICR come zero-initialized on a real micro:bit?

I remember there was an issue with .hex files that set UICR values.
Will nrf51_nvm_reset() overwrite values from .hex files when the generic
loader devices is used (-device loader,file=3Dtest.hex)?

--m+utxuhC6KVTvgNz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJb2uDXAAoJEJykq7OBq3PIbzwH/0JD0K9J7WT7ajAEh+DqEa6F
87uYhLUFTTcJqGsfHfKMzQtPVoG6JCNvhrM9AUcXtkCWHeaWFQzaPYDCJujuqpoG
xQJkQJaXnOdZuBFaw1N4/eK6IX5gCEm/OMbkDzdT8j7YOXIia/WOhPO/e7hF5ivj
EirthSmDYH764msiKCQIyXsUfI+hT/n1NSR1V9qLQ3/ussqerjm06eEB68bMupqZ
M6+YMo3wa3krNff47HecJoj1M2OwDQ1wqBa8LqrlsSf2Vf8vSilFT8gHjgcCPhPo
0jW19qUuBcUkOmzoEMb+Bphgh+Y+A0eKeE/SPNoQMKYKl4eaOb4Gic61ctFwts4=
=6Guq
-----END PGP SIGNATURE-----

--m+utxuhC6KVTvgNz--
