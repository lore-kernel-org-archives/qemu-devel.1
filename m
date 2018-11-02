Received: from eggs.gnu.org ([2001:4830:134:3::10]:49242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gIhXX-0001j4-6M
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 18:03:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gIhXV-0000ZV-Si
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 18:03:38 -0400
References: <20181030001841.1658-1-philmd@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d6148cb9-9cab-1aa2-18c8-ed9e076fd9c2@redhat.com>
Date: Fri, 2 Nov 2018 22:03:15 +0000
MIME-Version: 1.0
In-Reply-To: <20181030001841.1658-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tests/bios-tables-test: Sanitize test
 verbose output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 2018-10-30 00:18, Philippe Mathieu-Daud=C3=A9 wrote:
> Fix the extraneous extra blank lines in the test output when running wi=
th V=3D1.
>=20
> Before:
>=20
>     TEST: tests/bios-tables-test... (pid=3D25678)
>       /i386/acpi/piix4:
>     Looking for expected file 'tests/acpi-test-data/pc/DSDT'
>=20
>     Using expected file 'tests/acpi-test-data/pc/DSDT'
>=20
>     Looking for expected file 'tests/acpi-test-data/pc/FACP'
>=20
>     Using expected file 'tests/acpi-test-data/pc/FACP'
>=20
>     Looking for expected file 'tests/acpi-test-data/pc/APIC'
>=20
>     Using expected file 'tests/acpi-test-data/pc/APIC'
>=20
>     Looking for expected file 'tests/acpi-test-data/pc/HPET'
>=20
>     Using expected file 'tests/acpi-test-data/pc/HPET'
>     OK
>=20
> After:
>=20
>     TEST: tests/bios-tables-test... (pid=3D667)
>       /i386/acpi/piix4:
>     Looking for expected file 'tests/acpi-test-data/pc/DSDT'
>     Using expected file 'tests/acpi-test-data/pc/DSDT'
>     Looking for expected file 'tests/acpi-test-data/pc/FACP'
>     Using expected file 'tests/acpi-test-data/pc/FACP'
>     Looking for expected file 'tests/acpi-test-data/pc/APIC'
>     Using expected file 'tests/acpi-test-data/pc/APIC'
>     Looking for expected file 'tests/acpi-test-data/pc/HPET'
>     Using expected file 'tests/acpi-test-data/pc/HPET'
>     OK
>=20
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  tests/bios-tables-test.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
> index 4e24930c4b..02dd48de0d 100644
> --- a/tests/bios-tables-test.c
> +++ b/tests/bios-tables-test.c
> @@ -371,6 +371,9 @@ static GArray *load_expected_aml(test_data *data)
>      gboolean ret;
> =20
>      GArray *exp_tables =3D g_array_new(false, true, sizeof(AcpiSdtTabl=
e));
> +    if (getenv("V")) {
> +        fputc('\n', stderr);
> +    }
>      for (i =3D 0; i < data->tables->len; ++i) {
>          AcpiSdtTable exp_sdt;
>          gchar *aml_file =3D NULL;
> @@ -385,7 +388,7 @@ try_again:
>          aml_file =3D g_strdup_printf("%s/%s/%.4s%s", data_dir, data->m=
achine,
>                                     (gchar *)&sdt->header.signature, ex=
t);
>          if (getenv("V")) {
> -            fprintf(stderr, "\nLooking for expected file '%s'\n", aml_=
file);
> +            fprintf(stderr, "Looking for expected file '%s'\n", aml_fi=
le);
>          }
>          if (g_file_test(aml_file, G_FILE_TEST_EXISTS)) {
>              exp_sdt.aml_file =3D aml_file;
> @@ -397,7 +400,7 @@ try_again:
>          }
>          g_assert(exp_sdt.aml_file);
>          if (getenv("V")) {
> -            fprintf(stderr, "\nUsing expected file '%s'\n", aml_file);
> +            fprintf(stderr, "Using expected file '%s'\n", aml_file);
>          }
>          ret =3D g_file_get_contents(aml_file, &exp_sdt.aml,
>                                    &exp_sdt.aml_len, &error);
>=20

Could we please get rid of the getenv + fprintf here and use
g_test_message() instead, like we already do in most of the other tests
that want to log additional output?

  Thomas
