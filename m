Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAFA3C38BFA
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 23:07:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F7A82082F
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 23:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OekE+rQn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F7A82082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6MpI-0005O4-M1
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 18:07:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43575)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j6Mod-0004xM-K1
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 18:07:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j6Moc-0007r7-Hk
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 18:07:07 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:42760)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j6Moc-0007qm-Ct
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 18:07:06 -0500
Received: by mail-pg1-x541.google.com with SMTP id w21so5882126pgl.9
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2020 15:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=IlpT7hToaft1NBoOyrgUoSSudlCch3LjkCKccso2Ha8=;
 b=OekE+rQnEkUyOYy1HfIOxVaonaJqgmbf5qS06CfjKUaQWM21aPxqswkx2x5xpstPoH
 0Q5P7CEQaCKks7ZDquDaEBID7gCPArmcS4hoSwj0dgn/XpFHR++LtiyUUqCRAmJfUNX6
 D3D9b5q4HyU829kRUJ1PYvv+s44uF6MysJw/pyg9juXE6v1dx4VoKjyk4UIhhPY5d5Gt
 GirjsDHx/Pjiost17kYyE880ahwESX8H/qqZ0GwT9dD7RhUNpLx6lTSSn8n1oVCXoFTx
 xNtpPs15hRcl2/B0U94x6VTB3lmmXnko23O5FpMSof6RdWGbSmIhApUFAp/5iJJSftu4
 +VaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IlpT7hToaft1NBoOyrgUoSSudlCch3LjkCKccso2Ha8=;
 b=ES9EmRjFzKhv6jJoKJI6qjXenqDEIg9uYiPnMDJxvytLSbwdIsbSKxf8pagmaDYIhE
 tA1oM8t4UWCfGJhCT/enxT2Y/lsx48g5lwVbnlI/cdDv6y4unw0+cc1ymK9BV48UFRIO
 HDWDeww6/UqgiAo03a38GVMh0rC9t4oRbPzu4smDxFUELemkZAt+KZpOUqzx6ZHuAwDi
 NjPfnC2fJm5hHz8eYHT6CYVndAM4iY70ozV3omykQ53fJqiC9TDA2PYP/qjw6vcy9hmY
 TJGhRpGUlpU6BknJ54u1bNhGVj34fwInKjJuVoCOaUtmVDQ1ju9cgYPNlQX2cGZ3xWfH
 o4Xg==
X-Gm-Message-State: APjAAAUZ6aAAjHQUbE2wZfK3VKbzLXqtdKNjtG9DdvDFkhSkY8hr7SXJ
 SUPfTb9dQbzminedq9pS4ss5VN4FZ8c=
X-Google-Smtp-Source: APXvYqxiesBSP6JaVgt7QVkjnQvu6MHGI2ib20cFIDSO17YcT0R47OQgFMAc0RjyZbkWGU/Ubi60wg==
X-Received: by 2002:a63:ff05:: with SMTP id k5mr54150419pgi.185.1582585624980; 
 Mon, 24 Feb 2020 15:07:04 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 s124sm14465500pfc.57.2020.02.24.15.07.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Feb 2020 15:07:04 -0800 (PST)
Subject: Re: [PATCH] target/arm: Implement ARMv8.3-CCIDX
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200224182626.29252-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <766248a4-5898-1c9d-841d-ee0c45cf3fd6@linaro.org>
Date: Mon, 24 Feb 2020 15:07:02 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200224182626.29252-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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

On 2/24/20 10:26 AM, Peter Maydell wrote:
> The ARMv8.3-CCIDX extension makes the CCSIDR_EL1 system ID registers
> have a format that uses the full 64 bit width of the register, and
> adds a new CCSIDR2 register so AArch32 can get at the high 32 bits.
> 
> QEMU doesn't implement caches, so we just treat these ID registers as
> opaque values that are set to the correct constant values for each
> CPU.  The only thing we need to do is allow 64-bit values in our
> cssidr[] array and provide the CCSIDR2 accessors.
> 
> We don't set the CCIDX field in our 'max' CPU because the CCSIDR
> constant values we use are the same as the ones used by the
> Cortex-A57 and they are in the old 32-bit format. This means
> that the extra regdef added here is unused currently, but it
> means that whenever in the future we add a CPU that does need
> the new 64-bit format it will just work when we set the cssidr
> values and the ID registers for it.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> This is to some extent just ticking off the architecture
> feature from our todo list, but it does avoid an unexpected
> surprise for whoever is the first to need to implement a
> core with ARMv8.3-CCIDX...
> 
> Based-on: 20200224172846.13053-1-peter.maydell@linaro.org
> ("target/arm: Implement v8.3-RCPC and v8.4-RCPC")
> but only to avoid a textual conflict in cpu.h

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

