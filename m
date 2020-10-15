Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 809D5C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 07:49:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACEF122243
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 07:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P4F4IwvW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACEF122243
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSy15-0005oY-NB
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 03:49:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41010)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1kSxyv-0003xU-7H
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 03:47:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43560)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1kSxys-0006jT-Jg
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 03:47:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602748040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hafST5W6KfNISku4nGNN92qQKoL9XZq2ay4WfPSy8u0=;
 b=P4F4IwvW5EOSAT6PYkEpAcfrf8IUiznT6nK82DM9x4DFX3VXTlaB+BhUM+yp0AZt61/nt/
 E7CfrieNlAkft5cRJq6fRy6z1y9WMI7Jg9ZjltUHKlIlqDDwiw/JdRAoc6xen1aAteA8FO
 H9ehIL6SzQSkaoLFMxeN2n98PKdlE5Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-28OfEY3QOW2fma4fgbp_MQ-1; Thu, 15 Oct 2020 03:47:19 -0400
X-MC-Unique: 28OfEY3QOW2fma4fgbp_MQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1FA3C1074647;
 Thu, 15 Oct 2020 07:47:18 +0000 (UTC)
Received: from [10.72.13.96] (ovpn-13-96.pek2.redhat.com [10.72.13.96])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 88ACC19C4F;
 Thu, 15 Oct 2020 07:47:10 +0000 (UTC)
Subject: Re: [PATCH] pci: advertise a page aligned ATS
To: mst@redhat.com, qemu-devel@nongnu.org
References: <20200909081731.24688-1-jasowang@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <704323d4-8079-fbd2-3318-c67ebefa2525@redhat.com>
Date: Thu, 15 Oct 2020 15:47:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200909081731.24688-1-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 02:10:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: eperezma@redhat.com, qemu-stable@nongnu.org, peterx@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/9/9 下午4:17, Jason Wang wrote:
> After Linux kernel commit 61363c1474b1 ("iommu/vt-d: Enable ATS only
> if the device uses page aligned address."), ATS will be only enabled
> if device advertises a page aligned request.
>
> Unfortunately, vhost-net is the only user and we don't advertise the
> aligned request capability in the past since both vhost IOTLB and
> address_space_get_iotlb_entry() can support non page aligned request.
>
> Though it's not clear that if the above kernel commit makes
> sense. Let's advertise a page aligned ATS here to make vhost device
> IOTLB work with Intel IOMMU again.
>
> Note that in the future we may extend pcie_ats_init() to accept
> parameters like queue depth and page alignment.
>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>   hw/pci/pcie.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> index 5b48bae0f6..d4010cf8f3 100644
> --- a/hw/pci/pcie.c
> +++ b/hw/pci/pcie.c
> @@ -971,8 +971,9 @@ void pcie_ats_init(PCIDevice *dev, uint16_t offset)
>   
>       dev->exp.ats_cap = offset;
>   
> -    /* Invalidate Queue Depth 0, Page Aligned Request 0 */
> -    pci_set_word(dev->config + offset + PCI_ATS_CAP, 0);
> +    /* Invalidate Queue Depth 0, Page Aligned Request 1 */
> +    pci_set_word(dev->config + offset + PCI_ATS_CAP,
> +                 PCI_ATS_CAP_PAGE_ALIGNED);
>       /* STU 0, Disabled by default */
>       pci_set_word(dev->config + offset + PCI_ATS_CTRL, 0);
>   


Ping, Michael, want to pick this patch?

Thanks


