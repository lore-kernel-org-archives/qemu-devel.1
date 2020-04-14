Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B560FC2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 21:11:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EBD92074D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 21:11:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OPhgkg+x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EBD92074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOSpx-0006Ih-I2
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 17:11:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56003)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jOSp2-0005dw-H9
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 17:10:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jOSp1-0004zX-ET
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 17:10:20 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035]:56104)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jOSp1-0004yw-1x
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 17:10:19 -0400
Received: by mail-pj1-x1035.google.com with SMTP id a32so5833494pje.5
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 14:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=OJqmRpzDh8jYF30yB6zqOJfl60BR+M9sySGIKQ+FurY=;
 b=OPhgkg+xqDuLJcK/CLuWGWgHW7jRXAiI9CLT0M8J6zSxZEec6dAqlz9dJN8NGtQ2lJ
 QrG4ibWiJ6XcOFMTMH4Tpui95jIBwwYwTfdQiiezvw2dNtac+XGBZZwI0Vt10h69esqM
 JJxJbABWewdRMBZVTPmhwZeIl8VEnLGB9uUv9KUT317VERotCS8zsOqYlg88MmgRaQaj
 Jcfxod5QHYjOX2P0rim/T9zaXip+M3Z10uXC/eqCtJLYjEMkQl9lnCtIoRqvhy3RGqxV
 jTYPBjANXCa66Wb9H96q2e+alPAcB6/jG4XOMc2qFiakWTjDC/f4SJN5yGVoJTrQ8r2C
 JrXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OJqmRpzDh8jYF30yB6zqOJfl60BR+M9sySGIKQ+FurY=;
 b=khzqWi0S2Wz7I9e9uZj9sz0GVwEwoM3hsGe9BOMvZrUuWk2J5WUKVB+lA1VRlgjAVa
 SjZtaYq0ROHQoHTCC6ssVIBnLyLzioocMD+5w++gIpUDtTng+L3qlplqfd6vy9hSRBoG
 BrNVwLmovydLk05tX3omJxMYfiVruSPkwFbUi3dsfzAe31ryEZFt6R7qAFJx7GMYRqzy
 BkI+AbczNcox5N0iUwHcZ9Hroc/1LWI4w43pfuVc0qLp/Wvu8tkhmZJoGWoHaSZZClbn
 Sub93Qi3qq8QO9yic+qv1FaW88jHGgx0zReuj3cEkxKvXOdSGbot5kLNN0IMtXrh6z2r
 GQWg==
X-Gm-Message-State: AGi0PuY6EAgCkyyDFA/wGfdARZTUYJN1jBzBJStHvtIVi5H04YdalJf2
 YQli90SuJGnqSCU+bsBKVkYmyg==
X-Google-Smtp-Source: APiQypLWpcktunXd3TqIvULw4m9nkbejOa8VRDAIfq9M1ywptj5VulIsGv+iDDJhCF7O7YTSQeF/oQ==
X-Received: by 2002:a17:902:b941:: with SMTP id
 h1mr1798320pls.174.1586898617674; 
 Tue, 14 Apr 2020 14:10:17 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id w2sm11997991pff.195.2020.04.14.14.10.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Apr 2020 14:10:17 -0700 (PDT)
Subject: Re: [PATCH-for-5.0 v2 2/2] gdbstub: Introduce gdb_get_float64() to
 get 64-bit float registers
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200414143240.21764-1-philmd@redhat.com>
 <20200414143240.21764-3-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f67300a4-e4cb-61bb-1746-833aadf7a2d9@linaro.org>
Date: Tue, 14 Apr 2020 14:10:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200414143240.21764-3-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1035
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
 Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/14/20 7:32 AM, Philippe Mathieu-Daudé wrote:
> When converted to use GByteArray in commits 462474d760c and
> a010bdbe719, the call to stfq_p() was removed. This call
> serialize a float.
> Since we now use a GByteArray, we can not use stfq_p() directly.
> Introduce the gdb_get_float64() helper to load a float64 register.
> 
> Fixes: 462474d760c ("target/m68k: use gdb_get_reg helpers")
> Fixes: a010bdbe719 ("extend GByteArray to read register helpers")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  include/exec/gdbstub.h          | 12 ++++++++++++
>  target/m68k/helper.c            |  3 ++-
>  target/ppc/gdbstub.c            |  4 ++--
>  target/ppc/translate_init.inc.c |  2 +-
>  4 files changed, 17 insertions(+), 4 deletions(-)

This one can wait for 5.1, or be dropped altogether, depending.

In this case, we're only making the artificial distinction between float64 and
uint64_t.  Therefore all of the existing uses of gdb_get_reg64 that you replace
are not bug fixes.  Therefore, not 5.0 material.

I've been considering removing float32 and float64, and just replacing them
with uint32_t and uint64_t, and removing all of the associated shims like
stfq_p.  But I've never quite gotten around to doing that.


r~

