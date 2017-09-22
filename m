Received: from eggs.gnu.org ([2001:4830:134:3::10]:37454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dvLxp-0003z4-0R
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 07:17:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dvLxl-00064f-0J
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 07:17:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44806)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dvLxk-00064M-NX
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 07:17:40 -0400
Date: Fri, 22 Sep 2017 12:17:33 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170922111733.GG2620@work-vm>
References: <1504081950-2528-1-git-send-email-peterx@redhat.com>
	<1504081950-2528-24-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1504081950-2528-24-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC v2 23/33] migration: introduce
 SaveVMHandlers.resume_prepare
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>

* Peter Xu (peterx@redhat.com) wrote:
> This is hook function to be called when a postcopy migration wants to
> resume from a failure. For each module, it should provide its own
> recovery logic before we switch to the postcopy-active state.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  include/migration/register.h |  2 ++
>  migration/migration.c        | 20 +++++++++++++++++++-
>  migration/savevm.c           | 25 +++++++++++++++++++++++++
>  migration/savevm.h           |  1 +
>  migration/trace-events       |  1 +
>  5 files changed, 48 insertions(+), 1 deletion(-)
> 
> diff --git a/include/migration/register.h b/include/migration/register.h
> index a0f1edd..b669362 100644
> --- a/include/migration/register.h
> +++ b/include/migration/register.h
> @@ -41,6 +41,8 @@ typedef struct SaveVMHandlers {
>      LoadStateHandler *load_state;
>      int (*load_setup)(QEMUFile *f, void *opaque);
>      int (*load_cleanup)(void *opaque);
> +    /* Called when postcopy migration wants to resume from failure */
> +    int (*resume_prepare)(MigrationState *s, void *opaque);
>  } SaveVMHandlers;
>  
>  int register_savevm_live(DeviceState *dev,
> diff --git a/migration/migration.c b/migration/migration.c
> index 4dc564a..19b7f3a5 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2172,7 +2172,25 @@ typedef enum MigThrError {
>  /* Return zero if success, or <0 for error */
>  static int postcopy_do_resume(MigrationState *s)
>  {
> -    /* TODO: do the resume logic */
> +    int ret;
> +
> +    /*
> +     * Call all the resume_prepare() hooks, so that modules can be
> +     * ready for the migration resume.
> +     */
> +    ret = qemu_savevm_state_resume_prepare(s);
> +    if (ret) {
> +        error_report("%s: resume_prepare() failure detected: %d",
> +                     __func__, ret);
> +        return ret;
> +    }
> +
> +    /*
> +     * TODO: handshake with dest using MIG_CMD_RESUME,
> +     * MIG_RP_MSG_RESUME_ACK, then switch source state to
> +     * "postcopy-active"
> +     */
> +
>      return 0;
>  }
>  
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 7fd5390..b86c9c6 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1004,6 +1004,31 @@ void qemu_savevm_state_setup(QEMUFile *f)
>      }
>  }
>  
> +int qemu_savevm_state_resume_prepare(MigrationState *s)
> +{
> +    SaveStateEntry *se;
> +    int ret;
> +
> +    trace_savevm_state_resume_prepare();
> +
> +    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
> +        if (!se->ops || !se->ops->resume_prepare) {
> +            continue;
> +        }
> +        if (se->ops && se->ops->is_active) {
> +            if (!se->ops->is_active(se->opaque)) {
> +                continue;
> +            }
> +        }
> +        ret = se->ops->resume_prepare(s, se->opaque);
> +        if (ret < 0) {
> +            return ret;
> +        }
> +    }
> +
> +    return 0;
> +}
> +
>  /*
>   * this function has three return values:
>   *   negative: there was one error, and we have -errno.
> diff --git a/migration/savevm.h b/migration/savevm.h
> index a5f3879..3193f04 100644
> --- a/migration/savevm.h
> +++ b/migration/savevm.h
> @@ -31,6 +31,7 @@
>  
>  bool qemu_savevm_state_blocked(Error **errp);
>  void qemu_savevm_state_setup(QEMUFile *f);
> +int qemu_savevm_state_resume_prepare(MigrationState *s);
>  void qemu_savevm_state_header(QEMUFile *f);
>  int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy);
>  void qemu_savevm_state_cleanup(void);
> diff --git a/migration/trace-events b/migration/trace-events
> index a929bc7..61b0d49 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -38,6 +38,7 @@ savevm_send_postcopy_run(void) ""
>  savevm_send_postcopy_resume(void) ""
>  savevm_send_recv_bitmap(char *name) "%s"
>  savevm_state_setup(void) ""
> +savevm_state_resume_prepare(void) ""
>  savevm_state_header(void) ""
>  savevm_state_iterate(void) ""
>  savevm_state_cleanup(void) ""
> -- 
> 2.7.4
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
