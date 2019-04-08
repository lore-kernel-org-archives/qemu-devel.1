Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35860C10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 12:36:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6EBE21473
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 12:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="onZGAmhS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6EBE21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52472 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDTW9-0003NV-7Y
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 08:36:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <i.maximets@samsung.com>) id 1hDTTI-0001It-9s
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 08:33:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <i.maximets@samsung.com>) id 1hDTTG-0003vT-Gb
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 08:33:55 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:38310)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <i.maximets@samsung.com>)
	id 1hDTTA-0003ov-PN
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 08:33:50 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
	20190408123342euoutp025f3a148c3785953af3b756f3c24f2ffb~Tf87afdpS0613506135euoutp02D
	for <qemu-devel@nongnu.org>; Mon,  8 Apr 2019 12:33:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
	20190408123342euoutp025f3a148c3785953af3b756f3c24f2ffb~Tf87afdpS0613506135euoutp02D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1554726822;
	bh=THgaSCUIIEb4ZWpUkGBZQCPyeAcxiVYlY5YzqxteY3w=;
	h=To:Subject:Cc:From:Date:References:From;
	b=onZGAmhSYhhM0agUn7NEKCa1MHqX/dZU3ZGk9qDGenzL6PbxGqoLfbMXyNRvaG7sT
	C1o/PBXbyObK5T4Dnj61BhSSkjKzTLDKsztUElkkG2UMboGNuaFFT+CemkitWaqaBw
	dvganq4NICHKPZAGlEY9zZdyjwMo4bVKT8/U+pVw=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20190408123342eucas1p22243b2f06780ee252009ed83c64652ee~Tf87AHjNf1507615076eucas1p2I;
	Mon,  8 Apr 2019 12:33:42 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 0E.A2.04298.5AF3BAC5;
	Mon,  8 Apr 2019 13:33:42 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20190408123341eucas1p2add7886160b2b66912413defd4544d1f~Tf86OsRd-1709917099eucas1p2z;
	Mon,  8 Apr 2019 12:33:41 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20190408123341eusmtrp26a1053ea6e50745573a5d981b53598d0~Tf859GFz-0058100581eusmtrp2N;
	Mon,  8 Apr 2019 12:33:41 +0000 (GMT)
X-AuditID: cbfec7f2-f13ff700000010ca-1b-5cab3fa596cc
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 65.27.04140.5AF3BAC5;
	Mon,  8 Apr 2019 13:33:41 +0100 (BST)
Received: from [106.109.129.180] (unknown [106.109.129.180]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20190408123340eusmtip289b71e6883c14e08a86dc7a309d7d467~Tf85moDyo2429224292eusmtip2X;
	Mon,  8 Apr 2019 12:33:40 +0000 (GMT)
To: mdroth@linux.vnet.ibm.com
From: Ilya Maximets <i.maximets@samsung.com>
Message-ID: <c138abfe-61fd-6e04-8900-2ba2a24073de@samsung.com>
Date: Mon, 8 Apr 2019 15:33:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.5.1
MIME-Version: 1.0
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsWy7djPc7rL7FfHGKxfwWTRu+0eu8WV9p/s
	Fl+Os1sc793BYjF/6U4WB1aPB4c2s3g8ubaZyeP9vqtsHn1bVjEGsERx2aSk5mSWpRbp2yVw
	ZVyZ8om14C17xY4ZCQ2Mx1i7GDk5JARMJHb8OsDYxcjFISSwglHiYMc6KOcLo8SyiauZIJzP
	jBKft+5kgmn5vPYRVNVyRonVm5qgnI+MEhN7jzCDVIkIyEosO/2AHcQWFoiWmL91IdhCZoFQ
	ib4XC8BsNgEdiVOrjwA1c3DwCthJPNnrChJmEVCR6Pu3iQXEFhWIkHj/dDeYzSsgKHFy5hMW
	iDHiEk1fVkKNlJfY/nYOM8gNEgLd7BIr335mhrjURWLvl7tQjwpLvDq+hR3ClpH4v3M+1Df1
	EvdbXjJCNHcwSkw/9A8qYS+x5fU5dpDjmAU0Jdbv0ocIO0q8P9XODBKWEOCTuPFWEOIGPolJ
	26ZDhXklOtqEIKpVJH4fXA51jZTEzXefoS7wkJhyqpVtAqPiLCSfzULy2Swkn81CuGEBI8sq
	RvHU0uLc9NRiw7zUcr3ixNzi0rx0veT83E2MwBRz+t/xTzsYv15KOsQowMGoxMP7w2ZVjBBr
	YllxZe4hRgkOZiUR3p1TgUK8KYmVValF+fFFpTmpxYcYpTlYlMR5qxkeRAsJpCeWpGanphak
	FsFkmTg4pRoYm98nP/zAqtdQ52C9gO9Dx4HrG3ffvPZ4Qp2E88oUDsGfZRbJhzM/bJpx2W7q
	o1rfn0tYbqqF2SwPX3Lm2D4v6fhzK1/N3nRO4ZuDiLpOz3G1+C+Xf3wL0snmr22e2u9rOnFa
	9u9ZosdW3mp7UCcyy/72vR+uNbvfXkzOXX5szzq50Ji0rmiJZUosxRmJhlrMRcWJAJ2SQ6At
	AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPIsWRmVeSWpSXmKPExsVy+t/xe7pL7VfHGBzZwG3Ru+0eu8WV9p/s
	Fl+Os1sc793BYjF/6U4WB1aPB4c2s3g8ubaZyeP9vqtsHn1bVjEGsETp2RTll5akKmTkF5fY
	KkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZVyZ8om14C17xY4ZCQ2Mx1i7
	GDk5JARMJD6vfcTYxcjFISSwlFFi/pkbLBAJKYkfvy5AFQlL/LnWxQZR9J5R4lVHJzNIQkRA
	VmLZ6QfsXYwcQAluidXNQSBhYYFoif5lS9lBbGaBUIm1Px4xgdhsAjoSp1YfYQQp5xWwk3iy
	1xUkzCKgItH3bxPYWlGBCIm7F1+A2bwCghInZz5hgRijLvFn3iVmCFtcounLSlYIW15i+9s5
	zBMYBWchaZmFpGUWkpZZSFoWMLKsYhRJLS3OTc8tNtIrTswtLs1L10vOz93ECIycbcd+btnB
	2PUu+BCjAAejEg/vD5tVMUKsiWXFlbmHGCU4mJVEeHdOBQrxpiRWVqUW5ccXleakFh9iNAV6
	aCKzlGhyPjCq80riDU0NzS0sDc2NzY3NLJTEec8bVEYJCaQnlqRmp6YWpBbB9DFxcEo1MO7o
	+d0YEn8l4bVue3OkZ7hb2Vux0nXKby6KPHU9a7S5z3Bto+3XfdL9EUv2Ln6gZli04lzBm3Dj
	tkwGBVGWs5uneyi/13268GiCb88Fnt2vFfZcVnF8m7Bg4Twvgb0qc1/yvVEOPX0hxjBlvfc0
	Dsdtd8x1a+IPnO7ySLboY7kpzqQ9TaPsoRJLcUaioRZzUXEiAGmVaWWyAgAA
X-CMS-MailID: 20190408123341eucas1p2add7886160b2b66912413defd4544d1f
X-Msg-Generator: CA
Content-Type: text/plain; charset="UTF-8"
X-RootMTR: 20190408123341eucas1p2add7886160b2b66912413defd4544d1f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190408123341eucas1p2add7886160b2b66912413defd4544d1f
References: <CGME20190408123341eucas1p2add7886160b2b66912413defd4544d1f@eucas1p2.samsung.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 210.118.77.12
Subject: [Qemu-devel]  [PATCH 00/97] Patch Round-up for stable 3.0.1,
 freeze on 2019-04-08
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel <qemu-devel@nongnu.org>, dgilbert@redhat.com,
	qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408123339.spSeGMxRhx1GR-rylus-ZiXOC8NOJXeobDKc7xLvjgc@z>

> Hi everyone,                                                                    
>                           
> 
> The following new patches are queued for QEMU stable v3.0.1:
> 
>   https://github.com/mdroth/qemu/commits/stable-3.0-staging
> 
> The release is planned for 2019-04-11:
> 
>   https://wiki.qemu.org/Planning/3.0
> 
> Please respond here or CC address@hidden on any patches you
> think should be included in the release.
> 
> Note that this update falls outside the normal stable release support
> window (~1 development cycle), but is being release now since it was
> delayed from its intended release date.
> 
> Thanks!
> 

[...]

> 
> Ilya Maximets (1):
>       migration: Stop postcopy fault thread before notifying

Hi.

Sorry for late response, but what about following two patches:

  c4f753859ae6 ("vhost-user: Fix userfaultfd leak")
  5ce43896e167 ("vhost-user: Don't ask for reply on postcopy mem table set")

?

Best regards, Ilya Maximets.

