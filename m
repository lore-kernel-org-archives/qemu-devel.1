Received: from eggs.gnu.org ([2001:4830:134:3::10]:45304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dXPwN-00046U-7X
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:41:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dXPwK-00016H-5c
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:41:19 -0400
References: <20170718101632.3304-1-lvivier@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ef867792-9bc4-7338-7fe6-ce48241fb4e7@redhat.com>
Date: Tue, 18 Jul 2017 12:41:09 +0200
MIME-Version: 1.0
In-Reply-To: <20170718101632.3304-1-lvivier@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] spapr/htab: fix savevm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, sursingh@redhat.com, mdroth@linux.vnet.ibm.com, David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, sbobroff@redhat.com

On 18.07.2017 12:16, Laurent Vivier wrote:
> Commit 3a38429 ("spapr: Add a "no HPT" encoding to HTAB migration stream")
> allows to migrate an empty HPT, but doesn't mark correctly the
> end of the migration stream.
> 
> The end condition (value returned by htab_save_iterate())
> should be 1, whereas in 3a38429 it returns 0.
> 
> The problem can be reproduced with QEMU monitor command "savevm":
> the command never stops and the disk image grows without limit.
> 
> Fixes: 3a38429748aa4f74abaecf16c4c087e8a325e12a
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
> v2: remove change in htab_save_complete() as
>     it always return 0 in case of success (Thomas)
> 
>  hw/ppc/spapr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 970093e..1cb09e7 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1827,7 +1827,7 @@ static int htab_save_iterate(QEMUFile *f, void *opaque)
>      /* Iteration header */
>      if (!spapr->htab_shift) {
>          qemu_put_be32(f, -1);
> -        return 0;
> +        return 1;
>      } else {
>          qemu_put_be32(f, 0);
>      }
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
