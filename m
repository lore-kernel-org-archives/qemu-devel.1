Received: from eggs.gnu.org ([2001:4830:134:3::10]:44021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dQAwK-00057Y-SQ
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 07:15:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dQAwJ-0004HU-Hq
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 07:15:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33940)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dQAwJ-0004H5-9J
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 07:15:19 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9A38C80B56
	for <qemu-devel@nongnu.org>; Wed, 28 Jun 2017 11:15:17 +0000 (UTC)
Date: Wed, 28 Jun 2017 12:15:04 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170628111504.GC2130@work-vm>
References: <20170628095228.4661-1-quintela@redhat.com>
	<20170628095228.4661-4-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170628095228.4661-4-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 3/5] migration: Create
 load_setup()/cleanup() methods
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com, kwolf@redhat.com

* Juan Quintela (quintela@redhat.com) wrote:
> We need to do things at load time and at cleanup time.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> 
> --
> 
> Move the printing of the error message so we can print the device
> giving the error.
> Add call to postcopy stuff
> ---
>  include/migration/register.h |  2 ++
>  migration/savevm.c           | 45 +++++++++++++++++++++++++++++++++++++++++++-
>  migration/savevm.h           |  1 +
>  migration/trace-events       |  2 ++
>  4 files changed, 49 insertions(+), 1 deletion(-)
> 
> diff --git a/include/migration/register.h b/include/migration/register.h
> index 938ea2b..a0f1edd 100644
> --- a/include/migration/register.h
> +++ b/include/migration/register.h
> @@ -39,6 +39,8 @@ typedef struct SaveVMHandlers {
>                                uint64_t *non_postcopiable_pending,
>                                uint64_t *postcopiable_pending);
>      LoadStateHandler *load_state;
> +    int (*load_setup)(QEMUFile *f, void *opaque);
> +    int (*load_cleanup)(void *opaque);
>  } SaveVMHandlers;
>  
>  int register_savevm_live(DeviceState *dev,
> diff --git a/migration/savevm.c b/migration/savevm.c
> index fee11c5..fdd15fa 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1541,7 +1541,7 @@ static void *postcopy_ram_listen_thread(void *opaque)
>       * got a bad migration state).
>       */
>      migration_incoming_state_destroy();
> -
> +    qemu_loadvm_state_cleanup();

Is that order right? It seems wrong to call the cleanup
code after MIS is destroyed.
(The precopy path seems to call mis_destroy at the end of
process_incoming_migration_bh which is much later).

Dave

>      return NULL;
>  }
> @@ -1901,6 +1901,44 @@ qemu_loadvm_section_part_end(QEMUFile *f, MigrationIncomingState *mis)
>      return 0;
>  }
>  
> +static int qemu_loadvm_state_setup(QEMUFile *f)
> +{
> +    SaveStateEntry *se;
> +    int ret;
> +
> +    trace_loadvm_state_setup();
> +    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
> +        if (!se->ops || !se->ops->load_setup) {
> +            continue;
> +        }
> +        if (se->ops && se->ops->is_active) {
> +            if (!se->ops->is_active(se->opaque)) {
> +                continue;
> +            }
> +        }
> +
> +        ret = se->ops->load_setup(f, se->opaque);
> +        if (ret < 0) {
> +            qemu_file_set_error(f, ret);
> +            error_report("Load state of device %s failed", se->idstr);
> +            return ret;
> +        }
> +    }
> +    return 0;
> +}
> +
> +void qemu_loadvm_state_cleanup(void)
> +{
> +    SaveStateEntry *se;
> +
> +    trace_loadvm_state_cleanup();
> +    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
> +        if (se->ops && se->ops->load_cleanup) {
> +            se->ops->load_cleanup(se->opaque);
> +        }
> +    }
> +}
> +
>  static int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis)
>  {
>      uint8_t section_type;
> @@ -1973,6 +2011,10 @@ int qemu_loadvm_state(QEMUFile *f)
>          return -ENOTSUP;
>      }
>  
> +    if (qemu_loadvm_state_setup(f) != 0) {
> +        return -EINVAL;
> +    }
> +
>      if (migrate_get_current()->send_configuration) {
>          if (qemu_get_byte(f) != QEMU_VM_CONFIGURATION) {
>              error_report("Configuration section missing");
> @@ -2036,6 +2078,7 @@ int qemu_loadvm_state(QEMUFile *f)
>          }
>      }
>  
> +    qemu_loadvm_state_cleanup();
>      cpu_synchronize_all_post_init();
>  
>      return ret;
> diff --git a/migration/savevm.h b/migration/savevm.h
> index 6babc62..295c4a1 100644
> --- a/migration/savevm.h
> +++ b/migration/savevm.h
> @@ -53,5 +53,6 @@ void qemu_savevm_send_postcopy_ram_discard(QEMUFile *f, const char *name,
>                                             uint64_t *length_list);
>  
>  int qemu_loadvm_state(QEMUFile *f);
> +void qemu_loadvm_state_cleanup(void);
>  
>  #endif
> diff --git a/migration/trace-events b/migration/trace-events
> index 9669e94..cb2c4b5 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -7,6 +7,8 @@ qemu_loadvm_state_section_partend(uint32_t section_id) "%u"
>  qemu_loadvm_state_post_main(int ret) "%d"
>  qemu_loadvm_state_section_startfull(uint32_t section_id, const char *idstr, uint32_t instance_id, uint32_t version_id) "%u(%s) %u %u"
>  qemu_savevm_send_packaged(void) ""
> +loadvm_state_setup(void) ""
> +loadvm_state_cleanup(void) ""
>  loadvm_handle_cmd_packaged(unsigned int length) "%u"
>  loadvm_handle_cmd_packaged_main(int ret) "%d"
>  loadvm_handle_cmd_packaged_received(int ret) "%d"
> -- 
> 2.9.4
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
