Received: from eggs.gnu.org ([2001:4830:134:3::10]:42365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1d3fSi-0004mR-Vu
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 05:11:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1d3fSf-0003WU-QV
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 05:11:44 -0400
Date: Thu, 27 Apr 2017 11:11:35 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170427111135.7a7bbfa9@nial.brq.redhat.com>
In-Reply-To: <1493233622-14485-1-git-send-email-brogers@suse.com>
References: <1493233622-14485-1-git-send-email-brogers@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] ACPI: call acpi_set_pci_info when only
 acpi enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bruce Rogers <brogers@suse.com>
Cc: qemu-devel@nongnu.org, sstabellini@kernel.org, mst@redhat.com, qemu-stable@nongnu.org

On Wed, 26 Apr 2017 13:07:02 -0600
Bruce Rogers <brogers@suse.com> wrote:

> Commit f0c9d64a exposed an issue with the code order in acpi_setup.
> As of that commit, a xenfv machine type guest will no longer start
> if using pci passthrough. Re-order the code in that function to
> allow acpi_set_pci_info to be called before bailing on the other,
> non-related conditions. With this change I can again use pci
> passthrough and xenfv together.
> 
> Signed-off-by: Bruce Rogers <brogers@suse.com>
it doesn't look right,
acpi_set_pci_info() is supposed to affect only ACPI based hotplug

could you elaborate more on what's going on and
what error you see at startup?

> ---
>  hw/i386/acpi-build.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 2073108..1ec072f 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -2834,6 +2834,13 @@ void acpi_setup(void)
>      AcpiBuildState *build_state;
>      Object *vmgenid_dev;
>  
> +    if (!acpi_enabled) {
> +        ACPI_BUILD_DPRINTF("ACPI disabled. Bailing out.\n");
> +        return;
> +    }
> +
> +    acpi_set_pci_info();
> +
>      if (!pcms->fw_cfg) {
>          ACPI_BUILD_DPRINTF("No fw cfg. Bailing out.\n");
>          return;
> @@ -2844,15 +2851,8 @@ void acpi_setup(void)
>          return;
>      }
>  
> -    if (!acpi_enabled) {
> -        ACPI_BUILD_DPRINTF("ACPI disabled. Bailing out.\n");
> -        return;
> -    }
> -
>      build_state = g_malloc0(sizeof *build_state);
>  
> -    acpi_set_pci_info();
> -
>      acpi_build_tables_init(&tables);
>      acpi_build(&tables, MACHINE(pcms));
>  
