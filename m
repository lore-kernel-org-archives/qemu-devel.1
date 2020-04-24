Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99AE9C54FD0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 19:14:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52B1E20774
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 19:14:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cjFsDjt2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52B1E20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jS3mW-0000mm-DE
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 15:14:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51034)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jS3jR-0005Ja-EV
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 15:11:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jS3jQ-0003H2-Al
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 15:11:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56402
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jS3jP-0003Es-Rl
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 15:11:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587755482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JjOS1wX2ETIang6bs9uwcXb1p1OmHUnBg9ALBvBbgS4=;
 b=cjFsDjt2gAP+lAcGqG2t3GRdN6QBz5AXsyjmViuOQTkmOt+ANqnuwrAUkCDe+7rH5b9OPp
 3/1U/vm/itbYGnbpfPLwoVXB6C0qIm5bxxFXNRVvsETrVYUGoG1INAC9j5EAJv0P6yh1wf
 OAFJNZPvaui8P5BYOn2Jb2a2d43FsBg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-CQCjUJiOP9yrtaTh1iTeeQ-1; Fri, 24 Apr 2020 15:11:12 -0400
X-MC-Unique: CQCjUJiOP9yrtaTh1iTeeQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 531AB8014D9;
 Fri, 24 Apr 2020 19:11:09 +0000 (UTC)
Received: from work-vm (ovpn-113-179.ams2.redhat.com [10.36.113.179])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A63515C1D0;
 Fri, 24 Apr 2020 19:10:51 +0000 (UTC)
Date: Fri, 24 Apr 2020 20:10:49 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Subject: Re: [PATCH v5 0/4] introduction of migration_version attribute for
 VFIO live migration
Message-ID: <20200424191049.GU3106@work-vm>
References: <20200413055201.27053-1-yan.y.zhao@intel.com>
 <20200417104450.2d2f2fa9.cohuck@redhat.com>
 <20200417095202.GD16688@joy-OptiPlex-7040>
 <20200417132457.45d91fe3.cohuck@redhat.com>
 <20200420012457.GE16688@joy-OptiPlex-7040>
 <20200420165600.4951ae82@w520.home>
 <20200421023718.GA12111@joy-OptiPlex-7040>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D86DF06@SHSMSX104.ccr.corp.intel.com>
 <20200422073628.GA12879@joy-OptiPlex-7040>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422073628.GA12879@joy-OptiPlex-7040>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Received-SPF: pass client-ip=205.139.110.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 15:11:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Cornelia Huck <cohuck@redhat.com>, "cjia@nvidia.com" <cjia@nvidia.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "libvir-list@redhat.com" <libvir-list@redhat.com>,
 "Zhengxiao.zx@alibaba-inc.com" <Zhengxiao.zx@alibaba-inc.com>,
 "shuangtai.tst@alibaba-inc.com" <shuangtai.tst@alibaba-inc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "kwankhede@nvidia.com" <kwankhede@nvidia.com>,
 "eauger@redhat.com" <eauger@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "corbet@lwn.net" <corbet@lwn.net>, "Yang, Ziye" <ziye.yang@intel.com>,
 "mlevitsk@redhat.com" <mlevitsk@redhat.com>,
 "pasic@linux.ibm.com" <pasic@linux.ibm.com>, "aik@ozlabs.ru" <aik@ozlabs.ru>,
 "felipe@nutanix.com" <felipe@nutanix.com>, "Ken.Xue@amd.com" <Ken.Xue@amd.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Zeng, Xin" <xin.zeng@intel.com>,
 "zhenyuw@linux.intel.com" <zhenyuw@linux.intel.com>,
 "jonathan.davies@nutanix.com" <jonathan.davies@nutanix.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "intel-gvt-dev@lists.freedesktop.org" <intel-gvt-dev@lists.freedesktop.org>,
 "Liu, Changpeng" <changpeng.liu@intel.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "eskultet@redhat.com" <eskultet@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Wang,
 Zhi A" <zhi.a.wang@intel.com>, "dinechin@redhat.com" <dinechin@redhat.com>,
 "He, Shaopeng" <shaopeng.he@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Yan Zhao (yan.y.zhao@intel.com) wrote:
> On Tue, Apr 21, 2020 at 08:08:49PM +0800, Tian, Kevin wrote:
> > > From: Yan Zhao
> > > Sent: Tuesday, April 21, 2020 10:37 AM
> > > 
> > > On Tue, Apr 21, 2020 at 06:56:00AM +0800, Alex Williamson wrote:
> > > > On Sun, 19 Apr 2020 21:24:57 -0400
> > > > Yan Zhao <yan.y.zhao@intel.com> wrote:
> > > >
> > > > > On Fri, Apr 17, 2020 at 07:24:57PM +0800, Cornelia Huck wrote:
> > > > > > On Fri, 17 Apr 2020 05:52:02 -0400
> > > > > > Yan Zhao <yan.y.zhao@intel.com> wrote:
> > > > > >
> > > > > > > On Fri, Apr 17, 2020 at 04:44:50PM +0800, Cornelia Huck wrote:
> > > > > > > > On Mon, 13 Apr 2020 01:52:01 -0400
> > > > > > > > Yan Zhao <yan.y.zhao@intel.com> wrote:
> > > > > > > >
> > > > > > > > > This patchset introduces a migration_version attribute under sysfs
> > > of VFIO
> > > > > > > > > Mediated devices.
> > > > > > > > >
> > > > > > > > > This migration_version attribute is used to check migration
> > > compatibility
> > > > > > > > > between two mdev devices.
> > > > > > > > >
> > > > > > > > > Currently, it has two locations:
> > > > > > > > > (1) under mdev_type node,
> > > > > > > > >     which can be used even before device creation, but only for
> > > mdev
> > > > > > > > >     devices of the same mdev type.
> > > > > > > > > (2) under mdev device node,
> > > > > > > > >     which can only be used after the mdev devices are created, but
> > > the src
> > > > > > > > >     and target mdev devices are not necessarily be of the same
> > > mdev type
> > > > > > > > > (The second location is newly added in v5, in order to keep
> > > consistent
> > > > > > > > > with the migration_version node for migratable pass-though
> > > devices)
> > > > > > > >
> > > > > > > > What is the relationship between those two attributes?
> > > > > > > >
> > > > > > > (1) is for mdev devices specifically, and (2) is provided to keep the
> > > same
> > > > > > > sysfs interface as with non-mdev cases. so (2) is for both mdev
> > > devices and
> > > > > > > non-mdev devices.
> > > > > > >
> > > > > > > in future, if we enable vfio-pci vendor ops, (i.e. a non-mdev device
> > > > > > > is binding to vfio-pci, but is able to register migration region and do
> > > > > > > migration transactions from a vendor provided affiliate driver),
> > > > > > > the vendor driver would export (2) directly, under device node.
> > > > > > > It is not able to provide (1) as there're no mdev devices involved.
> > > > > >
> > > > > > Ok, creating an alternate attribute for non-mdev devices makes sense.
> > > > > > However, wouldn't that rather be a case (3)? The change here only
> > > > > > refers to mdev devices.
> > > > > >
> > > > > as you pointed below, (3) and (2) serve the same purpose.
> > > > > and I think a possible usage is to migrate between a non-mdev device and
> > > > > an mdev device. so I think it's better for them both to use (2) rather
> > > > > than creating (3).
> > > >
> > > > An mdev type is meant to define a software compatible interface, so in
> > > > the case of mdev->mdev migration, doesn't migrating to a different type
> > > > fail the most basic of compatibility tests that we expect userspace to
> > > > perform?  IOW, if two mdev types are migration compatible, it seems a
> > > > prerequisite to that is that they provide the same software interface,
> > > > which means they should be the same mdev type.
> > > >
> > > > In the hybrid cases of mdev->phys or phys->mdev, how does a
> > > management
> > > > tool begin to even guess what might be compatible?  Are we expecting
> > > > libvirt to probe ever device with this attribute in the system?  Is
> > > > there going to be a new class hierarchy created to enumerate all
> > > > possible migrate-able devices?
> > > >
> > > yes, management tool needs to guess and test migration compatible
> > > between two devices. But I think it's not the problem only for
> > > mdev->phys or phys->mdev. even for mdev->mdev, management tool needs
> > > to
> > > first assume that the two mdevs have the same type of parent devices
> > > (e.g.their pciids are equal). otherwise, it's still enumerating
> > > possibilities.
> > > 
> > > on the other hand, for two mdevs,
> > > mdev1 from pdev1, its mdev_type is 1/2 of pdev1;
> > > mdev2 from pdev2, its mdev_type is 1/4 of pdev2;
> > > if pdev2 is exactly 2 times of pdev1, why not allow migration between
> > > mdev1 <-> mdev2.
> > 
> > How could the manage tool figure out that 1/2 of pdev1 is equivalent 
> > to 1/4 of pdev2? If we really want to allow such thing happen, the best
> > choice is to report the same mdev type on both pdev1 and pdev2.
> I think that's exactly the value of this migration_version interface.
> the management tool can take advantage of this interface to know if two
> devices are migration compatible, no matter they are mdevs, non-mdevs,
> or mix.
> 
> as I know, (please correct me if not right), current libvirt still
> requires manually generating mdev devices, and it just duplicates src vm
> configuration to the target vm.
> for libvirt, currently it's always phys->phys and mdev->mdev (and of the
> same mdev type).
> But it does not justify that hybrid cases should not be allowed. otherwise,
> why do we need to introduce this migration_version interface and leave
> the judgement of migration compatibility to vendor driver? why not simply
> set the criteria to something like "pciids of parent devices are equal,
> and mdev types are equal" ?
> 
> 
> > btw mdev<->phys just brings trouble to upper stack as Alex pointed out. 
> could you help me understand why it will bring trouble to upper stack?
> 
> I think it just needs to read src migration_version under src dev node,
> and test it in target migration version under target dev node. 
> 
> after all, through this interface we just help the upper layer
> knowing available options through reading and testing, and they decide
> to use it or not.
> 
> > Can we simplify the requirement by allowing only mdev<->mdev and 
> > phys<->phys migration? If an customer does want to migrate between a 
> > mdev and phys, he could wrap physical device into a wrapped mdev 
> > instance (with the same type as the source mdev) instead of using vendor 
> > ops. Doing so does add some burden but if mdev<->phys is not dominant 
> > usage then such tradeoff might be worthywhile...
> >
> If the interfaces for phys<->phys and mdev<->mdev are consistent, it makes no
> difference to phys<->mdev, right?
> I think the vendor string for a mdev device is something like:
> "Parent PCIID + mdev type + software version", and
> that for a phys device is something like:
> "PCIID + software version".
> as long as we don't migrate between devices from different vendors, it's
> easy for vendor driver to tell if a phys device is migration compatible
> to a mdev device according it supports it or not.

It surprises me that the PCIID matching is a requirement; I'd assumed
with this clever mdev name setup that you could migrate between two
different models in a series, or to a newer model, as long as they
both supported the same mdev view.

Dave

> 
> Thanks
> Yan
> > 
> > > 
> > > 
> > > > I agree that there was a gap in the previous proposal for non-mdev
> > > > devices, but I think this bring a lot of questions that we need to
> > > > puzzle through and libvirt will need to re-evaluate how they might
> > > > decide to pick a migration target device.  For example, I'm sure
> > > > libvirt would reject any policy decisions regarding picking a physical
> > > > device versus an mdev device.  Had we previously left it that only a
> > > > layer above libvirt would select a target device and libvirt only tests
> > > > compatibility to that target device?
> > > I'm not sure if there's a layer above libvirt would select a target
> > > device. but if there is such a layer (even it's human), we need to
> > > provide an interface for them to know whether their decision is suitable
> > > for migration. The migration_version interface provides a potential to
> > > allow mdev->phys migration, even libvirt may currently reject it.
> > > 
> > > 
> > > > We also need to consider that this expands the namespace.  If we no
> > > > longer require matching types as the first level of comparison, then
> > > > vendor migration strings can theoretically collide.  How do we
> > > > coordinate that can't happen?  Thanks,
> > > yes, it's indeed a problem.
> > > could only allowing migration beteen devices from the same vendor be a
> > > good
> > > prerequisite?
> > > 
> > > Thanks
> > > Yan
> > > >
> > > > > > > > Is existence (and compatibility) of (1) a pre-req for possible
> > > > > > > > existence (and compatibility) of (2)?
> > > > > > > >
> > > > > > > no. (2) does not reply on (1).
> > > > > >
> > > > > > Hm. Non-existence of (1) seems to imply "this type does not support
> > > > > > migration". If an mdev created for such a type suddenly does support
> > > > > > migration, it feels a bit odd.
> > > > > >
> > > > > yes. but I think if the condition happens, it should be reported a bug
> > > > > to vendor driver.
> > > > > should I add a line in the doc like "vendor driver should ensure that the
> > > > > migration compatibility from migration_version under mdev_type should
> > > be
> > > > > consistent with that from migration_version under device node" ?
> > > > >
> > > > > > (It obviously cannot be a prereq for what I called (3) above.)
> > > > > >
> > > > > > >
> > > > > > > > Does userspace need to check (1) or can it completely rely on (2), if
> > > > > > > > it so chooses?
> > > > > > > >
> > > > > > > I think it can completely reply on (2) if compatibility check before
> > > > > > > mdev creation is not required.
> > > > > > >
> > > > > > > > If devices with a different mdev type are indeed compatible, it
> > > seems
> > > > > > > > userspace can only find out after the devices have actually been
> > > > > > > > created, as (1) does not apply?
> > > > > > > yes, I think so.
> > > > > >
> > > > > > How useful would it be for userspace to even look at (1) in that case?
> > > > > > It only knows if things have a chance of working if it actually goes
> > > > > > ahead and creates devices.
> > > > > >
> > > > > hmm, is it useful for userspace to test the migration_version under mdev
> > > > > type before it knows what mdev device to generate ?
> > > > > like when the userspace wants to migrate an mdev device in src vm,
> > > > > but it has not created target vm and the target mdev device.
> > > > >
> > > > > > >
> > > > > > > > One of my worries is that the existence of an attribute with the
> > > same
> > > > > > > > name in two similar locations might lead to confusion. But maybe it
> > > > > > > > isn't a problem.
> > > > > > > >
> > > > > > > Yes, I have the same feeling. but as (2) is for sysfs interface
> > > > > > > consistency, to make it transparent to userspace tools like libvirt,
> > > > > > > I guess the same name is necessary?
> > > > > >
> > > > > > What do we actually need here, I wonder? (1) and (2) seem to serve
> > > > > > slightly different purposes, while (2) and what I called (3) have the
> > > > > > same purpose. Is it important to userspace that (1) and (2) have the
> > > > > > same name?
> > > > > so change (1) to migration_type_version and (2) to
> > > > > migration_instance_version?
> > > > > But as they are under different locations, could that location imply
> > > > > enough information?
> > > > >
> > > > >
> > > > > Thanks
> > > > > Yan
> > > > >
> > > > >
> > > >
> > > _______________________________________________
> > > intel-gvt-dev mailing list
> > > intel-gvt-dev@lists.freedesktop.org
> > > https://lists.freedesktop.org/mailman/listinfo/intel-gvt-dev
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


