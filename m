Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAAB2C10F14
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 19:41:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC13620659
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 19:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fUraRKch"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC13620659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFkUw-0000sA-QE
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 15:41:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56143)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iFkUB-0000Sw-JP
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 15:40:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iFkUA-0000wo-DE
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 15:40:31 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e]:36843)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iFkUA-0000wJ-7c
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 15:40:30 -0400
Received: by mail-pf1-x42e.google.com with SMTP id y22so21571pfr.3
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2019 12:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=U+fDm4+ZXs6BauH4LvJxLjn54MCtsuR5xloJjjtTW6I=;
 b=fUraRKchd7/5pGGMHElQG0e6y+tT5w4WhVfkPnhIjt+oTiH6viDbkG26iGJUqn509h
 nsMRrOAJoFPpD2wKYEajwPrN6YBHJE/nPLpY38vgFbrS+JZSJQFJ3gBRpuXcLxICGv95
 5R30bh1+KqQU58DB43FGA33eUJ9pSU8geqkgOgMOjy1rTjgJV/hlmVEO3oK5p8edQQ4q
 +UXPaTQAncHnTN+OpXeq3k/q22Ywyx7za5rUT+H34P+PwqDrXo0u4bAroIQYwwFBL2eD
 XNlejBZIqIFVYZ9ZJ9wbsT8TrIFQIYZxAc0Mu1ZGbOKm8XG7xucw1Ot/Yia7STSVzV/E
 gmdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=U+fDm4+ZXs6BauH4LvJxLjn54MCtsuR5xloJjjtTW6I=;
 b=N22yHv/HfqGNUB6tVKUTwppahgzkaBaLcRXJ4fHsTC1ZA26RcodB39QPEJucEc2t+a
 J4kb8o9+/r3at9aLtEQTftZWveFP/8M9kBp/qJ7ncl9t1MrrsoggLZHVaf7aR/XRBVKw
 Bp0VLhVwoT+dotyEaQO5IEMYwuM3z+FxhToWFdfmdchfqNg3CPOHajhXhYtpQFjs1K0L
 Nyp+dCpIic0lpYWiLadeFZoYdKKx3WHlwpebgpGnbxP2C1FmuNzdu/u6GtcMy5s2tN5z
 1upRG7Bi+UE44cxYjAucl6pDPjnOOhvJU+6hDqclX4tn+saOnK3y5bzKQ1UnBsbEEA4u
 +e9g==
X-Gm-Message-State: APjAAAUOXyskUSi3JT083kQUXMVY3Mcxq4HNVVXiyEW9PxFIT9iGz0D1
 5Cj+rNwWUk+spbzgtsLHBn5m6w==
X-Google-Smtp-Source: APXvYqwiyycx7gXXi9wK92qK8oNzq4FH1YyR0tcFRP/kVL6u/xPmhJTlmaQskYmm21VssaEZehxwwQ==
X-Received: by 2002:a17:90a:b012:: with SMTP id
 x18mr6348889pjq.116.1570045228755; 
 Wed, 02 Oct 2019 12:40:28 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id w188sm180279pgw.26.2019.10.02.12.40.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 02 Oct 2019 12:40:27 -0700 (PDT)
Subject: Re: target/ppc: bug in optimised vsl/vsr implementation?
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <bf30baf5-4d75-dc6f-c30a-57b80714999b@ilande.co.uk>
 <CAL1e-=gcK2mdtrt9vibHGpbm4_FZgQWTA91+p=9ouuMYmZwPqQ@mail.gmail.com>
 <c9679b01-91c3-3d69-fb38-dfef1602dcf4@ilande.co.uk>
 <87v9t7jbep.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <5f80d547-3027-2315-bb98-221283b9df2f@linaro.org>
Date: Wed, 2 Oct 2019 12:40:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87v9t7jbep.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::42e
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
Cc: stefan.brankovic@rt-rk.com, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 Paul Clarke <pc@us.ibm.com>, Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/2/19 10:38 AM, Alex Bennée wrote:
> Is the denbcdq instruction exposed in any standard float operations?
> Once this is fixed it would be worth adding a testcase (either ppc64
> specific or multiarch) so protect it from regression in the future.

Not standard float operations -- this is binary coded decimal stuff.
It would certainly be possible to write a ppc specific test case.


r~

