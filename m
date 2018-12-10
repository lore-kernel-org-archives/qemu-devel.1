Received: from eggs.gnu.org ([2001:4830:134:3::10]:54881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gWTbz-00055m-JD
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 17:01:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gWTbs-0000Bh-Ao
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 17:01:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34608)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gWTbr-00008N-Pr
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 17:01:04 -0500
References: <154419994154.27028.14774494243513273923.stgit@gimli.home>
	<154420088248.27028.3919592169648338038.stgit@gimli.home>
From: Eric Blake <eblake@redhat.com>
Message-ID: <16f2e753-4e80-0acc-d35a-75c6eb5a8f54@redhat.com>
Date: Mon, 10 Dec 2018 16:00:57 -0600
MIME-Version: 1.0
In-Reply-To: <154420088248.27028.3919592169648338038.stgit@gimli.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [for-4.0 PATCH v4 4/9] qapi: Define PCIe link
 speed and width properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org
Cc: Geoffrey McRae <geoff@hostfission.com>, Markus Armbruster <armbru@redhat.com>

On 12/7/18 10:41 AM, Alex Williamson wrote:
> Create properties to be able to define speeds and widths for PCIe
> links.  The only tricky bit here is that our get and set callbacks
> translate from the fixed QAPI automagic enums to those we define
> in PCI code to represent the actual register segment value.
> 
> Cc: Eric Blake <eblake@redhat.com>
> Tested-by: Geoffrey McRae <geoff@hostfission.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
>   hw/core/qdev-properties.c    |  178 ++++++++++++++++++++++++++++++++++++++++++
>   include/hw/qdev-properties.h |    8 ++
>   qapi/common.json             |   42 ++++++++++
>   3 files changed, 228 insertions(+)
> 
> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> index 35072dec1ecf..f5ca5b821a79 100644
> --- a/hw/core/qdev-properties.c
> +++ b/hw/core/qdev-properties.c
> @@ -1327,3 +1327,181 @@ const PropertyInfo qdev_prop_off_auto_pcibar = {
>       .set = set_enum,
>       .set_default_value = set_default_value_enum,
>   };
> +
> +/* --- PCIELinkSpeed 2_5/5/8/16 -- */
> +
> +static void get_prop_pcielinkspeed(Object *obj, Visitor *v, const char *name,
> +                                   void *opaque, Error **errp)
> +{
> +    DeviceState *dev = DEVICE(obj);
> +    Property *prop = opaque;
> +    PCIExpLinkSpeed *p = qdev_get_prop_ptr(dev, prop);
> +    PCIELinkSpeed speed;

C does not guarantee what width 'speed' has,...

> +
> +    switch (*p) {
> +    case QEMU_PCI_EXP_LNK_2_5GT:
> +        speed = PCIE_LINK_SPEED_2_5;
> +        break;
> +    case QEMU_PCI_EXP_LNK_5GT:
> +        speed = PCIE_LINK_SPEED_5;
> +        break;
> +    case QEMU_PCI_EXP_LNK_8GT:
> +        speed = PCIE_LINK_SPEED_8;
> +        break;
> +    case QEMU_PCI_EXP_LNK_16GT:
> +        speed = PCIE_LINK_SPEED_16;
> +        break;
> +    default:
> +        /* Unreachable */
> +        abort();
> +    }
> +
> +    visit_type_enum(v, prop->name, (int *)&speed, prop->info->enum_table, errp);

...making this cast to (int*) not be very kosher. I _think_ we're okay 
here, but I'd be a LOT happier if you just used 'int speed' to avoid the 
cast.

> +}
> +
> +static void set_prop_pcielinkspeed(Object *obj, Visitor *v, const char *name,
> +                                   void *opaque, Error **errp)
> +{
> +    DeviceState *dev = DEVICE(obj);
> +    Property *prop = opaque;
> +    PCIExpLinkSpeed *p = qdev_get_prop_ptr(dev, prop);
> +    PCIELinkSpeed speed;
> +    Error *local_err = NULL;
> +
> +    if (dev->realized) {
> +        qdev_prop_set_after_realize(dev, name, errp);
> +        return;
> +    }
> +
> +    visit_type_enum(v, prop->name, (int *)&speed,

And again.

> +                    prop->info->enum_table, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +
> +    switch (speed) {
> +    case PCIE_LINK_SPEED_2_5:
> +        *p = QEMU_PCI_EXP_LNK_2_5GT;
> +        break;
> +    case PCIE_LINK_SPEED_5:
> +        *p = QEMU_PCI_EXP_LNK_5GT;
> +        break;
> +    case PCIE_LINK_SPEED_8:
> +        *p = QEMU_PCI_EXP_LNK_8GT;
> +        break;
> +    case PCIE_LINK_SPEED_16:
> +        *p = QEMU_PCI_EXP_LNK_16GT;
> +        break;
> +    default:
> +        /* Unreachable */
> +        abort();
> +    }
> +}
> +

> +static void get_prop_pcielinkwidth(Object *obj, Visitor *v, const char *name,
> +                                   void *opaque, Error **errp)
> +{
> +    DeviceState *dev = DEVICE(obj);
> +    Property *prop = opaque;
> +    PCIExpLinkWidth *p = qdev_get_prop_ptr(dev, prop);
> +    PCIELinkWidth width;
> +
> +    switch (*p) {

> +    visit_type_enum(v, prop->name, (int *)&width, prop->info->enum_table, errp);
> +}
> +
> +static void set_prop_pcielinkwidth(Object *obj, Visitor *v, const char *name,
> +                                   void *opaque, Error **errp)
> +{
> +    DeviceState *dev = DEVICE(obj);
> +    Property *prop = opaque;
> +    PCIExpLinkWidth *p = qdev_get_prop_ptr(dev, prop);
> +    PCIELinkWidth width;
> +    Error *local_err = NULL;
> +
> +    if (dev->realized) {
> +        qdev_prop_set_after_realize(dev, name, errp);
> +        return;
> +    }
> +
> +    visit_type_enum(v, prop->name, (int *)&width,

And two more spots.

> +++ b/qapi/common.json
> @@ -127,6 +127,48 @@
>   { 'enum': 'OffAutoPCIBAR',
>     'data': [ 'off', 'auto', 'bar0', 'bar1', 'bar2', 'bar3', 'bar4', 'bar5' ] }
>   
> +##
> +# @PCIELinkSpeed:
> +#
> +# An enumeration of PCIe link speeds in units of GT/s
> +#
> +# @2_5: 2.5GT/s
> +#
> +# @5: 5.0GT/s
> +#
> +# @8: 8.0GT/s
> +#
> +# @16: 16.0GT/s
> +#
> +# Since: 4.0
> +##
> +{ 'enum': 'PCIELinkSpeed',
> +  'data': [ '2_5', '5', '8', '16' ] }

QAPI enums are special-cased to allow starting with digits, thanks to 
QKeyCode.  I don't know if we are trying to avoid adding yet more of 
those, but the fact that you didn't have to whitelist them means that we 
are at least not forcibly limiting the use of leading digits in new enums.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
