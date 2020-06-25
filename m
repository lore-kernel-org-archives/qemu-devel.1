Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73208C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 17:42:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AE5420781
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 17:42:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gwtqU65+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AE5420781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joVtN-0007rZ-7h
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 13:42:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50812)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1joVrs-0006HA-Di
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 13:40:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23399
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1joVrp-0006YZ-VT
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 13:40:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593106853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4npFYX8ALzjAX3e3AtO89BrXJFgiCwUkLpSINdxRGYQ=;
 b=gwtqU65+UOFtgFLQwUiPbMlRLYsmII+3bBORwOX3yV2nIQgh1zz9JqV7Ef5RX1Ra04wF5g
 kT3ZEzXHH117HRzj9z7GM3RX8emhJO7UrBO/V2+2wQp5a5qeRH6lK+ZeVCkF11WBUl3RVL
 fVjJV9g/KXcjfIf36w+i6kt+yTQ4nGc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-BnUCZ25sMMavUTOEDPkDEg-1; Thu, 25 Jun 2020 13:40:48 -0400
X-MC-Unique: BnUCZ25sMMavUTOEDPkDEg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E41891005512;
 Thu, 25 Jun 2020 17:40:45 +0000 (UTC)
Received: from x1.home (ovpn-112-156.phx2.redhat.com [10.3.112.156])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DAC5E71688;
 Thu, 25 Jun 2020 17:40:39 +0000 (UTC)
Date: Thu, 25 Jun 2020 11:40:39 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>, <peterx@redhat.com>
Subject: Re: [PATCH QEMU v25 13/17] vfio: create mapped iova list when
 vIOMMU is enabled
Message-ID: <20200625114039.566b0914@x1.home>
In-Reply-To: <b0ee702d-02e5-4cd6-6dcc-047cfcb907b2@nvidia.com>
References: <1592684486-18511-1-git-send-email-kwankhede@nvidia.com>
 <1592684486-18511-14-git-send-email-kwankhede@nvidia.com>
 <20200624125526.5488954c@x1.home>
 <b0ee702d-02e5-4cd6-6dcc-047cfcb907b2@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120;
 envelope-from=alex.williamson@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 00:45:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 qemu-devel@nongnu.org, eauger@redhat.com, yi.l.liu@intel.com,
 quintela@redhat.com, ziye.yang@intel.com, armbru@redhat.com,
 mlevitsk@redhat.com, pasic@linux.ibm.com, felipe@nutanix.com,
 zhi.a.wang@intel.com, kevin.tian@intel.com, yan.y.zhao@intel.com,
 dgilbert@redhat.com, changpeng.liu@intel.com, eskultet@redhat.com,
 Ken.Xue@amd.com, jonathan.davies@nutanix.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 25 Jun 2020 20:04:08 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> On 6/25/2020 12:25 AM, Alex Williamson wrote:
> > On Sun, 21 Jun 2020 01:51:22 +0530
> > Kirti Wankhede <kwankhede@nvidia.com> wrote:
> >   
> >> Create mapped iova list when vIOMMU is enabled. For each mapped iova
> >> save translated address. Add node to list on MAP and remove node from
> >> list on UNMAP.
> >> This list is used to track dirty pages during migration.  
> > 
> > This seems like a lot of overhead to support that the VM might migrate.
> > Is there no way we can build this when we start migration, for example
> > replaying the mappings at that time?  Thanks,
> >   
> 
> In my previous version I tried to go through whole range and find valid 
> iotlb, as below:
> 
> +        if (memory_region_is_iommu(section->mr)) {
> +            iotlb = address_space_get_iotlb_entry(container->space->as, 
> iova,
> +                                                 true, 
> MEMTXATTRS_UNSPECIFIED);
> 
> When mapping doesn't exist, qemu throws error as below:
> 
> qemu-system-x86_64: vtd_iova_to_slpte: detected slpte permission error 
> (iova=0x0, level=0x3, slpte=0x0, write=1)
> qemu-system-x86_64: vtd_iommu_translate: detected translation failure 
> (dev=00:03:00, iova=0x0)
> qemu-system-x86_64: New fault is not recorded due to compression of faults

My assumption would have been that we use the replay mechanism, which
is known to work because we need to use it when we hot-add a device.
We'd make use of iommu_notifier_init() to create a new handler for this
purpose, then we'd walk our container->giommu_list and call
memory_region_iommu_replay() for each.

Peter, does this sound like the right approach to you?

> Secondly, it iterates through whole range with IOMMU page size 
> granularity which is 4K, so it takes long time resulting in large 
> downtime. With this optimization, downtime with vIOMMU reduced 
> significantly.

Right, but we amortize that overhead and the resulting bloat across the
99.9999% of the time that we're not migrating.  I wonder if we could
startup another thread to handle this when we enable dirty logging.  We
don't really need the result until we start processing the dirty
bitmap, right?  Also, if we're dealing with this many separate pages,
shouldn't we be using a tree rather than a list to give us O(logN)
rather than O(N)?
 
> Other option I will try if I can check that if migration is supported 
> then only create this list.

Wouldn't we still have problems if we start with a guest IOMMU domain
with a device that doesn't support migration, hot-add a device that
does support migration, then hot-remove the original device?  Seems
like our list would only be complete since the migration device was
added.  Thanks,

Alex


