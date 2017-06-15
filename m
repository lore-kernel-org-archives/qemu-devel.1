Received: from eggs.gnu.org ([2001:4830:134:3::10]:52205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dLY2d-0002aL-5S
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 12:54:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dLY2Z-0006Zi-7D
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 12:54:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44742)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1dLY2Z-0006Yo-0u
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 12:54:39 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 46170201FB
	for <qemu-devel@nongnu.org>; Thu, 15 Jun 2017 16:54:35 +0000 (UTC)
References: <1497426958-20871-1-git-send-email-peterx@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <786c6bcf-2b85-1faa-bc70-66cbe404cbfa@redhat.com>
Date: Thu, 15 Jun 2017 18:54:26 +0200
MIME-Version: 1.0
In-Reply-To: <1497426958-20871-1-git-send-email-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] migration: fix incorrect enable return path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On 14/06/2017 09:55, Peter Xu wrote:
> 0425dc9 is actually v1 of that patch, but it was accidentally
> merged (while there was a v2). That will cause problem when we try to
> migrate to some old QEMUs when return path is not really there. Let's
> fix it, then squashing this patch with 0425dc9 will be exactly patch
> content of v2.
> 
> Fixes: 0425dc9 ("migration: isolate return path on src")
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/migration.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 8ef6d6c..f9053b0 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1814,7 +1814,11 @@ static void *migration_thread(void *opaque)
>  
>      qemu_savevm_state_header(s->to_dst_file);
>  
> -    if (s->to_dst_file) {
> +    /*
> +     * If we opened the return path, we need to make sure dst has it
> +     * opened as well.
> +     */
> +    if (s->rp_state.from_dst_file) {
>          /* Now tell the dest that it should open its end so it can reply */
>          qemu_savevm_send_open_return_path(s->to_dst_file);
>  
> 

Tested-by: Laurent Vivier <lvivier@redhat.com>

This also fixes migration of pseries guest, using the same
binary/machine type on both side, the error was:

qemu-system-ppc64: Failed to load spapr_iommu:mig_table
qemu-system-ppc64: error while loading state for instance 0x80000001 of
device 'spapr_iommu'
qemu-system-ppc64: load of migration failed: Input/output error

Laurent
