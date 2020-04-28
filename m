Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F18D6C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 16:54:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAE14208E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 16:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PGGn2gma"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAE14208E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTTUt-0000eO-Sv
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 12:54:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34714)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jTTFz-0007hL-FT
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 12:39:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jTTFX-0003dQ-Pg
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 12:38:51 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:39648)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jTTFX-0003YQ-Cn
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 12:38:23 -0400
Received: by mail-lf1-x144.google.com with SMTP id m2so17435456lfo.6
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2020 09:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=GX1Tskvtx7fhjdqrNdiWEbAn06c1WEohfeYI98p8pNs=;
 b=PGGn2gmaf7SvJwSJ+hnKhyk9bypRS84Q4wBVdVSjBiS9D15EVXCH47XKJ8o07gcWJn
 RWIlrXsnUy232liotV7rklr2x8pA4gsOhx9Y1nUmkRGgLhqCPz2nfj6SdNiZO3mrt8mR
 mlI8ipk3BY4jORjU/GzJiQ0XxSq5gxGhJFiLgld/crGPGgFQ630EJcmEDWmL4XLveyQ0
 sp5NM4j0zmsvJzRbVjRNs92Shz4qxkRVaIp61cvHtwfxg1DjXn0bR8EMRnU9345wI5an
 KhjqZcnKKR5t3boeCMvdV9b4SxOQ6DikgpOtVg+pfdRqbreLddTc9MJf0tcYb2SE4Ti0
 Iuqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=GX1Tskvtx7fhjdqrNdiWEbAn06c1WEohfeYI98p8pNs=;
 b=Zb4APPmR5unKh6PZqQfomx6Hqi09bqvnnnia7o+u5D4AUxtPGXlM2P/9DiTvIzJlYS
 jOeTIRHsJW0ei+hDmfmeQ7mcRWZAVKJcWCiX7UtbuTouRqC6SZmc9BuzLjcnEvg5Ph0a
 Uia2bJgEQu69dMQXM2hmQ2w0vMvlZFVr2iyl7YBdVZiLBW6DxXtg56RP9/TNt8DKZ2AJ
 rXnlAKjHp0ozD5bP+IifJk571Yt9wlc8bQ8AD4SL1vmWEZWgK0tHA4JKkrXoQi/NKs42
 uuRkUxcVJSH8AreA7uFwFuuPxnpOMcfl6Q0y2ZbLHS5+6edLKbiRmHiercGHLATJUqZ8
 u0jQ==
X-Gm-Message-State: AGi0PubzkhWVzi7OzKgKTp9S9WMBWZHSTvRojOppDoM+rnUtpoPZcRHs
 tg00TPltF0AS024RKtOGImw=
X-Google-Smtp-Source: APiQypIWUsCqgshC0C+B/FMSYWzje2LyYiNtGas3o/GjpaDC5mR8/T8Or9JO0sH+evC35oH8Dw8IJg==
X-Received: by 2002:ac2:46ea:: with SMTP id q10mr20399566lfo.128.1588091900398; 
 Tue, 28 Apr 2020 09:38:20 -0700 (PDT)
Received: from localhost (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id u7sm11899707ljk.32.2020.04.28.09.38.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2020 09:38:19 -0700 (PDT)
Date: Tue, 28 Apr 2020 18:37:47 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Vikram Garhwal <fnu.vikram@xilinx.com>
Subject: Re: [PATCH v3 4/4] MAINTAINERS: Add maintainer entry for Xilinx
 ZynqMP CAN
Message-ID: <20200428163747.GN2669@toto>
References: <1587603369-14644-1-git-send-email-fnu.vikram@xilinx.com>
 <1587603369-14644-5-git-send-email-fnu.vikram@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587603369-14644-5-git-send-email-fnu.vikram@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Received-SPF: pass client-ip=2a00:1450:4864:20::144;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x144.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::144
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Apr 22, 2020 at 05:56:09PM -0700, Vikram Garhwal wrote:
> Add myself as Xilinx CAN maintainer.

Hi Vikram,

I think it would be good to add Francisco Iglesias <francisco.iglesias@xilinx.com>
as co-maintainer since he's been involved with this too.

Anyway:
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>



> 
> Signed-off-by: Vikram Garhwal <fnu.vikram@xilinx.com>
> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8cbc1fa..6223573 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1433,6 +1433,13 @@ F: hw/net/opencores_eth.c
>  
>  Devices
>  -------
> +Xilinx CAN
> +M: Vikram Garhwal <fnu.vikram@xilinx.com>
> +S: Maintained
> +F: hw/net/can/xlnx-*
> +F: include/hw/net/xlnx-*
> +F: tests/qtest/xlnx-can-test*
> +
>  EDU
>  M: Jiri Slaby <jslaby@suse.cz>
>  S: Maintained
> -- 
> 2.7.4
> 
> 

