Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F398C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 07:25:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC68A20720
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 07:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="IYmivchq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC68A20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izbXN-0002oN-Rx
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 02:25:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58395)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <k.jensen@samsung.com>) id 1izbWY-0002Ae-Nt
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 02:24:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <k.jensen@samsung.com>) id 1izbWW-00059Y-M6
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 02:24:30 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:55783)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <k.jensen@samsung.com>)
 id 1izbWW-0004p0-EM
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 02:24:28 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200206072424euoutp029f98d0a2ce3c4e28c4814b69a09f93c1~wv1pkawuH1827518275euoutp02l
 for <qemu-devel@nongnu.org>; Thu,  6 Feb 2020 07:24:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200206072424euoutp029f98d0a2ce3c4e28c4814b69a09f93c1~wv1pkawuH1827518275euoutp02l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1580973864;
 bh=gwTTEmHTrR3robbUxbfeNTzxffX5rDbL0Rk/sKX36Hs=;
 h=Date:From:To:CC:Subject:In-Reply-To:References:From;
 b=IYmivchq8DFMotuZLFVLKHdb9bTOCfTlJJzZxo9VbZ2mut1IbwdUeVCPaLeXFsA5o
 7LxmH3zJDUKK6YQiffZdXJy/ud+SpE67rnVVJQKg73GmywN8mB1IbkMukj1LaTWWzs
 /LOHDtTtlxgq5ToZweuePDRaPfbj3B9nesErMp+8=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20200206072423eucas1p1470f0a5d49ce8aed06eafc484ad1942e~wv1pXyxFr0485504855eucas1p1m;
 Thu,  6 Feb 2020 07:24:23 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id 0B.43.60698.72FBB3E5; Thu,  6
 Feb 2020 07:24:23 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200206072423eucas1p2095a4f5b4e5e23a162155274a05994ab~wv1osG2LR0438704387eucas1p2p;
 Thu,  6 Feb 2020 07:24:23 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200206072423eusmtrp1084585b26d699b368233ba8865462829~wv1oreYQZ2523225232eusmtrp1E;
 Thu,  6 Feb 2020 07:24:23 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-09-5e3bbf27e934
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id C0.8D.08375.72FBB3E5; Thu,  6
 Feb 2020 07:24:23 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20200206072423eusmtip2e59d03ee197360d3646a29aaa2153a2f~wv1oklOZU0847508475eusmtip2B;
 Thu,  6 Feb 2020 07:24:23 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) by
 CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) with Microsoft SMTP
 Server (TLS) id 15.0.1320.4; Thu, 6 Feb 2020 07:24:22 +0000
Received: from apples.localdomain (106.110.32.41) by CAMSVWEXC01.scsc.local
 (106.1.227.71) with Microsoft SMTP Server (TLS) id 15.0.1320.4 via Frontend
 Transport; Thu, 6 Feb 2020 07:24:22 +0000
Date: Thu, 6 Feb 2020 08:24:21 +0100
From: Klaus Birkelund Jensen <k.jensen@samsung.com>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v5 26/26] nvme: make lba data size configurable
Message-ID: <20200206072421.h3vjwelfod2y7nax@apples.localdomain>
MIME-Version: 1.0
In-Reply-To: <20200204164358.GC6823@redsun51.ssa.fujisawa.hgst.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKKsWRmVeSWpSXmKPExsWy7djPc7rq+63jDOY/M7bY3N/OaLH/4DdW
 i0mHrjFaLLmYajHvlrLFrHftbBbHe3ewOLB7nNtxnt1j06pONo871/aweTy5tpnJ4/2+q2wB
 rFFcNimpOZllqUX6dglcGQs777MW7BCsWLpoDXMDYz9fFyMnh4SAicTXjUfZuhi5OIQEVjBK
 vJk2mwnC+cIocf/bdWYI5zOjxOKXs4AcDrCWjtleEPHljBIfj3aywxVN3L6OFcI5zSjR+PoL
 E8gSIYGjjBILn/mA2CwCKhJXf3Uzg9hsAsYSb7qWg9kiAsoSd+fPBGtmBpn0+ck+NpCEsICz
 xMybv8BsXgEHib3rZrBA2IISJ2c+AbM5gWq2rjsM1iwhsIldYsrX3awQ77lITDp5gw3CFpZ4
 dXwLO4QtI3F6cg8LREM3o0Tfh6/MEM4MRonpy76zQXxqLdF3JgekgVkgQ2LNzz/MEM2OEheO
 X2KFKOGTuPFWEKKET2LStunQMOKV6GgTgqhWk9jRtJURIiwj8XSNAkTYQ+JixwnWCYyKs5B8
 MwvJrllAHcwCmhLrd+lDmNISy/9xIIkuYGRdxSieWlqcm55abJyXWq5XnJhbXJqXrpecn7uJ
 EZiYTv87/nUH474/SYcYBTgYlXh4DV5bxQmxJpYVV+YeYpTgYFYS4T2vbxknxJuSWFmVWpQf
 X1Sak1p8iFGag0VJnNd40ctYIYH0xJLU7NTUgtQimCwTB6dUAyPH6/Wt5Tc+BzX2BWqeKOT+
 1Xo2OuzhT88of5l1L8MnZ3O0f275dlveKL57v4fqloib65nMrufssd1pE2G4K6LO/qtW1x23
 hFWVwhFfCnwjOnT7dA1vLb9w/kTU2/6EE+KXLPfNXPjDLJi5tGBvzqFFbXosbOGsXr9kn68o
 L69bo7Tpy8r4V0osxRmJhlrMRcWJAF7GuYpIAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLIsWRmVeSWpSXmKPExsVy+t/xe7rq+63jDB5t4rLY3N/OaLH/4DdW
 i0mHrjFaLLmYajHvlrLFrHftbBbHe3ewOLB7nNtxnt1j06pONo871/aweTy5tpnJ4/2+q2wB
 rFF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6Gfe2
 HWAr+M1X8bj/L1MD42vuLkYODgkBE4mO2V5djJwcQgJLGSV+NOiB2BICMhKfrnxkh7CFJf5c
 62LrYuQCqvnIKHHiwwp2COc0o8SMx7uYILqPMkp83ckCYrMIqEhc/dXNDGKzCRhLvOlaDmaL
 CChL3J0/kxWkmVngM6PEl/XfwJqFBZwlZt78xQZi8wo4SOxdN4MFYsNPRol3+1awQCQEJU7O
 fMICcjazgKbE+l36EKa0xPJ/HCAVnEBjtq47zDqBUWgWkoZZCA2zEBoWMDKvYhRJLS3OTc8t
 NtQrTswtLs1L10vOz93ECIyqbcd+bt7BeGlj8CFGAQ5GJR5eg9dWcUKsiWXFlbmHGCU4mJVE
 eM/rW8YJ8aYkVlalFuXHF5XmpBYfYjQFen8is5Rocj4w4vNK4g1NDc0tLA3Njc2NzSyUxHk7
 BA7GCAmkJ5akZqemFqQWwfQxcXBKNTBqFnXUu+Se72dnc/iZZ5Ou6+Ru3s6lqKtqKnrK7eTW
 rFC/jQcebO/Q/PPyHIv3x/zmzVwecfWvDheLHVvw39dm1dRXwasXzmDf8N/X4DMf2zRVX/GM
 fwLaHb9WbuQxfH/ulXjSn0mG3FM4+F4tnB98a4mQ8eUp3I+eh4iLJeiteBPxO8Gm5b4SS3FG
 oqEWc1FxIgBD3jj0wAIAAA==
X-CMS-MailID: 20200206072423eucas1p2095a4f5b4e5e23a162155274a05994ab
X-Msg-Generator: CA
Content-Type: multipart/mixed;
 boundary="----hOJ5GdqmCD5HU0nivmTlpM5sy44LA-aRLVXr7mNKZTqSVN7p=_3a108_"
X-RootMTR: 20200204095232eucas1p2b3264104447a42882f10edb06608ece5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200204095232eucas1p2b3264104447a42882f10edb06608ece5
References: <20200204095208.269131-1-k.jensen@samsung.com>
 <CGME20200204095232eucas1p2b3264104447a42882f10edb06608ece5@eucas1p2.samsung.com>
 <20200204095208.269131-27-k.jensen@samsung.com>
 <20200204164358.GC6823@redsun51.ssa.fujisawa.hgst.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 210.118.77.12
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
Cc: Kevin Wolf <kwolf@redhat.com>, Beata Michalska <beata.michalska@linaro.org>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Javier Gonzalez <javier.gonz@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

------hOJ5GdqmCD5HU0nivmTlpM5sy44LA-aRLVXr7mNKZTqSVN7p=_3a108_
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline

On Feb  5 01:43, Keith Busch wrote:
> On Tue, Feb 04, 2020 at 10:52:08AM +0100, Klaus Jensen wrote:
> > Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> > ---
> >  hw/block/nvme-ns.c | 2 +-
> >  hw/block/nvme-ns.h | 4 +++-
> >  hw/block/nvme.c    | 1 +
> >  3 files changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/hw/block/nvme-ns.c b/hw/block/nvme-ns.c
> > index 0e5be44486f4..981d7101b8f2 100644
> > --- a/hw/block/nvme-ns.c
> > +++ b/hw/block/nvme-ns.c
> > @@ -18,7 +18,7 @@ static int nvme_ns_init(NvmeNamespace *ns)
> >  {
> >      NvmeIdNs *id_ns = &ns->id_ns;
> >  
> > -    id_ns->lbaf[0].ds = BDRV_SECTOR_BITS;
> > +    id_ns->lbaf[0].ds = ns->params.lbads;
> >      id_ns->nuse = id_ns->ncap = id_ns->nsze =
> >          cpu_to_le64(nvme_ns_nlbas(ns));
> >  
> > diff --git a/hw/block/nvme-ns.h b/hw/block/nvme-ns.h
> > index b564bac25f6d..f1fe4db78b41 100644
> > --- a/hw/block/nvme-ns.h
> > +++ b/hw/block/nvme-ns.h
> > @@ -7,10 +7,12 @@
> >  
> >  #define DEFINE_NVME_NS_PROPERTIES(_state, _props) \
> >      DEFINE_PROP_DRIVE("drive", _state, blk), \
> > -    DEFINE_PROP_UINT32("nsid", _state, _props.nsid, 0)
> > +    DEFINE_PROP_UINT32("nsid", _state, _props.nsid, 0), \
> > +    DEFINE_PROP_UINT8("lbads", _state, _props.lbads, BDRV_SECTOR_BITS)
> 
> I think we need to validate the parameter is between 9 and 12 before
> trusting it can be used safely.
> 
> Alternatively, add supported formats to the lbaf array and let the host
> decide on a live system with the 'format' command.

The device does not yet support Format NVM, but we have a patch ready
for that to be submitted with a new series when this is merged.

For now, while it does not support Format, I will change this patch such
that it defaults to 9 (BRDV_SECTOR_BITS) and only accept 12 as an
alternative (while always keeping the number of formats available to 1).

------hOJ5GdqmCD5HU0nivmTlpM5sy44LA-aRLVXr7mNKZTqSVN7p=_3a108_
Content-Type: text/plain; charset="utf-8"


------hOJ5GdqmCD5HU0nivmTlpM5sy44LA-aRLVXr7mNKZTqSVN7p=_3a108_--

