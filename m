Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1617BC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 16:22:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F6A5206A4
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 16:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ok8Cv/2B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F6A5206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHrF1-00021M-CN
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 12:22:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58066)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kHpkR-0001I1-2i
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 10:46:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50388)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kHpkO-0004dr-Hp
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 10:46:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600094783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+FTjA4enfFJIR63GYEIsWV3awMt+Q34RFrVM4vhT7s4=;
 b=Ok8Cv/2B3jYVWeZN+pX2SxWUYtZ0FOou6Wr9lP4dnIA85XN3dBcVvgR8AxiII0T8H0VOkg
 eNT+JMOyVdBt9cbM6ZjsFBmaKguBWEH9n8AcPrGBMWKEHvCtrAvol7Mt404y0IDqXcCaWK
 SAdynDVAOnHaN+ct+/El6bpzzIuFjBs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-1thlOCTkP76oOonY2-lLjw-1; Mon, 14 Sep 2020 10:46:20 -0400
X-MC-Unique: 1thlOCTkP76oOonY2-lLjw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A12778BF01D;
 Mon, 14 Sep 2020 14:44:57 +0000 (UTC)
Received: from x1.home (ovpn-112-71.phx2.redhat.com [10.3.112.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 50F5D7BE49;
 Mon, 14 Sep 2020 14:44:50 +0000 (UTC)
Date: Mon, 14 Sep 2020 08:44:49 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: "Zeng, Xin" <xin.zeng@intel.com>
Subject: Re: device compatibility interface for live migration with assigned
 devices
Message-ID: <20200914084449.0182e8a9@x1.home>
In-Reply-To: <DM6PR11MB3500BAC3B7056E348002A7FD88230@DM6PR11MB3500.namprd11.prod.outlook.com>
References: <20200825163925.1c19b0f0.cohuck@redhat.com>
 <20200826064117.GA22243@joy-OptiPlex-7040>
 <20200828154741.30cfc1a3.cohuck@redhat.com>
 <8f5345be73ebf4f8f7f51d6cdc9c2a0d8e0aa45e.camel@redhat.com>
 <20200831044344.GB13784@joy-OptiPlex-7040>
 <20200908164130.2fe0d106.cohuck@redhat.com>
 <20200909021308.GA1277@joy-OptiPlex-7040>
 <20200910143822.2071eca4.cohuck@redhat.com>
 <7cebcb6c8d1a1452b43e8358ee6ee18a150a0238.camel@redhat.com>
 <20200910120244.71e7b630@w520.home>
 <20200911005559.GA3932@joy-OptiPlex-7040>
 <20200911105155.184e32a0@w520.home>
 <DM6PR11MB3500BAC3B7056E348002A7FD88230@DM6PR11MB3500.namprd11.prod.outlook.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Received-SPF: pass client-ip=216.205.24.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 02:10:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.792,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 "kwankhede@nvidia.com" <kwankhede@nvidia.com>,
 "eauger@redhat.com" <eauger@redhat.com>, "Wang,
 Xin-ran" <xin-ran.wang@intel.com>, "corbet@lwn.net" <corbet@lwn.net>,
 "openstack-discuss@lists.openstack.org"
 <openstack-discuss@lists.openstack.org>, "Feng,
 Shaohe" <shaohe.feng@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Zhao,
 Yan Y" <yan.y.zhao@intel.com>, Parav Pandit <parav@mellanox.com>, "Ding,
 Jian-feng" <jian-feng.ding@intel.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "zhenyuw@linux.intel.com" <zhenyuw@linux.intel.com>, "Xu,
 Hejie" <hejie.xu@intel.com>, "bao.yumeng@zte.com.cn" <bao.yumeng@zte.com.cn>,
 Jiri Pirko <jiri@mellanox.com>, "eskultet@redhat.com" <eskultet@redhat.com>,
 Sean Mooney <smooney@redhat.com>,
 "intel-gvt-dev@lists.freedesktop.org" <intel-gvt-dev@lists.freedesktop.org>,
 Daniel =?UTF-8?B?UC5CZXJyYW5nw6k=?= <berrange@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, "dinechin@redhat.com" <dinechin@redhat.com>,
 "devel@ovirt.org" <devel@ovirt.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 14 Sep 2020 13:48:43 +0000
"Zeng, Xin" <xin.zeng@intel.com> wrote:

> On Saturday, September 12, 2020 12:52 AM
> Alex Williamson <alex.williamson@redhat.com> wrote:
> > To: Zhao, Yan Y <yan.y.zhao@intel.com>
> > Cc: Sean Mooney <smooney@redhat.com>; Cornelia Huck
> > <cohuck@redhat.com>; Daniel P.Berrang=C3=A9 <berrange@redhat.com>;
> > kvm@vger.kernel.org; libvir-list@redhat.com; Jason Wang
> > <jasowang@redhat.com>; qemu-devel@nongnu.org;
> > kwankhede@nvidia.com; eauger@redhat.com; Wang, Xin-ran <xin- =20
> > ran.wang@intel.com>; corbet@lwn.net; openstack- =20
> > discuss@lists.openstack.org; Feng, Shaohe <shaohe.feng@intel.com>; Tian,
> > Kevin <kevin.tian@intel.com>; Parav Pandit <parav@mellanox.com>; Ding,
> > Jian-feng <jian-feng.ding@intel.com>; dgilbert@redhat.com;
> > zhenyuw@linux.intel.com; Xu, Hejie <hejie.xu@intel.com>;
> > bao.yumeng@zte.com.cn; intel-gvt-dev@lists.freedesktop.org;
> > eskultet@redhat.com; Jiri Pirko <jiri@mellanox.com>; dinechin@redhat.co=
m;
> > devel@ovirt.org
> > Subject: Re: device compatibility interface for live migration with ass=
igned
> > devices
> >=20
> > On Fri, 11 Sep 2020 08:56:00 +0800
> > Yan Zhao <yan.y.zhao@intel.com> wrote:
> >  =20
> > > On Thu, Sep 10, 2020 at 12:02:44PM -0600, Alex Williamson wrote: =20
> > > > On Thu, 10 Sep 2020 13:50:11 +0100
> > > > Sean Mooney <smooney@redhat.com> wrote:
> > > > =20
> > > > > On Thu, 2020-09-10 at 14:38 +0200, Cornelia Huck wrote: =20
> > > > > > On Wed, 9 Sep 2020 10:13:09 +0800
> > > > > > Yan Zhao <yan.y.zhao@intel.com> wrote:
> > > > > > =20
> > > > > > > > > still, I'd like to put it more explicitly to make ensure =
it's not =20
> > missed: =20
> > > > > > > > > the reason we want to specify compatible_type as a trait =
and =20
> > check =20
> > > > > > > > > whether target compatible_type is the superset of source
> > > > > > > > > compatible_type is for the consideration of backward =20
> > compatibility. =20
> > > > > > > > > e.g.
> > > > > > > > > an old generation device may have a mdev type xxx-v4-yyy,=
 =20
> > while a newer =20
> > > > > > > > > generation  device may be of mdev type xxx-v5-yyy.
> > > > > > > > > with the compatible_type traits, the old generation devic=
e is still
> > > > > > > > > able to be regarded as compatible to newer generation dev=
ice =20
> > even their =20
> > > > > > > > > mdev types are not equal. =20
> > > > > > > >
> > > > > > > > If you want to support migration from v4 to v5, can't the =
=20
> > (presumably =20
> > > > > > > > newer) driver that supports v5 simply register the v4 type =
as well, =20
> > so =20
> > > > > > > > that the mdev can be created as v4? (Just like QEMU version=
ed =20
> > machine =20
> > > > > > > > types work.) =20
> > > > > > >
> > > > > > > yes, it should work in some conditions.
> > > > > > > but it may not be that good in some cases when v5 and v4 in t=
he =20
> > name string =20
> > > > > > > of mdev type identify hardware generation (e.g. v4 for gen8, =
and v5 =20
> > for =20
> > > > > > > gen9)
> > > > > > >
> > > > > > > e.g.
> > > > > > > (1). when src mdev type is v4 and target mdev type is v5 as
> > > > > > > software does not support it initially, and v4 and v5 identif=
y =20
> > hardware =20
> > > > > > > differences. =20
> > > > > >
> > > > > > My first hunch here is: Don't introduce types that may be compa=
tible
> > > > > > later. Either make them compatible, or make them distinct by de=
sign,
> > > > > > and possibly add a different, compatible type later.
> > > > > > =20
> > > > > > > then after software upgrade, v5 is now compatible to v4, shou=
ld the
> > > > > > > software now downgrade mdev type from v5 to v4?
> > > > > > > not sure if moving hardware generation info into a separate =
=20
> > attribute =20
> > > > > > > from mdev type name is better. e.g. remove v4, v5 in mdev typ=
e, =20
> > while use =20
> > > > > > > compatible_pci_ids to identify compatibility. =20
> > > > > >
> > > > > > If the generations are compatible, don't mention it in the mdev=
 type.
> > > > > > If they aren't, use distinct types, so that management software=
 =20
> > doesn't =20
> > > > > > have to guess. At least that would be my naive approach here. =
=20
> > > > > yep that is what i would prefer to see too. =20
> > > > > > =20
> > > > > > >
> > > > > > > (2) name string of mdev type is composed by "driver_name + =20
> > type_name". =20
> > > > > > > in some devices, e.g. qat, different generations of devices a=
re =20
> > binding to =20
> > > > > > > drivers of different names, e.g. "qat-v4", "qat-v5".
> > > > > > > then though type_name is equal, mdev type is not equal. e.g.
> > > > > > > "qat-v4-type1", "qat-v5-type1". =20
> > > > > >
> > > > > > I guess that shows a shortcoming of that "driver_name + type_na=
me"
> > > > > > approach? Or maybe I'm just confused. =20
> > > > > yes i really dont like haveing the version in the mdev-type name
> > > > > i would stongly perfger just qat-type-1 wehere qat is just there =
as a way =20
> > of namespacing. =20
> > > > > although symmetric-cryto, asymmetric-cryto and compression woudl =
=20
> > be a better name then type-1, type-2, type-3 if =20
> > > > > that is what they would end up mapping too. e.g. qat-compression =
or =20
> > qat-aes is a much better name then type-1 =20
> > > > > higher layers of software are unlikely to parse the mdev names bu=
t as a =20
> > human looking at them its much eaiser to =20
> > > > > understand if the names are meaningful. the qat prefix i think is=
 =20
> > important however to make sure that your mdev-types =20
> > > > > dont colide with other vendeors mdev types. so i woudl encurage a=
ll =20
> > vendors to prefix there mdev types with etiher the =20
> > > > > device name or the vendor. =20
> > > >
> > > > +1 to all this, the mdev type is meant to indicate a software
> > > > compatible interface, if different hardware versions can be software
> > > > compatible, then don't make the job of finding a compatible device
> > > > harder.  The full type is a combination of the vendor driver name p=
lus
> > > > the vendor provided type name specifically in order to provide a ty=
pe
> > > > namespace per vendor driver.  That's done at the mdev core level.
> > > > Thanks, =20
> > >
> > > hi Alex,
> > > got it. so do you suggest that vendors use consistent driver name over
> > > generations of devices?
> > > for qat, they create different modules for each generation. This
> > > practice is not good if they want to support migration between devices
> > > of different generations, right?
> > >
> > > and can I understand that we don't want support of migration between
> > > different mdev types even in future ? =20
> >=20
> > You need to balance your requirements here.  If you're creating
> > different drivers per generation, that suggests different device APIs,
> > which is a legitimate use case for different mdev types.  However if
> > you're expecting migration compatibility, that must be seamless to the
> > guest, therefore the device API must be identical.  That suggests that
> > migration between different types doesn't make much sense.  If a new
> > generation device wants to expose a new mdev type with new features or
> > device API, yet also support migration with an older mdev type, why
> > wouldn't it simply expose both the old and the new type?   =20
>=20
> I think all of these make sense, and I am assuming it's also reasonable a=
nd=20
> common that each generation of  device has a separate device driver modul=
e.
> On the other hand, please be aware that, the mdev type is consisted of the
> driver name of the mdev's parent device and the name of a mdev type which
> the device driver specifies.=20
> If a new generation device driver wants to expose an old mdev type, it ha=
s to
> register  the same driver name as the old one so that the mdev type could=
=20
> be completely same. This doesn't make sense as a) driver name usually is
> unique for a device driver module. b) If a system has both these two=20
> generation devices, once one generation device driver is loaded, the othe=
r=20
> is not allowed to be loaded due to the same driver name. =20
> So to allow a new generation device to simply expose the old mdev type for
> compatibility like you proposed, is it possible to create the mdev type by
> another approach, e.g. device driver creates its own namespace for the
> mdev type instead of mdev's parent device driver name being used currentl=
y?

TBH, I don't think that it's reasonable or common that different
drivers are used for each generation of hardware.  Drivers typically
evolve to support new generations of hardware, often sharing
significant code between generations.  When we deal with mdev
migration, we have an opaque data stream managed by the driver, our
default assumption is therefore that the driver plays a significant
role in the composition of that data stream.  I'm not ruling out that
we should support some form of compatibility between types, but in the
described scenario it seems the development model of the vendor drivers
is not conducive to the most obvious form of compatibility checking.
Thanks,

Alex


