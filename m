Received: from eggs.gnu.org ([209.51.188.92]:60541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hMGb8-0008Do-JC
	for qemu-devel@nongnu.org; Thu, 02 May 2019 14:38:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hMGb7-0005FL-Ie
	for qemu-devel@nongnu.org; Thu, 02 May 2019 14:38:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56870)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hMGb7-0005F2-B7
	for qemu-devel@nongnu.org; Thu, 02 May 2019 14:38:21 -0400
References: <1556808723-226478-1-git-send-email-imammedo@redhat.com>
	<1556808723-226478-14-git-send-email-imammedo@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <33b6a2be-fb11-58ac-812b-798267696e16@redhat.com>
Date: Thu, 2 May 2019 20:38:12 +0200
MIME-Version: 1.0
In-Reply-To: <1556808723-226478-14-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 13/15] tests: acpi: add simple arm/virt
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
Cc: Andrew Jones <drjones@redhat.com>, Ben Warren <ben@skyportsystems.com>, "Michael S. Tsirkin" <mst@redhat.com>, linuxarm@huawei.com, Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, Gonglei <arei.gonglei@huawei.com>, Wei Yang <richardw.yang@linux.intel.com>, xuwei5@huawei.com, xuwei5@hisilicon.com, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>

On 05/02/19 16:52, Igor Mammedov wrote:
> adds simple arm/virt test case that starts guest with
> bios-tables-test.aarch64.iso.qcow2 boot image which
> initializes UefiTestSupport* structure in RAM once
> guest is booted.
>=20
>  * see commit: tests: acpi: add acpi_find_rsdp_address_uefi() helper
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> v4:
>   * force test to use TCG accelerator
> v3:
>   * use firmware blobs directly from pc-bios directory
>   * use bios-tables-test.aarch64.iso.qcow2 as test boot image
>   * drop leftover qtest-uefi-images-aarch64 iMakefile rule from
>     previos version (Laszlo)
>   * add Makefile rule to include bios-tables-test into
>     check-qtest-aarch64 target
> v2:
>   * specify in test_data where board's RAM starts and RAM size
>=20
> fixup! tests: acpi: add simple arm/virt testcase
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  tests/Makefile.include   |  1 +
>  tests/bios-tables-test.c | 18 ++++++++++++++++++
>  2 files changed, 19 insertions(+)
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
> index 39c1e24..eaa1b0c 100644
> --- a/tests/bios-tables-test.c
> +++ b/tests/bios-tables-test.c
> @@ -810,6 +810,22 @@ static void test_acpi_piix4_tcg_dimm_pxm(void)
>      test_acpi_tcg_dimm_pxm(MACHINE_PC);
>  }
> =20
> +static void test_acpi_virt_tcg(void)
> +{
> +    test_data data =3D {
> +        .machine =3D "virt",
> +        .accel =3D "tcg",
> +        .uefi_fl1 =3D "pc-bios/edk2-aarch64-code.fd",
> +        .uefi_fl2 =3D "pc-bios/edk2-arm-vars.fd",
> +        .cd =3D "tests/data/uefi-boot-images/bios-tables-test.aarch64.=
iso.qcow2",
> +        .ram_start =3D 0x40000000ULL,
> +        .scan_len =3D 128ULL * 1024 * 1024,
> +    };
> +
> +    test_acpi_one("-cpu cortex-a57", &data);
> +    free_test_data(&data);
> +}
> +
>  int main(int argc, char *argv[])
>  {
>      const char *arch =3D qtest_get_arch();
> @@ -838,6 +854,8 @@ int main(int argc, char *argv[])
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

my R-b stands

thanks
Laszlo
