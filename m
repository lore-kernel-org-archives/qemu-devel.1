Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B95C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 03:23:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FC3C207BB
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 03:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H0CtUhhP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FC3C207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8bAl-0003ES-Qy
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 23:23:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52978)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1k8bAE-0002nk-FT
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 23:22:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38484)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1k8bAB-0003Xx-QE
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 23:22:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597893770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tLd/qISkb4SgY+sj5n1JVIOSU5FSzdkPJ0PTVDiEVxM=;
 b=H0CtUhhPqaDR8dBNokbOMRfU30P39AsIYUpdraeA2h/vE1OalCXngHfukQXExY+/B3id4F
 QVtvaf7cPB7ZO9ZiPXlCtSJtb1nPFm/nUxcAdOdcaW0EFewX+HqF4X694cRcULvZ/HLblV
 GpBHo8fDw9n26rgA2GbTKqgjO5owkcw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-GzGRLPngP9iBA0IYQ712nw-1; Wed, 19 Aug 2020 23:22:45 -0400
X-MC-Unique: GzGRLPngP9iBA0IYQ712nw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0036085C705;
 Thu, 20 Aug 2020 03:22:43 +0000 (UTC)
Received: from x1.home (ovpn-112-71.phx2.redhat.com [10.3.112.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 32A215C88B;
 Thu, 20 Aug 2020 03:22:35 +0000 (UTC)
Date: Wed, 19 Aug 2020 21:22:34 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Subject: Re: device compatibility interface for live migration with assigned
 devices
Message-ID: <20200819212234.223667b3@x1.home>
In-Reply-To: <20200820003922.GE21172@joy-OptiPlex-7040>
References: <20200805093338.GC30485@joy-OptiPlex-7040>
 <20200805105319.GF2177@nanopsycho>
 <20200810074631.GA29059@joy-OptiPlex-7040>
 <e6e75807-0614-bd75-aeb6-64d643e029d3@redhat.com>
 <20200814051601.GD15344@joy-OptiPlex-7040>
 <a51209fe-a8c6-941f-ff54-7be06d73bc44@redhat.com>
 <20200818085527.GB20215@redhat.com>
 <3a073222-dcfe-c02d-198b-29f6a507b2e1@redhat.com>
 <20200818091628.GC20215@redhat.com>
 <20200818113652.5d81a392.cohuck@redhat.com>
 <20200820003922.GE21172@joy-OptiPlex-7040>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Received-SPF: pass client-ip=63.128.21.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 20:12:48
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: kvm@vger.kernel.org, libvir-list@redhat.com,
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, kwankhede@nvidia.com,
 eauger@redhat.com, xin-ran.wang@intel.com, corbet@lwn.net,
 openstack-discuss@lists.openstack.org, shaohe.feng@intel.com,
 kevin.tian@intel.com, Parav Pandit <parav@mellanox.com>,
 jian-feng.ding@intel.com, dgilbert@redhat.com, zhenyuw@linux.intel.com,
 hejie.xu@intel.com, bao.yumeng@zte.com.cn, Jiri Pirko <jiri@mellanox.com>,
 eskultet@redhat.com, smooney@redhat.com, intel-gvt-dev@lists.freedesktop.org,
 "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, dinechin@redhat.com, devel@ovirt.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 20 Aug 2020 08:39:22 +0800
Yan Zhao <yan.y.zhao@intel.com> wrote:

> On Tue, Aug 18, 2020 at 11:36:52AM +0200, Cornelia Huck wrote:
> > On Tue, 18 Aug 2020 10:16:28 +0100
> > Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> >  =20
> > > On Tue, Aug 18, 2020 at 05:01:51PM +0800, Jason Wang wrote: =20
> > > >    On 2020/8/18 =E4=B8=8B=E5=8D=884:55, Daniel P. Berrang=C3=A9 wro=
te:
> > > >=20
> > > >  On Tue, Aug 18, 2020 at 11:24:30AM +0800, Jason Wang wrote:
> > > >=20
> > > >  On 2020/8/14 =E4=B8=8B=E5=8D=881:16, Yan Zhao wrote:
> > > >=20
> > > >  On Thu, Aug 13, 2020 at 12:24:50PM +0800, Jason Wang wrote:
> > > >=20
> > > >  On 2020/8/10 =E4=B8=8B=E5=8D=883:46, Yan Zhao wrote:   =20
> > >  =20
> > > >  we actually can also retrieve the same information through sysfs, =
.e.g
> > > >=20
> > > >  |- [path to device]
> > > >     |--- migration
> > > >     |     |--- self
> > > >     |     |   |---device_api
> > > >     |    |   |---mdev_type
> > > >     |    |   |---software_version
> > > >     |    |   |---device_id
> > > >     |    |   |---aggregator
> > > >     |     |--- compatible
> > > >     |     |   |---device_api
> > > >     |    |   |---mdev_type
> > > >     |    |   |---software_version
> > > >     |    |   |---device_id
> > > >     |    |   |---aggregator
> > > >=20
> > > >=20
> > > >  Yes but:
> > > >=20
> > > >  - You need one file per attribute (one syscall for one attribute)
> > > >  - Attribute is coupled with kobject =20
> >=20
> > Is that really that bad? You have the device with an embedded kobject
> > anyway, and you can just put things into an attribute group?
> >=20
> > [Also, I think that self/compatible split in the example makes things
> > needlessly complex. Shouldn't semantic versioning and matching already
> > cover nearly everything? I would expect very few cases that are more
> > complex than that. Maybe the aggregation stuff, but I don't think we
> > need that self/compatible split for that, either.] =20
> Hi Cornelia,
>=20
> The reason I want to declare compatible list of attributes is that
> sometimes it's not a simple 1:1 matching of source attributes and target =
attributes
> as I demonstrated below,
> source mdev of (mdev_type i915-GVTg_V5_2 + aggregator 1) is compatible to
> target mdev of (mdev_type i915-GVTg_V5_4 + aggregator 2),
>                (mdev_type i915-GVTg_V5_8 + aggregator 4)
>=20
> and aggragator may be just one of such examples that 1:1 matching does not
> fit.

If you're suggesting that we need a new 'compatible' set for every
aggregation, haven't we lost the purpose of aggregation?  For example,
rather than having N mdev types to represent all the possible
aggregation values, we have a single mdev type with N compatible
migration entries, one for each possible aggregation value.  BTW, how do
we have multiple compatible directories?  compatible0001,
compatible0002? Thanks,

Alex


