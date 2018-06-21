Received: from eggs.gnu.org ([2001:4830:134:3::10]:34811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fVxYU-0002Yn-79
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 07:15:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fVxYP-000240-8p
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 07:15:10 -0400
References: <20180620100825.22476-1-david@redhat.com>
	<20180620100825.22476-2-david@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <574e1e82-79f7-af2a-c590-87f480f369a0@redhat.com>
Date: Thu, 21 Jun 2018 13:15:00 +0200
MIME-Version: 1.0
In-Reply-To: <20180620100825.22476-2-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/7] s390x/tod: factor out TOD into
 separate device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>

On 20.06.2018 12:08, David Hildenbrand wrote:
> Let's treat this like a separate device. TCG will have to store the
> actual state/time later on.
>=20
> Include cpu-qom.h in kvm_s390x.h (due to S390CPU) to compile tod-kvm.c.
>=20
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
[...]
> +static void s390_tod_class_init(ObjectClass *oc, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(oc);
> +
> +    dc->desc =3D "TOD (Time Of Day) Clock";
> +    dc->realize =3D s390_tod_realize;
> +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> +
> +    /* We only have one TOD clock in the system attached to the machin=
e */
> +    dc->user_creatable =3D false;
> +    dc->hotpluggable =3D false;
> +}

IIRC you don't need the hotpluggable =3D false if you already set
user_creatable =3D false.

> +static TypeInfo s390_tod_info =3D {
> +    .name =3D TYPE_S390_TOD,
> +    .parent =3D TYPE_DEVICE,
> +    .instance_size =3D sizeof(S390TODState),
> +    .class_init =3D s390_tod_class_init,
> +    .class_size =3D sizeof(S390TODClass),
> +    .abstract =3D true,
> +};
> +
> +static void register_types(void)
> +{
> +    type_register_static(&s390_tod_info);
> +}
> +type_init(register_types);
> diff --git a/include/hw/s390x/tod.h b/include/hw/s390x/tod.h
> new file mode 100644
> index 0000000000..43ed71600f
> --- /dev/null
> +++ b/include/hw/s390x/tod.h
> @@ -0,0 +1,46 @@
> +/*
> + * TOD (Time Of Day) clock
> + *
> + * Copyright 2018 Red Hat, Inc.
> + * Author(s): David Hildenbrand <david@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or =
later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#ifndef HW_S390_TOD_H
> +#define HW_S390_TOD_H
> +
> +#include "hw/qdev.h"
> +
> +typedef struct S390TOD {
> +    uint8_t high;
> +    uint64_t low;
> +} S390TOD;
> +
> +#define TYPE_S390_TOD "s390-tod"
> +#define S390_TOD(obj) OBJECT_CHECK(S390TODState, (obj), TYPE_S390_TOD)
> +#define S390_TOD_CLASS(oc) OBJECT_CLASS_CHECK(S390TODClass, (oc), \
> +                                              TYPE_S390_TOD)
> +#define S390_TOD_GET_CLASS(obj) OBJECT_GET_CLASS(S390TODClass, (obj), =
\
> +                                                 TYPE_S390_TOD)
> +#define TYPE_KVM_S390_TOD "kvm-" TYPE_S390_TOD
> +#define TYPE_QEMU_S390_TOD "qemu-" TYPE_S390_TOD

I'd prefer if you could turn that into suffixes instead of prefixes,
like it is done in include/hw/s390x/storage-keys.h and
storage-attributes.h already.

Apart from that, the patch looks fine to me, so once you've changed
that, feel free to add:

Reviewed-by: Thomas Huth <thuth@redhat.com>
