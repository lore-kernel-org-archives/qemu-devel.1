Received: from eggs.gnu.org ([2001:4830:134:3::10]:39721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVYHq-0003vG-3n
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 03:11:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVYHm-0002eZ-Ry
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 03:11:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41731)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dVYHm-0002eK-Gw
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 03:11:42 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6D796o8093406
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 03:11:41 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bnt3x3bky-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 03:11:40 -0400
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 13 Jul 2017 03:11:39 -0400
References: <1499864265-144136-1-git-send-email-borntraeger@de.ibm.com>
	<1499864265-144136-4-git-send-email-borntraeger@de.ibm.com>
	<92a0944a-156a-6800-88f1-ae39b5263730@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 13 Jul 2017 09:11:34 +0200
MIME-Version: 1.0
In-Reply-To: <92a0944a-156a-6800-88f1-ae39b5263730@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-IE
Content-Transfer-Encoding: 7bit
Message-Id: <83795acd-ddfd-e039-80bb-78a785fb7669@de.ibm.com>
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
To: Thomas Huth <thuth@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Cc: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>

Thanks for the review, all valid. Claudio has provided me the following fixup.

I plan to fold that in the base patch (retest pending).

Christian


---
 hw/s390x/s390-stattrib-kvm.c          | 26 +++++++++++++++++++-------
 hw/s390x/s390-stattrib.c              | 12 +++---------
 include/hw/s390x/storage-attributes.h |  9 +++++++++
 3 files changed, 31 insertions(+), 16 deletions(-)

diff --git a/hw/s390x/s390-stattrib-kvm.c b/hw/s390x/s390-stattrib-kvm.c
index 2e7f144..2ab3060 100644
--- a/hw/s390x/s390-stattrib-kvm.c
+++ b/hw/s390x/s390-stattrib-kvm.c
@@ -11,7 +11,6 @@

 #include "qemu/osdep.h"
 #include "hw/boards.h"
-#include "qmp-commands.h"
 #include "migration/qemu-file.h"
 #include "hw/s390x/storage-attributes.h"
 #include "qemu/error-report.h"
@@ -19,6 +18,15 @@
 #include "exec/ram_addr.h"
 #include "cpu.h"

+Object *kvm_s390_stattrib_create(void)
+{
+    if (kvm_enabled() &&
+                kvm_check_extension(kvm_state, KVM_CAP_S390_CMMA_MIGRATION)) {
+        return object_new(TYPE_KVM_S390_STATTRIB);
+    }
+    return object_new(TYPE_QEMU_S390_STATTRIB);
+}
+
 static void kvm_s390_stattrib_instance_init(Object *obj)
 {
     KVMS390StAttribState *sas = KVM_S390_STATTRIB(obj);
@@ -27,10 +35,10 @@ static void kvm_s390_stattrib_instance_init(Object *obj)
 }

 static int kvm_s390_stattrib_read_helper(S390StAttribState *sa,
-                                        uint64_t *start_gfn,
-                                        uint32_t count,
-                                        uint8_t *values,
-                                        uint32_t flags)
+                                         uint64_t *start_gfn,
+                                         uint32_t count,
+                                         uint8_t *values,
+                                         uint32_t flags)
 {
     KVMS390StAttribState *sas = KVM_S390_STATTRIB(sa);
     int r;
@@ -43,7 +51,7 @@ static int kvm_s390_stattrib_read_helper(S390StAttribState *sa,

     r = kvm_vm_ioctl(kvm_state, KVM_S390_GET_CMMA_BITS, &clog);
     if (r < 0) {
-        error_report("Error: %s", strerror(-r));
+        error_report("KVM_S390_GET_CMMA_BITS failed: %s", strerror(-r));
         return r;
     }

@@ -79,7 +87,7 @@ static int kvm_s390_stattrib_set_stattr(S390StAttribState *sa,
     unsigned long max = machine->maxram_size / TARGET_PAGE_SIZE;

     if (start_gfn + count > max) {
-        error_report("Error: invalid address.");
+        error_report("Out of memory bounds when setting storage attributes");
         return -1;
     }
     if (!sas->incoming_buffer) {
@@ -110,6 +118,7 @@ static void kvm_s390_stattrib_synchronize(S390StAttribState *sa)
             clog.values = (uint64_t)(sas->incoming_buffer + cx * len);
             r = kvm_vm_ioctl(kvm_state, KVM_S390_SET_CMMA_BITS, &clog);
             if (r) {
+                error_report("KVM_S390_SET_CMMA_BITS failed: %s", strerror(-r));
                 return;
             }
         }
@@ -118,6 +127,9 @@ static void kvm_s390_stattrib_synchronize(S390StAttribState *sa)
             clog.count = max - cx;
             clog.values = (uint64_t)(sas->incoming_buffer + cx * len);
             r = kvm_vm_ioctl(kvm_state, KVM_S390_SET_CMMA_BITS, &clog);
+            if (r) {
+                error_report("KVM_S390_SET_CMMA_BITS failed: %s", strerror(-r));
+            }
         }
         g_free(sas->incoming_buffer);
         sas->incoming_buffer = NULL;
diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
index b9533b4..bac9aea 100644
--- a/hw/s390x/s390-stattrib.c
+++ b/hw/s390x/s390-stattrib.c
@@ -40,16 +40,10 @@ void s390_stattrib_init(void)
 {
     Object *obj;

-#ifdef CONFIG_KVM
-    if (kvm_enabled() &&
-            kvm_check_extension(kvm_state, KVM_CAP_S390_CMMA_MIGRATION)) {
-        obj = object_new(TYPE_KVM_S390_STATTRIB);
-    } else {
+    obj = kvm_s390_stattrib_create();
+    if (!obj) {
         obj = object_new(TYPE_QEMU_S390_STATTRIB);
     }
-#else
-    obj = object_new(TYPE_QEMU_S390_STATTRIB);
-#endif

     object_property_add_child(qdev_get_machine(), TYPE_S390_STATTRIB,
                               obj, NULL);
@@ -224,7 +218,7 @@ static int cmma_save(QEMUFile *f, void *opaque, int final)
         }

         ret = 1;
-        if (0 == reallen) {
+        if (!reallen) {
             break;
         }
         qemu_put_be64(f, (start_gfn << TARGET_PAGE_BITS) | STATTR_FLAG_MORE);
diff --git a/include/hw/s390x/storage-attributes.h b/include/hw/s390x/storage-attributes.h
index ccf4aa1..9be954d 100644
--- a/include/hw/s390x/storage-attributes.h
+++ b/include/hw/s390x/storage-attributes.h
@@ -66,6 +66,15 @@ typedef struct KVMS390StAttribState {

 void s390_stattrib_init(void);

+#ifdef CONFIG_KVM
+Object *kvm_s390_stattrib_create(void);
+#else
+static inline Object *kvm_s390_stattrib_create(void)
+{
+    return NULL;
+}
+#endif
+
 void hmp_info_cmma(Monitor *mon, const QDict *qdict);
 void hmp_migrationmode(Monitor *mon, const QDict *qdict);


On 07/12/2017 04:09 PM, Thomas Huth wrote:
> On 12.07.2017 14:57, Christian Borntraeger wrote:
>> From: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
>>
>> Storage attributes device, like we have for storage keys.
>>
>> Signed-off-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
> [...]
>> diff --git a/hw/s390x/s390-stattrib-kvm.c b/hw/s390x/s390-stattrib-kvm.c
>> new file mode 100644
>> index 0000000..2e7f144
>> --- /dev/null
>> +++ b/hw/s390x/s390-stattrib-kvm.c
>> @@ -0,0 +1,178 @@
>> +/*
>> + * s390 storage attributes device -- KVM object
>> + *
>> + * Copyright 2016 IBM Corp.
>> + * Author(s): Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or (at
>> + * your option) any later version. See the COPYING file in the top-level
>> + * directory.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "hw/boards.h"
>> +#include "qmp-commands.h"
> 
> Why do you need qmp-commands.h here?
> 
>> +#include "migration/qemu-file.h"
>> +#include "hw/s390x/storage-attributes.h"
>> +#include "qemu/error-report.h"
>> +#include "sysemu/kvm.h"
>> +#include "exec/ram_addr.h"
>> +#include "cpu.h"
>> +
>> +static void kvm_s390_stattrib_instance_init(Object *obj)
>> +{
>> +    KVMS390StAttribState *sas = KVM_S390_STATTRIB(obj);
>> +
>> +    sas->still_dirty = 0;
>> +}
>> +
>> +static int kvm_s390_stattrib_read_helper(S390StAttribState *sa,
>> +                                        uint64_t *start_gfn,
>> +                                        uint32_t count,
>> +                                        uint8_t *values,
>> +                                        uint32_t flags)
> 
> Indentation seems to be off by 1 ----------^
> 
>> +{
>> +    KVMS390StAttribState *sas = KVM_S390_STATTRIB(sa);
>> +    int r;
>> +    struct kvm_s390_cmma_log clog = {
>> +        .values = (uint64_t)values,
>> +        .start_gfn = *start_gfn,
>> +        .count = count,
>> +        .flags = flags,
>> +    };
>> +
>> +    r = kvm_vm_ioctl(kvm_state, KVM_S390_GET_CMMA_BITS, &clog);
>> +    if (r < 0) {
>> +        error_report("Error: %s", strerror(-r));
> 
> Please avoid "Error:" ... there is currently a patch series on the
> qemu-devel mailing list which will likely add an "error: " prefix for
> all error_reports()s automatically. So please use a better error message
> here instead, e.g. something like "KVM_S390_GET_CMMA_BITS ioctl failed".
> 
>> +        return r;
>> +    }
>> +
>> +    *start_gfn = clog.start_gfn;
>> +    sas->still_dirty = clog.remaining;
>> +    return clog.count;
>> +}
>> +
>> +static int kvm_s390_stattrib_get_stattr(S390StAttribState *sa,
>> +                                        uint64_t *start_gfn,
>> +                                        uint32_t count,
>> +                                        uint8_t *values)
>> +{
>> +    return kvm_s390_stattrib_read_helper(sa, start_gfn, count, values, 0);
>> +}
>> +
>> +static int kvm_s390_stattrib_peek_stattr(S390StAttribState *sa,
>> +                                         uint64_t start_gfn,
>> +                                         uint32_t count,
>> +                                         uint8_t *values)
>> +{
>> +    return kvm_s390_stattrib_read_helper(sa, &start_gfn, count, values,
>> +                                         KVM_S390_CMMA_PEEK);
>> +}
>> +
>> +static int kvm_s390_stattrib_set_stattr(S390StAttribState *sa,
>> +                                        uint64_t start_gfn,
>> +                                        uint32_t count,
>> +                                        uint8_t *values)
>> +{
>> +    KVMS390StAttribState *sas = KVM_S390_STATTRIB(sa);
>> +    MachineState *machine = MACHINE(qdev_get_machine());
>> +    unsigned long max = machine->maxram_size / TARGET_PAGE_SIZE;
>> +
>> +    if (start_gfn + count > max) {
>> +        error_report("Error: invalid address.");
> 
> dito - please use a better error message.
> 
>> +        return -1;
>> +    }
>> +    if (!sas->incoming_buffer) {
>> +        sas->incoming_buffer = g_malloc0(max);
>> +    }
>> +
>> +    memcpy(sas->incoming_buffer + start_gfn, values, count);
>> +
>> +    return 0;
>> +}
>> +
>> +static void kvm_s390_stattrib_synchronize(S390StAttribState *sa)
>> +{
>> +    KVMS390StAttribState *sas = KVM_S390_STATTRIB(sa);
>> +    MachineState *machine = MACHINE(qdev_get_machine());
>> +    unsigned long max = machine->maxram_size / TARGET_PAGE_SIZE;
>> +    unsigned long cx, len = 1 << 19;
>> +    int r;
>> +    struct kvm_s390_cmma_log clog = {
>> +        .flags = 0,
>> +        .mask = ~0ULL,
>> +    };
>> +
>> +    if (sas->incoming_buffer) {
>> +        for (cx = 0; cx + len <= max; cx += len) {
>> +            clog.start_gfn = cx;
>> +            clog.count = len;
>> +            clog.values = (uint64_t)(sas->incoming_buffer + cx * len);
>> +            r = kvm_vm_ioctl(kvm_state, KVM_S390_SET_CMMA_BITS, &clog);
>> +            if (r) {
>> +                return;
> 
> So if the ioctl failed, it will go completely unnoticed? Sounds like
> this could result in hard-to-debug situations, so maybe add an error
> message here?
> 
>> +            }
>> +        }
>> +        if (cx < max) {
>> +            clog.start_gfn = cx;
>> +            clog.count = max - cx;
>> +            clog.values = (uint64_t)(sas->incoming_buffer + cx * len);
>> +            r = kvm_vm_ioctl(kvm_state, KVM_S390_SET_CMMA_BITS, &clog);
> 
> check r for error?
> 
>> +        }
>> +        g_free(sas->incoming_buffer);
>> +        sas->incoming_buffer = NULL;
>> +    }
>> +}
>> +
>> +static int kvm_s390_stattrib_set_migrationmode(S390StAttribState *sa, bool val)
>> +{
>> +    struct kvm_device_attr attr = {
>> +        .group = KVM_S390_VM_MIGRATION,
>> +        .attr = val,
>> +        .addr = 0,
>> +    };
>> +    return kvm_vm_ioctl(kvm_state, KVM_SET_DEVICE_ATTR, &attr);
>> +}
>> +
>> +static long long kvm_s390_stattrib_get_dirtycount(S390StAttribState *sa)
>> +{
>> +    KVMS390StAttribState *sas = KVM_S390_STATTRIB(sa);
>> +    uint8_t val[8];
>> +
>> +    kvm_s390_stattrib_peek_stattr(sa, 0, 1, val);
>> +    return sas->still_dirty;
>> +}
>> +
>> +static int kvm_s390_stattrib_get_active(S390StAttribState *sa)
>> +{
>> +    return kvm_s390_cmma_active() && sa->migration_enabled;
>> +}
>> +
>> +static void kvm_s390_stattrib_class_init(ObjectClass *oc, void *data)
>> +{
>> +    S390StAttribClass *sac = S390_STATTRIB_CLASS(oc);
>> +
>> +    sac->get_stattr = kvm_s390_stattrib_get_stattr;
>> +    sac->peek_stattr = kvm_s390_stattrib_peek_stattr;
>> +    sac->set_stattr = kvm_s390_stattrib_set_stattr;
>> +    sac->set_migrationmode = kvm_s390_stattrib_set_migrationmode;
>> +    sac->get_dirtycount = kvm_s390_stattrib_get_dirtycount;
>> +    sac->synchronize = kvm_s390_stattrib_synchronize;
>> +    sac->get_active = kvm_s390_stattrib_get_active;
>> +}
>> +
>> +static const TypeInfo kvm_s390_stattrib_info = {
>> +    .name          = TYPE_KVM_S390_STATTRIB,
>> +    .parent        = TYPE_S390_STATTRIB,
>> +    .instance_init = kvm_s390_stattrib_instance_init,
>> +    .instance_size = sizeof(KVMS390StAttribState),
>> +    .class_init    = kvm_s390_stattrib_class_init,
>> +    .class_size    = sizeof(S390StAttribClass),
>> +};
>> +
>> +static void kvm_s390_stattrib_register_types(void)
>> +{
>> +    type_register_static(&kvm_s390_stattrib_info);
>> +}
>> +
>> +type_init(kvm_s390_stattrib_register_types)
>> diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
>> new file mode 100644
>> index 0000000..eb41fe9
>> --- /dev/null
>> +++ b/hw/s390x/s390-stattrib.c
>> @@ -0,0 +1,348 @@
>> +/*
>> + * s390 storage attributes device
>> + *
>> + * Copyright 2016 IBM Corp.
>> + * Author(s): Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or (at
>> + * your option) any later version. See the COPYING file in the top-level
>> + * directory.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "hw/boards.h"
>> +#include "migration/qemu-file.h"
>> +#include "migration/register.h"
>> +#include "hw/s390x/storage-attributes.h"
>> +#include "qemu/error-report.h"
>> +#include "sysemu/kvm.h"
>> +#include "exec/ram_addr.h"
>> +#include "qapi/error.h"
>> +
>> +#define CMMA_BLOCK_SIZE  (1 << 10)
>> +
>> +#define STATTR_FLAG_EOS     0x01ULL
>> +#define STATTR_FLAG_MORE    0x02ULL
>> +#define STATTR_FLAG_ERROR   0x04ULL
>> +#define STATTR_FLAG_DONE    0x08ULL
>> +
>> +void s390_stattrib_init(void)
>> +{
>> +    Object *obj;
>> +
>> +#ifdef CONFIG_KVM
>> +    if (kvm_enabled() &&
>> +            kvm_check_extension(kvm_state, KVM_CAP_S390_CMMA_MIGRATION)) {
>> +        obj = object_new(TYPE_KVM_S390_STATTRIB);
>> +    } else {
>> +        obj = object_new(TYPE_QEMU_S390_STATTRIB);
>> +    }
>> +#else
>> +    obj = object_new(TYPE_QEMU_S390_STATTRIB);
>> +#endif
> 
> Could you maybe do something similar as in s390_flic_init() to avoid the
> #ifdefs here?
> 
>> +    object_property_add_child(qdev_get_machine(), TYPE_S390_STATTRIB,
>> +                              obj, NULL);
>> +    object_unref(obj);
>> +
>> +    qdev_init_nofail(DEVICE(obj));
>> +}
> [...]
>> +static int cmma_save(QEMUFile *f, void *opaque, int final)
>> +{
>> +    S390StAttribState *sas = S390_STATTRIB(opaque);
>> +    S390StAttribClass *sac = S390_STATTRIB_GET_CLASS(sas);
>> +    uint8_t *buf;
>> +    int r, cx, reallen = 0, ret = 0;
>> +    uint32_t buflen = 1 << 19;   /* 512kB cover 2GB of guest memory */
>> +    uint64_t start_gfn = sas->migration_cur_gfn;
>> +
>> +    buf = g_try_malloc(buflen);
>> +    if (!buf) {
>> +        error_report("Could not allocate memory to save storage attributes");
>> +        return -ENOMEM;
>> +    }
>> +
>> +    while (final ? 1 : qemu_file_rate_limit(f) == 0) {
>> +        reallen = sac->get_stattr(sas, &start_gfn, buflen, buf);
>> +        if (reallen < 0) {
>> +            g_free(buf);
>> +            return reallen;
>> +        }
>> +
>> +        ret = 1;
>> +        if (0 == reallen) {
> 
> Please, no Yoda conditions. See CODING_STYLE file.
> 
>> +            break;
>> +        }
>> +        qemu_put_be64(f, (start_gfn << TARGET_PAGE_BITS) | STATTR_FLAG_MORE);
>> +        qemu_put_be64(f, reallen);
>> +        for (cx = 0; cx < reallen; cx++) {
>> +            qemu_put_byte(f, buf[cx]);
>> +        }
>> +        if (!sac->get_dirtycount(sas)) {
>> +            break;
>> +        }
>> +    }
>> +
>> +    sas->migration_cur_gfn = start_gfn + reallen;
>> +    g_free(buf);
>> +    if (final) {
>> +        qemu_put_be64(f, STATTR_FLAG_DONE);
>> +    }
>> +    qemu_put_be64(f, STATTR_FLAG_EOS);
>> +
>> +    r = qemu_file_get_error(f);
>> +    if (r < 0) {
>> +        return r;
>> +    }
>> +
>> +    return ret;
>> +}
> [...]
> 
>  Thomas
> 
> 
