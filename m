Received: from eggs.gnu.org ([209.51.188.92]:45676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hK4OK-0004wr-8P
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 13:12:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hK4OJ-0002zn-3S
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 13:12:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:26808)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hK4OI-0002yf-Rl
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 13:12:03 -0400
References: <1556170489-131927-1-git-send-email-imammedo@redhat.com>
	<1556170489-131927-12-git-send-email-imammedo@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <0676f7d1-5d75-8ff8-a75b-a9ce01a65741@redhat.com>
Date: Fri, 26 Apr 2019 19:11:50 +0200
MIME-Version: 1.0
In-Reply-To: <1556170489-131927-12-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 11/13] tests: acpi: add simple arm/virt
 testcase
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Gonglei <arei.gonglei@huawei.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, Wei Yang <richardw.yang@linux.intel.com>, Andrew Jones <drjones@redhat.com>, Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, Ben Warren <ben@skyportsystems.com>

On 04/25/19 07:34, Igor Mammedov wrote:
> adds simple arm/virt test case that starts guest with
> bios-tables-test.aarch64.iso.qcow2 boot image which
> initializes UefiTestSupport* structure in RAM once
> guest is booted.
>=20
>  * see commit: tests: acpi: add acpi_find_rsdp_address_uefi() helper
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> v3:
>   * use firmware blobs directly from pc-bios directory
>   * use bios-tables-test.aarch64.iso.qcow2 as test boot image
>   * drop leftover qtest-uefi-images-aarch64 iMakefile rule from
>     previos version (Laszlo)
>   * add Makefile rule to include bios-tables-test into
>     check-qtest-aarch64 target
> v2:
>   * specify in test_data where board's RAM starts and RAM size
> ---
>  tests/Makefile.include   |  1 +
>  tests/bios-tables-test.c | 17 +++++++++++++++++
>  2 files changed, 18 insertions(+)
>=20
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index e2432d5..983c8b1 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -267,6 +267,7 @@ check-qtest-arm-y +=3D tests/hexloader-test$(EXESUF=
)
>  check-qtest-aarch64-y =3D tests/numa-test$(EXESUF)
>  check-qtest-aarch64-y +=3D tests/boot-serial-test$(EXESUF)
>  check-qtest-aarch64-y +=3D tests/migration-test$(EXESUF)
> +check-qtest-aarch64-y +=3D tests/bios-tables-test$(EXESUF)
> =20
>  check-qtest-microblazeel-y +=3D $(check-qtest-microblaze-y)
> =20
> diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
> index 1be55a1..f117461 100644
> --- a/tests/bios-tables-test.c
> +++ b/tests/bios-tables-test.c
> @@ -812,6 +812,21 @@ static void test_acpi_piix4_tcg_dimm_pxm(void)
>      test_acpi_tcg_dimm_pxm(MACHINE_PC);
>  }
> =20
> +static void test_acpi_virt_tcg(void)
> +{
> +    test_data data =3D {
> +        .machine =3D "virt",
> +        .uefi_fl1 =3D "pc-bios/edk2-aarch64-code.fd",
> +        .uefi_fl2 =3D "pc-bios/edk2-arm-vars.fd",
> +        .cd =3D "tests/data/uefi-boot-images/bios-tables-test.aarch64.=
iso.qcow2",
> +        .ram_start =3D 0x40000000ULL,
> +        .scan_len =3D 128ULL * 1024 * 1024,
> +    };
> +
> +    test_acpi_one("-cpu cortex-a57 ", &data);
> +    free_test_data(&data);
> +}
> +
>  int main(int argc, char *argv[])
>  {
>      const char *arch =3D qtest_get_arch();
> @@ -840,6 +855,8 @@ int main(int argc, char *argv[])
>          qtest_add_func("acpi/q35/numamem", test_acpi_q35_tcg_numamem);
>          qtest_add_func("acpi/piix4/dimmpxm", test_acpi_piix4_tcg_dimm_=
pxm);
>          qtest_add_func("acpi/q35/dimmpxm", test_acpi_q35_tcg_dimm_pxm)=
;
> +    } else if (strcmp(arch, "aarch64") =3D=3D 0) {
> +        qtest_add_func("acpi/virt", test_acpi_virt_tcg);
>      }
>      ret =3D g_test_run();
>      boot_sector_cleanup(disk);
>=20

Looks good, my R-b stands.

(Please let me know if you want me to look at other patches in the
series... struggling again with email bankruptcy...)

Thanks!
Laszlo
