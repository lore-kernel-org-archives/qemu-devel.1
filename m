Received: from eggs.gnu.org ([2001:4830:134:3::10]:44022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cqj14-0003C7-KY
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 12:21:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cqj10-0002aV-Ac
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 12:21:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58388)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cqj10-0002aL-4k
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 12:21:38 -0400
References: <1490198476-12244-1-git-send-email-mst@redhat.com>
	<1490198476-12244-5-git-send-email-mst@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <a5f0cf7d-b0e0-10c8-3518-4c25360b724f@redhat.com>
Date: Wed, 22 Mar 2017 17:21:32 +0100
MIME-Version: 1.0
In-Reply-To: <1490198476-12244-5-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 4/4] hw/acpi/vmgenid: prevent more than one
 vmgenid device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Ben Warren <ben@skyportsystems.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 03/22/17 17:01, Michael S. Tsirkin wrote:
> From: Laszlo Ersek <lersek@redhat.com>
> 
> A system with multiple VMGENID devices is undefined in the VMGENID spec by
> omission.
> 
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Ben Warren <ben@skyportsystems.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Can you please add the feedback tags from Igor and Ben?

http://mid.mail-archive.com/23205322-903E-42E2-99D7-ED8351E62694@skyportsystems.com
http://mid.mail-archive.com/20170321131414.08cc6bfa@nial.brq.redhat.com

> Binary file /tmp/tmp.IaAwzHwwsQ matches

I'm not sure what this means.

Thanks,
Laszlo

> ---
>  include/hw/acpi/vmgenid.h | 1 +
>  hw/acpi/vmgenid.c         | 8 ++++++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/include/hw/acpi/vmgenid.h b/include/hw/acpi/vmgenid.h
> index 8578476..7beb959 100644
> --- a/include/hw/acpi/vmgenid.h
> +++ b/include/hw/acpi/vmgenid.h
> @@ -24,6 +24,7 @@ typedef struct VmGenIdState {
>      bool write_pointer_available;
>  } VmGenIdState;
>  
> +/* returns NULL unless there is exactly one device */
>  static inline Object *find_vmgenid_dev(void)
>  {
>      return object_resolve_path_type("", VMGENID_DEVICE, NULL);
> diff --git a/hw/acpi/vmgenid.c b/hw/acpi/vmgenid.c
> index c3ddcc8..a32b847 100644
> --- a/hw/acpi/vmgenid.c
> +++ b/hw/acpi/vmgenid.c
> @@ -221,6 +221,14 @@ static void vmgenid_realize(DeviceState *dev, Error **errp)
>          return;
>      }
>  
> +    /* Given that this function is executing, there is at least one VMGENID
> +     * device. Check if there are several.
> +     */
> +    if (!find_vmgenid_dev()) {
> +        error_setg(errp, "at most one %s device is permitted", VMGENID_DEVICE);
> +        return;
> +    }
> +
>      qemu_register_reset(vmgenid_handle_reset, vms);
>  }
>  
> 
