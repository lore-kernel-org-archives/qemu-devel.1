Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B288DC468BD
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 12:08:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81437212F5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 12:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="BEYoncOn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81437212F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49190 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZDfo-0003Ww-NG
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 08:08:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38140)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hZDa1-0000Ok-Cv
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 08:02:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hZDa0-0001bb-9d
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 08:02:45 -0400
Received: from mail-eopbgr20137.outbound.protection.outlook.com
 ([40.107.2.137]:59011 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hZDZw-0001SC-ON; Fri, 07 Jun 2019 08:02:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8OZN6jg00cw3x9qVJgY5CRsbGVEL0GGRi4pqmFttXd0=;
 b=BEYoncOn88lS3vLRS5xrQviZxEZtkPfISuyYLGuegHg6Wd9viLcmBQJ4b4ZHK4T8m9N6CeLI6DGHcYD/sBe23WAN4FnDjLibPxTtAeHlWMJjsZ9WJxHMRc/yTZlYNMUtEUwovD7Q8/qX13kZIZlFtTJTjytIV00EmGYMP68hFLo=
Received: from AM0PR08MB2961.eurprd08.prod.outlook.com (52.134.126.11) by
 AM0PR08MB3666.eurprd08.prod.outlook.com (20.177.43.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.12; Fri, 7 Jun 2019 12:02:37 +0000
Received: from AM0PR08MB2961.eurprd08.prod.outlook.com
 ([fe80::8d90:32ae:bdd6:48e8]) by AM0PR08MB2961.eurprd08.prod.outlook.com
 ([fe80::8d90:32ae:bdd6:48e8%7]) with mapi id 15.20.1965.011; Fri, 7 Jun 2019
 12:02:37 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>
Thread-Topic: [PATCH v6 6/7] block/nbd-client: nbd reconnect
Thread-Index: AQHU8IvOU96perqu+EiRV82H4T/8KaaP3geAgABQuoCAAEHwgA==
Date: Fri, 7 Jun 2019 12:02:37 +0000
Message-ID: <c1414cfd-99cd-ea31-ab22-f7d76974e6b3@virtuozzo.com>
References: <20190411172709.205032-1-vsementsov@virtuozzo.com>
 <20190411172709.205032-7-vsementsov@virtuozzo.com>
 <0b64cff5-33fa-0945-504c-b1bdd004c42a@redhat.com>
 <20190607080635.GB5055@dhcp-200-226.str.redhat.com>
In-Reply-To: <20190607080635.GB5055@dhcp-200-226.str.redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0402CA0035.eurprd04.prod.outlook.com
 (2603:10a6:7:7c::24) To AM0PR08MB2961.eurprd08.prod.outlook.com
 (2603:10a6:208:66::11)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190607150235336
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 241cf9df-b136-4305-09da-08d6eb4008a3
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:AM0PR08MB3666; 
x-ms-traffictypediagnostic: AM0PR08MB3666:
x-microsoft-antispam-prvs: <AM0PR08MB3666F2432F61A1DFE33CF349C1100@AM0PR08MB3666.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:305;
x-forefront-prvs: 0061C35778
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(366004)(396003)(346002)(376002)(39850400004)(199004)(189003)(52314003)(8676002)(6512007)(81166006)(4326008)(81156014)(53936002)(25786009)(36756003)(5660300002)(11346002)(8936002)(446003)(76176011)(6436002)(229853002)(31686004)(14454004)(102836004)(186003)(6246003)(6486002)(26005)(107886003)(256004)(86362001)(14444005)(305945005)(7736002)(6506007)(66066001)(386003)(53546011)(64756008)(66556008)(66946007)(31696002)(73956011)(66476007)(66446008)(2906002)(68736007)(3846002)(6116002)(316002)(486006)(110136005)(54906003)(478600001)(476003)(71200400001)(2616005)(71190400001)(52116002)(99286004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3666;
 H:AM0PR08MB2961.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: A+cP0+mZ/h+EU8mQra/kf2LppGbR1gF63BHvzDRlSFIHADzwIOZAX4s0unuLrQZL87vqSRdyDARsOc72Nre1S0XejL4+hoX6e5kXmFEPez2uTTs8nfvDwnWU2nQJS77AXcK7TUljw8KvlHny5Hd2+hdPd1MUZXJkclLK0YZarr+4to/Ugz4F3+8JxPMOu7XrHp9bLznDYViwlijFD82GUjUc299wxhsanYETfJzUEDFTdDOIa1fcXoLYZNdHagSoX6Yu4uzo78nnqZrmTz8Fyk16s36onXp711dDI4HIv5qFc7Jb/AOdtBWih2jfwYNDSDeOKNdniL2dE/vi7BVjfTMzlVsbYBoTE14h4EAyDJfUnjWtRV2Jpk+n15Fv+c5WXDniIIv8kJpuDz9UCJV+2VJnlBluXgxjYSfOsf1GzaI=
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <05EB099C487A4A498A471BA111331593@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 241cf9df-b136-4305-09da-08d6eb4008a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2019 12:02:37.7459 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3666
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.2.137
Subject: Re: [Qemu-devel] [PATCH v6 6/7] block/nbd-client: nbd reconnect
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
Cc: Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

07.06.2019 11:06, Kevin Wolf wrote:
> Am 07.06.2019 um 05:17 hat Eric Blake geschrieben:
>> On 4/11/19 12:27 PM, Vladimir Sementsov-Ogievskiy wrote:
>>> +static coroutine_fn void nbd_reconnect_loop(NBDConnection *con)
>>> +{
>>> +    NBDClientSession *s =3D nbd_get_client_session(con->bs);
>>> +    uint64_t start_time_ns =3D qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
>>> +    uint64_t delay_ns =3D s->reconnect_delay * 1000000000UL;
>>
>> Do we have a #define constant for nanoseconds in a second to make this
>> more legible than counting '0's?
>>
>>> +    uint64_t timeout =3D 1000000000UL; /* 1 sec */
>>> +    uint64_t max_timeout =3D 16000000000UL; /* 16 sec */
>>
>> 1 * constant, 16 * constant
>>
>>> +
>>> +    nbd_reconnect_attempt(con);
>>> +
>>> +    while (nbd_client_connecting(s)) {
>>> +        if (s->state =3D=3D NBD_CLIENT_CONNECTING_WAIT &&
>>> +            qemu_clock_get_ns(QEMU_CLOCK_REALTIME) - start_time_ns > d=
elay_ns)
>>> +        {
>>> +            s->state =3D NBD_CLIENT_CONNECTING_NOWAIT;
>>> +            qemu_co_queue_restart_all(&s->free_sema);
>>> +        }
>>> +
>>> +        bdrv_dec_in_flight(con->bs);
>>> +        qemu_co_sleep_ns(QEMU_CLOCK_REALTIME, timeout);
>>
>> Another place where I'd like someone more familiar with coroutines to
>> also have a look.
>=20
> What's the exact question you'd like me to answer?
>=20
> But anyway, bdrv_dec/inc_in_flight() around the sleep looks wrong to me.
> Either the operation must be waited for in drain, then you can't
> decrease the counter even during the sleep. Or drain doesn't have to
> consider it, then why is the counter even increased in the first place?
>=20
> The way it currently is, drain can return assuming that there are no
> requests, but after the timeout the request automatically comes back
> while the drain caller assumes that there is no more activity. This
> doesn't look right.
>=20

Hmm.

This ind/dec around all lifetime of connection coroutine you added in

commit 5ad81b4946baf948c65cf7e1436d9b74803c1280
Author: Kevin Wolf <kwolf@redhat.com>
Date:   Fri Feb 15 16:53:51 2019 +0100

     nbd: Restrict connection_co reentrance


And now I try to connect in endless loop, with qemu_co_sleep_ns() inside.
I need to get a change to bdrv_drain to complete, so I have to sometimes
drop this in_flight request. But I understand your point.

Will the following work better?

bdrv_dec_in_flight(con->bs);
qemu_co_sleep_ns(...);
while (s->drained) {
   s->wait_drained_end =3D true;
   qemu_coroutine_yield();
}
bdrv_inc_in_flight(con->bs);

...
.drained_begin() {
    s->drained =3D true;
}

.drained_end() {
    if (s->wait_drained_end) {
       s->wait_drained_end =3D false;
       aio_co_wake(s->connection_co);
    }
}




--=20
Best regards,
Vladimir

