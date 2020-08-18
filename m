Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3230CC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 09:37:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECB332078B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 09:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c+6/TNjz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECB332078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7y40-0000P6-1M
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 05:37:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33772)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k7y3T-0008QE-LN
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 05:37:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39644
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k7y3P-0002UG-Us
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 05:37:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597743434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uJjNy/iBoF2FonoLrwK5UsgI5KqHfrDJbMHahAh/X50=;
 b=c+6/TNjz/Klq4DbWfw/2D3i8DEUK4WRTDF5Ctrm0UDEWS6JePf95tntbNeaCv/HXTgI1Az
 FnNubvtlJcS5xFQXsd02st2uZKtu33UlJu45VB7ssKD0O9gf8KeDkgBR3IJCTVDZdxP4WQ
 6rKb01ZyjjjuGf0/LrFymYFJGlwJdfY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-buTrGnQ6PEC5eD5s6IyfoQ-1; Tue, 18 Aug 2020 05:37:12 -0400
X-MC-Unique: buTrGnQ6PEC5eD5s6IyfoQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DEEE2801ADD;
 Tue, 18 Aug 2020 09:37:09 +0000 (UTC)
Received: from gondolin (ovpn-112-221.ams2.redhat.com [10.36.112.221])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EC6EE7D939;
 Tue, 18 Aug 2020 09:36:54 +0000 (UTC)
Date: Tue, 18 Aug 2020 11:36:52 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>
Subject: Re: device compatibility interface for live migration with assigned
 devices
Message-ID: <20200818113652.5d81a392.cohuck@redhat.com>
In-Reply-To: <20200818091628.GC20215@redhat.com>
References: <20200805075647.GB2177@nanopsycho>
 <eb1d01c2-fbad-36b6-10cf-9e03483a736b@redhat.com>
 <20200805093338.GC30485@joy-OptiPlex-7040>
 <20200805105319.GF2177@nanopsycho>
 <20200810074631.GA29059@joy-OptiPlex-7040>
 <e6e75807-0614-bd75-aeb6-64d643e029d3@redhat.com>
 <20200814051601.GD15344@joy-OptiPlex-7040>
 <a51209fe-a8c6-941f-ff54-7be06d73bc44@redhat.com>
 <20200818085527.GB20215@redhat.com>
 <3a073222-dcfe-c02d-198b-29f6a507b2e1@redhat.com>
 <20200818091628.GC20215@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Received-SPF: none client-ip=205.139.110.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 03:19:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: kvm@vger.kernel.org, libvir-list@redhat.com,
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, kwankhede@nvidia.com,
 eauger@redhat.com, xin-ran.wang@intel.com, corbet@lwn.net,
 openstack-discuss@lists.openstack.org, shaohe.feng@intel.com,
 kevin.tian@intel.com, Yan Zhao <yan.y.zhao@intel.com>,
 Parav Pandit <parav@mellanox.com>, jian-feng.ding@intel.com,
 dgilbert@redhat.com, zhenyuw@linux.intel.com, hejie.xu@intel.com,
 bao.yumeng@zte.com.cn, Alex Williamson <alex.williamson@redhat.com>,
 smooney@redhat.com, intel-gvt-dev@lists.freedesktop.org, eskultet@redhat.com,
 Jiri Pirko <jiri@mellanox.com>, dinechin@redhat.com, devel@ovirt.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 18 Aug 2020 10:16:28 +0100
Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:

> On Tue, Aug 18, 2020 at 05:01:51PM +0800, Jason Wang wrote:
> >    On 2020/8/18 =E4=B8=8B=E5=8D=884:55, Daniel P. Berrang=C3=A9 wrote:
> >=20
> >  On Tue, Aug 18, 2020 at 11:24:30AM +0800, Jason Wang wrote:
> >=20
> >  On 2020/8/14 =E4=B8=8B=E5=8D=881:16, Yan Zhao wrote:
> >=20
> >  On Thu, Aug 13, 2020 at 12:24:50PM +0800, Jason Wang wrote:
> >=20
> >  On 2020/8/10 =E4=B8=8B=E5=8D=883:46, Yan Zhao wrote: =20
>=20
> >  we actually can also retrieve the same information through sysfs, .e.g
> >=20
> >  |- [path to device]
> >     |--- migration
> >     |     |--- self
> >     |     |   |---device_api
> >     |    |   |---mdev_type
> >     |    |   |---software_version
> >     |    |   |---device_id
> >     |    |   |---aggregator
> >     |     |--- compatible
> >     |     |   |---device_api
> >     |    |   |---mdev_type
> >     |    |   |---software_version
> >     |    |   |---device_id
> >     |    |   |---aggregator
> >=20
> >=20
> >  Yes but:
> >=20
> >  - You need one file per attribute (one syscall for one attribute)
> >  - Attribute is coupled with kobject

Is that really that bad? You have the device with an embedded kobject
anyway, and you can just put things into an attribute group?

[Also, I think that self/compatible split in the example makes things
needlessly complex. Shouldn't semantic versioning and matching already
cover nearly everything? I would expect very few cases that are more
complex than that. Maybe the aggregation stuff, but I don't think we
need that self/compatible split for that, either.]

> >=20
> >  All of above seems unnecessary.
> >=20
> >  Another point, as we discussed in another thread, it's really hard to =
make
> >  sure the above API work for all types of devices and frameworks. So ha=
ving a
> >  vendor specific API looks much better.
> >=20
> >  From the POV of userspace mgmt apps doing device compat checking / mig=
ration,
> >  we certainly do NOT want to use different vendor specific APIs. We wan=
t to
> >  have an API that can be used / controlled in a standard manner across =
vendors.
> >=20
> >    Yes, but it could be hard. E.g vDPA will chose to use devlink (there=
's a
> >    long debate on sysfs vs devlink). So if we go with sysfs, at least t=
wo
> >    APIs needs to be supported ... =20
>=20
> NB, I was not questioning devlink vs sysfs directly. If devlink is related
> to netlink, I can't say I'm enthusiastic as IMKE sysfs is easier to deal
> with. I don't know enough about devlink to have much of an opinion though.
> The key point was that I don't want the userspace APIs we need to deal wi=
th
> to be vendor specific.

=46rom what I've seen of devlink, it seems quite nice; but I understand
why sysfs might be easier to deal with (especially as there's likely
already a lot of code using it.)

I understand that some users would like devlink because it is already
widely used for network drivers (and some others), but I don't think
the majority of devices used with vfio are network (although certainly
a lot of them are.)

>=20
> What I care about is that we have a *standard* userspace API for performi=
ng
> device compatibility checking / state migration, for use by QEMU/libvirt/
> OpenStack, such that we can write code without countless vendor specific
> code paths.
>=20
> If there is vendor specific stuff on the side, that's fine as we can igno=
re
> that, but the core functionality for device compat / migration needs to be
> standardized.

To summarize:
- choose one of sysfs or devlink
- have a common interface, with a standardized way to add
  vendor-specific attributes
?


