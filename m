Received: from eggs.gnu.org ([2001:4830:134:3::10]:49811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dG41G-00087y-2I
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:50:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dG41D-0001cd-DP
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:50:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41460)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dG41D-0001cI-7X
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:50:35 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BEA8E3DBCA
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 13:50:33 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170531125746.17585-1-pbonzini@redhat.com>
Date: Wed, 31 May 2017 15:50:30 +0200
In-Reply-To: <20170531125746.17585-1-pbonzini@redhat.com> (Paolo Bonzini's
	message of "Wed, 31 May 2017 14:57:46 +0200")
Message-ID: <87mv9t5e55.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] edu: fix memory leak on msi_broken
 platforms
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>

Paolo Bonzini <pbonzini@redhat.com> writes:

> If msi_init fails, the thread has already been created and the
> mutex/condvar are not destroyed.  Initialize everything only
> after the point where pci_edu_realize cannot fail.
>
> Reported-by: Markus Armbruster <armbru@redhat.com>
> Cc: Peter Xu <peterx@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/misc/edu.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/hw/misc/edu.c b/hw/misc/edu.c
> index 401039c100..01acacf142 100644
> --- a/hw/misc/edu.c
> +++ b/hw/misc/edu.c
> @@ -343,6 +343,12 @@ static void pci_edu_realize(PCIDevice *pdev, Error **errp)
>      EduState *edu = DO_UPCAST(EduState, pdev, pdev);
>      uint8_t *pci_conf = pdev->config;
>  
> +    pci_config_set_interrupt_pin(pci_conf, 1);
> +
> +    if (msi_init(pdev, 0, 1, true, false, errp)) {
> +        return;
> +    }
> +
>      timer_init_ms(&edu->dma_timer, QEMU_CLOCK_VIRTUAL, edu_dma_timer, edu);
>  
>      qemu_mutex_init(&edu->thr_mutex);
> @@ -350,12 +356,6 @@ static void pci_edu_realize(PCIDevice *pdev, Error **errp)
>      qemu_thread_create(&edu->thread, "edu", edu_fact_thread,
>                         edu, QEMU_THREAD_JOINABLE);
>  
> -    pci_config_set_interrupt_pin(pci_conf, 1);
> -
> -    if (msi_init(pdev, 0, 1, true, false, errp)) {
> -        return;
> -    }
> -
>      memory_region_init_io(&edu->mmio, OBJECT(edu), &edu_mmio_ops, edu,
>                      "edu-mmio", 1 << 20);
>      pci_register_bar(pdev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY, &edu->mmio);

Reviewed-by: Markus Armbruster <armbru@redhat.com>
