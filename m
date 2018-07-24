Received: from eggs.gnu.org ([2001:4830:134:3::10]:60298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fhxS7-0006MV-0A
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 09:34:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fhxS3-00005u-1M
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 09:34:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53968 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fhxS2-00005i-RN
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 09:34:06 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1532434585-14732-2-git-send-email-lidongchen@tencent.com>
	(Lidong Chen's message of "Tue, 24 Jul 2018 20:16:25 +0800")
References: <1532434585-14732-1-git-send-email-lidongchen@tencent.com>
	<1532434585-14732-2-git-send-email-lidongchen@tencent.com>
Reply-To: quintela@redhat.com
Date: Tue, 24 Jul 2018 15:33:59 +0200
Message-ID: <87muugg3lk.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 2/2] migration: fix duplicate
 initialization for expected_downtime and cleanup_bh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lidong Chen <jemmy858585@gmail.com>
Cc: dgilbert@redhat.com, qemu-devel@nongnu.org, Lidong Chen <lidongchen@tencent.com>

Lidong Chen <jemmy858585@gmail.com> wrote:
> migrate_fd_connect duplicate initialize expected_downtime and cleanup_bh.
>
> Signed-off-by: Lidong Chen <lidongchen@tencent.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

Good catch.

Inserted here.

commit d3e35b8f6248eab2c3d412198a487ae49706b214
Author: Peter Xu <peterx@redhat.com>
Date:   Wed May 2 18:47:24 2018 +0800



> ---
>  migration/migration.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/migration/migration.c b/migration/migration.c
> index ff05422..b8c4fec 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -3032,8 +3032,6 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
>      } else {
>          /* This is a fresh new migration */
>          rate_limit = s->parameters.max_bandwidth / XFER_LIMIT_RATIO;
> -        s->expected_downtime = s->parameters.downtime_limit;
> -        s->cleanup_bh = qemu_bh_new(migrate_fd_cleanup, s);
>  
>          /* Notify before starting migration thread */
>          notifier_list_notify(&migration_state_notifiers, s);
