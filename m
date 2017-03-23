Received: from eggs.gnu.org ([2001:4830:134:3::10]:34299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cr11Z-0004Bx-Vl
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 07:35:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cr11V-0006ll-TD
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 07:35:25 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:33617)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cr11V-0006lP-Hu
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 07:35:21 -0400
Received: by mail-wr0-x243.google.com with SMTP id 20so2727955wrx.0
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 04:35:21 -0700 (PDT)
Date: Thu, 23 Mar 2017 11:35:17 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170323113517.GC12560@stefanha-x1.localdomain>
References: <148900626714.27090.1616990932333159904.stgit@brijesh-build-machine>
	<148900632968.27090.15435012868487968230.stgit@brijesh-build-machine>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GZVR6ND4mMseVXL/"
Content-Disposition: inline
In-Reply-To: <148900632968.27090.15435012868487968230.stgit@brijesh-build-machine>
Subject: Re: [Qemu-devel] [RFC PATCH v4 06/20] core: add new security-policy
 object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brijesh Singh <brijesh.singh@amd.com>
Cc: ehabkost@redhat.com, crosthwaite.peter@gmail.com, armbru@redhat.com, mst@redhat.com, p.fedin@samsung.com, qemu-devel@nongnu.org, lcapitulino@redhat.com, pbonzini@redhat.com, rth@twiddle.net, Thomas.Lendacky@amd.com


--GZVR6ND4mMseVXL/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 08, 2017 at 03:52:09PM -0500, Brijesh Singh wrote:
> The object can be used to define global security policy for the guest.

"security-policy" is very vague.  Lots of parts of QEMU have security
related options (e.g. VNC display, networking, etc).

I'd prefer a
-machine memory-encryption=3Don|off,memory-encryption-debug=3Don|off
or -m encryption=3Don|off,encryption-debug=3Don|off switch instead of a new
security policy object with questionable scope.

> object provides two properties:
>=20
>  1) debug: can be used to disable guest memory access from hypervisor.
>=20
>    e.g to disable guest memory debug accesses
>=20
>     # $QEMU \
>           -object security-policy,debug=3Dfalse,id=3Dmypolicy \
>           -machine ...,security-policy=3Dmypolicy
>=20
>  2) memory-encryption: if hypervisor supports memory encryption then this
>     property can be used to define object for encryption.
>=20
>     # $QEMU \
>         -object sev-guest,id=3Dsev0 \
>         -object security-policy,id=3Dmemory-encryption=3Dsev0,id=3Dmypoli=
cy \

s/id=3Dmemory-encryption=3D/id=3Dmypolicy,memory-encryption=3D/

>         -machine ...,security-policy=3Dmypolicy
>=20
> The memory-encryption property will be used for enabling AMD's SEV featur=
e.
>=20
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  exec.c                           |    7 ++
>  hw/core/Makefile.objs            |    1=20
>  hw/core/machine.c                |   22 +++++
>  hw/core/security-policy.c        |  165 ++++++++++++++++++++++++++++++++=
++++++
>  include/hw/boards.h              |    1=20
>  include/sysemu/security-policy.h |   75 +++++++++++++++++
>  qemu-options.hx                  |   21 +++++
>  7 files changed, 292 insertions(+)
>  create mode 100644 hw/core/security-policy.c
>  create mode 100644 include/sysemu/security-policy.h
>=20
> diff --git a/exec.c b/exec.c
> index 772a959..2c7c891 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -40,6 +40,7 @@
>  #else /* !CONFIG_USER_ONLY */
>  #include "hw/hw.h"
>  #include "exec/memory.h"
> +#include "sysemu/security-policy.h"
>  #include "exec/ioport.h"
>  #include "sysemu/dma.h"
>  #include "sysemu/numa.h"
> @@ -2926,6 +2927,12 @@ static inline void cpu_physical_memory_rw_debug_in=
ternal(AddressSpace *as,
>      hwaddr addr1;
>      MemoryRegion *mr;
> =20
> +    /* Check if debug accesses is allowed */
> +    if (attrs.debug &&
> +        !security_policy_debug_allowed(current_machine->security_policy)=
) {
> +        return;
> +    }
> +
>      rcu_read_lock();
>      while (len > 0) {
>          l =3D len;
> diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
> index 91450b2..3c413b1 100644
> --- a/hw/core/Makefile.objs
> +++ b/hw/core/Makefile.objs
> @@ -18,6 +18,7 @@ common-obj-$(CONFIG_SOFTMMU) +=3D qdev-properties-syste=
m.o
>  common-obj-$(CONFIG_SOFTMMU) +=3D register.o
>  common-obj-$(CONFIG_SOFTMMU) +=3D or-irq.o
>  common-obj-$(CONFIG_PLATFORM_BUS) +=3D platform-bus.o
> +common-obj-$(CONFIG_SOFTMMU) +=3D security-policy.o
> =20
>  obj-$(CONFIG_SOFTMMU) +=3D generic-loader.o
>  obj-$(CONFIG_SOFTMMU) +=3D null-machine.o
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 0699750..c14f59c 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -332,6 +332,23 @@ static bool machine_get_enforce_config_section(Objec=
t *obj, Error **errp)
>      return ms->enforce_config_section;
>  }
> =20
> +static char *machine_get_security_policy(Object *obj, Error **errp)
> +{
> +    MachineState *ms =3D MACHINE(obj);
> +
> +    return g_strdup(ms->security_policy);
> +}
> +
> +static void machine_set_security_policy(Object *obj,
> +                                        const char *value, Error **errp)
> +{
> +    MachineState *ms =3D MACHINE(obj);
> +
> +    g_free(ms->security_policy);
> +    ms->security_policy =3D g_strdup(value);
> +}
> +
> +
>  static void error_on_sysbus_device(SysBusDevice *sbdev, void *opaque)
>  {
>      error_report("Option '-device %s' cannot be handled by this machine",
> @@ -493,6 +510,11 @@ static void machine_class_init(ObjectClass *oc, void=
 *data)
>          &error_abort);
>      object_class_property_set_description(oc, "enforce-config-section",
>          "Set on to enforce configuration section migration", &error_abor=
t);
> +
> +    object_class_property_add_str(oc, "security-policy",
> +            machine_get_security_policy, machine_set_security_policy, NU=
LL);
> +    object_class_property_set_description(oc, "security-policy",
> +            "Set the security policy for the machine", NULL);
>  }
> =20
>  static void machine_class_base_init(ObjectClass *oc, void *data)
> diff --git a/hw/core/security-policy.c b/hw/core/security-policy.c
> new file mode 100644
> index 0000000..4d4658e
> --- /dev/null
> +++ b/hw/core/security-policy.c
> @@ -0,0 +1,165 @@
> +/*
> + * QEMU security policy support
> + *
> + * Copyright (c) 2016 Advanced Micro Devices
> + *
> + * Author:
> + *      Brijesh Singh <brijesh.singh@amd.com>
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qom/object_interfaces.h"
> +#include "qemu/base64.h"
> +
> +#include "sysemu/security-policy.h"
> +
> +static SecurityPolicy *
> +find_security_policy_obj(const char *name)
> +{
> +    Object *obj;
> +    SecurityPolicy *policy;
> +
> +    if (!name) {
> +        return NULL;
> +    }
> +
> +    obj =3D object_resolve_path_component(
> +        object_get_objects_root(), name);
> +    if (!obj) {
> +        return NULL;
> +    }
> +
> +    policy =3D (SecurityPolicy *)
> +        object_dynamic_cast(obj,
> +                            TYPE_SECURITY_POLICY);
> +    if (!policy) {
> +        return NULL;
> +    }
> +
> +    return policy;
> +}
> +
> +bool
> +security_policy_debug_allowed(const char *secure_policy_id)
> +{
> +    SecurityPolicy *policy =3D find_security_policy_obj(secure_policy_id=
);
> +
> +    /* if id is not a valid security policy then we return true */
> +    return policy ? policy->debug : true;
> +}
> +
> +char *
> +security_policy_get_memory_encryption_id(const char *secure_policy_id)
> +{
> +    SecurityPolicy *policy =3D find_security_policy_obj(secure_policy_id=
);
> +
> +    return policy ? g_strdup(policy->memory_encryption) : NULL;
> +}
> +
> +static bool
> +security_policy_prop_get_debug(Object *obj,
> +                               Error **errp G_GNUC_UNUSED)
> +{
> +    SecurityPolicy *policy =3D SECURITY_POLICY(obj);
> +
> +    return policy->debug;
> +}
> +
> +
> +static void
> +security_policy_prop_set_debug(Object *obj,
> +                               bool value,
> +                               Error **errp G_GNUC_UNUSED)
> +{
> +    SecurityPolicy *policy =3D SECURITY_POLICY(obj);
> +
> +    policy->debug =3D value;
> +}
> +
> +static char *
> +sev_launch_get_memory_encryption(Object *obj, Error **errp)
> +{
> +    SecurityPolicy *policy =3D SECURITY_POLICY(obj);
> +
> +    return g_strdup(policy->memory_encryption);
> +}
> +
> +static void
> +sev_launch_set_memory_encryption(Object *obj, const char *value,
> +                                 Error **errp)
> +{
> +    SecurityPolicy *policy =3D SECURITY_POLICY(obj);
> +
> +    policy->memory_encryption =3D g_strdup(value);
> +}
> +
> +static void
> +security_policy_init(Object *obj)
> +{
> +    SecurityPolicy *policy =3D SECURITY_POLICY(obj);
> +
> +    policy->debug =3D true;
> +}
> +
> +static void
> +security_policy_finalize(Object *obj)
> +{
> +}
> +
> +static void
> +security_policy_class_init(ObjectClass *oc, void *data)
> +{
> +    object_class_property_add_bool(oc, "debug",
> +                                   security_policy_prop_get_debug,
> +                                   security_policy_prop_set_debug,
> +                                   NULL);
> +    object_class_property_set_description(oc, "debug",
> +            "Set on/off if debugging is allowed on this guest (default o=
n)",
> +            NULL);
> +    object_class_property_add_str(oc, "memory-encryption",
> +                                  sev_launch_get_memory_encryption,
> +                                  sev_launch_set_memory_encryption,
> +                                  NULL);
> +    object_class_property_set_description(oc, "memory-encryption",
> +            "Set memory encryption object id (if supported by hardware)",
> +            NULL);
> +}
> +
> +static const TypeInfo security_policy_info =3D {
> +    .parent =3D TYPE_OBJECT,
> +    .name =3D TYPE_SECURITY_POLICY,
> +    .instance_size =3D sizeof(SecurityPolicy),
> +    .instance_init =3D security_policy_init,
> +    .instance_finalize =3D security_policy_finalize,
> +    .class_size =3D sizeof(SecurityPolicyClass),
> +    .class_init =3D security_policy_class_init,
> +    .interfaces =3D (InterfaceInfo[]) {
> +        { TYPE_USER_CREATABLE },
> +        { }
> +    }
> +};
> +
> +
> +static void
> +security_policy_register_types(void)
> +{
> +    type_register_static(&security_policy_info);
> +}
> +
> +
> +type_init(security_policy_register_types);
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index 269d0ba..a1c99a0 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -153,6 +153,7 @@ struct MachineState {
>      /*< public >*/
> =20
>      char *accel;
> +    char *security_policy;
>      bool kernel_irqchip_allowed;
>      bool kernel_irqchip_required;
>      bool kernel_irqchip_split;
> diff --git a/include/sysemu/security-policy.h b/include/sysemu/security-p=
olicy.h
> new file mode 100644
> index 0000000..6d3789d
> --- /dev/null
> +++ b/include/sysemu/security-policy.h
> @@ -0,0 +1,75 @@
> +/*
> + * QEMU security policy support
> + *
> + * Copyright (c) 2016 Advanced Micro Devices
> + *
> + * Author:
> + *      Brijesh Singh <brijesh.singh@amd.com>
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
> + *
> + */
> +
> +#ifndef SECURITY_POLICY_H
> +#define SECURITY_POLICY_H
> +
> +#include "qom/object.h"
> +
> +#define TYPE_SECURITY_POLICY "security-policy"
> +#define SECURITY_POLICY(obj)                  \
> +    OBJECT_CHECK(SecurityPolicy, (obj), TYPE_SECURITY_POLICY)
> +
> +typedef struct SecurityPolicy SecurityPolicy;
> +typedef struct SecurityPolicyClass SecurityPolicyClass;
> +
> +/**
> + * SecurityPolicy:
> + *
> + * The SecurityPolicy object provides method to define
> + * various security releated policies for guest machine.
> + *
> + * e.g
> + * When launching QEMU, user can create a security policy
> + * to disallow memory dump and debug of guest
> + *
> + *  # $QEMU \
> + *      -object security-policy,id=3Dmypolicy,debug=3Doff \
> + *      -machine ...,security-policy=3Dmypolicy
> + *
> + * If hardware supports memory encryption then user can set
> + * encryption policy of guest
> + *
> + * # $QEMU \
> + *    -object encrypt-policy,key=3Dxxx,flags=3Dxxxx,id=3Dencrypt \
> + *    -object security-policy,debug=3Doff,memory-encryption=3Dencrypt,id=
=3Dmypolicy \
> + *    -machine ...,security-policy=3Dmypolicy
> + *
> + */
> +
> +struct SecurityPolicy {
> +    Object parent_obj;
> +
> +    bool debug;
> +    char *memory_encryption;
> +};
> +
> +
> +struct SecurityPolicyClass {
> +    ObjectClass parent_class;
> +};
> +
> +bool security_policy_debug_allowed(const char *name);
> +char *security_policy_get_memory_encryption_id(const char *name);
> +
> +#endif /* SECURITY_POLICY_H */
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 2292438..536db1b 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -4140,6 +4140,27 @@ contents of @code{iv.b64} to the second secret
> =20
>  @end table
> =20
> +@item -object security-policy,id=3D@var{id}[,debug=3D@var{bool}][,memory=
-encryption=3D@var{string}]
> +
> +Create a security policy object, which can be used to define guest secur=
ity.
> +The id parameter is a unique ID that will be used to reference this
> +object when security-policy is applied via -machine argument.
> +
> +The 'debug' parameter can be defined to tell whether the debugging or me=
mory
> +dump is allowed through qemu monitor console.
> +
> +e.g to disable the guest memory dump
> +@example
> + # $QEMU \
> +     -object security-policy,id=3Dsecure0,debug=3Doff \
> +     -machine ...,security-policy=3Dsecure0
> +@end example
> +
> +if hardware support guest memory encrytion, then 'memory-encryption' par=
ameter
> +can be set to the unquie ID of memory encryption object.
> +
> +On AMD processor, memory encryption is supported via 'sev-guest' object.
> +
>  ETEXI
> =20
> =20
>=20
>=20

--GZVR6ND4mMseVXL/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY07L1AAoJEJykq7OBq3PI9+0IALd9OwbJJ7YfUAK3VgKbXnNo
gCuDVMQqMN/wA86UtyO5o5L4VixXlTYEAGT71zcLHjeDhxiWjGvMk9i4z/k+JRra
0CSItHFchxBUGibU7ECJomHd+7Z3aey03L+2ZXKld+WZ0o7w3c9IzTkllFYHgyl6
4pUUFB+YA8ElicoUbe08OjT0awbMN2EcUeShTClkwJuUSsmMdq25bY9tmUmM6Sbx
1NFXTvSGdY7yfyw/ZiyBRvBP9eFw4gk3sBCA0J10IS5e1kvQAUhT6AWr2ndqcxQZ
1tRuEwzxjCnOjvwgSkexJtzjq+OrEAyr3R+wTH/Jcf/l4TgoV1Ti7bqvX/Pz4xc=
=ao62
-----END PGP SIGNATURE-----

--GZVR6ND4mMseVXL/--
