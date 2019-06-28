Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 574ACC5B57A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 18:25:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F91D20828
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 18:25:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="Zz2vz6WW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F91D20828
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgvYY-0003mR-C0
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 14:25:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59644)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aaron@os.amperecomputing.com>) id 1hgv8Y-0001t7-OG
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 13:58:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aaron@os.amperecomputing.com>) id 1hgv8V-0002py-GL
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 13:58:13 -0400
Received: from mail-eopbgr770112.outbound.protection.outlook.com
 ([40.107.77.112]:51510 helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aaron@os.amperecomputing.com>)
 id 1hgv8V-0002nX-1O
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 13:58:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=ZLLCr+rL/xLUXJJMzP8zCH/pgqTUaDCYLUn+NUtCDwPYzcAkGNre7X6pe0aOUlIWnhxlH4IWhMO50hjm+t/drjTv7AmrRlAlKi1SY62lWkV0Oj95ppPoeDPMytYJ1Ii9wGCFnAfwpw+cFH/qaQh0DfoGS4MdSTgF4nHx0i1IQRA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xxe3IcRrRyI8Y3xsclUhNmRtYIMIlWZ9hbW0jFGgbPA=;
 b=QSat+cbT+Ue+6hUzOfPUzKwFScBeynv1RTEL72VQO+UnyP669r/UMLvUfTQ8vfHbTrZOwBk5MPmrQrvMamxz45UfOVu0qfEA1pfGEQntXHWsOjs8XdX/c5CgOxWl+g1fcXH4KbR4xsOY83yrblHt2njbzAHDbOK40IS5NhKAdQU=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xxe3IcRrRyI8Y3xsclUhNmRtYIMIlWZ9hbW0jFGgbPA=;
 b=Zz2vz6WWSh/nJM62H39xMhpl+QDOO8QLeSI6ACwENBHzjfBXc1wMDxeQYkLCAfkZeH8MwgFWmF1GdjDiJ/p9+i0J8TNEHDHCs2yrivmxXDboW5aNGwXOP9SH4nozi8wSMmHOKRQ+bqFjRlqhZfI2+s1TCahHMjX5qatT11zI6Yo=
Received: from DM6PR01MB4825.prod.exchangelabs.com (20.177.218.222) by
 DM6PR01MB5530.prod.exchangelabs.com (20.179.68.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Fri, 28 Jun 2019 17:58:04 +0000
Received: from DM6PR01MB4825.prod.exchangelabs.com
 ([fe80::390e:9996:6dec:d60f]) by DM6PR01MB4825.prod.exchangelabs.com
 ([fe80::390e:9996:6dec:d60f%6]) with mapi id 15.20.2032.018; Fri, 28 Jun 2019
 17:58:04 +0000
To: =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
Thread-Topic: [Qemu-devel] [PATCH v3 19/50] tcg: let plugins instrument memory
 accesses
Thread-Index: AQHVIt11hLjmFwnAA0W4zaK1l+4xhaaxRysAgAAcDgCAAA0TAA==
Date: Fri, 28 Jun 2019 17:58:04 +0000
Message-ID: <20190628175756.GC26345@quinoa.localdomain>
References: <20190614171200.21078-1-alex.bennee@linaro.org>
 <20190614171200.21078-20-alex.bennee@linaro.org>
 <20190628153044.GB26345@quinoa.localdomain>
 <87mui1ab4j.fsf@zen.linaroharston>
In-Reply-To: <87mui1ab4j.fsf@zen.linaroharston>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CY4PR2201CA0031.namprd22.prod.outlook.com
 (2603:10b6:910:3e::20) To DM6PR01MB4825.prod.exchangelabs.com
 (2603:10b6:5:6b::30)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aaron@os.amperecomputing.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [108.169.132.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0fc14328-ff14-4242-4ba1-08d6fbf22b05
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DM6PR01MB5530; 
x-ms-traffictypediagnostic: DM6PR01MB5530:
x-microsoft-antispam-prvs: <DM6PR01MB5530685363C7602BB563ED8A8AFC0@DM6PR01MB5530.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 00826B6158
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(376002)(39840400004)(366004)(136003)(396003)(346002)(189003)(199004)(476003)(446003)(52116002)(99286004)(66066001)(11346002)(6246003)(102836004)(386003)(6506007)(76176011)(14454004)(68736007)(33656002)(66446008)(305945005)(81166006)(66556008)(64756008)(81156014)(66476007)(486006)(25786009)(66946007)(66574012)(1076003)(8676002)(229853002)(478600001)(7736002)(6916009)(186003)(9686003)(6512007)(53936002)(26005)(6486002)(73956011)(4326008)(2906002)(6436002)(8936002)(3846002)(71190400001)(6116002)(14444005)(54906003)(5660300002)(71200400001)(86362001)(316002)(256004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM6PR01MB5530;
 H:DM6PR01MB4825.prod.exchangelabs.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:0; 
received-spf: None (protection.outlook.com: os.amperecomputing.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: WIBaywki+aTNzsERuMLK8XqLYuSEV/QI9swDwN3gXQ72XPt17AQlEXgPSGsghbzIzy0xNz3bxhx+ll8m3koVF1QgehGHGgm1tahAHcF8FH1wbE5Y921KfR9nsHpwoVFddSmYurLdrMri7u6N5j1yGqAlodmZmsUA0S79/pXbN7HCwZopHl504SlrNqb7n08xF7ZrfFJ9Uzpmu/caBeN4kcNP0sBrO2WNuJy/chkfW+c2qqKfELbzMIJE7hRV9i0mEkVV+3aLJTU4RQdmliCyYV45D74sMC/q+fPRj0XqUhpJQNT1Irneu1vX+spbOPktcVP46Ui9r+AkjJ7Ta8gpDeybYMX84VKiyyROn2ZmBxyJY45a13wPnmGNzwpm28VfS86UbtYdakHQTqhz1nSgacWsHPWUolAo739Qb7Zro58=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <32C5D270488A0C4687AA6052D7CDA529@prod.exchangelabs.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fc14328-ff14-4242-4ba1-08d6fbf22b05
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2019 17:58:04.5426 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Aaron@os.amperecomputing.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR01MB5530
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.77.112
Subject: Re: [Qemu-devel] [PATCH v3 19/50] tcg: let plugins instrument
 memory accesses
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
From: Aaron Lindsay OS via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: Aaron Lindsay OS <aaron@os.amperecomputing.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Emilio G. Cota" <cota@braap.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Jun 28 18:11, Alex Benn=E9e wrote:
> Aaron Lindsay OS <aaron@os.amperecomputing.com> writes:
> > On Jun 14 18:11, Alex Benn=E9e wrote:
> >> From: "Emilio G. Cota" <cota@braap.org>
> >>
> >> Here the trickiest feature is passing the host address to
> >> memory callbacks that request it. Perhaps it would be more
> >> appropriate to pass a "physical" address to plugins, but since
> >> in QEMU host addr ~=3D guest physical, I'm going with that for
> >> simplicity.
> >
> > How much more difficult would it be to get the true physical address (o=
n
> > the guest)?
>=20
> Previously there was a helper that converted host address (i.e. where
> QEMU actually stores that value) back to the physical address (ram
> offset + ram base). However the code for calculating all of this is
> pretty invasive and requires tweaks to all the softmmu TCG backends as
> well as hooks into a slew of memory functions.
>=20
> I'm re-working this now so we just have the one memory callback and we
> provide a helper function that can provide an opaque hwaddr struct which
> can then be queried.

To make sure I understand - you're implying that one such query will
return the PA from the guest's perspective, right?

> The catch is you can only call this helper during a
> memory callback.

Does this mean it will be difficult to get the physical address for the
bytes containing the instruction encoding itself?

> I'm not sure if having this restriction violates our
> aim of not leaking implementation details to the plugin but it makes the
> code simpler.

Assuming that the purpose of "not leaking implementation details" is to
allow the same plugin interface to work with other backend
implementations in the future, isn't this probably fine? It may add an
unnecessary limitation for another backend driving the same plugin
interface, but I don't think it likely changes the structure of the
interface itself. And that seems like the sort of restriction that could
easily be dropped in the future while remaining backwards-compatible.

> Internally what the helper does is simply re-query the SoftMMU TLB. As
> the TLBs are per-CPU nothing else can have touched the TLB and the cache
> should be hot so the cost of lookup should be minor. We could also
> potentially expand the helpers so if you are interested in only IO
> accesses we can do the full resolution and figure out what device we
> just accessed.

Oh, so you're already working on doing just what I asked about?

> > This is important enough to me that I would be willing to help if
> > pointed in the right direction.
>=20
> Well I'll certainly CC on the next series (hopefully posted Monday,
> softfreeze starts Tuesday). I'll welcome any testing and review. Also if
> you can tell us more about your use case that will help.

Awesome, thanks!

In terms of our use case - we use QEMU to drive studies to help us
design the next generation of processors. As you can imagine, having the
right physical addresses is important for some aspects of that. We're
currently using a version of Pavel Dovgalyuk's earlier plugin patchset
with some of our own patches/fixes on top, but it would obviously make
our lives easier to work together to get this sort of infrastructure
upstream!

-Aaron

