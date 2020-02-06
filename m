Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD64FC2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 07:30:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7600A214AF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 07:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="BCkm6qlW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7600A214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izbcU-0007O0-LG
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 02:30:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60116)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <k.jensen@samsung.com>) id 1izbbj-0006md-1a
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 02:29:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <k.jensen@samsung.com>) id 1izbbh-0004WY-UH
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 02:29:50 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:53909)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <k.jensen@samsung.com>)
 id 1izbbh-0004Uc-Nq
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 02:29:49 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20200206072948euoutp01ae1c579f5dd3d058c6cda6e0445c52ed~wv6XQrLRh1869818698euoutp01X
 for <qemu-devel@nongnu.org>; Thu,  6 Feb 2020 07:29:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20200206072948euoutp01ae1c579f5dd3d058c6cda6e0445c52ed~wv6XQrLRh1869818698euoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1580974188;
 bh=h8R9x3j3ck3BIJbJ3TIJ+ph5UsegLPsA/JiKVSZAfhY=;
 h=Date:From:To:CC:Subject:In-Reply-To:References:From;
 b=BCkm6qlWsk+sXDa74BXKDu80NGCS26yB+HXVxDTkwHu5gxaUzBe7A0W/UcAgs6Exz
 BFPodWKwNmvRH1aV0oxOkEHvqjkXggbKXBa1JwrLDaP3GnBWr75joJVBx/kyvhcGKv
 alZ8xrQ8ta4/QC3bwgbZmonX4ZTE8ICS0mwhOjpU=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200206072947eucas1p2dd18824e3a2c4b9a737d0c662b137a3e~wv6XJxxwQ2534125341eucas1p2d;
 Thu,  6 Feb 2020 07:29:47 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id 6B.91.61286.B60CB3E5; Thu,  6
 Feb 2020 07:29:47 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20200206072947eucas1p1c4248f27ace3639d0e5952d5d04b3824~wv6WzYwRv0684506845eucas1p1R;
 Thu,  6 Feb 2020 07:29:47 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200206072947eusmtrp1eb99429be2a28c1f4d353ca45d1a17b3~wv6Wyxj3D2838628386eusmtrp1q;
 Thu,  6 Feb 2020 07:29:47 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-56-5e3bc06bfa3a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id B1.0E.08375.B60CB3E5; Thu,  6
 Feb 2020 07:29:47 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20200206072947eusmtip20af4b4d4b5f7aa03f46d6f49ea128e8a~wv6WncguG1123611236eusmtip2I;
 Thu,  6 Feb 2020 07:29:47 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) by
 CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) with Microsoft SMTP
 Server (TLS) id 15.0.1320.4; Thu, 6 Feb 2020 07:29:47 +0000
Received: from apples.localdomain (106.110.32.41) by CAMSVWEXC01.scsc.local
 (106.1.227.71) with Microsoft SMTP Server (TLS) id 15.0.1320.4 via Frontend
 Transport; Thu, 6 Feb 2020 07:29:46 +0000
Date: Thu, 6 Feb 2020 08:29:45 +0100
From: Klaus Birkelund Jensen <k.jensen@samsung.com>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v5 00/26] nvme: support NVMe v1.3d, SGLs and multiple
 namespaces
Message-ID: <20200206072945.6ik26f2madn2fqc6@apples.localdomain>
MIME-Version: 1.0
In-Reply-To: <20200204164710.GD6823@redsun51.ssa.fujisawa.hgst.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOKsWRmVeSWpSXmKPExsWy7djP87rZB6zjDOZuMbPY3N/OaLH/4DdW
 i0mHrjFaLLmYajHvlrLFrHftbBbHe3ewOLB7nNtxnt1j06pONo871/aweTy5tpnJ4/2+q2wB
 rFFcNimpOZllqUX6dglcGQe+bmAt+MdZcffsetYGxr/sXYycHBICJhJTZk5n6WLk4hASWMEo
 8eD1N2YI5wujxNElD1khnM+MEkun7GOEadl/6TQjRGI5o8ScWy2McFUnbp2BGnYayJl/HKr/
 KKPE1ZenwPpZBFQkDlz+xAxiswkYS7zpWg5miwgoS9ydPxOsgRlk1Ocn+9hAEsICYRI3Z0wH
 u5dXwEHi45zbzBC2oMTJmU9YQGxOAWeJSW83g62WEFjHLnFoZR8rxLUuEivubGaBsIUlXh3f
 AvW4jMTpyT1QDd2MEn0fvjJDODMYJaYv+w60mgPIsZboO5MD0sAskCFxtnctNAgcJVZ9ewRV
 widx460gRAmfxKRt05khwrwSHW1CENVqEjuatjJChGUknq5RgAh7SJz6eYppAqPiLCTfzEKy
 axZQB7OApsT6XfoQprTE8n8cSKILGFlXMYqnlhbnpqcWG+allusVJ+YWl+al6yXn525iBCan
 0/+Of9rB+PVS0iFGAQ5GJR5eg9dWcUKsiWXFlbmHGCU4mJVEeM/rW8YJ8aYkVlalFuXHF5Xm
 pBYfYpTmYFES5zVe9DJWSCA9sSQ1OzW1ILUIJsvEwSnVwOi95cdrlqi0iJ3ajmarI8y9Th5Q
 vH/2zJ5ZrD6iH0PW84v7FZyInxl+hW9+edJhX33D4362CZHTJ3g/aP+zcIqb6BfX/bWiv4W7
 5jw884Ax7MvMdCbmysssRxY9f7pJZs+m9fslG+ZYtqdO3RMr/OfAVYtpzhO+Br0v/HTqxjeG
 5bfCM3pEu5YpsRRnJBpqMRcVJwIAl/MiOkoDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAIsWRmVeSWpSXmKPExsVy+t/xe7rZB6zjDE7fl7XY3N/OaLH/4DdW
 i0mHrjFaLLmYajHvlrLFrHftbBbHe3ewOLB7nNtxnt1j06pONo871/aweTy5tpnJ4/2+q2wB
 rFF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6GV/P
 3mQuOMhece3OHdYGxpusXYycHBICJhL7L51m7GLk4hASWMoosaN/NRtEQkbi05WP7BC2sMSf
 a11sEEUfGSWOXr7NAuGcZpT4v3o2K4RzlFHi2qTXLCAtLAIqEgcuf2IGsdkEjCXedC0Hs0UE
 lCXuzp8J1sAs8JlR4sv6b0wgCWGBMImbM6aD7eMVcJD4OOc2M8TU44wS7Q8eQyUEJU7OfAK0
 gQOoW1Ni/S59CFNaYvk/DpAKTgFniUlvN7NMYBSahaRhFkLDLISGBYzMqxhFUkuLc9Nziw31
 ihNzi0vz0vWS83M3MQJja9uxn5t3MF7aGHyIUYCDUYmH1+C1VZwQa2JZcWXuIUYJDmYlEd7z
 +pZxQrwpiZVVqUX58UWlOanFhxhNgd6fyCwlmpwPjPu8knhDU0NzC0tDc2NzYzMLJXHeDoGD
 MUIC6YklqdmpqQWpRTB9TBycUg2Ms4tFhSLblKa2zC7v/Tbh6L/joqdX/PBZlL01wuy7307R
 J+crJLwDtUpCGu+ZiRpt0WWsFpPxdWb8lrL/8LJbjCGdzbnix2Ms1vee4nU4se7ZR0P2WQ+8
 Z/w79D9oMcsFpkc2hz1yn9nO+JqmfzPQ4k2AnvADbXmTsDrOeWEzWxMCHZ7tf3dRiaU4I9FQ
 i7moOBEA9JfZXcMCAAA=
X-CMS-MailID: 20200206072947eucas1p1c4248f27ace3639d0e5952d5d04b3824
X-Msg-Generator: CA
Content-Type: multipart/mixed;
 boundary="----YylyyeIpAX4OpiHhpiXz1I5bEdvfH4tDCR882SzCOFpc-4tm=_3a0ae_"
X-RootMTR: 20200204095215eucas1p1bb0d5a3c183f7531d8b0e5e081f1ae6b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200204095215eucas1p1bb0d5a3c183f7531d8b0e5e081f1ae6b
References: <CGME20200204095215eucas1p1bb0d5a3c183f7531d8b0e5e081f1ae6b@eucas1p1.samsung.com>
 <20200204095208.269131-1-k.jensen@samsung.com>
 <20200204164710.GD6823@redsun51.ssa.fujisawa.hgst.com>
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

------YylyyeIpAX4OpiHhpiXz1I5bEdvfH4tDCR882SzCOFpc-4tm=_3a0ae_
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline

On Feb  5 01:47, Keith Busch wrote:
> On Tue, Feb 04, 2020 at 10:51:42AM +0100, Klaus Jensen wrote:
> > Hi,
> > 
> > 
> > Changes since v4
> >  - Changed vendor and device id to use a Red Hat allocated one. For
> >    backwards compatibility add the 'x-use-intel-id' nvme device
> >    parameter. This is off by default but is added as a machine compat
> >    property to be true for machine types <= 4.2.
> > 
> >  - SGL mapping code has been refactored.
> 
> Looking pretty good to me. For the series beyond the individually
> reviewed patches:
> 
> Acked-by: Keith Busch <kbusch@kernel.org>
> 
> If you need to send a v5, you may add my tag to the patches that are not
> substaintially modified if you like.

I'll send a v6 with the changes to "nvme: make lba data size
configurable". It won't be substantially changed, I will just only
accept 9 and 12 as valid values for lbads.

Thanks for the Ack's and Reviews Keith!


Klaus

------YylyyeIpAX4OpiHhpiXz1I5bEdvfH4tDCR882SzCOFpc-4tm=_3a0ae_
Content-Type: text/plain; charset="utf-8"


------YylyyeIpAX4OpiHhpiXz1I5bEdvfH4tDCR882SzCOFpc-4tm=_3a0ae_--

