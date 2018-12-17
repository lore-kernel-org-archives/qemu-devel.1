Received: from eggs.gnu.org ([2001:4830:134:3::10]:43499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gYsFE-0005kL-SA
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 07:43:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gYsFB-0003Bi-KC
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 07:43:36 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33369)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gYsFB-0003Au-Cn
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 07:43:33 -0500
Received: by mail-wm1-f68.google.com with SMTP id r24so4655586wmh.0
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 04:43:33 -0800 (PST)
References: <1543467132-2873-1-git-send-email-liq3ea@gmail.com>
	<1543467132-2873-3-git-send-email-liq3ea@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <644186db-32d3-7c83-8b37-02e8427ef217@redhat.com>
Date: Mon, 17 Dec 2018 13:43:30 +0100
MIME-Version: 1.0
In-Reply-To: <1543467132-2873-3-git-send-email-liq3ea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 2/2] hw: vmmouse: Use link instead of
 pointer property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>, mst@redhat.com, pbonzini@redhat.com, ehabkost@redhat.com, armbru@redhat.com, Thomas Huth <thuth@redhat.com>
Cc: marcel.apfelbaum@gmail.com, rth@twiddle.net, darren.kenny@oracle.com, qemu-devel@nongnu.org

Hi Li,

On 11/29/18 5:52 AM, Li Qiang wrote:
> According to qdev-properties.h, properties of pointer type should
> be avoided. Turn "ps2_mouse" into a link.
> 
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
> Signed-off-by: Li Qiang <liq3ea@gmail.com>
> ---
> 
> Change since v2: detailed commit message
> 
> Change since v1: use error_abort in object_property_set_link()
> 
>  hw/i386/pc.c      |  3 ++-
>  hw/i386/vmmouse.c | 17 +++++++++++------
>  2 files changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 73c7b777a0..64f0f233b8 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1552,7 +1552,8 @@ static void pc_superio_init(ISABus *isa_bus, bool create_fdctrl, bool no_vmport)
>      }
>      if (vmmouse) {
>          DeviceState *dev = DEVICE(vmmouse);
> -        qdev_prop_set_ptr(dev, "ps2_mouse", i8042);
> +        object_property_set_link(OBJECT(dev), OBJECT(i8042),
> +                                 "ps2_mouse", &error_abort);
>          qdev_init_nofail(dev);
>      }
>      port92 = isa_create_simple(isa_bus, TYPE_PORT92);
> diff --git a/hw/i386/vmmouse.c b/hw/i386/vmmouse.c
> index 4412eaf604..f63aac6673 100644
> --- a/hw/i386/vmmouse.c
> +++ b/hw/i386/vmmouse.c
> @@ -27,6 +27,7 @@
>  #include "hw/i386/pc.h"
>  #include "hw/input/i8042.h"
>  #include "hw/qdev.h"
> +#include "qapi/error.h"
>  
>  /* debug only vmmouse */
>  //#define DEBUG_VMMOUSE
> @@ -271,10 +272,15 @@ static void vmmouse_realizefn(DeviceState *dev, Error **errp)
>      vmport_register(VMMOUSE_DATA, vmmouse_ioport_read, s);
>  }
>  
> -static Property vmmouse_properties[] = {
> -    DEFINE_PROP_PTR("ps2_mouse", VMMouseState, ps2_mouse),
> -    DEFINE_PROP_END_OF_LIST(),
> -};
> +static void vmmouse_instance_initfn(Object *obj)
> +{
> +    VMMouseState *s = VMMOUSE(obj);
> +
> +    object_property_add_link(obj, "ps2_mouse", TYPE_I8042,
> +                             (Object **)&s->ps2_mouse,
> +                             qdev_prop_allow_set_link_before_realize,
> +                             0, &error_abort);
> +}
>  
>  static void vmmouse_class_initfn(ObjectClass *klass, void *data)
>  {
> @@ -283,8 +289,6 @@ static void vmmouse_class_initfn(ObjectClass *klass, void *data)
>      dc->realize = vmmouse_realizefn;
>      dc->reset = vmmouse_reset;
>      dc->vmsd = &vmstate_vmmouse;
> -    dc->props = vmmouse_properties;
> -    /* Reason: pointer property "ps2_mouse" */
>      dc->user_creatable = false;

"user_creatable = false" must have an justification comment.

Can you keep 'Reason: link property "ps2_mouse"'?

Eventually the maintainer taking this patch can fix this for you.

With the comment:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>  }
>  
> @@ -292,6 +296,7 @@ static const TypeInfo vmmouse_info = {
>      .name          = TYPE_VMMOUSE,
>      .parent        = TYPE_ISA_DEVICE,
>      .instance_size = sizeof(VMMouseState),
> +    .instance_init = vmmouse_instance_initfn,
>      .class_init    = vmmouse_class_initfn,
>  };
>  
> 
