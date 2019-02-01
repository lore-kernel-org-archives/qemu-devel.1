Received: from eggs.gnu.org ([209.51.188.92]:37801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gpYP8-0006BE-Sj
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 07:58:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gpYP2-0001hs-SC
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 07:58:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48500)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gpYP1-0001f5-3P
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 07:58:39 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190201051806.53183-1-lifei1214@126.com>
	<20190201051806.53183-5-lifei1214@126.com>
Date: Fri, 01 Feb 2019 13:58:33 +0100
In-Reply-To: <20190201051806.53183-5-lifei1214@126.com> (Fei Li's message of
	"Fri, 1 Feb 2019 13:17:59 +0800")
Message-ID: <87k1ij7jie.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v11 for-4.0 04/11] qemu_thread: supplement
 error handling for pci_edu_realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fei Li <lifei1214@126.com>
Cc: qemu-devel@nongnu.org, shirley17fei@gmail.com, Jiri Slaby <jslaby@suse.cz>

Fei Li <lifei1214@126.com> writes:

> From: Fei Li <fli@suse.com>
>
> Utilize the existed errp to propagate the error and do the
> corresponding cleanup to replace the temporary &error_abort.
>
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Jiri Slaby <jslaby@suse.cz>
> Signed-off-by: Fei Li <fli@suse.com>
> ---
>  hw/misc/edu.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/hw/misc/edu.c b/hw/misc/edu.c
> index 21adbfddce..8fe232b6d6 100644
> --- a/hw/misc/edu.c
> +++ b/hw/misc/edu.c
> @@ -356,9 +356,14 @@ static void pci_edu_realize(PCIDevice *pdev, Error **errp)
>  
>      qemu_mutex_init(&edu->thr_mutex);
>      qemu_cond_init(&edu->thr_cond);
> -    /* TODO: let the further caller handle the error instead of abort() here */
> -    qemu_thread_create(&edu->thread, "edu", edu_fact_thread,
> -                       edu, QEMU_THREAD_JOINABLE, &error_abort);
> +    if (qemu_thread_create(&edu->thread, "edu", edu_fact_thread,
> +                           edu, QEMU_THREAD_JOINABLE, errp) < 0) {
> +        qemu_cond_destroy(&edu->thr_cond);
> +        qemu_mutex_destroy(&edu->thr_mutex);
> +        timer_del(&edu->dma_timer);
> +        msi_uninit(pdev);
> +        return;
> +    }
>  
>      memory_region_init_io(&edu->mmio, OBJECT(edu), &edu_mmio_ops, edu,
>                      "edu-mmio", 1 * MiB);

In review of v9, I pointed out that pci_edu_uninit() neglects to call
msix_uninit(), and you offered to fix it.  Not in this series.  Do you
still intend to fix it?

That's a separate patch, though, so
Reviewed-by: Markus Armbruster <armbru@redhat.com>
