Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C64EFC3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 04:41:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 914B520828
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 04:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q82Ol/YP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 914B520828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2TI4-0005tg-PB
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 00:41:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34795)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <shorne@gmail.com>) id 1i2TGr-0004vz-Ru
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 00:39:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shorne@gmail.com>) id 1i2TGq-0003cw-VB
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 00:39:53 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:37939)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <shorne@gmail.com>) id 1i2TGp-0003cK-Ln
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 00:39:52 -0400
Received: by mail-pf1-x443.google.com with SMTP id o70so13260880pfg.5
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2019 21:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=mwqzT/VtIG2gqBjVTpc7U53j/IGGayZmqrovno0fk+s=;
 b=Q82Ol/YPOMH28PxoD8z7G2ZPbHZYMbcVrUV0X7XYIKZwmCKLqVw3y99ZLLQIIg81n5
 YynS274O6rLN9C2F4TiWV3NWt3Uv7E1bKFPiWAIxd5dABSyukQ2rgqV2oY9P6QOeoq+e
 Yjr/1TfXYkUcUz1mmo5CAzZWHJzBOVYMPD3G1ZhZqtbcZDDURxoYthBdbmynRjHeHdfO
 J1tYvXM1uHsSRGd1OMEH5QvsjRXEXrAKyCgWSGjDvJR9q6DCOGAhVWszDTQ7qir9XUoN
 BzNEsMeRvQWh33EFg0QC96zU5VI+5Bxc/h8coW1tStxWlXJnp5akYugIcPe3zzPNT2QT
 pv9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=mwqzT/VtIG2gqBjVTpc7U53j/IGGayZmqrovno0fk+s=;
 b=OuyipXmsic05Ca6jKC477csGoZNhunO+dx3FhlYo+vmiCa1Hy4E6kMMgdGPTOCdD2x
 Od5yVPXuMDRAfTQZiV0T/Bn0W1muSTuf0E8V3FQcMBZae/q7JDFMJgJee9CAKitcugFk
 KMudfUAf7gpi+prkuRy4N1iY7srkk7s+ii9XIO+Y00sRrdU1S77obzzi1zR+nsFuc0Y4
 m2Ni1sKwarFZbnkkLPtDQXLyE8wMTrC6YeZF4qfiwm+nlzePDqQ9Pvi7b4NZQ644oaOF
 ffdgdWXEdcLSXQ+toLuiwDL5h7+123W1m6Bw9lPVvL/IE9peNzbfa2FbjuZLjs6wbFj3
 Jxkg==
X-Gm-Message-State: APjAAAXxXplatzlsoryzb0GEsx7Ocxzc55fQksLSMuuGkqHi9yyCOCbj
 fERnrTvV357Toi10Ttmamw8=
X-Google-Smtp-Source: APXvYqwYSMgw6nQdUrx4oJZvjAJt2ZT3WavRJ6Nfrupdif8z+Nec/w2ZfXP06Weq/wHWPHX3dxgqjA==
X-Received: by 2002:a65:63c4:: with SMTP id n4mr19303331pgv.44.1566880790113; 
 Mon, 26 Aug 2019 21:39:50 -0700 (PDT)
Received: from localhost (g75.222-224-160.ppp.wakwak.ne.jp. [222.224.160.75])
 by smtp.gmail.com with ESMTPSA id
 j74sm1014767pje.14.2019.08.26.21.39.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2019 21:39:49 -0700 (PDT)
Date: Tue, 27 Aug 2019 13:39:47 +0900
From: Stafford Horne <shorne@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20190827043947.GM24874@lianli.shorne-pla.net>
References: <20190827000745.19645-1-richard.henderson@linaro.org>
 <20190827000745.19645-9-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827000745.19645-9-richard.henderson@linaro.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: Re: [Qemu-devel] [PATCH 08/13] target/openrisc: Check CPUCFG_OF32S
 for float insns
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

On Mon, Aug 26, 2019 at 05:07:40PM -0700, Richard Henderson wrote:
> Make sure the OF32S insns are enabled before allowing execution.
> Include the missing bit for cpu "any".
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Stafford Horne <shorne@gmail.com>

