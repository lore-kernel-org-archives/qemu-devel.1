Received: from eggs.gnu.org ([209.51.188.92]:40847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ggYiE-0006ON-N1
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 12:29:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ggYiC-0007bt-NW
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 12:29:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38240)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ggYiC-0007b4-BG
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 12:29:16 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181225140449.15786-1-fli@suse.com>
	<20181225140449.15786-10-fli@suse.com>
Date: Mon, 07 Jan 2019 18:29:13 +0100
In-Reply-To: <20181225140449.15786-10-fli@suse.com> (Fei Li's message of "Tue,
	25 Dec 2018 22:04:42 +0800")
Message-ID: <87a7kcml5i.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-4.0 v9 09/16] qemu_thread: supplement
 error handling for pci_edu_realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fei Li <fli@suse.com>
Cc: qemu-devel@nongnu.org, shirley17fei@gmail.com, lifei1214@126.com, Jiri Slaby <jslaby@suse.cz>

Fei Li <fli@suse.com> writes:

> Utilize the existed errp to propagate the error instead of the
> temporary &error_abort.
>
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Jiri Slaby <jslaby@suse.cz>
> Signed-off-by: Fei Li <fli@suse.com>
> ---
>  hw/misc/edu.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/hw/misc/edu.c b/hw/misc/edu.c
> index 3f4ba7ded3..011fe6e0b7 100644
> --- a/hw/misc/edu.c
> +++ b/hw/misc/edu.c
> @@ -356,9 +356,10 @@ static void pci_edu_realize(PCIDevice *pdev, Error **errp)
>  
>      qemu_mutex_init(&edu->thr_mutex);
>      qemu_cond_init(&edu->thr_cond);
> -    /* TODO: let the further caller handle the error instead of abort() here */
> -    qemu_thread_create(&edu->thread, "edu", edu_fact_thread,
> -                       edu, QEMU_THREAD_JOINABLE, &error_abort);
> +    if (!qemu_thread_create(&edu->thread, "edu", edu_fact_thread,
> +                            edu, QEMU_THREAD_JOINABLE, errp)) {
> +        return;

You need to clean up everything that got initialized so far.  You might
want to call qemu_thread_create() earlier so you have less to clean up.

> +    }
>  
>      memory_region_init_io(&edu->mmio, OBJECT(edu), &edu_mmio_ops, edu,
>                      "edu-mmio", 1 * MiB);
       pci_register_bar(pdev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY, &edu->mmio);
   }

   static void pci_edu_uninit(PCIDevice *pdev)
   {
       EduState *edu = EDU(pdev);

       qemu_mutex_lock(&edu->thr_mutex);
       edu->stopping = true;
       qemu_mutex_unlock(&edu->thr_mutex);
       qemu_cond_signal(&edu->thr_cond);
       qemu_thread_join(&edu->thread);

       qemu_cond_destroy(&edu->thr_cond);
       qemu_mutex_destroy(&edu->thr_mutex);

       timer_del(&edu->dma_timer);
   }

Preexisting: pci_edu_uninit() neglects to call msi_uninit().  Jiri?
