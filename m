Received: from eggs.gnu.org ([2001:4830:134:3::10]:37874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dQilP-0000oq-Q4
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 19:22:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dQilO-0003eu-EQ
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 19:22:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54438)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dQilO-0003eV-8o
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 19:22:18 -0400
Date: Fri, 30 Jun 2017 02:22:14 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170630022154-mutt-send-email-mst@kernel.org>
References: <1498773362-18675-1-git-send-email-zuban32s@gmail.com>
	<1498773362-18675-4-git-send-email-zuban32s@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1498773362-18675-4-git-send-email-zuban32s@gmail.com>
Subject: Re: [Qemu-devel] [PATCH RFC 3/6] hw/acpi: fix pcihp io
 initialization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandr Bezzubikov <zuban32s@gmail.com>
Cc: qemu-devel@nongnu.org, marcel@redhat.com, imammedo@redhat.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com

On Fri, Jun 30, 2017 at 12:55:59AM +0300, Aleksandr Bezzubikov wrote:
> Signed-off-by: Aleksandr Bezzubikov <zuban32s@gmail.com>

Any data on what is wrong with the current code?
Pls include this in commit log.

> ---
>  hw/i386/acpi-build.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index b0dcd34..c99dbcc 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -129,17 +129,18 @@ static void acpi_get_pm_info(AcpiPmInfo *pm)
>      Object *lpc = ich9_lpc_find();
>      Object *obj = NULL;
>      QObject *o;
> +    int pcihp_io_len, pcihp_io_base;
>  
>      pm->cpu_hp_io_base = 0;
> -    pm->pcihp_io_base = 0;
> -    pm->pcihp_io_len = 0;
>      if (piix) {
>          obj = piix;
>          pm->cpu_hp_io_base = PIIX4_CPU_HOTPLUG_IO_BASE;
> -        pm->pcihp_io_base =
> +        pcihp_io_base =
>              object_property_get_int(obj, ACPI_PCIHP_IO_BASE_PROP, NULL);
> -        pm->pcihp_io_len =
> +        pcihp_io_len =
>              object_property_get_int(obj, ACPI_PCIHP_IO_LEN_PROP, NULL);
> +        pm->pcihp_io_base = (pcihp_io_base == -1) ? 0 : pcihp_io_base;
> +        pm->pcihp_io_len = (pcihp_io_len == -1) ? 0 : pcihp_io_len;
>      }
>      if (lpc) {
>          obj = lpc;
> -- 
> 2.7.4
