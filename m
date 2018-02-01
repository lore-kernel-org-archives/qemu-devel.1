Received: from eggs.gnu.org ([2001:4830:134:3::10]:52334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ehDkJ-00056L-B0
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 07:13:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ehDkD-0007zz-OH
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 07:13:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60240)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ehDkD-0007zE-Fk
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 07:13:33 -0500
Date: Thu, 1 Feb 2018 12:13:25 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180201121324.GD2457@work-vm>
References: <20180129174132.108925-1-brijesh.singh@amd.com>
	<20180129174132.108925-11-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180129174132.108925-11-brijesh.singh@amd.com>
Subject: Re: [Qemu-devel] [PATCH v6 10/23] sev: add command to initialize
 the memory encryption context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brijesh Singh <brijesh.singh@amd.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Tom Lendacky <Thomas.Lendacky@amd.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Eric Blake <eblake@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>

* Brijesh Singh (brijesh.singh@amd.com) wrote:
> When memory encryption is enabled, KVM_SEV_INIT command is used to
> initialize the platform. The command loads the SEV related persistent
> data from non-volatile storage and initializes the platform context.
> This command should be first issued before invoking any other guest
> commands provided by the SEV firmware.

Some minor comments rather than full review.

> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  accel/kvm/kvm-all.c    |  15 ++++++
>  accel/kvm/sev.c        | 124 +++++++++++++++++++++++++++++++++++++++++++++++++
>  accel/kvm/trace-events |   2 +
>  include/sysemu/sev.h   |  10 ++++
>  4 files changed, 151 insertions(+)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index f290f487a573..a9b16846675e 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -38,6 +38,7 @@
>  #include "qemu/event_notifier.h"
>  #include "trace.h"
>  #include "hw/irq.h"
> +#include "sysemu/sev.h"
>  
>  #include "hw/boards.h"
>  
> @@ -103,6 +104,9 @@ struct KVMState
>  #endif
>      KVMMemoryListener memory_listener;
>      QLIST_HEAD(, KVMParkedVcpu) kvm_parked_vcpus;
> +
> +    /* memory encryption */
> +    void *memcrypt_handle;
>  };
>  
>  KVMState *kvm_state;
> @@ -1632,6 +1636,17 @@ static int kvm_init(MachineState *ms)
>  
>      kvm_state = s;
>  
> +    /*
> +     * if memory encryption object is specified then initialize the memory
> +     * encryption context.
> +     * */

Style: should be */

> +    if (ms->memory_encryption) {
> +        kvm_state->memcrypt_handle = sev_guest_init(ms->memory_encryption);
> +        if (!kvm_state->memcrypt_handle) {
> +            goto err;
> +        }
> +    }
> +
>      ret = kvm_arch_init(ms, s);
>      if (ret < 0) {
>          goto err;
> diff --git a/accel/kvm/sev.c b/accel/kvm/sev.c
> index e93fdfeb0c8f..be1791e510b3 100644
> --- a/accel/kvm/sev.c
> +++ b/accel/kvm/sev.c
> @@ -18,10 +18,72 @@
>  #include "sysemu/kvm.h"
>  #include "sysemu/sev.h"
>  #include "sysemu/sysemu.h"
> +#include "trace.h"
>  
>  #define DEFAULT_GUEST_POLICY    0x1 /* disable debug */
>  #define DEFAULT_SEV_DEVICE      "/dev/sev"
>  
> +static int sev_fd;
> +
> +#define SEV_FW_MAX_ERROR      0x17
> +
> +static char sev_fw_errlist[SEV_FW_MAX_ERROR][100] = {

Perhaps:
   static const char *sev_few_errlist[] = {
?

> +    "",
> +    "Platform state is invalid",
> +    "Guest state is invalid",
> +    "Platform configuration is invalid",
> +    "Buffer too small",
> +    "Platform is already owned",
> +    "Certificate is invalid",
> +    "Policy is not allowed",
> +    "Guest is not active",
> +    "Invalid address",
> +    "Bad signature",
> +    "Bad measurement",
> +    "Asid is already owned",
> +    "Invalid ASID",
> +    "WBINVD is required",
> +    "DF_FLUSH is required",
> +    "Guest handle is invalid",
> +    "Invalid command",
> +    "Guest is active",
> +    "Hardware error",
> +    "Hardware unsafe",
> +    "Feature not supported",
> +    "Invalid parameter"
> +};
> +
> +static int
> +sev_ioctl(int cmd, void *data, int *error)
> +{
> +    int r;
> +    struct kvm_sev_cmd input;
> +
> +    memset(&input, 0x0, sizeof(input));
> +
> +    input.id = cmd;
> +    input.sev_fd = sev_fd;
> +    input.data = (__u64)data;
> +
> +    r = kvm_vm_ioctl(kvm_state, KVM_MEMORY_ENCRYPT_OP, &input);
> +
> +    if (error) {
> +        *error = input.error;
> +    }
> +
> +    return r;
> +}
> +
> +static char *
> +fw_error_to_str(int code)
> +{
> +    if (code > SEV_FW_MAX_ERROR) {

I'm trying to convince myself whether that should be >= and whether the
maximum error is really 0x16 ?  Your list up there has 23 entries
so I think trying to access error 0x17 would be bad.

> +        return NULL;

It might be better to return 'No error' or the like unless you're going
to be testing for NULL; that way you never end up with a Null getting
out.

> +    }
> +
> +    return sev_fw_errlist[code];
> +}
> +
>  static void
>  qsev_guest_finalize(Object *obj)
>  {
> @@ -170,6 +232,68 @@ static const TypeInfo qsev_guest_info = {
>      }
>  };
>  
> +static QSevGuestInfo *
> +lookup_sev_guest_info(const char *id)
> +{
> +    Object *obj;
> +    QSevGuestInfo *info;
> +
> +    obj = object_resolve_path_component(object_get_objects_root(), id);
> +    if (!obj) {
> +        return NULL;
> +    }
> +
> +    info = (QSevGuestInfo *)
> +            object_dynamic_cast(obj, TYPE_QSEV_GUEST_INFO);
> +    if (!info) {
> +        return NULL;
> +    }
> +
> +    return info;
> +}
> +
> +void *
> +sev_guest_init(const char *id)
> +{
> +    SEVState *s;
> +    char *devname;
> +    int ret, fw_error;
> +
> +    s = g_malloc0(sizeof(SEVState));

g_new0 is easier.

> +    if (!s) {
> +        return NULL;
> +    }

and allocation aborts rather than returning NULL (unless you use the
_try_ version of g_new)

> +
> +    s->sev_info = lookup_sev_guest_info(id);
> +    if (!s->sev_info) {
> +        error_report("%s: '%s' is not a valid '%s' object",
> +                     __func__, id, TYPE_QSEV_GUEST_INFO);
> +        goto err;
> +    }
> +
> +    devname = object_property_get_str(OBJECT(s->sev_info), "sev-device", NULL);
> +    sev_fd = open(devname, O_RDWR);
> +    if (sev_fd < 0) {
> +        error_report("%s: Failed to open %s '%s'", __func__,
> +                     devname, strerror(errno));
> +        goto err;
> +    }
> +    g_free(devname);
> +
> +    trace_kvm_sev_init();
> +    ret = sev_ioctl(KVM_SEV_INIT, NULL, &fw_error);
> +    if (ret) {
> +        error_report("%s: failed to initialize ret=%d fw_error=%d '%s'",
> +                     __func__, ret, fw_error, fw_error_to_str(fw_error));
> +        goto err;
> +    }
> +
> +    return s;
> +err:
> +    g_free(s);
> +    return NULL;
> +}
> +
>  static void
>  sev_register_types(void)
>  {
> diff --git a/accel/kvm/trace-events b/accel/kvm/trace-events
> index f89ba5578dc1..ea487e5a5913 100644
> --- a/accel/kvm/trace-events
> +++ b/accel/kvm/trace-events
> @@ -13,3 +13,5 @@ kvm_irqchip_add_msi_route(char *name, int vector, int virq) "dev %s vector %d vi
>  kvm_irqchip_update_msi_route(int virq) "Updating MSI route virq=%d"
>  kvm_irqchip_release_virq(int virq) "virq %d"
>  
> +# sev.c
> +kvm_sev_init(void) ""
> diff --git a/include/sysemu/sev.h b/include/sysemu/sev.h
> index d2621a9d1100..6aec25bc05e5 100644
> --- a/include/sysemu/sev.h
> +++ b/include/sysemu/sev.h
> @@ -14,6 +14,8 @@
>  #ifndef QEMU_SEV_H
>  #define QEMU_SEV_H
>  
> +#include <linux/kvm.h>
> +
>  #include "qom/object.h"
>  #include "qapi/error.h"
>  #include "sysemu/kvm.h"
> @@ -49,5 +51,13 @@ struct QSevGuestInfoClass {
>      ObjectClass parent_class;
>  };
>  
> +struct SEVState {
> +    QSevGuestInfo *sev_info;
> +};
> +
> +typedef struct SEVState SEVState;
> +
> +void *sev_guest_init(const char *id);
> +
>  #endif
>  
> -- 
> 2.9.5
> 

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
