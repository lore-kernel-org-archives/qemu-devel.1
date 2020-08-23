Return-Path: <SRS0=gE17=CB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEEA0C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2020 18:18:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D31D20768
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2020 18:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=phystech-edu.20150623.gappssmtp.com header.i=@phystech-edu.20150623.gappssmtp.com header.b="FpZ9FcLq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D31D20768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=phystech.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9uZh-0000Mj-Mz
	for qemu-devel@archiver.kernel.org; Sun, 23 Aug 2020 14:18:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53022)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <viktor.prutyanov@phystech.edu>)
 id 1k9uZC-0008OL-1X
 for qemu-devel@nongnu.org; Sun, 23 Aug 2020 14:18:06 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:39038)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <viktor.prutyanov@phystech.edu>)
 id 1k9uZA-0004zX-B8
 for qemu-devel@nongnu.org; Sun, 23 Aug 2020 14:18:05 -0400
Received: by mail-lj1-x244.google.com with SMTP id v9so7152117ljk.6
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2020 11:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phystech-edu.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :organization:mime-version:content-transfer-encoding;
 bh=mva65Oq5LuhrzbOZn7DUZL599O1RNxpdrYcFYJECt1U=;
 b=FpZ9FcLqG0d9+TSxduZLoByGQjQ4xhnx1B94bEHzpJHSnr5MUFeyp5OhjfTIl9/MuO
 o2hBafPdodb24RknioBLFGFXkb1pZK9mXptVSaQA8sN3Uimi7ViZNYWMC3aIQdZwd/kr
 JqprwOJHPp3ByEopTykBvp9+ZI5jyV8hbfcJDI1TBrbUUNfJH0VIU4DDMNTZKRgdbxPN
 b2ZH2mheBJwuukO9uYwMdGuS0kelPywhW96c3t0qGF3TCVfl035w9D0wDo2KzClbB29G
 EED3oywsLgLyAAPwtLfoYoPe690XBDwMdRe1K7Qe/BpRJpR8o3vF0BE9CV0vSEOi7XRo
 GtMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:organization:mime-version:content-transfer-encoding;
 bh=mva65Oq5LuhrzbOZn7DUZL599O1RNxpdrYcFYJECt1U=;
 b=h/KNpSfrhwNlWUff9gNfp3BBB4oDefYhNtkD+dvaUqYXt38KD90PKPNngwt2UAgT4l
 dglC+J4U0UEFGbMSTK37Q3dfRMgCcqAkCyhMKjSe55+fmQ1ad1DzkWCkzTHgYj97vnOR
 XBVnb6w/mv42gNm0RL2Vdfji0MGBNx3HqsSKhgRXXr6uv1Kv7zfqqIO4dXOFhKj31zrT
 SwTSbuiu4vCsbwjx4+dBW9La0XAW77G5B15h7cfugn2sDxH2oj2B5S8Np/ZUQW7c/xus
 9NbUFmuBNhCvDDjlWSPZMEooSkb1I5jOOHDLusMUKF6FtKo/gLWfWfASXm2r9zpH2AYq
 ly2g==
X-Gm-Message-State: AOAM531k+Bud69pAqErow3dClJNgrZVMM6tFabOPXx2mGh9J7Zg72fpi
 ORE+yuCoqK8hm5L5iCt0dTzFMQ==
X-Google-Smtp-Source: ABdhPJxfUH3+jnfDfBIis3HxGQTw+z8vrbX5vox98JTgNwHmvZuY9TRFGrq6i4psHPAAQpUJjwZbFw==
X-Received: by 2002:a2e:9196:: with SMTP id f22mr1015359ljg.435.1598206682079; 
 Sun, 23 Aug 2020 11:18:02 -0700 (PDT)
Received: from localhost ([178.176.74.168])
 by smtp.gmail.com with ESMTPSA id r9sm1729109ljj.41.2020.08.23.11.18.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2020 11:18:01 -0700 (PDT)
Date: Sun, 23 Aug 2020 21:17:59 +0300
From: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
To: Pan Nengyuan <pannengyuan@huawei.com>
Subject: Re: [PATCH 04/12] elf2dmp/pdb: Plug memleak in pdb_init_from_file
Message-ID: <20200823211759.374c413c@phystech.edu>
In-Reply-To: <20200814160241.7915-5-pannengyuan@huawei.com>
References: <20200814160241.7915-1-pannengyuan@huawei.com>
 <20200814160241.7915-5-pannengyuan@huawei.com>
Organization: MIPT
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::244;
 envelope-from=viktor.prutyanov@phystech.edu; helo=mail-lj1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kuhn.chenqun@huawei.com, euler.robot@huawei.com, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 14 Aug 2020 12:02:33 -0400
Pan Nengyuan <pannengyuan@huawei.com> wrote:

> Missing g_error_free in pdb_init_from_file() error path. Fix that.
> 
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
> ---
> Cc: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
> ---
>  contrib/elf2dmp/pdb.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/contrib/elf2dmp/pdb.c b/contrib/elf2dmp/pdb.c
> index a5bd40c99d..b3a6547068 100644
> --- a/contrib/elf2dmp/pdb.c
> +++ b/contrib/elf2dmp/pdb.c
> @@ -285,6 +285,7 @@ int pdb_init_from_file(const char *name, struct
> pdb_reader *reader) reader->gmf = g_mapped_file_new(name, TRUE,
> &gerr); if (gerr) {
>          eprintf("Failed to map PDB file \'%s\'\n", name);
> +        g_error_free(gerr);
>          return 1;
>      }
>  

Reviewed-by: Viktor Prutyanov <viktor.prutyanov@phystech.edu>

-- 
Viktor Prutyanov

