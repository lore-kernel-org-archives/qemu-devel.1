Received: from eggs.gnu.org ([2001:4830:134:3::10]:58790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eXTlY-0000GN-E5
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 10:18:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eXTlV-0005nh-99
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 10:18:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56460)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eXTlU-0005mw-VT
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 10:18:37 -0500
Date: Fri, 5 Jan 2018 15:18:34 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180105151834.GD28322@stefanha-x1.localdomain>
References: <20180103214925.16677-1-f4bug@amsat.org>
	<20180103214925.16677-3-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XvKFcGCOAo53UbWW"
Content-Disposition: inline
In-Reply-To: <20180103214925.16677-3-f4bug@amsat.org>
Subject: Re: [Qemu-devel] [RFC PATCH v2 2/4] libqos: add a sdbus API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>


--XvKFcGCOAo53UbWW
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 03, 2018 at 06:49:23PM -0300, Philippe Mathieu-Daud=E9 wrote:
> +typedef struct SDBusAdapter SDBusAdapter;
> +struct SDBusAdapter {
> +
> +    ssize_t (*do_command)(SDBusAdapter *adapter, enum NCmd cmd, uint32_t=
 arg,
> +                          uint8_t **response);
> +    void (*write_byte)(SDBusAdapter *adapter, uint8_t value);
> +    uint8_t (*read_byte)(SDBusAdapter *adapter);
> +};

Is it necessary to expose the struct definition?  qmp_sdbus_create()
allocates this struct so the caller cannot embed it anyway and does not
need to know sizeof.

> +
> +ssize_t sdbus_do_cmd(SDBusAdapter *adapter, enum NCmd cmd, uint32_t arg,
> +                     uint8_t **response);
> +ssize_t sdbus_do_acmd(SDBusAdapter *adapter, enum ACmd acmd, uint32_t ar=
g,
> +                      uint16_t address, uint8_t **response);
> +void sdbus_write_byte(SDBusAdapter *adapter, uint8_t value);
> +uint8_t sdbus_read_byte(SDBusAdapter *adapter);
> +
> +SDBusAdapter *qmp_sdbus_create(const char *bus_name);

Does this function belong in another patch?

> +static bool verbose;
> +#define DPRINTF(fmt, ...)                           \
> +    do {                                            \
> +        if (verbose) {                              \

I suggest using if (getenv("V")) directly and removing the verbose
global.  The verbose global is error-prone because it requires that the
caller first initializes it.

> +ssize_t sdbus_do_acmd(SDBusAdapter *adapter, enum ACmd acmd, uint32_t ar=
g,
> +                      uint16_t address, uint8_t **response)
> +{
> +    do_cmd(adapter, 55, address << 16, NULL, false);
> +    // TODO check rv?

Even if there is no actual error handling, g_assert_...() could be used
here.

--XvKFcGCOAo53UbWW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaT5dKAAoJEJykq7OBq3PIRFYH/0HRPYki5KV0DlhPe+2CnET/
YKd9wGWxNE+j5DckQUi87l7lWZTCp7wMOi6stylLGO6fwM0sIbg7B2pdTXFAheP/
5R6AzcE64Mj9fEuytnL5cgS6UQoCtKVNdlQ43cxuar8OULGE+n+5ZDbT2wGR+eQq
yz/YC12ROndsPjY/U0USF1vP8Jf9bTV8N0cfZSpkUNurLBC2srUl5wCaSiUnGhHS
2bzbC6g3Xt83t6OdD4I+5wvUY7/G6o1O3Bp4ZDAkds3NvZfdbwX/Tk+K5Sjy3xcy
j6HmsVrRSa/GyH8Nf7/HLpt1+RwIeIQO6RrUow5XDRHbQpzs+8nNwUGqJHM+HK0=
=et5d
-----END PGP SIGNATURE-----

--XvKFcGCOAo53UbWW--
