Received: from eggs.gnu.org ([2001:4830:134:3::10]:59379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dOWuP-000221-Ei
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 18:18:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dOWuM-0003wb-92
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 18:18:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34432)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dOWuM-0003vY-2g
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 18:18:30 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D8478E7C5C
	for <qemu-devel@nongnu.org>; Fri, 23 Jun 2017 22:18:28 +0000 (UTC)
Date: Fri, 23 Jun 2017 19:18:19 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170623221819.GE10776@localhost.localdomain>
References: <1498193206-18007-1-git-send-email-peterx@redhat.com>
	<1498193206-18007-5-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1498193206-18007-5-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 04/10] migration: let MigrationState be
 a qdev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Fri, Jun 23, 2017 at 12:46:40PM +0800, Peter Xu wrote:
> Let the old man "MigrationState" join the object family. Direct benefit
> is that we can start to use all the property features derived from
> current QDev, like: HW_COMPAT_* bits, command line setup for migration
> parameters (so will never need to set them up each time using HMP/QMP,
> this is really, really attractive for test writters), etc.
> 
> I see no reason to disallow this happen yet. So let's start from this
> one, to see whether it would be anything good.
> 
> Now we init the MigrationState struct statically in main() to make sure
> it's initialized after global properties are applied, since we'll use
> them during creation of the object.
> 
> No functional change at all.
> 
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/migration/misc.h |  1 +
>  migration/migration.c    | 78 ++++++++++++++++++++++++++++++++++--------------
>  migration/migration.h    | 19 ++++++++++++
>  vl.c                     |  6 ++++
>  4 files changed, 81 insertions(+), 23 deletions(-)
> 
[...]
> diff --git a/vl.c b/vl.c
> index cdd2ec8..9b04ba7 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -4596,6 +4596,12 @@ int main(int argc, char **argv, char **envp)
>       */
>      register_global_properties(current_machine);
>  
> +    /*
> +     * Migration object can only be created after global properties
> +     * are applied correctly.
> +     */
> +    migration_object_init();
> +

Do we really need this? Can't be we just do:

    if (!current_migration) {
        current_migration = MIGRATION_OBJ(object_new(TYPE_MIGRATION));
    }

inside migration_get_current()?

>      /* This checkpoint is required by replay to separate prior clock
>         reading from the other reads, because timer polling functions query
>         clock values from the log. */
> -- 
> 2.7.4
> 
> 

-- 
Eduardo
