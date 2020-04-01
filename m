Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CDA2C43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 19:43:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02D8320714
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 19:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NqwwB1t8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02D8320714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJjGN-0003jb-4v
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 15:42:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37390)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1jJjFg-0003IV-Jj
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 15:42:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1jJjFe-0006DK-Py
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 15:42:15 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57481
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1jJjFe-0006Cs-K9
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 15:42:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585770133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hiGTxk8LQ2YCQ0ihZF9BnWSKWQbXmsmvEdOyl/Ln0V0=;
 b=NqwwB1t8XCpY9a5HqipCeNKNfV03zEOBa9BtVrSBlCtPMn+crKSg4f7xQ22iejG7dbyjfu
 31QiVDGWfhjxQoBFPdwaUj7bea/ClEB60J7Z/q+VPE0DFK1x8LuNNlGPq7V6AbRm6ke68L
 aoi3s782zTs+Ib51J+3mF+J8/sihJBg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-CkJDsNvzPG6jDcY_3VWDug-1; Wed, 01 Apr 2020 15:42:09 -0400
X-MC-Unique: CkJDsNvzPG6jDcY_3VWDug-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 431F6107ACCA;
 Wed,  1 Apr 2020 19:42:07 +0000 (UTC)
Received: from w520.home (ovpn-112-162.phx2.redhat.com [10.3.112.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D26E760BE2;
 Wed,  1 Apr 2020 19:42:02 +0000 (UTC)
Date: Wed, 1 Apr 2020 13:42:02 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v16 QEMU 12/16] memory: Set DIRTY_MEMORY_MIGRATION when
 IOMMU is enabled
Message-ID: <20200401134202.40dd13e0@w520.home>
In-Reply-To: <20200401190032.GI52559@work-vm>
References: <1585084154-29461-1-git-send-email-kwankhede@nvidia.com>
 <1585084154-29461-13-git-send-email-kwankhede@nvidia.com>
 <20200401190032.GI52559@work-vm>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Zhengxiao.zx@alibaba-inc.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 cjia@nvidia.com, eskultet@redhat.com, ziye.yang@intel.com, cohuck@redhat.com,
 shuangtai.tst@alibaba-inc.com, qemu-devel@nongnu.org, zhi.a.wang@intel.com,
 mlevitsk@redhat.com, pasic@linux.ibm.com, aik@ozlabs.ru,
 Kirti Wankhede <kwankhede@nvidia.com>, eauger@redhat.com, felipe@nutanix.com,
 jonathan.davies@nutanix.com, yan.y.zhao@intel.com, changpeng.liu@intel.com,
 Ken.Xue@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 1 Apr 2020 20:00:32 +0100
"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:

> * Kirti Wankhede (kwankhede@nvidia.com) wrote:
> > Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> > ---
> >  memory.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/memory.c b/memory.c
> > index acb7546971c3..285ca2ed6dd9 100644
> > --- a/memory.c
> > +++ b/memory.c
> > @@ -1788,7 +1788,7 @@ bool memory_region_is_ram_device(MemoryRegion *mr)
> >  uint8_t memory_region_get_dirty_log_mask(MemoryRegion *mr)
> >  {
> >      uint8_t mask = mr->dirty_log_mask;
> > -    if (global_dirty_log && mr->ram_block) {
> > +    if (global_dirty_log && (mr->ram_block || memory_region_is_iommu(mr))) {
> >          mask |= (1 << DIRTY_MEMORY_MIGRATION);  
> 
> I'm missing why the two go together here.
> What does 'is_iommu' really mean?

I take that to mean MemoryRegion is translated by an IOMMU, ie. it's an
IOVA range of the IOMMU.  Therefore we're adding it to dirty log
tracking, just as we do for ram blocks.  At least that's my
interpretation of what it's supposed to do, I'm not an expert here on
whether it's the right way to do that.  Thanks,

Alex


