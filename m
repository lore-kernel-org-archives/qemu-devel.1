Received: from eggs.gnu.org ([2001:4830:134:3::10]:45530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dFdaI-0006FP-QT
	for qemu-devel@nongnu.org; Tue, 30 May 2017 05:37:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dFdaF-0000g9-JP
	for qemu-devel@nongnu.org; Tue, 30 May 2017 05:37:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43048)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1dFdaF-0000fz-Dc
	for qemu-devel@nongnu.org; Tue, 30 May 2017 05:36:59 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 70A4980F6D
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 09:36:58 +0000 (UTC)
References: <20170530083705.15141-1-quintela@redhat.com>
	<20170530083705.15141-4-quintela@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <520a4a08-1345-b229-8e4b-709334fdf3dd@redhat.com>
Date: Tue, 30 May 2017 11:36:55 +0200
MIME-Version: 1.0
In-Reply-To: <20170530083705.15141-4-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/3] migration: Remove section_id
 parameter from vmstate_load
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, peterx@redhat.com

On 30/05/2017 10:37, Juan Quintela wrote:
> Everything else assumes that we always load a device from its own
> savevm handler.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Laurent Vivier <lvivier@redhat.com>

> ---
>  migration/savevm.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 14af5ad..e5dd7ef 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -723,13 +723,13 @@ void vmstate_unregister(DeviceState *dev, const VMStateDescription *vmsd,
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
> @@ -1858,7 +1858,7 @@ qemu_loadvm_section_start_full(QEMUFile *f, MigrationIncomingState *mis)
>          return -EINVAL;
>      }
>  
> -    ret = vmstate_load(f, se, se->load_version_id);
> +    ret = vmstate_load(f, se);
>      if (ret < 0) {
>          error_report("error while loading state for instance 0x%x of"
>                       " device '%s'", instance_id, idstr);
> @@ -1891,7 +1891,7 @@ qemu_loadvm_section_part_end(QEMUFile *f, MigrationIncomingState *mis)
>          return -EINVAL;
>      }
>  
> -    ret = vmstate_load(f, se, se->load_version_id);
> +    ret = vmstate_load(f, se);
>      if (ret < 0) {
>          error_report("error while loading state section id %d(%s)",
>                       section_id, se->idstr);
> 
