Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD2D7C35240
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 04:25:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 884F122314
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 04:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="GnnU2suy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z68zi0Ud"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 884F122314
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aj.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itl6T-0000lX-Or
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 23:25:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59295)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrew@aj.id.au>) id 1itl5p-0000Ek-H0
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 23:24:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrew@aj.id.au>) id 1itl5o-0004Pk-H7
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 23:24:45 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:58449)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrew@aj.id.au>)
 id 1itl5m-0004OF-8b; Mon, 20 Jan 2020 23:24:42 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 00F3321B7C;
 Mon, 20 Jan 2020 23:24:42 -0500 (EST)
Received: from imap2 ([10.202.2.52])
 by compute4.internal (MEProxy); Mon, 20 Jan 2020 23:24:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
 mime-version:message-id:in-reply-to:references:date:from:to:cc
 :subject:content-type; s=fm1; bh=+ql6XpaYv26lkBKja4dJPr0iK4DSRdQ
 qdM4NAxVmIOE=; b=GnnU2suygUo+36JMN6ZNnAISDWZQe9hHQtGF1T92EhFMA2t
 74Io03QPTKxqOFptH4sUUdO4i2Jv0vOUBPDpDka8P4XCFpY0mbGqJEtrxr8ZXB54
 HFbeRdgDct9QKwM85K5plL1hKk6/L/knV6VqePMSkfq1IgHCG43IgaKCw1hbMFKh
 xxCvo1fQDy3fALwzWB4dylStzqOu4IwBvZWGF2kGBjGavcBaOoD+a1x8o/fP0zIs
 VSI53e7s1hST2z8B+iLGSvFWGAuRW3Qy4L1HBms3RZTN/3o2Jf9RqN3AJvDDB5zp
 x6VsjVV9O8lvV15QXa3L+ymur05AtL5pYJq0OGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=+ql6Xp
 aYv26lkBKja4dJPr0iK4DSRdQqdM4NAxVmIOE=; b=Z68zi0UdI2khSOAl7cFdLj
 2qeRsM/63BJaYNBs6ULIQn6w1oxgAaKVZQXBhdBqbXcEz9JN8IynsO7nNIx3EZVQ
 qcoP3K2lYC/JKN9oZMtlOZ+0mQjglAFJg7SEcl3wGvGWYjpLWLrrkdzjokEHK19w
 STKXW5q0yXM4c2exrsb1JBvKLBVE9aoVYIFcRot3jvMQoJUGc8VcVHK6nIuqdORX
 rkYJYN4szI+nJg+qPcb/LfbcYZFxHHazp6e2QRTxoBmwwRTund1Le4WqAH+pZ39+
 U3oUCp2PRPT6OUo/CUNOYd+pn2VTe/dFJCDmLd5eFP4/UdZO45dC25QsJ/sTByEw
 ==
X-ME-Sender: <xms:CX0mXtR6luiqxHj-Yyjgi1y8FKsZQsWIvKIRyjGsKH2N40iWpQCxXA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrudejgdeikecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehnughr
 vgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucevlhhush
 htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghj
 rdhiugdrrghu
X-ME-Proxy: <xmx:CX0mXm5Fblin7a5qHdOEOBtvsWIZDDbnoirgUPZBQ3Dwkzc40PRmQA>
 <xmx:CX0mXqxtj4zQymi-AVkNqI6UDWGcpyhCQ1S2W5w5dF9_p41OoCZyNg>
 <xmx:CX0mXtT6WFvVn2NV3cXIkJhOevl9M-UtBwd16wYEv5rnVOY7yybCxw>
 <xmx:CX0mXtT1ZvHaCvGIXNV7A_h74wijFbVAWSDE71egmqLxZiXHNawqHQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 69173E00A2; Mon, 20 Jan 2020 23:24:41 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-754-g09d1619-fmstable-20200113v1
Mime-Version: 1.0
Message-Id: <d6dc47da-2e84-4be8-b299-1cc092266f33@www.fastmail.com>
In-Reply-To: <20200121013302.43839-3-joel@jms.id.au>
References: <20200121013302.43839-1-joel@jms.id.au>
 <20200121013302.43839-3-joel@jms.id.au>
Date: Tue, 21 Jan 2020 14:53:54 +1030
From: "Andrew Jeffery" <andrew@aj.id.au>
To: "Joel Stanley" <joel@jms.id.au>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 "Peter Maydell" <peter.maydell@linaro.org>
Subject: Re: [PATCH 2/2] aspeed/scu: Implement chip ID register
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 66.111.4.27
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
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On Tue, 21 Jan 2020, at 12:03, Joel Stanley wrote:
> This returns a fixed but non-zero value for the chip id.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
> ---
>  hw/misc/aspeed_scu.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
> index 7108cad8c6a7..19d1780a40da 100644
> --- a/hw/misc/aspeed_scu.c
> +++ b/hw/misc/aspeed_scu.c
> @@ -77,6 +77,8 @@
>  #define CPU2_BASE_SEG4       TO_REG(0x110)
>  #define CPU2_BASE_SEG5       TO_REG(0x114)
>  #define CPU2_CACHE_CTRL      TO_REG(0x118)
> +#define CHIP_ID0             TO_REG(0x150)
> +#define CHIP_ID1             TO_REG(0x154)
>  #define UART_HPLL_CLK        TO_REG(0x160)
>  #define PCIE_CTRL            TO_REG(0x180)
>  #define BMC_MMIO_CTRL        TO_REG(0x184)
> @@ -115,6 +117,8 @@
>  #define AST2600_HW_STRAP2_PROT    TO_REG(0x518)
>  #define AST2600_RNG_CTRL          TO_REG(0x524)
>  #define AST2600_RNG_DATA          TO_REG(0x540)
> +#define AST2600_CHIP_ID0          TO_REG(0x5B0)
> +#define AST2600_CHIP_ID1          TO_REG(0x5B4)
>  
>  #define AST2600_CLK TO_REG(0x40)
>  
> @@ -182,6 +186,8 @@ static const uint32_t 
> ast2500_a1_resets[ASPEED_SCU_NR_REGS] = {
>       [CPU2_BASE_SEG1]  = 0x80000000U,
>       [CPU2_BASE_SEG4]  = 0x1E600000U,
>       [CPU2_BASE_SEG5]  = 0xC0000000U,
> +     [CHIP_ID0]        = 0x1234ABCDU,
> +     [CHIP_ID1]        = 0x88884444U,
>       [UART_HPLL_CLK]   = 0x00001903U,
>       [PCIE_CTRL]       = 0x0000007BU,
>       [BMC_DEV_ID]      = 0x00002402U
> @@ -307,6 +313,8 @@ static void aspeed_ast2500_scu_write(void *opaque, 
> hwaddr offset,
>      case RNG_DATA:
>      case FREE_CNTR4:
>      case FREE_CNTR4_EXT:
> +    case CHIP_ID0:
> +    case CHIP_ID1:
>          qemu_log_mask(LOG_GUEST_ERROR,
>                        "%s: Write to read-only offset 0x%" HWADDR_PRIx 
> "\n",
>                        __func__, offset);
> @@ -620,6 +628,8 @@ static void aspeed_ast2600_scu_write(void *opaque, 
> hwaddr offset,
>      case AST2600_RNG_DATA:
>      case AST2600_SILICON_REV:
>      case AST2600_SILICON_REV2:
> +    case AST2600_CHIP_ID0:
> +    case AST2600_CHIP_ID1:
>          /* Add read only registers here */
>          qemu_log_mask(LOG_GUEST_ERROR,
>                        "%s: Write to read-only offset 0x%" HWADDR_PRIx 
> "\n",
> @@ -648,6 +658,9 @@ static const uint32_t 
> ast2600_a0_resets[ASPEED_AST2600_SCU_NR_REGS] = {
>      [AST2600_CLK_STOP_CTRL2]    = 0xFFF0FFF0,
>      [AST2600_SDRAM_HANDSHAKE]   = 0x00000040,  /* SoC completed DRAM 
> init */
>      [AST2600_HPLL_PARAM]        = 0x1000405F,
> +    [AST2600_CHIP_ID0]          = 0x1234ABCD,
> +    [AST2600_CHIP_ID1]          = 0x88884444,

Probably should add the explicit trailing 'U' to the constants at some point.

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

