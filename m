Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B122C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 23:47:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A79920738
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 23:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="DY7Vq3rG";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QQUwbrPc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A79920738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aj.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnWA4-0003r3-H2
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 19:47:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58746)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@aj.id.au>)
 id 1jnW8t-00038p-Nw; Mon, 22 Jun 2020 19:46:23 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:56371)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@aj.id.au>)
 id 1jnW8q-0001Vb-MM; Mon, 22 Jun 2020 19:46:23 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailnew.nyi.internal (Postfix) with ESMTP id 177425802D4;
 Mon, 22 Jun 2020 19:46:19 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
 by compute3.internal (MEProxy); Mon, 22 Jun 2020 19:46:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
 mime-version:message-id:in-reply-to:references:date:from:to:cc
 :subject:content-type:content-transfer-encoding; s=fm3; bh=mLKEw
 f2cevhwCtO32RUnIKwLIQNtA+ThnXTkkf8u7VQ=; b=DY7Vq3rGKcDN2lEu7NT9D
 BtocmjOxYJXEnupE5tEVioG4mRkJVbYL0tIDm3f6HXDiyb3qed4M9Z0J5wvA95oU
 dQYwabklnPMdzickGVAlTW6M5gj/Hp2c97EQVJWj2ZL6MnWK6IeYCjN16pusnodX
 IfdItQvyUzmvNJf7KMLnSVaZeoJhJugtxs+HqY0LlHRud9zYBHLIWgScuR+XaWVy
 GLpZFQAf2yu+TTApGwcvol2cFNB+hjYRi13G8MNTI0BIduoqLH3jTNlxUhZOQuXV
 wCL+jODEQI9Vrri6aIwAgtxMeVJD4ZKdTykSEXmJDa1GsUkYUc17321uYeUrmOZp
 g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; bh=mLKEwf2cevhwCtO32RUnIKwLIQNtA+ThnXTkkf8u7
 VQ=; b=QQUwbrPcN8uGp3bOfd9+BbkApS3p4Kd5PCsh0QllJPSKJTeupL0faCILF
 sr/XrFR8xWhi9O0zoWVqAu4VG6rGBP9SPspGBVLsZimasYhpqrhWbkNWzbHwERKj
 eW04ayYlIxc7lmBDr4FKtNZrBHi11YZS8hvr2dpy1Op8cTPR9IK9ga/7UXbeEgnk
 x9UFVOegysJayp4YuEE9uWqtDGxgjKWLM7QwNdMSgOcU/J+qVCrQnuQ0oyTBDzZ+
 H8DSmaKxZ/sTEba/s35AYKZPsvTcX/fPqCUNg4uPbJOCUSTEz28moelX6K56P3l3
 RE3Kh4wtTPn7pYlt4BPhxhDahi9CA==
X-ME-Sender: <xms:ykLxXtsij1GEdn-G7c2DR0dVMshWsI7Wdi2LiGXdgE2kKk3v0M52mA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudekfedgvdehucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvffutgfgsehtqhertderreejnecuhfhrohhmpedftehn
 ughrvgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucggtf
 frrghtthgvrhhnpedvgeekheegfedvhfethefhudetteegueeggfeiieegueehkedugedt
 kefglefgheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpegrnhgurhgvfiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:ykLxXme1HKcFfXujCn1GO53UX0R0_z_WPdCE05AKvOUnmS-xb_Pilg>
 <xmx:ykLxXgwfiHbDNODRmbMh5FLn9JmCCAq9rddmWEq_koZz6VSWIAIp7g>
 <xmx:ykLxXkNszQ-Y0LWb3gCbdgEoAVuUQZeK26mZ6yqOCakccZiMqAHtRw>
 <xmx:y0LxXu0WF1JZyjX6o9WJr3ADDMDvS8Qk3sj3PGF_0-KkQN2-pGaFwg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 41C0AE00A8; Mon, 22 Jun 2020 19:46:18 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.3.0-dev0-543-gda70334-fm-20200618.004-gda703345
Mime-Version: 1.0
Message-Id: <e1fba66a-8c7e-4b15-9f6e-5e1957555088@www.fastmail.com>
In-Reply-To: <3e3459aa-7179-56e5-3e4d-b25f2ea3b450@amsat.org>
References: <20200616075121.12837-1-f4bug@amsat.org>
 <20200616075121.12837-8-f4bug@amsat.org>
 <914f089d-e81e-4b01-bd70-4702d8b39724@www.fastmail.com>
 <ad812821-8b06-bb82-d336-ffb1e7c14839@amsat.org>
 <1acc89c9-8a5c-4ba5-9201-2f0124cd7969@www.fastmail.com>
 <3e3459aa-7179-56e5-3e4d-b25f2ea3b450@amsat.org>
Date: Tue, 23 Jun 2020 09:15:58 +0930
From: "Andrew Jeffery" <andrew@aj.id.au>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 "Cameron Esfahani via" <qemu-devel@nongnu.org>
Subject: =?UTF-8?Q?Re:_[PATCH_7/7]_hw/watchdog/wdt=5Faspeed:_Reduce_timer_precisi?=
 =?UTF-8?Q?on_to_micro-second?=
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=66.111.4.229; envelope-from=andrew@aj.id.au;
 helo=new3-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 19:46:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, Corey Minyard <minyard@acm.org>,
 David Hildenbrand <david@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Max Reitz <mreitz@redhat.com>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On Mon, 22 Jun 2020, at 18:13, Philippe Mathieu-Daud=C3=A9 wrote:
> On 6/22/20 2:21 AM, Andrew Jeffery wrote:
> > On Wed, 17 Jun 2020, at 13:11, Philippe Mathieu-Daud=C3=A9 wrote:
> >> Hi Andrew,
> >>
> >> On 6/17/20 3:18 AM, Andrew Jeffery wrote:
> >>> On Tue, 16 Jun 2020, at 17:21, Philippe Mathieu-Daud=C3=A9 wrote:
> >>>> The current implementation uses nano-second precision, while
> >>>> the watchdog can not be more precise than a micro-second.
> >>>
> >>> What's the basis for this assertion? It's true for the AST2500 and=
 AST2600, but=20
> >>> the AST2400 can run the watchdog from either a 1MHz clock source o=
r the APB=20
> >>> clock (which must be at least 16.5MHz on palmetto). The reset stat=
e on the
> >>> AST2400 configures the watchdog for the APB clock rate.
> >>>
> >>> The Linux driver will eventually configure the watchdog for 1MHz m=
ode
> >>> regardless so perhaps the AST2400 reset state is a bit of a corner=
 case, but
> >>> I feel the assertion should be watered down a bit?
> >>
> >> What about this description?
> >>
> >> "The current implementation uses nano-second precision, but
> >>  is not more precise than micro-second precision.
> >>  Simplify by using a micro-second based timer.
> >>  Rename the timer 'timer_us' to have the unit explicit."
> >=20
> > So is this a limitation of QEMUTimer? I was establishing that the ha=
rdware can=20
> > operate at greater than 1 micro-second precision.
>=20
> No, I misread your comment about the AST2400 timer which can run
> at more than 1Mhz.
>=20
> The QEMUTimer doesn't have a such limitation; this patch
> aimed to simplify the code for reviewers, but you proved
> it incorrect, so let's disregard it.
>=20
> Thanks for your careful review!

Ah, great, I was wondering where my misunderstanding was.

Thanks for clearing that up.

Andrew

