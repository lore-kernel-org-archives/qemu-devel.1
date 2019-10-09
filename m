Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D72ECE58C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 16:49:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3147721848
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 16:49:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="aMjJ+ZIe";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="tkmEdzlh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3147721848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIF9P-0003lf-NE
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 12:49:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43066)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=718511e6aa=jglauber@marvell.com>)
 id 1iI6w4-0004F2-AD
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 04:03:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=718511e6aa=jglauber@marvell.com>)
 id 1iI6vy-0004XW-IO
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 04:03:03 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:51120)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=718511e6aa=jglauber@marvell.com>)
 id 1iI6vy-0004Sa-3Q; Wed, 09 Oct 2019 04:02:58 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 x9982IiA016913; Wed, 9 Oct 2019 01:02:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=dQ8RnV6BB660yZahOF6QVCf976LOe4pwUkpDjwMKgwo=;
 b=aMjJ+ZIewG577j0sOsatvOFgL7xNruai7/DfglFL2dWYrl3KFUEhMmTJaNdWGyYT2RbJ
 X5ADSKBeDtpFoA10EXXIuzL9aGwo52/E9Du2tbKQZ8K0vsc4YD8uLaIqJAlR6NP3to01
 YLV7RUDo2XhZaKrkKKJjoQcc+9gW+G4JjtkrxOOsihku8JE7EOVUwYnPUGGINtbxbTxc
 ndJ4s/VjUeJER98oP0EfDBA/ivGevubBvH1txvsAQyXntC5B4V5auN+gJtOX+sZ3mtGS
 cfy0kPAy98oJ3Qj/8nDsv7MZKuBS728UyDrvBpYLcRUPPUB1QlVFA5buBr83IAkMxhJl Iw== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
 by mx0b-0016f401.pphosted.com with ESMTP id 2vetpn5y45-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Wed, 09 Oct 2019 01:02:43 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 9 Oct
 2019 01:02:41 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.56) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server
 (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 9 Oct 2019 01:02:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kgN8hns2ZWL5piTuB5iX/AE0HxAySWE91zmBGrA7lboUr3dB/bF0oarRDLBU8aHFkW5Rs5rJeGiccuUzCQPifdvWWYDLuRoLbuyd0bNLLOBIHrb4HrZQZChCy+aquJBOdXvKuPvqua/sXwS64KsITiKp7vtc4S5zAulu56JH8dRDH1dE6bYAkM95EgqZBJuxanTBpfpN8ACGTTc9jBAl4B/eUMvaEFwSJIQZBTeRcA+lArJfKQWZhduVVp6uX7Ptq6csQ5mUfVBI62dVVMAm+OhZJj0kUbcRpd8/bsv5m9fhDfZrQ9PwdqWB7Uid9Xm69v4UacF5lM/LSx1ENmWfpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dQ8RnV6BB660yZahOF6QVCf976LOe4pwUkpDjwMKgwo=;
 b=GrCjX6ysQd8WY6HLiD9uhzwlHQwpSbNy1FCGsskZrUCeMiNldtAji/0WF1qwjOvA2fNzcd7RaLU2TXMuoK6y4q432dMF59jOUnAZsHCyrlTxZDlLf7UiB2uwuMZSR7kNn/jIx1JZ5q5Vii78PqhHWlDhyxzOdp4PCO7wRGG3dU0aSgrUZeGS9zra/OhFK124Q1IYcxUHuA+nzwGh1oqQ7nJ4aGDd+NbudkiNCXUwMbK8V10O+eUQfqwqz8gFhRx1zX5g6vYvdNOSSPdtmpupyRIVMKUrM9gMjmXNcZPXThPItxKqnTnjmO+52hXaVgy6w/EGk7blp1u61ks40azKTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dQ8RnV6BB660yZahOF6QVCf976LOe4pwUkpDjwMKgwo=;
 b=tkmEdzlhyAASWpQATp+WVTMtSHpf/2HX4gtb3QMw1K6XcWRmW25VVP2m4jg0M0ULdQcS13YGcIZwcVWqMFCOiVMG2Q8axfoIu5ih245PsvwL881KNMw2JKCrcIiPND9sTV2P0uZzqWWBlvQ1czrsUXWoC7qBRp3qlzGlzB+kyBI=
Received: from DM6PR18MB3001.namprd18.prod.outlook.com (20.179.104.143) by
 DM6PR18MB3275.namprd18.prod.outlook.com (10.255.173.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Wed, 9 Oct 2019 08:02:39 +0000
Received: from DM6PR18MB3001.namprd18.prod.outlook.com
 ([fe80::11c2:98e0:b9d9:5dba]) by DM6PR18MB3001.namprd18.prod.outlook.com
 ([fe80::11c2:98e0:b9d9:5dba%5]) with mapi id 15.20.2327.026; Wed, 9 Oct 2019
 08:02:39 +0000
From: Jan Glauber <jglauber@marvell.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [Qemu-devel] qemu_futex_wait() lockups in ARM64: 2 possible issues
Thread-Topic: [Qemu-devel] qemu_futex_wait() lockups in ARM64: 2 possible
 issues
Thread-Index: AQHVfnfqvu+yt3RexE2xAyyT9MgnEQ==
Date: Wed, 9 Oct 2019 08:02:38 +0000
Message-ID: <20191009080220.GA2905@hc>
References: <cbe46ad6-ef6c-d155-e79a-672182c725ad@ubuntu.com>
 <d94f18f1-986f-ec19-02c0-e83e5e7af3d0@redhat.com>
 <1864070a-2f84-1d98-341e-f01ddf74ec4b@ubuntu.com>
 <20190924202517.GA21422@xps13.dannf> <20191002092253.GA3857@hc>
 <6dd73749-49b0-0fbc-b9bb-44c3736642b8@redhat.com>
 <20191007144432.GA29958@xps13.dannf>
 <065a52a9-5bb0-1259-6c73-41af60e0a05d@redhat.com>
In-Reply-To: <065a52a9-5bb0-1259-6c73-41af60e0a05d@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR06CA0062.eurprd06.prod.outlook.com
 (2603:10a6:208:aa::39) To DM6PR18MB3001.namprd18.prod.outlook.com
 (2603:10b6:5:182::15)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [46.5.45.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5e3be27c-6fef-479a-66d4-08d74c8f0c8a
x-ms-traffictypediagnostic: DM6PR18MB3275:
x-microsoft-antispam-prvs: <DM6PR18MB32750DB22F89CEAE084B548ED8950@DM6PR18MB3275.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 018577E36E
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(7916004)(4636009)(136003)(376002)(366004)(346002)(39850400004)(396003)(189003)(199004)(66556008)(386003)(476003)(486006)(4326008)(446003)(6246003)(11346002)(99286004)(33716001)(54906003)(26005)(66066001)(186003)(66946007)(64756008)(66446008)(71200400001)(66476007)(71190400001)(102836004)(53546011)(6506007)(256004)(52116002)(14444005)(76176011)(8676002)(6436002)(33656002)(81166006)(316002)(81156014)(6916009)(5660300002)(86362001)(6486002)(8936002)(6512007)(9686003)(3846002)(6116002)(7736002)(305945005)(2906002)(14454004)(229853002)(478600001)(25786009)(1076003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR18MB3275;
 H:DM6PR18MB3001.namprd18.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kZS3kbsSV6vvCPmmP6oHZTYPtHpZpnuVUqeyLXmC49kMKyzyAmK5JpWdL+t38wb67jpkPnqfFt5baHCW/jfsj5rUGK2Xyf/Y7sfwu1H6l/NPZsxgCXNFxrJ9Su8UuQSqjFdxwS/DC5TALK5Iz/+WyATLhNp6HJlVn3QDEUeu06zh/N1u3TkhIEIyxyHG10gTUQ6hCUv4F0TMcOWSZrUzEfH2d1igt56anqRIapzrWu7R88nnFKwOqQOrvK2QDGzByAUtJ2dDFB+SdO7Xeg/grN4UL7p8gHLfX9hbOFqfxdPUBpUkTfzDernXWBIToMugMBWzzWcisT7XfdSinMmuyMTH3rFqPeT5LJtGCVOVymC7Jx5s4DohBBW3Z7N1VngdcKhXW4fYpNHHqIakHvQ0XCEDCWiqOH9Ir/RVeX/3Ktg=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <99F6E93CC8D06744859B160F24C647C4@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e3be27c-6fef-479a-66d4-08d74c8f0c8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2019 08:02:38.8885 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2bdojPrWsSpo2J9sa61ETC5UdIjkH28fpBR+jnrIwRZbatKkXpKu/hmRpv3Z8bJbwdPZikjaFiQXrtdpTrKKlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR18MB3275
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-09_03:2019-10-08,2019-10-09 signatures=0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 67.231.156.173
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

On Mon, Oct 07, 2019 at 04:58:30PM +0200, Paolo Bonzini wrote:
> On 07/10/19 16:44, dann frazier wrote:
> > On Mon, Oct 07, 2019 at 01:06:20PM +0200, Paolo Bonzini wrote:
> >> On 02/10/19 11:23, Jan Glauber wrote:
> >>> I've looked into this on ThunderX2. The arm64 code generated for the
> >>> atomic_[add|sub] accesses of ctx->notify_me doesn't contain any
> >>> memory barriers. It is just plain ldaxr/stlxr.
> >>>
> >>> From my understanding this is not sufficient for SMP sync.
> >>>
> >>> If I read this comment correct:
> >>>
> >>>     void aio_notify(AioContext *ctx)
> >>>     {
> >>>         /* Write e.g. bh->scheduled before reading ctx->notify_me.  P=
airs
> >>>          * with atomic_or in aio_ctx_prepare or atomic_add in aio_pol=
l.
> >>>          */
> >>>         smp_mb();
> >>>         if (ctx->notify_me) {
> >>>
> >>> it points out that the smp_mb() should be paired. But as
> >>> I said the used atomics don't generate any barriers at all.
> >>
> >> Based on the rest of the thread, this patch should also fix the bug:
> >>
> >> diff --git a/util/async.c b/util/async.c
> >> index 47dcbfa..721ea53 100644
> >> --- a/util/async.c
> >> +++ b/util/async.c
> >> @@ -249,7 +249,7 @@ aio_ctx_check(GSource *source)
> >>      aio_notify_accept(ctx);
> >> =20
> >>      for (bh =3D ctx->first_bh; bh; bh =3D bh->next) {
> >> -        if (bh->scheduled) {
> >> +        if (atomic_mb_read(&bh->scheduled)) {
> >>              return true;
> >>          }
> >>      }
> >>
> >>
> >> And also the memory barrier in aio_notify can actually be replaced
> >> with a SEQ_CST load:
> >>
> >> diff --git a/util/async.c b/util/async.c
> >> index 47dcbfa..721ea53 100644
> >> --- a/util/async.c
> >> +++ b/util/async.c
> >> @@ -349,11 +349,11 @@ LinuxAioState *aio_get_linux_aio(AioContext *ctx=
)
> >> =20
> >>  void aio_notify(AioContext *ctx)
> >>  {
> >> -    /* Write e.g. bh->scheduled before reading ctx->notify_me.  Pairs
> >> -     * with atomic_or in aio_ctx_prepare or atomic_add in aio_poll.
> >> +    /* Using atomic_mb_read ensures that e.g. bh->scheduled is writte=
n before
> >> +     * ctx->notify_me is read.  Pairs with atomic_or in aio_ctx_prepa=
re or
> >> +     * atomic_add in aio_poll.
> >>       */
> >> -    smp_mb();
> >> -    if (ctx->notify_me) {
> >> +    if (atomic_mb_read(&ctx->notify_me)) {
> >>          event_notifier_set(&ctx->notifier);
> >>          atomic_mb_set(&ctx->notified, true);
> >>      }
> >>
> >>
> >> Would you be able to test these (one by one possibly)?
> >=20
> > Paolo,
> >   I tried them both separately and together on a Hi1620 system, each
> > time it hung in the first iteration. Here's a backtrace of a run with
> > both patches applied:
>=20
> Ok, not a great start...  I'll find myself an aarch64 machine and look
> at it more closely.  I'd like the patch to be something we can
> understand and document, since this is probably the second most-used
> memory barrier idiom in QEMU.
>=20
> Paolo

I'm still not sure what the actual issue is here, but could it be some bad
interaction between the notify_me and the list_lock? The are both 4 byte
and side-by-side:

address notify_me: 0xaaaadb528aa0  sizeof notify_me: 4
address list_lock: 0xaaaadb528aa4  sizeof list_lock: 4

AFAICS the generated code looks OK (all load/store exclusive done
with 32 bit size):

     e6c:       885ffc01        ldaxr   w1, [x0]
     e70:       11000821        add     w1, w1, #0x2
     e74:       8802fc01        stlxr   w2, w1, [x0]

...but if I bump notify_me size to uint64_t the issue goes away.

BTW, the image file I convert in the testcase is ~20 GB.

--Jan

diff --git a/include/block/aio.h b/include/block/aio.h
index a1d6b9e24939..e8a5ea3860bb 100644
--- a/include/block/aio.h
+++ b/include/block/aio.h
@@ -83,7 +83,7 @@ struct AioContext {
      * Instead, the aio_poll calls include both the prepare and the
      * dispatch phase, hence a simple counter is enough for them.
      */
-    uint32_t notify_me;
+    uint64_t notify_me;
=20
     /* A lock to protect between QEMUBH and AioHandler adders and deleter,
      * and to ensure that no callbacks are removed while we're walking and

