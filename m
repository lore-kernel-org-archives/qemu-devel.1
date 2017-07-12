Received: from eggs.gnu.org ([2001:4830:134:3::10]:56801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dVMuS-0005uQ-8p
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 15:02:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dVMuN-00019Y-8F
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 15:02:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54132)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dVMuN-00018o-2f
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 15:02:47 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DE6A67EBD8
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 19:02:45 +0000 (UTC)
Date: Wed, 12 Jul 2017 20:02:40 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170712190240.GM30658@work-vm>
References: <1499842423-21101-1-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1499842423-21101-1-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/3] migration: export cap/params to qdev
 props
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>

* Peter Xu (peterx@redhat.com) wrote:
> We have the MigrationState as QDev now (which seems crazy). Let's
> continue to benefit.
> 
> This series is exporting all migration capabilities/params as global
> parameters. Then we can do something like this:
> 
>   qemu -global migration.postcopy-ram=true \
>        -global migration.max-bandwidth=4096
> 
> The values will be inited just like we typed these values into HMP
> monitor. It'll simplify lots of migration scripts.
> 
> The changes are fairly straightforward. One tiny loss is that we still
> don't support:
> 
>   -global migration.max-bandwidth=1g
> 
> ...just like what we did in HMP:
> 
>   migrate_set_speed 1g
> 
> ...while we need to use:
> 
>   -global migration.max-bandwidth=1073741824
> 
> However that should only be used in scripts, and that's good enough
> imho.
> 
> These properties should only be used for debugging/testing purpose,
> and we should not guarantee any interface compatibility for them (just
> like HMP).

I guess the sanity checks in qmp_migrate_set_parameters and
qmp_migrate_set_capabilities aren't run?

Also, have you done any checks on multiple migrations; e.g. it's good
to check that the flags/state are all preserved if we do a migrate, that
migrate fails or is cancelled and then you do a 2nd migrate.

Dave

> Please review. Thanks.
> 
> Peter Xu (3):
>   qdev: provide DEFINE_PROP_INT64()
>   migration: export parameters to props
>   migration: export capabilities to props
> 
>  hw/core/qdev-properties.c    | 32 +++++++++++++++++++++++++++
>  include/hw/qdev-properties.h |  3 +++
>  migration/migration.c        | 52 +++++++++++++++++++++++++++++++++++---------
>  3 files changed, 77 insertions(+), 10 deletions(-)
> 
> -- 
> 2.7.4
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
