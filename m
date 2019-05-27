Return-Path: <SRS0=zt/K=T3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAD_ENC_HEADER,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D96F7C04AB3
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 11:06:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D1A920815
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 11:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="NA5VB3vM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D1A920815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43662 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVDSq-0004rd-Kq
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 07:06:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1hVDRw-0004Tg-Jz
	for qemu-devel@nongnu.org; Mon, 27 May 2019 07:05:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1hVDRv-00079S-Kn
	for qemu-devel@nongnu.org; Mon, 27 May 2019 07:05:52 -0400
Received: from mail-bgr052101133046.outbound.protection.outlook.com
	([52.101.133.46]:11981
	helo=EUR02-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1hVDRu-00077x-Ve
	for qemu-devel@nongnu.org; Mon, 27 May 2019 07:05:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=Y56Qa/M9d5nsgoKvrmcams33cVcsN3kMGdebeSZviVs=;
	b=NA5VB3vMNJdsR8IhtCwuNmQUs00CQUoFXoFRbZVbyVTdll/sl6j28aZj6yHNon5ucSdRxO5nqJKMIDr4GxUg+IaiFNZAaGwirkYyjdm25onTSmFvhVRj5aCa0eqZlKElOVnl7C1XFiu1ZL+rCdhkAKtT+5wOdaHTnSc/U5+roog=
Received: from DBBPR08MB4854.eurprd08.prod.outlook.com (20.179.46.205) by
	DBBPR08MB4647.eurprd08.prod.outlook.com (10.255.78.78) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1922.20; Mon, 27 May 2019 11:05:38 +0000
Received: from DBBPR08MB4854.eurprd08.prod.outlook.com
	([fe80::4d46:2c95:d6e:ab3f]) by DBBPR08MB4854.eurprd08.prod.outlook.com
	([fe80::4d46:2c95:d6e:ab3f%7]) with mapi id 15.20.1922.021;
	Mon, 27 May 2019 11:05:38 +0000
From: Roman Kagan <rkagan@virtuozzo.com>
To: =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
Thread-Topic: [Qemu-devel] [RFC PATCH 0/2] establish nesting rule of BQL vs
	cpu-exclusive
Thread-Index: AQHVEVXwLFxTyUznOk6fV4juQbW3H6Z4k2UAgAZCJQA=
Date: Mon, 27 May 2019 11:05:38 +0000
Message-ID: <20190527110534.GA13549@rkaganb.sw.ru>
References: <20190523105440.27045-1-rkagan@virtuozzo.com>
	<87imu11k6z.fsf@zen.linaroharston>
In-Reply-To: <87imu11k6z.fsf@zen.linaroharston>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.11.4 (2019-03-13)
mail-followup-to: =?iso-8859-1?Q?Roman_Kagan_<rkagan@virtuozzo.com>,
	=09Alex_Benn=E9e_<alex.?=
	=?iso-8859-1?Q?bennee@linaro.org>, =09qemu-devel@nongnu.org,
	_Paolo_Bonzini?=
	=?iso-8859-1?Q?_<pbonzini@redhat.com>, =09cota@braap.org,
	_richard.henderso?= =?iso-8859-1?Q?n@linaro.org?=
x-originating-ip: [185.231.240.5]
x-clientproxiedby: HE1P190CA0008.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::18)
	To DBBPR08MB4854.eurprd08.prod.outlook.com
	(2603:10a6:10:da::13)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=rkagan@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7894df38-61da-47fe-3af7-08d6e2933fcd
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
	SRVR:DBBPR08MB4647; 
x-ms-traffictypediagnostic: DBBPR08MB4647:|DBBPR08MB4647:
x-microsoft-antispam-prvs: <DBBPR08MB4647BF7F01BECB2164F1D6A4C91D0@DBBPR08MB4647.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 0050CEFE70
x-forefront-antispam-report: SFV:SPM;
	SFS:(10019020)(39850400004)(346002)(376002)(136003)(366004)(396003)(189003)(199004)(486006)(9686003)(6512007)(4326008)(5660300002)(81156014)(81166006)(71190400001)(6506007)(6436002)(53936002)(11346002)(229853002)(58126008)(186003)(8676002)(6486002)(6246003)(25786009)(8936002)(6116002)(446003)(476003)(478600001)(3846002)(26005)(68736007)(33656002)(66574012)(1076003)(99286004)(316002)(36756003)(71200400001)(73956011)(66946007)(66476007)(66556008)(64756008)(66446008)(102836004)(76176011)(52116002)(386003)(305945005)(7736002)(66066001)(86362001)(14444005)(14454004)(256004)(54906003)(6916009)(2906002)(30126002);
	DIR:OUT; SFP:1501; SCL:5; SRVR:DBBPR08MB4647;
	H:DBBPR08MB4854.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YvnkrpJ0LvMBa99IC9fySbMd0/OtYWxgEazhx89Y9InT0hTDcSfp0m13ZfpEEjW5JpDr9PfFjAjhmY7Hgfsmc6UOS96bF28n+86nyHt/+RBXI1muOcG41DciLGgHhKSV/2VJscDHD1bPzU17y8h8eoMDKYOS7o9Unf6nSYybxExN+JbN6CS3ap+bdX5klV+NRADEtqq7aMFPt9xDLmE7UK55CIiwW+o/0/QH5wOLhsLmJS8eRou2nYtHEAZqubXcki4PRSklMYCJLqzqhOpREqUKizloX8nyiKS28/JgkFD5HpMQore6wiK5f//QKgF4UM1Eo+iEzy5cXeYLJP5mMqdP03PKnZTcEe03mi8UyN2NNgqsgsm22kMEegar+m8kHXBeAw3dQkEDXpDb1zbQQGzwhx6oBfyKAzv1fzcMQD6scXJupUHzVWtrY2aentu60ykxTqxjTH2Fy6IHRlDRWYwNS547rrtFP5hP5Lap54Z7rlrQzjcVyD33fJgoKbUN
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <69242F5F07726D4AAC269386C5463ADB@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7894df38-61da-47fe-3af7-08d6e2933fcd
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2019 11:05:38.4254 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rkagan@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4647
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 52.101.133.46
Subject: Re: [Qemu-devel] [RFC PATCH 0/2] establish nesting rule of BQL vs
 cpu-exclusive
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "cota@braap.org" <cota@braap.org>,
	"richard.henderson@linaro.org" <richard.henderson@linaro.org>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 23, 2019 at 12:31:16PM +0100, Alex Benn=E9e wrote:
>=20
> Roman Kagan <rkagan@virtuozzo.com> writes:
>=20
> > I came across the following AB-BA deadlock:
> >
> >     vCPU thread                             main thread
> >     -----------                             -----------
> > async_safe_run_on_cpu(self,
> >                       async_synic_update)
> > ...                                         [cpu hot-add]
> > process_queued_cpu_work()
> >   qemu_mutex_unlock_iothread()
> >                                             [grab BQL]
> >   start_exclusive()                         cpu_list_add()
> >   async_synic_update()                        finish_safe_work()
> >     qemu_mutex_lock_iothread()                  cpu_exec_start()
> >
> > ATM async_synic_update seems to be the only async safe work item that
> > grabs BQL.  However it isn't quite obvious that it shouldn't; in the
> > past there were more examples of this (e.g.
> > memory_region_do_invalidate_mmio_ptr).
> >
> > It looks like the problem is generally in the lack of the nesting rule
> > for cpu-exclusive sections against BQL, so I thought I would try to
> > address that.  This patchset is my feeble attempt at this; I'm not sure
> > I fully comprehend all the consequences (rather, I'm sure I don't) henc=
e
> > RFC.
>=20
> Hmm I think this is an area touched by:
>=20
>   Subject: [PATCH v7 00/73] per-CPU locks
>   Date: Mon,  4 Mar 2019 13:17:00 -0500
>   Message-Id: <20190304181813.8075-1-cota@braap.org>
>=20
> which has stalled on it's path into the tree. Last time I checked it
> explicitly handled the concept of work that needed the BQL and work that
> didn't.

I'm still trying to get my head around that patchset, but it looks like
it changes nothing in regards to cpu-exclusive sections and safe work,
so it doesn't make the problem go.

> How do you trigger your deadlock? Just hot-pluging CPUs?

Yes.  The window is pretty narrow so I only saw it once although this
test (where the vms are started and stopped and the cpus are plugged in
and out) is in our test loop for quite a bit (probably 2+ years).

Roman.

