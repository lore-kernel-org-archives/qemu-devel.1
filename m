Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63576C2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 13:17:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C7EB2073C
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 13:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="OLfN0GKv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C7EB2073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1rtu-0002bn-D2
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 08:17:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34066)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <k.jensen@samsung.com>) id 1j1rl2-0004QO-A5
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 08:08:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <k.jensen@samsung.com>) id 1j1rl0-0003Bs-OY
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 08:08:48 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:40570)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <k.jensen@samsung.com>)
 id 1j1rl0-00036s-Ig
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 08:08:46 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20200212130841euoutp01088130042ed576f8fa768709fe7891c9~yqZ9usWeQ1719717197euoutp01F
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 13:08:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20200212130841euoutp01088130042ed576f8fa768709fe7891c9~yqZ9usWeQ1719717197euoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1581512921;
 bh=J7PQo5C9rJV3jHvh8muksx2TE6eiHf9S3vzjhQ9NU/w=;
 h=Date:From:To:CC:Subject:In-Reply-To:References:From;
 b=OLfN0GKvSv5GjrmFUcx3IuzrJOgQ3vYLxvuIoUmFgU6IxSNoxNKNLL9pMCMPMVa0M
 RTxvc7r34BOrz9JFzAljja73oCXsEjqJTHY1m3kNBZKJ7FUnjVlyal6w0+LKCbuilr
 2PvWEdSlZ5Sb5oPn9zq4JbgstSaiNyqTYti+qz+E=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20200212130841eucas1p1f72c45b668ee8910df3b08eb9cd78b10~yqZ9gc7rs2493424934eucas1p1R;
 Wed, 12 Feb 2020 13:08:41 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id CB.5A.60698.9D8F34E5; Wed, 12
 Feb 2020 13:08:41 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20200212130840eucas1p1dbe8d50ad7a2957b01ce1d94be9dede5~yqZ9O3-s72290022900eucas1p1q;
 Wed, 12 Feb 2020 13:08:40 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200212130840eusmtrp1bf7f1805d23844a0fb1ca784728f4fbd~yqZ9ON_Js1504515045eusmtrp1j;
 Wed, 12 Feb 2020 13:08:40 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-24-5e43f8d97d45
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id C9.15.07950.8D8F34E5; Wed, 12
 Feb 2020 13:08:40 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20200212130840eusmtip2c86ec75fa4f3c1aa1c5daa5b7dac7a8a~yqZ9H3XHk1447714477eusmtip2K;
 Wed, 12 Feb 2020 13:08:40 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) by
 CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) with Microsoft SMTP
 Server (TLS) id 15.0.1320.4; Wed, 12 Feb 2020 13:08:40 +0000
Received: from apples.localdomain (106.110.32.41) by CAMSVWEXC01.scsc.local
 (106.1.227.71) with Microsoft SMTP Server (TLS) id 15.0.1320.4 via Frontend
 Transport; Wed, 12 Feb 2020 13:08:39 +0000
Date: Wed, 12 Feb 2020 14:08:38 +0100
From: Klaus Birkelund Jensen <k.jensen@samsung.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH v5 01/26] nvme: rename trace events to nvme_dev
Message-ID: <20200212130838.2zgz6iuysi4ef2ne@apples.localdomain>
MIME-Version: 1.0
In-Reply-To: <0106bf338e09bbf01e35bbcabed344ba71a2ad0d.camel@redhat.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0iTURjHO3svex3OXqfggxrloiukloGrzCwlVhBdCAIpbenLNOeUd177
 pCnqlncFddEFs2kqFE6Xl7y0D0ooTiFNy8hARaNpppaWSptHw2+///85P8554DCEpI1yZ6LV
 CRyvVqiktIg0da9YjowuB4f5mg1CmbEgG8k63/6iZMXmYSSrGuRkbVM1Atnjj3tl+tlsWtaT
 10wGMfL+ZotQ3lCrpeVjw29o+cSwUSCf6xiir1ChooBIThWdxPE+gbdFURm5C1S8SZQyXtGC
 0tAAo0MODLDHIX3ZItQhESNhaxBMZReROCwimG+3EjgsIPg8NE9tKT8bRyk8qEZQn/NJ8P/U
 WJ2WxqEPwR+DadPvRpA3+HrDJ9l9MDRoFdiZZv3gu66asLMrexDmpyuRXSDYUgHkPHyB7AMX
 NhgKdVbSzmI2CEZePaEwO8O7iomN3oGVw/Ms/YYMbIMQGhtbBfi1IaC3mjbZBb71NAoxe0Jv
 SS6JhQcI8n8sETiUIygz/LZtwdjCKcjvU9kFgo2CTGM9ieuzMFkaitEJRqzO+IQTFJvKCFyL
 ISdLgm/aD833mxCuPWGyfg+u5dD0t44sRF76bcvot12ltxkEewhetvpg9IDqdWZb+xRRtciN
 S9TEKjmNn5pL9tYoYjWJaqV3RFxsA7J9qd71nqVm1LF6x4xYBkkdxV3TwWESSpGkSY01I2AI
 qavYLd1WiSMVqfc4Pi6cT1RxGjPyYEipm9ivcuaWhFUqErgYjovn+K2pgHFwT0Nej75aVN4z
 /erLozcyzYzOkR+8WKUtapEmndk9P2zk/cm1Ll/9SP5chvaLv5K2XCMWgswH7o7PaJ3Cyt87
 eq0m7DzpOf74mMhnR9wsX7Cr87RuOfCcujcyc/z8oiGrJO/CVEz7iQ/PLoWvXA+g1xTJzhED
 N32WU9IzHONCrpb1SUlNlOLoYYLXKP4Bom/g004DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCIsWRmVeSWpSXmKPExsVy+t/xe7o3fjjHGbxrMLTY3N/OaLH/4DdW
 i0mHrjFaLLmYarH72Qomi3m3lC1mvWtnszjeu4PFgcPj3I7z7B6bVnWyedy5tofN48m1zUwe
 7/ddZQtgjdKzKcovLUlVyMgvLrFVija0MNIztLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3
 S9DLuPDGsuAne8XtLQfYGxjXsHUxcnJICJhIfNpyk7WLkYtDSGApo8S8GzuZIBIyEp+ufGSH
 sIUl/lzrYoMo+sgose3AdmYI5wyjxO69z6AyxxglXl7fzgjSwiKgKnH14luwUWwCxhJvupYz
 g9giAhoSH18sYgRpYBaYwiTRMXslWIOwgLPEhK63LCA2r4CDxI0N86GO+sso8XvbC2aIhKDE
 yZlPgIo4gLo1Jdbv0ocwpSWW/+MAqeAU8JBY2jaLcQKj0CwkDbMQGmYhNCxgZF7FKJJaWpyb
 nltspFecmFtcmpeul5yfu4kRGGPbjv3csoOx613wIUYBDkYlHt4DL5zjhFgTy4orcw8xSnAw
 K4nwijcChXhTEiurUovy44tKc1KLDzGaAr0/kVlKNDkfGP95JfGGpobmFpaG5sbmxmYWSuK8
 HQIHY4QE0hNLUrNTUwtSi2D6mDg4pRoYT6l9a983Ifatxdyy0GMxoeZ8F1+UvXHdyGSb3HtM
 eMOkLevEt651lYptVZqu/a8wMDp8w4/GksxHtxfnzH3v4n3Iie3hWfkF//Y8XFlh/V8lZttS
 6zueT7T7pn6W0ggQZ1E/NmXvf0cjDu+puQYN6TVK52IZl525+1paybfhyuHrm529v3TOVmIp
 zkg01GIuKk4EAMowN3fHAgAA
X-CMS-MailID: 20200212130840eucas1p1dbe8d50ad7a2957b01ce1d94be9dede5
X-Msg-Generator: CA
Content-Type: multipart/mixed;
 boundary="----23msWjQUv43tpiUhVjkRmyiL.ak-ODCQG-izg5rO9weAO7SH=_797f1_"
X-RootMTR: 20200204095216eucas1p2cb2b4772c04b92c97b0690c8e565234c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200204095216eucas1p2cb2b4772c04b92c97b0690c8e565234c
References: <20200204095208.269131-1-k.jensen@samsung.com>
 <CGME20200204095216eucas1p2cb2b4772c04b92c97b0690c8e565234c@eucas1p2.samsung.com>
 <20200204095208.269131-2-k.jensen@samsung.com>
 <0106bf338e09bbf01e35bbcabed344ba71a2ad0d.camel@redhat.com>
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
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Javier Gonzalez <javier.gonz@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

------23msWjQUv43tpiUhVjkRmyiL.ak-ODCQG-izg5rO9weAO7SH=_797f1_
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline

On Feb 12 11:08, Maxim Levitsky wrote:
> On Tue, 2020-02-04 at 10:51 +0100, Klaus Jensen wrote:
> > Change the prefix of all nvme device related trace events to 'nvme_dev'
> > to not clash with trace events from the nvme block driver.
> > 

Hi Maxim,

Thank you very much for your thorough reviews! Utterly appreciated!

I'll start going through your suggested changes. There is a bit of work
to do on splitting patches into refactoring and bugfixes, but I can
definitely see the reason for this, so I'll get to work.

You mention the alignment with split lines alot. I actually thought I
was following CODING_STYLE.rst (which allows a single 4 space indent for
functions, but not statements such as if/else and while/for). But since
hw/block/nvme.c is originally written in the style of aligning with the
opening paranthesis I'm in the wrong here, so I will of course amend
it. Should have done that from the beginning, it's just my personal
taste shining through ;)


Thanks again,
Klaus


------23msWjQUv43tpiUhVjkRmyiL.ak-ODCQG-izg5rO9weAO7SH=_797f1_
Content-Type: text/plain; charset="utf-8"


------23msWjQUv43tpiUhVjkRmyiL.ak-ODCQG-izg5rO9weAO7SH=_797f1_--

