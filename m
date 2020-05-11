Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E99EC47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 09:47:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF39D206F9
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 09:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tjfULMxv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF39D206F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY52T-0000jR-Uh
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 05:47:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42222)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jY512-0007jU-Mi; Mon, 11 May 2020 05:46:28 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:40832)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jY511-0002pC-Rp; Mon, 11 May 2020 05:46:28 -0400
Received: by mail-lf1-x142.google.com with SMTP id u4so6934193lfm.7;
 Mon, 11 May 2020 02:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=gpH2tKXCjUnkJ4UxAw3yg9UWeRqETvSZhoIE66gIUc0=;
 b=tjfULMxv5t3BSqs/JN7wUWndEZqMYaZqFK6eRZML9KlurmdQjAcmSfX5JBOf6fRSFW
 gSyq+YNFmXb8SLmxH8Fbrbh38XL6i6rw+zGGjkN4l15rZsAoT9A5Cw0O8d2ziiIk45II
 VdKEQEmaLiWWq4HCJNW+sFO16P+S2Zx5FwH+9BowQUydjC/7RQszYuriSx9TvJY2nXtQ
 2q3B6TUCBLHKXdM9shi1KNjWkGE+aL71ERDa+ef2FCYOFbvTgspB2uGIuXMp1qebXPiM
 xUHZ/xMfY+hVrF/CXJXFSzUf7zyZu6z7567s0P/YoNF/kypUutYFV5LTKXXZExnAiu3o
 m/bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=gpH2tKXCjUnkJ4UxAw3yg9UWeRqETvSZhoIE66gIUc0=;
 b=O1HtoMidugE068HGvZI2X+roUfj5VBuiDamFMoJHrizH0umr8ByGa0lRA7uMgJdNqg
 YQH8/Ew//OiGtFNuZdvJDZ7B9vDgYmKHYG1Rb5ZhUxTeAlILGYGwRJPhu4WVdmOqHym3
 biudQ35VjQr+VARnPiCWIi+fgLQj79JN9k6r2ANSsqe5T2achgfR5qwoy2VfkpX9qLOg
 1D8rgmJPbl4JQvHrYPpenpkRvXpdDQpGwyNXUjIacGVG4WpBZpo/CxwAxjjMsA35lM7v
 FIkH7Vhy8oH8yi8CZVivAzuz/nh2E2/V+s/6P6bp1yS/u49XgB8ZVI+5pSyiZb2WD5/H
 oUOQ==
X-Gm-Message-State: AOAM531mXVFZvqwGtbpyaxi93eSJ6VIDGNF91oBnLSwY/xIAHphCLwxn
 4P7xP3eYpqCgXpLz/MeybqM=
X-Google-Smtp-Source: ABdhPJwKQcIsUR1P9Gu4NnWXlNjZRtdZ0QmSECJkJzR5ySzhfdIptBEcQ3dJQ8rAXmrZEQ1EJQZr4Q==
X-Received: by 2002:a19:700b:: with SMTP id h11mr10497912lfc.62.1589190384034; 
 Mon, 11 May 2020 02:46:24 -0700 (PDT)
Received: from localhost (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id z5sm9255843lji.30.2020.05.11.02.46.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 02:46:22 -0700 (PDT)
Date: Mon, 11 May 2020 11:46:06 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [PATCH 03/11] sysemu/tcg: Only declare tcg_allowed when TCG is
 available
Message-ID: <20200511094606.GQ5519@toto>
References: <20200509130910.26335-1-f4bug@amsat.org>
 <20200509130910.26335-4-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200509130910.26335-4-f4bug@amsat.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Received-SPF: pass client-ip=2a00:1450:4864:20::142;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x142.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Chris Wulff <crwulff@gmail.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Max Filippov <jcmvbkbc@gmail.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Marek Vasut <marex@denx.de>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, qemu-ppc@nongnu.org,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, Stafford Horne <shorne@gmail.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>, qemu-riscv@nongnu.org,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>, Roman Bolshakov <r.bolshakov@yadro.com>,
 Laurent Vivier <laurent@vivier.eu>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, May 09, 2020 at 03:09:02PM +0200, Philippe Mathieu-Daudé wrote:
> When TCG is not available, the tcg_allowed variable does not exist.

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>



> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  include/sysemu/tcg.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/sysemu/tcg.h b/include/sysemu/tcg.h
> index 7d116d2e80..d9d3ca8559 100644
> --- a/include/sysemu/tcg.h
> +++ b/include/sysemu/tcg.h
> @@ -8,9 +8,9 @@
>  #ifndef SYSEMU_TCG_H
>  #define SYSEMU_TCG_H
>  
> -extern bool tcg_allowed;
>  void tcg_exec_init(unsigned long tb_size);
>  #ifdef CONFIG_TCG
> +extern bool tcg_allowed;
>  #define tcg_enabled() (tcg_allowed)
>  #else
>  #define tcg_enabled() 0
> -- 
> 2.21.3
> 

