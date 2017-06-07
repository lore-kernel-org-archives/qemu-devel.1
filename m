Received: from eggs.gnu.org ([2001:4830:134:3::10]:40002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dIaIo-0000Fg-Dx
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 08:43:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dIaIj-0008SL-M1
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 08:43:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47900)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dIaIj-0008SB-GU
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 08:43:05 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1496828798-27548-7-git-send-email-a.perevalov@samsung.com>
	(Alexey Perevalov's message of "Wed, 07 Jun 2017 12:46:33 +0300")
References: <1496828798-27548-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170607094729eucas1p119b3d77f7d869eb06c16c9e91215e8cd@eucas1p1.samsung.com>
	<1496828798-27548-7-git-send-email-a.perevalov@samsung.com>
Reply-To: quintela@redhat.com
Date: Wed, 07 Jun 2017 14:43:00 +0200
Message-ID: <87tw3sezor.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v8 06/11] migration: add postcopy blocktime
 ctx into MigrationIncomingState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Perevalov <a.perevalov@samsung.com>
Cc: qemu-devel@nongnu.org, i.maximets@samsung.com, peterx@redhat.com, dgilbert@redhat.com

Alexey Perevalov <a.perevalov@samsung.com> wrote:
> This patch adds request to kernel space for UFFD_FEATURE_THREAD_ID,
> in case when this feature is provided by kernel.
>

I think this function is wrong

> +static void migration_exit_cb(Notifier *n, void *data)
> +{
> +    PostcopyBlocktimeContext *ctx = container_of(n, PostcopyBlocktimeContext,
> +                                                 exit_notifier);
> +    destroy_blocktime_context(ctx);
> +}
> +
> +static struct PostcopyBlocktimeContext *blocktime_context_new(void)
> +{
> +    PostcopyBlocktimeContext *ctx = g_new0(PostcopyBlocktimeContext, 1);
> +    ctx->page_fault_vcpu_time = g_new0(int64_t, smp_cpus);
> +    ctx->vcpu_addr = g_new0(uint64_t, smp_cpus);
> +    ctx->vcpu_blocktime = g_new0(int64_t, smp_cpus);
> +
> +    ctx->exit_notifier.notify = migration_exit_cb;
> +    qemu_add_exit_notifier(&ctx->exit_notifier);
> +    add_migration_state_change_notifier(&ctx->postcopy_notifier);

Or you don't want to call it this awy.

This will destroy the context at every migration state change.

Or I am missing something here?  Look at ui/spice-core.c to see how to
use it only for some states (I guess you will need to do it for
error/cleanup/completion changes only).

Later, Juan.

> +    return ctx;
> +}
>  
>  /**
>   * receive_ufd_features: check userfault fd features, to request only supported
> @@ -155,6 +207,19 @@ static bool ufd_check_and_apply(int ufd, MigrationIncomingState *mis)
>          }
>      }
>  
> +#ifdef UFFD_FEATURE_THREAD_ID
> +    if (migrate_postcopy_blocktime() && mis &&
> +        UFFD_FEATURE_THREAD_ID & supported_features) {
> +        /* kernel supports that feature */
> +        /* don't create blocktime_context if it exists */
> +        if (!mis->blocktime_ctx) {
> +            mis->blocktime_ctx = blocktime_context_new();
> +        }
> +
> +        asked_features |= UFFD_FEATURE_THREAD_ID;
> +    }
> +#endif
> +
>      /*
>       * request features, even if asked_features is 0, due to
>       * kernel expects UFFD_API before UFFDIO_REGISTER, per
