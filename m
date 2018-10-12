Received: from eggs.gnu.org ([2001:4830:134:3::10]:56859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gAx4b-00083B-9e
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 09:01:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gAx4Z-0003up-Nt
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 09:01:44 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:45709)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gAx4Z-0003sf-AG
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 09:01:43 -0400
Received: by mail-ot1-x343.google.com with SMTP id u22so12247765ota.12
	for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 06:01:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <b41a233c-988c-19bb-0d4b-b17655912839@redhat.com>
References: <b41a233c-988c-19bb-0d4b-b17655912839@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Oct 2018 14:01:21 +0100
Message-ID: <CAFEAcA-TeU8SRPrZU_6=97yyL8UkMO_61P8oK4Xz2q0DweeBQA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] QOM: Can devices having link properties be
 user-creatable?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, Thomas Huth <thuth@redhat.com>, Mao Zhongyi <maozhongyi@cmss.chinamobile.com>

On 12 October 2018 at 13:47, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
> While looking at Mao's series
> (https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg02519.html) I
> wondered if devices having link properties can be user-creatable.
>
> Using the following patch (I don't think this is correct to put qdev
> code into qobject, but I used this as PoC):
>
> -- >8 --
> diff --git a/qom/object.c b/qom/object.c
> index 547dcf97c3..2dd3a25531 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -16,4 +16,5 @@
>  #include "qom/object_interfaces.h"
>  #include "qemu/cutils.h"
> +#include "qemu/error-report.h"
>  #include "qapi/visitor.h"
>  #include "qapi/string-input-visitor.h"
> @@ -1662,4 +1663,11 @@ void object_property_add_link(Object *obj, const
> char *name,
>      gchar *full_type;
>      ObjectProperty *op;
> +    ObjectClass *klass =3D object_get_class(obj);
> +
> +    if (klass && object_dynamic_cast(obj, TYPE_DEVICE) &&
> +                 DEVICE_CLASS(klass)->user_creatable =3D=3D false) {
> +        warn_report("Device type '%s' is user_creatable "
> +                    "(linked property: '%s')", type, name);
> +    }
>
>      prop->child =3D child;
> ---
>
> I get:
>
> $ aarch64-softmmu/qemu-system-aarch64 -M virt
> qemu-system-aarch64: warning: Device type 'bus' is user_creatable
> (linked property: 'parent_bus')
> qemu-system-aarch64: warning: Device type 'qemu:memory-region' is
> user_creatable (linked property: 'memory')

Is your warning printing the wrong thing? "bus", "irq",
etc don't seem like names of devices...

I think whether a device with a link property is
user creatable might depend on what the property is
for and whether the device has a useful fallback for
"link not connected".

thanks
-- PMM
