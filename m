Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 569DEC3A5A3
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 03:13:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 250CA205C9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 03:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mPjhja/f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 250CA205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2oOv-0005uE-CE
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 23:13:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46736)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i2oO4-0005TO-8T
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 23:12:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i2oO2-00072s-R7
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 23:12:44 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:34813)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i2oO2-00072P-KZ
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 23:12:42 -0400
Received: by mail-pg1-x543.google.com with SMTP id n9so599282pgc.1
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2019 20:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=RmlV09K3Mnu/8enT+O/GHKj1//bd96Q7ogqQfXCf6PI=;
 b=mPjhja/fDuBp/HCJaE+8XaTo0xoQ+5wQzEYw+mJvW9iwH387BRjVkhhtbt5P6/aY85
 DtpS7HUF0b1qfMvhoUeYVQrXNu8zebsRczjvetx1Fl0R1i9P56zvZcZlNVjAE1ZwFiQB
 67zprcAmg2FGZwt8bcB3AcdGS1V12C30W5tDKQ2SpfSj+a7awVwrjZ8/rDRQMLuGLi1x
 Dwpi22Q68BAgt6SNihbGqXVF5rPNSZ/JTH7S62hxCPua0rFtln1OCRU0eDmhYcR4WkXY
 JMF3/8oFYCOHB1vMJZvtCNqy4L1MdcKt56km/naMhwYvP3vm5HkTjjZ/VomO8dZ2lwFJ
 RwPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RmlV09K3Mnu/8enT+O/GHKj1//bd96Q7ogqQfXCf6PI=;
 b=kPErClQkkQdJJzRSipGPEHAhnFyKsTAaKHHq7Onl3I/ENbsvpeHBS9uSHuX5r4R/3n
 /rOHXsfVNZJx3PHTL6u3bo+9s00Hl9Ln/LRJgKeQYMq5iPMkvKR9C2P08oTdXW7x1A+u
 eUkIC/wY5Oh0MV4xkqOBAG0tuCq5dhq0VrrvMi4aLSyZWN6xcGmXNQPP2C9untJNseNp
 JJ/XuVSsl+xlm0Tt1Gch1msUm4Fu6FiuKNvj/UI0p+5zKN9BN6JvAj+D+VdonlxeB7Oa
 t9RUhoUbrfDifCwZJC+ms4+29TmVLGvCxtasQRbQ+/snVrAbE4Rmwv2Wq8+WgVHtRJoJ
 W/tg==
X-Gm-Message-State: APjAAAWTExvyGegvaTCF3wqhFtHKyf8VZvhP6mt7i/wzlvbuWlNVNjfH
 eAZONfC0vA0UNkyjrvJlU4mUr67EmBE=
X-Google-Smtp-Source: APXvYqxymkNuS2s5vEpuerY9K2xYIW16Yp0pNYZ8ktEKGD28wg/9gDS2UefgL/Mn7bTWn7hiI4xFSQ==
X-Received: by 2002:aa7:84d7:: with SMTP id x23mr2122572pfn.53.1566961961515; 
 Tue, 27 Aug 2019 20:12:41 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id z68sm666947pgz.88.2019.08.27.20.12.40
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 27 Aug 2019 20:12:40 -0700 (PDT)
To: Sandra Loosemore <sandra@codesourcery.com>, qemu-devel@nongnu.org
References: <20190827223317.8614-1-sandra@codesourcery.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <d3ccd9c7-47d8-d5f7-cf7c-7a4d3670a176@linaro.org>
Date: Tue, 27 Aug 2019 20:12:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190827223317.8614-1-sandra@codesourcery.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: Re: [Qemu-devel] [PATCH V3] gdbstub: Fix handler for 'F' packet
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Jon Doron <arilou@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/27/19 3:33 PM, Sandra Loosemore wrote:
> Handling of the 'F' packet has been broken since commit
> 4b20fab101b9e2d0fb47454209637a17fc7a13d5, which converted it to use
> the new packet parsing infrastructure.  Per the GDB RSP specification
> 
> https://sourceware.org/gdb/current/onlinedocs/gdb/The-F-Reply-Packet.html
> 
> the second parameter may be omitted, but the rewritten implementation
> was failing to recognize this case.  The result was that QEMU was
> repeatedly resending the fileio request and ignoring GDB's replies of
> successful completion.  This patch restores the behavior of the
> previous code in allowing the errno parameter to be omitted and
> passing 0 to the callback in that case.
> 
> Signed-off-by: Sandra Loosemore <sandra@codesourcery.com>
> ---
>  gdbstub.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


