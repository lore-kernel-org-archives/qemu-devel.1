Received: from eggs.gnu.org ([2001:4830:134:3::10]:51004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dFjOs-0003Nr-SJ
	for qemu-devel@nongnu.org; Tue, 30 May 2017 11:49:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dFjOo-0002wK-W6
	for qemu-devel@nongnu.org; Tue, 30 May 2017 11:49:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:12807)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dFjOo-0002wG-Pg
	for qemu-devel@nongnu.org; Tue, 30 May 2017 11:49:34 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4AAA280C0E
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 15:49:33 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1495176212-14446-4-git-send-email-peterx@redhat.com> (Peter Xu's
	message of "Fri, 19 May 2017 14:43:29 +0800")
References: <1495176212-14446-1-git-send-email-peterx@redhat.com>
	<1495176212-14446-4-git-send-email-peterx@redhat.com>
Reply-To: quintela@redhat.com
Date: Tue, 30 May 2017 17:49:29 +0200
Message-ID: <877f0yfipi.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH RFC 3/6] migration: fix leak of src file on
 dst
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Peter Xu <peterx@redhat.com> wrote:
> The return path channel is possibly leaked. Fix it.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/migration.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/migration/migration.c b/migration/migration.c
> index e4f4c8c..92617fc 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -130,6 +130,11 @@ void migration_incoming_state_destroy(void)
>  {
>      struct MigrationIncomingState *mis = migration_incoming_get_current();
>  
> +    if (mis->to_src_file) {
> +        qemu_fclose(mis->to_src_file);
> +        mis->to_src_file = NULL;
> +    }
> +
>      qemu_event_destroy(&mis->main_thread_load_event);
>      loadvm_free_handlers(mis);
>  }

Reviewed-by: Juan Quintela <quintela@redhat.com>
