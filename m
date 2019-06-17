Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B32BBC31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 17:44:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82E8C2084D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 17:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="bDVl76bP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82E8C2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50574 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcvga-0003XV-00
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 13:44:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45839)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <rkagan@virtuozzo.com>) id 1hcvW0-0001jx-JK
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 13:33:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rkagan@virtuozzo.com>) id 1hcvVz-0000I8-Ao
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 13:33:56 -0400
Received: from mail-bgr052101135083.outbound.protection.outlook.com
 ([52.101.135.83]:43020 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
 id 1hcvVy-0007Ds-BC
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 13:33:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ExMqjsM2JmmuaRQvk6extUMU85aTt2PhHMikISM4OTw=;
 b=bDVl76bPN6Vy/SKTvYszMYppksPb/Ys+aC3xE/gDlXUkrv8Jtk27ysATmWqYrCJbFE6p/l80SeN3744FVDhaF6HfMRRtlQEfNl8kKLG4vafb4DHlQ+XecPrFgtPdXgbcfY71Q18+g36EljkhXwA/c7QO9z1h0xmr1NFChDhEOjw=
Received: from DB8PR08MB3977.eurprd08.prod.outlook.com (20.179.11.95) by
 DB8PR08MB4156.eurprd08.prod.outlook.com (20.179.11.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.15; Mon, 17 Jun 2019 17:32:13 +0000
Received: from DB8PR08MB3977.eurprd08.prod.outlook.com
 ([fe80::3530:3b13:be7f:2944]) by DB8PR08MB3977.eurprd08.prod.outlook.com
 ([fe80::3530:3b13:be7f:2944%4]) with mapi id 15.20.1987.014; Mon, 17 Jun 2019
 17:32:13 +0000
From: Roman Kagan <rkagan@virtuozzo.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Thread-Topic: [PATCH] i386: Fix signedness of hyperv_spinlock_attempts
Thread-Index: AQHVI7WqVFjrvk1Rm0af2n9zJo17vaaf32UAgAAJhYCAADTZAA==
Date: Mon, 17 Jun 2019 17:32:13 +0000
Message-ID: <20190617173210.GG32624@rkaganb.sw.ru>
References: <20190615200505.31348-1-ehabkost@redhat.com>
 <20190617134856.GF32624@rkaganb.sw.ru> <20190617142301.GA19178@habkost.net>
In-Reply-To: <20190617142301.GA19178@habkost.net>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.11.4 (2019-03-13)
mail-followup-to: Roman Kagan <rkagan@virtuozzo.com>,	Eduardo Habkost
 <ehabkost@redhat.com>,	Vitaly Kuznetsov <vkuznets@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson
 <rth@twiddle.net>
x-originating-ip: [185.231.240.5]
x-clientproxiedby: HE1PR1001CA0003.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:3:f7::13) To DB8PR08MB3977.eurprd08.prod.outlook.com
 (2603:10a6:10:ad::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6e03bdf0-3405-4561-e87b-08d6f349bbe0
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB4156; 
x-ms-traffictypediagnostic: DB8PR08MB4156:|DB8PR08MB4156:
x-microsoft-antispam-prvs: <DB8PR08MB41563844F37C3D49D5246122C9EB0@DB8PR08MB4156.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0071BFA85B
x-forefront-antispam-report: SFV:SPM;
 SFS:(10019020)(376002)(39850400004)(366004)(396003)(346002)(136003)(189003)(199004)(36756003)(58126008)(316002)(54906003)(6512007)(9686003)(6116002)(8676002)(81156014)(81166006)(8936002)(2906002)(53936002)(6246003)(229853002)(6436002)(6486002)(66066001)(68736007)(14454004)(3846002)(4326008)(25786009)(33656002)(478600001)(446003)(5660300002)(14444005)(256004)(6916009)(102836004)(6506007)(386003)(71190400001)(7736002)(11346002)(186003)(99286004)(76176011)(86362001)(52116002)(305945005)(1076003)(71200400001)(476003)(26005)(66476007)(66556008)(64756008)(66446008)(66946007)(486006)(73956011)(30126002);
 DIR:OUT; SFP:1501; SCL:5; SRVR:DB8PR08MB4156;
 H:DB8PR08MB3977.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0oiMdeOQnO0rYCxAi2GXmL0OGTdUdj//B6kzxrt9/eAPNNyCo34p4RmEqJ2hWTxnrC04V085OkQwYAxqXCKPthoHvSJp4wCJDVhMztRixtbDB2vbvQuVQ3l6yn4ZYfjIE5pNKDGBWGIM+ptfKx1m3SrUvgCqsCY7us00BRu7xCH3SUpdveWUrzKwyZBnROeEz35ZmjIJuhcXpVRkSOtvW8YVu8obCruMuMweErdBu7Hi86eMT84AAfoF9KTVQCGBuFMtnSs3diTxd0c5nKb4c1d+ijJjruGW3QPGTr7oYjdg0G2vjdc9LBHtOAjWNl85DxSHP6WTTGFqpqw1fFUSUPctkPDahe8i7KGwlMCEsMMwo8tyU426UaZ6EnSScH+Sez5HBOPY9v/CrJfLNf1u+2c/uZp6dqcpDegvjw0RLVRUiRK6+ewzZQzuFuZtn7+hJwVS9/8oOq+7qLXIDZe3nvDp3k4C67XaJapKTNZCzYaGfgCXnOLPo7Dq7G2KzX4+
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2A33801DF992AB40B48242444EC25D5B@eurprd08.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e03bdf0-3405-4561-e87b-08d6f349bbe0
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2019 17:32:13.5311 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rkagan@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4156
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 52.101.135.83
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 17, 2019 at 11:23:01AM -0300, Eduardo Habkost wrote:
> On Mon, Jun 17, 2019 at 01:48:59PM +0000, Roman Kagan wrote:
> > On Sat, Jun 15, 2019 at 05:05:05PM -0300, Eduardo Habkost wrote:
> > > The current default value for hv-spinlocks is 0xFFFFFFFF (meaning
> > > "never retry").  However, the value is stored as a signed
> > > integer, making the getter of the hv-spinlocks QOM property
> > > return -1 instead of 0xFFFFFFFF.
> > > 
> > > Fix this by changing the type of X86CPU::hyperv_spinlock_attempts
> > > to uint32_t.  This has no visible effect to guest operating
> > > systems, affecting just the behavior of the QOM getter.
> > > 
> > > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > > ---
> > >  target/i386/cpu.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > Reviewed-by: Roman Kagan <rkagan@virtuozzo.com>
> > 
> > That said, it's tempting to just nuke qdev_prop_spinlocks and make
> > hv-spinlocks a regular DEFINE_PROP_UINT32...
> 
> Agreed.  The only difference is that we would validate the
> property at realize time instead of object_property_set().

Right.  But currently it's validated to be no less than 0xfff and no
bigger than 0xffffffff.  The latter check would become unnecessary, and
I'm unable to find any reason to do the former (neither spec references
nor the log messages of the commits that introduced it).

Roman.

