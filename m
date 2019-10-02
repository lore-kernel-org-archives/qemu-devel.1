Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59746C35280
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 12:29:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 278FA21920
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 12:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="s45KGowi";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="R8u6r9Zd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 278FA21920
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFdkv-00010R-5c
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 08:29:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44975)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=71787d9211=jglauber@marvell.com>)
 id 1iFaqp-0002yI-9w
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 05:23:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=71787d9211=jglauber@marvell.com>)
 id 1iFaqn-0008BC-Td
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 05:23:14 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:14164
 helo=mx0b-0016f401.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=71787d9211=jglauber@marvell.com>)
 id 1iFaqn-00089q-EG; Wed, 02 Oct 2019 05:23:13 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 x9299bEo005670; Wed, 2 Oct 2019 02:23:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=KGeDtELnz5+OVFIXQpTRDVSPpulDszLOxKMJxQsc2yE=;
 b=s45KGowi9b1vgzAXw9y1laZb00Vtl3qqs8P5RsCRkTXyzrYIPo8fUEEHTWeMmQKgi/Lq
 +RpYEyRi/IElpBqIHP9mJTSmoFLGXHiFaYyoeDnftdgy4+nYTM+zDg5DSe75hEIXWF/P
 wjdA4UtmSEq0c5S83alfPuCRtfu0TXR+iR/SEngzXbc+QugTanYOsWlHzVfRKN2IJXnp
 k17n6urWENRidy8I898KXhpm+dSvNSJ7RXBlQlSMdcuYZkgonivwTunWfnAhEyQfVD4o
 tKRZOWLkOnn57uEOVLIDu4LvbnpmYwWi+DMTmLbtiO/03GASI/EKWCCFlj2ztvkHZpuE uA== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
 by mx0a-0016f401.pphosted.com with ESMTP id 2vcjbn19rq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Wed, 02 Oct 2019 02:23:03 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 2 Oct
 2019 02:23:02 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (104.47.32.52) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server
 (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 2 Oct 2019 02:23:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nkQZQ8EPv9mAMthg5hs1Kc9IPq14Yk2MOkZKerMNoDo1zX1WqXpXrObp9KWt5nIOE5jVuu8yf50YlQOjeftRV/uBEEAme7kCq4CRL5juQgY+h+jmLaBxTPx6iKipNiXLmVTUO/BGna/cfVyKyKyP13p7wpyQcpG3wk3uAfFDJzVWsRoBh6UVQJ0dNy5a70ZK86pXZR/YKECYzxWEKVk/M3cMyUiAnj9xdV1tCQ4JWwSbEKCcAwAUP66Fu4c8yQq+OmuSErr2UhbKkOn4HNK2RgOoejKsO/WwODHSUmx8CgeSZNu0U4x3JbfZiT1jgohddUc9zA8QgoaPp+ioK7oJiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KGeDtELnz5+OVFIXQpTRDVSPpulDszLOxKMJxQsc2yE=;
 b=A5EkqSIJQ8qCYSsJ3KWZd/SC4sBQcNIz652EdBsdyLqqZAo7f4sNxNwHIB9Z94qLCdy5/Kz62vBkHFw35U+np63AKCH+TEcW8v6399zLXMp/WyRx2MljLSgUE3/3F9VljJeWHyg2xJBuGxYT4B9Dss7caDe+sWckFlCQgKYaNSqZd1sMYNs0EhtYnSfFioX8fovfgZjt8DSeOTQerhceUtta3AUOaNRdwWmLojlM2zvToQcE04hieEmYr6hj6CXwLw/M/P1HKbn/Yuvab6SyzNfv2OcEZLHBS3pA5QrNA5iSYllFpwN5IKYQ1AVLI/dL84nQvAC/hZIdjbQHet3HUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KGeDtELnz5+OVFIXQpTRDVSPpulDszLOxKMJxQsc2yE=;
 b=R8u6r9ZdcYjfhi3t16svRuIZ5FmvlhVT5bhMHyC0Zzmbgpz0yhsX7LioIth16SLlCQ1yZsJUjb5u9jWdGO4N3oZ2TyCRvTh3xoHKxQNL3MFfVIO0ceOJLP5Bgm75dR8Xoa2Kq4j4+x8l0TcFz8t05cht3jLQuSHbU+oDqIDURKc=
Received: from DM6PR18MB3001.namprd18.prod.outlook.com (20.179.104.143) by
 DM6PR18MB3290.namprd18.prod.outlook.com (10.255.173.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Wed, 2 Oct 2019 09:23:00 +0000
Received: from DM6PR18MB3001.namprd18.prod.outlook.com
 ([fe80::11c2:98e0:b9d9:5dba]) by DM6PR18MB3001.namprd18.prod.outlook.com
 ([fe80::11c2:98e0:b9d9:5dba%5]) with mapi id 15.20.2305.023; Wed, 2 Oct 2019
 09:23:00 +0000
From: Jan Glauber <jglauber@marvell.com>
To: dann frazier <dann.frazier@canonical.com>
Subject: Re: [Qemu-devel] qemu_futex_wait() lockups in ARM64: 2 possible issues
Thread-Topic: [Qemu-devel] qemu_futex_wait() lockups in ARM64: 2 possible
 issues
Thread-Index: AQHVeQL8XqadU6+f8U6NPy661ojeeQ==
Date: Wed, 2 Oct 2019 09:23:00 +0000
Message-ID: <20191002092253.GA3857@hc>
References: <cbe46ad6-ef6c-d155-e79a-672182c725ad@ubuntu.com>
 <d94f18f1-986f-ec19-02c0-e83e5e7af3d0@redhat.com>
 <1864070a-2f84-1d98-341e-f01ddf74ec4b@ubuntu.com>
 <20190924202517.GA21422@xps13.dannf>
In-Reply-To: <20190924202517.GA21422@xps13.dannf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR0102CA0061.eurprd01.prod.exchangelabs.com
 (2603:10a6:208::38) To DM6PR18MB3001.namprd18.prod.outlook.com
 (2603:10b6:5:182::15)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [78.43.208.134]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bffda711-6cc9-480e-ffb1-08d7471a1e74
x-ms-traffictypediagnostic: DM6PR18MB3290:
x-microsoft-antispam-prvs: <DM6PR18MB3290DB837484FF82666FF649D89C0@DM6PR18MB3290.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0178184651
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(7916004)(39860400002)(136003)(366004)(396003)(376002)(346002)(189003)(199004)(8676002)(81166006)(66946007)(305945005)(446003)(14454004)(3846002)(66556008)(66476007)(6512007)(229853002)(6436002)(64756008)(476003)(54906003)(316002)(66446008)(6486002)(6116002)(8936002)(486006)(9686003)(478600001)(6916009)(33716001)(7736002)(81156014)(2906002)(256004)(186003)(14444005)(26005)(25786009)(1076003)(76176011)(11346002)(99286004)(66066001)(6246003)(102836004)(86362001)(5660300002)(52116002)(6506007)(4326008)(71200400001)(33656002)(71190400001)(386003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR18MB3290;
 H:DM6PR18MB3001.namprd18.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dkFu/i+oSw0YyBVc1oxxl9TzK6qcIlJlQ4MOWjWahtuxGu28hBCdm83NRTZAs8yTRElSQ6QPg9hOvv7Wb9eJqO59TMnKOzpMQ+Fw6fCbmxKYmoNm1tUmkc3BPvDHjnSoBN2dABYnzt7RgXj9JutcOeATY/MBwjKKqzQ3Xg/b9HuxO4AUGIJgpCVBuauHFQv1dImO6mZ7BGyJyZjQ/a7SRNRPsKWH0SRuawKYwEaczE3s64jJc1Wk9LZ4Ami7w3wMeHsV3G+cBVJM0hwhN6zuWkCvEysS8wtRyVvzDlXn+dSva/NEe4kH/ERsJv3bAu/gPxsJnsMOf3VGulhPXgwJstMPzyB8uc88sSqT2s0A+SaeECFJ1VRzCMbuDV9UBr8+lSw767EhzhaSJUO2BO1HsOx81zV0m2J75UR6gb4pCg0=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="UTF-8"
Content-ID: <1FD4BA8EBA5CC442B321978B006886BF@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: bffda711-6cc9-480e-ffb1-08d7471a1e74
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2019 09:23:00.3889 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T3Sfha8Auu03ksCtQBsRNkOhwm+fmQhbhJ0frj+Q2dIsSyumx2v0aMYQkUaVNm2xXjrAuB8n0LqhTP6nO4LSlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR18MB3290
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-02_04:2019-10-01,2019-10-02 signatures=0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 67.231.148.174
X-Mailman-Approved-At: Wed, 02 Oct 2019 08:27:28 -0400
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
 lizhengui <lizhengui@huawei.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Bug 1805256 <1805256@bugs.launchpad.net>, QEMU
 Developers - ARM <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20191002092300.4X18tbGm-3-xzCXbAg6AeZ3gKHWNbeAdanlqUTFtqTc@z>

I've looked into this on ThunderX2. The arm64 code generated for the
atomic_[add|sub] accesses of ctx->notify_me doesn't contain any
memory barriers. It is just plain ldaxr/stlxr.

From my understanding this is not sufficient for SMP sync.

If I read this comment correct:

    void aio_notify(AioContext *ctx)
    {
        /* Write e.g. bh->scheduled before reading ctx->notify_me.  Pairs
         * with atomic_or in aio_ctx_prepare or atomic_add in aio_poll.
         */
        smp_mb();
        if (ctx->notify_me) {

it points out that the smp_mb() should be paired. But as
I said the used atomics don't generate any barriers at all.

I've tried to verify me theory with this patch and didn't run into the
issue for ~500 iterations (usually I would trigger the issue ~20 iterations=
).

--Jan

diff --git a/util/aio-posix.c b/util/aio-posix.c
index d8f0cb4af8dd..d07dcd4e9993 100644
--- a/util/aio-posix.c
+++ b/util/aio-posix.c
@@ -591,6 +591,7 @@ bool aio_poll(AioContext *ctx, bool blocking)
      */
     if (blocking) {
         atomic_add(&ctx->notify_me, 2);
+        smp_mb();
     }
=20
     qemu_lockcnt_inc(&ctx->list_lock);
@@ -632,6 +633,7 @@ bool aio_poll(AioContext *ctx, bool blocking)
=20
     if (blocking) {
         atomic_sub(&ctx->notify_me, 2);
+        smp_mb();
     }
=20
     /* Adjust polling time */
diff --git a/util/async.c b/util/async.c
index 4dd9d95a9e73..92ac209c4615 100644
--- a/util/async.c
+++ b/util/async.c
@@ -222,6 +222,7 @@ aio_ctx_prepare(GSource *source, gint    *timeout)
     AioContext *ctx =3D (AioContext *) source;
=20
     atomic_or(&ctx->notify_me, 1);
+    smp_mb();
=20
     /* We assume there is no timeout already supplied */
     *timeout =3D qemu_timeout_ns_to_ms(aio_compute_timeout(ctx));
@@ -240,6 +241,7 @@ aio_ctx_check(GSource *source)
     QEMUBH *bh;
=20
     atomic_and(&ctx->notify_me, ~1);
+    smp_mb();
     aio_notify_accept(ctx);
=20
     for (bh =3D ctx->first_bh; bh; bh =3D bh->next) {

