Received: from eggs.gnu.org ([2001:4830:134:3::10]:59489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dOWv4-0002LU-Fb
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 18:19:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dOWv1-0004Fy-9K
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 18:19:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35634)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dOWv1-0004Fi-32
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 18:19:11 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1F2A631CF19
	for <qemu-devel@nongnu.org>; Fri, 23 Jun 2017 22:19:10 +0000 (UTC)
Date: Fri, 23 Jun 2017 19:19:01 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170623221901.GF10776@localhost.localdomain>
References: <1498193206-18007-1-git-send-email-peterx@redhat.com>
	<1498193206-18007-6-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1498193206-18007-6-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 05/10] migration: move
 global_state.optional out
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

On Fri, Jun 23, 2017 at 12:46:41PM +0800, Peter Xu wrote:
> Put it into MigrationState then we can use the properties to specify
> whether to enable storing global state.
> 
> Removing global_state_set_optional() since now we can use HW_COMPAT_2_3
> for x86/power, and AccelClass.global_props for Xen.
> 
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  hw/i386/pc_piix.c                |  1 -
>  hw/ppc/spapr.c                   |  1 -
>  hw/xen/xen-common.c              | 11 ++++++++++-
>  include/hw/compat.h              |  4 ++++
>  include/migration/global_state.h |  1 -
>  migration/global_state.c         |  9 ++-------
>  migration/migration.c            |  7 +++++++
>  migration/migration.h            |  6 ++++++
>  8 files changed, 29 insertions(+), 11 deletions(-)
> 
[...]
> diff --git a/hw/xen/xen-common.c b/hw/xen/xen-common.c
> index d3fa705..9163a0a 100644
> --- a/hw/xen/xen-common.c
> +++ b/hw/xen/xen-common.c
> @@ -139,19 +139,28 @@ static int xen_init(MachineState *ms)
>      }
>      qemu_add_vm_change_state_handler(xen_change_state_handler, NULL);
>  
> -    global_state_set_optional();
>      savevm_skip_configuration();
>      savevm_skip_section_footers();
>  
>      return 0;
>  }
>  
> +GlobalProperty xen_compat_props[] = {

This can be static.

> +    {
> +        .driver = "migration",
> +        .property = "store-global-state",
> +        .value = "off",
> +    },
> +    { .driver = NULL, .property = NULL, .value = NULL },

Normally this is written as:

       { /* end of list */ },

> +};
> +
[...]

I didn't review the rest yet, but it seems to be good.

-- 
Eduardo
