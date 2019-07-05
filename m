Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB9BC5B57D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 23:03:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5741B21738
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 23:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q2FbWTCr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5741B21738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjXEt-0005Iy-Ie
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 19:03:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56688)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <frasse.iglesias@gmail.com>) id 1hjWdD-0007DM-27
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 18:24:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frasse.iglesias@gmail.com>) id 1hjWdC-0001Wp-5N
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 18:24:38 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:45805)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <frasse.iglesias@gmail.com>)
 id 1hjWdB-0001Tl-Bz; Fri, 05 Jul 2019 18:24:37 -0400
Received: by mail-lj1-x244.google.com with SMTP id m23so10506987lje.12;
 Fri, 05 Jul 2019 15:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=XW3tmrwiN3lQGHCFyidFYxKHrgyhO62gI0oGWxjTRsM=;
 b=q2FbWTCrsorrIH+D8uBPpBxoBPMFzqUoJ0FySqRd8iXxZjcX16zXzvCtwdPHPHUs6W
 SOGQw8l1xSNO9nysD/a67O+sc42OE9hGNBziIhbwmZZ0zluAEyO/yd00Yxinpz09ir9C
 cypYl2jL97L9UKGbOsqPT6l6Yxj1TTE350CPygL2LpItZmtDDxGMcw/f8578Yqtg33K4
 +w9vumWoaPnOOXpj77II7h1fEIGXu0q1BEDOvhCtCrAwTuewvzRb3BguYEMrVmdQgv61
 Fd6q6DkPw9dk65X1EsSEcpg1PkcRydLuxugoNeyLcZeWw92S/m/vs6jwK60Yw1aRI19b
 9rJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=XW3tmrwiN3lQGHCFyidFYxKHrgyhO62gI0oGWxjTRsM=;
 b=BE+ve23l+Ynoc4p8itKJsPkxBSr9NoEjP8/TiAM00jYe7mehU8DBxo5yeaJF3W/5k2
 hW3/UM8onbCVZTv7NPcGfy4Cs4ZnNdaw+vQ+2stvd+jOIqyLUsbFZ2FYSsikvfZcZldL
 JnEeuBJFkKeKY7tx6BvvWqk/qtoEtO1DDelvhOdp8mirg68VegSRDSFRaKcHb8xnE3Eo
 vTWh66i4dm5UVj9J2i8dLx08uyp0XnlnIMije1EODULIzuWJiFU5vkKeRncbc2XlQXr8
 ye2MqJw/AUDVW3norcYn0PAgWR/UKKACXHO8ZUe5Eg51CbGvY2y+boIreviYNO2mj5Jj
 0Rgw==
X-Gm-Message-State: APjAAAXDFRiOOGOTw1BIB2PCeDMlf3cAtw4YprKUrnu0PIoIqTNvXBUB
 Z9detRPoYBh0Qod0dN4B5PA=
X-Google-Smtp-Source: APXvYqxiSFenwZ9l3V1vC5ooT6tzJ+gkmuG6PcNMrdaiHNAI5J4J79+6NMuMmAfgplc7ZlS/eE/7Rw==
X-Received: by 2002:a2e:9d18:: with SMTP id t24mr3485658lji.2.1562365473110;
 Fri, 05 Jul 2019 15:24:33 -0700 (PDT)
Received: from fralle-msi (31-208-27-151.cust.bredband2.com. [31.208.27.151])
 by smtp.gmail.com with ESMTPSA id
 b192sm1575650lfg.75.2019.07.05.15.24.32
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 05 Jul 2019 15:24:32 -0700 (PDT)
Date: Sat, 6 Jul 2019 00:24:30 +0200
From: Francisco Iglesias <frasse.iglesias@gmail.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Message-ID: <20190705222429.ox6z6wckkupjpug2@fralle-msi>
References: <20190705202500.18853-1-philmd@redhat.com>
 <20190705202500.18853-4-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190705202500.18853-4-philmd@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::244
Subject: Re: [Qemu-devel] [RFC PATCH-for-4.1 v4 3/3] hw/ssi/xilinx_spips:
 Avoid out-of-bound access to lqspi_buf[]
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, qemu-devel@nongnu.org,
 Prasad J Pandit <ppandit@redhat.com>, Lei Sun <slei.casper@gmail.com>,
 qemu-arm@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Philippe,

On [2019 Jul 05] Fri 22:25:00, Philippe Mathieu-Daudé wrote:
> Both lqspi_read() and lqspi_load_cache() expect a 32-bit
> aligned address.
> 
> Set MemoryRegionOps.impl values to force 32-bit accesses,
> this way we are sure we do not access the lqspi_buf[] array
> out of bound.

The patch and correction follows chapter 24 aswell (UG1085) so I suggest
dropping 'RFC' in the subject.

> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> Late friday patch...
> 
>  hw/ssi/xilinx_spips.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
> index 3c4e8365ee..8f705132a3 100644
> --- a/hw/ssi/xilinx_spips.c
> +++ b/hw/ssi/xilinx_spips.c
> @@ -1243,6 +1243,10 @@ static const MemoryRegionOps lqspi_ops = {
>          .min_access_size = 1,
>          .max_access_size = 4
>      }

A comma is missing on the line above (else the patch doesn't compile).

Best regards,
Francisco

> +    .impl = {
> +        .min_access_size = 4,
> +        .max_access_size = 4,
> +    }
>  };
>  
>  static void xilinx_spips_realize(DeviceState *dev, Error **errp)
> -- 
> 2.20.1
> 

