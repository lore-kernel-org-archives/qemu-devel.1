Received: from eggs.gnu.org ([2001:4830:134:3::10]:42997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1dW2qC-0006Ax-2s
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 11:49:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1dW2q8-00018q-0v
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 11:49:16 -0400
Received: from mail-pf0-x232.google.com ([2607:f8b0:400e:c00::232]:36454)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ben@skyportsystems.com>)
	id 1dW2q7-00018J-Nw
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 11:49:11 -0400
Received: by mail-pf0-x232.google.com with SMTP id q86so47277487pfl.3
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 08:49:09 -0700 (PDT)
From: Ben Warren <ben@skyportsystems.com>
Message-Id: <4B913392-333F-455D-817E-46A1DE88FC6B@skyportsystems.com>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Date: Fri, 14 Jul 2017 08:49:07 -0700
In-Reply-To: <1500046217-24597-1-git-send-email-mst@redhat.com>
References: <1500046217-24597-1-git-send-email-mst@redhat.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] vmgenid-test: use boot-sector
 infrastructure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Laszlo Ersek <lersek@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

Hi Michael,

Looks good.  Thanks for taking care of this.
> On Jul 14, 2017, at 8:30 AM, Michael S. Tsirkin <mst@redhat.com> =
wrote:
>=20
> There's no requirement for RSDP to be installed last
> by the firmware, so in rare cases vmgen id test hits
> a race: RSDP is there but VM GEN ID isn't.
>=20
> To fix, switch to common boot sector infrastructure.
>=20
> Cc: Laszlo Ersek <lersek@redhat.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Ben Warren <ben@skyportsystems.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Ben Warren <ben@skyportsystems.com =
<mailto:ben@skyportsystems.com>>
> ---
>=20
> Changes from v1
>    fix coding style violation reported by Peter
>=20
> tests/vmgenid-test.c   | 46 =
++++++++++++++++++++++++++++++----------------
> tests/Makefile.include |  2 +-
> 2 files changed, 31 insertions(+), 17 deletions(-)
>=20
> diff --git a/tests/vmgenid-test.c b/tests/vmgenid-test.c
> index e7ba38c..a49de92 100644
> --- a/tests/vmgenid-test.c
> +++ b/tests/vmgenid-test.c
> @@ -15,6 +15,7 @@
> #include "qemu/bitmap.h"
> #include "qemu/uuid.h"
> #include "hw/acpi/acpi-defs.h"
> +#include "boot-sector.h"
> #include "acpi-utils.h"
> #include "libqtest.h"
>=20
> @@ -23,8 +24,6 @@
>                                   * OVMF SDT Header Probe Supressor
>                                   */
> #define RSDP_ADDR_INVALID 0x100000 /* RSDP must be below this address =
*/
> -#define RSDP_SLEEP_US     100000   /* Sleep for 100ms between tries =
*/
> -#define RSDP_TRIES_MAX    100      /* Max total time is 10 seconds */
>=20
> typedef struct {
>     AcpiTableHeader header;
> @@ -47,14 +46,12 @@ static uint32_t acpi_find_vgia(void)
>     VgidTable vgid_table;
>     int i;
>=20
> -    /* Tables may take a short time to be set up by the guest */
> -    for (i =3D 0; i < RSDP_TRIES_MAX; i++) {
> -        rsdp_offset =3D acpi_find_rsdp_address();
> -        if (rsdp_offset < RSDP_ADDR_INVALID) {
> -            break;
> -        }
> -        g_usleep(RSDP_SLEEP_US);
> -    }
> +    /* Wait for guest firmware to finish and start the payload. */
> +    boot_sector_test();
> +
> +    /* Tables should be initialized now. */
> +    rsdp_offset =3D acpi_find_rsdp_address();
> +
>     g_assert_cmphex(rsdp_offset, <, RSDP_ADDR_INVALID);
>=20
>     acpi_parse_rsdp_table(rsdp_offset, &rsdp_table);
> @@ -131,6 +128,18 @@ static void read_guid_from_monitor(QemuUUID =
*guid)
>     QDECREF(rsp);
> }
>=20
> +static char disk[] =3D "tests/vmgenid-test-disk-XXXXXX";
> +
> +static char *guid_cmd_strdup(const char *guid)
> +{
> +    return g_strdup_printf("-machine accel=3Dtcg "
> +                           "-device vmgenid,id=3Dtestvgid,guid=3D%s "
> +                           "-drive id=3Dhd0,if=3Dnone,file=3D%s,format=3D=
raw "
> +                           "-device ide-hd,drive=3Dhd0 ",
> +                           guid, disk);
> +}
> +
> +
> static void vmgenid_set_guid_test(void)
> {
>     QemuUUID expected, measured;
> @@ -138,8 +147,7 @@ static void vmgenid_set_guid_test(void)
>=20
>     g_assert(qemu_uuid_parse(VGID_GUID, &expected) =3D=3D 0);
>=20
> -    cmd =3D g_strdup_printf("-machine accel=3Dtcg -device =
vmgenid,id=3Dtestvgid,"
> -                          "guid=3D%s", VGID_GUID);
> +    cmd =3D guid_cmd_strdup(VGID_GUID);
>     qtest_start(cmd);
>=20
>     /* Read the GUID from accessing guest memory */
> @@ -152,10 +160,10 @@ static void vmgenid_set_guid_test(void)
>=20
> static void vmgenid_set_guid_auto_test(void)
> {
> -    const char *cmd;
> +    char *cmd;
>     QemuUUID measured;
>=20
> -    cmd =3D "-machine accel=3Dtcg -device vmgenid,id=3Dtestvgid," =
"guid=3Dauto";
> +    cmd =3D guid_cmd_strdup("auto");
>     qtest_start(cmd);
>=20
>     read_guid_from_memory(&measured);
> @@ -164,6 +172,7 @@ static void vmgenid_set_guid_auto_test(void)
>     g_assert(!qemu_uuid_is_null(&measured));
>=20
>     qtest_quit(global_qtest);
> +    g_free(cmd);
> }
>=20
> static void vmgenid_query_monitor_test(void)
> @@ -173,8 +182,7 @@ static void vmgenid_query_monitor_test(void)
>=20
>     g_assert(qemu_uuid_parse(VGID_GUID, &expected) =3D=3D 0);
>=20
> -    cmd =3D g_strdup_printf("-machine accel=3Dtcg -device =
vmgenid,id=3Dtestvgid,"
> -                          "guid=3D%s", VGID_GUID);
> +    cmd =3D guid_cmd_strdup(VGID_GUID);
>     qtest_start(cmd);
>=20
>     /* Read the GUID via the monitor */
> @@ -189,6 +197,11 @@ int main(int argc, char **argv)
> {
>     int ret;
>=20
> +    ret =3D boot_sector_init(disk);
> +    if (ret) {
> +        return ret;
> +    }
> +
>     g_test_init(&argc, &argv, NULL);
>=20
>     qtest_add_func("/vmgenid/vmgenid/set-guid",
> @@ -198,6 +211,7 @@ int main(int argc, char **argv)
>     qtest_add_func("/vmgenid/vmgenid/query-monitor",
>                    vmgenid_query_monitor_test);
>     ret =3D g_test_run();
> +    boot_sector_cleanup(disk);
>=20
>     return ret;
> }
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 18cd06a..aef374b 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -761,7 +761,7 @@ tests/test-uuid$(EXESUF): tests/test-uuid.o =
$(test-util-obj-y)
> tests/test-arm-mptimer$(EXESUF): tests/test-arm-mptimer.o
> tests/test-qapi-util$(EXESUF): tests/test-qapi-util.o =
$(test-util-obj-y)
> tests/numa-test$(EXESUF): tests/numa-test.o
> -tests/vmgenid-test$(EXESUF): tests/vmgenid-test.o tests/acpi-utils.o
> +tests/vmgenid-test$(EXESUF): tests/vmgenid-test.o tests/boot-sector.o =
tests/acpi-utils.o
>=20
> tests/migration/stress$(EXESUF): tests/migration/stress.o
> 	$(call quiet-command, $(LINKPROG) -static -O3 $(PTHREAD_LIB) -o =
$@ $< ,"LINK","$(TARGET_DIR)$@")
> --=20
> MST
