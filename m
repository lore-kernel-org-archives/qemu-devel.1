Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 456C2C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 15:01:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01D602083D
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 15:01:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="WgK/CfEf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01D602083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33607 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYtte-0006xw-99
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 11:01:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1hYtsq-0006QH-QP
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 11:00:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1hYtsi-0006Wu-Nf
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 11:00:50 -0400
Received: from mail-ve1eur04hn2055.outbound.protection.outlook.com
	([52.101.139.55]:30966
	helo=EUR04-VI1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1hYtsh-0006VM-Uc
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 11:00:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=N3KiW+jk7NrgPe6SSTTvkQSFZRfdr5K8AqrS13lC+qk=;
	b=WgK/CfEfbCBZ0wHNJeC0rJpVbPwPvwlVZ8rJZL49sL2H2pKKNDJHURXnKNITxG19quVORmMESX4q5tkhLs2j/TSIi3nY3dq/W54o397+jYRNeBG/9bD3yt2fhmszLQj2ysLTEkD9I0wc+/imM0qORTL1feTajJudjEDBP4NBeWM=
Received: from AM4PR08MB2676.eurprd08.prod.outlook.com (10.171.190.153) by
	AM4PR08MB2867.eurprd08.prod.outlook.com (10.171.190.12) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1965.12; Thu, 6 Jun 2019 15:00:31 +0000
Received: from AM4PR08MB2676.eurprd08.prod.outlook.com
	([fe80::6169:9a70:7143:1c1f]) by
	AM4PR08MB2676.eurprd08.prod.outlook.com
	([fe80::6169:9a70:7143:1c1f%3]) with mapi id 15.20.1965.011;
	Thu, 6 Jun 2019 15:00:31 +0000
From: Roman Kagan <rkagan@virtuozzo.com>
To: Alex Williamson <alex.williamson@redhat.com>
Thread-Topic: [Qemu-devel] [PATCH 3/4] net/virtio: add failover support
Thread-Index: AQHVDLBqo+KDkOZy7Eq2VyhhJK7jkKZ1WluAgA58EICAAgUtAIAD1q0AgACjtQCAAAoPAIAEd70A
Date: Thu, 6 Jun 2019 15:00:30 +0000
Message-ID: <20190606150028.GC32258@rkaganb.sw.ru>
References: <20190517125820.2885-1-jfreimann@redhat.com>
	<20190517125820.2885-4-jfreimann@redhat.com>
	<20190521094504.GB2915@work-vm>
	<20190530145645.tjwkgi4hae5yblsi@jenstp.localdomain>
	<20190531214748.GN22103@habkost.net>
	<20190603082456.vzpy256kj4o5e5wu@jenstp.localdomain>
	<97b5f189-a75d-3efe-0af6-4570f6d38a58@redhat.com>
	<20190603124652.10b3c0c2@x1.home>
In-Reply-To: <20190603124652.10b3c0c2@x1.home>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.11.4 (2019-03-13)
mail-followup-to: Roman Kagan <rkagan@virtuozzo.com>,	Alex Williamson
	<alex.williamson@redhat.com>,	Laine Stump <laine@redhat.com>,
	pkrempa@redhat.com,	berrange@redhat.com, Eduardo Habkost
	<ehabkost@redhat.com>,	mst@redhat.com, aadam@redhat.com,
	qemu-devel@nongnu.org, "Dr. David Alan	Gilbert" <dgilbert@redhat.com>,
	Jens Freimann <jfreimann@redhat.com>, ailan@redhat.com
x-originating-ip: [185.231.240.5]
x-clientproxiedby: HE1PR05CA0188.eurprd05.prod.outlook.com
	(2603:10a6:3:f9::12) To AM4PR08MB2676.eurprd08.prod.outlook.com
	(2603:10a6:205:c::25)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=rkagan@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 224e5645-2bcd-4125-baaa-08d6ea8fb7e7
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
	SRVR:AM4PR08MB2867; 
x-ms-traffictypediagnostic: AM4PR08MB2867:|AM4PR08MB2867:
x-microsoft-antispam-prvs: <AM4PR08MB28674B36439134459FFB2898C9170@AM4PR08MB2867.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 00603B7EEF
x-forefront-antispam-report: SFV:SPM;
	SFS:(10019020)(366004)(136003)(376002)(346002)(39850400004)(396003)(199004)(189003)(4326008)(478600001)(26005)(316002)(6486002)(6506007)(53546011)(386003)(86362001)(25786009)(54906003)(486006)(66476007)(66556008)(64756008)(11346002)(66446008)(66946007)(446003)(99286004)(229853002)(3846002)(53936002)(476003)(6116002)(102836004)(58126008)(73956011)(76176011)(6246003)(2906002)(52116002)(33656002)(7736002)(1076003)(305945005)(256004)(8936002)(68736007)(81166006)(14444005)(71200400001)(71190400001)(8676002)(81156014)(186003)(66066001)(14454004)(36756003)(6436002)(5660300002)(6916009)(7416002)(9686003)(6512007)(30126002);
	DIR:OUT; SFP:1501; SCL:5; SRVR:AM4PR08MB2867;
	H:AM4PR08MB2676.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /wj2yAT1Yvr+blMRNkAcDuX7uExSCLApHMiEHOqnhkjkql99c3wfZAiZcdiDv2pvo57DPGTNF2G7yliKktTANw92KykpqHDBndYoHtI2O6vcUEjHw2oGPmi2foXrZQTTdw/aZKEnX0HmtzNvXD3IGlPdJY0ToAVuiNjrVI7q+5l5fUbnjmsY5QSlbR9u3RGON/9RpR2Z/hQmWhLZXxjTHdfhJZjB+YOtqtW5UdtBaeSQpcJRPWGHoNX980HV3sUB2WW7/K+6cDGDKl6Q8oXOUI2guMVRd9uWb3LXCRv23HEPmZ3nA/HmuA2mFPCpMRUH2DJRt0ULdYGWy7kRniRdbdP7QpV8ppzG8Hfj6IUw6ci3Sha2nxOM93eIuPK1tY90EhscKuAzOtjXu9AhuJMiZQyUQUNWb85UDpD2bih8H1DG5OkhcQyPokYKWtbFQg9lo44PGIh71n6yiuHMuTUUWNLbaUyvUuzA4lH5cnFjoPsuvdVQE0tIqOFqybp25lSE
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <F6405D82A3B2A047A2E2E8CA7DC2C70C@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 224e5645-2bcd-4125-baaa-08d6ea8fb7e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2019 15:00:30.9951 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rkagan@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR08MB2867
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 52.101.139.55
Subject: Re: [Qemu-devel] [PATCH 3/4] net/virtio: add failover support
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "pkrempa@redhat.com" <pkrempa@redhat.com>,
	"berrange@redhat.com" <berrange@redhat.com>,
	Eduardo Habkost <ehabkost@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
	"aadam@redhat.com" <aadam@redhat.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Dr.
	David Alan	Gilbert" <dgilbert@redhat.com>, Laine Stump <laine@redhat.com>,
	Jens Freimann <jfreimann@redhat.com>, "ailan@redhat.com" <ailan@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 03, 2019 at 12:46:52PM -0600, Alex Williamson wrote:
> On Mon, 3 Jun 2019 14:10:52 -0400
> Laine Stump <laine@redhat.com> wrote:
>=20
> > On 6/3/19 4:24 AM, Jens Freimann wrote:
> > > On Fri, May 31, 2019 at 06:47:48PM -0300, Eduardo Habkost wrote: =20
> > >> On Thu, May 30, 2019 at 04:56:45PM +0200, Jens Freimann wrote: =20
> > >>> On Tue, May 28, 2019 at 11:04:15AM -0400, Michael S. Tsirkin wrote:=
 =20
> > >>> > On Tue, May 21, 2019 at 10:45:05AM +0100, Dr. David Alan Gilbert =
 =20
> > >>> wrote: =20
> > >>> > > * Jens Freimann (jfreimann@redhat.com) wrote: =20
> > >> [...] =20
> > >>> > > > +=A0=A0=A0 }
> > >>> > > > +=A0=A0=A0 if (migration_in_setup(s) && !should_be_hidden && =
 =20
> > >>> n->primary_dev) { =20
> > >>> > > > +=A0=A0=A0=A0=A0=A0=A0 qdev_unplug(n->primary_dev, &err); =20
> > >>> > >
> > >>> > > Not knowing unplug well; can you just explain - is that device =
hard
> > >>> > > unplugged and it's gone by the time this function returns or is=
  =20
> > >>> it still =20
> > >>> > > hanging around for some indeterminate time? =20
> > >>>
> > >>> Qemu will trigger an unplug request via pcie attention button in=20
> > >>> which case
> > >>> there could be a delay by the guest operating system. We could give=
=20
> > >>> it some
> > >>> amount of time and if nothing happens try surpise removal or handle=
 the
> > >>> error otherwise. =20
> > >>
> > >> I'm missing something here:
> > >>
> > >> Isn't the whole point of the new device-hiding infrastructure to
> > >> prevent QEMU from closing the VFIO until migration ended
> > >> successfully? =20
> > >=20
> > > No. The point of hiding it is to only add the VFIO (that is configure=
d
> > > with the same MAC as the virtio-net device) until the
> > > VIRTIO_NET_F_STANDBY feature is negotiated. We don't want to expose t=
o
> > > devices with the same MAC to guests who can't handle it.
> > >  =20
> > >> What exactly is preventing QEMU from closing the host VFIO device
> > >> after the guest OS has handled the unplug request? =20
> > >=20
> > > We qdev_unplug() the VFIO device and want the virtio-net standby devi=
ce to
> > > take over. If something goes wrong with unplug or
> > > migration in general we have to qdev_plug() the device back.
> > >=20
> > > This series does not try to implement new functionality to close a
> > > device without freeing the resources.
> > >=20
> > >  From the discussion in this thread I understand that is what libvirt
> > > needs though. Something that will trigger the unplug from the
> > > guest but not free the devices resources in the host system (which is
> > > what qdev_unplug() does). Correct?
> > > Why is it bad to fully re-create the device in case of a failed migra=
tion? =20
> >=20
> > I think the concern is that if the device was fully released by qemu=20
> > during migration, it might have already been given to some other/new=20
> > guest during the time that migration is trying to complete. If migratio=
n=20
> > then fails, you may be unable to restore the guest to the previous stat=
e.
>=20
> Yep, plus I think the memory pinning and IOMMU resources could be a
> variable as well.  Essentially, there's no guaranteed reservation to
> the device or any of the additional resources that the device implies
> once it's released, so we want to keep as much of that on hot-standby
> as we can in case the migration fails.  Unfortunately even just
> unmapping the BARs for a guest-only hot-unplug unmaps those regions
> from the IOMMU, but aside from catastrophic resource issues on the
> host, we can essentially guarantee being able to remap those.  Thanks,

Isn't this also the case for guest (re)boots?

IOW libvirt/mgmt will anyway have to be aware of the PT-PV pairing and
that pair being in a degraded state sometimes.  Then the migration of
such VMs would just imply transitioning to the degraded state prior to
the actual migration.  Which sounds much like putting the mostly
existing bits together in libvirt/mgmt and nothing to be done in QEMU.

Am I missing anything?

Thanks,
Roman.

