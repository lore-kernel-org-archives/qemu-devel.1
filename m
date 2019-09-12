Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD96C49ED9
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 06:27:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BEA520830
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 06:27:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="FldCLZAE";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="opUmCwul"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BEA520830
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aj.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8IZS-0006N6-JK
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 02:27:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40971)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrew@aj.id.au>) id 1i8IXK-0004sM-PW
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 02:25:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrew@aj.id.au>) id 1i8IXI-0006Is-8N
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 02:24:58 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:47683)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrew@aj.id.au>)
 id 1i8IXA-0006Hl-SS; Thu, 12 Sep 2019 02:24:49 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 39C31224EC;
 Thu, 12 Sep 2019 02:24:47 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
 by compute4.internal (MEProxy); Thu, 12 Sep 2019 02:24:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
 mime-version:message-id:in-reply-to:references:date:from:to:cc
 :subject:content-type:content-transfer-encoding; s=fm3; bh=Ph1EM
 ADjDASZh3KN9TBm15v9QudwLsxsqj8JH8vxcFQ=; b=FldCLZAEu7Bu+SbbAtymy
 xjVCaHWMDdJldL3J59cH6bStDNnRxX83XHD98EpjNs/LMLTsFb7SpOr+n4xY8rdu
 QVvMeJEB0ywswhcoISlJQNu4zTiDOB6nILTWP9aBXfrwLLc3tNAhqtl2e9VfA9hH
 7NnU2Q1WlRnkq0LpnvvJKNt69emlLA7mAK9KdiNR4e3CnNuxH2RHb9Qt322ZWLKC
 oUvtXw0G61GQP4ymeOembvOS2xN1cf1RYyTM6SN1Wvx9CYZ8qqduJ8pDOlchzTnS
 s7xN7qJNb/MphMakOGvIuECfLLBhQKU/2RIixgU9fTfC21VnSnxf7GTtl65aOD8+
 A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; bh=Ph1EMADjDASZh3KN9TBm15v9QudwLsxsqj8JH8vxc
 FQ=; b=opUmCwulSMYT3f3NyXj0SYLvKxnYBJu3Ge19sq8Li8JDkvylDHqCop3JW
 02Q/hRRro3pnizFl4XC89MmDN7ALwDMXYt49mU070CbRy2hiWtVxE1K1aCUZr80b
 JhmlizGtQCBvFAoOYXwpbVSNa4gf2VtKEGuBK1bKQcr1OqF65YFyvwQZ+XrCz5KR
 Sl8u7dzkZ+575offH5TIcIhKan3G51r4rLMPfXeEw3A9E3pNGOnCqMP8h5Ul4PAV
 u3RBnPZMx+1XoEuLf34KsTSj9QJ9mfm+dG+ViAFeO+VNqY4pTAkJu9XldqMMhT/F
 ttgeWKewPyA6o1xkdnra0PUXbzyEQ==
X-ME-Sender: <xms:ruR5XWuVgipF3vjNDSGRKhiYQ_kL-xsKQs7DFCDEXGQsEocCeQOfMg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrtdeggddutdekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvffutgfgsehtqhertderreejnecuhfhrohhmpedftehn
 ughrvgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucffoh
 hmrghinhepohiilhgrsghsrdhorhhgnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhgu
 rhgvfiesrghjrdhiugdrrghunecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:ruR5XRJPlKkOhBjIoMlehlH9j_4uWDOlrj-UqI2p7HUM3yf3SrPPwg>
 <xmx:ruR5XS_pIDl2yeEOGtwMYSG6R7EetzRdVwzZmybE5TXyUOg3ailYRQ>
 <xmx:ruR5XfC8V-Vku5KOSqnaEj9yx5X7jIRA5CGOz62KE-sCgln6SBBuhA>
 <xmx:r-R5XUm1S5B9Qkz9tVAPqLw5SrPlSkxfF2F1QffQDoV6wzthhVx8tg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 900EDE00A9; Thu, 12 Sep 2019 02:24:46 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-237-gf35468d-fmstable-20190912v1
Mime-Version: 1.0
Message-Id: <d0d2531e-7ee7-4e99-bab8-1fa6c6baf6c5@www.fastmail.com>
In-Reply-To: <a9fdcc8b-3a92-587f-28e8-5a997991532e@kaod.org>
References: <20190912032531.32546-1-andrew@aj.id.au>
 <a9fdcc8b-3a92-587f-28e8-5a997991532e@kaod.org>
Date: Thu, 12 Sep 2019 15:55:19 +0930
From: "Andrew Jeffery" <andrew@aj.id.au>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-arm@nongnu.org
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 66.111.4.26
Subject: Re: [Qemu-devel] [PATCH v4] target-arm: Make the counter tick
 relative to cntfrq
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On Thu, 12 Sep 2019, at 15:52, C=C3=A9dric Le Goater wrote:
> On 12/09/2019 05:25, Andrew Jeffery wrote:
> > Allow machines to configure CNTFRQ via a property if the ARM core
> > supports the generic timer. This is necessary on e.g. the ASPEED AST=
2600
> > SoC where the generic timer clock is run at 800MHz or above. The def=
ault
> > value for CNTFRQ remains at 62.50MHz (based on GTIMER_SCALE).
> >=20
> > CNTFRQ is a read-as-written co-processor register; the property sets=
 the
> > register's initial value which is used during realize() to configure=
 the
> > QEMUTimers that back the generic timers. Beyond that the firmware ca=
n to
> > do whatever it sees fit with the CNTFRQ register though changes to t=
he
> > value will not be reflected in the timers' rate.
> >=20
> > I've tested this using an out-of-tree AST2600 SoC model (Cortex-A7) =
with
> > the SDK u-boot that sets CNTFRQ as appropriate, and by starting/runn=
ing
> > machines with assorted ARM CPUs (palmetto-bmc with the ARM926EJ-S,
> > romulus-bmc with the ARM1176 and raspi2 with the Cortex-A53).
> >=20
> > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > ---
> > v4: Fix configuration for cores without a generic timer
> >=20
> > v3: https://patchwork.ozlabs.org/patch/1160634/
> > Peter - I think this addresses most of your feedback. I still reach =
into
> > the QEMUTimer to fetch out scale when adjusting the nexttick
> > calculation, but we no longer need to update the scale member and fo=
rce
> > a recalculation of the period.
> >=20
> > v2: https://patchwork.ozlabs.org/patch/1144389/
> > ---
> >  roms/SLOF           |  2 +-
> >  roms/skiboot        |  2 +-
> >  target/arm/cpu.c    | 43 +++++++++++++++++++++++++++++++++++-------=
-
> >  target/arm/cpu.h    |  3 +++
> >  target/arm/helper.c | 30 ++++++++++++++++++++++++++----
> >  5 files changed, 66 insertions(+), 14 deletions(-)
> >=20
> > diff --git a/roms/SLOF b/roms/SLOF
> > index 7bfe584e3219..ea221600a116 160000
> > --- a/roms/SLOF
> > +++ b/roms/SLOF
> > @@ -1 +1 @@
> > -Subproject commit 7bfe584e321946771692711ff83ad2b5850daca7
> > +Subproject commit ea221600a116883137ef90b2b7ab7d2472bc4f10
> > diff --git a/roms/skiboot b/roms/skiboot
> > index 261ca8e779e5..3a6fdede6ce1 160000
> > --- a/roms/skiboot
> > +++ b/roms/skiboot
> > @@ -1 +1 @@
> > -Subproject commit 261ca8e779e5138869a45f174caa49be6a274501
> > +Subproject commit 3a6fdede6ce117facec0108afe716cf5d0472c3f
>=20
>=20
> The changes above seem not related.

How did they get in there? :eyeroll:

Thanks. v5 I guess.

Andrew

