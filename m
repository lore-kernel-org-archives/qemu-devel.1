Received: from eggs.gnu.org ([2001:4830:134:3::10]:38635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dpBYM-0006Qo-De
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 06:58:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dpBYH-0003OA-5P
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 06:57:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47524)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dpBYG-0003Ll-TI
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 06:57:53 -0400
References: <20170901180340.30009-1-eblake@redhat.com>
	<20170901180340.30009-24-eblake@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e1f003db-0841-c2a1-c019-6b9d68114281@redhat.com>
Date: Tue, 5 Sep 2017 12:57:46 +0200
MIME-Version: 1.0
In-Reply-To: <20170901180340.30009-24-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 23/29] tests/acpi-utils: Drop dependence
 on global_qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, Igor Mammedov <imammedo@redhat.com>, armbru@redhat.com, Ben Warren <ben@skyportsystems.com>, "Michael S. Tsirkin" <mst@redhat.com>

On 01.09.2017 20:03, Eric Blake wrote:
> As a general rule, we prefer avoiding implicit global state
> because it makes code harder to safely copy and paste without
> thinking about the global state.  Adjust the helper code to
> use explicit state instead, and update all callers.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  tests/acpi-utils.h       |  65 +++++++++----------
>  tests/acpi-utils.c       |  19 +++---
>  tests/bios-tables-test.c | 161 ++++++++++++++++++++++++---------------=
--------
>  tests/vmgenid-test.c     |  18 +++---
>  4 files changed, 133 insertions(+), 130 deletions(-)
[...]
> @@ -87,7 +87,7 @@ static void test_acpi_rsdp_table(test_data *data)
>      AcpiRsdpDescriptor *rsdp_table =3D &data->rsdp_table;
>      uint32_t addr =3D data->rsdp_addr;
>=20
> -    acpi_parse_rsdp_table(addr, rsdp_table);
> +    acpi_parse_rsdp_table(global_qtest, addr, rsdp_table);
>=20
>      /* rsdp checksum is not for the whole table, but for the first 20 =
bytes */
>      g_assert(!acpi_calc_checksum((uint8_t *)rsdp_table, 20));
> @@ -102,7 +102,7 @@ static void test_acpi_rsdt_table(test_data *data)
>      uint8_t checksum;
>=20
>      /* read the header */
> -    ACPI_READ_TABLE_HEADER(rsdt_table, addr);
> +    ACPI_READ_TABLE_HEADER(global_qtest, rsdt_table, addr);
>      ACPI_ASSERT_CMP(rsdt_table->signature, "RSDT");
>=20
>      /* compute the table entries in rsdt */
> @@ -112,7 +112,7 @@ static void test_acpi_rsdt_table(test_data *data)
>=20
>      /* get the addresses of the tables pointed by rsdt */
>      tables =3D g_new0(uint32_t, tables_nr);
> -    ACPI_READ_ARRAY_PTR(tables, tables_nr, addr);
> +    ACPI_READ_ARRAY_PTR(global_qtest, tables, tables_nr, addr);
>=20
>      checksum =3D acpi_calc_checksum((uint8_t *)rsdt_table, rsdt_table-=
>length) +
>                 acpi_calc_checksum((uint8_t *)tables,

Wouldn't it be better to use a "QTestState *qts =3D global_qtest" variabl=
e
in this function, like you do it below in test_acpi_fadt_table()? Or
even pass it via test_data already? Otherwise you've got to change all
lines again when finally getting rid of global_qtest ...

> @@ -128,63 +128,64 @@ static void test_acpi_fadt_table(test_data *data)
>  {
>      AcpiFadtDescriptorRev3 *fadt_table =3D &data->fadt_table;
>      uint32_t addr;
> +    QTestState *qts =3D global_qtest;
>=20
>      /* FADT table comes first */
>      addr =3D data->rsdt_tables_addr[0];
> -    ACPI_READ_TABLE_HEADER(fadt_table, addr);
> +    ACPI_READ_TABLE_HEADER(qts, fadt_table, addr);
>=20
> -    ACPI_READ_FIELD(fadt_table->firmware_ctrl, addr);
> -    ACPI_READ_FIELD(fadt_table->dsdt, addr);
> -    ACPI_READ_FIELD(fadt_table->model, addr);
> -    ACPI_READ_FIELD(fadt_table->reserved1, addr);
> -    ACPI_READ_FIELD(fadt_table->sci_int, addr);
> -    ACPI_READ_FIELD(fadt_table->smi_cmd, addr);
> -    ACPI_READ_FIELD(fadt_table->acpi_enable, addr);
> -    ACPI_READ_FIELD(fadt_table->acpi_disable, addr);
> -    ACPI_READ_FIELD(fadt_table->S4bios_req, addr);
> -    ACPI_READ_FIELD(fadt_table->reserved2, addr);
> -    ACPI_READ_FIELD(fadt_table->pm1a_evt_blk, addr);
> -    ACPI_READ_FIELD(fadt_table->pm1b_evt_blk, addr);
> -    ACPI_READ_FIELD(fadt_table->pm1a_cnt_blk, addr);
> -    ACPI_READ_FIELD(fadt_table->pm1b_cnt_blk, addr);
> -    ACPI_READ_FIELD(fadt_table->pm2_cnt_blk, addr);
> -    ACPI_READ_FIELD(fadt_table->pm_tmr_blk, addr);
> -    ACPI_READ_FIELD(fadt_table->gpe0_blk, addr);
> -    ACPI_READ_FIELD(fadt_table->gpe1_blk, addr);
> -    ACPI_READ_FIELD(fadt_table->pm1_evt_len, addr);
> -    ACPI_READ_FIELD(fadt_table->pm1_cnt_len, addr);
> -    ACPI_READ_FIELD(fadt_table->pm2_cnt_len, addr);
> -    ACPI_READ_FIELD(fadt_table->pm_tmr_len, addr);
> -    ACPI_READ_FIELD(fadt_table->gpe0_blk_len, addr);
> -    ACPI_READ_FIELD(fadt_table->gpe1_blk_len, addr);
> -    ACPI_READ_FIELD(fadt_table->gpe1_base, addr);
> -    ACPI_READ_FIELD(fadt_table->reserved3, addr);
> -    ACPI_READ_FIELD(fadt_table->plvl2_lat, addr);
> -    ACPI_READ_FIELD(fadt_table->plvl3_lat, addr);
> -    ACPI_READ_FIELD(fadt_table->flush_size, addr);
> -    ACPI_READ_FIELD(fadt_table->flush_stride, addr);
> -    ACPI_READ_FIELD(fadt_table->duty_offset, addr);
> -    ACPI_READ_FIELD(fadt_table->duty_width, addr);
> -    ACPI_READ_FIELD(fadt_table->day_alrm, addr);
> -    ACPI_READ_FIELD(fadt_table->mon_alrm, addr);
> -    ACPI_READ_FIELD(fadt_table->century, addr);
> -    ACPI_READ_FIELD(fadt_table->boot_flags, addr);
> -    ACPI_READ_FIELD(fadt_table->reserved, addr);
> -    ACPI_READ_FIELD(fadt_table->flags, addr);
> -    ACPI_READ_GENERIC_ADDRESS(fadt_table->reset_register, addr);
> -    ACPI_READ_FIELD(fadt_table->reset_value, addr);
> -    ACPI_READ_FIELD(fadt_table->arm_boot_flags, addr);
> -    ACPI_READ_FIELD(fadt_table->minor_revision, addr);
> -    ACPI_READ_FIELD(fadt_table->x_facs, addr);
> -    ACPI_READ_FIELD(fadt_table->x_dsdt, addr);
> -    ACPI_READ_GENERIC_ADDRESS(fadt_table->xpm1a_event_block, addr);
> -    ACPI_READ_GENERIC_ADDRESS(fadt_table->xpm1b_event_block, addr);
> -    ACPI_READ_GENERIC_ADDRESS(fadt_table->xpm1a_control_block, addr);
> -    ACPI_READ_GENERIC_ADDRESS(fadt_table->xpm1b_control_block, addr);
> -    ACPI_READ_GENERIC_ADDRESS(fadt_table->xpm2_control_block, addr);
> -    ACPI_READ_GENERIC_ADDRESS(fadt_table->xpm_timer_block, addr);
> -    ACPI_READ_GENERIC_ADDRESS(fadt_table->xgpe0_block, addr);
> -    ACPI_READ_GENERIC_ADDRESS(fadt_table->xgpe1_block, addr);
> +    ACPI_READ_FIELD(qts, fadt_table->firmware_ctrl, addr);
> +    ACPI_READ_FIELD(qts, fadt_table->dsdt, addr);
> +    ACPI_READ_FIELD(qts, fadt_table->model, addr);
> +    ACPI_READ_FIELD(qts, fadt_table->reserved1, addr);
> +    ACPI_READ_FIELD(qts, fadt_table->sci_int, addr);
> +    ACPI_READ_FIELD(qts, fadt_table->smi_cmd, addr);
> +    ACPI_READ_FIELD(qts, fadt_table->acpi_enable, addr);
> +    ACPI_READ_FIELD(qts, fadt_table->acpi_disable, addr);
> +    ACPI_READ_FIELD(qts, fadt_table->S4bios_req, addr);
> +    ACPI_READ_FIELD(qts, fadt_table->reserved2, addr);
> +    ACPI_READ_FIELD(qts, fadt_table->pm1a_evt_blk, addr);
> +    ACPI_READ_FIELD(qts, fadt_table->pm1b_evt_blk, addr);
> +    ACPI_READ_FIELD(qts, fadt_table->pm1a_cnt_blk, addr);
> +    ACPI_READ_FIELD(qts, fadt_table->pm1b_cnt_blk, addr);
> +    ACPI_READ_FIELD(qts, fadt_table->pm2_cnt_blk, addr);
> +    ACPI_READ_FIELD(qts, fadt_table->pm_tmr_blk, addr);
> +    ACPI_READ_FIELD(qts, fadt_table->gpe0_blk, addr);
> +    ACPI_READ_FIELD(qts, fadt_table->gpe1_blk, addr);
> +    ACPI_READ_FIELD(qts, fadt_table->pm1_evt_len, addr);
> +    ACPI_READ_FIELD(qts, fadt_table->pm1_cnt_len, addr);
> +    ACPI_READ_FIELD(qts, fadt_table->pm2_cnt_len, addr);
> +    ACPI_READ_FIELD(qts, fadt_table->pm_tmr_len, addr);
> +    ACPI_READ_FIELD(qts, fadt_table->gpe0_blk_len, addr);
> +    ACPI_READ_FIELD(qts, fadt_table->gpe1_blk_len, addr);
> +    ACPI_READ_FIELD(qts, fadt_table->gpe1_base, addr);
> +    ACPI_READ_FIELD(qts, fadt_table->reserved3, addr);
> +    ACPI_READ_FIELD(qts, fadt_table->plvl2_lat, addr);
> +    ACPI_READ_FIELD(qts, fadt_table->plvl3_lat, addr);
> +    ACPI_READ_FIELD(qts, fadt_table->flush_size, addr);
> +    ACPI_READ_FIELD(qts, fadt_table->flush_stride, addr);
> +    ACPI_READ_FIELD(qts, fadt_table->duty_offset, addr);
> +    ACPI_READ_FIELD(qts, fadt_table->duty_width, addr);
> +    ACPI_READ_FIELD(qts, fadt_table->day_alrm, addr);
> +    ACPI_READ_FIELD(qts, fadt_table->mon_alrm, addr);
> +    ACPI_READ_FIELD(qts, fadt_table->century, addr);
> +    ACPI_READ_FIELD(qts, fadt_table->boot_flags, addr);
> +    ACPI_READ_FIELD(qts, fadt_table->reserved, addr);
> +    ACPI_READ_FIELD(qts, fadt_table->flags, addr);
> +    ACPI_READ_GENERIC_ADDRESS(qts, fadt_table->reset_register, addr);
> +    ACPI_READ_FIELD(qts, fadt_table->reset_value, addr);
> +    ACPI_READ_FIELD(qts, fadt_table->arm_boot_flags, addr);
> +    ACPI_READ_FIELD(qts, fadt_table->minor_revision, addr);
> +    ACPI_READ_FIELD(qts, fadt_table->x_facs, addr);
> +    ACPI_READ_FIELD(qts, fadt_table->x_dsdt, addr);
> +    ACPI_READ_GENERIC_ADDRESS(qts, fadt_table->xpm1a_event_block, addr=
);
> +    ACPI_READ_GENERIC_ADDRESS(qts, fadt_table->xpm1b_event_block, addr=
);
> +    ACPI_READ_GENERIC_ADDRESS(qts, fadt_table->xpm1a_control_block, ad=
dr);
> +    ACPI_READ_GENERIC_ADDRESS(qts, fadt_table->xpm1b_control_block, ad=
dr);
> +    ACPI_READ_GENERIC_ADDRESS(qts, fadt_table->xpm2_control_block, add=
r);
> +    ACPI_READ_GENERIC_ADDRESS(qts, fadt_table->xpm_timer_block, addr);
> +    ACPI_READ_GENERIC_ADDRESS(qts, fadt_table->xgpe0_block, addr);
> +    ACPI_READ_GENERIC_ADDRESS(qts, fadt_table->xgpe1_block, addr);
>=20
>      ACPI_ASSERT_CMP(fadt_table->signature, "FACP");
>      g_assert(!acpi_calc_checksum((uint8_t *)fadt_table, fadt_table->le=
ngth));
> @@ -195,13 +196,13 @@ static void test_acpi_facs_table(test_data *data)
>      AcpiFacsDescriptorRev1 *facs_table =3D &data->facs_table;
>      uint32_t addr =3D data->fadt_table.firmware_ctrl;
>=20
> -    ACPI_READ_FIELD(facs_table->signature, addr);
> -    ACPI_READ_FIELD(facs_table->length, addr);
> -    ACPI_READ_FIELD(facs_table->hardware_signature, addr);
> -    ACPI_READ_FIELD(facs_table->firmware_waking_vector, addr);
> -    ACPI_READ_FIELD(facs_table->global_lock, addr);
> -    ACPI_READ_FIELD(facs_table->flags, addr);
> -    ACPI_READ_ARRAY(facs_table->resverved3, addr);
> +    ACPI_READ_FIELD(global_qtest, facs_table->signature, addr);
> +    ACPI_READ_FIELD(global_qtest, facs_table->length, addr);
> +    ACPI_READ_FIELD(global_qtest, facs_table->hardware_signature, addr=
);
> +    ACPI_READ_FIELD(global_qtest, facs_table->firmware_waking_vector, =
addr);
> +    ACPI_READ_FIELD(global_qtest, facs_table->global_lock, addr);
> +    ACPI_READ_FIELD(global_qtest, facs_table->flags, addr);
> +    ACPI_READ_ARRAY(global_qtest, facs_table->resverved3, addr);

Dito, i.e. use a local "QTestState *qts =3D global_qtest" variable instea=
d?

Same comment applies to the other functions where you were using
global_test like this.

 Thomas
