Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A26C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 01:56:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D15CD214D8
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 01:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WsVL++Iz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D15CD214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifDiq-00072p-1j
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 20:56:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45227)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ifDhy-0006RR-Vu
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 20:56:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ifDhx-0001On-QR
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 20:56:02 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:36072)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ifDhx-0001MJ-Gs
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 20:56:01 -0500
Received: by mail-pf1-x441.google.com with SMTP id x184so254059pfb.3
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 17:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ZcpmQQfWOxKGqTFSxMEKdaMLE/l4mvb0EyNfdGxA7g0=;
 b=WsVL++IzOAmRyHiVEHDRVSBjhsDi/SnZivmlTsKiEChne+P8jVI3yM2Li21eHRcc4c
 Ev4R+uxUidf08FOChuAKAADyZBsjsfesfaMFolhkQrVDK/LG1K4HWEsW80LnYJbRee2C
 hmw0A4sKd6PCiSvUnsz0TIWXDYlE7A+5YUSwoVaHfA7vq4Tcqie/A0o1xF57q8R0hW0e
 V6cgz5z9jGNC93Z00YiTAx4ub9IeqBV9/QWh8+AoIyGAIs9uSt41brEm6cXs05/xad3z
 hBun3TftB/2OSddVF1XGB4DE0BZcwaNLlIeY6PApnAuU3BN0sul79xBevbwsFPk7oeyI
 YZ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZcpmQQfWOxKGqTFSxMEKdaMLE/l4mvb0EyNfdGxA7g0=;
 b=B622kg48fqF+Dsk2Ea8JxpYdOoICgM1kqanz9XCzD8Io1yiBCYIu+0bygcNCgcduYA
 di7mwFfo/ltW22C4qtAhq1e4g7Y66FlISVGkcW85Y5y+d6Co3LhNxf/Gg7LHA1FQmMHB
 8BX3R2rnbuDCSZybpQ7m7QVxYAf0oBGYHyYd6/YDR01GsFA9chCKTQ+62K9ksXppLl+o
 cWsiy8PpHuwhPqhRtZ4mnEOuUHsGwarSDkO55jltxiI1Smjmw2JNdT2m4xwdvAW5L3IK
 B/pI39emvxr5k+Dn0dQt0eyAXcCKdg9+2wKTYYJOA4U6c5vILg3okCZRNdWx2yrnf6+m
 777g==
X-Gm-Message-State: APjAAAUYfPTy9FYUyAJbgBf0hvtAiy/2F3o8/t0fiLbqsInE1YubUsWu
 sd1RzI85u3sgyO11Thgi7H6pwQ==
X-Google-Smtp-Source: APXvYqyhITzwXVS5e7icg7DK8QtXs5njvApH9ofZ43U7RW9EK0jR2qhd6W2itNOLUREGZTE7XU+kuA==
X-Received: by 2002:a63:4702:: with SMTP id u2mr7765676pga.125.1576115760284; 
 Wed, 11 Dec 2019 17:56:00 -0800 (PST)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id u190sm4459483pfb.60.2019.12.11.17.55.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Dec 2019 17:55:59 -0800 (PST)
Subject: Re: [PATCH v3 08/20] gdbstub: extend GByteArray to read register
 helpers
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191211170520.7747-1-alex.bennee@linaro.org>
 <20191211170520.7747-9-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <134bfe14-23c3-4301-bb45-80024f9eb4fb@linaro.org>
Date: Wed, 11 Dec 2019 17:55:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191211170520.7747-9-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
 luis.machado@linaro.org, Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Max Filippov <jcmvbkbc@gmail.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Marek Vasut <marex@denx.de>,
 alan.hayward@arm.com, "open list:PowerPC TCG CPUs" <qemu-ppc@nongnu.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "open list:S390 TCG CPUs" <qemu-s390x@nongnu.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 Stafford Horne <shorne@gmail.com>, David Gibson <david@gibson.dropbear.id.au>,
 damien.hedde@greensocs.com,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Chris Wulff <crwulff@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Michael Walle <michael@walle.cc>, Palmer Dabbelt <palmer@dabbelt.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/11/19 9:05 AM, Alex Bennée wrote:
> Instead of passing a pointer to memory now just extend the GByteArray
> to all the read register helpers. They can then safely append their
> data through the normal way. We don't bother with this abstraction for
> write registers as we have already ensured the buffer being copied
> from is the correct size.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


