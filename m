Received: from eggs.gnu.org ([2001:4830:134:3::10]:48369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cRegb-00006k-Er
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 07:40:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cRegW-0003Pr-Cv
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 07:40:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58490)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cRegW-0003Pd-6y
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 07:40:52 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4B76BC05683F
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 12:40:52 +0000 (UTC)
Date: Thu, 12 Jan 2017 10:40:49 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170112124049.GJ3565@thinpad.lan.raisama.net>
References: <20170111173528.30510-1-lersek@redhat.com>
	<20170111173528.30510-4-lersek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170111173528.30510-4-lersek@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 wave 2 3/3] hw/isa/lpc_ich9: negotiate
 SMI broadcast on pc-q35-2.9+ machine types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu devel list <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Wed, Jan 11, 2017 at 06:35:28PM +0100, Laszlo Ersek wrote:
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> ---
> 
> Notes:
>     v5:
>     - replace the v4 patch "hw/i386/pc_q35: advertise broadcast SMI if VCPU
>       hotplug is turned off" with a simple device property and compat
>       setting [Igor]
> 
>  include/hw/i386/pc.h | 5 +++++
>  hw/isa/lpc_ich9.c    | 2 ++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 230e9e70c504..fb8ca7c907f6 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -376,6 +376,11 @@ bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
>  
>  #define PC_COMPAT_2_8 \
>      HW_COMPAT_2_8 \
> +    {\
> +        .driver   = "ICH9-LPC",\
> +        .property = "smi_broadcast",\
> +        .value    = "off",\
> +    },\
>  
>  
>  #define PC_COMPAT_2_7 \
> diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
> index ced6f803a4f2..27fae5144744 100644
> --- a/hw/isa/lpc_ich9.c
> +++ b/hw/isa/lpc_ich9.c
> @@ -776,6 +776,8 @@ static const VMStateDescription vmstate_ich9_lpc = {
>  
>  static Property ich9_lpc_properties[] = {
>      DEFINE_PROP_BOOL("noreboot", ICH9LPCState, pin_strap.spkr_hi, true),
> +    DEFINE_PROP_BIT64("smi_broadcast", ICH9LPCState, smi_host_features,
> +                      ICH9_LPC_SMI_F_BROADCAST_BIT, true),

Please use hyphens instead of underscores on QOM property names.

Also, if this is not supposed to be configured directly by the
user, please use a "x-" prefix.

With that fixed:

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo
