Return-Path: <SRS0=JFFZ=XX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C08C4360C
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Sep 2019 13:33:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7D7020815
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Sep 2019 13:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="jN1tftt4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7D7020815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iECqS-0005mQ-Of
	for qemu-devel@archiver.kernel.org; Sat, 28 Sep 2019 09:33:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41243)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1iECjS-0003mc-V6
 for qemu-devel@nongnu.org; Sat, 28 Sep 2019 09:25:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lukasstraub2@web.de>) id 1iECjR-0004L0-Cu
 for qemu-devel@nongnu.org; Sat, 28 Sep 2019 09:25:54 -0400
Received: from mout.web.de ([212.227.17.11]:39169)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lukasstraub2@web.de>) id 1iECjR-0004JG-41
 for qemu-devel@nongnu.org; Sat, 28 Sep 2019 09:25:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1569677122;
 bh=7X3V7zuQYLw/MctBK1rKnYf1Wm+N/ho6EB/OJLF2gno=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=jN1tftt4gsuM9FEZ/REchiGyQUajouc5g04sR2tk3Ys5u1wAwBo9fr5pjzqsbJuZi
 pYv3aUOIDyveY2mPuWHh55eku9rBV60ZwGx6fK5CqpcjeVGtMwTgqV8RwfiyG5URRw
 iEqVxKul+tPnGRSHtV8ncpcCChJjwPjeICfkg8qs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([88.130.61.13]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MLPaA-1iDeUd3sgM-000fog; Sat, 28
 Sep 2019 15:25:22 +0200
Date: Sat, 28 Sep 2019 13:07:25 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: "Zhang, Chen" <chen.zhang@intel.com>
Subject: Re: [PATCH v5 2/4] tests/test-replication.c: Add test for ignoring
 requests after failover
Message-ID: <20190928130628.38407661@luklap>
In-Reply-To: <9CFF81C0F6B98A43A459C9EDAD400D780627E731@shsmsx102.ccr.corp.intel.com>
References: <cover.1568574478.git.lukasstraub2@web.de>
 <e3f1e1ec5b2bd2ce2c9a6c7669284a3fc2fdbaaa.1568574478.git.lukasstraub2@web.de>
 <9CFF81C0F6B98A43A459C9EDAD400D780627E731@shsmsx102.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pYXit2eoDG0oqP0oMhz5U8bTmdEJfhi6uZ5P56gxTgmiB2xyPEj
 NWIhN91GKhUWPUv6WTSS8Y4RDtlBev4JTYX3JpG7v+3Q08qu0yorqlYLNvwQg+M31pMDecD
 VGGqqa+dAMF0uYVvQ73ZhuV3GT27sSK/oSCRAMEfOcLMeEMIxpJRP/ip4duoWhtuhkqzx6f
 udDO2220y5+THlRMD341Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QctJ3ButgSM=:cK/DLp4pKsYZcvkwMnVzdj
 PB35zyqzC7QUFC1BTZdRH6IOLMNCwzeFktD+dfPKcNhNdWD0binoKnYgpDO870Etmwe9Oovpy
 gt7HUQnVh8t9132e0USLBnDYwKK1vBhmzHih/nZ7SSNlLFFMMEZMWSKXY2DiG0ZKSioxgyRTv
 byijHpt4RvNdjBZFEbBZNXYSc100L9UAviGpVj9Uo6AGV//DHY1UjepPqAqkYoutDxtJgay6h
 l1EKl1m3LKTI/wJoas+tl0wuNXdLMDHIx/O6uIY/yjwteYHQVfVqvMo05kraR0A8tpdPLrhfz
 oXwG+NzEWa/SRKKU5GqNmUY1sxNnBnmS85V/qx2k0CmuiV2z76oOqqh6cxOPFAqT5h8btMlmS
 VB386U5JXmBINfaVr1YZyFGrfE7jOvI/XdtmasG7u92Y2L/v/bFktn1IVgxQJzdmmRC/SdkdK
 03WiSphYefVqbIKU3X+EZzmrdcHQx/vGevNcIGGIY1FVMD40f4MKuRw0Bxff/sfNPbMlju+3c
 Sn496MsW6y5WSEZZIm4GL4Oa8HvyJNXXeJdtZoIZLsRzJGdndwPGywTGj+Kfp4QHDQsY9gGRO
 7gqU6w9bB6p4Vgi7/qTtf2dhQNbzQzUPRSt4SZu6dxwwP0WdgP3ew786wCqDF1TIE1MC7+uKR
 +fmnr41DleSudSytyzZa5MXakTPu+h4MFXrGEi2/4hRP4O5MVrS7/f2umQNVV8c1GGTQiGg1/
 BUyHNOBzCoDnqj9I1QPxFGodaf6ranho4J64XIpFFlwh3jY6z6IhwK/YeeRDcQ/bwuM29OM9j
 XOYjo3EKf6iCy+VhNgRaOKFoU4YtBnWDY2ZWq0oBqq3DxQc2SohGZePNjJJxTAa2UY4zI0zVC
 MRM7Llgp2mbgmqNwyeliFJ1UAR0zuEicmYn0rJexa26Tfo0XHAJWz+naQv4I4fumqU5USL8i6
 Kwp0KJdomyqKADhl1fqlv7aHFE71Axx1cacOWVeqvEquMxk9klkuzDpRlk3olSBWOlE+Fo0Dg
 y4ogeGWtBs56drSkPLLx1NxhBBRUI84uBsztl1hRmb32Khhg23joW91r3xzr1LSqFVDno5Syk
 ySs7rfqaWcxryA9GRGNRwdfo7JrgAuXb3FcOt0/DhMf8oEMBT/RPKrv1g5SoITMzpAFQb688F
 ZmvngnDlJAN4XTS3BCCT+cGZfBRqj5FWBzTt987yucBDBVyCXqVap73ACa6SJAAUz63GiqvP/
 Yt6qIyi0Kl7M14fVDjONLpxFyKhxHUVri7IKWBqJY6wtAcA4dO2DkvLaMXyI=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.17.11
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, "mreitz@redhat.com" <mreitz@redhat.com>,
 Xie Changlong <xiechanglong.d@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 26 Sep 2019 17:40:03 +0000
"Zhang, Chen" <chen.zhang@intel.com> wrote:

> > -----Original Message-----
> > From: Lukas Straub <lukasstraub2@web.de>
> > Sent: Monday, September 16, 2019 3:20 AM
> > To: qemu-devel <qemu-devel@nongnu.org>
> > Cc: Zhang, Chen <chen.zhang@intel.com>; Jason Wang
> > <jasowang@redhat.com>; Wen Congyang <wencongyang2@huawei.com>;
> > Xie Changlong <xiechanglong.d@gmail.com>; kwolf@redhat.com;
> > mreitz@redhat.com
> > Subject: [PATCH v5 2/4] tests/test-replication.c: Add test for ignorin=
g
> > requests after failover
> >
> > This simulates the case that happens when we resume COLO after failove=
r.
> >
>
> It looks change the title to "Add test for secondary node continuous bac=
kup" is better.

Did you mean "continuous replication"? Would "Add test for secondary node =
continuing replication" be Ok?

> > Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> > ---
> >  tests/test-replication.c | 52
> > ++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 52 insertions(+)
> >
> > diff --git a/tests/test-replication.c b/tests/test-replication.c index
> > f085d1993a..5addfc2227 100644
> > --- a/tests/test-replication.c
> > +++ b/tests/test-replication.c
> > @@ -489,6 +489,56 @@ static void test_secondary_stop(void)
> >      teardown_secondary();
> >  }
> >
> > +static void test_secondary_failover_then_ignore_requests(void)
>
> Same as title, I think change to "test_secondary_continuous_backup" is m=
ore clear.
>
> Thanks
> Zhang Chen
>
> > +{
> > +    BlockBackend *top_blk, *local_blk;
> > +    Error *local_err =3D NULL;
> > +
> > +    top_blk =3D start_secondary();
> > +    replication_start_all(REPLICATION_MODE_SECONDARY, &local_err);
> > +    g_assert(!local_err);
> > +
> > +    /* write 0x22 to s_local_disk (IMG_SIZE / 2, IMG_SIZE) */
> > +    local_blk =3D blk_by_name(S_LOCAL_DISK_ID);
> > +    test_blk_write(local_blk, 0x22, IMG_SIZE / 2, IMG_SIZE / 2, false=
);
> > +
> > +    /* replication will backup s_local_disk to s_hidden_disk */
> > +    test_blk_read(top_blk, 0x11, IMG_SIZE / 2,
> > +                  IMG_SIZE / 2, 0, IMG_SIZE, false);
> > +
> > +    /* write 0x33 to s_active_disk (0, IMG_SIZE / 2) */
> > +    test_blk_write(top_blk, 0x33, 0, IMG_SIZE / 2, false);
> > +
> > +    /* do failover (active commit) */
> > +    replication_stop_all(true, &local_err);
> > +    g_assert(!local_err);
> > +
> > +    /* it should ignore all requests from now on */
> > +
> > +    /* start after failover */
> > +    replication_start_all(REPLICATION_MODE_PRIMARY, &local_err);
> > +    g_assert(!local_err);
> > +
> > +    /* checkpoint */
> > +    replication_do_checkpoint_all(&local_err);
> > +    g_assert(!local_err);
> > +
> > +    /* stop */
> > +    replication_stop_all(true, &local_err);
> > +    g_assert(!local_err);
> > +
> > +    /* read from s_local_disk (0, IMG_SIZE / 2) */
> > +    test_blk_read(top_blk, 0x33, 0, IMG_SIZE / 2,
> > +                  0, IMG_SIZE / 2, false);
> > +
> > +
> > +    /* read from s_local_disk (IMG_SIZE / 2, IMG_SIZE) */
> > +    test_blk_read(top_blk, 0x22, IMG_SIZE / 2,
> > +                  IMG_SIZE / 2, 0, IMG_SIZE, false);
> > +
> > +    teardown_secondary();
> > +}
> > +
> >  static void test_secondary_do_checkpoint(void)
> >  {
> >      BlockBackend *top_blk, *local_blk;
> > @@ -584,6 +634,8 @@ int main(int argc, char **argv)
> >      g_test_add_func("/replication/secondary/write", test_secondary_wr=
ite);
> >      g_test_add_func("/replication/secondary/start", test_secondary_st=
art);
> >      g_test_add_func("/replication/secondary/stop",  test_secondary_st=
op);
> > +
> > g_test_add_func("/replication/secondary/failover_then_ignore_requests"=
,
> > +                    test_secondary_failover_then_ignore_requests);
> >      g_test_add_func("/replication/secondary/do_checkpoint",
> >                      test_secondary_do_checkpoint);
> >      g_test_add_func("/replication/secondary/get_error_all",
> > --
> > 2.20.1
>


