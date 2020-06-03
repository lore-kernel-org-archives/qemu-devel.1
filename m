Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F047C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 00:47:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FD6C206E9
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 00:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="wY3J5oII";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="svIqS5v8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FD6C206E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aj.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgHYe-0004VG-Da
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 20:47:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42462)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@aj.id.au>)
 id 1jgHY3-0003xG-R1; Tue, 02 Jun 2020 20:46:27 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:38477)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@aj.id.au>)
 id 1jgHY2-0005sX-CC; Tue, 02 Jun 2020 20:46:27 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.west.internal (Postfix) with ESMTP id 2C82E642;
 Tue,  2 Jun 2020 20:46:23 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
 by compute3.internal (MEProxy); Tue, 02 Jun 2020 20:46:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
 mime-version:message-id:in-reply-to:references:date:from:to:cc
 :subject:content-type; s=fm2; bh=7Yr9sQZveh3RFZSr00zd/xCbOzSG4e2
 csVh5T9HsnJU=; b=wY3J5oIIxNkJpg4siTrGvC8LGKrYEAoaKqo4w18HsAtBVkL
 XhDnYOzCRIJm3HCC70gQxoFsqCRuMsqwOw+/mv4svm0H8l4uyXiMbFzqBDQ44isa
 7jGahCcBaooN300fzLgunSnucX5eNOTXYOyuJllTUNpjQooAunWgvHdWHUEx0blX
 4gow6bqIWPctz9eOcIH7i0ru8udAA7OmVM8H+kwtoS0XHaLsbZy2UIArGGp5PBjq
 G/D/wplLP/DQL/PR5sujHP8W8nWbkcHYkvfX2Lcs4t7h1Rl4QEE647f6f4ilQSSj
 YnsrIUKLnOXGEAMQ7Z7zoqEtZaxoBrbIpdmdRFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=7Yr9sQ
 Zveh3RFZSr00zd/xCbOzSG4e2csVh5T9HsnJU=; b=svIqS5v8T7cqMfIFcREKjj
 1ffHiumk+WPUQ45j7qfAHpyHSVpmeWV6y89gwr5nGD2iSDOk6VoRAMJjXDHtL/LI
 G+mHr2bkv2skfCO1JVnKU/bWE5Xs6HaNFKAnhbaIdL3HjOr+msGbAAI77Ey8NCmy
 UERNat47pDDA8lriG4ZtCMpjgYUZINjVA6wb7QFAYzrkUAYP8kMaOM/KzY0DXPMR
 LXXdOVMKmp2CIuMgM0ELz+4xoIb3Ac8WslpcU1gXfUaNKeVo7LhXBLvqplbMKMR3
 +FF3liM53z0ovmVScdJm3M7qz6dLmFNvli2+QUSkgs8hEDrcBAFOgEpq5trgWuCQ
 ==
X-ME-Sender: <xms:3fLWXnTlkOE_6J-HJUvZ8gSepzyVUE7yWCGHoezKnyvTrcc64K9dEw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudefkedgfeefucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
 rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecuggftrf
 grthhtvghrnhephefhfeekgfekudevheffheeihedujeefjeevjeefudfgfeeutdeuvdeh
 hfevueffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 eprghnughrvgifsegrjhdrihgurdgruh
X-ME-Proxy: <xmx:3fLWXowGvp_rYhBqKlRIf3e8-Skd53g_nuFgX8-4lYo7oN9MuqwFvQ>
 <xmx:3fLWXs3pOiYU9aFwNyMLT-TKIfeUygPn6OY78Ko1XEeqMiQd6DE1ew>
 <xmx:3fLWXnAmA8kzdIIVKpWAQBbWBE7oVGcl8q_U2JzMPTYZR3QIGzqFwQ>
 <xmx:3vLWXjsIUriRek_ZUD9XGx3VQAnlW7GqVp1HJyIjkvioIn2C-Zo4XA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 0BCEEE00C9; Tue,  2 Jun 2020 20:46:21 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.3.0-dev0-519-g0f677ba-fm-20200601.001-g0f677ba6
Mime-Version: 1.0
Message-Id: <e3d11c90-86d9-4daf-ba4c-9da98942e578@www.fastmail.com>
In-Reply-To: <80e5403f-a842-4542-41d3-d1d8236af637@kaod.org>
References: <20200602135050.593692-1-clg@kaod.org>
 <a46437ce-1be4-3c0a-8403-1c279ad8b90b@amsat.org>
 <80e5403f-a842-4542-41d3-d1d8236af637@kaod.org>
Date: Wed, 03 Jun 2020 10:15:59 +0930
From: "Andrew Jeffery" <andrew@aj.id.au>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 "Peter Maydell" <peter.maydell@linaro.org>
Subject: Re: [PATCH] docs/system: Document Aspeed boards
Content-Type: text/plain
Received-SPF: pass client-ip=64.147.123.20; envelope-from=andrew@aj.id.au;
 helo=wout4-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 20:46:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>,
 Cameron Esfahani via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> 
> >> + * Hash/Crypto Engine
> >> + * PCI-Express 1 Controller
> >> + * Graphic Display Controller
> >> + * PECI Controller
> >> + * MCTP Controller
> >> + * Mailbox Controller
> >> + * Virtual UART
> > 
> > Uh what is that? :)
> 
> It is the host console. 
> 

To explain a little more, a 16550-compatible set of registers are exposed to 
both the host (via e.g. the LPC bus) and the BMC, but the FIFOs are shared and 
the transmissions are nothing more than register writes/reads from each side. 
There's no RS-232 involved, hence "Virtual" I guess.

Andrew

