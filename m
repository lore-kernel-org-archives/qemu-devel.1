Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57057ECE58C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 14:41:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 203BC21655
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 14:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="cvkWOHaH";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="B2Lk12LL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 203BC21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHUCf-0000sp-52
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 10:41:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41276)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=7183eea0ab=jglauber@marvell.com>)
 id 1iHU87-00040h-1M
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 10:36:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=7183eea0ab=jglauber@marvell.com>)
 id 1iHU85-0005TZ-0r
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 10:36:54 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:56528
 helo=mx0b-0016f401.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=7183eea0ab=jglauber@marvell.com>)
 id 1iHU84-0005SI-3R; Mon, 07 Oct 2019 10:36:52 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 x97EZDbS010489; Mon, 7 Oct 2019 07:36:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=xO0p0B6n4W8nbpdUV9faQD9sQ2u/lJb06Gvy2WERHMU=;
 b=cvkWOHaHPr3r4i+E612G8ZkXB91GmdBSqskLJOvOZ81PWVjpcs2myd6Y6rlRpJJKKbRv
 8EwoV8WUK69VjZeJcUrcmXWv8hxWUBkwyCFAuvwL2209DemUARiFz1nmgP7U7TD4ultm
 ndYLjvYLz0bCLBcHl/mYWbRs9p8Ub4ujOzhSGdH4FpSsiYtn3gwQ+mZNX7Von2J3wbQB
 myhjoiNaWKiNVQLOUhP+xxJ7Oplj03MxDaIgpUG3/vC5w5KlSB1tiy7XNsQPRhC4EDq2
 uAX0eK/nvR/VUMKyGjqKpbX26dpyxTpldMtyyPHRhKfbbtzJwciD+GSk/x52NK8frSQ0 nw== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
 by mx0a-0016f401.pphosted.com with ESMTP id 2vg3n8gsd2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Mon, 07 Oct 2019 07:36:40 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 7 Oct
 2019 07:36:39 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (104.47.34.51) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server
 (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 7 Oct 2019 07:36:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dDY/yrjixF6BhNqrX5EPe/3ndMl5LQiRtLi6OX8lzpTd5i1+euoQZd7IEn6JiGB6e7lYl1LgSlRuDV3AxMx8n7uOr08Pl2TZurtb2FPf+rLhgAZYi8mCBE/GXhKBdcr5iTOV79JDieIxT81z5vMFongmej6ueGfnHWmawY0wYzxv5AwPXCSHCmR1AgzuYnRU3ZOzVrn1oJeVSrrAcGyhu/Z74NdYtmx/drcX2S2FrpgX2S9hkbqlwCDa09RjlG7GG8R/5bc2FfRBFqfdtLjzSqE7O+4GFF6NTk/QHBfd4v0xyG7HPMT/OCS5pXCxtjAO4yUlJh/dPOd1C8TW2ATyeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xO0p0B6n4W8nbpdUV9faQD9sQ2u/lJb06Gvy2WERHMU=;
 b=I4QQU9uMhb1cY0ywzsH8ZnrIpPoJWybM16BxiylJHiuDq9oGejYuYuxL4C2Zv7+wVgDZJAMKkGnmygxYwXcpKMiFl8Q5bnonjAKl+PKncSo7+y6rbkAfz0ubQIFMWRbi9/pqs23ArOZY0o6pnV73XXG5w5DOxe8xhPWM6nFzJoePpOnjYd1O3MKOIO98d/Sn5Z+dUTL6vhxfSDINY7N+7CHAEvXntCuKbNDknRoNV7CVef/gIGK0fk1VuaVyMb143UeaEXadOT0JfBorYv//G29XxPLYeyDoSmvxMaMnYBW9Hy+BN7sBxxOtIZmNYjmS++2rp0weyeW6BKeuozkmRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xO0p0B6n4W8nbpdUV9faQD9sQ2u/lJb06Gvy2WERHMU=;
 b=B2Lk12LLlOI83e1TdDnxRoypaXz6FMhRENmGEcxOGfGXK6PD2h+DvGFnjY+wKZ4opjotxSKaH2KDWBW96H0XyiE1/I/LZzUIq/BIn39H9LgKLG2iRxFpbu+ZI8ngdxmbW6nyH0jtJxEXcAP3uLcuEwvGTOKJw2hBh99mwLwIjtU=
Received: from DM6PR18MB3001.namprd18.prod.outlook.com (20.179.104.143) by
 DM6PR18MB3164.namprd18.prod.outlook.com (10.255.172.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.24; Mon, 7 Oct 2019 14:36:38 +0000
Received: from DM6PR18MB3001.namprd18.prod.outlook.com
 ([fe80::11c2:98e0:b9d9:5dba]) by DM6PR18MB3001.namprd18.prod.outlook.com
 ([fe80::11c2:98e0:b9d9:5dba%5]) with mapi id 15.20.2327.026; Mon, 7 Oct 2019
 14:36:38 +0000
From: Jan Glauber <jglauber@marvell.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [Qemu-devel] qemu_futex_wait() lockups in ARM64: 2 possible issues
Thread-Topic: [Qemu-devel] qemu_futex_wait() lockups in ARM64: 2 possible
 issues
Thread-Index: AQHVfRygtO7Er40jOkCa/RGKZULg/Q==
Date: Mon, 7 Oct 2019 14:36:38 +0000
Message-ID: <20191007143629.GA23062@hc>
References: <cbe46ad6-ef6c-d155-e79a-672182c725ad@ubuntu.com>
 <d94f18f1-986f-ec19-02c0-e83e5e7af3d0@redhat.com>
 <1864070a-2f84-1d98-341e-f01ddf74ec4b@ubuntu.com>
 <20190924202517.GA21422@xps13.dannf> <20191002092253.GA3857@hc>
 <6dd73749-49b0-0fbc-b9bb-44c3736642b8@redhat.com>
In-Reply-To: <6dd73749-49b0-0fbc-b9bb-44c3736642b8@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR02CA0005.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::18) To DM6PR18MB3001.namprd18.prod.outlook.com
 (2603:10b6:5:182::15)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2a02:8070:8784:5a00:a897:ff71:4e18:8f6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9ec8422c-eff6-4711-131b-08d74b33c2ab
x-ms-traffictypediagnostic: DM6PR18MB3164:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DM6PR18MB3164F811E4AFA001FA90CFA9D89B0@DM6PR18MB3164.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01834E39B7
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(7916004)(4636009)(39850400004)(366004)(376002)(396003)(136003)(346002)(189003)(199004)(54906003)(966005)(14454004)(486006)(316002)(33716001)(6506007)(7736002)(386003)(53546011)(256004)(14444005)(11346002)(446003)(81156014)(478600001)(8936002)(81166006)(8676002)(46003)(1076003)(476003)(5660300002)(86362001)(6486002)(2906002)(186003)(4326008)(6436002)(6116002)(99286004)(52116002)(9686003)(6512007)(71190400001)(229853002)(76176011)(305945005)(102836004)(66556008)(66946007)(33656002)(66476007)(64756008)(71200400001)(6306002)(66446008)(25786009)(6246003)(6916009);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR18MB3164;
 H:DM6PR18MB3001.namprd18.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5YVWVnUEPZX0i7VwHL1aF+kCfGjklaXCKFZ5IW2aldRIkU4iK9RjiBpj/BMzeAomJ+Xv3u5rgoMWbYUSaMitO6Yj+PR4Mdv5ZEuw0U7iNZO2R+/T7rjDaCD5PF6EyAI6uoR2i13Jt0gvJ6/SminG5n06ZPHkvV7aXgZNZCt3OtBps/qfONcvWsRsmKneXR20Z6YI5Fo/gUThvVwk2TzLfsN2537wTAhliThnhjcch6wbVcEg5nH1dz+9OqVA3/sGx19urYcGeviSfp69lKklVMtwuiLePgKSQsoZNBk18c3URxmpsNnWrU0VbLct4eBujxk6dQiDMSaZemKuddFBPqe6TQ6ebHUIjzgpqF1h85YXTlLV1DDdFHzJwmn1CmfFzX22swiwy1nCpBUZGGhMiFpT5RfjkeYSr7zCiCJ911yZ9UoQHhk294yvuxGyV+1p0LpB458GQ/ibRZhG1BJz2A==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <47F70ACD419DB841B57599EFD1C52806@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ec8422c-eff6-4711-131b-08d74b33c2ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2019 14:36:38.1379 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qk+GmGcZjBMJiA++KCA5V/uQrcc954kQPUHBD4NPido0MCcIuaYefQLCBI74AH08O9+lZ+Vu663AH5H7KyzqHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR18MB3164
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-07_02:2019-10-07,2019-10-07 signatures=0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 67.231.148.174
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
Cc: Rafael David Tinoco <rafaeldtinoco@ubuntu.com>,
 lizhengui <lizhengui@huawei.com>, dann frazier <dann.frazier@canonical.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Bug 1805256 <1805256@bugs.launchpad.net>, QEMU
 Developers - ARM <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 07, 2019 at 01:06:20PM +0200, Paolo Bonzini wrote:
> On 02/10/19 11:23, Jan Glauber wrote:
> > I've looked into this on ThunderX2. The arm64 code generated for the
> > atomic_[add|sub] accesses of ctx->notify_me doesn't contain any
> > memory barriers. It is just plain ldaxr/stlxr.
> >=20
> > From my understanding this is not sufficient for SMP sync.
> >=20
> > If I read this comment correct:
> >=20
> >     void aio_notify(AioContext *ctx)
> >     {
> >         /* Write e.g. bh->scheduled before reading ctx->notify_me.  Pai=
rs
> >          * with atomic_or in aio_ctx_prepare or atomic_add in aio_poll.
> >          */
> >         smp_mb();
> >         if (ctx->notify_me) {
> >=20
> > it points out that the smp_mb() should be paired. But as
> > I said the used atomics don't generate any barriers at all.
>=20
> Based on the rest of the thread, this patch should also fix the bug:
>=20
> diff --git a/util/async.c b/util/async.c
> index 47dcbfa..721ea53 100644
> --- a/util/async.c
> +++ b/util/async.c
> @@ -249,7 +249,7 @@ aio_ctx_check(GSource *source)
>      aio_notify_accept(ctx);
> =20
>      for (bh =3D ctx->first_bh; bh; bh =3D bh->next) {
> -        if (bh->scheduled) {
> +        if (atomic_mb_read(&bh->scheduled)) {
>              return true;
>          }
>      }
>=20
>=20
> And also the memory barrier in aio_notify can actually be replaced
> with a SEQ_CST load:
>=20
> diff --git a/util/async.c b/util/async.c
> index 47dcbfa..721ea53 100644
> --- a/util/async.c
> +++ b/util/async.c
> @@ -349,11 +349,11 @@ LinuxAioState *aio_get_linux_aio(AioContext *ctx)
> =20
>  void aio_notify(AioContext *ctx)
>  {
> -    /* Write e.g. bh->scheduled before reading ctx->notify_me.  Pairs
> -     * with atomic_or in aio_ctx_prepare or atomic_add in aio_poll.
> +    /* Using atomic_mb_read ensures that e.g. bh->scheduled is written b=
efore
> +     * ctx->notify_me is read.  Pairs with atomic_or in aio_ctx_prepare =
or
> +     * atomic_add in aio_poll.
>       */
> -    smp_mb();
> -    if (ctx->notify_me) {
> +    if (atomic_mb_read(&ctx->notify_me)) {
>          event_notifier_set(&ctx->notifier);
>          atomic_mb_set(&ctx->notified, true);
>      }
>=20
>=20
> Would you be able to test these (one by one possibly)?

Sure.

> > I've tried to verify me theory with this patch and didn't run into the
> > issue for ~500 iterations (usually I would trigger the issue ~20 iterat=
ions).
>=20
> Sorry for asking the obvious---500 iterations of what?

The testcase mentioned in the Canonical issue:
https://bugs.launchpad.net/qemu/+bug/1805256

It's a simple image convert:
qemu-img convert -f qcow2 -O qcow2 ./disk01.qcow2 ./output.qcow2

Usually it got stuck after 3-20 iterations.

--Jan

