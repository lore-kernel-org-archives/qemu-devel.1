Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=BAD_ENC_HEADER,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A75BC43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 12:52:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDA322084E
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 12:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="We92YSP3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDA322084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33826 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heJ1r-0005DK-6O
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 08:52:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41596)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <rkagan@virtuozzo.com>) id 1heIyt-00037Y-0d
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 08:49:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rkagan@virtuozzo.com>) id 1heIyp-0008Cj-O3
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 08:49:26 -0400
Received: from mail-bgr052101131090.outbound.protection.outlook.com
 ([52.101.131.90]:17611 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
 id 1heIyo-00088a-VE
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 08:49:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hjvrZWdIt/3A7Yj4jSZtP4eN+Xj4vhSZvpXTTON3ctU=;
 b=We92YSP3TZ94JoAoScE8FcZKanfeoBKu+tAADSu6m232sH+MCcxJey6A9cjAvJX68FGEOCRa1YTNMDxo1NtpDrJs9Q05Ap7HvkIBj0++v263+F7gDEuq9wwtVZzS7HBqDR438gDkwO3UoV93GzTc23B/QfaAnOhavZTr2WR9O6Y=
Received: from DB8PR08MB3977.eurprd08.prod.outlook.com (20.179.11.95) by
 DB8PR08MB5099.eurprd08.prod.outlook.com (10.255.18.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.13; Fri, 21 Jun 2019 12:49:08 +0000
Received: from DB8PR08MB3977.eurprd08.prod.outlook.com
 ([fe80::3530:3b13:be7f:2944]) by DB8PR08MB3977.eurprd08.prod.outlook.com
 ([fe80::3530:3b13:be7f:2944%4]) with mapi id 15.20.1987.014; Fri, 21 Jun 2019
 12:49:08 +0000
From: Roman Kagan <rkagan@virtuozzo.com>
To: =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
Thread-Topic: [Qemu-devel] [RFC PATCH 0/2] establish nesting rule of BQL vs
 cpu-exclusive
Thread-Index: AQHVEVXwLFxTyUznOk6fV4juQbW3H6Z4k2UAgAZCJQCAD92SAIAXiaEA
Date: Fri, 21 Jun 2019 12:49:07 +0000
Message-ID: <20190621124904.GA24164@rkaganb.sw.ru>
References: <20190523105440.27045-1-rkagan@virtuozzo.com>
 <87imu11k6z.fsf@zen.linaroharston> <20190527110534.GA13549@rkaganb.sw.ru>
 <20190606132230.GB32258@rkaganb.sw.ru>
In-Reply-To: <20190606132230.GB32258@rkaganb.sw.ru>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.11.4 (2019-03-13)
mail-followup-to: =?iso-8859-1?Q?Roman_Kagan_<rkagan@virtuozzo.com>,
 =09Alex_Benn=E9e_<alex.?=
 =?iso-8859-1?Q?bennee@linaro.org>,=09Paolo_Bonzini_<pbonzini@redhat.com>,?=
 =?iso-8859-1?Q?=09"cota@braap.org"_<cota@braap.org>,=09"richard.henderson?=
 =?iso-8859-1?Q?@linaro.org"_<richard.henderson@linaro.org>,=09"qemu-devel?=
 =?iso-8859-1?Q?@nongnu.org"_<qemu-devel@nongnu.org>?=
x-originating-ip: [185.231.240.5]
x-clientproxiedby: HE1PR09CA0079.eurprd09.prod.outlook.com
 (2603:10a6:7:3d::23) To DB8PR08MB3977.eurprd08.prod.outlook.com
 (2603:10a6:10:ad::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a674d47b-1070-4e8b-58a5-08d6f646d983
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5099; 
x-ms-traffictypediagnostic: DB8PR08MB5099:|DB8PR08MB5099:
x-microsoft-antispam-prvs: <DB8PR08MB50996C473821A7316C751ED9C9E70@DB8PR08MB5099.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1148;
x-forefront-prvs: 0075CB064E
x-forefront-antispam-report: SFV:SPM;
 SFS:(10019020)(39850400004)(366004)(346002)(396003)(376002)(136003)(189003)(199004)(8936002)(81166006)(486006)(71190400001)(4326008)(71200400001)(81156014)(14454004)(446003)(68736007)(229853002)(316002)(5660300002)(11346002)(66946007)(66446008)(64756008)(66556008)(66476007)(36756003)(73956011)(33656002)(1076003)(476003)(256004)(14444005)(66574012)(9686003)(186003)(26005)(6512007)(54906003)(7736002)(86362001)(66066001)(58126008)(102836004)(76176011)(6506007)(386003)(6436002)(99286004)(52116002)(478600001)(6246003)(25786009)(2906002)(53936002)(3846002)(8676002)(6486002)(6916009)(305945005)(6116002)(30126002);
 DIR:OUT; SFP:1501; SCL:5; SRVR:DB8PR08MB5099;
 H:DB8PR08MB3977.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: yuDEBcTO8Z5HbQGd9/oJ2aikJXsPkPsE/dtV7cPtzJl/YneAZqUrVmARGNg7p++J7VnYNEl9hN1IoFrUQxo8070KDofO3kTPCM8PZTQoKRuPUGU+eiYmlwP8K5dqVt58V3BSqNR5NLJC8tSdiRMrmlTMkX5wJ3Rkpu3ALcWRQlnzgj7sbM4haCZyryfpFkhWj3nRMctKcjWotJFikDDEfKoLoW/jk1J59ducxRmkRsa7jly49T7aphjSeF7K/huvlXqo7FD9vCd78jVohIAE00neKF8aRFiAwnsrOZn6FIFSulxfTCDkIXxcVxba74HpQDLySYLA0e1WttYv0GEaeEQEIbEa47W9di5UnKMYng3ik+oEpBtuE9vGvfTvDnPKJqxlGfC9vJ26uptn4AqAs3DyrOpfh9C/yykuzkuvPGcvnlh4ls0+mHSHGfkHQLJjE50pcf06oI2gzRjN00H6PxLeJc+His5CK1SLorr3uxA7FrD1USByO6RiPRLPL6wX
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <81071A2CD9F37446B68E8C383A9A6BCD@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a674d47b-1070-4e8b-58a5-08d6f646d983
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2019 12:49:07.9060 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rkagan@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5099
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 52.101.131.90
Subject: Re: [Qemu-devel] [RFC PATCH 0/2] establish nesting rule of BQL vs
 cpu-exclusive
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "cota@braap.org" <cota@braap.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 06, 2019 at 01:22:33PM +0000, Roman Kagan wrote:
> On Mon, May 27, 2019 at 11:05:38AM +0000, Roman Kagan wrote:
> > On Thu, May 23, 2019 at 12:31:16PM +0100, Alex Benn=E9e wrote:
> > >=20
> > > Roman Kagan <rkagan@virtuozzo.com> writes:
> > >=20
> > > > I came across the following AB-BA deadlock:
> > > >
> > > >     vCPU thread                             main thread
> > > >     -----------                             -----------
> > > > async_safe_run_on_cpu(self,
> > > >                       async_synic_update)
> > > > ...                                         [cpu hot-add]
> > > > process_queued_cpu_work()
> > > >   qemu_mutex_unlock_iothread()
> > > >                                             [grab BQL]
> > > >   start_exclusive()                         cpu_list_add()
> > > >   async_synic_update()                        finish_safe_work()
> > > >     qemu_mutex_lock_iothread()                  cpu_exec_start()
> > > >
> > > > ATM async_synic_update seems to be the only async safe work item th=
at
> > > > grabs BQL.  However it isn't quite obvious that it shouldn't; in th=
e
> > > > past there were more examples of this (e.g.
> > > > memory_region_do_invalidate_mmio_ptr).
> > > >
> > > > It looks like the problem is generally in the lack of the nesting r=
ule
> > > > for cpu-exclusive sections against BQL, so I thought I would try to
> > > > address that.  This patchset is my feeble attempt at this; I'm not =
sure
> > > > I fully comprehend all the consequences (rather, I'm sure I don't) =
hence
> > > > RFC.
> > >=20
> > > Hmm I think this is an area touched by:
> > >=20
> > >   Subject: [PATCH v7 00/73] per-CPU locks
> > >   Date: Mon,  4 Mar 2019 13:17:00 -0500
> > >   Message-Id: <20190304181813.8075-1-cota@braap.org>
> > >=20
> > > which has stalled on it's path into the tree. Last time I checked it
> > > explicitly handled the concept of work that needed the BQL and work t=
hat
> > > didn't.
> >=20
> > I'm still trying to get my head around that patchset, but it looks like
> > it changes nothing in regards to cpu-exclusive sections and safe work,
> > so it doesn't make the problem go.
> >=20
> > > How do you trigger your deadlock? Just hot-pluging CPUs?
> >=20
> > Yes.  The window is pretty narrow so I only saw it once although this
> > test (where the vms are started and stopped and the cpus are plugged in
> > and out) is in our test loop for quite a bit (probably 2+ years).
> >=20
> > Roman.
>=20
> ping?

ping?

