Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65190C31E51
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 11:09:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 325532085A
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 11:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="KiSVA5uz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 325532085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55606 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdBzs-0005X5-H1
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 07:09:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41144)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <rkagan@virtuozzo.com>) id 1hdBys-00055K-09
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 07:08:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rkagan@virtuozzo.com>) id 1hdByq-0001Pn-C8
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 07:08:49 -0400
Received: from mail-db3eur04hn2084.outbound.protection.outlook.com
 ([52.101.138.84]:62785 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
 id 1hdByq-00017r-6Q
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 07:08:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IBJdNgECq3w2A5/o0nVe6wf00ynAbk+sDjYaLoSv5EY=;
 b=KiSVA5uzr4Jk1Hn6j4EwyRYh1hmrsXnGtQ75BZAORBYjOorqNrKfpudsqH9rRwiXQ/CEUD5mE7ko5Jp+NaT2EJoDfVebXHSG5zLwKfCrdURt81mQF47MXTVJD+wn+iM21OlT3kKiGc9LWMJVbARwkzIK5eDk+RfoYqGrN+pF44g=
Received: from DB8PR08MB3977.eurprd08.prod.outlook.com (20.179.11.95) by
 DB8PR08MB5146.eurprd08.prod.outlook.com (10.255.17.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Tue, 18 Jun 2019 11:08:26 +0000
Received: from DB8PR08MB3977.eurprd08.prod.outlook.com
 ([fe80::3530:3b13:be7f:2944]) by DB8PR08MB3977.eurprd08.prod.outlook.com
 ([fe80::3530:3b13:be7f:2944%4]) with mapi id 15.20.1987.014; Tue, 18 Jun 2019
 11:08:26 +0000
From: Roman Kagan <rkagan@virtuozzo.com>
To: Vadim Rozenfeld <vrozenfe@redhat.com>
Thread-Topic: [Qemu-devel] [PATCH] i386: Fix signedness of
 hyperv_spinlock_attempts
Thread-Index: AQHVI7WqVFjrvk1Rm0af2n9zJo17vaaf32UAgAAJhYCAADTZAIAABMmAgAB/UICAAJmvgIAACVIA
Date: Tue, 18 Jun 2019 11:08:26 +0000
Message-ID: <20190618110822.GA14505@rkaganb.sw.ru>
References: <20190615200505.31348-1-ehabkost@redhat.com>
 <20190617134856.GF32624@rkaganb.sw.ru> <20190617142301.GA19178@habkost.net>
 <20190617173210.GG32624@rkaganb.sw.ru> <20190617174917.GE19178@habkost.net>
 <1560821097.5084.179.camel@redhat.com> <20190618103501.GH32624@rkaganb.sw.ru>
In-Reply-To: <20190618103501.GH32624@rkaganb.sw.ru>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.11.4 (2019-03-13)
mail-followup-to: Roman Kagan <rkagan@virtuozzo.com>,	Vadim Rozenfeld
 <vrozenfe@redhat.com>,	Paolo Bonzini <pbonzini@redhat.com>,	Vitaly Kuznetsov
 <vkuznets@redhat.com>,	Richard Henderson <rth@twiddle.net>,	Eduardo Habkost
 <ehabkost@redhat.com>,	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
x-originating-ip: [185.231.240.5]
x-clientproxiedby: HE1PR07CA0004.eurprd07.prod.outlook.com
 (2603:10a6:7:67::14) To DB8PR08MB3977.eurprd08.prod.outlook.com
 (2603:10a6:10:ad::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 09ee0899-82fa-41a6-d3f3-08d6f3dd4928
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5146; 
x-ms-traffictypediagnostic: DB8PR08MB5146:|DB8PR08MB5146:
x-microsoft-antispam-prvs: <DB8PR08MB5146D60314CE494D5CC72DD3C9EA0@DB8PR08MB5146.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 007271867D
x-forefront-antispam-report: SFV:SPM;
 SFS:(10019020)(396003)(136003)(366004)(376002)(39850400004)(346002)(189003)(199004)(66556008)(6486002)(68736007)(25786009)(33656002)(6436002)(86362001)(76176011)(305945005)(3846002)(7736002)(54906003)(4326008)(26005)(6246003)(486006)(52116002)(11346002)(6916009)(386003)(99286004)(1076003)(58126008)(256004)(14444005)(102836004)(6506007)(53936002)(9686003)(66446008)(5660300002)(6512007)(8676002)(81166006)(81156014)(66066001)(316002)(446003)(14454004)(6116002)(186003)(66946007)(478600001)(71200400001)(229853002)(73956011)(476003)(36756003)(71190400001)(2906002)(66476007)(8936002)(64756008)(30126002);
 DIR:OUT; SFP:1501; SCL:5; SRVR:DB8PR08MB5146;
 H:DB8PR08MB3977.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /caE1H5QHZ+NV6WMhmDKEGMlhKnYOfnJBzdUFJaO+/M8Si39bV/6sjohcm3eYLSglHZNDnHYDe4mr5T+M1gPpGpmiEbRIzH84ThrD9I9P0qCdT+g1a2JlgTSzpwEajsY4HFgJeFxMMj5oNyWTVMBPDUvzeSj3fB2qh5d3LANNzmCUMSAHuwiofRqVzrVWIyAhUPiITKrUR7JGHotgsmdgw0H2cSiFPrCaXsj4sljzno/z7XQjx+902LkBNWZgtnnxuMrCOCu4/6iCy3IOMeK3wJ58xkclU/+eUd2O12zxnx8C9x5gVKtkseNgFgnuFoSTHwHOU1Zf6eUJU6a0341AdcNzdZKwcLIAAn+ReYesP/OpXLhmmo1NMjTp/N1c8VCUezk0//K9k1sKPhLXFOwNUNyyga+yim5WtV+5cEW2PsMpWrXzU39WpqddQjlq+aVtOU5HUh0Lgb4ZCRTrl8P4axxBobgm955JPGbQAyh8fFqITuZNYcHHfHKqjtiFZJ0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7E27038BB0CD2E40BFB217FBEFDD43B3@eurprd08.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09ee0899-82fa-41a6-d3f3-08d6f3dd4928
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2019 11:08:26.3716 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rkagan@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5146
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 52.101.138.84
Subject: Re: [Qemu-devel] [PATCH] i386: Fix signedness of
 hyperv_spinlock_attempts
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 18, 2019 at 10:35:05AM +0000, Roman Kagan wrote:
> On Tue, Jun 18, 2019 at 11:24:57AM +1000, Vadim Rozenfeld wrote:
> > On Mon, 2019-06-17 at 14:49 -0300, Eduardo Habkost wrote:
> > > On Mon, Jun 17, 2019 at 05:32:13PM +0000, Roman Kagan wrote:
> > > > On Mon, Jun 17, 2019 at 11:23:01AM -0300, Eduardo Habkost wrote:
> > > > > On Mon, Jun 17, 2019 at 01:48:59PM +0000, Roman Kagan wrote:
> > > > > > On Sat, Jun 15, 2019 at 05:05:05PM -0300, Eduardo Habkost
> > > > > > wrote:
> > > > > > > The current default value for hv-spinlocks is 0xFFFFFFFF
> > > > > > > (meaning
> > > > > > > "never retry").  However, the value is stored as a signed
> > > > > > > integer, making the getter of the hv-spinlocks QOM property
> > > > > > > return -1 instead of 0xFFFFFFFF.
> > > > > > > 
> > > > > > > Fix this by changing the type of
> > > > > > > X86CPU::hyperv_spinlock_attempts
> > > > > > > to uint32_t.  This has no visible effect to guest operating
> > > > > > > systems, affecting just the behavior of the QOM getter.
> > > > > > > 
> > > > > > > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > > > > > > ---
> > > > > > >  target/i386/cpu.h | 2 +-
> > > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > 
> > > > > > Reviewed-by: Roman Kagan <rkagan@virtuozzo.com>
> > > > > > 
> > > > > > That said, it's tempting to just nuke qdev_prop_spinlocks and
> > > > > > make
> > > > > > hv-spinlocks a regular DEFINE_PROP_UINT32...
> > > > > 
> > > > > Agreed.  The only difference is that we would validate the
> > > > > property at realize time instead of object_property_set().
> > > > 
> > > > Right.  But currently it's validated to be no less than 0xfff and
> > > > no
> > > > bigger than 0xffffffff.  The latter check would become unnecessary,
> > > > and
> > > > I'm unable to find any reason to do the former (neither spec
> > > > references
> > > > nor the log messages of the commits that introduced it).
> > > 
> > > The 0xFFF lower limit was originally introduced by commit
> > > 28f52cc04d34 ("hyper-v: introduce Hyper-V support infrastructure").
> > > 
> > > Vadim, do you know where the 0xFFF limit comes from?
> > 
> > I simply took this value from Windows Server 2008 R2 that 
> > I used as a reference while working on Hyper-V support for KVM.
> > I also remember some paper (probably published by AMD ???) mentioned
> > that 0x2fff seemed to have the best balance for PLE logic.
> 
> The question is whether the user should be disallowed to set it below
> 0xfff?
> I don't see this mandated by the spec, so I'd rather remove the lower
> limit and convert the property to a regular DEFINE_PROP_UINT32.

I've just posted a patch to that end, feel free to (dis)approve.

Roman.

