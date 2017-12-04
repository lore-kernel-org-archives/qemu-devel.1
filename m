Received: from eggs.gnu.org ([2001:4830:134:3::10]:34572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eLoi0-0006E8-5n
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 06:14:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eLohx-0006NQ-09
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 06:14:48 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38238)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1eLohw-0006NH-NN
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 06:14:44 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB4BE2In112013
	for <qemu-devel@nongnu.org>; Mon, 4 Dec 2017 06:14:42 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2en1dv3mc4-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 04 Dec 2017 06:14:41 -0500
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 4 Dec 2017 11:14:38 -0000
References: <20171201143136.62497-1-pasic@linux.vnet.ibm.com>
	<20171201143136.62497-3-pasic@linux.vnet.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 4 Dec 2017 12:14:34 +0100
MIME-Version: 1.0
In-Reply-To: <20171201143136.62497-3-pasic@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <9efb693a-7a03-7355-4acd-17e5e23fdceb@de.ibm.com>
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
To: Halil Pasic <pasic@linux.vnet.ibm.com>, Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Shalini Chellathurai Saroja <shalini@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org



On 12/01/2017 03:31 PM, Halil Pasic wrote:
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



FWIW, a property on the  virtual-css-bridge is
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>

So if Conny is also ok with this we might have found our solution.

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
> +            " or not (read only, always true)",
> +            NULL);
>  }
> 
>  static const TypeInfo virtual_css_bridge_info = {
> 
