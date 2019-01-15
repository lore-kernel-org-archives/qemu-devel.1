Received: from eggs.gnu.org ([209.51.188.92]:42072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gjVNf-0005IM-DC
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:32:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gjVNV-0000tp-QP
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:32:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37200)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1gjVNR-0000oB-TF
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:32:03 -0500
References: <1547566866-129386-1-git-send-email-imammedo@redhat.com>
	<1547566866-129386-11-git-send-email-imammedo@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <15698cec-79eb-7a17-cf70-3a8fcb7962a6@redhat.com>
Date: Tue, 15 Jan 2019 21:31:54 +0100
MIME-Version: 1.0
In-Reply-To: <1547566866-129386-11-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 10/14] tests: acpi: ignore SMBIOS tests
 when UEFI firmware is used
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

On 01/15/19 16:41, Igor Mammedov wrote:
> once FW provides a pointer to SMBIOS entry point like it does for
> RSDP it should be possible to enable this one the same way.

Good point, I didn't think of SMBIOS.

We have the following options:

(1) Use just one "test support" structure, and add more fields (such as
the SMBIOS entry point) to it, beyond the RSDP1.0/RSDP2.0. For this, we
should also introduce a "size" field to the table, so we don't have to
extend the table between firmware and QEMU in lock-step.

(2) Use a different table (with a different GUID) for exposing the
SMBIOS entry point.

On the firmware side, (1) would be more work now, but it would keep
things simpler (and better separated) in the future. (2) would be more
lazy ^W convenient now, but it would introduce more churn / possibly
some code duplication in the future.

In QEMU, which one would you prefer?

Thanks,
Laszlo

> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  tests/bios-tables-test.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
> index d9efe59..a64d0c2 100644
> --- a/tests/bios-tables-test.c
> +++ b/tests/bios-tables-test.c
> @@ -562,8 +562,11 @@ static void test_acpi_one(const char *params, test_data *data)
>          }
>      }
>  
> -    test_smbios_entry_point(data);
> -    test_smbios_structs(data);
> +    /* TODO: make SMBIOS tests work with UEFI firmware */
> +    if (!use_uefi) {
> +        test_smbios_entry_point(data);
> +        test_smbios_structs(data);
> +    }
>  
>      assert(!global_qtest);
>      qtest_quit(data->qts);
> 
