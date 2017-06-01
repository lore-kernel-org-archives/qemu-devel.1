Received: from eggs.gnu.org ([2001:4830:134:3::10]:39124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dGGVg-0005lz-IR
	for qemu-devel@nongnu.org; Wed, 31 May 2017 23:10:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dGGVb-0008NH-Lc
	for qemu-devel@nongnu.org; Wed, 31 May 2017 23:10:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47258)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dGGVb-0008NA-Fk
	for qemu-devel@nongnu.org; Wed, 31 May 2017 23:10:47 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2CCFA85376
	for <qemu-devel@nongnu.org>; Thu,  1 Jun 2017 03:10:46 +0000 (UTC)
Date: Thu, 1 Jun 2017 11:10:38 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170601031038.GC32741@pxdev.xzpeter.org>
References: <1496223756-24929-1-git-send-email-peterx@redhat.com>
	<20170531095023.GL14845@pxdev.xzpeter.org>
	<0d2dd83c-6a57-9617-087a-c57e64a667cd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0d2dd83c-6a57-9617-087a-c57e64a667cd@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/2] Edu leak fix series
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Wed, May 31, 2017 at 02:55:59PM +0200, Paolo Bonzini wrote:
> 
> 
> On 31/05/2017 11:50, Peter Xu wrote:
> > On Wed, May 31, 2017 at 05:42:34PM +0800, Peter Xu wrote:
> >> A whitelist for it does not really makes sense. Let's remove it and
> >> then we can introduce a blacklist when really needed, with msi_broken.
> >> That's patch 1.
> > Ok this paragraph does not make sense if not mentioning what's "it"...
> > 
> > Please just read the commit messages of patch 1. It should be much
> > better.
> 
> I think fixing the leak in case we have to reintroduce msi_(non)broken should
> be as simple as
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
> 
> 
> Then the two patches can be even squashed together.

Okay. So finally we still need this change... :)

Please anyone let me know whether this series needs a repost... And
also please feel free to do squashing of the two if that's not needed.

Thanks,

-- 
Peter Xu
