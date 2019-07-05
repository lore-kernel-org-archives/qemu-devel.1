Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF93C46499
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 16:34:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21D3F21721
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 16:34:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21D3F21721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjRA4-0002vE-E9
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 12:34:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47267)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.williamson@redhat.com>) id 1hjR8T-00026I-9j
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 12:32:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1hjR8M-0002la-DF
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 12:32:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47710)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1hjR8H-0007vY-Qq; Fri, 05 Jul 2019 12:32:22 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id ECF7F308222F;
 Fri,  5 Jul 2019 16:31:23 +0000 (UTC)
Received: from x1.home (ovpn-116-83.phx2.redhat.com [10.3.116.83])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 08EB018657;
 Fri,  5 Jul 2019 16:31:21 +0000 (UTC)
Date: Fri, 5 Jul 2019 10:31:21 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <20190705103121.30363b9c@x1.home>
In-Reply-To: <20190705032501.106966-1-aik@ozlabs.ru>
References: <20190705032501.106966-1-aik@ozlabs.ru>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Fri, 05 Jul 2019 16:31:32 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC PATCH qemu] vfio-quirks: Pass the actual
 parent when deleting a memory region
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri,  5 Jul 2019 13:25:01 +1000
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> The usual way of using a quirk's MR is to add it as a subregion of a BAR
> as this is what quirks are for. However there is less than standard user
> of this - NVLink2-enabled NVIDIA GPU which exposes a GPU RAM and a ATSD
> 64K region outside of PCI MMIO window so these MRs get the system address
> space root as a parent. So when the user unplugs such device, assert
> occurs:
> 
> qemu-system-ppc64: /home/aik/p/qemu/memory.c:2391: memory_region_del_subregion: Assertion `subregion->container == mr' failed.
> 
> This passes the actual parent MR to memory_region_del_subregion() in
> vfio_bar_quirk_exit.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
> 
> This removes an extra sanity check that a quirk has a correct parent;
> I am not sure if it is very useful.
> I could use the "system" MR if quirk->mem[i].container==get_system_memory()
> and quirk->mem[i].container otherwise to keep that assert working.
> 
> Also this does not help with the actual device removal much because of
> the closed source driver nature - the associated service
> (nvidia-persistenced, responsible for onlining GPU memory) crashes
> the guest system but at least the user can reboot the guest after
> the crash which is not as bad as assert.
> 
> ---
>  hw/vfio/pci-quirks.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
> index 27dddbc8fa3e..ef2e182c1d36 100644
> --- a/hw/vfio/pci-quirks.c
> +++ b/hw/vfio/pci-quirks.c
> @@ -1896,7 +1896,8 @@ void vfio_bar_quirk_exit(VFIOPCIDevice *vdev, int nr)
>          }
>  
>          for (i = 0; i < quirk->nr_mem; i++) {
> -            memory_region_del_subregion(bar->region.mem, &quirk->mem[i]);
> +            memory_region_del_subregion(quirk->mem[i].container,
> +                                        &quirk->mem[i]);
>          }
>      }
>  }

NAK

struct MemoryRegion {
    Object parent_obj;

    /* All fields are private - violators will be prosecuted */
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    ...
    MemoryRegion *container;

