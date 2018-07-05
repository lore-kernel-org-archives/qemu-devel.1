Received: from eggs.gnu.org ([2001:4830:134:3::10]:37839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fb24s-0002OP-3Z
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 07:05:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fb24o-0002tj-SY
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 07:05:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59488 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fb24o-0002rq-C0
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 07:05:30 -0400
Date: Thu, 5 Jul 2018 12:05:26 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180705110525.GL2538@work-vm>
References: <1528106113-32692-1-git-send-email-lidongchen@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528106113-32692-1-git-send-email-lidongchen@tencent.com>
Subject: Re: [Qemu-devel] [PATCH] migration: release MigrationIncomingState
 in migration_object_finalize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lidong Chen <jemmy858585@gmail.com>
Cc: quintela@redhat.com, qemu-devel@nongnu.org, Lidong Chen <lidongchen@tencent.com>

* Lidong Chen (jemmy858585@gmail.com) wrote:
> Qemu initialize the MigrationIncomingState structure in migration_object_init,
> but not release it. this patch release it in migration_object_finalize.
> 
> Signed-off-by: Lidong Chen <lidongchen@tencent.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/migration.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 05aec2c..e009a05 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -156,6 +156,13 @@ void migration_object_init(void)
>  void migration_object_finalize(void)
>  {
>      object_unref(OBJECT(current_migration));
> +
> +    qemu_sem_destroy(&current_incoming->postcopy_pause_sem_fault);
> +    qemu_sem_destroy(&current_incoming->postcopy_pause_sem_dst);
> +    qemu_event_destroy(&current_incoming->main_thread_load_event);
> +    qemu_mutex_destroy(&current_incoming->rp_mutex);
> +    g_array_free(current_incoming->postcopy_remote_fds, true);
> +    g_free(current_incoming);
>  }
>  
>  /* For outgoing */
> -- 
> 1.8.3.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
