Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC3AC43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 17:10:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26CFC20801
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 17:10:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="pBZz4G1E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26CFC20801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icudd-0008Rk-Iy
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 12:10:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40539)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1icuWL-0002Lt-IS
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 12:02:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1icuWI-0004FR-Jp
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 12:02:28 -0500
Received: from mail-eopbgr20098.outbound.protection.outlook.com
 ([40.107.2.98]:28929 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1icuWH-000451-MU
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 12:02:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EWx/s6oZK1L3Bymcagud0FiMMNoE+KXXusVfJJx1s+r8twr+ELLScNQkmZGrrLqe1rFyhHwtJefIDySJsdWLmyXHBNIPygecWh+GNG/zILjOe4r6nUcOxdkIm3bNS47t4Y6DIQJB0IdzntXrg8RlCKASnqMxoCxgIkxxqoFXbZ5oes46ORd/5n90+kp9EE/NsQ9q9nDCJ6DeKkHYIUEEe33iN25qxtjxDy4/OrcuXqXg3c34Y2A95d92TtQSXDRk/uLLvCKb269PQMXkcO+AgYq3/HKGwzPGhrwWWYU1/eDM5xyYgkC+bEF1h5vsOTb0/qAQC7HNBxEspbcGxxD5TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j0+mTzr8pVsS7iWwF4E3ql/L8TM7BqW5m/VmsYxMjE4=;
 b=QFm5cfGPrjXj2jBJj4gGvvFDeRLpPgzabTRmkgfoGYgAsOMcb6CPodoiEFpn+92YV2DdBQQU4QYG6tXNthtzPPS2kwWlBZ6QL0YOGn2Ud3xwXYvSMA/l4zEMknLYEIoiN2hZepI3sIXLKkKABQwYkU340fvkqD7t4raV4Btfjt/rcGKjUbiR0ynDQm6bUWy9i89PXMQHJ7663HvIq/ntO/lIk/yICid61hafm3CmAijLDYOjNeNhVryBTqKPfe52xcwUCAqXUBVkmvp1xTBYl/QBQQGI2PtxprQnx6r5dW4Lq0t4XenRfJ9ZSw0L86AqDW0gdvWgfel+RVrlVyRN7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j0+mTzr8pVsS7iWwF4E3ql/L8TM7BqW5m/VmsYxMjE4=;
 b=pBZz4G1ExQF6llbxn6voZl99C4HWGk3HRlEVwGACCAYH95eqBedouhEbXRfNuk/nIvdm6Rfns64T59jGzKRQzCA7qA38pBKTYw/VsljXQ+zBXOg83yHN/2xPmoJjat3+tIx9SQrwTm6tVZcOK+BpGpMTFx+t1Ki4UTe5n1VjWho=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3637.eurprd08.prod.outlook.com (20.177.113.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.12; Thu, 5 Dec 2019 17:02:18 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2516.014; Thu, 5 Dec 2019
 17:02:18 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v7 06/21] qdev-monitor: well form error hint helpers
Thread-Topic: [PATCH v7 06/21] qdev-monitor: well form error hint helpers
Thread-Index: AQHVq3+KoO+I7IyvrUCELb4r+U+O7Kerw2UAgAABGIA=
Date: Thu, 5 Dec 2019 17:02:18 +0000
Message-ID: <5755caa9-a794-0922-eac4-cb6a8441e694@virtuozzo.com>
References: <20191205152019.8454-1-vsementsov@virtuozzo.com>
 <20191205152019.8454-7-vsementsov@virtuozzo.com>
 <ab98627d-fdd3-1a01-793c-31bf9c445cd6@redhat.com>
In-Reply-To: <ab98627d-fdd3-1a01-793c-31bf9c445cd6@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P191CA0021.EURP191.PROD.OUTLOOK.COM (2603:10a6:3:cf::31)
 To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191205200215463
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7aad499a-6ca7-485b-e351-08d779a4e2a3
x-ms-traffictypediagnostic: AM6PR08MB3637:
x-microsoft-antispam-prvs: <AM6PR08MB3637BA4DBEA7C5DDEE79B6A8C15C0@AM6PR08MB3637.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:293;
x-forefront-prvs: 02426D11FE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39850400004)(376002)(136003)(346002)(396003)(366004)(199004)(189003)(8936002)(36756003)(81166006)(8676002)(14444005)(229853002)(5660300002)(81156014)(31686004)(6486002)(305945005)(4326008)(6512007)(66556008)(110136005)(66946007)(66476007)(2616005)(99286004)(6506007)(25786009)(478600001)(26005)(76176011)(316002)(52116002)(86362001)(186003)(66446008)(31696002)(54906003)(64756008)(71190400001)(71200400001)(14454004)(53546011)(102836004)(2906002)(11346002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3637;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A8Ymp7Jutcx3awnX3Mz4AIImWwvzNgEDw7Rx0OhQCoGSA3/0d7qR3KL8vrxsR/FUZ9UnNVMz1+RWNYuZ0cexv00ie8wrixvsSk8RC6YyUyHzO4/pRA6wo9YiWUU7sLijKsCrSJN60VQKK+h5qkhqRzZQ7ghuZ8937CJzM4KCYBorGNodHX6eBs8uel/V8sMdQstYblTDx/N4Yv389n1jjkXkKyRM8rR1GpYP2GLZsTjZ8cuMy2ueym6T6rOqNcVkY+yRk4O14GWVaU5kmrGOZ+pe+xuAPU0jKuqLnkX36aMnsYKJLTycLXs96uYUg9H+Xm3LVq0oEYVeHLJlrCUbytHY/gM18p+JTWoxHIpek7iNaDlhT8yDtlmZRFI+3RLD5LfM1vsQmSs/azpmxxbgr97PQYZhSJVGtinzf2SnJ4kgq85rU8/sGspB5BoMHGMw
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <15ED2092064BC14AA47919CA4C67E176@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aad499a-6ca7-485b-e351-08d779a4e2a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2019 17:02:18.1512 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rXlqSwGxvRWQcl8qcADyFF9ntIlO3GZz6HNrWRN3A7FQ8EKOYMYiFKax82dMABKCsF7SRXqXhQ2k4xfHgdMrqFyYcy367VQwh/VoScAPfPo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3637
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.2.98
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?Windows-1252?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

05.12.2019 19:58, Eric Blake wrote:
> On 12/5/19 9:20 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Make qbus_list_bus and qbus_list_dev hint append helpers well formed:
>> rename errp to errp_in, as it is IN-parameter here (which is unusual
>> for errp), rename functions to be error_append_*_hint.
>=20
> Commit message mentions a rename...
>=20
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>> =A0 qdev-monitor.c | 12 +++++++-----
>> =A0 1 file changed, 7 insertions(+), 5 deletions(-)
>>
>> diff --git a/qdev-monitor.c b/qdev-monitor.c
>> index 29ed73e56a..3465a1e2d0 100644
>> --- a/qdev-monitor.c
>> +++ b/qdev-monitor.c
>> @@ -328,7 +328,8 @@ static Object *qdev_get_peripheral_anon(void)
>> =A0=A0=A0=A0=A0 return dev;
>> =A0 }
>> -static void qbus_list_bus(DeviceState *dev, Error **errp)
>> +static void qbus_error_append_bus_list_hint(DeviceState *dev,
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Error *const *=
errp)
>=20
> ...but instead you did a type change with the name left unchanged. Commit=
 message needs a fix.
>=20

Oops. I blindly take Markus's fixum, and didn't fix commit messages. I'll r=
esend.

--=20
Best regards,
Vladimir

