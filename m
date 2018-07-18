Received: from eggs.gnu.org ([2001:4830:134:3::10]:51318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ffoTl-00063T-VV
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 11:35:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ffoTk-0004rJ-P2
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 11:35:02 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:34723)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1ffoTk-0004pC-EH
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 11:35:00 -0400
Received: by mail-wm0-x241.google.com with SMTP id l2-v6so1679987wme.1
	for <qemu-devel@nongnu.org>; Wed, 18 Jul 2018 08:35:00 -0700 (PDT)
Date: Wed, 18 Jul 2018 15:18:18 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180718141818.GK21825@stefanha-x1.localdomain>
References: <20180712101219.32707-1-contrib@steffen-goertz.de>
	<20180712101219.32707-2-contrib@steffen-goertz.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DozTQjXnjm3C9Xhk"
Content-Disposition: inline
In-Reply-To: <20180712101219.32707-2-contrib@steffen-goertz.de>
Subject: Re: [Qemu-devel] [RFC v3 1/2] arm: Add NRF51 SOC non-volatile
 memory controller
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


--DozTQjXnjm3C9Xhk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 12, 2018 at 12:12:18PM +0200, Steffen G=F6rtz wrote:
> Changes in V3:
> - NVMs consolidated in one file
> - Removed bitfields
> - Add VMState
> - Add reset
>=20
> Changes in V1/V2:
> - Code style changes
>=20
> Signed-off-by: Steffen G=F6rtz <contrib@steffen-goertz.de>
> ---

Everything above '---' goes into the commit description and is
permanently in the git log.  Changelogs are not useful in the git log
since their context (the earlier revisions and the discussion) is
missing.  Please put changelogs below '---' as anything there doesn't
get included in the commit description.

> +static uint64_t ficr_read(void *opaque, hwaddr offset, unsigned int size)
> +{
> +    if (offset > (ARRAY_SIZE(ficr_content) - size)) {

Bug alert, the semantic types look suspicious:

  bytes_t > num_elements_t - bytes_t

You cannot subtract a byte count from the number of elements in an
array.

Did you mean:

  if (offset >=3D sizeof(ficr_content)) {

MemoryRegion was already declared with FICR_SIZE length, so nothing
should ever call ficr_read() with an out-of-bounds offset.

Instead of defining FICR_SIZE, which could become out-of-sync with the
definition of ficr_content[], I would use sizeof(ficr_content) as the
MemoryRegion length.  This way the code is guaranteed to be safe even if
the size of ficr_content[] is changed in the future.  No if statement
would be necessary.

> +static uint64_t uicr_read(void *opaque, hwaddr offset, unsigned int size)
> +{
> +    Nrf51NVMState *s =3D NRF51_NVM(opaque);
> +
> +    offset >>=3D 2;
> +
> +    if (offset >=3D ARRAY_SIZE(s->uicr_content)) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                "%s: bad read offset 0x%" HWADDR_PRIx "\n", __func__, of=
fset);
> +        return 0;
> +    }

The same applies to NRF51_UICR_SIZE.  It's simpler to use
sizeof(s->uicr_content) instead of defining a separate constant and then
using an if statement to check the offset.

> +static void nrf51_nvm_init(Object *obj)
> +{
> +    Nrf51NVMState *s =3D NRF51_NVM(obj);
> +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
> +
> +    memory_region_init_io(&s->mmio, obj, &io_ops, s, "nrf51_soc.nvmc",
> +            NRF51_NVMC_SIZE);
> +    sysbus_init_mmio(sbd, &s->mmio);
> +
> +    memory_region_init_io(&s->ficr, NULL, &ficr_ops, s, "nrf51_soc.ficr",
> +            NRF51_FICR_SIZE);
> +    memory_region_set_readonly(&s->ficr, true);
> +    sysbus_init_mmio(sbd, &s->ficr);
> +
> +    memcpy(s->uicr_content, uicr_fixture, sizeof(s->uicr_content));

uicr_content[] persists across device reset?  Doing it that way seems
fine to me, but I wanted to check that it's what you intended.

> +static void nrf51_nvm_reset(DeviceState *dev)
> +{
> +    Nrf51NVMState *s =3D NRF51_NVM(dev);
> +
> +    s->empty_page =3D g_malloc(s->page_size);
> +    memset(s->empty_page, 0xFF, s->page_size);
> +}

This function can be called multiple times and will leak the previous
s->empty_page.  It's easier to allocate s->empty_page in
nrf51_nvm_realize() instead.

> +
> +
> +static Property nrf51_nvm_properties[] =3D {
> +    DEFINE_PROP_UINT16("page_size", Nrf51NVMState, page_size, 0x400),
> +    DEFINE_PROP_UINT32("code_size", Nrf51NVMState, code_size, 0x100),

There is an intense battle between '-' and '_' for property names:

$ git grep 'DEFINE_PROP[^(]\+("[^"]\+_' | wc -l
234
$ git grep 'DEFINE_PROP[^(]\+("[^"]\+-' | wc -l
394

I like '-' is because -device foo,my-option=3Dx is more consistent with
commonly-used properties than -device foo,my_option=3Dx, but there are
plenty of properties with '_' lurking around too.

Up to you :).

> diff --git a/include/hw/arm/nrf51_soc.h b/include/hw/arm/nrf51_soc.h
> index 35dd71c3db..9c32d22abe 100644
> --- a/include/hw/arm/nrf51_soc.h
> +++ b/include/hw/arm/nrf51_soc.h
> @@ -1,5 +1,5 @@
>  /*
> - * Nordic Semiconductor nRF51  SoC
> + * Nordic Semiconductor nRF51 SoC

Unrelated to this patch.  Please drop.

--DozTQjXnjm3C9Xhk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbT0wqAAoJEJykq7OBq3PIbnMH/RS3/8XWvZ9Ge020DTIsSpDn
dGoLkOMCGDt+9ewNCn0QP+tTLgVjvXnVH9/KW/qt0N2UJAPK0WO5mZiaVHg5/fCF
9IeWJrfhaRh6Ha8EkG3xbK6T63DA5YszoxlYpXyMzzaUR1J5IY5oFcQxMTvrnzKL
MDrCTEfYda9MPpVySCW/+Om0Gc1WwZJN5NoTM4FqtCFpvwgnxepQ8LYsd7jVcwjm
R77ukIhCWiUrFe6iRZSWDpOcu9KC4rKlj6AaOW0+SJLyVjpXoB9yHSgtTgL+21y4
tL5POAD091G8q0xkNSIWwD2fwfNUCRZUkXszP0j7/SaomV7zufkJaW+uePq2p5Q=
=spUK
-----END PGP SIGNATURE-----

--DozTQjXnjm3C9Xhk--
