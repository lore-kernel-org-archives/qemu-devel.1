Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760A1C282CE
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 09:47:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 433A520880
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 09:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="dHzralfd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 433A520880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50266 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDQs3-0005cf-FW
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 05:47:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hDQqD-0004aB-MB
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 05:45:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hDQqC-0008Nv-Lu
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 05:45:25 -0400
Received: from mail-eopbgr130120.outbound.protection.outlook.com
	([40.107.13.120]:33228
	helo=EUR01-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
	id 1hDQqA-0008Lw-4z; Mon, 08 Apr 2019 05:45:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=nfs+pTYpZiwyaSMLqF1Ifpk9ncwGm8yAyqiG9dmX6vM=;
	b=dHzralfdW4Lc6RE0eiN9tg7MuHx3olCoTDQBuRunVCwco5qt6snLeHJdV7la5csZ6JI/3IDUWCOGOCFcrCxa0ebnS3bryEAsIAgIdvgdWWQQW7c6rO2QP+mZN+LopEn6SsMyejEztzjLXDiHjmZLWq4NKp3bL1hfMwhOSIGGCQ4=
Received: from AM6PR08MB4421.eurprd08.prod.outlook.com (20.179.18.23) by
	AM6PR08MB4626.eurprd08.prod.outlook.com (10.255.22.19) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1771.16; Mon, 8 Apr 2019 09:45:18 +0000
Received: from AM6PR08MB4421.eurprd08.prod.outlook.com
	([fe80::d15a:3eaa:44bc:2644]) by
	AM6PR08MB4421.eurprd08.prod.outlook.com
	([fe80::d15a:3eaa:44bc:2644%4]) with mapi id 15.20.1771.019;
	Mon, 8 Apr 2019 09:45:18 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Thread-Topic: [PATCH] block/io.c: fix for the allocation failure
Thread-Index: AQHU67tCeBQBY4L5bEGNNolBmRLa5KYx+32AgAAMlYA=
Date: Mon, 8 Apr 2019 09:45:17 +0000
Message-ID: <3bd0a942-f89b-5302-631a-1b7af3dc8702@virtuozzo.com>
References: <1554474244-553661-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<20190408090013.GJ15001@stefanha-x1.localdomain>
In-Reply-To: <20190408090013.GJ15001@stefanha-x1.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR09CA0054.eurprd09.prod.outlook.com
	(2603:10a6:7:3c::22) To AM6PR08MB4421.eurprd08.prod.outlook.com
	(2603:10a6:20b:71::23)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bdb9e469-8533-4cd7-8d3c-08d6bc06e88b
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);
	SRVR:AM6PR08MB4626; 
x-ms-traffictypediagnostic: AM6PR08MB4626:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <AM6PR08MB4626FC420CC1564F3CE16AD3F42C0@AM6PR08MB4626.eurprd08.prod.outlook.com>
x-forefront-prvs: 0001227049
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(396003)(346002)(39840400004)(366004)(376002)(136003)(189003)(199004)(53936002)(36756003)(52116002)(8676002)(44832011)(8936002)(966005)(6916009)(6306002)(7736002)(316002)(86362001)(2906002)(6246003)(31696002)(2616005)(14454004)(81166006)(107886003)(81156014)(31686004)(486006)(446003)(71200400001)(6512007)(76176011)(11346002)(476003)(71190400001)(105586002)(4326008)(54906003)(106356001)(478600001)(99286004)(229853002)(186003)(25786009)(68736007)(305945005)(4744005)(26005)(66066001)(6506007)(386003)(256004)(14444005)(6116002)(102836004)(6486002)(97736004)(3846002)(53546011)(5660300002)(6436002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4626;
	H:AM6PR08MB4421.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nf+8Le6D1tVLD06OOn1PEpD259e/pHaII4AnVUZ1CvuU90vSuLmVa/0IXmhppebQIQ4BC0ycw7JZOdpCeeSS63h68zZ2CcvoRvm+i1lSHsi/Zvyp2MQrOG4oBFRBp50lAUZGKc1EtRi4qtc1SSmipWa0jXp5sAGT2d9rXOeoHP+FRuKTkj0d6dbHd426aOr3XwyV0uMhlUxiZWIZm8mbuy2AsX9L+n3hgyRyz233mrSsCCJwvDFlmF66O1lwCGUSdJn4WNK4CiY9ZYy8B3feIblVb2an8LizbZAsKIWaqcXXDVYgJNPc3DejcmMYyDoHp1bnI15uoos6xpsgbDK/svrPWI0OXBxyNou1TmCA2eZywQPYVk3yErpfJnIgeLvSsgwAdQue3oOYti6438oorKXn2U2arRx2+yXA8fREsNI=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <7502647989D87A45A286282D2EFCDB75@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdb9e469-8533-4cd7-8d3c-08d6bc06e88b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2019 09:45:17.8810 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4626
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.13.120
Subject: Re: [Qemu-devel] [PATCH] block/io.c: fix for the allocation failure
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
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
	Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	Denis Lunev <den@virtuozzo.com>,
	"qemu-block@nongnu.org" <qemu-block@nongnu.org>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408094517.-2fWsLbTpC7hOEnkE-reZmRZj_dnzAt59crGkSSWwdo@z>



On 08/04/2019 12:00, Stefan Hajnoczi wrote:
> On Fri, Apr 05, 2019 at 05:24:04PM +0300, Andrey Shinkevich wrote:
>> On a file system used by the customer, fallocate() returns an error
>> if the block is not properly aligned. So, bdrv_co_pwrite_zeroes()
>> fails. We can handle that case the same way as it is done for the
>> unsupported cases, namely, call to bdrv_driver_pwritev() that writes
>> zeroes to an image for the unaligned chunk of the block.
>>
>> Suggested-by: Denis V. Lunev <den@openvz.org>
>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>> ---
>>   block/io.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> Thanks, applied to my block-next tree for QEMU 4.1:
> https://github.com/stefanha/qemu/commits/block-next
>=20
> Stefan
>=20

Thank you all!
--=20
With the best regards,
Andrey Shinkevich

