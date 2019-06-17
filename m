Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0490CC31E57
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 12:48:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3AC020861
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 12:48:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Tm8UUkyh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3AC020861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47118 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcr3J-0001wR-2U
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 08:48:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45325)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <rkagan@virtuozzo.com>) id 1hcr0l-0000AG-OT
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 08:45:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rkagan@virtuozzo.com>) id 1hcr0j-0002b9-PB
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 08:45:23 -0400
Received: from mail-am5eur03hn0307.outbound.protection.outlook.com
 ([2a01:111:f400:fe08::307]:18398
 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
 id 1hcr0h-0002TN-T3; Mon, 17 Jun 2019 08:45:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L0b53u71ZOzuKuuTsPRXwhfXutQYDWR10ut6yErNiKI=;
 b=Tm8UUkyhS/x7v19P9VA/224gYcR/Lhoy7+xeahQLn60PhCp9Qm7g7srNlTGhCOLSDrkHJDzPDRPayZmvBhzU+22OdeyhBuMwTj5VpYoHk9aUtvNipzcl6j/c9Wks/+RcOrqDWSyOac5w3dXbEIDmqyxBJTylLwMvscMJJZDQ+GA=
Received: from DB8PR08MB3977.eurprd08.prod.outlook.com (20.179.11.95) by
 DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.12; Mon, 17 Jun 2019 12:45:01 +0000
Received: from DB8PR08MB3977.eurprd08.prod.outlook.com
 ([fe80::3530:3b13:be7f:2944]) by DB8PR08MB3977.eurprd08.prod.outlook.com
 ([fe80::3530:3b13:be7f:2944%4]) with mapi id 15.20.1987.014; Mon, 17 Jun 2019
 12:45:01 +0000
From: Roman Kagan <rkagan@virtuozzo.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Thread-Topic: [PATCH v2 6/7] iotests: amend QEMU NBD process synchronization
Thread-Index: AQHVIH/W+4fzIICfOUahb05s1OWCZ6aZXH6AgAZ3cwA=
Date: Mon, 17 Jun 2019 12:45:01 +0000
Message-ID: <20190617124458.GD32624@rkaganb.sw.ru>
References: <1560276131-683243-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1560276131-683243-7-git-send-email-andrey.shinkevich@virtuozzo.com>
 <98074e5c-028f-8cd0-f2ae-5b869ec18f70@virtuozzo.com>
In-Reply-To: <98074e5c-028f-8cd0-f2ae-5b869ec18f70@virtuozzo.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.11.4 (2019-03-13)
mail-followup-to: Roman Kagan <rkagan@virtuozzo.com>,	Vladimir
 Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,	Andrey Shinkevich
 <andrey.shinkevich@virtuozzo.com>,	"qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>,	"qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "kwolf@redhat.com" <kwolf@redhat.com>,	"mreitz@redhat.com"
 <mreitz@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>, Denis Lunev
 <den@virtuozzo.com>
x-originating-ip: [185.231.240.5]
x-clientproxiedby: HE1PR1001CA0016.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:3:f7::26) To DB8PR08MB3977.eurprd08.prod.outlook.com
 (2603:10a6:10:ad::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2e8ea229-8390-4ceb-44cf-08d6f3219d07
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5498; 
x-ms-traffictypediagnostic: DB8PR08MB5498:|DB8PR08MB5498:
x-microsoft-antispam-prvs: <DB8PR08MB54987EFB51F3DB98561CF21AC9EB0@DB8PR08MB5498.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0071BFA85B
x-forefront-antispam-report: SFV:SPM;
 SFS:(10019020)(979002)(396003)(376002)(366004)(39840400004)(136003)(346002)(189003)(199004)(76176011)(446003)(4326008)(54906003)(476003)(52116002)(8676002)(6486002)(81166006)(81156014)(6436002)(316002)(36756003)(11346002)(25786009)(102836004)(6636002)(486006)(14444005)(7736002)(6506007)(386003)(3846002)(71190400001)(8936002)(2906002)(66946007)(66446008)(64756008)(73956011)(66476007)(99286004)(6246003)(6862004)(68736007)(53936002)(6116002)(229853002)(14454004)(86362001)(71200400001)(107886003)(58126008)(186003)(26005)(5660300002)(478600001)(33656002)(66556008)(256004)(305945005)(1076003)(6512007)(66066001)(9686003)(30126002)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1501; SCL:5; SRVR:DB8PR08MB5498;
 H:DB8PR08MB3977.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9fLK34jGGdQb+QLZ8pL0yEw7pyjJkZzyqHiZ/FOd88jP4OW3bOya4AWY3lnel/K6UuK1iGlJm/28WwBMCie3usP5CasSoNrv+wC49iKQF6+Zm2EInPcm5jI9MTinyosJc6NkH+PyhygyOlBIzH2JPTir5n3EKLFAW7jUgC2zwycQUVVWVaNg68KJKmWNs92bs5J47/B7Xp3LKi7uurb52EkLi0EPHVe/+0GsF6X5gaRxP9x3pyx2lHaPiEzBCIt4XTOwukmOvFb68svkXbMgl5XVen8L5YV5rwpOjA7jyolGutjNsJKmrgFF0wxVVbMVah7Y0cwSydr91y7/jp+XaFk1oHSP6WZMm/laeavfaDEloK0f/KUXobcbmPB7dFv2x42knBsIeyuWoMKm93ZnGPP8f/FXKT5qFtxgRaFR6bperXNfnDFdHucKf41qypCDGAFwOHdTWZjuUe/KiOLGFLPdXHwOdOhteOlH/nh2ASRTIrNKEtcbrKXTQq60Kj4c
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6B0809F76B45B6429A4809B4DFDB1F8E@eurprd08.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e8ea229-8390-4ceb-44cf-08d6f3219d07
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2019 12:45:01.5312 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rkagan@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5498
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe08::307
Subject: Re: [Qemu-devel] [PATCH v2 6/7] iotests: amend QEMU NBD process
 synchronization
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 13, 2019 at 12:59:53PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> 11.06.2019 21:02, Andrey Shinkevich wrote:
> > Processes are dying harder under the Valgring. It results in counting
> > the dying process as a newborn one. Make it sure that old NBD job get
> > finished before starting a new one.
> > 
> > Suggested-by: Roman Kagan <rkagan@virtuozzo.com>
> > Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> > ---
> >   tests/qemu-iotests/common.nbd | 6 ++++++
> >   1 file changed, 6 insertions(+)
> > 
> > diff --git a/tests/qemu-iotests/common.nbd b/tests/qemu-iotests/common.nbd
> > index 25fc9ff..e3dcc60 100644
> > --- a/tests/qemu-iotests/common.nbd
> > +++ b/tests/qemu-iotests/common.nbd
> > @@ -22,6 +22,7 @@
> >   nbd_unix_socket="${TEST_DIR}/qemu-nbd.sock"
> >   nbd_tcp_addr="127.0.0.1"
> >   nbd_pid_file="${TEST_DIR}/qemu-nbd.pid"
> > +nbd_job_pid=""
> >   
> >   nbd_server_stop()
> >   {
> > @@ -33,6 +34,9 @@ nbd_server_stop()
> >               kill "$NBD_PID"
> >           fi
> >       fi
> 
> Honestly, I don't understand the problem from commit message, but anyway comment
> should be added here, to mark that this is for valgrind... But you don't check for
> VALGRIND enabled.. I it intentional?

It is.  The problem this patch fixes exists regardless of valgrind.
valgrind just makes it easier to notice.  See my reply to the patch
itself.

Roman.

> 
> > +    if [ -n "$nbd_job_pid" ] && kill -s 0 "$nbd_job_pid" 2>/dev/null; then
> > +        wait "$nbd_job_pid"
> > +    fi
> >       rm -f "$nbd_unix_socket"
> >   }
> >   
> > @@ -61,6 +65,7 @@ nbd_server_start_unix_socket()
> >   {
> >       nbd_server_stop
> >       $QEMU_NBD -v -t -k "$nbd_unix_socket" "$@" &
> > +    nbd_job_pid=$!
> >       nbd_server_wait_for_unix_socket $!
> >   }
> >   
> > @@ -105,5 +110,6 @@ nbd_server_start_tcp_socket()
> >   {
> >       nbd_server_stop
> >       $QEMU_NBD -v -t -b $nbd_tcp_addr -p $nbd_tcp_port "$@" &
> > +    nbd_job_pid=$!
> >       nbd_server_wait_for_tcp_socket $!
> >   }
> > 
> 
> 
> -- 
> Best regards,
> Vladimir

