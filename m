Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC9B7C31E50
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 13:54:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9E282080C
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 13:54:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ZxuB217E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9E282080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47678 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcs5D-0002BY-1P
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 09:54:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33812)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <rkagan@virtuozzo.com>) id 1hcs0d-0006Fn-Ej
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 09:49:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rkagan@virtuozzo.com>) id 1hcs0a-0002nq-8X
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 09:49:17 -0400
Received: from mail-ve1eur01hn0312.outbound.protection.outlook.com
 ([2a01:111:f400:fe1f::312]:14074
 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
 id 1hcs0X-0002kK-Ee
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 09:49:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTVR4co0XMyNq13KQZEs1MARWzPK0+KQ1TSuAy4B0eQ=;
 b=ZxuB217EmWA+vgRZHYp8714HhdEYof79fAQr6l3snP6RSgPzdWkN6+3aDgJhACHspUyv1Rvd7VvJlU3ifJj3yKIsmk+UNqIhCADK2s+SHvoHuL8kEh1NZNCjqb+3twStCDBInwG2CAekbau9ekc+Ni64nlZDpM7+RxwaWw7Cj68=
Received: from DB8PR08MB3977.eurprd08.prod.outlook.com (20.179.11.95) by
 DB8PR08MB4090.eurprd08.prod.outlook.com (20.179.10.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Mon, 17 Jun 2019 13:49:00 +0000
Received: from DB8PR08MB3977.eurprd08.prod.outlook.com
 ([fe80::3530:3b13:be7f:2944]) by DB8PR08MB3977.eurprd08.prod.outlook.com
 ([fe80::3530:3b13:be7f:2944%4]) with mapi id 15.20.1987.014; Mon, 17 Jun 2019
 13:49:00 +0000
From: Roman Kagan <rkagan@virtuozzo.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Thread-Topic: [PATCH] i386: Fix signedness of hyperv_spinlock_attempts
Thread-Index: AQHVI7WqVFjrvk1Rm0af2n9zJo17vaaf32UA
Date: Mon, 17 Jun 2019 13:48:59 +0000
Message-ID: <20190617134856.GF32624@rkaganb.sw.ru>
References: <20190615200505.31348-1-ehabkost@redhat.com>
In-Reply-To: <20190615200505.31348-1-ehabkost@redhat.com>
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
x-clientproxiedby: HE1PR05CA0350.eurprd05.prod.outlook.com
 (2603:10a6:7:92::45) To DB8PR08MB3977.eurprd08.prod.outlook.com
 (2603:10a6:10:ad::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1998b48b-f424-4c0f-9b03-08d6f32a8cdb
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB4090; 
x-ms-traffictypediagnostic: DB8PR08MB4090:|DB8PR08MB4090:
x-microsoft-antispam-prvs: <DB8PR08MB4090851A558CAB7A3930266DC9EB0@DB8PR08MB4090.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0071BFA85B
x-forefront-antispam-report: SFV:SPM;
 SFS:(10019020)(346002)(376002)(396003)(39850400004)(366004)(136003)(189003)(199004)(66066001)(8676002)(476003)(2906002)(102836004)(14454004)(256004)(6506007)(386003)(81166006)(73956011)(53936002)(14444005)(66946007)(305945005)(4326008)(11346002)(54906003)(86362001)(58126008)(316002)(186003)(229853002)(3846002)(52116002)(486006)(6916009)(66556008)(1076003)(66476007)(26005)(71200400001)(71190400001)(9686003)(6512007)(6116002)(446003)(7736002)(66446008)(68736007)(81156014)(25786009)(6486002)(33656002)(8936002)(36756003)(5660300002)(6436002)(478600001)(6246003)(99286004)(64756008)(76176011)(30126002);
 DIR:OUT; SFP:1501; SCL:5; SRVR:DB8PR08MB4090;
 H:DB8PR08MB3977.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DbKZ5ROc0Gm6kxKyYad7yWf9vDeUtD7zsfwbGHGtRFfOwKB9XYjOu588YoiegTkmjqgHNC0d5D4i1XQKNdJxGsPFPCnWDybJ3HyZ8Q4DTNrxR4fOZFrKVPWStBACNLOt/QZ1NrfYjDUEHG74v4nWcerjjBR7aUgQbxQCCaxzels0UtRt16q2l6lTbcebtcAYVzyCsF478PJN1MDumSR/NyqVqzLEz2O2Frgt7Q+wF46TTyO1+MC9LRUq8IdnEKZtYFBIeGxDjVbrxbAEJGj2IoMmrbotm93qOoieOeCpNT7SVc6+2oWUSpINoIEzmcjc+OXUzLr0gRJIYZVOQoZlEc1ceKMRgQaANKm+JKJl5NhmZLHwajdOubWFMIZYHcawKlG3518Lm7IZPyi8ZIQJqNK8UFrkOedZDjWqNctS4DOBw9aSgZOBm/gcpiXKS4woqew9K+tG4Dp3mgMaIF8ufK8rRO+z5pBdzpjw+YZxmNk=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4C693173E31E804E98BE2A52760FDF2C@eurprd08.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1998b48b-f424-4c0f-9b03-08d6f32a8cdb
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2019 13:48:59.9320 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rkagan@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4090
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe1f::312
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

On Sat, Jun 15, 2019 at 05:05:05PM -0300, Eduardo Habkost wrote:
> The current default value for hv-spinlocks is 0xFFFFFFFF (meaning
> "never retry").  However, the value is stored as a signed
> integer, making the getter of the hv-spinlocks QOM property
> return -1 instead of 0xFFFFFFFF.
> 
> Fix this by changing the type of X86CPU::hyperv_spinlock_attempts
> to uint32_t.  This has no visible effect to guest operating
> systems, affecting just the behavior of the QOM getter.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  target/i386/cpu.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Roman Kagan <rkagan@virtuozzo.com>

That said, it's tempting to just nuke qdev_prop_spinlocks and make
hv-spinlocks a regular DEFINE_PROP_UINT32...

> 
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 0732e059ec..8158d0de73 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1372,7 +1372,7 @@ struct X86CPU {
>  
>      bool hyperv_vapic;
>      bool hyperv_relaxed_timing;
> -    int hyperv_spinlock_attempts;
> +    uint32_t hyperv_spinlock_attempts;
>      char *hyperv_vendor_id;
>      bool hyperv_time;
>      bool hyperv_crash;
> -- 
> 2.18.0.rc1.1.g3f1ff2140
> 

