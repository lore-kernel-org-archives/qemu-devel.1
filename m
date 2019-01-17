Received: from eggs.gnu.org ([209.51.188.92]:59017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gk9C5-0001Vp-Ua
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 10:03:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gk9By-0005Bu-AB
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 10:02:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36930)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1gk9By-000597-3L
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 10:02:50 -0500
Date: Thu, 17 Jan 2019 16:02:37 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190117160237.26c85e69@redhat.com>
In-Reply-To: <2dd66229-b11e-4081-8934-bec2c5a16364@redhat.com>
References: <1547566866-129386-1-git-send-email-imammedo@redhat.com>
	<1547566866-129386-6-git-send-email-imammedo@redhat.com>
	<2dd66229-b11e-4081-8934-bec2c5a16364@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 05/14] tests: acpi: fetch X_DSDT if pointer
 to DSDT is 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, Andrew Jones <drjones@redhat.com>, Samuel Ortiz <sameo@linux.intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, Gonglei <arei.gonglei@huawei.com>, Laszlo Ersek <lersek@redhat.com>

On Thu, 17 Jan 2019 15:02:57 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> On 1/15/19 4:40 PM, Igor Mammedov wrote:
> > that way it would be possible to test a DSDT pointed by
> > 64bit X_DSDT field in FADT.
> >=20
> > PS:
> > it will allow to enable testing arm/virt board, which sets
> > only newer X_DSDT field.
> >=20
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> >  tests/bios-tables-test.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
> > index c28c5c7..0f04a0a 100644
> > --- a/tests/bios-tables-test.c
> > +++ b/tests/bios-tables-test.c
> > @@ -140,6 +140,8 @@ static void test_acpi_fadt_table(test_data *data)
> >      AcpiSdtTable table =3D g_array_index(data->tables, typeof(table), =
0);
> >      uint8_t *fadt_aml =3D table.aml;
> >      uint32_t fadt_len =3D table.aml_len;
> > +    uint32_t val;
> > +    int dsdt_offset =3D 40 /* DSDT */;
> > =20
> >      g_assert(compare_signature(&table, "FACP"));
> > =20
> > @@ -148,8 +150,12 @@ static void test_acpi_fadt_table(test_data *data)
> >                       fadt_aml + 36 /* FIRMWARE_CTRL */, "FACS", false);
> >      g_array_append_val(data->tables, table);
> > =20
> > +    memcpy(&val, fadt_aml + dsdt_offset, 4); =20
>=20
> Maybe in case someone extend this test, add:
>=20
>        val =3D le32_to_cpu(val);
I've skipped this conversion intentionally as we only care about
0 vs non 0. If we would care about concrete value then le32_to_cpu()
would be must have. I can put le32_to_cpu() there if you prefer
as it doesn't hurt and documents that value is in LE.

> Regardless:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>=20
> > +    if (!val) {
> > +        dsdt_offset =3D 140 /* X_DSDT */;
> > +    }
> >      acpi_fetch_table(data->qts, &table.aml, &table.aml_len,
> > -                     fadt_aml + 40 /* DSDT */, "DSDT", true);
> > +                     fadt_aml + dsdt_offset, "DSDT", true);
> >      g_array_append_val(data->tables, table);
> > =20
> >      memset(fadt_aml + 36, 0, 4); /* sanitize FIRMWARE_CTRL ptr */
> >  =20
>=20
