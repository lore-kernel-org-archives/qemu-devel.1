Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95592C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 19:25:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B506824170
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 19:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xib8qMbQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B506824170
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVJjQ-0003tQ-9G
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 15:25:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45094)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kVJPA-0003Z3-KR
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 15:04:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50531)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kVJP8-0000zo-J3
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 15:04:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603307048;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dEfpTPl9a10INckEvquFrm7/dmolKttPGZfWTWvtqH0=;
 b=Xib8qMbQVwSxsGBgdVH65IArsMHC/pWeMrrXy90VQWeLiu2cVzuZZoD6f/Opgp9l88MDjt
 S5IC7ImxIj8OCJOPOoHAFNhIFrHTglGjPLagcRzFKNAbVE2xf5M0BOv9JmQuJo5t9yTgYv
 zcaAMa+7lN45dv8jEq8c/Sm+Xc6AIuo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-Du9KrthjMyCjMZa86ylLug-1; Wed, 21 Oct 2020 15:04:07 -0400
X-MC-Unique: Du9KrthjMyCjMZa86ylLug-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 98FD4804B68;
 Wed, 21 Oct 2020 19:04:03 +0000 (UTC)
Received: from w520.home (ovpn-112-213.phx2.redhat.com [10.3.112.213])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D63F35D9DD;
 Wed, 21 Oct 2020 19:03:57 +0000 (UTC)
Date: Wed, 21 Oct 2020 13:03:57 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v26 03/17] vfio: Add save and load functions for VFIO
 PCI devices
Message-ID: <20201021130357.7eab9f3e@w520.home>
In-Reply-To: <c37eebe4-45d1-ea55-0540-3a2aecea442b@huawei.com>
References: <1600817059-26721-1-git-send-email-kwankhede@nvidia.com>
 <1600817059-26721-4-git-send-email-kwankhede@nvidia.com>
 <20200924164905.1a2f1384@x1.home>
 <c37eebe4-45d1-ea55-0540-3a2aecea442b@huawei.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 22:12:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: cohuck@redhat.com, cjia@nvidia.com, aik@ozlabs.ru,
 Zhengxiao.zx@Alibaba-inc.com, shuangtai.tst@alibaba-inc.com,
 qemu-devel@nongnu.org, peterx@redhat.com,
 Kirti Wankhede <kwankhede@nvidia.com>, eauger@redhat.com, yi.l.liu@intel.com,
 eskultet@redhat.com, ziye.yang@intel.com, armbru@redhat.com,
 mlevitsk@redhat.com, pasic@linux.ibm.com, felipe@nutanix.com,
 wanghaibin.wang@huawei.com, zhi.a.wang@intel.com, kevin.tian@intel.com,
 yan.y.zhao@intel.com, dgilbert@redhat.com, changpeng.liu@intel.com,
 quintela@redhat.com, lushenming@huawei.com, Ken.Xue@amd.com,
 jonathan.davies@nutanix.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 21 Oct 2020 17:30:04 +0800
Zenghui Yu <yuzenghui@huawei.com> wrote:

> On 2020/9/25 6:49, Alex Williamson wrote:
> >> +    } else if (interrupt_type == VFIO_INT_MSIX) {
> >> +        uint16_t offset;
> >> +
> >> +        msix_load(pdev, f);
> >> +        offset = pci_default_read_config(pdev,
> >> +                                       pdev->msix_cap + PCI_MSIX_FLAGS + 1, 2);
> >> +        /* load enable bit and maskall bit */
> >> +        vfio_pci_write_config(pdev, pdev->msix_cap + PCI_MSIX_FLAGS + 1,
> >> +                              offset, 2);  
> 
> It isn't clear that what purpose this load operation serves.  The config
> space has already been restored and we'll see that MSI-X _was_ and _is_
> enabled (or disabled).  vfio_msix_enable() will therefore not be invoked
> and no vectors would actually be enabled...  Not sure if I had missed
> something.

Yeah, afaict your interpretation is correct.  I think the intention was
to mimic userspace preforming a write to set the enable bit, but
re-writing it doesn't change the vconfig value, so the effect is not
the same.  I think this probably never worked.

> >> +    }
> >> +    return 0;  
> > 
> > It seems this could be simplified down to:
> > 
> > if (msi_enabled(pdev)) {
> >      vfio_msi_enable(vdev);
> > } else if (msix_enabled(pdev)) {
> >      msix_load(pdev, f);
> >      vfio_msix_enable(vdev);
> > }  
> 
> And it seems that this has fixed something :-)

Yep, no dependency on the value changing, simply set the state to that
indicated in vconfig.  Thanks,

Alex


