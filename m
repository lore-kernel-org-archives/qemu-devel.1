Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C71C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 01:19:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A780B2082F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 01:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="HkCGLoi5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Kfsaxhcx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A780B2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aj.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlMk4-0008AH-VP
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 21:19:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51270)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@aj.id.au>)
 id 1jlMjL-0007ap-1W; Tue, 16 Jun 2020 21:19:07 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:42837)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@aj.id.au>)
 id 1jlMjJ-0000fd-74; Tue, 16 Jun 2020 21:19:06 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailnew.west.internal (Postfix) with ESMTP id 16D15679;
 Tue, 16 Jun 2020 21:18:59 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
 by compute3.internal (MEProxy); Tue, 16 Jun 2020 21:19:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
 mime-version:message-id:in-reply-to:references:date:from:to:cc
 :subject:content-type:content-transfer-encoding; s=fm3; bh=bGiw2
 oVMO5sl1u06HPRnTO8nHbbowtd7bD1Dzh+zIN0=; b=HkCGLoi5tjpRO/g2A28GH
 4shI1XOK9YkyMPTrtWOptLqh/qFWCqrcLWi+ICYg5uBQ9o+X+4QQuO6Xl5fIW/An
 F18aB8rHS4WX0edjoVRh2hS56KqSHTJInK0AQIXOnmaKMfVYNA5JIHrWeuJx27kh
 UEyfKHw9wRpx5ICTCkQEZI4sYnqDX4daFdXJLsTk1SGOYOEdQvg1zdPK90XkxCFt
 /bG1k/wWlLb8ViIlQLASvMjO4f1PbSlIrQXyisiWZDPW+adOgd09GdfLauYOPcWQ
 SWMJl4ZDN2BkqXORPBwr8LKx/xXys7Aj6ACIZ9dMerZOBD3Y2Ea2kPe/tRmmW/ZD
 w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; bh=bGiw2oVMO5sl1u06HPRnTO8nHbbowtd7bD1Dzh+zI
 N0=; b=KfsaxhcxSRuYPM5VFJE7e4s7htSf0rEeuvI1Dw/ssYqwKvC2McIrow6bJ
 ONUAQ5J0QxhXah5U6sARcMkxfqcSN+T2Q0oHgUHoisceCRjRKpCC8xNjuvlVKy28
 vDJBIauFdm5x+hcory1d/WL1c4mafJ/lNgF/7uLBWrslCMJIpju5wjMM2UPBr1zg
 ALX8PvY4QTmEho3RsZjEZ3qId7c+nNeZQ1Acr+POw+a1kevbq+3uY9JwkAAjsiF1
 TkMDoaio4yiG51NcZ6YvAa1OBH+iIZczSSg3SnUK9WI79SVHxmANGqURIYxHsSE3
 rfTj9Gq6ue7vSNoO6e65/MVZ8zdjg==
X-ME-Sender: <xms:gm_pXiTCwIAjMercN7ZVL0lEskXIuqjY8i9tj9fYevtdiAXW2f1i3Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudejuddggeehucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvffutgfgsehtqhertderreejnecuhfhrohhmpedftehn
 ughrvgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucggtf
 frrghtthgvrhhnpedvgeekheegfedvhfethefhudetteegueeggfeiieegueehkedugedt
 kefglefgheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpegrnhgurhgvfiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:gm_pXnwdpXkvHA3B8fsZLEHh9ml9RJYq-5HIt4OmahkgpZk1Urw0jA>
 <xmx:gm_pXv1Ne9H2pDC7MxxsFoJ77P_-yhT2AF5czGA4GR757WLM0HZKrA>
 <xmx:gm_pXuDusImDmhyyMtuj97PA03BD9ssqzohiVJ2GuELWfwE5KKQTpQ>
 <xmx:g2_pXgYqn9wqOrTd4Y0D2Xi8N6MXXlOyi4QamG7QOsNRuHue9d6bNrYaH-Q>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id F097DE00D2; Tue, 16 Jun 2020 21:18:57 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.3.0-dev0-529-g3ee424a-fm-20200611.001-g3ee424a1
Mime-Version: 1.0
Message-Id: <914f089d-e81e-4b01-bd70-4702d8b39724@www.fastmail.com>
In-Reply-To: <20200616075121.12837-8-f4bug@amsat.org>
References: <20200616075121.12837-1-f4bug@amsat.org>
 <20200616075121.12837-8-f4bug@amsat.org>
Date: Wed, 17 Jun 2020 10:48:36 +0930
From: "Andrew Jeffery" <andrew@aj.id.au>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 "Cameron Esfahani via" <qemu-devel@nongnu.org>
Subject: =?UTF-8?Q?Re:_[PATCH_7/7]_hw/watchdog/wdt=5Faspeed:_Reduce_timer_precisi?=
 =?UTF-8?Q?on_to_micro-second?=
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=64.147.123.18; envelope-from=andrew@aj.id.au;
 helo=wnew4-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 21:19:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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



On Tue, 16 Jun 2020, at 17:21, Philippe Mathieu-Daud=C3=A9 wrote:
> The current implementation uses nano-second precision, while
> the watchdog can not be more precise than a micro-second.

What's the basis for this assertion? It's true for the AST2500 and AST26=
00, but=20
the AST2400 can run the watchdog from either a 1MHz clock source or the =
APB=20
clock (which must be at least 16.5MHz on palmetto). The reset state on t=
he
AST2400 configures the watchdog for the APB clock rate.

The Linux driver will eventually configure the watchdog for 1MHz mode
regardless so perhaps the AST2400 reset state is a bit of a corner case,=
 but
I feel the assertion should be watered down a bit?

Andrew

