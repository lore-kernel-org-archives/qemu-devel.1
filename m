Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A664C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 14:51:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7A0F20774
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 14:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ekq2UcYP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7A0F20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGktf-0003Fg-VZ
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 10:51:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33062)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1jGksf-0002Vk-Pq
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 10:50:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1jGkse-0000dw-H6
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 10:50:13 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:33951)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1jGkse-0000dW-Co
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 10:50:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585061412;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zI1iQYeYC9lt1kBrjAHropMSeNOxmOibl4mmPnXMvvM=;
 b=ekq2UcYP+UPerQIq4lgF2ENtrMjxRPcI49yhNpx+yD0xmG0DyWFL+7WF6hEaYkwzVQPFAF
 G5qiXLHQWdcwhUKLATWMkt9pzzH1EBubZhL9wcebnMSzjim1dNMVclR8/Q+UOENqlJDwr5
 OtteiYk1fD3utmBepJswBqK1sR0lkoE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-dxBHpPlMMnKjecfa07nMQw-1; Tue, 24 Mar 2020 10:50:08 -0400
X-MC-Unique: dxBHpPlMMnKjecfa07nMQw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 41EB58018A2;
 Tue, 24 Mar 2020 14:50:05 +0000 (UTC)
Received: from w520.home (ovpn-112-162.phx2.redhat.com [10.3.112.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A77B4171B1;
 Tue, 24 Mar 2020 14:49:54 +0000 (UTC)
Date: Tue, 24 Mar 2020 08:49:54 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v4 0/2] introduction of migration_version attribute for
 VFIO live migration
Message-ID: <20200324084954.0dd835e2@w520.home>
In-Reply-To: <20200324092331.GA2645@work-vm>
References: <20190531004438.24528-1-yan.y.zhao@intel.com>
 <20190603132932.1b5dc7fe@x1.home>
 <20190604003422.GA30229@joy-OptiPlex-7040>
 <20200323152959.1c39e9a7@w520.home>
 <20200324035316.GE5456@joy-OptiPlex-7040>
 <20200324092331.GA2645@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: "cjia@nvidia.com" <cjia@nvidia.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "aik@ozlabs.ru" <aik@ozlabs.ru>,
 "Zhengxiao.zx@alibaba-inc.com" <Zhengxiao.zx@alibaba-inc.com>,
 "shuangtai.tst@alibaba-inc.com" <shuangtai.tst@alibaba-inc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "kwankhede@nvidia.com" <kwankhede@nvidia.com>,
 "eauger@redhat.com" <eauger@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Yang, Ziye" <ziye.yang@intel.com>,
 "mlevitsk@redhat.com" <mlevitsk@redhat.com>,
 "pasic@linux.ibm.com" <pasic@linux.ibm.com>,
 "libvir-list@redhat.com" <libvir-list@redhat.com>,
 "felipe@nutanix.com" <felipe@nutanix.com>, "Ken.Xue@amd.com" <Ken.Xue@amd.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, Yan Zhao <yan.y.zhao@intel.com>,
 "zhenyuw@linux.intel.com" <zhenyuw@linux.intel.com>,
 "dinechin@redhat.com" <dinechin@redhat.com>,
 "intel-gvt-dev@lists.freedesktop.org" <intel-gvt-dev@lists.freedesktop.org>,
 "Liu, Changpeng" <changpeng.liu@intel.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Wang,
 Zhi A" <zhi.a.wang@intel.com>,
 "jonathan.davies@nutanix.com" <jonathan.davies@nutanix.com>, "He,
 Shaopeng" <shaopeng.he@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 24 Mar 2020 09:23:31 +0000
"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:

> * Yan Zhao (yan.y.zhao@intel.com) wrote:
> > On Tue, Mar 24, 2020 at 05:29:59AM +0800, Alex Williamson wrote:  
> > > On Mon, 3 Jun 2019 20:34:22 -0400
> > > Yan Zhao <yan.y.zhao@intel.com> wrote:
> > >   
> > > > On Tue, Jun 04, 2019 at 03:29:32AM +0800, Alex Williamson wrote:  
> > > > > On Thu, 30 May 2019 20:44:38 -0400
> > > > > Yan Zhao <yan.y.zhao@intel.com> wrote:
> > > > >     
> > > > > > This patchset introduces a migration_version attribute under sysfs of VFIO
> > > > > > Mediated devices.
> > > > > > 
> > > > > > This migration_version attribute is used to check migration compatibility
> > > > > > between two mdev devices of the same mdev type.
> > > > > > 
> > > > > > Patch 1 defines migration_version attribute in
> > > > > > Documentation/vfio-mediated-device.txt
> > > > > > 
> > > > > > Patch 2 uses GVT as an example to show how to expose migration_version
> > > > > > attribute and check migration compatibility in vendor driver.    
> > > > > 
> > > > > Thanks for iterating through this, it looks like we've settled on
> > > > > something reasonable, but now what?  This is one piece of the puzzle to
> > > > > supporting mdev migration, but I don't think it makes sense to commit
> > > > > this upstream on its own without also defining the remainder of how we
> > > > > actually do migration, preferably with more than one working
> > > > > implementation and at least prototyped, if not final, QEMU support.  I
> > > > > hope that was the intent, and maybe it's now time to look at the next
> > > > > piece of the puzzle.  Thanks,
> > > > > 
> > > > > Alex    
> > > > 
> > > > Got it. 
> > > > Also thank you and all for discussing and guiding all along:)
> > > > We'll move to the next episode now.  
> > > 
> > > Hi Yan,
> > > 
> > > As we're hopefully moving towards a migration API, would it make sense
> > > to refresh this series at the same time?  I think we're still expecting
> > > a vendor driver implementing Kirti's migration API to also implement
> > > this sysfs interface for compatibility verification.  Thanks,
> > >  
> > Hi Alex
> > Got it!
> > Thanks for reminding of this. And as now we have vfio-pci implementing
> > vendor ops to allow live migration of pass-through devices, is it
> > necessary to implement similar sysfs node for those devices?
> > or do you think just PCI IDs of those devices are enough for libvirt to
> > know device compatibility ?  
> 
> Wasn't the problem that we'd have to know how to check for things like:
>   a) Whether different firmware versions in the device were actually
> compatible
>   b) Whether minor hardware differences were compatible - e.g. some
> hardware might let you migrate to the next version of hardware up.

Yes, minor changes in hardware or firmware that may not be represented
in the device ID or hardware revision.  Also the version is as much for
indicating the compatibility of the vendor defined migration protocol
as it is for the hardware itself.  I certainly wouldn't be so bold as
to create a protocol that is guaranteed compatible forever.  We'll need
to expose the same sysfs attribute in some standard location for
non-mdev devices.  I assume vfio-pci would provide the vendor ops some
mechanism to expose these in a standard namespace of sysfs attributes
under the device itself.  Perhaps that indicates we need to link the
mdev type version under the mdev device as well to make this
transparent to userspace tools like libvirt.  Thanks,

Alex


