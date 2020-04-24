Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FBA4C54FD0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 21:59:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 090292098B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 21:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mVqrZWpB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 090292098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jS6M0-0004x2-4I
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 17:59:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50118)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jS6Cp-0008F9-Uv
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 17:49:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jS6Co-0007M9-9o
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 17:49:54 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:44695)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jS6Cn-0007Fl-PB
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 17:49:53 -0400
Received: by mail-pg1-x544.google.com with SMTP id q18so5251185pgm.11
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2020 14:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=/dSm7a0eb+jHHfF9pMuOwiHXLslj0mvOfuKqqBKISPk=;
 b=mVqrZWpBvLP+Vgz7GO5RGcPi1aH8nwtt2FTjyREtyhtI6tU9w3g7lYFcJvvRv5t/ns
 KCYmZKuwijPWy+ekxAl+hAZAcjJRs/SssiQx5cMx1pnYuu+WDhWNRT5JXhuhLZIQjiDr
 SDLL2mu+HFhx8iGYzYFw24mIxQOBs5F+yytAaialRCCgR5qHqkPspUHqbFFyI5RgG+/F
 pjfsY8unxkmDpP4SOQfgfEWvs1F7X73JR0N4MheFpQZUGD5edZy0oLRGohLmwQXngD5L
 6YKLCwyvon1XCM0rCjS46R9i4RCcR2JFl2a0eNrFK+Je+kVQuuidkiKXxJzhT36bwFhw
 EzNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/dSm7a0eb+jHHfF9pMuOwiHXLslj0mvOfuKqqBKISPk=;
 b=Q+ttS8jYX3fALnaEQtHyaLCzFZXMrWEhBPAqDnTmaeDXyHtE03qT5leVgaQCF5qKaE
 bSY8J+4fvpSxDr8agFijity7rrJqojrQ/IxwXGWdog6i++G+stWqL/8yKynkMgIRXVuV
 Y7311P/vkfAEVmbZkyyDQ9Ja098Jjss+7rBUpDHxFFW/PXBViaTtpzSp/jGqKC7+/qxs
 gtHZdz+H5yMkLrpExIdgzrN1pklIgyagzTypyu1yIABA/denCVN67vT2KL97VSgOqGCA
 vjtfUEvm2BsppNKWZ1P6ccd3lAcglpuGypvZh2TpJF8gSEBFQJz0Chv5ohW99QrDHszz
 Fzww==
X-Gm-Message-State: AGi0PuYJzBF6GO4fugGfXWoGN3KBO3GRXGHLub2uXlbz88cWd+hfCuBE
 XQsTsF1291zrhyUiditwokQnyPfRzVQ=
X-Google-Smtp-Source: APiQypIW24ggZ2rmd87dB3vLfOHneNxSYjLUCanN0dseiFzRjzJv93b8AsMWBzaOXr7ZgOUlyE+rdg==
X-Received: by 2002:a63:f46:: with SMTP id 6mr11375223pgp.367.1587764991815;
 Fri, 24 Apr 2020 14:49:51 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id c10sm5746066pgh.48.2020.04.24.14.49.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Apr 2020 14:49:51 -0700 (PDT)
Subject: Re: [PATCH] linux-user: Drop open-coded fcntl flags conversion in
 eventfd2 syscall
To: Helge Deller <deller@gmx.de>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20200424204858.GA26164@ls3530.fritz.box>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <76c818fa-fb77-5cb8-0ae3-76aa3805166e@linaro.org>
Date: Fri, 24 Apr 2020 14:49:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200424204858.GA26164@ls3530.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::544
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/24/20 1:48 PM, Helge Deller wrote:
> Drop the open-coded fcntl flags conversion in the eventfd2 syscall and
> replace it with the built-in conversion with fcntl_flags_tbl.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

