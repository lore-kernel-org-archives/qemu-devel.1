Received: from eggs.gnu.org ([2001:4830:134:3::10]:47039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cUIaV-0005Ep-UW
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 14:41:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cUIaT-0000U5-UL
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 14:41:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:61247)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cUIaT-0000Tq-Ob
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 14:41:33 -0500
Date: Thu, 19 Jan 2017 19:41:27 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170119194126.GL2085@work-vm>
References: <1484566314-3987-1-git-send-email-ashijeetacharya@gmail.com>
	<1484566314-3987-6-git-send-email-ashijeetacharya@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484566314-3987-6-git-send-email-ashijeetacharya@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v6 5/5] migration: Fail migration blocker
 for --only-migratable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ashijeet Acharya <ashijeetacharya@gmail.com>
Cc: jsnow@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, kwolf@redhat.com, armbru@redhat.com, quintela@redhat.com, mst@redhat.com, marcandre.lureau@redhat.com, groug@kaod.org, aneesh.kumar@linux.vnet.ibm.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

* Ashijeet Acharya (ashijeetacharya@gmail.com) wrote:
> migrate_add_blocker should rightly fail if the '--only-migratable'
> option was specified and the device in use should not be able to
> perform the action which results in an unmigratable VM.
> 
> Make migrate_add_blocker return -EACCES in this case.
> 
> Signed-off-by: Ashijeet Acharya <ashijeetacharya@gmail.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  include/migration/migration.h | 2 +-
>  migration/migration.c         | 7 +++++++
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/include/migration/migration.h b/include/migration/migration.h
> index bcbdb03..7881e89 100644
> --- a/include/migration/migration.h
> +++ b/include/migration/migration.h
> @@ -291,7 +291,7 @@ int ram_postcopy_incoming_init(MigrationIncomingState *mis);
>   *
>   * @errp - [out] The reason (if any) we cannot block migration right now.
>   *
> - * @returns - 0 on success, -EBUSY on failure, with errp set.
> + * @returns - 0 on success, -EBUSY/-EACCES on failure, with errp set.
>   */
>  int migrate_add_blocker(Error *reason, Error **errp);
>  
> diff --git a/migration/migration.c b/migration/migration.c
> index 0d88286..7dcb7d7 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1113,6 +1113,13 @@ static GSList *migration_blockers;
>  
>  int migrate_add_blocker(Error *reason, Error **errp)
>  {
> +    if (only_migratable) {
> +        error_propagate(errp, error_copy(reason));
> +        error_prepend(errp, "disallowing migration blocker "
> +                          "(--only_migratable) for: ");
> +        return -EACCES;
> +    }
> +
>      if (migration_is_idle(NULL)) {
>          migration_blockers = g_slist_prepend(migration_blockers, reason);
>          return 0;
> -- 
> 2.6.2
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
