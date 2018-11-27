Received: from eggs.gnu.org ([2001:4830:134:3::10]:53376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1gRciN-00047A-If
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 07:43:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1gRciK-0003dY-7v
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 07:43:43 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47834)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1gRciK-0003Z9-06
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 07:43:40 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wARCcOwr011394
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 07:43:33 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2p14a35a8t-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 07:43:33 -0500
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 27 Nov 2018 12:43:30 -0000
References: <20181127114102.4319-1-david@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 27 Nov 2018 13:43:24 +0100
MIME-Version: 1.0
In-Reply-To: <20181127114102.4319-1-david@redhat.com>
Content-Language: en-US
Message-Id: <f31fb9d1-d1dd-7d06-7993-08e44bb77632@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1] s390x/tod: properly stop the KVM TOD
 while the guest is not running
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>

On 27.11.2018 12:41, David Hildenbrand wrote:
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
> So whenever the guest stops, backup the KVM TOD. When continuning to run
> the guest, restore the KVM TOD.

We do a similar thing for managedsave so it probably makes sense to solve
the stall warnings. Now: At the same time, we actually want to have the guest
see the real time and maybe even share the TOD clock with the host in some
way, while at the same time avoid the stall warnings.

One idea is to signal the guest on migration (and stop start events) and let
the guest do a time sync with the host.
In fact, it seems that by architecture we need to signal a special sclp signal 
anyway if stsi information would change (e.g. on migration). Maybe we can 
piggyback on that and do some time sync interface in the future.
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
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/s390x/tod-kvm.c     | 88 +++++++++++++++++++++++++++++++++++++++++-
>  include/hw/s390x/tod.h |  7 +++-
>  2 files changed, 92 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/s390x/tod-kvm.c b/hw/s390x/tod-kvm.c
> index df564ab89c..d4b12e1145 100644
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
> @@ -38,6 +49,58 @@ static void kvm_s390_tod_set(S390TODState *td, const S390TOD *tod, Error **errp)
>      if (r) {
>          error_setg(errp, "Unable to set KVM guest TOD clock: %s",
>                     strerror(-r));
> +        return;
> +    }
> +}
> +
> +static void kvm_s390_tod_set(S390TODState *td, const S390TOD *tod, Error **errp)
> +{
> +    Error *local_err = NULL;
> +
> +    /*
> +     * Somebody (e.g. migration) set the TOD. We'll store it into KVM to
> +     * properly detect errors now but take a look at the runstate to decide
> +     * whether really to keep the tod running. E.g. during migration, this
> +     * is the point where we want to stop the inititally running TOD to fire
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
> +        /* set the old TOD when running the VM - start the TOD clock */
> +        kvm_s390_set_tod_raw(&td->base, &local_err);
> +        if (local_err) {
> +            warn_report_err(local_err);
> +        }
> +        /* Treat errors like the TOD was running all the time. */
> +        td->stopped = false;
> +    } else if (!running && !td->stopped) {
> +        /* store the TOD when stopping the VM - stop the TOD clock */
> +        kvm_s390_get_tod_raw(&td->base, &local_err);
> +        if (local_err) {
> +            /* keep the TOD running in case we could not back it up */
> +            warn_report_err(local_err);
> +        } else {
> +            td->stopped = true;
> +        }
>      }
>  }
>  
> @@ -49,10 +112,31 @@ static void kvm_s390_tod_class_init(ObjectClass *oc, void *data)
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
> +
> +    /*
> +     * We need to know when the VM gets started/stopped to start/stop the TOD.
> +     * As we can never have more than one TOD instance (and that will never be
> +     * removed), registering here and never unregistering is good enough.
> +     */
> +    qemu_add_vm_change_state_handler(kvm_s390_tod_vm_state_change, td);
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
> index 413c0d7c02..30558d4386 100644
> --- a/include/hw/s390x/tod.h
> +++ b/include/hw/s390x/tod.h
> @@ -31,8 +31,13 @@ typedef struct S390TODState {
>      /* private */
>      DeviceState parent_obj;
>  
> -    /* unused by KVM implementation */
> +    /*
> +     * Used by TCG remember the time base. Used by KVM to backup the TOD
> +     * while the TOD is stopped.
> +     */
>      S390TOD base;
> +    /* Used by KVM to remember if the TOD is stopped and base is valid. */
> +    bool stopped;
>  } S390TODState;
>  
>  typedef struct S390TODClass {
> 
