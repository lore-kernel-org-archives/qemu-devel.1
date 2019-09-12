Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73427C5ACAE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 10:15:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4942020830
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 10:15:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4942020830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8M8N-0002Af-FK
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 06:15:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53189)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1i8M7I-0001T7-4H
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 06:14:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1i8M7H-0005jc-7j
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 06:14:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41066)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1i8M7H-0005jR-30
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 06:14:19 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 71B32C051688;
 Thu, 12 Sep 2019 10:14:18 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.12])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7157D10016EB;
 Thu, 12 Sep 2019 10:14:17 +0000 (UTC)
Date: Thu, 12 Sep 2019 11:14:14 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, dmitry.fleytman@gmail.com, jasowang@redhat.com
Message-ID: <20190912101414.GC7230@work-vm>
References: <20190822111218.12079-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822111218.12079-1-dgilbert@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Thu, 12 Sep 2019 10:14:18 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] hw/net/vmxnet3: Fix leftover
 unregister_savevm
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
Cc: quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Dr. David Alan Gilbert (git) (dgilbert@redhat.com) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Commit 78dd48df3 reworked vmxnet3's live migration but left a straggling
> unregister_savevm call.  Remove it, although it doesn't seem to have
> any bad effect.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Queued

> ---
>  hw/net/vmxnet3.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
> index b07adeed9c..39ff6624c5 100644
> --- a/hw/net/vmxnet3.c
> +++ b/hw/net/vmxnet3.c
> @@ -2242,13 +2242,10 @@ static void vmxnet3_instance_init(Object *obj)
>  
>  static void vmxnet3_pci_uninit(PCIDevice *pci_dev)
>  {
> -    DeviceState *dev = DEVICE(pci_dev);
>      VMXNET3State *s = VMXNET3(pci_dev);
>  
>      VMW_CBPRN("Starting uninit...");
>  
> -    unregister_savevm(dev, "vmxnet3-msix", s);
> -
>      vmxnet3_net_uninit(s);
>  
>      vmxnet3_cleanup_msix(s);
> -- 
> 2.21.0
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

