Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28238C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 09:40:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9C15207FB
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 09:40:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hqPC7z8A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9C15207FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7y6A-0002CW-6R
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 05:40:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34318)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k7y5a-0001nb-I5
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 05:39:30 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40986
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k7y5Y-0002lv-Rm
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 05:39:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597743567;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EWyBYJmhu+RufU33YGRbdTkRS4E+NRocVAwpjFgsfPA=;
 b=hqPC7z8A61a5bBRH6JydiB2k05sfEEGQqEZFzJogMpXftsZkvfBZt7TmO2Cl6hIsHfbiFZ
 CILV5fkP8Nu/Mte0NCb27JyUs1Y3fjnNh3eBBDwcrLnAu+0JlsKMOw4dFg1B9/++auxXoB
 DwGUiBcKJ81grvF1WSuA1RRUMY11p/c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-8_MTxrkrPNSOf6jLgjwKDA-1; Tue, 18 Aug 2020 05:39:26 -0400
X-MC-Unique: 8_MTxrkrPNSOf6jLgjwKDA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C64571084C81;
 Tue, 18 Aug 2020 09:39:23 +0000 (UTC)
Received: from gondolin (ovpn-112-221.ams2.redhat.com [10.36.112.221])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 06C215D9D2;
 Tue, 18 Aug 2020 09:38:57 +0000 (UTC)
Date: Tue, 18 Aug 2020 11:38:55 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>
Subject: Re: device compatibility interface for live migration with assigned
 devices
Message-ID: <20200818113855.647938c0.cohuck@redhat.com>
In-Reply-To: <20200818092433.GD20215@redhat.com>
References: <20200805075647.GB2177@nanopsycho>
 <eb1d01c2-fbad-36b6-10cf-9e03483a736b@redhat.com>
 <20200805093338.GC30485@joy-OptiPlex-7040>
 <20200805105319.GF2177@nanopsycho>
 <20200810074631.GA29059@joy-OptiPlex-7040>
 <e6e75807-0614-bd75-aeb6-64d643e029d3@redhat.com>
 <20200814051601.GD15344@joy-OptiPlex-7040>
 <a51209fe-a8c6-941f-ff54-7be06d73bc44@redhat.com>
 <20200818085527.GB20215@redhat.com>
 <20200818110617.05def37c.cohuck@redhat.com>
 <20200818092433.GD20215@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Received-SPF: none client-ip=205.139.110.61; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 02:16:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Tue, 18 Aug 2020 10:24:33 +0100
Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:

> On Tue, Aug 18, 2020 at 11:06:17AM +0200, Cornelia Huck wrote:
> > On Tue, 18 Aug 2020 09:55:27 +0100
> > Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> >  =20
> > > On Tue, Aug 18, 2020 at 11:24:30AM +0800, Jason Wang wrote: =20
> > > > Another point, as we discussed in another thread, it's really hard =
to make
> > > > sure the above API work for all types of devices and frameworks. So=
 having a
> > > > vendor specific API looks much better.   =20
> > >=20
> > > From the POV of userspace mgmt apps doing device compat checking / mi=
gration,
> > > we certainly do NOT want to use different vendor specific APIs. We wa=
nt to
> > > have an API that can be used / controlled in a standard manner across=
 vendors. =20
> >=20
> > As we certainly will need to have different things to check for
> > different device types and vendor drivers, would it still be fine to
> > have differing (say) attributes, as long as they are presented (and can
> > be discovered) in a standardized way? =20
>=20
> Yes, the control API and algorithm to deal with the problem needs to
> have standardization, but the data passed in/out of the APIs can vary.
>=20
> Essentially the key is that vendors should be able to create devices
> at the kernel, and those devices should "just work" with the existing
> generic userspace migration / compat checking code, without needing
> extra vendor specific logic to be added.
>=20
> Note, I'm not saying that the userspace decisions would be perfectly
> optimal based on generic code. They might be making a simplified
> decision that while functionally safe, is not the ideal solution.
> Adding vendor specific code might be able to optimize the userspace
> decisions, but that should be considered just optimization, not a
> core must have for any opertion.

Yes, that sounds reasonable.


