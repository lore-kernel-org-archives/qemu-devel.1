Received: from eggs.gnu.org ([2001:4830:134:3::10]:46654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dVIL3-0002xY-A3
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 10:10:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dVIKz-00007a-OE
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 10:10:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46272)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dVIKz-00006h-FL
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 10:09:57 -0400
References: <1499864265-144136-1-git-send-email-borntraeger@de.ibm.com>
	<1499864265-144136-4-git-send-email-borntraeger@de.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <92a0944a-156a-6800-88f1-ae39b5263730@redhat.com>
Date: Wed, 12 Jul 2017 16:09:43 +0200
MIME-Version: 1.0
In-Reply-To: <1499864265-144136-4-git-send-email-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 03/11] s390x/migration: Storage attributes
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel <qemu-devel@nongnu.org>
Cc: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>

On 12.07.2017 14:57, Christian Borntraeger wrote:
> From: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
>=20
> Storage attributes device, like we have for storage keys.
>=20
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
[...]
> diff --git a/hw/s390x/s390-stattrib-kvm.c b/hw/s390x/s390-stattrib-kvm.=
c
> new file mode 100644
> index 0000000..2e7f144
> --- /dev/null
> +++ b/hw/s390x/s390-stattrib-kvm.c
> @@ -0,0 +1,178 @@
> +/*
> + * s390 storage attributes device -- KVM object
> + *
> + * Copyright 2016 IBM Corp.
> + * Author(s): Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or =
(at
> + * your option) any later version. See the COPYING file in the top-lev=
el
> + * directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/boards.h"
> +#include "qmp-commands.h"

Why do you need qmp-commands.h here?

> +#include "migration/qemu-file.h"
> +#include "hw/s390x/storage-attributes.h"
> +#include "qemu/error-report.h"
> +#include "sysemu/kvm.h"
> +#include "exec/ram_addr.h"
> +#include "cpu.h"
> +
> +static void kvm_s390_stattrib_instance_init(Object *obj)
> +{
> +    KVMS390StAttribState *sas =3D KVM_S390_STATTRIB(obj);
> +
> +    sas->still_dirty =3D 0;
> +}
> +
> +static int kvm_s390_stattrib_read_helper(S390StAttribState *sa,
> +                                        uint64_t *start_gfn,
> +                                        uint32_t count,
> +                                        uint8_t *values,
> +                                        uint32_t flags)

Indentation seems to be off by 1 ----------^

> +{
> +    KVMS390StAttribState *sas =3D KVM_S390_STATTRIB(sa);
> +    int r;
> +    struct kvm_s390_cmma_log clog =3D {
> +        .values =3D (uint64_t)values,
> +        .start_gfn =3D *start_gfn,
> +        .count =3D count,
> +        .flags =3D flags,
> +    };
> +
> +    r =3D kvm_vm_ioctl(kvm_state, KVM_S390_GET_CMMA_BITS, &clog);
> +    if (r < 0) {
> +        error_report("Error: %s", strerror(-r));

Please avoid "Error:" ... there is currently a patch series on the
qemu-devel mailing list which will likely add an "error: " prefix for
all error_reports()s automatically. So please use a better error message
here instead, e.g. something like "KVM_S390_GET_CMMA_BITS ioctl failed".

> +        return r;
> +    }
> +
> +    *start_gfn =3D clog.start_gfn;
> +    sas->still_dirty =3D clog.remaining;
> +    return clog.count;
> +}
> +
> +static int kvm_s390_stattrib_get_stattr(S390StAttribState *sa,
> +                                        uint64_t *start_gfn,
> +                                        uint32_t count,
> +                                        uint8_t *values)
> +{
> +    return kvm_s390_stattrib_read_helper(sa, start_gfn, count, values,=
 0);
> +}
> +
> +static int kvm_s390_stattrib_peek_stattr(S390StAttribState *sa,
> +                                         uint64_t start_gfn,
> +                                         uint32_t count,
> +                                         uint8_t *values)
> +{
> +    return kvm_s390_stattrib_read_helper(sa, &start_gfn, count, values=
,
> +                                         KVM_S390_CMMA_PEEK);
> +}
> +
> +static int kvm_s390_stattrib_set_stattr(S390StAttribState *sa,
> +                                        uint64_t start_gfn,
> +                                        uint32_t count,
> +                                        uint8_t *values)
> +{
> +    KVMS390StAttribState *sas =3D KVM_S390_STATTRIB(sa);
> +    MachineState *machine =3D MACHINE(qdev_get_machine());
> +    unsigned long max =3D machine->maxram_size / TARGET_PAGE_SIZE;
> +
> +    if (start_gfn + count > max) {
> +        error_report("Error: invalid address.");

dito - please use a better error message.

> +        return -1;
> +    }
> +    if (!sas->incoming_buffer) {
> +        sas->incoming_buffer =3D g_malloc0(max);
> +    }
> +
> +    memcpy(sas->incoming_buffer + start_gfn, values, count);
> +
> +    return 0;
> +}
> +
> +static void kvm_s390_stattrib_synchronize(S390StAttribState *sa)
> +{
> +    KVMS390StAttribState *sas =3D KVM_S390_STATTRIB(sa);
> +    MachineState *machine =3D MACHINE(qdev_get_machine());
> +    unsigned long max =3D machine->maxram_size / TARGET_PAGE_SIZE;
> +    unsigned long cx, len =3D 1 << 19;
> +    int r;
> +    struct kvm_s390_cmma_log clog =3D {
> +        .flags =3D 0,
> +        .mask =3D ~0ULL,
> +    };
> +
> +    if (sas->incoming_buffer) {
> +        for (cx =3D 0; cx + len <=3D max; cx +=3D len) {
> +            clog.start_gfn =3D cx;
> +            clog.count =3D len;
> +            clog.values =3D (uint64_t)(sas->incoming_buffer + cx * len=
);
> +            r =3D kvm_vm_ioctl(kvm_state, KVM_S390_SET_CMMA_BITS, &clo=
g);
> +            if (r) {
> +                return;

So if the ioctl failed, it will go completely unnoticed? Sounds like
this could result in hard-to-debug situations, so maybe add an error
message here?

> +            }
> +        }
> +        if (cx < max) {
> +            clog.start_gfn =3D cx;
> +            clog.count =3D max - cx;
> +            clog.values =3D (uint64_t)(sas->incoming_buffer + cx * len=
);
> +            r =3D kvm_vm_ioctl(kvm_state, KVM_S390_SET_CMMA_BITS, &clo=
g);

check r for error?

> +        }
> +        g_free(sas->incoming_buffer);
> +        sas->incoming_buffer =3D NULL;
> +    }
> +}
> +
> +static int kvm_s390_stattrib_set_migrationmode(S390StAttribState *sa, =
bool val)
> +{
> +    struct kvm_device_attr attr =3D {
> +        .group =3D KVM_S390_VM_MIGRATION,
> +        .attr =3D val,
> +        .addr =3D 0,
> +    };
> +    return kvm_vm_ioctl(kvm_state, KVM_SET_DEVICE_ATTR, &attr);
> +}
> +
> +static long long kvm_s390_stattrib_get_dirtycount(S390StAttribState *s=
a)
> +{
> +    KVMS390StAttribState *sas =3D KVM_S390_STATTRIB(sa);
> +    uint8_t val[8];
> +
> +    kvm_s390_stattrib_peek_stattr(sa, 0, 1, val);
> +    return sas->still_dirty;
> +}
> +
> +static int kvm_s390_stattrib_get_active(S390StAttribState *sa)
> +{
> +    return kvm_s390_cmma_active() && sa->migration_enabled;
> +}
> +
> +static void kvm_s390_stattrib_class_init(ObjectClass *oc, void *data)
> +{
> +    S390StAttribClass *sac =3D S390_STATTRIB_CLASS(oc);
> +
> +    sac->get_stattr =3D kvm_s390_stattrib_get_stattr;
> +    sac->peek_stattr =3D kvm_s390_stattrib_peek_stattr;
> +    sac->set_stattr =3D kvm_s390_stattrib_set_stattr;
> +    sac->set_migrationmode =3D kvm_s390_stattrib_set_migrationmode;
> +    sac->get_dirtycount =3D kvm_s390_stattrib_get_dirtycount;
> +    sac->synchronize =3D kvm_s390_stattrib_synchronize;
> +    sac->get_active =3D kvm_s390_stattrib_get_active;
> +}
> +
> +static const TypeInfo kvm_s390_stattrib_info =3D {
> +    .name          =3D TYPE_KVM_S390_STATTRIB,
> +    .parent        =3D TYPE_S390_STATTRIB,
> +    .instance_init =3D kvm_s390_stattrib_instance_init,
> +    .instance_size =3D sizeof(KVMS390StAttribState),
> +    .class_init    =3D kvm_s390_stattrib_class_init,
> +    .class_size    =3D sizeof(S390StAttribClass),
> +};
> +
> +static void kvm_s390_stattrib_register_types(void)
> +{
> +    type_register_static(&kvm_s390_stattrib_info);
> +}
> +
> +type_init(kvm_s390_stattrib_register_types)
> diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
> new file mode 100644
> index 0000000..eb41fe9
> --- /dev/null
> +++ b/hw/s390x/s390-stattrib.c
> @@ -0,0 +1,348 @@
> +/*
> + * s390 storage attributes device
> + *
> + * Copyright 2016 IBM Corp.
> + * Author(s): Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or =
(at
> + * your option) any later version. See the COPYING file in the top-lev=
el
> + * directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/boards.h"
> +#include "migration/qemu-file.h"
> +#include "migration/register.h"
> +#include "hw/s390x/storage-attributes.h"
> +#include "qemu/error-report.h"
> +#include "sysemu/kvm.h"
> +#include "exec/ram_addr.h"
> +#include "qapi/error.h"
> +
> +#define CMMA_BLOCK_SIZE  (1 << 10)
> +
> +#define STATTR_FLAG_EOS     0x01ULL
> +#define STATTR_FLAG_MORE    0x02ULL
> +#define STATTR_FLAG_ERROR   0x04ULL
> +#define STATTR_FLAG_DONE    0x08ULL
> +
> +void s390_stattrib_init(void)
> +{
> +    Object *obj;
> +
> +#ifdef CONFIG_KVM
> +    if (kvm_enabled() &&
> +            kvm_check_extension(kvm_state, KVM_CAP_S390_CMMA_MIGRATION=
)) {
> +        obj =3D object_new(TYPE_KVM_S390_STATTRIB);
> +    } else {
> +        obj =3D object_new(TYPE_QEMU_S390_STATTRIB);
> +    }
> +#else
> +    obj =3D object_new(TYPE_QEMU_S390_STATTRIB);
> +#endif

Could you maybe do something similar as in s390_flic_init() to avoid the
#ifdefs here?

> +    object_property_add_child(qdev_get_machine(), TYPE_S390_STATTRIB,
> +                              obj, NULL);
> +    object_unref(obj);
> +
> +    qdev_init_nofail(DEVICE(obj));
> +}
[...]
> +static int cmma_save(QEMUFile *f, void *opaque, int final)
> +{
> +    S390StAttribState *sas =3D S390_STATTRIB(opaque);
> +    S390StAttribClass *sac =3D S390_STATTRIB_GET_CLASS(sas);
> +    uint8_t *buf;
> +    int r, cx, reallen =3D 0, ret =3D 0;
> +    uint32_t buflen =3D 1 << 19;   /* 512kB cover 2GB of guest memory =
*/
> +    uint64_t start_gfn =3D sas->migration_cur_gfn;
> +
> +    buf =3D g_try_malloc(buflen);
> +    if (!buf) {
> +        error_report("Could not allocate memory to save storage attrib=
utes");
> +        return -ENOMEM;
> +    }
> +
> +    while (final ? 1 : qemu_file_rate_limit(f) =3D=3D 0) {
> +        reallen =3D sac->get_stattr(sas, &start_gfn, buflen, buf);
> +        if (reallen < 0) {
> +            g_free(buf);
> +            return reallen;
> +        }
> +
> +        ret =3D 1;
> +        if (0 =3D=3D reallen) {

Please, no Yoda conditions. See CODING_STYLE file.

> +            break;
> +        }
> +        qemu_put_be64(f, (start_gfn << TARGET_PAGE_BITS) | STATTR_FLAG=
_MORE);
> +        qemu_put_be64(f, reallen);
> +        for (cx =3D 0; cx < reallen; cx++) {
> +            qemu_put_byte(f, buf[cx]);
> +        }
> +        if (!sac->get_dirtycount(sas)) {
> +            break;
> +        }
> +    }
> +
> +    sas->migration_cur_gfn =3D start_gfn + reallen;
> +    g_free(buf);
> +    if (final) {
> +        qemu_put_be64(f, STATTR_FLAG_DONE);
> +    }
> +    qemu_put_be64(f, STATTR_FLAG_EOS);
> +
> +    r =3D qemu_file_get_error(f);
> +    if (r < 0) {
> +        return r;
> +    }
> +
> +    return ret;
> +}
[...]

 Thomas
