Received: from eggs.gnu.org ([2001:4830:134:3::10]:49853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eM8az-0002Ev-EB
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 03:28:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eM8aw-0003TK-B7
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 03:28:53 -0500
References: <20171201143136.62497-1-pasic@linux.vnet.ibm.com>
	<20171201143136.62497-3-pasic@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <012d3c95-a552-9bfb-38c4-f1bab1bea854@redhat.com>
Date: Tue, 5 Dec 2017 09:28:45 +0100
MIME-Version: 1.0
In-Reply-To: <20171201143136.62497-3-pasic@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH 2/3] s390x/css: advertise
 unrestricted cssids
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>, Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Shalini Chellathurai Saroja <shalini@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>

On 01.12.2017 15:31, Halil Pasic wrote:
> Let us advertise the changes introduced by "s390x/css: unrestrict cssid=
s"
> to the management software (so it can tell are cssids unrestricted or
> restricted).
>=20
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> ---
>=20
> Boris says having the property on the virtual-css-bridge is good form
> Libvirt PoV. @Shalini: could you verify that things work out fine
> (provided we get at least a preliminary blessing from Connie).
>=20
> Consider squashing into "s390x/css: unrestrict cssids".
> ---
>  hw/s390x/css-bridge.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/hw/s390x/css-bridge.c b/hw/s390x/css-bridge.c
> index c4a9735d71..c7e8998680 100644
> --- a/hw/s390x/css-bridge.c
> +++ b/hw/s390x/css-bridge.c
> @@ -123,6 +123,11 @@ static Property virtual_css_bridge_properties[] =3D=
 {
>      DEFINE_PROP_END_OF_LIST(),
>  };
> =20
> +static bool prop_get_true(Object *obj, Error **errp)
> +{
> +    return true;
> +}
> +
>  static void virtual_css_bridge_class_init(ObjectClass *klass, void *da=
ta)
>  {
>      HotplugHandlerClass *hc =3D HOTPLUG_HANDLER_CLASS(klass);
> @@ -131,6 +136,12 @@ static void virtual_css_bridge_class_init(ObjectCl=
ass *klass, void *data)
>      hc->unplug =3D ccw_device_unplug;
>      set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
>      dc->props =3D virtual_css_bridge_properties;
> +    object_class_property_add_bool(klass, "cssid-unrestricted",
> +                                   prop_get_true, NULL, NULL);
> +    object_class_property_set_description(klass, "cssid-unrestricted",
> +            "A css device can use any  cssid, regardless whether virtu=
al"
> +            " or not (read only, always true)",

I'd maybe remove the "always true" in the description here, since that
might create wrong assumptions with regards to future versions or lead
to bad code in the upper layers. If someone reads "always true", they
simply might omit the check of the value of this property. If we then
ever want to change it to "false" again, we're in trouble (sure, we
could simply completely remove the property again, but we have to
remember to do that instead of setting it to false ... so let's better
play safe right now already, ok?)

 Thomas
