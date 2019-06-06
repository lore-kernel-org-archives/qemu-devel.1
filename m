Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAD_ENC_HEADER,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF7BEC04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 13:24:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CBF620866
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 13:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ZDyNHfyk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CBF620866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60525 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYsN5-0001tl-RK
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 09:23:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1hYsMC-0001ZB-29
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 09:23:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1hYsM4-00072v-Q0
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 09:22:58 -0400
Received: from mail-bgr052101136026.outbound.protection.outlook.com
	([52.101.136.26]:26190
	helo=EUR03-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1hYsLx-0005nh-D1
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 09:22:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=jfGuJDd/HueXaYUXprZYYuk14Yvfmf9xkotwsObYr9A=;
	b=ZDyNHfyknHGn67RD/AWH+9WaezVd+zaWO963yCS408pHmqwtwRB78r1Ex3ekxn/7iQ5H7kROTBqIByKq7gxzCu0MtFJfSlytuIZ1S11StZEtYMeJKPyBzjOeMUUo4sRl23Ivm9f0N5FtTN02oZ51uJVTYmvLRzTZYTtrVE1dyKA=
Received: from AM4PR08MB2676.eurprd08.prod.outlook.com (10.171.190.153) by
	AM4PR08MB2643.eurprd08.prod.outlook.com (10.171.187.12) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1965.12; Thu, 6 Jun 2019 13:22:33 +0000
Received: from AM4PR08MB2676.eurprd08.prod.outlook.com
	([fe80::6169:9a70:7143:1c1f]) by
	AM4PR08MB2676.eurprd08.prod.outlook.com
	([fe80::6169:9a70:7143:1c1f%3]) with mapi id 15.20.1965.011;
	Thu, 6 Jun 2019 13:22:33 +0000
From: Roman Kagan <rkagan@virtuozzo.com>
To: =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
Thread-Topic: [Qemu-devel] [RFC PATCH 0/2] establish nesting rule of BQL vs
	cpu-exclusive
Thread-Index: AQHVEVXwLFxTyUznOk6fV4juQbW3H6Z4k2UAgAZCJQCAD92SAA==
Date: Thu, 6 Jun 2019 13:22:33 +0000
Message-ID: <20190606132230.GB32258@rkaganb.sw.ru>
References: <20190523105440.27045-1-rkagan@virtuozzo.com>
	<87imu11k6z.fsf@zen.linaroharston>
	<20190527110534.GA13549@rkaganb.sw.ru>
In-Reply-To: <20190527110534.GA13549@rkaganb.sw.ru>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.11.4 (2019-03-13)
mail-followup-to: =?iso-8859-1?Q?Roman_Kagan_<rkagan@virtuozzo.com>,
	=09Alex_Benn=E9e_<alex.?= =?iso-8859-1?Q?bennee@linaro.org>,
	=09Paolo_Bonzini_<pbonzini@redhat.com>, ?=
	=?iso-8859-1?Q?=09"cota@braap.org"_<cota@braap.org>,
	=09"richard.henderson?=
	=?iso-8859-1?Q?@linaro.org"_<richard.henderson@linaro.org>,
	=09"qemu-devel?=
	=?iso-8859-1?Q?@nongnu.org"_<qemu-devel@nongnu.org>?=
x-originating-ip: [185.231.240.5]
x-clientproxiedby: HE1PR07CA0045.eurprd07.prod.outlook.com
	(2603:10a6:7:66::31) To AM4PR08MB2676.eurprd08.prod.outlook.com
	(2603:10a6:205:c::25)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=rkagan@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0ba1646f-7d59-407a-31dc-08d6ea820893
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
	SRVR:AM4PR08MB2643; 
x-ms-traffictypediagnostic: AM4PR08MB2643:|AM4PR08MB2643:
x-microsoft-antispam-prvs: <AM4PR08MB2643096C25FA00A882D991D6C9170@AM4PR08MB2643.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1148;
x-forefront-prvs: 00603B7EEF
x-forefront-antispam-report: SFV:SPM;
	SFS:(10019020)(346002)(396003)(136003)(366004)(376002)(39840400004)(189003)(199004)(1076003)(53936002)(66574012)(316002)(14454004)(6512007)(2906002)(36756003)(8936002)(4326008)(9686003)(14444005)(81156014)(81166006)(6436002)(71190400001)(71200400001)(25786009)(256004)(6246003)(58126008)(478600001)(8676002)(446003)(186003)(33656002)(66066001)(305945005)(6116002)(7736002)(486006)(11346002)(6506007)(6916009)(26005)(66556008)(66476007)(73956011)(66946007)(66446008)(64756008)(386003)(476003)(102836004)(6486002)(76176011)(229853002)(52116002)(99286004)(68736007)(5660300002)(54906003)(86362001)(3846002)(30126002);
	DIR:OUT; SFP:1501; SCL:5; SRVR:AM4PR08MB2643;
	H:AM4PR08MB2676.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cGjIBY49BbqxfVJu0hQ8GRmwtU7Ile1a8Ogcx6/y/ryaNIOVkDA7mPmd1iVPCk+K+NjcaVRkdJRpim2nDqIDl3BEG16AUjs6gMLh0oHY8CvcrxLsWSqu6gnk1AKVauMzIcRaN7TwYmB4iY7hCID5J/7ds15RMYmGzuO4yO0x5WEAvHGPUBeTRZaAR/g/uqY4zORUYo040DGFBx8YDKHSaOya4T2+xIyEwtJyi8VC4RTeyxLZGXev4NDjA9pnZU/2izmF5OJtyXHKEau93TFFELEuMkighcP3GQav648hjTTYwzA77aLAi7z3v+QF6pxzuaPEkzYAbqDurIKUp+eAbn9E1E4e9BAtkim5GYi9A0nPkfpzPzfjQlQyTX+9BmBK0vdMIqDYXbZ3SwzD7NgATF1S6tTdrYKccbosu3ZRh92PPrx55tnaXaypsvSBriRyRu0ppfA8O1yyrHV/8wlO7AiptXt1eeYGuRZZHAc82XmC7Qyyc4qhc401Cdl9ea5E
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <D88E727C21DEC14EA3B2CA1962396837@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ba1646f-7d59-407a-31dc-08d6ea820893
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2019 13:22:33.2634 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rkagan@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR08MB2643
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 52.101.136.26
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

On Mon, May 27, 2019 at 11:05:38AM +0000, Roman Kagan wrote:
> On Thu, May 23, 2019 at 12:31:16PM +0100, Alex Benn=E9e wrote:
> >=20
> > Roman Kagan <rkagan@virtuozzo.com> writes:
> >=20
> > > I came across the following AB-BA deadlock:
> > >
> > >     vCPU thread                             main thread
> > >     -----------                             -----------
> > > async_safe_run_on_cpu(self,
> > >                       async_synic_update)
> > > ...                                         [cpu hot-add]
> > > process_queued_cpu_work()
> > >   qemu_mutex_unlock_iothread()
> > >                                             [grab BQL]
> > >   start_exclusive()                         cpu_list_add()
> > >   async_synic_update()                        finish_safe_work()
> > >     qemu_mutex_lock_iothread()                  cpu_exec_start()
> > >
> > > ATM async_synic_update seems to be the only async safe work item that
> > > grabs BQL.  However it isn't quite obvious that it shouldn't; in the
> > > past there were more examples of this (e.g.
> > > memory_region_do_invalidate_mmio_ptr).
> > >
> > > It looks like the problem is generally in the lack of the nesting rul=
e
> > > for cpu-exclusive sections against BQL, so I thought I would try to
> > > address that.  This patchset is my feeble attempt at this; I'm not su=
re
> > > I fully comprehend all the consequences (rather, I'm sure I don't) he=
nce
> > > RFC.
> >=20
> > Hmm I think this is an area touched by:
> >=20
> >   Subject: [PATCH v7 00/73] per-CPU locks
> >   Date: Mon,  4 Mar 2019 13:17:00 -0500
> >   Message-Id: <20190304181813.8075-1-cota@braap.org>
> >=20
> > which has stalled on it's path into the tree. Last time I checked it
> > explicitly handled the concept of work that needed the BQL and work tha=
t
> > didn't.
>=20
> I'm still trying to get my head around that patchset, but it looks like
> it changes nothing in regards to cpu-exclusive sections and safe work,
> so it doesn't make the problem go.
>=20
> > How do you trigger your deadlock? Just hot-pluging CPUs?
>=20
> Yes.  The window is pretty narrow so I only saw it once although this
> test (where the vms are started and stopped and the cpus are plugged in
> and out) is in our test loop for quite a bit (probably 2+ years).
>=20
> Roman.

ping?

