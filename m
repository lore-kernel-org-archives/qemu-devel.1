Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A99C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 15:52:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F2BB206F5
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 15:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mb4CPgKY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F2BB206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyH2J-0005aZ-KQ
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 11:52:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53912)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jyH1Q-00058s-Ki
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 11:51:08 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:41590)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jyH1O-0007l3-UM
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 11:51:08 -0400
Received: by mail-pf1-x443.google.com with SMTP id w126so1332588pfw.8
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 08:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=E3wp3HyswEEBzB3d5ImLfjep6HwT9h5z59GHAoNfdYQ=;
 b=Mb4CPgKYte4ewsImvHSsgWARzbVKttx5iAT8DVi6N3Nl7IXyEu0bmNJJMD/d3JHnf2
 Dy/EBH013UOx2U4qmtoWSbxghfUKW1kGZoN/gO+vssK6XWS2KZ2VemcGoE+yHtEmwIJ3
 sZ1UBdFFPCnnaW0qMaRX1841judl4h0bTp0JSEElLU1tBxeB/MuVDyZYEJTffTEGxJgw
 agSFNlxR/N0clfvARC51n+mwuyb8JjHhd/NXBVSDBVcYhnpBHk0bKLQFRKKA4SE6tTD1
 BzpeNtJDtg6koQhNihcMQdPXx7LulOW0A63fcrP45nnQ6Tmo9xuYBkpg/tAUjvMnHBvU
 aA2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=E3wp3HyswEEBzB3d5ImLfjep6HwT9h5z59GHAoNfdYQ=;
 b=FrBm5kB9uQ/ICOXhNVJ7sXysxDABY4z5JnE+ijv9qje2/PSs4+BUMEseAXtCHPZ7F5
 MYQs1mFZweA+rUmf9bhPC+sS21oph1LSKvVf5IUQnPVK3H266lu+Amln4acq7qxysuRj
 Fk+i8aznRYH4Qa7CdHodIIH9Md+yVXSl9h05cDOSETql8zoPns2BDGkfPv2AcBAoZSa/
 sDgCBwe39JUADCCsBhnK7dntXB4oBqZFL0av/87gp7HfgSCyVfRYq/QgZvAr2X5LArbc
 tUwX2btSsjyYnPjGFd3X+Ewvf/CTdh4KoXSB6h2cxHDj+8hrGW25OG18QSjaZgGoFlGy
 0ZWw==
X-Gm-Message-State: AOAM532VVxHw//3eB+Z7zgkKQIeU87ks6yfNxz0Lab0jHwgr328+nTUn
 J5iJu0/iLWC/IRaq+NRqgZDOLA==
X-Google-Smtp-Source: ABdhPJyDKO3yVN2fH1Jxp/URrp/kRhmwR3KPmhN/k8nhitFjLp7YG3dZ/aOX1F9MSbMcpZFY+op4kw==
X-Received: by 2002:a63:4956:: with SMTP id y22mr432019pgk.380.1595433064736; 
 Wed, 22 Jul 2020 08:51:04 -0700 (PDT)
Received: from [192.168.1.11] (216-160-65-90.tukw.qwest.net. [216.160.65.90])
 by smtp.gmail.com with ESMTPSA id
 l16sm209798pff.167.2020.07.22.08.51.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jul 2020 08:51:03 -0700 (PDT)
Subject: Re: [PATCH v2 04/12] util: add qemu_get_host_physmem utility function
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200722062902.24509-1-alex.bennee@linaro.org>
 <20200722062902.24509-5-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <cf4a37ec-b849-ccab-7068-f4c7607932a5@linaro.org>
Date: Wed, 22 Jul 2020 08:51:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200722062902.24509-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: fam@euphon.net, berrange@redhat.com, Stefan Weil <sw@weilnetz.de>,
 f4bug@amsat.org, Christian Ehrhardt <christian.ehrhardt@canonical.com>,
 cota@braap.org, Paolo Bonzini <pbonzini@redhat.com>, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/21/20 11:28 PM, Alex Bennée wrote:
> This will be used in a future patch. For POSIX systems _SC_PHYS_PAGES
> isn't standardised but at least appears in the man pages for
> Open/FreeBSD. The result is advisory so any users of it shouldn't just
> fail if we can't work it out.
> 
> The win32 stub currently returns 0 until someone with a Windows system
> can develop and test a patch.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: BALATON Zoltan <balaton@eik.bme.hu>
> Cc: Christian Ehrhardt <christian.ehrhardt@canonical.com>
> Message-Id: <20200717105139.25293-5-alex.bennee@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

