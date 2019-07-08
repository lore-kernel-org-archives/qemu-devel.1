Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D5E5C606BF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 14:28:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B77421537
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 14:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aDQNFrO0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B77421537
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkUcl-0001Na-O1
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 10:28:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41948)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <frasse.iglesias@gmail.com>) id 1hkUbJ-0000lU-Db
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 10:26:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frasse.iglesias@gmail.com>) id 1hkUbI-0002YC-3x
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 10:26:41 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:41834)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <frasse.iglesias@gmail.com>)
 id 1hkUbH-0001zF-H5; Mon, 08 Jul 2019 10:26:40 -0400
Received: by mail-lj1-x241.google.com with SMTP id d24so7023886ljg.8;
 Mon, 08 Jul 2019 07:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=ZUjIs7HyOXCHTzrNzHkS1o7+7iYW6+PyowkFVyfSvLU=;
 b=aDQNFrO0AGR/wscuI6Ju3Wcc4KERqlUO2HvJGQFI1aSCrh0DAqGqpeKQmtH+UVLHrv
 TMMweWDqaQxcYh8B6h34PWwcs1nXss9K9sKjYHZqlIO14otUhjmxKdfaLIltDubjbfgl
 NcK3gTnKY0gjNidB5TqkO+lII2km3p+1xxsD4ixCpOO7QJb+lb95fSeOq3fgmNsANKlr
 BalxAl7bAMzdudYiOof7yQdVg8JgXqoe5AKWAfHGpaYqHI7t/t5L9CqrkecUP6sADu0s
 TJMR+J43tRwd1UJO3hFU7ubf74ohbD8+yrRhMbDSgKnG4SqUMSFMgHGPu5j7m5zNqGKf
 ivgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=ZUjIs7HyOXCHTzrNzHkS1o7+7iYW6+PyowkFVyfSvLU=;
 b=JdCNpQFGKzE1ytbgD5HHw0yNZbqQus8y57tn7uY5qkNUHcfXUEO2MVRH7zyi42viag
 iY8m997dmGh4jhq450TASFEwqHXy31DeaGt4AX/a7qWZ4XFdFp/7oyZw7CtsBSzXfJKA
 O/RcX+A9fk28hi2K/9DeaPgQqtdv1cTGXWoaSdCjZrNiFWuka8fzY681VMWAxtK9lJua
 E88viO3huHZTAUElWnissW/kcsmmEYb4DsQUWG8p8YIswngC8d9zfpNKqcQg0iCckV6I
 pQ30b4LTTshsjRgYAgH7EWnYoCyLSZBFea0hCUTUzDZyQRUGuYEbssFV7w5+lE/H+oPz
 ATiw==
X-Gm-Message-State: APjAAAUd2pQnBOPtpNrlSbu+9R24kwwJ81UOIB5BFjKtKG12hJGQ87Ye
 oVfqF164yIi1e3MsGTc95MQ=
X-Google-Smtp-Source: APXvYqyCA+Ms8DRbsdvdOmbBzFctjugv+nuZobEGfk8XGje/ahvz4DjPeJY8nXVkPAYdl6d8MA4TkQ==
X-Received: by 2002:a2e:8999:: with SMTP id c25mr10416692lji.169.1562595986160; 
 Mon, 08 Jul 2019 07:26:26 -0700 (PDT)
Received: from fralle-msi (31-208-27-151.cust.bredband2.com. [31.208.27.151])
 by smtp.gmail.com with ESMTPSA id
 t1sm1870955lji.52.2019.07.08.07.26.25
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 08 Jul 2019 07:26:25 -0700 (PDT)
Date: Mon, 8 Jul 2019 16:26:23 +0200
From: Francisco Iglesias <frasse.iglesias@gmail.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Message-ID: <20190708142622.k4s5oknmzzj4brxd@fralle-msi>
References: <20190708104750.1071-1-philmd@redhat.com>
 <20190708104750.1071-4-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190708104750.1071-4-philmd@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::241
Subject: Re: [Qemu-devel] [PATCH-for-4.1 v5 3/3] hw/ssi/xilinx_spips: Avoid
 out-of-bound access to lqspi_buf[]
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-stable@nongnu.org,
 Alistair Francis <alistair@alistair23.me>, qemu-devel@nongnu.org,
 Prasad J Pandit <ppandit@redhat.com>, Lei Sun <slei.casper@gmail.com>,
 qemu-arm@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Philippe,

On [2019 Jul 08] Mon 12:47:50, Philippe Mathieu-Daudé wrote:
> Both lqspi_read() and lqspi_load_cache() expect a 32-bit
> aligned address.
> 
> From UG1085 datasheet [*] Chapter 22: Quad-SPI Controller:

s/22/24/

After above change:

Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com> 
Tested-by: Francisco Iglesias <frasse.iglesias@gmail.com>

(I tested all three patches so the Tested-by tag can also be appended on the
other two)

Best regards,
Francisco Iglesias

> 
>   Transfer Size Limitations
> 
>     Because of the 32-bit wide TX, RX, and generic FIFO, all
>     APB/AXI transfers must be an integer multiple of 4-bytes.
>     Shorter transfers are not possible.
> 
> Set MemoryRegionOps.impl values to force 32-bit accesses,
> this way we are sure we do not access the lqspi_buf[] array
> out of bound.
> 
> [*] https://www.xilinx.com/support/documentation/user_guides/ug1085-zynq-ultrascale-trm.pdf
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> v5: add datasheet reference, drop RFC prefix, fix build (Francisco)
> ---
>  hw/ssi/xilinx_spips.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
> index 3c4e8365ee..b29e0a4a89 100644
> --- a/hw/ssi/xilinx_spips.c
> +++ b/hw/ssi/xilinx_spips.c
> @@ -1239,6 +1239,10 @@ static const MemoryRegionOps lqspi_ops = {
>      .read_with_attrs = lqspi_read,
>      .write_with_attrs = lqspi_write,
>      .endianness = DEVICE_NATIVE_ENDIAN,
> +    .impl = {
> +        .min_access_size = 4,
> +        .max_access_size = 4,
> +    },
>      .valid = {
>          .min_access_size = 1,
>          .max_access_size = 4
> -- 
> 2.20.1
> 

