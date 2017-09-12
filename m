Received: from eggs.gnu.org ([2001:4830:134:3::10]:46960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1drhSl-0006r5-Ob
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 05:26:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1drhSi-0005wu-La
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 05:26:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52880)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1drhSi-0005us-Ci
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 05:26:32 -0400
References: <20170911172022.4738-1-eblake@redhat.com>
	<20170911172022.4738-25-eblake@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <4e98d25b-6f75-10f9-cbed-c2f26a1082f2@redhat.com>
Date: Tue, 12 Sep 2017 11:26:25 +0200
MIME-Version: 1.0
In-Reply-To: <20170911172022.4738-25-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 24/38] tests/acpi-utils: Drop dependence
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
Cc: armbru@redhat.com, pbonzini@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Ben Warren <ben@skyportsystems.com>

On 11.09.2017 19:20, Eric Blake wrote:
> As a general rule, we prefer avoiding implicit global state
> because it makes code harder to safely copy and paste without
> thinking about the global state.  Adjust the helper code to
> use explicit state instead, and update all callers.
> 
> bios-tables-test no longer depends on global_qtest, now that it
> passes explicit state through the testsuite data; an assert
> proves this fact (although we will get rid of it later, once
> global_qtest is gone).
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
[...]
> diff --git a/tests/vmgenid-test.c b/tests/vmgenid-test.c
> index 0ea98b86d7..970c6274fd 100644
> --- a/tests/vmgenid-test.c
> +++ b/tests/vmgenid-test.c
> @@ -50,15 +50,15 @@ static uint32_t acpi_find_vgia(void)
>      boot_sector_test(global_qtest);
> 
>      /* Tables should be initialized now. */
> -    rsdp_offset = acpi_find_rsdp_address();
> +    rsdp_offset = acpi_find_rsdp_address(global_qtest);
> 
>      g_assert_cmphex(rsdp_offset, <, RSDP_ADDR_INVALID);
> 
> -    acpi_parse_rsdp_table(rsdp_offset, &rsdp_table);
> +    acpi_parse_rsdp_table(global_qtest, rsdp_offset, &rsdp_table);
> 
>      rsdt = rsdp_table.rsdt_physical_address;
>      /* read the header */
> -    ACPI_READ_TABLE_HEADER(&rsdt_table, rsdt);
> +    ACPI_READ_TABLE_HEADER(global_qtest, &rsdt_table, rsdt);
>      ACPI_ASSERT_CMP(rsdt_table.signature, "RSDT");
> 
>      /* compute the table entries in rsdt */
> @@ -68,21 +68,21 @@ static uint32_t acpi_find_vgia(void)
> 
>      /* get the addresses of the tables pointed by rsdt */
>      tables = g_new0(uint32_t, tables_nr);
> -    ACPI_READ_ARRAY_PTR(tables, tables_nr, rsdt);
> +    ACPI_READ_ARRAY_PTR(global_qtest, tables, tables_nr, rsdt);
> 
>      for (i = 0; i < tables_nr; i++) {
> -        ACPI_READ_TABLE_HEADER(&ssdt_table, tables[i]);
> +        ACPI_READ_TABLE_HEADER(global_qtest, &ssdt_table, tables[i]);
>          if (!strncmp((char *)ssdt_table.oem_table_id, "VMGENID", 7)) {
>              /* the first entry in the table should be VGIA
>               * That's all we need
>               */
> -            ACPI_READ_FIELD(vgid_table.name_op, tables[i]);
> +            ACPI_READ_FIELD(global_qtest, vgid_table.name_op, tables[i]);
>              g_assert(vgid_table.name_op == 0x08);  /* name */
> -            ACPI_READ_ARRAY(vgid_table.vgia, tables[i]);
> +            ACPI_READ_ARRAY(global_qtest, vgid_table.vgia, tables[i]);
>              g_assert(memcmp(vgid_table.vgia, "VGIA", 4) == 0);
> -            ACPI_READ_FIELD(vgid_table.val_op, tables[i]);
> +            ACPI_READ_FIELD(global_qtest, vgid_table.val_op, tables[i]);
>              g_assert(vgid_table.val_op == 0x0C);  /* dword */
> -            ACPI_READ_FIELD(vgid_table.vgia_val, tables[i]);
> +            ACPI_READ_FIELD(global_qtest, vgid_table.vgia_val, tables[i]);
>              /* The GUID is written at a fixed offset into the fw_cfg file
>               * in order to implement the "OVMF SDT Header probe suppressor"
>               * see docs/specs/vmgenid.txt for more details
> 

I'd maybe use a local "QTestState *qts = global_qtest;" at the beginning
of this function instead, and then use "qts" instead of "global_qtest in
this function ... then we have to only touch one line later instead of
changing all lines with "global_qtest" again.

Any way:
Reviewed-by: Thomas Huth <thuth@redhat.com>
