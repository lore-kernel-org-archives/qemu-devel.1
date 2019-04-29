Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF54C04AA6
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 09:10:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAA9420578
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 09:10:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ic/4agU1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAA9420578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54367 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL2Iq-0003Le-4Q
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 05:10:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hL2Gp-0001YM-9L
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 05:08:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hL27V-0006qa-Mi
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 04:58:43 -0400
Received: from mail-eopbgr90102.outbound.protection.outlook.com
	([40.107.9.102]:13280
	helo=FRA01-MR2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hL27V-0006qO-FL
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 04:58:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=Si1kY3+O+a96siVqjzprlahGtKNNS5YBpnSm0CoJNKM=;
	b=ic/4agU1q4lKBN118Dks8J+Kd438qyNEvSNmFETijlf9Mslz1ESioiqA95WoafTZ6Ddyt4zRB9ANLxIFZw1/UhOoYw7C5urAULpSC+NKO3op0TokmxzV3Mwy+SKHpYezrvFo03Ctb1bhRy5gj7KUJVSZjAAAEQSSPAYxaxSEBnA=
Received: from PR2PR08MB4684.eurprd08.prod.outlook.com (52.133.109.209) by
	PR2PR08MB4827.eurprd08.prod.outlook.com (52.133.108.141) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1835.13; Mon, 29 Apr 2019 08:58:37 +0000
Received: from PR2PR08MB4684.eurprd08.prod.outlook.com
	([fe80::88d7:ecf0:1120:f1a1]) by
	PR2PR08MB4684.eurprd08.prod.outlook.com
	([fe80::88d7:ecf0:1120:f1a1%3]) with mapi id 15.20.1835.018;
	Mon, 29 Apr 2019 08:58:37 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Martin Kletzander <mkletzan@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Thread-Topic: [Qemu-devel] Possibly incorrect data sparsification by qemu-img
Thread-Index: AQHU+cg/x9u6pQM730uOb2lCE8MzcKZJqAYAgAAllACAAAu5gIABBDIAgAAK+ICAB934AIAAGW6A
Date: Mon, 29 Apr 2019 08:58:37 +0000
Message-ID: <ccc8393b-8b59-63ce-c3c3-618d52cfca3e@virtuozzo.com>
References: <20190423113028.GD30014@wheatley>
	<20190423121218.GF9041@localhost.localdomain>
	<20190423142648.GA2967@wheatley>
	<20190423150845.GG9041@localhost.localdomain>
	<aeb62174-5aad-676e-792d-e71d694dbd1e@virtuozzo.com>
	<20190424071917.GA15891@linux.fritz.box>
	<20190429072734.GC8818@wheatley>
In-Reply-To: <20190429072734.GC8818@wheatley>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR09CA0067.eurprd09.prod.outlook.com
	(2603:10a6:7:3d::11) To PR2PR08MB4684.eurprd08.prod.outlook.com
	(2603:10a6:101:22::17)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190429115835275
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aef28d1a-bcef-47b2-40ae-08d6cc80ddff
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:PR2PR08MB4827; 
x-ms-traffictypediagnostic: PR2PR08MB4827:
x-microsoft-antispam-prvs: <PR2PR08MB48275B6B55DDA752D26ED622C1390@PR2PR08MB4827.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0022134A87
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(346002)(366004)(39840400004)(136003)(376002)(396003)(199004)(189003)(5660300002)(14444005)(2906002)(8936002)(81156014)(73956011)(476003)(66446008)(64756008)(66556008)(66476007)(66066001)(81166006)(8676002)(478600001)(68736007)(14454004)(3846002)(6116002)(446003)(2616005)(66946007)(11346002)(110136005)(54906003)(316002)(25786009)(6506007)(6512007)(386003)(4326008)(53936002)(6436002)(305945005)(6486002)(7736002)(76176011)(36756003)(229853002)(6246003)(93886005)(99286004)(86362001)(186003)(26005)(52116002)(256004)(31686004)(97736004)(31696002)(71190400001)(486006)(71200400001)(102836004)(33290500001)(505234006);
	DIR:OUT; SFP:1102; SCL:1; SRVR:PR2PR08MB4827;
	H:PR2PR08MB4684.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /x/3hgoHknbYkzcNVJTTOe5vzSOrMbn28bxsANxSSDvG4yzN+k4b76iPZua2t1NrN0j9Io/hreM7JTgmIxAADohIYkQeaM7G6fso8Ot/jsZAm87jIV9KXBfD42g1Gc1O813/3YftAHU3AyPH2lekX8n29f9VIpvJu+//j3C1KI/6FR44TmY60yAC42rb81yfvI8P+BsizAL/jjQGkgJcLBqPb/CSOBx1p/Ws8sRkUEP1RiVPN6LIEdPIypZ5e0qtw/OFjJsad475YKQ9uSeOys2vXUZ7mT6WYAb3EgdGK6qO9cgOUWSrpp4eYvC/Dbs+2nKzhtL6Zlw/rkQaIpMSwvOXAYhaiX/jPAtFGWCJfK7l0+0B040KYeZPPS8fRYtIGxPUUklRqodnnWmHywUv8+0hmadzOKskbTfE7te5Msg=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <19541D4B6E50424AB46AFCE1AE986AC4@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aef28d1a-bcef-47b2-40ae-08d6cc80ddff
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2019 08:58:37.4068 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR2PR08MB4827
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.9.102
Subject: Re: [Qemu-devel] Possibly incorrect data sparsification by qemu-img
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	Richard Jones <rjones@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429085837.CWbtcIPvKTNX83dG7p66aWzU0di3fXw61PpTbEZtQvg@z>

29.04.2019 10:27, Martin Kletzander wrote:
> On Wed, Apr 24, 2019 at 09:19:17AM +0200, Kevin Wolf wrote:
>> Am 24.04.2019 um 08:40 hat Vladimir Sementsov-Ogievskiy geschrieben:
>>> 23.04.2019 18:08, Kevin Wolf wrote:
>>> > Am 23.04.2019 um 16:26 hat Martin Kletzander geschrieben:
>>> >> On Tue, Apr 23, 2019 at 02:12:18PM +0200, Kevin Wolf wrote:
>>> >>> Am 23.04.2019 um 13:30 hat Martin Kletzander geschrieben:
>>> >>>> Hi,
>>> >>>>
>>> >>>> I am using qemu-img with nbdkit to transfer a disk image and the u=
pdate it with
>>> >>>> extra data from newer snapshots.=A0 The end image cannot be transf=
erred because
>>> >>>> the snapshots will be created later than the first transfer and we=
 want to save
>>> >>>> some time up front.=A0 You might think of it as a continuous synch=
ronisation.=A0 It
>>> >>>> looks something like this:
>>> >>>>
>>> >>>> I first transfer the whole image:
>>> >>>>
>>> >>>>=A0=A0 qemu-img convert -p $nbd disk.raw
>>> >>>>
>>> >>>> Where `$nbd` is something along the lines of `nbd+unix:///?socket=
=3Dnbdkit.sock`
>>> >>>>
>>> >>>> Then, after the next snapshot is created, I can update it thanks t=
o the `-n`
>>> >>>> parameter (the $nbd now points to the newer snapshot with unchange=
d data looking
>>> >>>> like holes in the file):
>>> >>>>
>>> >>>>=A0=A0 qemu-img convert -p -n $nbd disk.raw
>>> >>>>
>>> >>>> This is fast and efficient as it uses block status nbd extension, =
so it only
>>> >>>> transfers new data.
>>> >>>
>>> >>> This is an implementation detail. Don't rely on it. What you're doi=
ng is
>>> >>> abusing 'qemu-img convert', so problems like what you describe are =
to be
>>> >>> expected.
>>> >>>
>>> >>>> This can be done over and over again to keep the local
>>> >>>> `disk.raw` image up to date with the latest remote snapshot.
>>> >>>>
>>> >>>> However, when the guest OS zeroes some of the data and it gets wri=
tten into the
>>> >>>> snapshot, qemu-img scans for those zeros and does not write them t=
o the
>>> >>>> destination image.=A0 Checking the output of `qemu-img map --outpu=
t=3Djson $nbd`
>>> >>>> shows that the zeroed data is properly marked as `data: true`.
>>> >>>>
>>> >>>> Using `-S 0` would write zeros even where the holes are, effective=
ly overwriting
>>> >>>> the data from the last snapshot even though they should not be cha=
nged.
>>> >>>>
>>> >>>> Having gone through some workarounds I would like there to be anot=
her way.=A0 I
>>> >>>> know this is far from the typical usage of qemu-img, but is this r=
eally the
>>> >>>> expected behaviour or is this just something nobody really needed =
before?=A0 If it
>>> >>>> is the former, would it be possible to have a parameter that would=
 control this
>>> >>>> behaviour?=A0 If the latter is the case, can that behaviour be cha=
nged so that it
>>> >>>> properly replicates the data when `-n` parameter is used?
>>> >>>>
>>> >>>> Basically the only thing we need is to either:
>>> >>>>
>>> >>>> 1) write zeros where they actually are or
>>> >>>>
>>> >>>> 2) turn off explicit sparsification without requesting dense image=
 (basically
>>> >>>>=A0=A0=A0=A0 sparsify only the par that is reported as hole on the =
source) or
>>> >>>>
>>> >>>> 3) ideally, just FALLOC_FL_PUNCH_HOLE in places where source did r=
eport data,
>>> >>>>=A0=A0=A0=A0 but qemu-img found they are all zeros (or source repor=
ted HOLE+ZERO which, I
>>> >>>>=A0=A0=A0=A0 believe, is effectively the same)
>>> >>>>
>>> >>>> If you want to try this out, I found the easiest reproducible way =
is using
>>> >>>> nbdkit's data plugin, which can simulate whatever source image you=
 like.
>>> >>>
>>> >>> I think what you _really_ want is a commit block job. The problem i=
s
>>> >>> just that you don't have a proper backing file chain, but just a bu=
nch
>>> >>> of NBD connections.
>>> >>>
>>> >>> Can't you get an NBD connection that already provides the condensed=
 form
>>> >>> of the whole snapshot chain directly at the source? If the NBD serv=
er
>>> >>> was QEMU, this would actually be easier than providing each snapsho=
t
>>> >>> individually.
>>> >>>
>>> >>> If this isn't possible, I think you need to replicate the backing c=
hain
>>> >>> on the destination instead of converting into the same image again =
and
>>> >>> again so that qemu-img knows that it must take existing data of the
>>> >>> backing file into consideration:
>>> >>>
>>> >>>=A0=A0=A0=A0 qemu-img convert -O qcow2 nbd://... base.qcow2
>>> >>>=A0=A0=A0=A0 qemu-img convert -O qcow2 -F qcow2 -B base.qcow2 nbd://=
... overlay1.qcow2
>>> >>>=A0=A0=A0=A0 qemu-img convert -O qcow2 -F qcow2 -B overlay1.qcow2 nb=
d://... overlay2.qcow2
>>> >>>=A0=A0=A0=A0 ...
>>>
>=20
> So I spoke too soon.=A0 This approach fixed the one thing that I was stru=
ggling with, but broke the rest, because it completely replicates the last =
image even when the source provides proper allocation data.=A0 Best to show=
 with an illustration:
>=20
>  =A0$ rm -f disk.img snap.img
>  =A0$ dd if=3D/dev/urandom of=3Ddisk.img bs=3D2M count=3D1
>  =A0$ dd if=3D/dev/zero of=3Dsnap.img bs=3D1M count=3D1
>  =A0$ truncate -s 2M snap.img
>  =A0$ qemu-img map --output=3Djson snap.img
>  =A0[{ "start": 0, "length": 1048576, "depth": 0, "zero": false, "data": =
true, "offset": 0},
>  =A0{ "start": 1048576, "length": 1048576, "depth": 0, "zero": true, "dat=
a": false, "offset": 1048576}]
>  =A0$ qemu-img convert -f raw -O qcow2 disk.img disk.qcow2
>  =A0$ qemu-img convert -f raw -O qcow2 -B disk.qcow2 snap.img snap.qcow2
>  =A0$ qemu-img convert -f qcow2 -O raw snap.qcow2 output.raw
>  =A0$ hexdump -C output.raw
>  =A000000000=A0 00 00 00 00 00 00 00 00=A0 00 00 00 00 00 00 00 00=A0 |..=
..............|
>  =A0*
>  =A000200000
>=20


Raw file holes and qcow2 unallocated clusters are not the same thing. Raw h=
oles are reported
as zero=3Dtrue (as we see in map output), and this considered "allocated" i=
n terms of backing-chain.
And convert will mark corresponding clusters to be ZERO (not UNALLOCATED) i=
n target qcow2.

But when you export qcow2 with unallocated clusters through NBD, unallocate=
d clusters should be
reported as zero=3Dfalse data=3Dfalse, and qemu-img will convert them to UN=
ALLOCATED (not ZERO)
clusters in target qcow2 and it should work.

In qcow2 ZERO and UNALLOCATED clusters works like this:
ZERO: on write - allocate clusters and write data, on read - return zeroes
UNALLOCATED: on write -allocate clusters and write data, on read - read fro=
m backing file if we have it, otherwise return zeroes


--=20
Best regards,
Vladimir

