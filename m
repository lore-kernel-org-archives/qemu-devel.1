Received: from eggs.gnu.org ([2001:4830:134:3::10]:59293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dLvSG-0005sk-5T
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 13:54:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dLvSF-0006IF-9c
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 13:54:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55626)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dLvSF-0006IA-09
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 13:54:43 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CF9F764DAC
	for <qemu-devel@nongnu.org>; Fri, 16 Jun 2017 17:54:41 +0000 (UTC)
Date: Fri, 16 Jun 2017 18:54:18 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170616175417.GD19805@work-vm>
References: <20170613095338.11560-1-quintela@redhat.com>
	<20170613095338.11560-4-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170613095338.11560-4-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/5] migration: Create
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
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com, kwolf@redhat.com, stefanha@redhat.com

* Juan Quintela (quintela@redhat.com) wrote:
> We need to do things at load time and at cleanup time.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  include/migration/register.h |  2 ++
>  migration/savevm.c           | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  migration/trace-events       |  2 ++
>  3 files changed, 48 insertions(+)
> 
> diff --git a/include/migration/register.h b/include/migration/register.h
> index 9ad1e4c..4b5c0e0 100644
> --- a/include/migration/register.h
> +++ b/include/migration/register.h
> @@ -42,6 +42,8 @@ typedef struct SaveVMHandlers {
>                                uint64_t *non_postcopiable_pending,
>                                uint64_t *postcopiable_pending);
>      LoadStateHandler *load_state;
> +    int (*load_setup)(QEMUFile *f, void *opaque);
> +    int (*load_cleanup)(void *opaque);
>  } SaveVMHandlers;
>  
>  int register_savevm_live(DeviceState *dev,
> diff --git a/migration/savevm.c b/migration/savevm.c
> index fb93931..ed36f35 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1912,6 +1912,43 @@ qemu_loadvm_section_part_end(QEMUFile *f, MigrationIncomingState *mis)
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
> +            return ret;
> +        }
> +    }
> +    return 0;
> +}
> +
> +static void qemu_loadvm_state_cleanup(void)
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
> @@ -1984,6 +2021,12 @@ int qemu_loadvm_state(QEMUFile *f)
>          return -ENOTSUP;
>      }
>  
> +
> +    if (qemu_loadvm_state_setup(f) != 0) {
> +        error_report("Load state of one device failed");
> +        return -EINVAL;

I'd prefer if that was an error report in qemu_loadvm_state_setup,
because then it would be easy to print the device name rather than
'one'.

Dave
> +    }
> +
>      if (!savevm_state.skip_configuration || enforce_config_section()) {
>          if (qemu_get_byte(f) != QEMU_VM_CONFIGURATION) {
>              error_report("Configuration section missing");
> @@ -2047,6 +2090,7 @@ int qemu_loadvm_state(QEMUFile *f)
>          }
>      }
>  
> +    qemu_loadvm_state_cleanup();
>      cpu_synchronize_all_post_init();
>  
>      return ret;
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
