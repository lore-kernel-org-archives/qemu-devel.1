Received: from eggs.gnu.org ([2001:4830:134:3::10]:34405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eyy4F-0003hD-5s
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 07:07:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eyy49-0001TE-5y
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 07:07:35 -0400
Date: Thu, 22 Mar 2018 11:07:12 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180322110712.GN3583@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180322031216.14569-1-wei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180322031216.14569-1-wei@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] mach-virt: Set VM's SMBIOS system
 version to mc->desc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Huang <wei@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, drjones@redhat.com, qemu-arm@nongnu.org

On Wed, Mar 21, 2018 at 10:12:16PM -0500, Wei Huang wrote:
> Instead of using "1.0" as the system version of SMBIOS, we should use
> mc->desc for mach-virt machine type. With this patch, "dmidecode -t 1"
> (e.g., "-M virt-2.12,accel=kvm") will show:
> 
>     Handle 0x0100, DMI type 1, 27 bytes
>     System Information
>             Manufacturer: QEMU
>             Product Name: KVM Virtual Machine
>             Version: QEMU 2.12 ARM Virtual Machine
>             Serial Number: Not Specified
>             ...
> 
> instead of:
>     Handle 0x0100, DMI type 1, 27 bytes
>     System Information
>             Manufacturer: QEMU
>             Product Name: KVM Virtual Machine
>             Version: 1.0
>             Serial Number: Not Specified
>             ...
> 
> Signed-off-by: Wei Huang <wei@redhat.com>
> ---
>  hw/arm/virt.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 2c07245047..da7228b297 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1132,6 +1132,7 @@ static void *machvirt_dtb(const struct arm_boot_info *binfo, int *fdt_size)
>  
>  static void virt_build_smbios(VirtMachineState *vms)
>  {
> +    MachineClass *mc = MACHINE_GET_CLASS(vms);
>      uint8_t *smbios_tables, *smbios_anchor;
>      size_t smbios_tables_len, smbios_anchor_len;
>      const char *product = "QEMU Virtual Machine";
> @@ -1145,7 +1146,7 @@ static void virt_build_smbios(VirtMachineState *vms)
>      }
>  
>      smbios_set_defaults("QEMU", product,
> -                        "1.0", false, true, SMBIOS_ENTRY_POINT_30);
> +                        mc->desc, false, true, SMBIOS_ENTRY_POINT_30);

Surely this needs to be handled in back compatible manner so that existing
machine types are not changed - only the new virt-2.12 machine type should
get new format.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
