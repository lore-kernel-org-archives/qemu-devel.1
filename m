Received: from eggs.gnu.org ([2001:4830:134:3::10]:44129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gUzGL-0007ls-1F
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 14:24:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gUz4x-00044d-B8
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 14:12:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58272)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gUz4u-0003rq-Hc
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 14:12:54 -0500
Date: Thu, 6 Dec 2018 17:12:40 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181206191240.GA31798@habkost.net>
References: <154393964026.28192.13536237934563059985.stgit@gimli.home>
	<154394083644.28192.8501647946108201466.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154394083644.28192.8501647946108201466.stgit@gimli.home>
Subject: Re: [Qemu-devel] [for-4.0 PATCH v3 8/9] q35/440fx/arm/spapr: Add
 QEMU 4.0 machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>

On Tue, Dec 04, 2018 at 09:27:16AM -0700, Alex Williamson wrote:
> Including all machine types that might have a pcie-root-port.
> 
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Acked-by: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
[...]
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 7afd1a175bf2..80d8498867a6 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3956,19 +3956,38 @@ static const TypeInfo spapr_machine_info = {
>      }                                                                \
>      type_init(spapr_machine_register_##suffix)
>  
> - /*
> +/*
> + * pseries-4.0
> + */
> +static void spapr_machine_4_0_instance_options(MachineState *machine)
> +{
> +}
> +
> +static void spapr_machine_4_0_class_options(MachineClass *mc)
> +{
> +    /* Defaults for the latest behaviour inherited from the base class */
> +}
> +
> +DEFINE_SPAPR_MACHINE(4_0, "4.0", true);
> +
> +/*
>   * pseries-3.1
>   */
> +#define SPAPR_COMPAT_3_1                                              \
> +    HW_COMPAT_3_1
> +
>  static void spapr_machine_3_1_instance_options(MachineState *machine)
>  {
> +    spapr_machine_4_0_instance_options(machine);
>  }
>  
>  static void spapr_machine_3_1_class_options(MachineClass *mc)
>  {
> -    /* Defaults for the latest behaviour inherited from the base class */
> +    spapr_machine_3_1_class_options(mc);

Infinite recursion.  This is supposed to be calling
spapr_machine_4_0_class_options().  I will fix manually on
machine-next.


> +    SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_3_1);
>  }
[...]

-- 
Eduardo
