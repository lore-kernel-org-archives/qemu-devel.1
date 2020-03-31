Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 465BCC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 19:00:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BD12207FF
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 19:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mJahafam"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BD12207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJM7O-0003s7-7W
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 15:00:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35662)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jJM6Y-0003SB-Gv
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 14:59:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jJM6X-00044b-Kb
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 14:59:18 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:45553)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jJM6X-00043P-B4
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 14:59:17 -0400
Received: by mail-pf1-x441.google.com with SMTP id r14so8281913pfl.12
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2020 11:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Ry8B3YFfUNlCIRkmyxbelgQ3TrZZCyXwM6NVwjoMakk=;
 b=mJahafamhHorAEde5Pz0HIMRGUPX2MDPGIc5xH0d6INTn/p7wT0dDn9cvrLRQ3Rry0
 EEAKayYFZuCXkhDLRDtxE3p636biOslaQseFlCxmV1HjkgPVI1KFL+C8qX/b+DX/0AcL
 +BD60C++iGK+R+s4PSmTgaz+Oy7eGSbsCOP8+sf7MyiwikGc+IhPFrndB3Ef0oP9WbOg
 2jHXHPYoAOryjcDgukHEVbaxJlr0eoabnAWXojzsifHAlTJuhdF19lANQy3iiXya2qKj
 ur7v8KxhZJvU7UB7wAaBwKc1i59ZAF4By5Fn7RYrXl4T0ebu7Fl3sfZD3lBBOG6+UC5T
 TTnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ry8B3YFfUNlCIRkmyxbelgQ3TrZZCyXwM6NVwjoMakk=;
 b=MQIwV1I0zq+xrNY35AAbtJCnpcha5c3O28cym2xdgvTVWO7NxJbb+KV+ZZax2G/cl6
 97Gvgm3+w8VNjoQYHMWB/SS3tbAFqQQ03w5doxRXaLDK5t5pxJD0u98mYEz/FONW4/NM
 Tz4UijdAtfxdJvmJ1Mc3b8sF15VyJFtQtSBM2WhZVFl+deLSMVaWKZiFlPzkOls6Q2Pr
 og1497OAfNo1hMMcC1AE4tRLI+Y7Z93U3ouBg/ybXoPAdRyaBSP1TVPkjugpLG5d2453
 64X9FsxQsbYw6QLgg+gZ5569zJUtInWA9sspRfN8S5vMKnfvXMl5iBcjUkmPTNUvsHdo
 o1yQ==
X-Gm-Message-State: AGi0PubhU8B96k2EORD3IPeMwCaeGJNA5Rh2J/dmJNwaD0oGkuLgBfRH
 Lf6Zznvls7AjoYbP0w6/h6L3zA==
X-Google-Smtp-Source: APiQypJ56ca2WebWs4OJcQiGWtBY38c/tCAcUxfQr93LMLx5fBanTJ5gULTJO3Y/rMsqUmeJEZXmlA==
X-Received: by 2002:a63:8442:: with SMTP id k63mr6511963pgd.11.1585681155813; 
 Tue, 31 Mar 2020 11:59:15 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id q71sm2557590pjb.5.2020.03.31.11.59.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Mar 2020 11:59:15 -0700 (PDT)
Subject: Re: [PATCH v7 00/41] target/arm: Implement ARMv8.1-VHE
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200206105448.4726-1-richard.henderson@linaro.org>
 <CAFEAcA83vHKOYdxnAG9ouF9OJTGh+3z_RuB1yEc6dCpErZ4pZw@mail.gmail.com>
 <20200331163324.000020fb@Huawei.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2c29aaa9-0c92-ba48-e218-ab816044eec3@linaro.org>
Date: Tue, 31 Mar 2020 11:59:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200331163324.000020fb@Huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: salil.mehta@huawei.com, QEMU Developers <qemu-devel@nongnu.org>,
 shameerali.kolothum.thodi@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/31/20 8:33 AM, Jonathan Cameron wrote:
> Just wondering if there are any known issues with this?

Nope.  It works for me.
Can you give us any more details.


r~

