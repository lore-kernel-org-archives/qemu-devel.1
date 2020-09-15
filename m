Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79699C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 17:34:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8BBA208E4
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 17:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MSF3UQOz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8BBA208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIEqY-0001wj-PI
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 13:34:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44482)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kIEXN-0000aC-Dm
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 13:14:37 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:38866)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kIEXL-0002pU-El
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 13:14:36 -0400
Received: by mail-pf1-x444.google.com with SMTP id l126so2325392pfd.5
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 10:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=lRIPWbfsgwuSxAB+0xWpROTdIrgQaKTeLOlhjXvT9bU=;
 b=MSF3UQOz3bTG2485h5AsxiIeuJsYuCrKi2RNWgdYgUmHqiQthBdgry8rTK7hsgOQaw
 qSwQX1XPv4y0cp1KgdIecLrFXtfetaistPm3MzkfmPIU+W+WH/Q1xQNNzjUgXypbzS6J
 4+H5nyZu12X8nGaangbQo2t7lMMDts7YtT1c2wAF8shHOpO2fSA1oUuaK/Y88vWYpjgm
 9w/DBc6+wXyG4cFG+1f9KvKgBceMBYgCaZzJg1fd+4NEg9C+cntLVxMYhkR+/vOVBAP/
 Ow/rxBFmkm1Lo/RHXbeh3NJ4pVdL5WFzUZceCriLgC8c/20UR7kKZ3tRN5ulozGKGQis
 YzrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lRIPWbfsgwuSxAB+0xWpROTdIrgQaKTeLOlhjXvT9bU=;
 b=GgKJtnOI2hDnJL0AN5ZRVM1Te8fUjjLUEU/gK9IZuTLIJaiH1J14MO0QWiVZqMXY7q
 gCij/0wcgbPAgS0134UkRnpKo+aj+89C+E96MtcqZl4/Fz3rG3Q4UU8RKMDqUVJIk5x2
 7xemT3nZT1VuRZcMbVMJ5WaxJmbpPUP0BY+qcge7co242yIM6MiIfHevIUi3juTKwy2Q
 UyKkl35aF8RW6qmVVYyw8JHHVjjd1iC92VMQEbsu9GkOibNnM6Owr7rvzEC40dpe/Ck7
 gOIA11Vpq4ZujPg39+/C7auTNkJx+IRoIskbG0qMgifyNUa+7X0zPnBY31wfbt4cIJGE
 Fnww==
X-Gm-Message-State: AOAM532A8U+3E/GEJs2gEQe/xIdAaayAVjF6oySbpG7KCSOGFkvRKu2a
 bb/Lqc/bvc4rX5IDlM7Hzj+TsA==
X-Google-Smtp-Source: ABdhPJzXpYlwoOvk+97W4MS3+ozI086454tIYlYhIpr2XiXv5NE5Q75tYts29mK1Nffc3ODRtLJvEQ==
X-Received: by 2002:a62:52ce:0:b029:13e:50c8:499b with SMTP id
 g197-20020a6252ce0000b029013e50c8499bmr18920885pfb.14.1600190072402; 
 Tue, 15 Sep 2020 10:14:32 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id n9sm6614748pgi.2.2020.09.15.10.14.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Sep 2020 10:14:31 -0700 (PDT)
Subject: Re: [PATCH v2 2/8] iotests: Drop readlink -f
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200915134317.11110-1-alex.bennee@linaro.org>
 <20200915134317.11110-3-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2376b7ad-07c7-a4c1-21ec-d239c1234e0f@linaro.org>
Date: Tue, 15 Sep 2020 10:14:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200915134317.11110-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Claudio Fontana <cfontana@suse.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/15/20 6:43 AM, Alex Bennée wrote:
> From: Max Reitz <mreitz@redhat.com>
> 
> On macOS, (out of the box) readlink does not have -f.  We do not really
> need readlink here, though, it was just a replacement for realpath
> (which is not available on our BSD test systems), which we needed to
> make the $(dirname) into an absolute path.
> 
> Instead of using either, just use "cd; pwd" like is done for
> $source_iotests.
> 
>        ("iotests: Allow running from different directory")
> 
> Fixes: b1cbc33a3971b6bb005d5ac3569feae35a71de0f
> Reported-by: Claudio Fontana <cfontana@suse.de>
> Reported-by: Thomas Huth <thuth@redhat.com>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> Message-Id: <20200914145606.94620-1-mreitz@redhat.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/qemu-iotests/check | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


