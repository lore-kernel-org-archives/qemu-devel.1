Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F29C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 07:29:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE11C20720
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 07:29:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="FhDGbvzw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE11C20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izbbP-0006Ak-3f
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 02:29:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59818)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <k.jensen@samsung.com>) id 1izbaN-0004va-G0
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 02:28:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <k.jensen@samsung.com>) id 1izbaM-0002ya-B4
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 02:28:27 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:53550)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <k.jensen@samsung.com>)
 id 1izbaM-0002y5-4o
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 02:28:26 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20200206072825euoutp01acd0d234be5d990f61baa032e59547c5~wv5KHtcIv1874418744euoutp01u
 for <qemu-devel@nongnu.org>; Thu,  6 Feb 2020 07:28:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20200206072825euoutp01acd0d234be5d990f61baa032e59547c5~wv5KHtcIv1874418744euoutp01u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1580974105;
 bh=DzVYFTv0KSnTjTBJib/EVPaTubaFdCDRlzUGtCzAODo=;
 h=Date:From:To:CC:Subject:In-Reply-To:References:From;
 b=FhDGbvzwSR5kPNdYEDxOQppzZ8qE0JtW2oMfKI3WVqmQ+gdbq0JXjFyhzXPXJrVfI
 o/jl4BGrIRKvDMiv3x7vORfn+Kde/7Xf8dpcPCr9z7DtN65HrKnciuu3WU651x1ubd
 4rei1ypo6wM2E8KSTWnLFgeErEI7IWv+hY+TK/HQ=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20200206072825eucas1p1c372d298791ffcc9ddc6d8aa9be576cc~wv5J8-s6z0428204282eucas1p16;
 Thu,  6 Feb 2020 07:28:25 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id C7.D4.60679.810CB3E5; Thu,  6
 Feb 2020 07:28:25 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200206072824eucas1p26038eeb397dc7c3fb486644e9d233a74~wv5JjQhwe0995309953eucas1p2r;
 Thu,  6 Feb 2020 07:28:24 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20200206072824eusmtrp290eb16fdc4630a81c33447f4dc474e2b~wv5JipWLG0457804578eusmtrp2K;
 Thu,  6 Feb 2020 07:28:24 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-97-5e3bc0187a70
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 3A.8A.07950.810CB3E5; Thu,  6
 Feb 2020 07:28:24 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20200206072824eusmtip282ba5f5f9eb13a547d2061517be68c2d~wv5JZh0d_0737307373eusmtip2K;
 Thu,  6 Feb 2020 07:28:24 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) by
 CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) with Microsoft SMTP
 Server (TLS) id 15.0.1320.4; Thu, 6 Feb 2020 07:28:24 +0000
Received: from apples.localdomain (106.110.32.41) by CAMSVWEXC01.scsc.local
 (106.1.227.71) with Microsoft SMTP Server (TLS) id 15.0.1320.4 via Frontend
 Transport; Thu, 6 Feb 2020 07:28:23 +0000
Date: Thu, 6 Feb 2020 08:28:22 +0100
From: Klaus Birkelund Jensen <k.jensen@samsung.com>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v5 24/26] nvme: change controller pci id
Message-ID: <20200206072822.6iyn7qfryu6waza6@apples.localdomain>
MIME-Version: 1.0
In-Reply-To: <20200204163547.GB6823@redsun51.ssa.fujisawa.hgst.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjm29nOzszZcRp701U6oxvlnZwXyqgfq1/RvxIvKw8qus02L1kY
 NmnaInUjUJdolrQUL+XUpnnJRVpoXjBnqVHBKvJSwmaahOZ2NPz3vM/tfT/4CIzXwvIiUmQZ
 lEImSRPiLsy2vj9DR3a+iIwLHKtHImNxARL19P5miXRmCxLVjFKiykk/kf5nAS7qv2NiRrPF
 Q6Zhtri57hYunrZ04mKrxcgQ/+oex8+yLrhEJVJpKVmUIuBYgktyZW1cunHblXfVNlYeKuJo
 EIcAMhTy5m24BrkQPPIxgoftc5hD4JF2BBUWPi3YEOTPNKLNRFd7AYMWDAiermjY/103qz4h
 ehhA0PBct1H8CoH2rtpZzCT3gmpMjTswTobAnMbg5D1JP/hYVc5yBDBHlc3avW4iCA8yCvTa
 VIeHS0ZDSeE0TmN3eFNuZTowhzwJy1q18wwgG9mgm+hh0ceeAo2hAaOxB8z0t7BpLIC19ioG
 HbiNoGhhEaOHMgSlj5acm4GMhKLBNEcAI5NBtbi0UXoCtK8X2LTFDd7Pu9MWN9C1lWI0zYVC
 NY927wOTqhXRtAC+1vvQtBjujffhJchXv+U1+i279OsJjDwITR0BNPQGwyqxhb2PWHWIT2Uq
 pUmUMlhGZfsrJVJlpizJ/5Jc2ozW/9LAar/dhDr+XjQjkkBCV27gbEQcjyXJUuZIzQgITOjJ
 HQ4Ij+NxEyU5VymFPF6RmUYpzcibYAr53JAHP2J5ZJIkg0qlqHRKsakyCI5XHqKW82u1TUdH
 pswRDZ/NKV+yOqtnjZdDaqrD2oOKW972BMvjb0Sqeg/vynXHn52PTYgf2m2Luc4/Prn/iW/2
 y67xPWi0tkzr6jG4sDbhYW+09bbWJXw4J7i2cqCNFA5oBYExcv3Ud6vNPnr6TOhIlM9a3/bF
 AVevbzvC1bkVYUN8IVOZLAk6hCmUkn8BUF7gRwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHIsWRmVeSWpSXmKPExsVy+t/xe7oSB6zjDE4fUbXY3N/OaLH/4DdW
 i0mHrjFaLLmYajHvlrLFrHftbBbHe3ewOLB7nNtxnt1j06pONo871/aweTy5tpnJ4/2+q2wB
 rFF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6GY9e
 v2Mu+MZRsWnNPMYGxldsXYycHBICJhJ7d7YzdTFycQgJLGWUmLFmNVRCRuLTlY/sELawxJ9r
 XWwQRR8ZJe5t6mACSQgJnGaU6FrsDpE4yiix8EcjC0iCRUBFoulyG9gkNgFjiTddy5lBbBEB
 ZYm782eygjQwC3xmlPiy/hvQJA4OYQEbiVkTs0FqeAUcJCZ03IHa9pNR4t2E/+wQCUGJkzOf
 sIDUMwtoSqzfpQ9hSkss/8cBUsEp4CzxY2Ib+wRGoVlIGmYhNMxCaFjAyLyKUSS1tDg3PbfY
 SK84Mbe4NC9dLzk/dxMjMK62Hfu5ZQdj17vgQ4wCHIxKPLwGr63ihFgTy4orcw8xSnAwK4nw
 nte3jBPiTUmsrEotyo8vKs1JLT7EaAr0/URmKdHkfGDM55XEG5oamltYGpobmxubWSiJ83YI
 HIwREkhPLEnNTk0tSC2C6WPi4JRqYNR24O4O22gzMax9yft/MzZ2TKhS7fT2uOj6oV66/I6W
 3fO1AU4mLLXGl96sKaiQ38G+Z1IXW9KaZb2zQuVFj+W5KDC/fPJwie/N5EXsHFPdNzoF/M9S
 Xd1Y+U0zl61p7VvGJQ9ui8cd+PY/7lSgBs+3KYVn/DtbVxaZ6c/ui7tz9+tmzmkc/EosxRmJ
 hlrMRcWJAMLGn+DBAgAA
X-CMS-MailID: 20200206072824eucas1p26038eeb397dc7c3fb486644e9d233a74
X-Msg-Generator: CA
Content-Type: multipart/mixed;
 boundary="----YylyyeIpAX4OpiHhpiXz1I5bEdvfH4tDCR882SzCOFpc-4tm=_3a06b_"
X-RootMTR: 20200204095231eucas1p21019b1d857fcda9d67950e7d01de6b6a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200204095231eucas1p21019b1d857fcda9d67950e7d01de6b6a
References: <20200204095208.269131-1-k.jensen@samsung.com>
 <CGME20200204095231eucas1p21019b1d857fcda9d67950e7d01de6b6a@eucas1p2.samsung.com>
 <20200204095208.269131-25-k.jensen@samsung.com>
 <20200204163547.GB6823@redsun51.ssa.fujisawa.hgst.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 210.118.77.11
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

------YylyyeIpAX4OpiHhpiXz1I5bEdvfH4tDCR882SzCOFpc-4tm=_3a06b_
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline

On Feb  5 01:35, Keith Busch wrote:
> On Tue, Feb 04, 2020 at 10:52:06AM +0100, Klaus Jensen wrote:
> > There are two reasons for changing this:
> > 
> >   1. The nvme device currently uses an internal Intel device id.
> > 
> >   2. Since commits "nvme: fix write zeroes offset and count" and "nvme:
> >      support multiple namespaces" the controller device no longer has
> >      the quirks that the Linux kernel think it has.
> > 
> >      As the quirks are applied based on pci vendor and device id, change
> >      them to get rid of the quirks.
> > 
> > To keep backward compatibility, add a new 'x-use-intel-id' parameter to
> > the nvme device to force use of the Intel vendor and device id. This is
> > off by default but add a compat property to set this for machines 4.2
> > and older.
> > 
> > Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> 
> Yay, thank you for following through on getting this identifier assigned.
> 
> Reviewed-by: Keith Busch <kbusch@kernel.org>

This is technically not "officially" sanctioned yet, but I got an
indication from Gerd that we are good to proceed with this.


------YylyyeIpAX4OpiHhpiXz1I5bEdvfH4tDCR882SzCOFpc-4tm=_3a06b_
Content-Type: text/plain; charset="utf-8"


------YylyyeIpAX4OpiHhpiXz1I5bEdvfH4tDCR882SzCOFpc-4tm=_3a06b_--

