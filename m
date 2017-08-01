Received: from eggs.gnu.org ([2001:4830:134:3::10]:59101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dcUdW-0005ji-8g
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 06:42:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dcUdT-0005GC-KA
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 06:42:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49286)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dcUdT-0005Fr-BD
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 06:42:47 -0400
Date: Tue, 1 Aug 2017 11:42:36 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170801104235.GI2079@work-vm>
References: <1501229198-30588-1-git-send-email-peterx@redhat.com>
	<1501229198-30588-17-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1501229198-30588-17-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC 16/29] qmp: hmp: add migrate "resume" option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>

* Peter Xu (peterx@redhat.com) wrote:
> It will be used when we want to resume one paused migration.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

Other than Eric's comments:


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  hmp-commands.hx       | 7 ++++---
>  hmp.c                 | 4 +++-
>  migration/migration.c | 2 +-
>  qapi-schema.json      | 5 ++++-
>  4 files changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index 1941e19..7adb029 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -928,13 +928,14 @@ ETEXI
>  
>      {
>          .name       = "migrate",
> -        .args_type  = "detach:-d,blk:-b,inc:-i,uri:s",
> -        .params     = "[-d] [-b] [-i] uri",
> +        .args_type  = "detach:-d,blk:-b,inc:-i,resume:-r,uri:s",
> +        .params     = "[-d] [-b] [-i] [-r] uri",
>          .help       = "migrate to URI (using -d to not wait for completion)"
>  		      "\n\t\t\t -b for migration without shared storage with"
>  		      " full copy of disk\n\t\t\t -i for migration without "
>  		      "shared storage with incremental copy of disk "
> -		      "(base image shared between src and destination)",
> +		      "(base image shared between src and destination)"
> +                      "\n\t\t\t -r to resume a paused migration",
>          .cmd        = hmp_migrate,
>      },
>  
> diff --git a/hmp.c b/hmp.c
> index fd80dce..ebc1563 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -1891,10 +1891,12 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
>      bool detach = qdict_get_try_bool(qdict, "detach", false);
>      bool blk = qdict_get_try_bool(qdict, "blk", false);
>      bool inc = qdict_get_try_bool(qdict, "inc", false);
> +    bool resume = qdict_get_try_bool(qdict, "resume", false);
>      const char *uri = qdict_get_str(qdict, "uri");
>      Error *err = NULL;
>  
> -    qmp_migrate(uri, !!blk, blk, !!inc, inc, false, false, &err);
> +    qmp_migrate(uri, !!blk, blk, !!inc, inc,
> +                false, false, true, resume, &err);
>      if (err) {
>          error_report_err(err);
>          return;
> diff --git a/migration/migration.c b/migration/migration.c
> index 9d93836..36ff8c3 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1238,7 +1238,7 @@ bool migration_is_blocked(Error **errp)
>  
>  void qmp_migrate(const char *uri, bool has_blk, bool blk,
>                   bool has_inc, bool inc, bool has_detach, bool detach,
> -                 Error **errp)
> +                 bool has_resume, bool resume, Error **errp)
>  {
>      Error *local_err = NULL;
>      MigrationState *s = migrate_get_current();
> diff --git a/qapi-schema.json b/qapi-schema.json
> index 2a36b80..27b7c4c 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -3208,6 +3208,8 @@
>  # @detach: this argument exists only for compatibility reasons and
>  #          is ignored by QEMU
>  #
> +# @resume: resume one paused migration
> +#
>  # Returns: nothing on success
>  #
>  # Since: 0.14.0
> @@ -3229,7 +3231,8 @@
>  #
>  ##
>  { 'command': 'migrate',
> -  'data': {'uri': 'str', '*blk': 'bool', '*inc': 'bool', '*detach': 'bool' } }
> +  'data': {'uri': 'str', '*blk': 'bool', '*inc': 'bool',
> +           '*detach': 'bool', '*resume': 'bool' } }
>  
>  ##
>  # @migrate-incoming:
> -- 
> 2.7.4
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
