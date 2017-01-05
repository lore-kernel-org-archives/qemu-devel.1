Received: from eggs.gnu.org ([2001:4830:134:3::10]:56298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cP7Uh-0001o3-6C
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 07:50:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cP7Uc-0003ZT-B8
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 07:50:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35998)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cP7Uc-0003Yc-2l
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 07:50:06 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1ACE93D944
	for <qemu-devel@nongnu.org>; Thu,  5 Jan 2017 12:50:05 +0000 (UTC)
Date: Thu, 5 Jan 2017 12:49:59 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170105124958.GC2332@work-vm>
References: <1483610987-24331-1-git-send-email-peterx@redhat.com>
	<1483610987-24331-2-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1483610987-24331-2-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] migration: allow to prioritize save
 state entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>, Jason Wang <jasowang@redhat.com>, mst@redhat.com, Amit Shah <amit.shah@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

* Peter Xu (peterx@redhat.com) wrote:
> During migration, save state entries are saved/loaded without a specific
> order - we just traverse the savevm_state.handlers list and do it one by
> one. This might not be enough in the future.
> 
> There is case that we need to load specific device's vmstate first
> before others. For example, VT-d IOMMU contains DMA address remapping
> information, which is required by all the PCI devices to do address
> translations. We need to make sure IOMMU's device state is loaded before
> the rest of the PCI devices, so that DMA address translation can work
> properly.
> 
> This patch provide a VMStateDescription.priority value to allow specify
> the priority of the saved states. The loadvm operation will be done with
> those devices with higher vmsd priority.
> 
> Current ordering logic is still naive and slow, but after all that's not
> a critical path so IMO it's a workable solution for now.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/migration/vmstate.h |  1 +
>  migration/savevm.c          | 27 +++++++++++++++++++++++----
>  2 files changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index 1638ee5..dd5e26a 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -207,6 +207,7 @@ struct VMStateDescription {
>      int version_id;
>      int minimum_version_id;
>      int minimum_version_id_old;
> +    int priority;

Would it be possible to make this an 'enum' and define
a migration_priority_default  then you can add
your migration_priority_iommu  rather than the magic '100';
so we'd then end up with something like:

enum migration_priority {
   migration_priority_default = 0,
   migration_priority_iommu,       /* Must happen before PCI devices */
}

and that way we'd have one place where we could see all
the priorities next to each other.

I know there are some other existing ordering requirements that happen
to work because of the order devices are created - however
I dont think they're documented anywhere and I don't think any one knows
them all!

Dave

>      LoadStateHandler *load_state_old;
>      int (*pre_load)(void *opaque);
>      int (*post_load)(void *opaque, int version_id);
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 0363372..93a2837 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -257,6 +257,7 @@ typedef struct SaveStateEntry {
>      void *opaque;
>      CompatEntry *compat;
>      int is_ram;
> +    int priority;
>  } SaveStateEntry;
>  
>  typedef struct SaveState {
> @@ -532,6 +533,23 @@ static int calculate_compat_instance_id(const char *idstr)
>      return instance_id;
>  }
>  
> +static void savevm_state_handler_insert(SaveStateEntry *nse)
> +{
> +    SaveStateEntry *se;
> +
> +    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
> +        if (se->priority < nse->priority) {
> +            break;
> +        }
> +    }
> +
> +    if (se) {
> +        QTAILQ_INSERT_BEFORE(se, nse, entry);
> +    } else {
> +        QTAILQ_INSERT_TAIL(&savevm_state.handlers, nse, entry);
> +    }
> +}
> +
>  /* TODO: Individual devices generally have very little idea about the rest
>     of the system, so instance_id should be removed/replaced.
>     Meanwhile pass -1 as instance_id if you do not already have a clearly
> @@ -551,6 +569,8 @@ int register_savevm_live(DeviceState *dev,
>      se->ops = ops;
>      se->opaque = opaque;
>      se->vmsd = NULL;
> +    se->priority = 0;
> +
>      /* if this is a live_savem then set is_ram */
>      if (ops->save_live_setup != NULL) {
>          se->is_ram = 1;
> @@ -578,8 +598,7 @@ int register_savevm_live(DeviceState *dev,
>          se->instance_id = instance_id;
>      }
>      assert(!se->compat || se->instance_id == 0);
> -    /* add at the end of list */
> -    QTAILQ_INSERT_TAIL(&savevm_state.handlers, se, entry);
> +    savevm_state_handler_insert(se);
>      return 0;
>  }
>  
> @@ -639,6 +658,7 @@ int vmstate_register_with_alias_id(DeviceState *dev, int instance_id,
>      se->opaque = opaque;
>      se->vmsd = vmsd;
>      se->alias_id = alias_id;
> +    se->priority = vmsd->priority;
>  
>      if (dev) {
>          char *id = qdev_get_dev_path(dev);
> @@ -662,8 +682,7 @@ int vmstate_register_with_alias_id(DeviceState *dev, int instance_id,
>          se->instance_id = instance_id;
>      }
>      assert(!se->compat || se->instance_id == 0);
> -    /* add at the end of list */
> -    QTAILQ_INSERT_TAIL(&savevm_state.handlers, se, entry);
> +    savevm_state_handler_insert(se);
>      return 0;
>  }
>  
> -- 
> 2.7.4
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
