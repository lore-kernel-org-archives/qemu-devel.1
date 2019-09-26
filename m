Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DEB0C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 17:20:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5323B222C7
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 17:20:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5323B222C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDXRZ-0006dT-5S
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 13:20:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54717)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1iDXNW-0004Lc-Ch
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 13:16:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1iDXNU-0006jn-Bl
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 13:16:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54058)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1iDXNU-0006Rc-3m
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 13:16:28 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9F98D300BEA4;
 Thu, 26 Sep 2019 17:16:23 +0000 (UTC)
Received: from x1.home (ovpn-118-102.phx2.redhat.com [10.3.118.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 673825D9C9;
 Thu, 26 Sep 2019 17:16:23 +0000 (UTC)
Date: Thu, 26 Sep 2019 11:16:22 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Evgeny Yakovlev <wrfsh@yandex-team.ru>
Subject: Re: [PATCH] hw/vfio/pci: fix double free in vfio_msi_disable
Message-ID: <20190926111622.5cd9f856@x1.home>
In-Reply-To: <1569497375-24633-1-git-send-email-wrfsh@yandex-team.ru>
References: <1569497375-24633-1-git-send-email-wrfsh@yandex-team.ru>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Thu, 26 Sep 2019 17:16:23 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: qemu-devel@nongnu.org, yc-core@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 26 Sep 2019 14:29:35 +0300
Evgeny Yakovlev <wrfsh@yandex-team.ru> wrote:

> The following guest behaviour patter leads to double free in VFIO PCI:
> 
> 1. Guest enables MSI interrupts
> vfio_msi_enable is called, but fails in vfio_enable_vectors.
> In our case this was because VFIO GPU device was in D3 state.
> Unhappy path in vfio_msi_enable will g_free(vdev->msi_vectors) but not
> set this pointer to NULL
> 
> 2. Guest still sees MSI an enabled after that because emulated config
> write is done in vfio_pci_write_config unconditionally before calling
> vfio_msi_enable
> 
> 3. Guest disables MSI interrupts
> vfio_msi_disable is called and tries to g_free(vdev->msi_vectors)
> in vfio_msi_disable_common => double free
> 
> Signed-off-by: Evgeny Yakovlev <wrfsh@yandex-team.ru>
> ---
>  hw/vfio/pci.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index c5e6fe6..12fac39 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -651,6 +651,7 @@ retry:
>          }
>  
>          g_free(vdev->msi_vectors);
> +        vdev->msi_vectors = NULL;
>  
>          if (ret > 0 && ret != vdev->nr_vectors) {
>              vdev->nr_vectors = ret;

Looks correct to me, I'll queue it.  Thanks,

Alex

