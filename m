Received: from eggs.gnu.org ([2001:4830:134:3::10]:55857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fY70a-0007ey-0g
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 05:45:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fY70W-0002zh-2D
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 05:45:04 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:34696)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fY70V-0002yc-PF
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 05:44:59 -0400
Received: by mail-wr0-x241.google.com with SMTP id a12-v6so1351162wro.1
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 02:44:59 -0700 (PDT)
Date: Wed, 27 Jun 2018 10:44:56 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180627094456.GB4325@stefanha-x1.localdomain>
References: <20180626093204.27612-1-contrib@steffen-goertz.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xXmbgvnjoT4axfJE"
Content-Disposition: inline
In-Reply-To: <20180626093204.27612-1-contrib@steffen-goertz.de>
Subject: Re: [Qemu-devel] [RFC v2] arm: Add NRF51 SOC non-volatile memory
 controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Steffen =?iso-8859-1?Q?G=F6rtz?= <contrib@steffen-goertz.de>
Cc: qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>


--xXmbgvnjoT4axfJE
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 26, 2018 at 11:32:04AM +0200, Steffen G=F6rtz wrote:
> Changes since V1:
> - Code style changes

Please put the changelog below '---'.

> diff --git a/hw/nvram/nrf51_nvmc.c b/hw/nvram/nrf51_nvmc.c
> new file mode 100644
> index 0000000000..5dde3088a8
> --- /dev/null
> +++ b/hw/nvram/nrf51_nvmc.c
> @@ -0,0 +1,168 @@
> +/*
> + * nrf51_nvmc.c
> + *
> + * Copyright 2018 Steffen G=F6rtz <contrib@steffen-goertz.de>
> + *
> + * This code is licensed under the GPL version 2 or later.  See
> + * the COPYING file in the top-level directory.
> + */

Please mention the full name of the peripheral so its purpose is clear
and include a link to the datasheet.

It's convenient to have this information in the .c file, since that's
where the majority of code changes happen.

> diff --git a/include/hw/nvram/nrf51_nvmc.h b/include/hw/nvram/nrf51_nvmc.h
> new file mode 100644
> index 0000000000..3a63b7e5ad
> --- /dev/null
> +++ b/include/hw/nvram/nrf51_nvmc.h
> @@ -0,0 +1,51 @@
> +/*
> + * nrf51_nvmc.h
> + *
> + * Copyright 2018 Steffen G=F6rtz <contrib@steffen-goertz.de>
> + *
> + * This code is licensed under the GPL version 2 or later.  See
> + * the COPYING file in the top-level directory.
> + *
> + * See Nrf51 reference manual 6 Non-Volatile Memory Controller (NVMC)
> + * See Nrf51 product sheet 8.22 NVMC specifications
> + *
> + * QEMU interface:
> + * + sysbus MMIO regions 0: Memory Region with registers
> + *   to be mapped to the peripherals instance address by the SOC.
> + * + page_size property to set the page size in bytes.
> + * + code_size property to set the code size in number of pages.
> + *
> + * Accuracy of the peripheral model:
> + * + The NVMC is always ready, all requested erase operations succeed
> + *   immediately.
> + * + CONFIG.WEN and CONFIG.EEN flags can be written and read back
> + *   but are not evaluated to check whether a requested write/erase oper=
ation
> + *   is legal.

Checking CONFIG.EEN would be easy, please do it.

Peter: CONFIG.WEN determines whether stores to the flash memory region
are allowed.  What is the best way to implement this protection?

> +    MemoryRegion *mr;
> +    AddressSpace as;

I remember you said you tried
address_space_read/write(get_system_memory(), ...) but it didn't work.
Did you figure out why?

> +    struct {
> +        uint32_t config:2;
> +    } state;

I noticed you used bit-fields in recent patches.  They are rarely-used
in QEMU.

The representation of bit-fields is (compiler) implementation-defined,
so they cannot be used for live-migration where values are serialized
(marshaled).

For boolean flags just 'bool' is preferred because 'true'/'false' is
clearer in code than '0'/'1' (the reader doesn't know whether it's a
bool or used as an integer at some point unless they study all the
code).

For this field I would use just uint32_t config.

Stefan

--xXmbgvnjoT4axfJE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbM1yYAAoJEJykq7OBq3PItr4H/14Yp7tKImQ8P3/GEaR94KPh
Atm931QWKVC+EfUAdwcMb3hG7DcT9wEGTjg6F7Wo6sAVlRyfHJDO5GjqTWTTWI9f
+k9Pv454m97cDKp6XjCzRZtMNrzJjf5/jAVEG+k7zmMPlbPeHiIOn9pP5Ce+7Yni
Ez4jm57mArhE9D3P/ti/B05vb/Jss46KjZwSUBN+TcUgDGo8X7kuNZ+5w37Ocs+D
Gyqj9t8kwhVT9JcWQNRyanB0ko9yDZt9qBnltqHlFP5KWIAwk/dXX88j3g6PO9f0
1mG35J0d6dehwfA7hgW+u+iuGrPfgYI5/ct1kpM7SqcAxE9OlgEQyAme4VUVqgU=
=vNDx
-----END PGP SIGNATURE-----

--xXmbgvnjoT4axfJE--
