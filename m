Received: from eggs.gnu.org ([2001:4830:134:3::10]:40354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dG1yY-00019D-QD
	for qemu-devel@nongnu.org; Wed, 31 May 2017 07:39:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dG1yT-0007W0-SL
	for qemu-devel@nongnu.org; Wed, 31 May 2017 07:39:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42480)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dG1yT-0007Vd-Je
	for qemu-devel@nongnu.org; Wed, 31 May 2017 07:39:37 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 433237AE8A
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 11:39:36 +0000 (UTC)
Date: Wed, 31 May 2017 12:39:25 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170531113924.GH2141@work-vm>
References: <20170531091720.21697-1-quintela@redhat.com>
	<20170531091720.21697-4-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170531091720.21697-4-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 3/3] migration: Remove section_id
 parameter from vmstate_load
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com

* Juan Quintela (quintela@redhat.com) wrote:
> Everything else assumes that we always load a device from its own
> savevm handler.

Except for the title (it's the version_id you're removing not
section_id) but now I think this series is ok because you're always
using
the load_* stuff.

I guess in manyways the LoadStateEntry list made some sense; it was
harder to accidentally use version_id rather than load_version_id if
it was on a different pointer.

But generally now for the series:

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>


Dave

> Signed-off-by: Juan Quintela <quintela@redhat.com>
> Reviewed-by: Laurent Vivier <lvivier@redhat.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/savevm.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/migration/savevm.c b/migration/savevm.c
> index d96209b..2d1d4bc 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -746,13 +746,13 @@ void vmstate_unregister(DeviceState *dev, const VMStateDescription *vmsd,
>      }
>  }
>  
> -static int vmstate_load(QEMUFile *f, SaveStateEntry *se, int version_id)
> +static int vmstate_load(QEMUFile *f, SaveStateEntry *se)
>  {
>      trace_vmstate_load(se->idstr, se->vmsd ? se->vmsd->name : "(old)");
>      if (!se->vmsd) {         /* Old style */
> -        return se->ops->load_state(f, se->opaque, version_id);
> +        return se->ops->load_state(f, se->opaque, se->load_version_id);
>      }
> -    return vmstate_load_state(f, se->vmsd, se->opaque, version_id);
> +    return vmstate_load_state(f, se->vmsd, se->opaque, se->load_version_id);
>  }
>  
>  static void vmstate_save_old_style(QEMUFile *f, SaveStateEntry *se, QJSON *vmdesc)
> @@ -1882,7 +1882,7 @@ qemu_loadvm_section_start_full(QEMUFile *f, MigrationIncomingState *mis)
>          return -EINVAL;
>      }
>  
> -    ret = vmstate_load(f, se, se->load_version_id);
> +    ret = vmstate_load(f, se);
>      if (ret < 0) {
>          error_report("error while loading state for instance 0x%x of"
>                       " device '%s'", instance_id, idstr);
> @@ -1915,7 +1915,7 @@ qemu_loadvm_section_part_end(QEMUFile *f, MigrationIncomingState *mis)
>          return -EINVAL;
>      }
>  
> -    ret = vmstate_load(f, se, se->load_version_id);
> +    ret = vmstate_load(f, se);
>      if (ret < 0) {
>          error_report("error while loading state section id %d(%s)",
>                       section_id, se->idstr);
> -- 
> 2.9.4
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
