Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C8BC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 10:56:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7050206A5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 10:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="gysRD4V6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T/pavc9I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7050206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aj.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVYlg-0008GI-3i
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 06:56:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44080)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@aj.id.au>)
 id 1jVYh5-0005OW-PU; Mon, 04 May 2020 06:51:27 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:40699)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@aj.id.au>)
 id 1jVYh4-0002To-Ed; Mon, 04 May 2020 06:51:27 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.west.internal (Postfix) with ESMTP id DB7D46B8;
 Mon,  4 May 2020 06:51:22 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
 by compute3.internal (MEProxy); Mon, 04 May 2020 06:51:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
 mime-version:message-id:in-reply-to:references:date:from:to:cc
 :subject:content-type; s=fm2; bh=DADLxHaieEJ+JCJUlhevE7XfuFfJugz
 yd0bkM/NLtJo=; b=gysRD4V6xu2VsGGlWFL5j2Syl4RKh/g9klyznJZCsEwHkyZ
 z5sCt/aD0NYRmVA0+MBW7vv3kf8Qv+iN3b4ad1N+OB1zg8qZqdDX5cbaFRDMDnhN
 GRpx707/9Ee3hKAXzA1VsmE1/8Xl17qPv+/EgqzZOtEslvvUPWH3YSTji/Pk5TW8
 sfQw1BjCqkGP/l3l7uQuJ+JNiFN71OVQcjvJdTJRjrUcW5KQVgyIRtu+qF4Fa8hM
 xhG3claYtDfIwXYVoN3H54iZLK7HasU/UzgeXEP6Y950r8L/thHO1FM3LKblT4QZ
 /MPLKYVbb1L6jyVuwenBt0RGlB1tZso2xi5aTrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=DADLxH
 aieEJ+JCJUlhevE7XfuFfJugzyd0bkM/NLtJo=; b=T/pavc9IW1VhQFO5F9H8Vm
 a7YgKPzY3cwDBAk5MAufQbGyIHLd+UM8yQy6Y8W8CGG5PoAaZJIG9IDJLIg09o9Y
 GXZ03myDRrJp10QXIDvMDHP4brw3vdVaWB1j6IicYY9w7pdLVi1PCglOI8mJIdKi
 q6IKdgFKDk8L5ozWCHK9/6LZqvr0DlCsuS/dkCtC4SJFXs/yatK0P/Bjv9aKGjdG
 JZSJABqFgqwypAOGj8Q+kQ8nupFs483ud5km8oAV9b+WKOQgG9mi4r5CGlMfmD+6
 SnOtcQ36e8xcHj2kUxVbksFIg0gTcxS10agNsU9rGXn68sW1M4mDsE2YpV3zaChg
 ==
X-ME-Sender: <xms:qfOvXr7kbK7gFWjZ78LfIQR66HpYMbX_6-bI6kct50H9mc7HMzfn7g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrjeeggdeftdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehnughr
 vgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucggtffrrg
 htthgvrhhnpeehhfefkefgkeduveehffehieehudejfeejveejfedugfefuedtuedvhefh
 veeuffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 grnhgurhgvfiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:qfOvXokvqa8s2iDpdzpQbHhqzmwOqb7mQkQyX049IVHxRidWw5K7Hw>
 <xmx:qfOvXkpjuM4SStQG6d-CNwpFxGzFi5XQSfodbpPHY56VHWct468JDQ>
 <xmx:qfOvXq1HmCqFKnbrvJMPqUGfKbyfJe66VB2HM5Jn9Ow-21O8U3xLqQ>
 <xmx:qvOvXmwcbfRePxzuKKZ4CAmnlCCnUzlktztdCXknP4fCYQGKWrowOA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 350DAE00A9; Mon,  4 May 2020 06:51:21 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.3.0-dev0-351-g9981f4f-fmstable-20200421v1
Mime-Version: 1.0
Message-Id: <fbe6fc06-2aaf-4125-82ce-dd3acd9a1158@www.fastmail.com>
In-Reply-To: <20200504093703.261135-1-joel@jms.id.au>
References: <20200504093703.261135-1-joel@jms.id.au>
Date: Mon, 04 May 2020 20:21:01 +0930
From: "Andrew Jeffery" <andrew@aj.id.au>
To: "Joel Stanley" <joel@jms.id.au>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 "Peter Maydell" <peter.maydell@linaro.org>
Subject: Re: [PATCH] aspeed: Support AST2600A1 silicon revision
Content-Type: text/plain
Received-SPF: pass client-ip=64.147.123.21; envelope-from=andrew@aj.id.au;
 helo=wout5-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 06:51:23
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
Cc: qemu-arm@nongnu.org, Cameron Esfahani via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On Mon, 4 May 2020, at 19:07, Joel Stanley wrote:
> There are minimal differences from Qemu's point of view between the A0
> and A1 silicon revisions.
> 
> As the A1 exercises different code paths in u-boot it is desirable to
> emulate that instead.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  hw/arm/aspeed.c              |  8 ++++----
>  hw/arm/aspeed_ast2600.c      |  6 +++---
>  hw/misc/aspeed_scu.c         | 11 +++++------
>  include/hw/misc/aspeed_scu.h |  1 +
>  4 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index 99a0f3fcf36e..91301efab32d 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -93,7 +93,7 @@ struct AspeedBoardState {
>  
>  /* Tacoma hardware value */
>  #define TACOMA_BMC_HW_STRAP1  0x00000000
> -#define TACOMA_BMC_HW_STRAP2  0x00000000
> +#define TACOMA_BMC_HW_STRAP2  0x00000040
>  
>  /*
>   * The max ram region is for firmwares that scan the address space
> @@ -585,7 +585,7 @@ static void 
> aspeed_machine_ast2600_evb_class_init(ObjectClass *oc, void *data)
>      AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
>  
>      mc->desc       = "Aspeed AST2600 EVB (Cortex A7)";
> -    amc->soc_name  = "ast2600-a0";
> +    amc->soc_name  = "ast2600-a1";
>      amc->hw_strap1 = AST2600_EVB_HW_STRAP1;
>      amc->hw_strap2 = AST2600_EVB_HW_STRAP2;
>      amc->fmc_model = "w25q512jv";
> @@ -600,8 +600,8 @@ static void 
> aspeed_machine_tacoma_class_init(ObjectClass *oc, void *data)
>      MachineClass *mc = MACHINE_CLASS(oc);
>      AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
>  
> -    mc->desc       = "Aspeed AST2600 EVB (Cortex A7)";
> -    amc->soc_name  = "ast2600-a0";
> +    mc->desc       = "OpenPOWER Tacoma BMC (Cortex A7)";

Lol, whoops.

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

