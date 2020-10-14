Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1577C433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 17:53:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8FE122200
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 17:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nz6odthf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8FE122200
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSkxq-0003CL-Pl
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 13:53:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51936)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kSkx7-0002mn-50
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 13:52:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46020)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kSkx5-0006uk-ER
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 13:52:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602697957;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/bmqIxOtbMfUIk+61Bjq8Nwme/nTjohMQdH9WjoEvk8=;
 b=Nz6odthfnOAdEUpLBMUmtBOh0Vve5XDVmRv8px1gHW2ak6cx3Rhgl1psYdI5GeslqKUBqe
 GoicAdFbcYPKjOSIVCIOhx3v1F7vgjOaWN7Q/MlDr90Zk2X99Bfrd82/gGRpGN3gVr5Tfy
 g5FMzW3yk1KFHb4JSYBs8fB13xbiN9I=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-TnmJgvJrPKW83fq3L7gIpQ-1; Wed, 14 Oct 2020 13:52:36 -0400
X-MC-Unique: TnmJgvJrPKW83fq3L7gIpQ-1
Received: by mail-wm1-f70.google.com with SMTP id s25so161804wmj.7
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 10:52:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=/bmqIxOtbMfUIk+61Bjq8Nwme/nTjohMQdH9WjoEvk8=;
 b=DuTb0ssac831wf+KdIzpEo8Iaw1FHRgqZZh4vTZF6ahIGCCyQ7F4Ks3iOYVmzQLS2i
 zeT5l9+y/HU0O4m+A7ZtSj9GqoyFADg9TzDqHTwoLFSVaPq4jvd4u7pudGAAcIffTnGM
 ZCvs7Tgb+7qweXABB7B7dFh9gp9Pc39xY6CxXI/QovM9KC257jRuvrfALt/MEUC5cCp0
 wRRYqQs3YJuzuLVRSUhSPT5dfzyBpZllWrifzQwgNT67+Vvv9FMzX8HZ6OzcQo/KwZeC
 zgpfUh8xhIYFo64DjDD5TIqX8R8HxxG/vPN8vCxBFOV/j6aez1ZHfzR4v/uhBwy2eD/T
 Jt0g==
X-Gm-Message-State: AOAM532aL7EW+pMp2HQG7oFj0S7GZ3DNhvNssa4IO9tcPFEPHH6qf1x3
 H0nJI7HcGiivnK3vRDykvixZH6OAkHo80yPY8ME1cyHQSWuLqSo/JtIjz/Q1/Tlql7rSfUMRDrZ
 3UruyFz3gKcfaMO8=
X-Received: by 2002:adf:fcc3:: with SMTP id f3mr71222wrs.336.1602697954737;
 Wed, 14 Oct 2020 10:52:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy5fsj+DBEw+rtTeqpEUpjdG+S263PS1xADCPbYn31dIgE1obGoill/d62NR1YdoG56TR4sAg==
X-Received: by 2002:adf:fcc3:: with SMTP id f3mr71200wrs.336.1602697954466;
 Wed, 14 Oct 2020 10:52:34 -0700 (PDT)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id a3sm217883wmb.46.2020.10.14.10.52.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2020 10:52:33 -0700 (PDT)
Date: Wed, 14 Oct 2020 13:52:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ben Widawsky <ben.widawsky@intel.com>
Subject: Re: [PATCH RESEND] pci: Disallow improper BAR registration for type 1
Message-ID: <20201014135146-mutt-send-email-mst@kernel.org>
References: <20201014171853.71130-1-ben.widawsky@intel.com>
MIME-Version: 1.0
In-Reply-To: <20201014171853.71130-1-ben.widawsky@intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 01:12:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 14, 2020 at 10:18:53AM -0700, Ben Widawsky wrote:
> This patch informs future developers working on root complexes, root
> ports, or bridges that also wish to implement a BAR for those. PCI type
> 1 headers only support 2 base address registers. It is incorrect and
> difficult to figure out what is wrong with the device when this mistake
> is made. With this, it is immediate and obvious what has gone wrong.
> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>

How about an assert + a comment?
This is how we usually handle developer bugs. error_report is
for user errors and similar issues ...

> ---
>  hw/pci/pci.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 3c8f10b461..55b0302c57 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -1141,6 +1141,7 @@ void pci_register_bar(PCIDevice *pci_dev, int region_num,
>      uint32_t addr; /* offset in pci config space */
>      uint64_t wmask;
>      pcibus_t size = memory_region_size(memory);
> +    uint8_t hdr_type;
>  
>      assert(region_num >= 0);
>      assert(region_num < PCI_NUM_REGIONS);
> @@ -1150,6 +1151,15 @@ void pci_register_bar(PCIDevice *pci_dev, int region_num,
>          exit(1);
>      }
>  
> +    hdr_type =
> +        pci_dev->config[PCI_HEADER_TYPE] & ~PCI_HEADER_TYPE_MULTI_FUNCTION;
> +    if (hdr_type == PCI_HEADER_TYPE_BRIDGE && region_num > 1) {
> +        error_report("ERROR: PCI Type 1 header only has 2 BARs "
> +                     "requested BAR=%d",
> +                     region_num);
> +        exit(1);
> +    }
> +
>      r = &pci_dev->io_regions[region_num];
>      r->addr = PCI_BAR_UNMAPPED;
>      r->size = size;
> -- 
> 2.28.0


