Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13AF6C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 18:05:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C39D82067D
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 18:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J8mqjcDF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C39D82067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwUjE-0004MM-UM
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 14:05:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33596)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jwUiQ-0003p2-9m
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 14:04:10 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22159
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jwUiN-0007kt-Jr
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 14:04:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595009045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hwuh1qT9MVPYFQgBuOngocpkahm0SAjR5CoM/gWKArA=;
 b=J8mqjcDFgv0ZqRqSd+W3hMV64j2XDscieHOOyh1nPXCh2UYMf7+Yim0sGwpjKl3pfTlANQ
 MdOtAroAwzON+KnvclyDMY/EwDm5Is6sRlTwPVUf2ukA4p5NsaR4REHInN+Z/3GSfoD29a
 MDWWjyYYUhDRp1YWMtKTGo6c1zxXR/I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-TTwQsQj0MrqM5_1OHLaGCg-1; Fri, 17 Jul 2020 14:04:04 -0400
X-MC-Unique: TTwQsQj0MrqM5_1OHLaGCg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9914D1888AA9;
 Fri, 17 Jul 2020 18:04:01 +0000 (UTC)
Received: from work-vm (ovpn-114-175.ams2.redhat.com [10.36.114.175])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 72B8B61100;
 Fri, 17 Jul 2020 18:03:47 +0000 (UTC)
Date: Fri, 17 Jul 2020 19:03:44 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: device compatibility interface for live migration with assigned
 devices
Message-ID: <20200717180344.GD3294@work-vm>
References: <20200713232957.GD5955@joy-OptiPlex-7040>
 <20200714102129.GD25187@redhat.com>
 <20200714101616.5d3a9e75@x1.home> <20200714171946.GL2728@work-vm>
 <20200714145948.17b95eb3@x1.home>
 <20200715082040.GA13136@joy-OptiPlex-7040>
 <20200717085935.224ffd46@x1.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200717085935.224ffd46@x1.home>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Received-SPF: pass client-ip=205.139.110.61; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/17 01:33:03
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
Cc: kvm@vger.kernel.org, libvir-list@redhat.com, qemu-devel@nongnu.org,
 kwankhede@nvidia.com, eauger@redhat.com, xin-ran.wang@intel.com,
 corbet@lwn.net, openstack-discuss@lists.openstack.org, shaohe.feng@intel.com,
 kevin.tian@intel.com, Yan Zhao <yan.y.zhao@intel.com>, eskultet@redhat.com,
 jian-feng.ding@intel.com, zhenyuw@linux.intel.com, hejie.xu@intel.com,
 bao.yumeng@zte.com.cn, smooney@redhat.com, intel-gvt-dev@lists.freedesktop.org,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 cohuck@redhat.com, dinechin@redhat.com, devel@ovirt.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Alex Williamson (alex.williamson@redhat.com) wrote:
> On Wed, 15 Jul 2020 16:20:41 +0800
> Yan Zhao <yan.y.zhao@intel.com> wrote:
> 
> > On Tue, Jul 14, 2020 at 02:59:48PM -0600, Alex Williamson wrote:
> > > On Tue, 14 Jul 2020 18:19:46 +0100
> > > "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> > >   
> > > > * Alex Williamson (alex.williamson@redhat.com) wrote:  
> > > > > On Tue, 14 Jul 2020 11:21:29 +0100
> > > > > Daniel P. Berrangé <berrange@redhat.com> wrote:
> > > > >     
> > > > > > On Tue, Jul 14, 2020 at 07:29:57AM +0800, Yan Zhao wrote:    
> > > > > > > hi folks,
> > > > > > > we are defining a device migration compatibility interface that helps upper
> > > > > > > layer stack like openstack/ovirt/libvirt to check if two devices are
> > > > > > > live migration compatible.
> > > > > > > The "devices" here could be MDEVs, physical devices, or hybrid of the two.
> > > > > > > e.g. we could use it to check whether
> > > > > > > - a src MDEV can migrate to a target MDEV,
> > > > > > > - a src VF in SRIOV can migrate to a target VF in SRIOV,
> > > > > > > - a src MDEV can migration to a target VF in SRIOV.
> > > > > > >   (e.g. SIOV/SRIOV backward compatibility case)
> > > > > > > 
> > > > > > > The upper layer stack could use this interface as the last step to check
> > > > > > > if one device is able to migrate to another device before triggering a real
> > > > > > > live migration procedure.
> > > > > > > we are not sure if this interface is of value or help to you. please don't
> > > > > > > hesitate to drop your valuable comments.
> > > > > > > 
> > > > > > > 
> > > > > > > (1) interface definition
> > > > > > > The interface is defined in below way:
> > > > > > > 
> > > > > > >              __    userspace
> > > > > > >               /\              \
> > > > > > >              /                 \write
> > > > > > >             / read              \
> > > > > > >    ________/__________       ___\|/_____________
> > > > > > >   | migration_version |     | migration_version |-->check migration
> > > > > > >   ---------------------     ---------------------   compatibility
> > > > > > >      device A                    device B
> > > > > > > 
> > > > > > > 
> > > > > > > a device attribute named migration_version is defined under each device's
> > > > > > > sysfs node. e.g. (/sys/bus/pci/devices/0000\:00\:02.0/$mdev_UUID/migration_version).
> > > > > > > userspace tools read the migration_version as a string from the source device,
> > > > > > > and write it to the migration_version sysfs attribute in the target device.
> > > > > > > 
> > > > > > > The userspace should treat ANY of below conditions as two devices not compatible:
> > > > > > > - any one of the two devices does not have a migration_version attribute
> > > > > > > - error when reading from migration_version attribute of one device
> > > > > > > - error when writing migration_version string of one device to
> > > > > > >   migration_version attribute of the other device
> > > > > > > 
> > > > > > > The string read from migration_version attribute is defined by device vendor
> > > > > > > driver and is completely opaque to the userspace.
> > > > > > > for a Intel vGPU, string format can be defined like
> > > > > > > "parent device PCI ID" + "version of gvt driver" + "mdev type" + "aggregator count".
> > > > > > > 
> > > > > > > for an NVMe VF connecting to a remote storage. it could be
> > > > > > > "PCI ID" + "driver version" + "configured remote storage URL"
> > > > > > > 
> > > > > > > for a QAT VF, it may be
> > > > > > > "PCI ID" + "driver version" + "supported encryption set".
> > > > > > > 
> > > > > > > (to avoid namespace confliction from each vendor, we may prefix a driver name to
> > > > > > > each migration_version string. e.g. i915-v1-8086-591d-i915-GVTg_V5_8-1)    
> > > > > 
> > > > > It's very strange to define it as opaque and then proceed to describe
> > > > > the contents of that opaque string.  The point is that its contents
> > > > > are defined by the vendor driver to describe the device, driver version,
> > > > > and possibly metadata about the configuration of the device.  One
> > > > > instance of a device might generate a different string from another.
> > > > > The string that a device produces is not necessarily the only string
> > > > > the vendor driver will accept, for example the driver might support
> > > > > backwards compatible migrations.    
> > > > 
> > > > (As I've said in the previous discussion, off one of the patch series)
> > > > 
> > > > My view is it makes sense to have a half-way house on the opaqueness of
> > > > this string; I'd expect to have an ID and version that are human
> > > > readable, maybe a device ID/name that's human interpretable and then a
> > > > bunch of other cruft that maybe device/vendor/version specific.
> > > > 
> > > > I'm thinking that we want to be able to report problems and include the
> > > > string and the user to be able to easily identify the device that was
> > > > complaining and notice a difference in versions, and perhaps also use
> > > > it in compatibility patterns to find compatible hosts; but that does
> > > > get tricky when it's a 'ask the device if it's compatible'.  
> > > 
> > > In the reply I just sent to Dan, I gave this example of what a
> > > "compatibility string" might look like represented as json:
> > > 
> > > {
> > >   "device_api": "vfio-pci",
> > >   "vendor": "vendor-driver-name",
> > >   "version": {
> > >     "major": 0,
> > >     "minor": 1
> > >   },
> > >   "vfio-pci": { // Based on above device_api
> > >     "vendor": 0x1234, // Values for the exposed device
> > >     "device": 0x5678,
> > >       // Possibly further parameters for a more specific match
> > >   },
> > >   "mdev_attrs": [
> > >     { "attribute0": "VALUE" }
> > >   ]
> > > }
> > > 
> > > Are you thinking that we might allow the vendor to include a vendor
> > > specific array where we'd simply require that both sides have matching
> > > fields and values?  ie.
> > > 
> > >   "vendor_fields": [
> > >     { "unknown_field0": "unknown_value0" },
> > >     { "unknown_field1": "unknown_value1" },
> > >   ]
> > > 
> > > We could certainly make that part of the spec, but I can't really
> > > figure the value of it other than to severely restrict compatibility,
> > > which the vendor could already do via the version.major value.  Maybe
> > > they'd want to put a build timestamp, random uuid, or source sha1 into
> > > such a field to make absolutely certain compatibility is only determined
> > > between identical builds?  Thanks,
> > >  
> > Yes, I agree kernel could expose such sysfs interface to educate
> > openstack how to filter out devices. But I still think the proposed
> > migration_version (or rename to migration_compatibility) interface is
> > still required for libvirt to do double check.
> > 
> > In the following scenario: 
> > 1. openstack chooses the target device by reading sysfs interface (of json
> > format) of the source device. And Openstack are now pretty sure the two
> > devices are migration compatible.
> > 2. openstack asks libvirt to create the target VM with the target device
> > and start live migration.
> > 3. libvirt now receives the request. so it now has two choices:
> > (1) create the target VM & target device and start live migration directly
> > (2) double check if the target device is compatible with the source
> > device before doing the remaining tasks.
> > 
> > Because the factors to determine whether two devices are live migration
> > compatible are complicated and may be dynamically changing, (e.g. driver
> > upgrade or configuration changes), and also because libvirt should not
> > totally rely on the input from openstack, I think the cost for libvirt is
> > relatively lower if it chooses to go (2) than (1). At least it has no
> > need to cancel migration and destroy the VM if it knows it earlier.
> > 
> > So, it means the kernel may need to expose two parallel interfaces:
> > (1) with json format, enumerating all possible fields and comparing
> > methods, so as to indicate openstack how to find a matching target device
> > (2) an opaque driver defined string, requiring write and test in target,
> > which is used by libvirt to make sure device compatibility, rather than
> > rely on the input accurateness from openstack or rely on kernel driver
> > implementing the compatibility detection immediately after migration
> > start.
> > 
> > Does it make sense?
> 
> No, libvirt is not responsible for the success or failure of the
> migration, it's the vendor driver's responsibility to encode
> compatibility information early in the migration stream and error
> should the incoming device prove to be incompatible.  It's not
> libvirt's job to second guess the management engine and I would not
> support a duplicate interface only for that purpose.  Thanks,

libvirt does try to enforce it for other things; trying to stop a bad
migration from starting.

Dave

> Alex
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


