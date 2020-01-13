Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F85C33CA8
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 09:17:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C629D2080D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 09:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="IKpZjNaR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C629D2080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iqvr6-0004jz-Rp
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 04:17:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55824)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <k.jensen@samsung.com>) id 1iqvqF-000453-G8
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 04:17:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <k.jensen@samsung.com>) id 1iqvqE-0006a7-3B
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 04:16:59 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:49287)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <k.jensen@samsung.com>)
 id 1iqvqD-0006Ki-Kr
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 04:16:58 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200113091651euoutp02aed7d140fd6e53b3d5fe942bfb8e013b~pZ4_oqPwq1025010250euoutp02I
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2020 09:16:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200113091651euoutp02aed7d140fd6e53b3d5fe942bfb8e013b~pZ4_oqPwq1025010250euoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1578907011;
 bh=BtzQ0VAfozo1yatC1RNIBWBM8pi+byKdbjrRQO6ISPo=;
 h=Date:From:To:CC:Subject:In-Reply-To:References:From;
 b=IKpZjNaRMHBbKRwhqMPV0zNCBCqGoXfBMV6LszjSB5QT8rj7ohYrTeI0ysV3A81jO
 KH8rD3C3V+3ETnkH0t6l0BTRElF3mJblyjMtXDrDpYZ6KF76mEG8sZmOmV5v1t6ttz
 s/FcNbDadOvXxoDpyTDWFCiTnFg5JKZ/sX5JGADg=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20200113091650eucas1p1e84c94483673332c90412e11b5420ba0~pZ4_gfEti0579705797eucas1p1f;
 Mon, 13 Jan 2020 09:16:50 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id 92.BD.60679.2853C1E5; Mon, 13
 Jan 2020 09:16:50 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200113091650eucas1p2da313c06aaf39a360fd02872752cf6ea~pZ4_LFTyD2570725707eucas1p2u;
 Mon, 13 Jan 2020 09:16:50 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20200113091650eusmtrp23d00c8ac37cf748cf42b768dd2dab0c8~pZ4_KeRgi3103131031eusmtrp2Q;
 Mon, 13 Jan 2020 09:16:50 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-ac-5e1c35826606
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 0B.18.08375.2853C1E5; Mon, 13
 Jan 2020 09:16:50 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200113091650eusmtip1c488163aa26274df721b0e61cd7fe84b~pZ4_D-aN63006330063eusmtip1C;
 Mon, 13 Jan 2020 09:16:50 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) by
 CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) with Microsoft SMTP
 Server (TLS) id 15.0.1320.4; Mon, 13 Jan 2020 09:16:49 +0000
Received: from apples.localdomain (106.110.32.41) by CAMSVWEXC01.scsc.local
 (106.1.227.71) with Microsoft SMTP Server (TLS) id 15.0.1320.4 via Frontend
 Transport; Mon, 13 Jan 2020 09:16:49 +0000
Date: Mon, 13 Jan 2020 10:16:48 +0100
From: Klaus Birkelund Jensen <k.jensen@samsung.com>
To: Beata Michalska <beata.michalska@linaro.org>
Subject: Re: [PATCH v4 19/24] nvme: handle dma errors
Message-ID: <20200113091648.bpg3lsvdnz7zhfam@apples.localdomain>
MIME-Version: 1.0
In-Reply-To: <CADSWDzvedgUVQQx0Pc6gw1hZVtDpOFayXRMUny-7PHf+oFga3g@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0iTYRTHefa+215nk9dN8qAjbN1I8pKXGEzMMmlfgoKCKNStfFFrXtjr
 vH3JVFInms5AnWWaoqaSMMuWhuVQpyReiiTsQhcTEm84c2g2cz4z/Pb/n/P/nXMeeChC1MX1
 ohKT0xhNskot5QnIrsG1Ub/cUElMYMWXE7LOuwVI9qpvlSvTmyeRrHGCkdVOHZAZFgp4MkuJ
 iYzgK0ZNY3yFsbWIp/g0+ZKnmJ7s5CgWe9/zznOvCMLiGHViOqMJCFcKEnKn9qX2CjNLjUOc
 HGQR6JALBXQIFPflc3VIQInoFgQD9gcENisI1svaETZWBPrSP5wdpPf+ghNpRtDS1EP+Txna
 TBxsRhDULlucsUEE5qJp0sGT9CGwdti2Z/HoYJjTNRMO7UEHgnXMxncABL2KYLxqFjkaYjoU
 bLqKbUBIR4B1uo7E2h2Gq/FQF/oCjH/+u70NaCMfnlRPOa89AzMDmyTWYpi1POVjLYHNFw85
 GChGULr0m8CmCkFlk42nQ9SWkUPpiNoBEHQitBtMzqGnYK38GxdH3ODDvDuOuIG+q5LAZSEU
 3hHh9GEw5T5DuCyBn+0+WCqgoSSkDO037HqMYdcqrI9BXc8yz7BFELQ3NNspLI9CR3dAHeK2
 Ik9GyybFM2xQMpPhz6qSWG1yvP/1lCQj2vpNb+yWFRPq3rhmRjSFpHuEr7O9Y0RcVTqblWRG
 QBFSD6Fx1CtGJIxTZWUzmpRYjVbNsGbkTZFST2Hwo1/RIjpelcbcZJhURrPT5VAuXjnIL7Mv
 s1FBnpPc1hbG+sC7vKj+kxti8+OLbmGsmpzwHZ4Pa1WOCY64DxFEZG67r+jyR7neNW+vIKov
 Ouq5fmrz7FJ624JG9vZW4+C6MnzRlan66uUp/h5pr8mouMrkKxfl9aeD7t2QL/cLatxFaWXF
 MwOXDpLlc6kN3PqlH5FSkk1QHfclNKzqH9+x1UlJAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIIsWRmVeSWpSXmKPExsVy+t/xu7pNpjJxBl+mKlps7m9ntNh/8Bur
 xaRD1xgtllxMtZh3S9li1rt2NovjvTtYHNg9zu04z+6xaVUnm8eda3vYPJ5c28zk8X7fVbYA
 1ig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jFM7
 z7AX/Oaq+LzKsYFxLkcXIyeHhICJxL4571i7GLk4hASWMkr8mreNFSIhI/Hpykd2CFtY4s+1
 LjaIoo+MEu9P/mCEcM4wSlw7+wgqc4xRYsGzS8wgLSwCqhKf139nArHZBIwl3nQtB4uLCBhI
 fD7/nR2kgVngG6PEnMmfGEESwgKmEt+7JoM18Ao4SHx+soAFYmo7k8Se1+uhEoISJ2c+YQGx
 mQV0JBbs/gS0mgPIlpZY/g/sIU6BQIkLd/+yTmAUmoWkYxaSjlkIHQsYmVcxiqSWFuem5xYb
 6hUn5haX5qXrJefnbmIERte2Yz8372C8tDH4EKMAB6MSD++BKuk4IdbEsuLK3EOMEhzMSiK8
 m85JxQnxpiRWVqUW5ccXleakFh9iNAUGwERmKdHkfGDk55XEG5oamltYGpobmxubWSiJ83YI
 HIwREkhPLEnNTk0tSC2C6WPi4JRqYEw12VTpLFpQ+HlalcfzHz5J5atYAs9dTV81j/OU84Zu
 93nBc6e6KE1wvSf9+Awzw+2PJ6fab3v88Gh97eWL0t9S3O6/E9gvs2LByqygzVx3eGfsnbBo
 9+ZfNrJB/H7fQqr19/W0TF3lU8pozjA7WFPdTrQz9kqUwaUqtgRmoziJ+vdSty8kLlJiKc5I
 NNRiLipOBABKMsHHxAIAAA==
X-CMS-MailID: 20200113091650eucas1p2da313c06aaf39a360fd02872752cf6ea
X-Msg-Generator: CA
Content-Type: multipart/mixed;
 boundary="----wuEC8jduJpGPgLKK9WIRscW_csS_daTJEwiPQviyXYkcG3WR=_1cbf52_"
X-RootMTR: 20191219130947eucas1p21cf4cec3d0b63850ab0e35aa5fab62b8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191219130947eucas1p21cf4cec3d0b63850ab0e35aa5fab62b8
References: <CGME20191219130947eucas1p21cf4cec3d0b63850ab0e35aa5fab62b8@eucas1p2.samsung.com>
 <20191219130921.309264-1-k.jensen@samsung.com>
 <20191219130921.309264-20-k.jensen@samsung.com>
 <CADSWDzvedgUVQQx0Pc6gw1hZVtDpOFayXRMUny-7PHf+oFga3g@mail.gmail.com>
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

------wuEC8jduJpGPgLKK9WIRscW_csS_daTJEwiPQviyXYkcG3WR=_1cbf52_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Jan  9 11:35, Beata Michalska wrote:
> Hi Klaus,
> 

Hi Beata,

Your reviews are, as always, much appreciated! Thanks!

> On Thu, 19 Dec 2019 at 13:09, Klaus Jensen <k.jensen@samsung.com> wrote:
> > @@ -1595,7 +1611,12 @@ static void nvme_process_sq(void *opaque)
> >
> >      while (!(nvme_sq_empty(sq) || QTAILQ_EMPTY(&sq->req_list))) {
> >          addr = sq->dma_addr + sq->head * n->sqe_size;
> > -        nvme_addr_read(n, addr, (void *)&cmd, sizeof(cmd));
> > +        if (nvme_addr_read(n, addr, (void *)&cmd, sizeof(cmd))) {
> > +            trace_nvme_dev_err_addr_read(addr);
> > +            timer_mod(sq->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
> > +                100 * SCALE_MS);
> > +            break;
> > +        }
> 
> Is there a chance we will end up repeatedly triggering the read error here
> as this will come back to the same memory location each time (the sq->head
> is not moving here) ?
> 

Absolutely, and that was the point. Not being able to read the
submission queue is pretty bad, so the device just keeps retrying every
100 ms. This is the same for when writing to the completion queue fails.

But... It would probably be prudent to track how long it has been since
a successful DMA transfer was done and timeout, shutting down the
device. Say maybe after 60 seconds. I'll try to add something like that.


Thanks,
Klaus

------wuEC8jduJpGPgLKK9WIRscW_csS_daTJEwiPQviyXYkcG3WR=_1cbf52_
Content-Type: text/plain; charset="utf-8"


------wuEC8jduJpGPgLKK9WIRscW_csS_daTJEwiPQviyXYkcG3WR=_1cbf52_--

