Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE27C33CA8
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 09:23:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08185207FF
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 09:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="dGYa5AH4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08185207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iqvwu-0007cH-3o
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 04:23:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57656)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <k.jensen@samsung.com>) id 1iqvwF-00077W-Sh
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 04:23:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <k.jensen@samsung.com>) id 1iqvwD-0000Ja-Eb
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 04:23:10 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:51646)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <k.jensen@samsung.com>)
 id 1iqvwC-0000Bb-O8
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 04:23:09 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200113092305euoutp02d701e9ac00fa423507a45ada81e4e977~pZ_a8oXhN1475014750euoutp02j
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2020 09:23:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200113092305euoutp02d701e9ac00fa423507a45ada81e4e977~pZ_a8oXhN1475014750euoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1578907385;
 bh=dehaiTptkf4XyEB/o4U356fTwCZPLU45Z4piSJhXos0=;
 h=Date:From:To:CC:Subject:In-Reply-To:References:From;
 b=dGYa5AH4FXY7phmoZBgZ4TS+VHmyGcU9AjnBb5LJD7k0n76ke0kwYwUm/Dej17p3g
 uY9jqpRvejZ0pMoVTg1m66CTK0GFfEHF1ksp9HKySf4Vomz+3GHstRHZqmRJoLTvlC
 T/g3yMIeze5JBZlkNkgU/Z0YJVWWS6ZSLG4KSWns=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200113092304eucas1p27b7bde7aa6f9f11843caf7572c073070~pZ_ayob7d3187231872eucas1p2G;
 Mon, 13 Jan 2020 09:23:04 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id D8.E6.61286.8F63C1E5; Mon, 13
 Jan 2020 09:23:04 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200113092304eucas1p2eebecc29a6ef499111921982b19f04b2~pZ_ag6own2323723237eucas1p2k;
 Mon, 13 Jan 2020 09:23:04 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20200113092304eusmtrp285a6d9d2efb59d58e55d4f6aca30d66c~pZ_aftHoR0250202502eusmtrp2U;
 Mon, 13 Jan 2020 09:23:04 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-7d-5e1c36f829ff
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 63.78.07950.8F63C1E5; Mon, 13
 Jan 2020 09:23:04 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20200113092304eusmtip241e80a6b46d51705a7b09377a75d9e21~pZ_aZft8B0041000410eusmtip2e;
 Mon, 13 Jan 2020 09:23:04 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) by
 CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) with Microsoft SMTP
 Server (TLS) id 15.0.1320.4; Mon, 13 Jan 2020 09:23:03 +0000
Received: from apples.localdomain (106.110.32.41) by CAMSVWEXC01.scsc.local
 (106.1.227.71) with Microsoft SMTP Server (TLS) id 15.0.1320.4 via Frontend
 Transport; Mon, 13 Jan 2020 09:23:03 +0000
Date: Mon, 13 Jan 2020 10:23:02 +0100
From: Klaus Birkelund Jensen <k.jensen@samsung.com>
To: Beata Michalska <beata.michalska@linaro.org>
Subject: Re: [PATCH v4 17/24] nvme: allow multiple aios per command
Message-ID: <20200113092302.rupgo5k7rnzaszqs@apples.localdomain>
MIME-Version: 1.0
In-Reply-To: <CADSWDztO1ffbXWnGAbaVLhXO4fYXsAbSUd-f7zQonDTRi8-n=A@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMKsWRmVeSWpSXmKPExsWy7djP87o/zGTiDJo3Glts7m9ntNh/8Bur
 xaRD1xgtllxMtZh3S9li1rt2NovjvTtYHNg9zu04z+6xaVUnm8eda3vYPJ5c28zk8X7fVbYA
 1igum5TUnMyy1CJ9uwSujOfT9jIXvBSvWPn2N0sD4ymhLkZODgkBE4mp5x8ydjFycQgJrGCU
 mH3lCTuE84VR4mLTKSjnM6PE7v4GFpiW6c3nWCASyxklVl3pYwVJgFV9PsIFkTjDKDHvXyMT
 ROIYo8SD96kgNouAqsTa1y3MIDabgLHEm67lYLaIgIHE5/PfwdYxC3xjlLgw4xUjSEJYwFmi
 e8oVsEG8Ag4Sr2e9Z4OwBSVOznwCdhKnQKDEyve9rCDNEgLr2CU2ff/DDHGri8TJ0x+g7haW
 eHV8CzuELSPxf+d8JoiGbkaJvg9fmSGcGYwS05d9B1rBAeRYS/SdyQExmQUyJVauVISIOkq0
 bcuGMPkkbrwVBJnIDGRO2jadGSLMK9HRBg1fNYkdTVsZIcIyEk/XKECEPSS+n2tim8CoOAvJ
 L7MQNs0Cm6kjsWD3JzaIsLTE8n8cEKamxPpd+gsYWVcxiqeWFuempxYb5qWW6xUn5haX5qXr
 JefnbmIEJqXT/45/2sH49VLSIUYBDkYlHt4DVdJxQqyJZcWVuYcYJTiYlUR4N52TihPiTUms
 rEotyo8vKs1JLT7EKM3BoiTOa7zoZayQQHpiSWp2ampBahFMlomDU6qBseT87KLw80ElS08E
 1nBfCtPeOiWv783NWaLdO7X+y92WXLynNFi2sChzr/s9b7uyWu1Jyc2sl8WObJ6qJFV8ipnj
 q+jf/KwZUtkuKqvXHWi17eUsm3BzwufyjFxf8fJFxQoaAsez+G41MOVP19BdHTl72Yzds89r
 3D4Zrf5mS/6RF3ePX85dpMRSnJFoqMVcVJwIAHtg4DlGAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEIsWRmVeSWpSXmKPExsVy+t/xe7o/zGTiDD7dUbLY3N/OaLH/4DdW
 i0mHrjFaLLmYajHvlrLFrHftbBbHe3ewOLB7nNtxnt1j06pONo871/aweTy5tpnJ4/2+q2wB
 rFF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6GYv6
 H7MULBOt2NP7ibmBcYFAFyMnh4SAicT05nMsXYxcHEICSxklHnXvYYZIyEh8uvKRHcIWlvhz
 rYsNougjo0TjjPnsEM4ZRomtXz8xQjjHGCU27OgFa2cRUJVY+7oFzGYTMJZ407UczBYRMJD4
 fP47WDezwDdGiTmTQbo5OYQFnCW6p1xhArF5BRwkXs96D7WvnUni3/1/bBAJQYmTM5+wgNjM
 AjoSC3Z/AopzANnSEsv/cYCEOQUCJVa+72WdwCg0C0nHLCQdsxA6FjAyr2IUSS0tzk3PLTbS
 K07MLS7NS9dLzs/dxAiMr23Hfm7Zwdj1LvgQowAHoxIP74Eq6Tgh1sSy4srcQ4wSHMxKIryb
 zknFCfGmJFZWpRblxxeV5qQWH2I0BQbARGYp0eR8YOznlcQbmhqaW1gamhubG5tZKInzdggc
 jBESSE8sSc1OTS1ILYLpY+LglGpgnMl6K5J9nZiNxd+U94rpkQoRU5pPNmxZ8bc+nXvOTbED
 ftxWF7cwGc5a+km1YtvjTY+2HLv3Ott34kHTbtUbhtMrwzKeunSu1dpy9P/MLNPNjGccPrA0
 tVz/z7Nq0R/3nJxr/Nc7+LV/nWGZHzenr6I/4nBMQ0vv1f3z/1tySpQ8+hNT4sFwQYmlOCPR
 UIu5qDgRAJ93TZHFAgAA
X-CMS-MailID: 20200113092304eucas1p2eebecc29a6ef499111921982b19f04b2
X-Msg-Generator: CA
Content-Type: multipart/mixed;
 boundary="----wuEC8jduJpGPgLKK9WIRscW_csS_daTJEwiPQviyXYkcG3WR=_1cc14e_"
X-RootMTR: 20191219130945eucas1p1cfffc6af127586ee24746beccbe993fb
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191219130945eucas1p1cfffc6af127586ee24746beccbe993fb
References: <CGME20191219130945eucas1p1cfffc6af127586ee24746beccbe993fb@eucas1p1.samsung.com>
 <20191219130921.309264-1-k.jensen@samsung.com>
 <20191219130921.309264-18-k.jensen@samsung.com>
 <CADSWDztO1ffbXWnGAbaVLhXO4fYXsAbSUd-f7zQonDTRi8-n=A@mail.gmail.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Keith Busch <kbusch@kernel.org>,
 Javier Gonzalez <javier.gonz@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

------wuEC8jduJpGPgLKK9WIRscW_csS_daTJEwiPQviyXYkcG3WR=_1cc14e_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Jan  9 11:40, Beata Michalska wrote:
> Hi Klaus,
> 
> On Thu, 19 Dec 2019 at 13:09, Klaus Jensen <k.jensen@samsung.com> wrote:
> > +static NvmeAIO *nvme_aio_new(BlockBackend *blk, int64_t offset, size_t len,
> > +    QEMUSGList *qsg, QEMUIOVector *iov, NvmeRequest *req,
> > +    NvmeAIOCompletionFunc *cb)
> 
> Minor: The indentation here (and in a few other places across the patchset)
> does not seem right . And maybe inline ?

I tried to follow the style in CODING_STYLE.rst for "Multiline Indent",
but how the style is for function definition is a bit underspecified.

I can change it to align with the opening paranthesis. I just found the
"one indent" more readable for these long function definitions.

> Also : seems that there are cases when some of the parameters are
> not required (NULL) , maybe having a simplified version for those cases
> might be useful ?
> 

True. Actually - at this point in the series there are no users of the
NvmeAIOCompletionFunc. It is preparatory for other patches I have in the
pipeline. But I'll clean it up.

> > +static void nvme_aio_cb(void *opaque, int ret)
> > +{
> > +    NvmeAIO *aio = opaque;
> > +    NvmeRequest *req = aio->req;
> > +
> > +    BlockBackend *blk = aio->blk;
> > +    BlockAcctCookie *acct = &aio->acct;
> > +    BlockAcctStats *stats = blk_get_stats(blk);
> > +
> > +    Error *local_err = NULL;
> > +
> > +    trace_nvme_dev_aio_cb(nvme_cid(req), aio, blk_name(blk), aio->offset,
> > +        nvme_aio_opc_str(aio), req);
> > +
> > +    if (req) {
> > +        QTAILQ_REMOVE(&req->aio_tailq, aio, tailq_entry);
> > +    }
> > +
> >      if (!ret) {
> > -        block_acct_done(blk_get_stats(n->conf.blk), &req->acct);
> > -        req->status = NVME_SUCCESS;
> > +        block_acct_done(stats, acct);
> > +
> > +        if (aio->cb) {
> > +            aio->cb(aio, aio->cb_arg);
> 
> We are dropping setting status to SUCCESS here,
> is that expected ?

Yes, that is on purpose. nvme_aio_cb is called for *each* issued AIO and
we do not want to overwrite a previously set error status with a success
(if one aio in the request fails even though others succeed, it should
not go unnoticed). Note that NVME_SUCCESS is the default setting in the
request, so if no one sets an error code we are still good.

> Also the aio callback will not get
> called case failure and it probably should ?
> 

I tried both but ended up with just not calling it on failure, but I
think that in the future some AIO callbacks might want to take a
different action if the request failed, so I'll add it back in an add
the aio return value (ret) to the callback function definition.


Thanks,
Klaus

------wuEC8jduJpGPgLKK9WIRscW_csS_daTJEwiPQviyXYkcG3WR=_1cc14e_
Content-Type: text/plain; charset="utf-8"


------wuEC8jduJpGPgLKK9WIRscW_csS_daTJEwiPQviyXYkcG3WR=_1cc14e_--

