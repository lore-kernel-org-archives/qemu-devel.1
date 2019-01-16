Received: from eggs.gnu.org ([209.51.188.92]:39915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gjoPn-0004p3-4q
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 11:51:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gjoPl-0005pT-Km
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 11:51:42 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39314)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gjoPl-0005mV-Cp
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 11:51:41 -0500
Received: by mail-wm1-f65.google.com with SMTP id y8so2721031wmi.4
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 08:51:37 -0800 (PST)
References: <1547566866-129386-1-git-send-email-imammedo@redhat.com>
	<1547566866-129386-5-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <844dd42f-e9ed-309a-2bd3-db2668903a42@redhat.com>
Date: Wed, 16 Jan 2019 17:51:34 +0100
MIME-Version: 1.0
In-Reply-To: <1547566866-129386-5-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
Cc: Gonglei <arei.gonglei@huawei.com>, Laszlo Ersek <lersek@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Samuel Ortiz <sameo@linux.intel.com>, Andrew Jones <drjones@redhat.com>

On 1/15/19 4:40 PM, Igor Mammedov wrote:
> In case of UEFI RSDP doesn't have to be located in lowmem,
> it could be placed at any address. Make sure that test won't
> break if it is placed above the first 4Gb of address space.
> 
> PS:
> While at it cleanup some local variables as we don't really
> need them.

Splitting as obvious patches make review quicker, but it's a matter of
taste.

> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

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
