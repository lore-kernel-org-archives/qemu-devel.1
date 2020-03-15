Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC03C10DCE
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 20:22:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ADC9205C9
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 20:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I2E/3N9J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ADC9205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDZmD-0007su-C0
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 16:22:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43457)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jDZhW-0006Dj-Rp
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 16:17:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jDZhV-00078w-HY
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 16:17:34 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:45725)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jDZhV-00074A-7X
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 16:17:33 -0400
Received: by mail-pg1-x541.google.com with SMTP id m15so8406572pgv.12
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2020 13:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=6gBwYbnX4Se3M5jfu273nxf9h2vGvRVO0RidTPNXEr0=;
 b=I2E/3N9J5wVSHrrdGxlRtlqdy44+ZlhOHgN+wGslHxCr4+W4xiZXj3udZ9D31Ngjrh
 6bf7CI/CGckIWfC9F275EZmzIUTu8A4aI9LlZ4C7x1dE2JZwoAmcTYdd6Vg5jotCdc0s
 C/kwHfrhB9bQFtpVkn2D+qhni7El9685nay2zcGm26kVArIv7D1skBA+8IRfZK28eOGZ
 zpVmVCb1NulH/axIWqoo6rMNnAB7LNBtEuDDJikFrbdmOTHc1X0pxcIygQVYiD2Bzi1L
 8H7dPKDWQCr/PiSIEgJHsG6WNjo315uZp8GRPCjUlPFBdSDGpry0AaGEMAgUBNQKCy9Q
 IDdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6gBwYbnX4Se3M5jfu273nxf9h2vGvRVO0RidTPNXEr0=;
 b=BXY6uu0JmyIdmFbOHW9NIJ5Wdu9TTxAynx1GHf4Ku+ou3icMIC9Pjsl1Ex9W+zELGR
 pN9PHizHhtF9YFFPMyMUSjVf0Ci287AJ+SVHxlyHm3avuWJkthjnY9MrGusKMiFYODxT
 pTi8n2fT+7NS0lgeh/yWLKe8CB8aZilhTA+qhVnkZpsn2IYeOryd7E4d8bws4q2uouMU
 ELAK7zrKf/4pUHhZqL6MxEfBgQwbl/LKikfFgjuUBmGNWM91gpu9tDIW7tHJ3lE2AgMf
 z91gVx1o4PrISwnTH85b1JCKpKnMrbwc8zctr3oXodQ+mnHnR8M1L+otRTcW31Jh5oum
 de4w==
X-Gm-Message-State: ANhLgQ0YYzrZYd6FUXGVVQ1K7F2QYigzYwPjvOqcJs5fcV59uDk7awPn
 AQg/3jwDWTNS1dGj0x0Ploe+VA==
X-Google-Smtp-Source: ADFU+vssijLhaXyL/4k+UfHIYKXFWUVTPyO2a4DXoxZAIug2ken6y9Qn0xE5K7nlggctqPlVJ4SzVg==
X-Received: by 2002:a63:ee02:: with SMTP id e2mr22989077pgi.183.1584303451954; 
 Sun, 15 Mar 2020 13:17:31 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 f127sm65685327pfa.112.2020.03.15.13.17.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Mar 2020 13:17:31 -0700 (PDT)
Subject: Re: [PATCH 04/14] tests/Makefile: Restrict some softmmu-only tests
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200313183652.10258-1-philmd@redhat.com>
 <20200313183652.10258-5-philmd@redhat.com>
 <942d57d6-b272-c2c6-b2df-405d81d03996@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ab32ab13-f5ce-8f6d-af9e-d59272801c3d@linaro.org>
Date: Sun, 15 Mar 2020 13:17:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <942d57d6-b272-c2c6-b2df-405d81d03996@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <Alistair.Francis@wdc.com>, qemu-riscv@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/15/20 1:07 PM, Richard Henderson wrote:
> On 3/13/20 11:36 AM, Philippe Mathieu-Daudé wrote:
>> These tests fails when configured with --disable-system.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  tests/Makefile.include | 16 ++++++++--------
>>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> So... they don't currently fail check-unit.  Did you mean to say that they
> *will* fail once other files are disabled?

Ah yes.  I've rebased your patchset without this one and it does fail.  So with
a re-worded commit message,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Richard Henderson <richard.henderson@linaro.org>


r~


