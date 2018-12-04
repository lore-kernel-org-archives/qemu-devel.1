Received: from eggs.gnu.org ([2001:4830:134:3::10]:37398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1gU63J-0000vm-0a
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 03:27:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1gU63F-0002XA-RY
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 03:27:33 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52038
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1gU63F-0002WT-MB
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 03:27:29 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wB48PUSF031980
	for <qemu-devel@nongnu.org>; Tue, 4 Dec 2018 03:27:28 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2p5ntrgs8e-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 04 Dec 2018 03:27:28 -0500
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 4 Dec 2018 08:27:26 -0000
From: Christian Borntraeger <borntraeger@de.ibm.com>
References: <20181130094957.4121-1-david@redhat.com>
Date: Tue, 4 Dec 2018 09:27:21 +0100
MIME-Version: 1.0
In-Reply-To: <20181130094957.4121-1-david@redhat.com>
Content-Language: en-US
Message-Id: <b1bd36ca-f0e0-4973-86b8-6dc8b2c0e4b5@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3] s390x/tod: Properly stop the KVM TOD while
 the guest is not running
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>

On 30.11.2018 10:49, David Hildenbrand wrote:
> Just like on other architectures, we should stop the clock while the guest
> is not running. This is already properly done for TCG. Right now, doing an
> offline migration (stop, migrate, cont) can easily trigger stalls in the
> guest.
> 
> Even doing a
>     (hmp) stop
>     ... wait 2 minutes ...
>     (hmp) cont
> will already trigger stalls.
> 
> So whenever the guest stops, backup the KVM TOD. When continuing to run
> the guest, restore the KVM TOD.
> 
> One special case is starting a simple VM: Reading the TOD from KVM to
> stop it right away until the guest is actually started means that the
> time of any simple VM will already differ to the host time. We can
> simply leave the TOD running and the guest won't be able to recognize
> it.
> 
> For migration, we actually want to keep the TOD stopped until really
> starting the guest. To be able to catch most errors, we should however
> try to set the TOD in addition to simply storing it. So we can still
> catch basic migration problems.
> 
> If anything goes wrong while backing up/restoring the TOD, we have to
> ignore it (but print a warning). This is then basically a fallback to
> old behavior (TOD remains running).
> 
> I tested this very basically with an initrd:
>     1. Start a simple VM. Observed that the TOD is kept running. Old
>        behavior.
>     2. Ordinary live migration. Observed that the TOD is temporarily
>        stopped on the destination when setting the new value and
>        correctly started when finally starting the guest.
>     3. Offline live migration. (stop, migrate, cont). Observed that the
>        TOD will be stopped on the source with the "stop" command. On the
>        destination, the TOD is temporarily stopped when setting the new
>        value and correctly started when finally starting the guest via
>        "cont".
>     4. Simple stop/cont correctly stops/starts the TOD. (multiple stops
>        or conts in a row have no effect, so works as expected)
> 
> In the future, we might want to send the guest a special kind of time sync
> interrupt under some conditions, so it can synchronize its tod to the
> host tod. This is interesting for migration scenarios but also when we
> get time sync interrupts ourselves. This however will most probably have
> to be handled in KVM (e.g. when the tods differ too much) and is not
> desired e.g. when debugging the guest. (single stepping should not
> result in permanent time syncs). I consider something like that an add-on
> on top of this basic "don't break the guest" handling.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>


Long time we should really work on getting the guest back in sync with the host
TOD (e..g on migration) since there are some advanced mechanisms that rely on all
clocks to be in sync. For example the dasd I/O will also write time stamps
and in an stp complex (synced time across CECs) this can be useful for "classic"
mainframe databases and ordering.



It is probably the right thing to do as of today as on migration we are also out
of sync.

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>

Adding Viktor in case he has concerns.


> ---
> 
> v2 -> v3:
> - use device_class_set_parent_realize() to implement a child realize
>   function
> 
>  hw/s390x/tod-kvm.c     | 102 ++++++++++++++++++++++++++++++++++++++++-
>  include/hw/s390x/tod.h |   8 +++-
>  2 files changed, 107 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/s390x/tod-kvm.c b/hw/s390x/tod-kvm.c
> index df564ab89c..2456bf7b24 100644
> --- a/hw/s390x/tod-kvm.c
> +++ b/hw/s390x/tod-kvm.c
> @@ -10,10 +10,11 @@
>  
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
> +#include "sysemu/sysemu.h"
>  #include "hw/s390x/tod.h"
>  #include "kvm_s390x.h"
>  
> -static void kvm_s390_tod_get(const S390TODState *td, S390TOD *tod, Error **errp)
> +static void kvm_s390_get_tod_raw(S390TOD *tod, Error **errp)
>  {
>      int r;
>  
> @@ -27,7 +28,17 @@ static void kvm_s390_tod_get(const S390TODState *td, S390TOD *tod, Error **errp)
>      }
>  }
>  
> -static void kvm_s390_tod_set(S390TODState *td, const S390TOD *tod, Error **errp)
> +static void kvm_s390_tod_get(const S390TODState *td, S390TOD *tod, Error **errp)
> +{
> +    if (td->stopped) {
> +        *tod = td->base;
> +        return;
> +    }
> +
> +    kvm_s390_get_tod_raw(tod, errp);
> +}
> +
> +static void kvm_s390_set_tod_raw(const S390TOD *tod, Error **errp)
>  {
>      int r;
>  
> @@ -41,18 +52,105 @@ static void kvm_s390_tod_set(S390TODState *td, const S390TOD *tod, Error **errp)
>      }
>  }
>  
> +static void kvm_s390_tod_set(S390TODState *td, const S390TOD *tod, Error **errp)
> +{
> +    Error *local_err = NULL;
> +
> +    /*
> +     * Somebody (e.g. migration) set the TOD. We'll store it into KVM to
> +     * properly detect errors now but take a look at the runstate to decide
> +     * whether really to keep the tod running. E.g. during migration, this
> +     * is the point where we want to stop the initially running TOD to fire
> +     * it back up when actually starting the migrated guest.
> +     */
> +    kvm_s390_set_tod_raw(tod, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +
> +    if (runstate_is_running()) {
> +        td->stopped = false;
> +    } else {
> +        td->stopped = true;
> +        td->base = *tod;
> +    }
> +}
> +
> +static void kvm_s390_tod_vm_state_change(void *opaque, int running,
> +                                         RunState state)
> +{
> +    S390TODState *td = opaque;
> +    Error *local_err = NULL;
> +
> +    if (running && td->stopped) {
> +        /* Set the old TOD when running the VM - start the TOD clock. */
> +        kvm_s390_set_tod_raw(&td->base, &local_err);
> +        if (local_err) {
> +            warn_report_err(local_err);
> +        }
> +        /* Treat errors like the TOD was running all the time. */
> +        td->stopped = false;
> +    } else if (!running && !td->stopped) {
> +        /* Store the TOD when stopping the VM - stop the TOD clock. */
> +        kvm_s390_get_tod_raw(&td->base, &local_err);
> +        if (local_err) {
> +            /* Keep the TOD running in case we could not back it up. */
> +            warn_report_err(local_err);
> +        } else {
> +            td->stopped = true;
> +        }
> +    }
> +}
> +
> +static void kvm_s390_tod_realize(DeviceState *dev, Error **errp)
> +{
> +    S390TODState *td = S390_TOD(dev);
> +    S390TODClass *tdc = S390_TOD_GET_CLASS(td);
> +    Error *local_err = NULL;
> +
> +    tdc->parent_realize(dev, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +
> +    /*
> +     * We need to know when the VM gets started/stopped to start/stop the TOD.
> +     * As we can never have more than one TOD instance (and that will never be
> +     * removed), registering here and never unregistering is good enough.
> +     */
> +    qemu_add_vm_change_state_handler(kvm_s390_tod_vm_state_change, td);
> +}
> +
>  static void kvm_s390_tod_class_init(ObjectClass *oc, void *data)
>  {
>      S390TODClass *tdc = S390_TOD_CLASS(oc);
>  
> +    device_class_set_parent_realize(DEVICE_CLASS(oc), kvm_s390_tod_realize,
> +                                    &tdc->parent_realize);
>      tdc->get = kvm_s390_tod_get;
>      tdc->set = kvm_s390_tod_set;
>  }
>  
> +static void kvm_s390_tod_init(Object *obj)
> +{
> +    S390TODState *td = S390_TOD(obj);
> +
> +    /*
> +     * The TOD is initially running (value stored in KVM). Avoid needless
> +     * loading/storing of the TOD when starting a simple VM, so let it
> +     * run although the (never started) VM is stopped. For migration, we
> +     * will properly set the TOD later.
> +     */
> +    td->stopped = false;
> +}
> +
>  static TypeInfo kvm_s390_tod_info = {
>      .name = TYPE_KVM_S390_TOD,
>      .parent = TYPE_S390_TOD,
>      .instance_size = sizeof(S390TODState),
> +    .instance_init = kvm_s390_tod_init,
>      .class_init = kvm_s390_tod_class_init,
>      .class_size = sizeof(S390TODClass),
>  };
> diff --git a/include/hw/s390x/tod.h b/include/hw/s390x/tod.h
> index 413c0d7c02..cbd7552e7a 100644
> --- a/include/hw/s390x/tod.h
> +++ b/include/hw/s390x/tod.h
> @@ -31,13 +31,19 @@ typedef struct S390TODState {
>      /* private */
>      DeviceState parent_obj;
>  
> -    /* unused by KVM implementation */
> +    /*
> +     * Used by TCG to remember the time base. Used by KVM to backup the TOD
> +     * while the TOD is stopped.
> +     */
>      S390TOD base;
> +    /* Used by KVM to remember if the TOD is stopped and base is valid. */
> +    bool stopped;
>  } S390TODState;
>  
>  typedef struct S390TODClass {
>      /* private */
>      DeviceClass parent_class;
> +    void (*parent_realize)(DeviceState *dev, Error **errp);
>  
>      /* public */
>      void (*get)(const S390TODState *td, S390TOD *tod, Error **errp);
> 
