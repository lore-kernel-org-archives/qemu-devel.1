Received: from eggs.gnu.org ([2001:4830:134:3::10]:59986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dkZLM-0003Im-Q7
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 13:21:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dkZLL-0000BP-RJ
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 13:21:28 -0400
Date: Wed, 23 Aug 2017 14:21:18 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170823172118.GQ19998@localhost.localdomain>
References: <1503416789-32080-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1503416789-32080-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] hw/arm/allwinner-a10: Mark the
 allwinner-a10 device with user_creatable = false
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org, Beniamino Galvani <b.galvani@gmail.com>

On Tue, Aug 22, 2017 at 05:46:29PM +0200, Thomas Huth wrote:
> QEMU currently exits unexpectedly when the user accidentially
> tries to do something like this:
> 
> $ aarch64-softmmu/qemu-system-aarch64 -S -M integratorcp -nographic
> QEMU 2.9.93 monitor - type 'help' for more information
> (qemu) device_add allwinner-a10
> Unsupported NIC model: smc91c111
> 
> Exiting just due to a "device_add" should not happen. Looking closer
> at the the realize and instance_init function of this device also
> reveals that it is using serial_hds and nd_table directly there, so
> this device is clearly not creatable by the user and should be marked
> accordingly.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/arm/allwinner-a10.c    | 2 ++
>  scripts/device-crash-test | 1 -
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/arm/allwinner-a10.c b/hw/arm/allwinner-a10.c
> index f62a9a3..43a3f01 100644
> --- a/hw/arm/allwinner-a10.c
> +++ b/hw/arm/allwinner-a10.c
> @@ -118,6 +118,8 @@ static void aw_a10_class_init(ObjectClass *oc, void *data)
>      DeviceClass *dc = DEVICE_CLASS(oc);
>  
>      dc->realize = aw_a10_realize;
> +    /* Reason: Uses serial_hds in realize and nd_table in instance_init */
> +    dc->user_creatable = false;

I assume this patch will be replaced by one changing TYPE_DEVICE
to default to user_creatable=false, based on the replies to the
hw/misc/auxbus.c patch?


>  }
>  
>  static const TypeInfo aw_a10_type_info = {
> diff --git a/scripts/device-crash-test b/scripts/device-crash-test
> index 8eb2d02..74aee68 100755
> --- a/scripts/device-crash-test
> +++ b/scripts/device-crash-test
> @@ -187,7 +187,6 @@ ERROR_WHITELIST = [
>      {'log':r"Device [\w.,-]+ can not be dynamically instantiated"},
>      {'log':r"Platform Bus: Can not fit MMIO region of size "},
>      # other more specific errors we will ignore:
> -    {'device':'allwinner-a10', 'log':"Unsupported NIC model:"},
>      {'device':'.*-spapr-cpu-core', 'log':r"CPU core type should be"},
>      {'log':r"MSI(-X)? is not supported by interrupt controller"},
>      {'log':r"pxb-pcie? devices cannot reside on a PCIe? bus"},
> -- 
> 1.8.3.1
> 

-- 
Eduardo
