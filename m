Received: from eggs.gnu.org ([2001:4830:134:3::10]:34644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cMyAt-00031u-9H
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 09:28:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cMyAp-00023y-Vr
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 09:28:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43238)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1cMyAp-00023t-PX
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 09:28:47 -0500
Date: Fri, 30 Dec 2016 15:28:34 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20161230152834.6d1fa963@Igors-MacBook-Pro.local>
In-Reply-To: <20161229223815.13705-1-ehabkost@redhat.com>
References: <20161229223815.13705-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qdev: Make "hotplugged" property read-only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Michael S.
	Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>, Andreas =?UTF-8?Q?F=C3=A4rber?= <afaerber@suse.de>

On Thu, 29 Dec 2016 20:38:15 -0200
Eduardo Habkost <ehabkost@redhat.com> wrote:

> The "hotplugged" property is user visible, but it was never meant
> to be set by the user. There are probably multiple ways to break
> or crash device code by overriding the property. One example:
> 
>   $ qemu-system-x86_64 -cpu qemu64,hotplugged=true
>   Segmentation fault (core dumped)
> 
> The DeviceState::hotplugged struct field is set directly by
> device_initfn(), there's no need to provide a setter for the
> property.
this property is meant to be used for individual devices on target side
of migration.
Doing above is a rather big hammer with behavioral change of migrated
instance.

So I'd  fix crash caused by assumption that hotplugged CPU
guarantied to have rtc&fw_cfg available.
I'll post a patch with the fix.

> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  hw/core/qdev.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 57834423b9..f5989c41cb 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -1013,13 +1013,6 @@ static bool device_get_hotplugged(Object *obj, Error **err)
>      return dev->hotplugged;
>  }
>  
> -static void device_set_hotplugged(Object *obj, bool value, Error **err)
> -{
> -    DeviceState *dev = DEVICE(obj);
> -
> -    dev->hotplugged = value;
> -}
> -
>  static void device_initfn(Object *obj)
>  {
>      DeviceState *dev = DEVICE(obj);
> @@ -1039,7 +1032,7 @@ static void device_initfn(Object *obj)
>      object_property_add_bool(obj, "hotpluggable",
>                               device_get_hotpluggable, NULL, NULL);
>      object_property_add_bool(obj, "hotplugged",
> -                             device_get_hotplugged, device_set_hotplugged,
> +                             device_get_hotplugged, NULL,
>                               &error_abort);
>  
>      class = object_get_class(OBJECT(dev));
