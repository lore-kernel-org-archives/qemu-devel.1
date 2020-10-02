Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A61C35257
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 22:55:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62D2C206DD
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 22:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wlo3diP3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62D2C206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOTxW-0006wA-DM
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 18:55:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44236)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kOTwt-0006Ti-4X
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 18:54:47 -0400
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32]:45295)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kOTwp-0004tJ-LO
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 18:54:46 -0400
Received: by mail-oo1-xc32.google.com with SMTP id h8so758907ooc.12
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 15:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=8d9P+VKui+tfhiRAvIZlxXoig5uZIWgDPjzu2OoFYWY=;
 b=wlo3diP3sO2n+ZCOv0Ss3B8zDYlq7k9cDfCD1VgdpKBJrNaYhJE7WIeXTAs+O2D+Cx
 pAw8IEtmSRORjlRHeq8h8Qz3W586e8eJGopmZ6O2UXmvbDsEdJSbsszlhi7+jeGEuJzG
 u9dIMw9CMUnR2MUELbPa6f6ltuNuDOQmsKzvoRdxFP2241p/H78shFuktd7p7KT9STJO
 OX+9HK0A7JUYZuVl1KqSVB7d9QdxBft5QZJlsAAH+cm617gI/7VPXmMcn8L1PpAa8FIy
 yFuWwbFuRm9Fq8lAT0yGMlVd+MGUNLEHyz/kHtyo4qAtgiMEC8WDXps6FHY4b/WArNHb
 TEUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8d9P+VKui+tfhiRAvIZlxXoig5uZIWgDPjzu2OoFYWY=;
 b=hRUl7kjwQ3aNFERNrkHdrXhqAdHRcKMD/jywBlzHvUmOGcGFFUPBcifgKqPCWjX0HR
 GLw51hzjDuTo9/FkQPrr0Yb4gXM4lFfyRcCRG3JsTGviV0OWk3RAmANYq++rr9YhzmeX
 PCCx8bKmtzCDAXSKfXLhHDug2pR6UA2VXNEnhR301knJv4XmO+hBq43GcxjihIXVE1J5
 Zr7ey7lTsYvC0m845ZTN/ncMVz0jUGsPxnVIcsDMyufK4mqSxeeJNrdRcfTa/1d9MLvO
 GkPDFGCdj7cb+Cm6I1dfmVX6IDXdE8iD2Djme8LzEtCKM5tjpwiaaTQ9QAZ8LXug36KE
 CDSg==
X-Gm-Message-State: AOAM531F1hh68apXRO8OIUZ6O+bexhueBWcbEpMjrnmhCnAsu227rzN9
 jF3WgBTig9Q5xjnG2U/+pBYEO/k2RSQl2Hek
X-Google-Smtp-Source: ABdhPJxME98iaiA4lzj0pOrpOvlvjacjT57Xr5GRz/En1+mVxkmBOHM50ahYSgUNNEQ6w217J4HjBQ==
X-Received: by 2002:a4a:5d84:: with SMTP id w126mr3569066ooa.1.1601679281379; 
 Fri, 02 Oct 2020 15:54:41 -0700 (PDT)
Received: from [10.10.73.179] (fixed-187-189-51-144.totalplay.net.
 [187.189.51.144])
 by smtp.gmail.com with ESMTPSA id q81sm591348oia.46.2020.10.02.15.54.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Oct 2020 15:54:40 -0700 (PDT)
Subject: Re: [PULL v2 00/11] capstone + disassembler patch queue
To: Peter Maydell <peter.maydell@linaro.org>
References: <20201002165127.130369-1-richard.henderson@linaro.org>
 <CAFEAcA_kr5M+TbLDiYVMZbSMgpZE8fN+ae27rgOVkpOj2b9-xQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2d325c7f-1627-3fb7-164b-58caafe22e06@linaro.org>
Date: Fri, 2 Oct 2020 17:54:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_kr5M+TbLDiYVMZbSMgpZE8fN+ae27rgOVkpOj2b9-xQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c32;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc32.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.256,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/2/20 3:37 PM, Peter Maydell wrote:
> Meson warning on the BSDs:
> 
> Configuring sparc-bsd-user-config-target.h using configuration
> Configuring sparc64-bsd-user-config-target.h using configuration
> Configuring x86_64-bsd-user-config-target.h using configuration
> Did not find CMake 'cmake'
> Found CMake: NO
> Run-time dependency capstone found: NO (tried pkgconfig and cmake)
> ../src/meson.build:753: WARNING: Trying to compare values of different
> types (bool, str) using ==.
> The result of this is undefined and will become a hard error in a
> future Meson release.
> Configuring config-host.h using configuration
> Program scripts/hxtool found: YES
> Program scripts/shaderinclude.pl found: YES
> Program scripts/qapi-gen.py found: YES
> Program scripts/qemu-version.sh found: YES
> Run-time dependency threads found: YES
> Program keycodemapdb/tools/keymap-gen found: YES
> Program scripts/decodetree.py found: YES
> 
> Warning from ppc64be box (gcc compilefarm one):
> 
> Configuring sh4eb-linux-user-config-target.h using configuration
> Configuring sparc-linux-user-config-target.h using configuration
> Configuring sparc32plus-linux-user-config-target.h using configuration
> Configuring sparc64-linux-user-config-target.h using configuration
> Configuring x86_64-linux-user-config-target.h using configuration
> Configuring xtensa-linux-user-config-target.h using configuration
> Configuring xtensaeb-linux-user-config-target.h using configuration
> Found CMake: /usr/bin/cmake (2.8.12.2)
> WARNING: The version of CMake /usr/bin/cmake is 2.8.12.2 but version
>> =3.4 is required
> Run-time dependency capstone found: NO (tried pkgconfig and cmake)
> Configuring capstone-defs.h using configuration
> Configuring config-host.h using configuration
> 
> We shouldn't be looking for or using cmake at all.

Huh.  I hadn't noticed that before.
I think it's coming from meson internally, but I'm not sure what's causing.
Certainly it is not something I asked for.

So it's a warning.  Does the build succeed?


r~

