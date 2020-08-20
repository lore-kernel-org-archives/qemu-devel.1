Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76094C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 03:14:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 395532078B
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 03:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VihxZfjc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 395532078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8b2O-0000aK-EU
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 23:14:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51482)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1k8b1k-0008Ia-Am
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 23:14:08 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25658
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1k8b1h-0002Zr-GN
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 23:14:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597893244;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1uL6oaieNOxO0lNuxORuGUFqqOmdlfIgO2Muo0Z8fB0=;
 b=VihxZfjcGkQj3HWY4eqa6qD3NJEOFsoNHs3oYzUBK0oS07vqD3cwYGp8mAuWzH3Ulhq/rp
 FTEqdMrrU3R6G9eYl4K/UxNDfy40Nj/CV4Zk8ctBBWedw0fVEBd4x9tsIoZwxDh4AUkaP/
 8B9sGyBCmLyMYqf98yECJY5uS33Qj3w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-AueevQPFNxOMCGZ_BIsASA-1; Wed, 19 Aug 2020 23:13:58 -0400
X-MC-Unique: AueevQPFNxOMCGZ_BIsASA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A0140802B47;
 Thu, 20 Aug 2020 03:13:54 +0000 (UTC)
Received: from x1.home (ovpn-112-71.phx2.redhat.com [10.3.112.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 75CD27A40D;
 Thu, 20 Aug 2020 03:13:46 +0000 (UTC)
Date: Wed, 19 Aug 2020 21:13:45 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Subject: Re: device compatibility interface for live migration with assigned
 devices
Message-ID: <20200819211345.0d9daf03@x1.home>
In-Reply-To: <20200820001810.GD21172@joy-OptiPlex-7040>
References: <e6e75807-0614-bd75-aeb6-64d643e029d3@redhat.com>
 <20200814051601.GD15344@joy-OptiPlex-7040>
 <a51209fe-a8c6-941f-ff54-7be06d73bc44@redhat.com>
 <20200818085527.GB20215@redhat.com>
 <3a073222-dcfe-c02d-198b-29f6a507b2e1@redhat.com>
 <20200818091628.GC20215@redhat.com>
 <20200818113652.5d81a392.cohuck@redhat.com>
 <BY5PR12MB4322C9D1A66C4657776A1383DC5C0@BY5PR12MB4322.namprd12.prod.outlook.com>
 <20200819033035.GA21172@joy-OptiPlex-7040>
 <20200819115021.004427a3@x1.home>
 <20200820001810.GD21172@joy-OptiPlex-7040>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Received-SPF: pass client-ip=207.211.31.81;
 envelope-from=alex.williamson@redhat.com; helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 20:12:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "libvir-list@redhat.com" <libvir-list@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Kirti Wankhede <kwankhede@nvidia.com>, "eauger@redhat.com" <eauger@redhat.com>,
 "xin-ran.wang@intel.com" <xin-ran.wang@intel.com>,
 "corbet@lwn.net" <corbet@lwn.net>, "openstack-discuss@lists.openstack.org"
 <openstack-discuss@lists.openstack.org>,
 "shaohe.feng@intel.com" <shaohe.feng@intel.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>,
 Parav Pandit <parav@mellanox.com>,
 "jian-feng.ding@intel.com" <jian-feng.ding@intel.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "zhenyuw@linux.intel.com" <zhenyuw@linux.intel.com>,
 "hejie.xu@intel.com" <hejie.xu@intel.com>,
 "bao.yumeng@zte.com.cn" <bao.yumeng@zte.com.cn>,
 Jiri Pirko <jiri@mellanox.com>, "eskultet@redhat.com" <eskultet@redhat.com>,
 Parav Pandit <parav@nvidia.com>, "smooney@redhat.com" <smooney@redhat.com>,
 "intel-gvt-dev@lists.freedesktop.org" <intel-gvt-dev@lists.freedesktop.org>,
 "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, "dinechin@redhat.com" <dinechin@redhat.com>,
 "devel@ovirt.org" <devel@ovirt.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 20 Aug 2020 08:18:10 +0800
Yan Zhao <yan.y.zhao@intel.com> wrote:

> On Wed, Aug 19, 2020 at 11:50:21AM -0600, Alex Williamson wrote:
> <...>
> > > > > > What I care about is that we have a *standard* userspace API for
> > > > > > performing device compatibility checking / state migration, for use by
> > > > > > QEMU/libvirt/ OpenStack, such that we can write code without countless
> > > > > > vendor specific code paths.
> > > > > >
> > > > > > If there is vendor specific stuff on the side, that's fine as we can
> > > > > > ignore that, but the core functionality for device compat / migration
> > > > > > needs to be standardized.    
> > > > > 
> > > > > To summarize:
> > > > > - choose one of sysfs or devlink
> > > > > - have a common interface, with a standardized way to add
> > > > >   vendor-specific attributes
> > > > > ?    
> > > > 
> > > > Please refer to my previous email which has more example and details.    
> > > hi Parav,
> > > the example is based on a new vdpa tool running over netlink, not based
> > > on devlink, right?
> > > For vfio migration compatibility, we have to deal with both mdev and physical
> > > pci devices, I don't think it's a good idea to write a new tool for it, given
> > > we are able to retrieve the same info from sysfs and there's already an
> > > mdevctl from Alex (https://github.com/mdevctl/mdevctl).
> > > 
> > > hi All,
> > > could we decide that sysfs is the interface that every VFIO vendor driver
> > > needs to provide in order to support vfio live migration, otherwise the
> > > userspace management tool would not list the device into the compatible
> > > list?
> > > 
> > > if that's true, let's move to the standardizing of the sysfs interface.
> > > (1) content
> > > common part: (must)
> > >    - software_version: (in major.minor.bugfix scheme)
> > >    - device_api: vfio-pci or vfio-ccw ...
> > >    - type: mdev type for mdev device or
> > >            a signature for physical device which is a counterpart for
> > > 	   mdev type.
> > > 
> > > device api specific part: (must)
> > >   - pci id: pci id of mdev parent device or pci id of physical pci
> > >     device (device_api is vfio-pci)  
> > 
> > As noted previously, the parent PCI ID should not matter for an mdev
> > device, if a vendor has a dependency on matching the parent device PCI
> > ID, that's a vendor specific restriction.  An mdev device can also
> > expose a vfio-pci device API without the parent device being PCI.  For
> > a physical PCI device, shouldn't the PCI ID be encompassed in the
> > signature?  Thanks,
> >   
> you are right. I need to put the PCI ID as a vendor specific field.
> I didn't do that because I wanted all fields in vendor specific to be
> configurable by management tools, so they can configure the target device
> according to the value of a vendor specific field even they don't know
> the meaning of the field.
> But maybe they can just ignore the field when they can't find a matching
> writable field to configure the target.


If fields can be ignored, what's the point of reporting them?  Seems
it's no longer a requirement.  Thanks,

Alex


> > >   - subchannel_type (device_api is vfio-ccw) 
> > >  
> > > vendor driver specific part: (optional)
> > >   - aggregator
> > >   - chpid_type
> > >   - remote_url
> > > 
> > > NOTE: vendors are free to add attributes in this part with a
> > > restriction that this attribute is able to be configured with the same
> > > name in sysfs too. e.g.
> > > for aggregator, there must be a sysfs attribute in device node
> > > /sys/devices/pci0000:00/0000:00:02.0/882cc4da-dede-11e7-9180-078a62063ab1/intel_vgpu/aggregator,
> > > so that the userspace tool is able to configure the target device
> > > according to source device's aggregator attribute.
> > > 
> > > 
> > > (2) where and structure
> > > proposal 1:
> > > |- [path to device]
> > >   |--- migration
> > >   |     |--- self
> > >   |     |    |-software_version
> > >   |     |    |-device_api
> > >   |     |    |-type
> > >   |     |    |-[pci_id or subchannel_type]
> > >   |     |    |-<aggregator or chpid_type>
> > >   |     |--- compatible
> > >   |     |    |-software_version
> > >   |     |    |-device_api
> > >   |     |    |-type
> > >   |     |    |-[pci_id or subchannel_type]
> > >   |     |    |-<aggregator or chpid_type>
> > > multiple compatible is allowed.
> > > attributes should be ASCII text files, preferably with only one value
> > > per file.
> > > 
> > > 
> > > proposal 2: use bin_attribute.
> > > |- [path to device]
> > >   |--- migration
> > >   |     |--- self
> > >   |     |--- compatible
> > > 
> > > so we can continue use multiline format. e.g.
> > > cat compatible
> > >   software_version=0.1.0
> > >   device_api=vfio_pci
> > >   type=i915-GVTg_V5_{val1:int:1,2,4,8}
> > >   pci_id=80865963
> > >   aggregator={val1}/2
> > > 
> > > Thanks
> > > Yan
> > >   
> >   
> 


