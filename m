Received: from eggs.gnu.org ([2001:4830:134:3::10]:49526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fWJZK-0000UP-Ae
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 06:45:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fWJZJ-00082S-C5
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 06:45:30 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:42845)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fWJZJ-000824-5h
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 06:45:29 -0400
Received: by mail-ot0-x242.google.com with SMTP id 92-v6so6994919otw.9
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 03:45:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1529663827-28854-1-git-send-email-hongbo.zhang@linaro.org>
References: <1529663827-28854-1-git-send-email-hongbo.zhang@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Jun 2018 11:45:07 +0100
Message-ID: <CAFEAcA8Bx7b_0zUxbdxFgtANFycVkUiSiemAwHpr0wpyxuLKmw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/arm/virt: fix psci conduit in acpi when
 el3 enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Hongbo Zhang <hongbo.zhang@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 22 June 2018 at 11:37, Hongbo Zhang <hongbo.zhang@linaro.org> wrote:
> When QEMU_PSCI_CONDUIT_DISABLED is set, it doesn't mean all the PSCI
> conduits are totally disabled, it only mean the QEMU built-in PSCI
> support is disabled, in such a case, e.g. EL3 is enabled and external
> firmware (it is usually Arm Trusted Firmware) is loaded, SMC should be
> used for the guest to trigger PSCI functions.
>
> Signed-off-by: Hongbo Zhang <hongbo.zhang@linaro.org>
> ---
>  hw/arm/virt-acpi-build.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 74f5744..e5b4947 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -715,7 +715,11 @@ static void build_fadt_rev5(GArray *table_data, BIOSLinker *linker,
>
>      switch (vms->psci_conduit) {
>      case QEMU_PSCI_CONDUIT_DISABLED:
> -        fadt.arm_boot_arch = 0;
> +        /* This case means QEMU's internal EL3 implementation is disabled,
> +         * but when firmware is loaded, the guest can still use SMC as PSCI
> +         * conduit to call external firmware PSCI services
> +         */
> +        fadt.arm_boot_arch = ACPI_FADT_ARM_PSCI_COMPLIANT;
>          break;
>      case QEMU_PSCI_CONDUIT_HVC:
>          fadt.arm_boot_arch = ACPI_FADT_ARM_PSCI_COMPLIANT |

I think this means we end up reporting different things for ACPI
and DT in this case, doesn't it?

I think that if QEMU isn't providing the PSCI implementation it
shouldn't advertise it in the ACPI tables. It would seem more
logical that the firmware itself does that (QEMU can't know if
it really does provide PSCI, after all...)

thanks
-- PMM
