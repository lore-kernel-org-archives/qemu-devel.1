Received: from eggs.gnu.org ([209.51.188.92]:38553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gmHOh-0002UZ-H2
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 07:12:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gmHE0-0004Cg-7C
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 07:01:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53286)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gmHDz-0004BO-P0
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 07:01:44 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3DAFBC0495AE
	for <qemu-devel@nongnu.org>; Wed, 23 Jan 2019 12:01:40 +0000 (UTC)
Date: Wed, 23 Jan 2019 12:01:34 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190123120133.GC5771@work-vm>
References: <20181114132130.27141-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20181114132130.27141-1-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tests: add /vmstate/simple/array
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com

* Marc-Andr=E9 Lureau (marcandre.lureau@redhat.com) wrote:
> A very simple test to show VMSTATE_*_ARRAY usage and result. It could
> be systematically extended to other primitives, but I leave that as an
> exercise for others :).
>=20
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>

Queued

> ---
>  tests/test-vmstate.c | 50 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
>=20
> diff --git a/tests/test-vmstate.c b/tests/test-vmstate.c
> index 37a7a93784..2a960dedbe 100644
> --- a/tests/test-vmstate.c
> +++ b/tests/test-vmstate.c
> @@ -284,6 +284,55 @@ static void test_simple_primitive(void)
>      FIELD_EQUAL(i64_2);
>  }
> =20
> +typedef struct TestSimpleArray {
> +    uint16_t u16_1[3];
> +} TestSimpleArray;
> +
> +/* Object instantiation, we are going to use it in more than one test =
*/
> +
> +TestSimpleArray obj_simple_arr =3D {
> +    .u16_1 =3D { 0x42, 0x43, 0x44 },
> +};
> +
> +/* Description of the values.  If you add a primitive type
> +   you are expected to add a test here */
> +
> +static const VMStateDescription vmstate_simple_arr =3D {
> +    .name =3D "simple/array",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_UINT16_ARRAY(u16_1, TestSimpleArray, 3),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +uint8_t wire_simple_arr[] =3D {
> +    /* u16_1 */ 0x00, 0x42,
> +    /* u16_1 */ 0x00, 0x43,
> +    /* u16_1 */ 0x00, 0x44,
> +    QEMU_VM_EOF, /* just to ensure we won't get EOF reported premature=
ly */
> +};
> +
> +static void obj_simple_arr_copy(void *target, void *source)
> +{
> +    memcpy(target, source, sizeof(TestSimpleArray));
> +}
> +
> +static void test_simple_array(void)
> +{
> +    TestSimpleArray obj, obj_clone;
> +
> +    memset(&obj, 0, sizeof(obj));
> +    save_vmstate(&vmstate_simple_arr, &obj_simple_arr);
> +
> +    compare_vmstate(wire_simple_arr, sizeof(wire_simple_arr));
> +
> +    SUCCESS(load_vmstate(&vmstate_simple_arr, &obj, &obj_clone,
> +                         obj_simple_arr_copy, 1, wire_simple_arr,
> +                         sizeof(wire_simple_arr)));
> +}
> +
>  typedef struct TestStruct {
>      uint32_t a, b, c, e;
>      uint64_t d, f;
> @@ -863,6 +912,7 @@ int main(int argc, char **argv)
> =20
>      g_test_init(&argc, &argv, NULL);
>      g_test_add_func("/vmstate/simple/primitive", test_simple_primitive=
);
> +    g_test_add_func("/vmstate/simple/array", test_simple_array);
>      g_test_add_func("/vmstate/versioned/load/v1", test_load_v1);
>      g_test_add_func("/vmstate/versioned/load/v2", test_load_v2);
>      g_test_add_func("/vmstate/field_exists/load/noskip", test_load_nos=
kip);
> --=20
> 2.19.1.708.g4ede3d42df
>=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
