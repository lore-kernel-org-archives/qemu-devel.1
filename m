Received: from eggs.gnu.org ([209.51.188.92]:40170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gjV1R-0002Rt-17
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:09:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gjV1P-0006Cz-8y
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:09:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59366)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1gjV1O-0006BZ-UI
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:09:15 -0500
References: <1547566866-129386-1-git-send-email-imammedo@redhat.com>
	<1547566866-129386-5-git-send-email-imammedo@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <458a77e3-6802-6e33-1117-746d18851557@redhat.com>
Date: Tue, 15 Jan 2019 21:09:03 +0100
MIME-Version: 1.0
In-Reply-To: <1547566866-129386-5-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 04/14] tests: acpi: make pointer to RSDP
 64bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: Gonglei <arei.gonglei@huawei.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Samuel Ortiz <sameo@linux.intel.com>, Andrew Jones <drjones@redhat.com>

On 01/15/19 16:40, Igor Mammedov wrote:
> In case of UEFI RSDP doesn't have to be located in lowmem,

I suggest inserting a comma (,) after "UEFI". Currently the message
reads like

  in case of UEFI RSDP, doesn't have to... ENOPARSE

:) It should be

  in case of UEFI, RSDP doesn't have to...

Thanks
Laszlo

> it could be placed at any address. Make sure that test won't
> break if it is placed above the first 4Gb of address space.
> 
> PS:
> While at it cleanup some local variables as we don't really
> need them.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  tests/bios-tables-test.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
> index 99d7bf8..c28c5c7 100644
> --- a/tests/bios-tables-test.c
> +++ b/tests/bios-tables-test.c
> @@ -26,7 +26,7 @@
>  typedef struct {
>      const char *machine;
>      const char *variant;
> -    uint32_t rsdp_addr;
> +    uint64_t rsdp_addr;
>      uint8_t rsdp_table[36 /* ACPI 2.0+ RSDP size */];
>      GArray *tables;
>      uint32_t smbios_ep_addr;
> @@ -86,13 +86,11 @@ static void test_acpi_rsdp_address(test_data *data)
>  
>  static void test_acpi_rsdp_table(test_data *data)
>  {
> -    uint8_t *rsdp_table = data->rsdp_table, revision;
> -    uint32_t addr = data->rsdp_addr;
> +    uint8_t *rsdp_table = data->rsdp_table;
>  
> -    acpi_fetch_rsdp_table(data->qts, addr, rsdp_table);
> -    revision = rsdp_table[15 /* Revision offset */];
> +    acpi_fetch_rsdp_table(data->qts, data->rsdp_addr, rsdp_table);
>  
> -    switch (revision) {
> +    switch (rsdp_table[15 /* Revision offset */]) {
>      case 0: /* ACPI 1.0 RSDP */
>          /* With rev 1, checksum is only for the first 20 bytes */
>          g_assert(!acpi_calc_checksum(rsdp_table,  20));
> 
