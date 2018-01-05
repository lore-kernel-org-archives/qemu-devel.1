Received: from eggs.gnu.org ([2001:4830:134:3::10]:38643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eXTyM-0006lh-N2
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 10:31:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eXTyJ-00053a-JN
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 10:31:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59112)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eXTyJ-00052T-Bb
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 10:31:51 -0500
Date: Fri, 5 Jan 2018 15:31:36 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180105153136.GF28322@stefanha-x1.localdomain>
References: <20180103214925.16677-1-f4bug@amsat.org>
	<20180103214925.16677-5-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JSkcQAAxhB1h8DcT"
Content-Disposition: inline
In-Reply-To: <20180103214925.16677-5-f4bug@amsat.org>
Subject: Re: [Qemu-devel] [RFC PATCH v2 4/4] tests: add some sdcard qtest
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


--JSkcQAAxhB1h8DcT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 03, 2018 at 06:49:25PM -0300, Philippe Mathieu-Daud=E9 wrote:
> +static const char *machines[PROTO_COUNT] =3D {
> +    [PROTO_SD] =3D "nuri",
> +    //[PROTO_MMC] =3D "vexpress-a9",
> +    //[PROTO_SPI] =3D "lm3s6965evb"
> +};
> +
> +static const uint64_t sizes[] =3D {
> +    //512 * M_BYTE,
> +    //1 * G_BYTE,
> +    4 * G_BYTE,
> +    //64 * G_BYTE,
> +};

Why are these commented out?

> +static void test1(SDBusAdapter *mmc, uint64_t size)
> +{
> +    uint8_t *response;
> +    uint16_t rca;
> +    ssize_t sz;
> +
> +    sz =3D sdbus_do_cmd(mmc, GO_IDLE_STATE, 0, NULL);
> +    g_assert_cmpuint(sz, =3D=3D, 0);
> +
> +    sz =3D sdbus_do_cmd(mmc, SEND_IF_COND, 0x1aa, NULL);
> +    //g_assert_cmpuint(sz, =3D=3D, 0);

Why is this commented out?

> +    // TODO 8x: sdcard_read_data len 512
> +
> +    //sz =3D sdbus_do_acmd(mmc, SEND_STATUS, 0, rca, &response);
> +    //g_free(response);

Why is there commenteded out code and TODO here?  Please either
implement this stuff or remove it from the patch.

> +int main(int argc, char **argv)
> +{
> +    const char *arch =3D qtest_get_arch();
> +    int iproto, isize;
> +    gchar *path;
> +    TestCase *test;
> +
> +    g_test_init(&argc, &argv, NULL);
> +
> +    if (strcmp(arch, "arm") =3D=3D 0 || strcmp(arch, "aarch64") =3D=3D 0=
) {
> +        for (iproto =3D 0; iproto < PROTO_COUNT; iproto++) {
> +            if (!machines[iproto]) {
> +                continue;
> +            }
> +            for (isize =3D 0; isize < ARRAY_SIZE(sizes); isize++) {
> +                test =3D g_new(TestCase, 1);
> +
> +                test->protocol =3D iproto;
> +                test->size =3D sizes[isize];
> +
> +                path =3D g_strdup_printf("sdcard/%s/%lu", proto_name[ipr=
oto], sizes[isize]);
> +                qtest_add_data_func(path, test, sdcard_tests);
> +                g_free(path);
> +                // g_free(test)?

Please remove this.  qtest_add_data_func() keeps the pointer to test so
it must not be freed.

--JSkcQAAxhB1h8DcT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaT5pYAAoJEJykq7OBq3PIpecIAJRXyMXfmLjNDXCSwkEWVm1M
EyTM3WIcbVcg2Sz/oqZEBX2B5eSIn9L/K75Ix3HYfezJqdQ7pkaVBEeVHwGQvw+R
kONLaK+aRfWIvUDqX6Jyd3a1kxPJ0UFOB74F7uC1WTpQhzQUevMlUNUM6GBu3hI/
NTR8sZYuCAijmOHwU8QY1lqshuZT2zs0ksymU7X5Tq/8yVFP3h5DOuUhlYw/Le3p
PHNuy2ngPZKbf16pzSlAopEOdU2aD+zb8M4hxxDl68puYUnfh0/ymGpKN86M8d85
3K3cjjO95OB2KgiOEYIjNcSrnEY0UmzQQGNHYc8PuETuCJrcxpSlunliKeOHjTU=
=gKL8
-----END PGP SIGNATURE-----

--JSkcQAAxhB1h8DcT--
