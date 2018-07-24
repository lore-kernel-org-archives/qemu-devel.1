Received: from eggs.gnu.org ([2001:4830:134:3::10]:35515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fhzka-0002or-E4
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 12:01:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fhzkV-0003ki-CH
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 12:01:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37638 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fhzkV-0003jT-7B
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 12:01:19 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 70A2E40711A1
	for <qemu-devel@nongnu.org>; Tue, 24 Jul 2018 16:01:18 +0000 (UTC)
Date: Tue, 24 Jul 2018 17:01:15 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180724160115.GC48553@work-vm>
References: <20180719092257.12703-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180719092257.12703-1-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] migrate: Fix cancelling state warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peterx@redhat.com, quintela@redhat.com

* Dr. David Alan Gilbert (git) (dgilbert@redhat.com) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> We've been getting the warning:
> 
> migration_iteration_finish: Unknown ending state 2
> 
> on a cancel.
> 
> I think that's originally due to 39b9e17905c;  although
> I've only seen the warning, I think that in some cases
> that we could find the VM stays paused after a cancel where
> it should restart.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Queued

> ---
>  migration/migration.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 8d56d56930..db6bde7453 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2877,6 +2877,7 @@ static void migration_iteration_finish(MigrationState *s)
>          /* Fallthrough */
>      case MIGRATION_STATUS_FAILED:
>      case MIGRATION_STATUS_CANCELLED:
> +    case MIGRATION_STATUS_CANCELLING:
>          if (s->vm_was_running) {
>              vm_start();
>          } else {
> -- 
> 2.17.1
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
