Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D599CC31E51
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 10:37:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A03992080C
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 10:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="GY+or930"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A03992080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55494 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdBUv-00039x-Pp
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 06:37:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35152)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <rkagan@virtuozzo.com>) id 1hdBSd-0001oq-4K
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 06:35:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rkagan@virtuozzo.com>) id 1hdBST-0001VC-1q
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 06:35:23 -0400
Received: from mail-db3eur04hn2037.outbound.protection.outlook.com
 ([52.101.138.37]:40773 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
 id 1hdBSN-0001LU-AU
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 06:35:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9FRLfnTlwm221gNQhR8HiGnUmsXeTn3itwBw+lSOW8Y=;
 b=GY+or930CQLhwJIAnUN7TsodlwQMk6rSfzi/Mz8GJqnMi8HOVwqiyPVsPIOBSC9IbqnEFBH9q4s2mf4deeXSeLOrA2LQ+P52ypvLvKc4+CUWMr+QE+IMIZ3TRh7KGx6p+lJQreWtpiBMbV8QXn6v5hRO7xpEih8HqSdML8be2N4=
Received: from DB8PR08MB3977.eurprd08.prod.outlook.com (20.179.11.95) by
 DB8PR08MB3929.eurprd08.prod.outlook.com (20.179.11.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.15; Tue, 18 Jun 2019 10:35:05 +0000
Received: from DB8PR08MB3977.eurprd08.prod.outlook.com
 ([fe80::3530:3b13:be7f:2944]) by DB8PR08MB3977.eurprd08.prod.outlook.com
 ([fe80::3530:3b13:be7f:2944%4]) with mapi id 15.20.1987.014; Tue, 18 Jun 2019
 10:35:05 +0000
From: Roman Kagan <rkagan@virtuozzo.com>
To: Vadim Rozenfeld <vrozenfe@redhat.com>
Thread-Topic: [PATCH] i386: Fix signedness of hyperv_spinlock_attempts
Thread-Index: AQHVI7WqVFjrvk1Rm0af2n9zJo17vaaf32UAgAAJhYCAADTZAIAABMmAgAB/UICAAJmvgA==
Date: Tue, 18 Jun 2019 10:35:05 +0000
Message-ID: <20190618103501.GH32624@rkaganb.sw.ru>
References: <20190615200505.31348-1-ehabkost@redhat.com>
 <20190617134856.GF32624@rkaganb.sw.ru> <20190617142301.GA19178@habkost.net>
 <20190617173210.GG32624@rkaganb.sw.ru> <20190617174917.GE19178@habkost.net>
 <1560821097.5084.179.camel@redhat.com>
In-Reply-To: <1560821097.5084.179.camel@redhat.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.11.4 (2019-03-13)
mail-followup-to: Roman Kagan <rkagan@virtuozzo.com>,	Vadim Rozenfeld
 <vrozenfe@redhat.com>,	Eduardo Habkost <ehabkost@redhat.com>,	Vitaly
 Kuznetsov <vkuznets@redhat.com>, qemu-devel@nongnu.org,	Paolo Bonzini
 <pbonzini@redhat.com>,	Richard Henderson <rth@twiddle.net>
x-originating-ip: [185.231.240.5]
x-clientproxiedby: HE1P191CA0013.EURP191.PROD.OUTLOOK.COM (2603:10a6:3:cf::23)
 To DB8PR08MB3977.eurprd08.prod.outlook.com
 (2603:10a6:10:ad::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e6cf0f9b-f36c-4839-b036-08d6f3d8a06f
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB3929; 
x-ms-traffictypediagnostic: DB8PR08MB3929:|DB8PR08MB3929:
x-microsoft-antispam-prvs: <DB8PR08MB3929E8E085DA792E319E1A29C9EA0@DB8PR08MB3929.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 007271867D
x-forefront-antispam-report: SFV:SPM;
 SFS:(10019020)(346002)(39850400004)(376002)(396003)(366004)(136003)(189003)(199004)(229853002)(486006)(52116002)(36756003)(66446008)(64756008)(7736002)(73956011)(66556008)(305945005)(478600001)(476003)(33656002)(446003)(8936002)(316002)(71200400001)(102836004)(76176011)(66476007)(66946007)(14454004)(6506007)(386003)(81166006)(8676002)(58126008)(99286004)(71190400001)(11346002)(81156014)(54906003)(6916009)(6116002)(86362001)(53936002)(6486002)(4326008)(25786009)(66066001)(3846002)(68736007)(6436002)(26005)(6246003)(1076003)(6512007)(14444005)(9686003)(256004)(2906002)(186003)(5660300002)(30126002);
 DIR:OUT; SFP:1501; SCL:5; SRVR:DB8PR08MB3929;
 H:DB8PR08MB3977.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bSjYcmVtT7xlZ53JYMcjbMM4JgN9x0gGGpSR/0CiHDwxh3PvrF2LkTcQRMYLflTVAu7AJDglMfliBLFBWOwNNJmbixIiNGPlHbKLd2Jl72dHlQf3BjsY0HRJUIXuE5IWMp+XFA+G2y/QXc2Mg6SFmNMfZ9fj0UAKA9hlA/IHUfwcC5iF1f8tXVSqTb3+MQjnNt//Vvln4gxpJgzvGPY43vKMqFC2rIFbS7gDlibxPes/UT+hnEE3jn6jmxKcyuzJ9VSsYyiEe76w7MSzi0e6tnM7DBzcniRBhLn6aLr4Q8DGEU61RQeFHKuXue5JrDR1K1nxhOuapXPb9O2R1VabwQkEJaicCCNzBVE5A7er98yci3aagks5pmOe0xo1N7t+Ts2JJW/UV+pUshFlSUwmvnIFWlzxm0xubmXXnSenlaI/qWPB42I8mRHhJIjZZBn0rC5qJUf5tdyXW3dRLiFdZz7JqXKr2IflfgZISs5GiDOfH1Ky8ZfEnqI76AlgxcFy
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F2F282D34698E04EA420E13E9B79CE60@eurprd08.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6cf0f9b-f36c-4839-b036-08d6f3d8a06f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2019 10:35:05.3131 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rkagan@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB3929
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 52.101.138.37
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 18, 2019 at 11:24:57AM +1000, Vadim Rozenfeld wrote:
> On Mon, 2019-06-17 at 14:49 -0300, Eduardo Habkost wrote:
> > On Mon, Jun 17, 2019 at 05:32:13PM +0000, Roman Kagan wrote:
> > > On Mon, Jun 17, 2019 at 11:23:01AM -0300, Eduardo Habkost wrote:
> > > > On Mon, Jun 17, 2019 at 01:48:59PM +0000, Roman Kagan wrote:
> > > > > On Sat, Jun 15, 2019 at 05:05:05PM -0300, Eduardo Habkost
> > > > > wrote:
> > > > > > The current default value for hv-spinlocks is 0xFFFFFFFF
> > > > > > (meaning
> > > > > > "never retry").  However, the value is stored as a signed
> > > > > > integer, making the getter of the hv-spinlocks QOM property
> > > > > > return -1 instead of 0xFFFFFFFF.
> > > > > > 
> > > > > > Fix this by changing the type of
> > > > > > X86CPU::hyperv_spinlock_attempts
> > > > > > to uint32_t.  This has no visible effect to guest operating
> > > > > > systems, affecting just the behavior of the QOM getter.
> > > > > > 
> > > > > > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > > > > > ---
> > > > > >  target/i386/cpu.h | 2 +-
> > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > 
> > > > > Reviewed-by: Roman Kagan <rkagan@virtuozzo.com>
> > > > > 
> > > > > That said, it's tempting to just nuke qdev_prop_spinlocks and
> > > > > make
> > > > > hv-spinlocks a regular DEFINE_PROP_UINT32...
> > > > 
> > > > Agreed.  The only difference is that we would validate the
> > > > property at realize time instead of object_property_set().
> > > 
> > > Right.  But currently it's validated to be no less than 0xfff and
> > > no
> > > bigger than 0xffffffff.  The latter check would become unnecessary,
> > > and
> > > I'm unable to find any reason to do the former (neither spec
> > > references
> > > nor the log messages of the commits that introduced it).
> > 
> > The 0xFFF lower limit was originally introduced by commit
> > 28f52cc04d34 ("hyper-v: introduce Hyper-V support infrastructure").
> > 
> > Vadim, do you know where the 0xFFF limit comes from?
> 
> I simply took this value from Windows Server 2008 R2 that 
> I used as a reference while working on Hyper-V support for KVM.
> I also remember some paper (probably published by AMD ???) mentioned
> that 0x2fff seemed to have the best balance for PLE logic.

The question is whether the user should be disallowed to set it below
0xfff?
I don't see this mandated by the spec, so I'd rather remove the lower
limit and convert the property to a regular DEFINE_PROP_UINT32.

Roman.

