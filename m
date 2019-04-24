Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B94C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 06:47:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A9172148D
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 06:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="RvAvPChn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A9172148D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36827 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJBgo-0004A5-41
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 02:47:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hJBf5-0002kU-Nq
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 02:45:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hJBZi-0003En-L0
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 02:40:11 -0400
Received: from mail-eopbgr150114.outbound.protection.outlook.com
	([40.107.15.114]:62955
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hJBZi-0003Ag-3Z
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 02:40:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=tmhRoTg2wwLd+n4RLfubqu56zLOAs+K2hyW9MzPTujg=;
	b=RvAvPChnOUb3glEnnO74CPqCaZP4WNe+Eu48H2KBna3JhesGXBaBepkaR+YR+zysrKbqMGPuDnKK7aioPd+KGFPGyKidoobAnNTEO+DSBlBLzjryav+MCaz4yJvFqzVzG1vqffap1fNQyRrybS2Kui+R61lMwys6adBDrimaD1g=
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com (20.178.46.222) by
	DB7PR08MB3354.eurprd08.prod.outlook.com (52.134.111.149) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1813.17; Wed, 24 Apr 2019 06:40:05 +0000
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949]) by
	DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949%3]) with mapi id 15.20.1813.017;
	Wed, 24 Apr 2019 06:40:05 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>, Martin Kletzander <mkletzan@redhat.com>
Thread-Topic: [Qemu-devel] Possibly incorrect data sparsification by qemu-img
Thread-Index: AQHU+cg/x9u6pQM730uOb2lCE8MzcKZJqAYAgAAllACAAAu5gIABBDIA
Date: Wed, 24 Apr 2019 06:40:04 +0000
Message-ID: <aeb62174-5aad-676e-792d-e71d694dbd1e@virtuozzo.com>
References: <20190423113028.GD30014@wheatley>
	<20190423121218.GF9041@localhost.localdomain>
	<20190423142648.GA2967@wheatley>
	<20190423150845.GG9041@localhost.localdomain>
In-Reply-To: <20190423150845.GG9041@localhost.localdomain>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0180.eurprd05.prod.outlook.com
	(2603:10a6:3:f8::28) To DB7PR08MB3851.eurprd08.prod.outlook.com
	(2603:10a6:10:7b::30)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190424094002330
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 98b245f9-cee8-4fb0-503b-08d6c87faf19
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:DB7PR08MB3354; 
x-ms-traffictypediagnostic: DB7PR08MB3354:
x-microsoft-antispam-prvs: <DB7PR08MB33540C8C7E4D13FBD250F495C13C0@DB7PR08MB3354.eurprd08.prod.outlook.com>
x-forefront-prvs: 00179089FD
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(396003)(136003)(366004)(376002)(346002)(39850400004)(189003)(199004)(81166006)(2906002)(5660300002)(71190400001)(229853002)(478600001)(6436002)(3846002)(8676002)(6116002)(71200400001)(36756003)(31696002)(68736007)(97736004)(14454004)(93886005)(31686004)(86362001)(316002)(81156014)(102836004)(66066001)(476003)(4326008)(54906003)(6506007)(386003)(99286004)(8936002)(7736002)(6246003)(6512007)(6486002)(53936002)(446003)(305945005)(76176011)(486006)(2616005)(64756008)(256004)(110136005)(186003)(66946007)(66556008)(66476007)(73956011)(52116002)(66446008)(25786009)(11346002)(26005)(14444005)(33290500001);
	DIR:OUT; SFP:1102; SCL:1; SRVR:DB7PR08MB3354;
	H:DB7PR08MB3851.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FfhjPa1wjTwNwZCXFWZrvXjGjHn+UHi0ZRofDS/l/mnISCdAL9dbLihuRIR8ytbr2D+E5oO+W3I9NpsENUD5jULQfBjFmd7EcOfyLda8J3nn6SuY+cK8JTQFQVOmG+H08r+lSWlWNHsijVGFNdJ2+ZyFjXoXpIShwaXHF+AgH1wyXl5q5Qtr8fmYV2R+Py+5H04zwPYMWB8dv8kC7q/GjVrgYoyFj/T0KpBqp0hPI9GUcaGci9Wr5htP5wgwhL0Q607+kNAQ3UKjDOaCdcaekINMbrexgVBGWSId+qGEpQQORT+SD3f+5Rtk9JsW7oPi+fuq5wh8ktci/U+4BSsh8kG3Nexf2x5bv5IEAckdP0CrP2m3tYpgwp6WiMCyg0BzjoKUViptaZJuANj5zN/4Y//y55KU7KNVYOLQne/FjAs=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <9656653A1CF5874483A8CFDEB232A8E9@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98b245f9-cee8-4fb0-503b-08d6c87faf19
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2019 06:40:05.3434 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3354
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.15.114
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
Message-ID: <20190424064004.iX-R3CqmIaqGpNECBMIEeBHn3MUyE4udnSBKCmcdenU@z>

23.04.2019 18:08, Kevin Wolf wrote:
> Am 23.04.2019 um 16:26 hat Martin Kletzander geschrieben:
>> On Tue, Apr 23, 2019 at 02:12:18PM +0200, Kevin Wolf wrote:
>>> Am 23.04.2019 um 13:30 hat Martin Kletzander geschrieben:
>>>> Hi,
>>>>
>>>> I am using qemu-img with nbdkit to transfer a disk image and the updat=
e it with
>>>> extra data from newer snapshots.  The end image cannot be transferred =
because
>>>> the snapshots will be created later than the first transfer and we wan=
t to save
>>>> some time up front.  You might think of it as a continuous synchronisa=
tion.  It
>>>> looks something like this:
>>>>
>>>> I first transfer the whole image:
>>>>
>>>>   qemu-img convert -p $nbd disk.raw
>>>>
>>>> Where `$nbd` is something along the lines of `nbd+unix:///?socket=3Dnb=
dkit.sock`
>>>>
>>>> Then, after the next snapshot is created, I can update it thanks to th=
e `-n`
>>>> parameter (the $nbd now points to the newer snapshot with unchanged da=
ta looking
>>>> like holes in the file):
>>>>
>>>>   qemu-img convert -p -n $nbd disk.raw
>>>>
>>>> This is fast and efficient as it uses block status nbd extension, so i=
t only
>>>> transfers new data.
>>>
>>> This is an implementation detail. Don't rely on it. What you're doing i=
s
>>> abusing 'qemu-img convert', so problems like what you describe are to b=
e
>>> expected.
>>>
>>>> This can be done over and over again to keep the local
>>>> `disk.raw` image up to date with the latest remote snapshot.
>>>>
>>>> However, when the guest OS zeroes some of the data and it gets written=
 into the
>>>> snapshot, qemu-img scans for those zeros and does not write them to th=
e
>>>> destination image.  Checking the output of `qemu-img map --output=3Djs=
on $nbd`
>>>> shows that the zeroed data is properly marked as `data: true`.
>>>>
>>>> Using `-S 0` would write zeros even where the holes are, effectively o=
verwriting
>>>> the data from the last snapshot even though they should not be changed=
.
>>>>
>>>> Having gone through some workarounds I would like there to be another =
way.  I
>>>> know this is far from the typical usage of qemu-img, but is this reall=
y the
>>>> expected behaviour or is this just something nobody really needed befo=
re?  If it
>>>> is the former, would it be possible to have a parameter that would con=
trol this
>>>> behaviour?  If the latter is the case, can that behaviour be changed s=
o that it
>>>> properly replicates the data when `-n` parameter is used?
>>>>
>>>> Basically the only thing we need is to either:
>>>>
>>>> 1) write zeros where they actually are or
>>>>
>>>> 2) turn off explicit sparsification without requesting dense image (ba=
sically
>>>>     sparsify only the par that is reported as hole on the source) or
>>>>
>>>> 3) ideally, just FALLOC_FL_PUNCH_HOLE in places where source did repor=
t data,
>>>>     but qemu-img found they are all zeros (or source reported HOLE+ZER=
O which, I
>>>>     believe, is effectively the same)
>>>>
>>>> If you want to try this out, I found the easiest reproducible way is u=
sing
>>>> nbdkit's data plugin, which can simulate whatever source image you lik=
e.
>>>
>>> I think what you _really_ want is a commit block job. The problem is
>>> just that you don't have a proper backing file chain, but just a bunch
>>> of NBD connections.
>>>
>>> Can't you get an NBD connection that already provides the condensed for=
m
>>> of the whole snapshot chain directly at the source? If the NBD server
>>> was QEMU, this would actually be easier than providing each snapshot
>>> individually.
>>>
>>> If this isn't possible, I think you need to replicate the backing chain
>>> on the destination instead of converting into the same image again and
>>> again so that qemu-img knows that it must take existing data of the
>>> backing file into consideration:
>>>
>>>     qemu-img convert -O qcow2 nbd://... base.qcow2
>>>     qemu-img convert -O qcow2 -F qcow2 -B base.qcow2 nbd://... overlay1=
.qcow2
>>>     qemu-img convert -O qcow2 -F qcow2 -B overlay1.qcow2 nbd://... over=
lay2.qcow2
>>>     ...

Is it safe in general?

Qemu often consider rounding-up allocated ranges to be safe, or just consid=
er unknown area as allocated.
And if this happen, we'll convert unallocated hole to allocated zeroes on t=
arget, which will break
backing chain.

This way would be correct if on source under nbd server we have valid backi=
ng chain too, so in case of
"rounding-up" we'll just read valid data from backing. But it is not the ca=
se (or sorry, if I misunderstood).

>>>
>>
>> I thought of this, but (to be honest) I did not know that `-B` would
>> work for nbd.
>=20
> It still depends on the NBD server providing the right block allocation
> status, but that's no worse than what you needed for -n. But whether -B
> can be used at all depends on the target format, not the source.
>=20
>> Does it assume that data are to be taken from the base image if and
>> only if the source (be it nbd server or just a plain file) says there
>> is a hole?  If yes, then it could nicely solve the issue.
>=20
> I haven't tested it now, but yes, that's what I remember it to do.
>=20
> Looking at the code, the requirement seems to be that the NBD server
> flags the sparse blocks as a HOLE, but not as ZERO.
>=20
> Kevin
>=20


--=20
Best regards,
Vladimir

