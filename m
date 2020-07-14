Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED04C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 14:05:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FBBC22456
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 14:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U84QadVv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FBBC22456
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvLYK-0005DQ-Pj
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 10:05:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41680)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smooney@redhat.com>)
 id 1jvK9K-000545-9L
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 08:35:06 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47297
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <smooney@redhat.com>)
 id 1jvK9H-0000sJ-HI
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 08:35:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594730101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t56q2i2kWe5qidncJEOdhkmzgAnPO6MguGehPznRv04=;
 b=U84QadVvcr6+F98FATdohR69qHvyViCMulV7mnpUV1LHGTb2PQJe7JZXbARzn8apOrIF/X
 pGeVeWN1YCarbnqdDQJEDnMx9KKqnOHxR8MfsjY8QWsvMGSECPXKl/416TBcIjx3RCFMhk
 yCKtFQN1TNP34oL/AXh3SwQbIyK3EtA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-133-BAKWuUYIPGapOq-P5CxjUQ-1; Tue, 14 Jul 2020 08:33:27 -0400
X-MC-Unique: BAKWuUYIPGapOq-P5CxjUQ-1
Received: by mail-wm1-f71.google.com with SMTP id v6so3761258wmg.1
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 05:33:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=t56q2i2kWe5qidncJEOdhkmzgAnPO6MguGehPznRv04=;
 b=oniJTpHBn/18w9XQobMDWNkl/EQtjWXJLWTl4r41bbJ5mkVJfn8Sc9+2eUAu2STDrv
 TUPeU6TM325GxJiFWFqVkKJ3pwd3MaO74JVtHeTWO35+GGrewmw1f2rzPFaa6zRTGw7W
 RtPZkqOKNzWri0pnGEWv5lORWAwIZSAZN6gN8MK5QHcg5xd55erBnYTk0JDp+lxjbRJj
 siec5axdRSYvAQA0owXU7mz4JWEEskBgKPluFU/vYWwbgrAqbPIwXkkGGvZmod0ApeVe
 o6g8Tzr/cM+rPEl8DVGW196ZlzMhlJztwlUX5LG/c9bOCSTybDkKVroXrFKd51Qzx8Ow
 MFrw==
X-Gm-Message-State: AOAM533hXmm7wRZ0Xy5kCya4UpcYsiSKV51+NeHnLQ2wQwEmUUEJz3+d
 m12q74SuFoiLd4BZC7zDtYnAQo+wIDjAMPl/+xTgXelSrmjJ9xY0e8b7YffOOdE4YbLBa9cXBV6
 uwgGSPf92YlcmXms=
X-Received: by 2002:a5d:408c:: with SMTP id o12mr5140498wrp.412.1594730006430; 
 Tue, 14 Jul 2020 05:33:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx0B7FveCBnVdlppVprd5K2mdOpDaeFXP/dIr2p2T6REcFccaP5z4ESNi8JDrXEHZI4SPZatQ==
X-Received: by 2002:a5d:408c:: with SMTP id o12mr5140430wrp.412.1594730005970; 
 Tue, 14 Jul 2020 05:33:25 -0700 (PDT)
Received: from pop-os ([51.37.88.107])
 by smtp.gmail.com with ESMTPSA id n125sm4229689wme.30.2020.07.14.05.33.24
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 14 Jul 2020 05:33:25 -0700 (PDT)
Message-ID: <febb463fc7494aa20b6f57fef469cce7279d2c9a.camel@redhat.com>
Subject: Re: device compatibility interface for live migration with assigned
 devices
From: Sean Mooney <smooney@redhat.com>
To: "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>, Yan Zhao
 <yan.y.zhao@intel.com>
Date: Tue, 14 Jul 2020 13:33:24 +0100
In-Reply-To: <20200714102129.GD25187@redhat.com>
References: <20200713232957.GD5955@joy-OptiPlex-7040>
 <20200714102129.GD25187@redhat.com>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2
Mime-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=smooney@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 03:06:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 14 Jul 2020 09:59:31 -0400
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
Cc: shaohe.feng@intel.com, corbet@lwn.net, kevin.tian@intel.com,
 cohuck@redhat.com, kvm@vger.kernel.org, devel@ovirt.org,
 libvir-list@redhat.com, eskultet@redhat.com, jian-feng.ding@intel.com,
 qemu-devel@nongnu.org, kwankhede@nvidia.com, dgilbert@redhat.com,
 bao.yumeng@zte.com.cn, alex.williamson@redhat.com, zhenyuw@linux.intel.com,
 openstack-discuss@lists.openstack.org, xin-ran.wang@intel.com,
 dinechin@redhat.com, hejie.xu@intel.com, intel-gvt-dev@lists.freedesktop.org,
 eauger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2020-07-14 at 11:21 +0100, Daniel P. Berrangé wrote:
> On Tue, Jul 14, 2020 at 07:29:57AM +0800, Yan Zhao wrote:
> > hi folks,
> > we are defining a device migration compatibility interface that helps upper
> > layer stack like openstack/ovirt/libvirt to check if two devices are
> > live migration compatible.
> > The "devices" here could be MDEVs, physical devices, or hybrid of the two.
> > e.g. we could use it to check whether
> > - a src MDEV can migrate to a target MDEV,
mdev live migration is completely possible to do but i agree with Dan barrange's comments
from the point of view of openstack integration i dont see calling out to a vender sepecific
tool to be an accpetable
solutions for device compatiablity checking. the sys filesystem
that describs the mdevs that can be created shoudl also
contain the relevent infomation such
taht nova could integrate it via libvirt xml representation or directly retrive the
info from
sysfs.
> > - a src VF in SRIOV can migrate to a target VF in SRIOV,
so vf to vf migration is not possible in the general case as there is no standarised
way to transfer teh device state as part of the siorv specs produced by the pci-sig
as such there is not vender neutral way to support sriov live migration. 
> > - a src MDEV can migration to a target VF in SRIOV.
that also makes this unviable
> >   (e.g. SIOV/SRIOV backward compatibility case)
> > 
> > The upper layer stack could use this interface as the last step to check
> > if one device is able to migrate to another device before triggering a real
> > live migration procedure.
well actully that is already too late really. ideally we would want to do this compaiablity
check much sooneer to avoid the migration failing. in an openstack envionment  at least
by the time we invoke libvirt (assuming your using the libvirt driver) to do the migration we have alreaedy
finished schduling the instance to the new host. if if we do the compatiablity check at this point
and it fails then the live migration is aborted and will not be retired. These types of late check lead to a
poor user experince as unless you check the migration detial it basically looks like the migration was ignored
as it start to migrate and then continuge running on the orgininal host.

when using generic pci passhotuhg with openstack, the pci alias is intended to reference a single vendor id/product
id so you will have 1+ alias for each type of device. that allows openstack to schedule based on the availability of a
compatibale device because we track inventories of pci devices and can query that when selecting a host.

if we were to support mdev live migration in the future we would want to take the same declarative approch.
1 interospec the capability of the deivce we manage
2 create inventories of the allocatable devices and there capabilities
3 schdule the instance to a host based on the device-type/capabilities and claim it atomicly to prevent raceces
4 have the lower level hyperviors do addtional validation if need prelive migration.

this proposal seams to be targeting extending step 4 where as ideally we should focuse on providing the info that would
be relevant in set 1 preferably in a vendor neutral way vai a kernel interface like /sys.
 
> > we are not sure if this interface is of value or help to you. please don't
> > hesitate to drop your valuable comments.
> > 
> > 
> > (1) interface definition
> > The interface is defined in below way:
> > 
> >              __    userspace
> >               /\              \
> >              /                 \write
> >             / read              \
> >    ________/__________       ___\|/_____________
> >   | migration_version |     | migration_version |-->check migration
> >   ---------------------     ---------------------   compatibility
> >      device A                    device B
> > 
> > 
> > a device attribute named migration_version is defined under each device's
> > sysfs node. e.g. (/sys/bus/pci/devices/0000\:00\:02.0/$mdev_UUID/migration_version).
this might be useful as we could tag the inventory with the migration version and only might to
devices with  the same version
> > userspace tools read the migration_version as a string from the source device,
> > and write it to the migration_version sysfs attribute in the target device.
this would not be useful as the schduler cannot directlly connect to the compute host
and even if it could it would be extreamly slow to do this for 1000s of hosts and potentally
multiple devices per host.
> > 
> > The userspace should treat ANY of below conditions as two devices not compatible:
> > - any one of the two devices does not have a migration_version attribute
> > - error when reading from migration_version attribute of one device
> > - error when writing migration_version string of one device to
> >   migration_version attribute of the other device
> > 
> > The string read from migration_version attribute is defined by device vendor
> > driver and is completely opaque to the userspace.
opaque vendor specific stings that higher level orchestros have to pass form host
to host and cant reason about are evil, when allowed they prolifroate and
makes any idea of a vendor nutral abstraction and interoperablity between systems
impossible to reason about. that said there is a way to make it opaue but still useful
to userspace. see below
> > for a Intel vGPU, string format can be defined like
> > "parent device PCI ID" + "version of gvt driver" + "mdev type" + "aggregator count".
> > 
> > for an NVMe VF connecting to a remote storage. it could be
> > "PCI ID" + "driver version" + "configured remote storage URL"
> > 
> > for a QAT VF, it may be
> > "PCI ID" + "driver version" + "supported encryption set".
> > 
> > (to avoid namespace confliction from each vendor, we may prefix a driver name to
> > each migration_version string. e.g. i915-v1-8086-591d-i915-GVTg_V5_8-1)
honestly i would much prefer if the version string was just a semver string.
e.g. {major}.{minor}.{bugfix} 

if you do a driver/frimware update and break compatiablity with an older version bump the
major version.

if you add optional a feature that does not break backwards compatiablity if you migrate
an older instance to the new host then just bump the minor/feature number.

if you have a fix for a bug that does not change the feature set or compatiblity backwards or
forwards then bump the bugfix number

then the check is as simple as 
1.) is the mdev type the same
2.) is the major verion the same
3.) am i going form the same version to same version or same version to newer version

if all 3 are true we can migrate.
e.g. 
2.0.1 -> 2.1.1 (ok same major version and migrating from older feature release to newer feature release)
2.1.1 -> 2.0.1 (not ok same major version and migrating from new feature release to old feature release may be
incompatable)
2.0.0 -> 3.0.0 (not ok chaning major version)
2.0.1 -> 2.0.0 (ok same major and minor version, all bugfixs in the same minor release should be compatibly)

we dont need vendor to rencode the driver name or vendor id and product id in the string. that info is alreay
available both to the device driver and to userspace via /sys already we just need to know if version of
the same mdev are compatiable so a simple semver version string which is well know in the software world
at least is a clean abstration we can reuse.

> > (2) backgrounds
> > 
> > The reason we hope the migration_version string is opaque to the userspace
> > is that it is hard to generalize standard comparing fields and comparing
> > methods for different devices from different vendors.
> > Though userspace now could still do a simple string compare to check if
> > two devices are compatible, and result should also be right, it's still
> > too limited as it excludes the possible candidate whose migration_version
> > string fails to be equal.
> > e.g. an MDEV with mdev_type_1, aggregator count 3 is probably compatible
> > with another MDEV with mdev_type_3, aggregator count 1, even their
> > migration_version strings are not equal.
> > (assumed mdev_type_3 is of 3 times equal resources of mdev_type_1).
> > 
> > besides that, driver version + configured resources are all elements demanding
> > to take into account.
> > 
> > So, we hope leaving the freedom to vendor driver and let it make the final decision
> > in a simple reading from source side and writing for test in the target side way.
> > 
> > 
> > we then think the device compatibility issues for live migration with assigned
> > devices can be divided into two steps:
> > a. management tools filter out possible migration target devices.
> >    Tags could be created according to info from product specification.
> >    we think openstack/ovirt may have vendor proprietary components to create
> >    those customized tags for each product from each vendor.
> >    for Intel vGPU, with a vGPU(a MDEV device) in source side, the tags to
> >    search target vGPU are like:
> >    a tag for compatible parent PCI IDs,
> >    a tag for a range of gvt driver versions,
> >    a tag for a range of mdev type + aggregator count
> > 
> >    for NVMe VF, the tags to search target VF may be like:
> >    a tag for compatible PCI IDs,
> >    a tag for a range of driver versions,
> >    a tag for URL of configured remote storage.
> 
> Requiring management application developers to figure out this possible
> compatibility based on prod specs is really unrealistic. Product specs
> are typically as clear as mud, and with the suggestion we consider
> different rules for different types of devices, add up to a huge amount
> of complexity. This isn't something app developers should have to spend
> their time figuring out.
> 
> The suggestion that we make use of vendor proprietary helper components
> is totally unacceptable. We need to be able to build a solution that
> works with exclusively an open source software stack.
> 
> IMHO there needs to be a mechanism for the kernel to report via sysfs
> what versions are supported on a given device. This puts the job of
> reporting compatible versions directly under the responsibility of the
> vendor who writes the kernel driver for it. They are the ones with the
> best knowledge of the hardware they've built and the rules around its
> compatibility.
yep totally agree with that statement.
> 
> > b. with the output from step a, openstack/ovirt/libvirt could use our proposed
> >    device migration compatibility interface to make sure the two devices are
> >    indeed live migration compatible before launching the real live migration
> >    process to start stream copying, src device stopping and target device
> >    resuming.
> >    It is supposed that this step would not bring any performance penalty as
> >    -in kernel it's just a simple string decoding and comparing
> >    -in openstack/ovirt, it could be done by extending current function
> >     check_can_live_migrate_destination, along side claiming target resources.[1]
that is a compute driver fucntion
https://github.com/openstack/nova/blob/8988316b8c132c9662dea6cf0345975e87ce7344/nova/virt/driver.py#L1261-L1278
that is called in the conductor here

https://github.com/openstack/nova/blob/8988316b8c132c9662dea6cf0345975e87ce7344/nova/conductor/tasks/live_migrate.py#L360-L364
if the check fails(ignoreing the fact its expensive to do an rpc to the compute host) we raise an excption that
move on to the next host in the alternate host list.

https://github.com/openstack/nova/blob/8988316b8c132c9662dea6cf0345975e87ce7344/nova/conductor/tasks/live_migrate.py#L556-L567
by default the alternate host list is 3
https://docs.openstack.org/nova/latest/configuration/config.html#scheduler.max_attempts
so there would be a pretty high likely hood that if we only checked compatiablity at this point it would fail to
migrate. realistically speaking this is too late. we can do a final safty check at this point but this should
not be the first time we check compatibility. at a mimnium we would have wanted to select a host with the same mdev
type first, we can do that from the info we have today but i hope i have made the point that declaritive interfacs
which we can introspect without haveing opaqce vender sepecitic blob are vastly more consomable then imperitive
interfaces we have to probe. form a security and packaging point of view this is better too as if i only need
readonly access to sysfs instead of write access and if i dont need to package a bunch of addtion vendor tools
in a continerised deployment that significantly decreases the potential attack surface.
> 
> 
> 
> 
> > 
> > 
> > [1] https://specs.openstack.org/openstack/nova-specs/specs/stein/approved/libvirt-neutron-sriov-livemigration.html
> > 
> > Thanks
> > Yan
> > 
> 
> Regards,
> Daniel


