Received: from eggs.gnu.org ([2001:4830:134:3::10]:53194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f6YK2-0000Gr-5l
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 05:15:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f6YJv-00040g-Sh
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 05:15:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54138 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1f6YJv-00040M-NQ
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 05:15:07 -0400
References: <20180329032149.44685-1-aik@ozlabs.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bc4100f4-0a01-a526-c6ce-c2602a96e28a@redhat.com>
Date: Thu, 12 Apr 2018 11:15:04 +0200
MIME-Version: 1.0
In-Reply-To: <20180329032149.44685-1-aik@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH qemu] RFC: memory/hmp: Print owners/parents
 in "info mtree"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>

On 29/03/2018 05:21, Alexey Kardashevskiy wrote:
> +    DeviceState *dev =3D (DeviceState *) object_dynamic_cast(obj, TYPE=
_DEVICE);
> +    const char *id =3D object_property_print(obj, "id", true, NULL);

I learnt now about commit e1ff3c67e8544f41f1bea76ba76385faee0d2bb7 and I
find it a mistake.  The "id" is available through
object_get_canonical_path_component.  Can you change the "id" assignment
to use object_get_canonical_path_component instead?

> +    const char *name =3D object_property_print(obj, "name", true, NULL=
);

Who defines a name property?

> +    mon_printf(f, " %s:{", label);
> +    if (dev) {
> +        mon_printf(f, "dev");
> +        if (dev->id) {
> +            mon_printf(f, " id=3D%s", dev->id);
> +        }
> +    } else {
> +        mon_printf(f, "obj");

> +    }
> +    if (name) {
> +        mon_printf(f, " name=3D%s ", name);
> +    }
> +    if (id) {
> +        mon_printf(f, " id=3D%s ", id);
> +    }
> +    if (dev && (!name && !id && !dev->id)) {
> +        mon_printf(f, " path=3D%s", dev->canonical_path);

Why not print the path for the !dev case?  I think we can just have

    mon_prinf(f, " %s:{%s", label, dev ? "dev" : "obj");
    if (dev ? dev->id : id) {
        mon_printf(f, " id=3D%s", dev ? dev->id : id);
    } else {
        canonical_path =3D object_get_canonical_path(...)
        mon_printf(f, " path=3D%s", canonical_path);
        g_free(canonical_path);
    }

Thanks,

Paolo
