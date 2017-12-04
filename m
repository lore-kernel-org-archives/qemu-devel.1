Received: from eggs.gnu.org ([2001:4830:134:3::10]:34746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eLoiZ-0006Wx-Dk
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 06:15:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eLoiV-0006Wr-3V
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 06:15:23 -0500
Date: Mon, 4 Dec 2017 12:15:11 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171204121511.0abe9ca2.cohuck@redhat.com>
In-Reply-To: <20171201143136.62497-3-pasic@linux.vnet.ibm.com>
References: <20171201143136.62497-1-pasic@linux.vnet.ibm.com>
	<20171201143136.62497-3-pasic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/3] s390x/css: advertise unrestricted
 cssids
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Shalini Chellathurai Saroja <shalini@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org

On Fri,  1 Dec 2017 15:31:35 +0100
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> Let us advertise the changes introduced by "s390x/css: unrestrict cssids"
> to the management software (so it can tell are cssids unrestricted or
> restricted).
> 
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> ---
> 
> Boris says having the property on the virtual-css-bridge is good form
> Libvirt PoV. @Shalini: could you verify that things work out fine
> (provided we get at least a preliminary blessing from Connie).
> 
> Consider squashing into "s390x/css: unrestrict cssids".
> ---
>  hw/s390x/css-bridge.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/hw/s390x/css-bridge.c b/hw/s390x/css-bridge.c
> index c4a9735d71..c7e8998680 100644
> --- a/hw/s390x/css-bridge.c
> +++ b/hw/s390x/css-bridge.c
> @@ -123,6 +123,11 @@ static Property virtual_css_bridge_properties[] = {
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> +static bool prop_get_true(Object *obj, Error **errp)
> +{
> +    return true;
> +}
> +
>  static void virtual_css_bridge_class_init(ObjectClass *klass, void *data)
>  {
>      HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(klass);
> @@ -131,6 +136,12 @@ static void virtual_css_bridge_class_init(ObjectClass *klass, void *data)
>      hc->unplug = ccw_device_unplug;
>      set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
>      dc->props = virtual_css_bridge_properties;
> +    object_class_property_add_bool(klass, "cssid-unrestricted",
> +                                   prop_get_true, NULL, NULL);
> +    object_class_property_set_description(klass, "cssid-unrestricted",
> +            "A css device can use any  cssid, regardless whether virtual"

extra space -----------------------------^

> +            " or not (read only, always true)",
> +            NULL);
>  }
>  
>  static const TypeInfo virtual_css_bridge_info = {

Looks reasonable. If this works as expected, I'll squash it into the
previous patch.
