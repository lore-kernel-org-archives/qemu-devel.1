Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5541AC2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 07:28:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E9C820720
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 07:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ospED/Nb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E9C820720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izba1-000411-86
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 02:28:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59585)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <k.jensen@samsung.com>) id 1izbZJ-0003XN-Fe
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 02:27:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <k.jensen@samsung.com>) id 1izbZI-0001f3-Bj
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 02:27:21 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:56713)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <k.jensen@samsung.com>)
 id 1izbZI-0001eW-5G
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 02:27:20 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200206072719euoutp02f66d34490c65f957a896aa0808ea3be7~wv4MkeUin2013420134euoutp02S
 for <qemu-devel@nongnu.org>; Thu,  6 Feb 2020 07:27:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200206072719euoutp02f66d34490c65f957a896aa0808ea3be7~wv4MkeUin2013420134euoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1580974039;
 bh=2K/JZBJNbuabJK7IR8PLO1qfslvDDOGBe2zSKis/Vtg=;
 h=Date:From:To:CC:Subject:In-Reply-To:References:From;
 b=ospED/NbGovWu2EqlQ2XxmOoUnO71DPiCvLxJjZ32BpGlNqn+2J0w1gRSwURRO2N7
 FMRqvxLEWNDMGHf5nmWCtdmF4wSa9tiOasJHa7l8hY4D/g58VXBuaStQcFWAg89ALC
 OfQnSM1RdwWfwWaIeC5qKh9bnSDcD+5I01SovXY0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200206072718eucas1p2c8131143eedaf74dd5d0a42d7771a762~wv4MSqYwT0994609946eucas1p2m;
 Thu,  6 Feb 2020 07:27:18 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id 8A.51.61286.6DFBB3E5; Thu,  6
 Feb 2020 07:27:18 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20200206072718eucas1p1ffb99d9ee7dfdf55f059754797dbb12b~wv4L9dMMy2673126731eucas1p1g;
 Thu,  6 Feb 2020 07:27:18 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20200206072718eusmtrp203b7fa7ac94d421eb6a30a253e262103~wv4L80bkX0319703197eusmtrp27;
 Thu,  6 Feb 2020 07:27:18 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-e0-5e3bbfd623a9
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id BF.6A.07950.6DFBB3E5; Thu,  6
 Feb 2020 07:27:18 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20200206072718eusmtip279558a935d286a5ef3ee55ff05622085~wv4Lu1gwk0737407374eusmtip2I;
 Thu,  6 Feb 2020 07:27:18 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) by
 CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) with Microsoft SMTP
 Server (TLS) id 15.0.1320.4; Thu, 6 Feb 2020 07:27:17 +0000
Received: from apples.localdomain (106.110.32.41) by CAMSVWEXC01.scsc.local
 (106.1.227.71) with Microsoft SMTP Server (TLS) id 15.0.1320.4 via Frontend
 Transport; Thu, 6 Feb 2020 07:27:17 +0000
Date: Thu, 6 Feb 2020 08:27:16 +0100
From: Klaus Birkelund Jensen <k.jensen@samsung.com>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v5 22/26] nvme: support multiple namespaces
Message-ID: <20200206072716.qwuirlf7zaoxu4fa@apples.localdomain>
MIME-Version: 1.0
In-Reply-To: <20200204163158.GA6823@redsun51.ssa.fujisawa.hgst.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKKsWRmVeSWpSXmKPExsWy7djPc7rX9lvHGTRtNbHY3N/OaLH/4DdW
 i0mHrjFaLLmYajHvlrLFrHftbBbHe3ewOLB7nNtxnt1j06pONo871/aweTy5tpnJ4/2+q2wB
 rFFcNimpOZllqUX6dglcGSc39rMVrBeuWPehpoFxN38XIyeHhICJxJrOW0xdjFwcQgIrGCUa
 pu9gAkkICXxhlDg31xAi8ZlR4v7hXjaYjssbb7BBJJYzSkw8+4gZrqr/TCcrhHOaUWLCpj8s
 EM5RRonbL7YzgvSzCKhIzH6wgxnEZhMwlnjTtRzMFhFQlrg7fyZYNzPIqM9P9oEtFBawl7j9
 7B2YzSvgILHi2lkmCFtQ4uTMJywgNqeAs8TWruVg2yQE1rFLdP28DXWti8Sz39uYIGxhiVfH
 t7BD2DIS/3fOZ4Jo6GaU6PvwlRnCmcEoMX3Zd6BuDiDHWqLvTA5IA7NAhsT9M78YIZodJZYv
 OMgMUcInceOtIEQJn8SkbdOhwrwSHW1CENVqEjuatjJChGUknq5RgAh7SGw/2Mk+gVFxFpJv
 ZiHZNQuog1lAU2L9Ln0IU1pi+T8OJNEFjKyrGMVTS4tz01OLDfNSy/WKE3OLS/PS9ZLzczcx
 AhPT6X/HP+1g/Hop6RCjAAejEg+vwWurOCHWxLLiytxDjBIczEoivOf1LeOEeFMSK6tSi/Lj
 i0pzUosPMUpzsCiJ8xovehkrJJCeWJKanZpakFoEk2Xi4JRqYPT2KXq3xSz4+hp2eYv5h6fa
 RofI183TfrHc+0vot02T45YGsYgV9hnmvrSt1H9VlV9dqeqraHVB7b1prrDH244+D+372ZbC
 M4NKlhQIOSS9WsLcc/DxY7Wk7tu/Mj/l/8o6su2ziHFI96l7zBqqu15aSywwynt7iNX/s3vU
 gasT3uUrCzrtVmIpzkg01GIuKk4EAKb2nHVIAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPIsWRmVeSWpSXmKPExsVy+t/xe7rX9lvHGcw6LWGxub+d0WL/wW+s
 FpMOXWO0WHIx1WLeLWWLWe/a2SyO9+5gcWD3OLfjPLvHplWdbB53ru1h83hybTOTx/t9V9kC
 WKP0bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLLUov07RL0Mj6f
 aGUq+CRQsaixi6mBcTpvFyMnh4SAicTljTfYuhi5OIQEljJKfPz9mAUiISPx6cpHdghbWOLP
 tS42EFtI4COjxJYed4iG04wSp67eYYRwjjJK9H7ezQRSxSKgIjH7wQ5mEJtNwFjiTddyMFtE
 QFni7vyZrCANzAKfGSW+rP8G1iAsYC9x+9k7sBW8Ag4SK66dZYKY+pNRYkJnPxNEQlDi5Mwn
 QPdxAHVrSqzfpQ9hSkss/8cBUsEp4CyxtWs5ywRGoVlIGmYhNMxCaFjAyLyKUSS1tDg3PbfY
 SK84Mbe4NC9dLzk/dxMjMLK2Hfu5ZQdj17vgQ4wCHIxKPLwGr63ihFgTy4orcw8xSnAwK4nw
 nte3jBPiTUmsrEotyo8vKs1JLT7EaAr0/kRmKdHkfGDU55XEG5oamltYGpobmxubWSiJ83YI
 HIwREkhPLEnNTk0tSC2C6WPi4JRqYIzpjtB9GNCtvOO3Zn6+3Wa/r4bh87tK+/WbzjTveX/6
 lIucCW9dgMrDW7Fq/SsXB97NMzf86HNhleZ35qkd/wV7woOOBBc+KG1kv7f+01oBv1MBm2cG
 /dZksP2c0p156n/rQuWCQ4eurCvOWiCr6+emt6b63NQlkc4X9zvt6K+IidicmhT7QImlOCPR
 UIu5qDgRAFUiySXCAgAA
X-CMS-MailID: 20200206072718eucas1p1ffb99d9ee7dfdf55f059754797dbb12b
X-Msg-Generator: CA
Content-Type: multipart/mixed;
 boundary="----23msWjQUv43tpiUhVjkRmyiL.ak-ODCQG-izg5rO9weAO7SH=_3a107_"
X-RootMTR: 20200204095230eucas1p27456c6c0ab3b688d2f891d0dff098821
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200204095230eucas1p27456c6c0ab3b688d2f891d0dff098821
References: <20200204095208.269131-1-k.jensen@samsung.com>
 <CGME20200204095230eucas1p27456c6c0ab3b688d2f891d0dff098821@eucas1p2.samsung.com>
 <20200204095208.269131-23-k.jensen@samsung.com>
 <20200204163158.GA6823@redsun51.ssa.fujisawa.hgst.com>
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

------23msWjQUv43tpiUhVjkRmyiL.ak-ODCQG-izg5rO9weAO7SH=_3a107_
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline

On Feb  5 01:31, Keith Busch wrote:
> On Tue, Feb 04, 2020 at 10:52:04AM +0100, Klaus Jensen wrote:
> > This adds support for multiple namespaces by introducing a new 'nvme-ns'
> > device model. The nvme device creates a bus named from the device name
> > ('id'). The nvme-ns devices then connect to this and registers
> > themselves with the nvme device.
> > 
> > This changes how an nvme device is created. Example with two namespaces:
> > 
> >   -drive file=nvme0n1.img,if=none,id=disk1
> >   -drive file=nvme0n2.img,if=none,id=disk2
> >   -device nvme,serial=deadbeef,id=nvme0
> >   -device nvme-ns,drive=disk1,bus=nvme0,nsid=1
> >   -device nvme-ns,drive=disk2,bus=nvme0,nsid=2
> > 
> > The drive property is kept on the nvme device to keep the change
> > backward compatible, but the property is now optional. Specifying a
> > drive for the nvme device will always create the namespace with nsid 1.
> > 
> > Signed-off-by: Klaus Jensen <klaus.jensen@cnexlabs.com>
> > Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> 
> I like this feature a lot, thanks for doing it.
> 
> Reviewed-by: Keith Busch <kbusch@kernel.org>
> 
> > @@ -1256,18 +1272,24 @@ static uint16_t nvme_smart_info(NvmeCtrl *n, NvmeCmd *cmd, uint8_t rae,
> >      uint64_t units_read = 0, units_written = 0, read_commands = 0,
> >          write_commands = 0;
> >      NvmeSmartLog smart;
> > -    BlockAcctStats *s;
> >  
> >      if (nsid && nsid != 0xffffffff) {
> >          return NVME_INVALID_FIELD | NVME_DNR;
> >      }
> 
> This is totally optional, but worth mentioning: this patch makes it
> possible to remove this check and allow per-namespace smart logs. The
> ID_CTRL.LPA would need to updated to reflect that if you wanted to
> go that route.

Yeah, I thought about that, but with NVMe v1.4 support arriving in a
later series, there are no longer any namespace specific stuff in the
log page anyway.

The spec isn't really clear on what the preferred behavior for a 1.4
compliant device is. Either

  1. LBA bit 0 set and just return the same page for each namespace or,
  2. LBA bit 0 unset and fail when NSID is set


------23msWjQUv43tpiUhVjkRmyiL.ak-ODCQG-izg5rO9weAO7SH=_3a107_
Content-Type: text/plain; charset="utf-8"


------23msWjQUv43tpiUhVjkRmyiL.ak-ODCQG-izg5rO9weAO7SH=_3a107_--

