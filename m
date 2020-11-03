Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8194C388F9
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 21:22:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30544206B5
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 21:22:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30544206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka3kp-00055w-0R
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 16:22:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55630)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <remi@remlab.net>)
 id 1ka3jw-0004W2-2s; Tue, 03 Nov 2020 16:21:16 -0500
Received: from poy.remlab.net ([2001:41d0:2:5a1a::]:57462
 helo=ns207790.ip-94-23-215.eu)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <remi@remlab.net>)
 id 1ka3js-00068e-7E; Tue, 03 Nov 2020 16:21:15 -0500
Received: from basile.remlab.net (dzyqn8ypzhx7l91mxjsvy-3.rev.dnainternet.fi
 [IPv6:2001:14ba:a01a:be01:9434:f69e:d553:3be2])
 (Authenticated sender: remi)
 by ns207790.ip-94-23-215.eu (Postfix) with ESMTPSA id 6A1465FB6A;
 Tue,  3 Nov 2020 22:21:08 +0100 (CET)
From: =?ISO-8859-1?Q?R=E9mi?= Denis-Courmont <remi.denis.courmont@huawei.com>
To: qemu-arm@nongnu.org
Subject: Re: [PATCH 10/14] target/arm: do S1_ptw_translate() before address
 space lookup
Date: Tue, 03 Nov 2020 23:21:05 +0200
Message-ID: <1855963.usQuhbGJ8B@basile.remlab.net>
Organization: Huawei Technologies, Finland
In-Reply-To: <8ebcf033-7044-ee14-8b84-3812ff041d5c@linaro.org>
References: <2172054.ElGaqSPkdT@basile.remlab.net>
 <20201102105802.39332-10-remi.denis.courmont@huawei.com>
 <8ebcf033-7044-ee14-8b84-3812ff041d5c@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2001:41d0:2:5a1a::; envelope-from=remi@remlab.net;
 helo=ns207790.ip-94-23-215.eu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 16:21:09
X-ACL-Warn: Detected OS   = ???
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le tiistaina 3. marraskuuta 2020, 21.54.48 EET Richard Henderson a =C3=A9cr=
it :
> On 11/2/20 2:57 AM, remi.denis.courmont@huawei.com wrote:
> > From: R=C3=A9mi Denis-Courmont <remi.denis.courmont@huawei.com>
> >=20
> > In the secure stage 2 translation regime, the VSTCR.SW and VTCR.NSW
> > bits can invert the secure flag for pagetable walks. This patchset
> > allows S1_ptw_translate() to change the non-secure bit.
> >=20
> > Signed-off-by: R=C3=A9mi Denis-Courmont <remi.denis.courmont@huawei.com>
> > ---
> >=20
> >  target/arm/helper.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/target/arm/helper.c b/target/arm/helper.c
> > index 4c86e4f57c..7c70460e65 100644
> > --- a/target/arm/helper.c
> > +++ b/target/arm/helper.c
> > @@ -10403,7 +10403,7 @@ static bool get_level1_table_address(CPUARMState
> > *env, ARMMMUIdx mmu_idx,>=20
> >  /* Translate a S1 pagetable walk through S2 if needed.  */
> >  static hwaddr S1_ptw_translate(CPUARMState *env, ARMMMUIdx mmu_idx,
> >=20
> > -                               hwaddr addr, MemTxAttrs txattrs,
> > +                               hwaddr addr, bool *is_secure,
> >=20
> >                                 ARMMMUFaultInfo *fi)
> > =20
> >  {
> > =20
> >      ARMMMUIdx s2_mmu_idx;
> >=20
> > @@ -10415,6 +10415,9 @@ static hwaddr S1_ptw_translate(CPUARMState *env,
> > ARMMMUIdx mmu_idx,>=20
> >          int s2prot;
> >          int ret;
> >          ARMCacheAttrs cacheattrs =3D {};
> >=20
> > +        MemTxAttrs txattrs =3D {};
> > +
> > +        assert(!*is_secure); /* TODO: S-EL2 */
>=20
> Are you sure that you don't want to pass in txattrs via pointer instead?

That's possible too, and more like the existing code. Though I thought it=20
clearer to pass only a pointer to the secure bit in/out, seen as that's the=
=20
only in/out parameter.

> This change by itself looks questionable.  I guess I'll have to look
> forward to the other patch...


=2D-=20
R=C3=A9mi Denis-Courmont



