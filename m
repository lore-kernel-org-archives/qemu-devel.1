Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61599C31E51
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 07:39:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FB9A2082C
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 07:39:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Sev+vtTK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FB9A2082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54484 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hd8iM-0003Yp-Cw
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 03:39:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56803)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hd8hD-0002ej-5e
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 03:38:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hd8hC-0005VY-2v
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 03:38:23 -0400
Received: from mail-eopbgr140113.outbound.protection.outlook.com
 ([40.107.14.113]:52870 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hd8h9-0005RY-Jl; Tue, 18 Jun 2019 03:38:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zvtGXGy8W1dTPUn6zVVoTal3A+/2qo6n6sDpGEFp6JI=;
 b=Sev+vtTKHgtxzQ+oVBhNf17wE2uW1ggdQddzIXmUZpRxwFqexjaVM6DUFGgxLvE82t42WUQLCHreD4D4wQ4pIBBJdiWq7DF8HuGOU1LZIEygAXfT0kjQQvO91yB/4tkyk7EEcsK4ZSfTQRwYGo0sfTjKoOCS0EaxEdqMbyEwuJg=
Received: from DBBPR08MB4838.eurprd08.prod.outlook.com (20.179.46.151) by
 DBBPR08MB4775.eurprd08.prod.outlook.com (20.179.45.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.12; Tue, 18 Jun 2019 07:38:14 +0000
Received: from DBBPR08MB4838.eurprd08.prod.outlook.com
 ([fe80::9c49:321c:cc13:35d3]) by DBBPR08MB4838.eurprd08.prod.outlook.com
 ([fe80::9c49:321c:cc13:35d3%3]) with mapi id 15.20.1987.014; Tue, 18 Jun 2019
 07:38:14 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>
Thread-Topic: [PATCH 0/3] block: blk_co_pcache
Thread-Index: AQHVHG6Gw8f3OdFEe0GxA9A7ku3zhaaOpkUAgAADMICAEU1cAP//21mAgAAQqACAAANLgIABMpKA
Date: Tue, 18 Jun 2019 07:38:14 +0000
Message-ID: <25f4917f-8480-069f-4958-aa4a89113cdb@virtuozzo.com>
References: <20190606134814.123689-1-vsementsov@virtuozzo.com>
 <f92b274d-1949-3afa-7353-d3e3d67ae705@redhat.com>
 <dbacab33-ccb4-0c1e-5ce3-7214bd405701@virtuozzo.com>
 <4ec35629-0c64-9727-780f-31e4e494f376@virtuozzo.com>
 <20190617120929.GF7397@linux.fritz.box>
 <cbec5fee-8c57-f929-28b0-e68e1992c757@redhat.com>
 <20190617132053.GI7397@linux.fritz.box>
In-Reply-To: <20190617132053.GI7397@linux.fritz.box>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0701CA0062.eurprd07.prod.outlook.com
 (2603:10a6:3:9e::30) To DBBPR08MB4838.eurprd08.prod.outlook.com
 (2603:10a6:10:d9::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190618103809620
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dac5d1f7-be7f-4e35-e9fa-08d6f3bfebfd
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DBBPR08MB4775; 
x-ms-traffictypediagnostic: DBBPR08MB4775:
x-microsoft-antispam-prvs: <DBBPR08MB4775E630D6D75F6846321CA1C1EA0@DBBPR08MB4775.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 007271867D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(396003)(39850400004)(136003)(346002)(376002)(51444003)(199004)(189003)(66556008)(66476007)(256004)(52116002)(66946007)(6116002)(64756008)(3846002)(68736007)(86362001)(14454004)(11346002)(36756003)(5660300002)(8936002)(476003)(66066001)(446003)(486006)(6506007)(2906002)(6486002)(81156014)(53546011)(81166006)(7736002)(316002)(8676002)(31696002)(2616005)(76176011)(14444005)(305945005)(6512007)(54906003)(107886003)(99286004)(31686004)(478600001)(71190400001)(186003)(53936002)(66446008)(6246003)(110136005)(102836004)(6436002)(73956011)(4326008)(26005)(229853002)(25786009)(71200400001)(386003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DBBPR08MB4775;
 H:DBBPR08MB4838.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hbMGy8JJa3cEe1lE3VTfvISVsGN/9qYGEfKtmTaSHkAzYYEHhnmGJL8Sk23bCKiiuoERyvV0TOr5irBCn3ns7efU16mCtSeuYxWUuHoxVDUbarsD3k4V8ahDbCt2GbAIPLCsyPIJB8JlupMgdDIZa6jqc5H7lLcUbUin570R8S8eYtxOmZZ9Qjihg0kuEwZItmPNnRWRUtmECWMdiNejlywuSpBMdtOoAIOIdSiq2AwONxIDVQ8zYEzaKsibuDZ6/WcwJJQ7UJ39Dl/1CvqWm3Frftdr+VTVnpYwE4z7TQiUA0DRN9EZ1tDMCdGVHdBoWJ/4pMDB1B4bO6lpzIOCZtABgnF1Yq+jn+Ar11RS+h4L6Vex4dNRt+MHaCaoc+vFsQ2OZu5CxS3DCJ5ODi5w6jiHqTpkJsweYIgcwoH4mJ4=
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <4642D86BE08E1A478C05CB75C9582052@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dac5d1f7-be7f-4e35-e9fa-08d6f3bfebfd
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2019 07:38:14.7820 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4775
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.14.113
Subject: Re: [Qemu-devel] [PATCH 0/3] block: blk_co_pcache
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
Cc: "fam@euphon.net" <fam@euphon.net>, Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

17.06.2019 16:20, Kevin Wolf wrote:
> Am 17.06.2019 um 15:09 hat Eric Blake geschrieben:
>> On 6/17/19 7:09 AM, Kevin Wolf wrote:
>>
>>>>>
>>>>> Hmm, don't you think that blk_co_pcache sends NBD_CMD_CACHE if called=
 on nbd driver?
>>>>> I didn't implement it. But may be I should..
>>>>>
>>>>> May aim was only to avoid extra allocation and unnecessary reads. But=
 if we implement
>>>>> full-featured io request, what should it do?
>>>>>
>>>>> On qcow2 with backing it should pull data from backing to top, like i=
n copy-on-read.
>>>>> And for nbd it will send NBD_CMD_CACHE?
>>>>> These semantics seems different, but why not?
>>>>>
>>>>
>>>> Any opinions here? Should I resend or could we use it as a first step,
>>>> not touching external API but improving things a little bit?
>>>
>>> I'm not opposed to making only a first step now. The interface seems to
>>> make sense to me; the only thing that I don't really like is the naming
>>> both of the operation (blk_co_pcache) and of the flag (BDRV_REQ_CACHE)
>>> because to me, "cache" doesn't mean "read, but ignore the result".
>>>
>>> The operation only results in something being cached if the block graph
>>> is configured to cache things. And indeed, the most importatn use case
>>> for the flag is not populating a cache, but triggering copy-on-read. So
>>> I think calling this operation "cache" is misleading.
>>>
>>> Now, I don't have very good ideas for better names either. I guess
>>> BDRV_REQ_NO_DATA could work, though it's not perfect. (Also, not sure i=
f
>>> a blk_co_preadv_no_read wrapper is even needed when you can just call
>>> blk_co_preadv with the right flag.)
>>>
>>> I'm open for good naming ideas.
>>
>> Would 'prefetch' be a more useful name? The name NBD_CMD_CACHE was
>> chosen in the NBD project, but we are not stuck to that name if we think
>> something better makes more sense.
>=20
> Whether 'prefetch' is entirely accurate really depends on the graph
> configuration, too. But at least it gives me the right idea of "read
> something, but don't return it yet", so yes, I think that would work for
> me.
>=20

Do you mean BDRV_REQ_PREFETCH + blk_co_pprefetch, or only the flag? Hmm, do=
ubled 'p'
in blk_co_pprefetch looks strange, bit it should be here for consistency wi=
th other
requests..


--=20
Best regards,
Vladimir

