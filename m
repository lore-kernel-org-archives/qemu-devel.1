Return-Path: <SRS0=PlQC=BZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C13C433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 16:22:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAD8B23B32
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 16:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gi7gRRHl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAD8B23B32
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6ywu-0000Va-0J
	for qemu-devel@archiver.kernel.org; Sat, 15 Aug 2020 12:22:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60144)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6ywI-0008R6-Vg
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 12:21:51 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:43589)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6ywH-0004Hk-EE
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 12:21:50 -0400
Received: by mail-pf1-x441.google.com with SMTP id y206so6008187pfb.10
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2020 09:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=reUavR+bIo7ybvlUG3TVKJcK0+XufRLUiV3eYFfq0NM=;
 b=gi7gRRHlV7hZJMyHlPUHfmD4lg6Ykdqt6/UI3lSsb8ENph055FwacCApeb0ErlK/ec
 vy23PLGjNFEckEkWqcYNQeuTs0X6Iksd9Soi0IMbmEHGIwmuNYb3NVWqs1fB6lzkptxi
 Jz8AMrW7GlpoM2/thhtX7e9p6yIosnuuy7pS3xF5B7WkkstaAp+cc3yDKFJE95AOqWjQ
 uaod19+chmtwfaZeaBWze/AVgjbngLW5VH+IYY4q3JuByZOYk9eO0jzw3fvb226cDEIL
 NJd6CSfNPbo6lY4W5DFz7ZGreUekMr8Z8QZajyD9wVextfK3YSwmGHtseAWsWY+AEGAm
 Hv6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=reUavR+bIo7ybvlUG3TVKJcK0+XufRLUiV3eYFfq0NM=;
 b=Vq0tVsG0ASzG6pzSRWhd5M9fbrKN8T9pIHKITA1E+6JT3O176JyvJKuvURJFM/DquQ
 piNhRCK4KlpGncZYyjXL1AM5jpvJC4xI9iM+kJLBTyq6c454k34pKTHlaPKQ7rNSU3Oe
 vRD9Km4vh8/EIAl+FO/uB+I/Q0pFF+6hDXsEjG6DJ179RytcEi3z63mgqWZprQHB1Miu
 tB+rOwy9kg8qDHayJ96s1LpK0XZmMSeh+TC06S9TNZslZPIzean8FFWUBbhuUk74zhqC
 bhmAVWTVekZTu/DO6GWzrdbJ2umPtVCVI+gunhhkpzkr0rGdLmkGJFbk+B3BYeDpeKfe
 9F8Q==
X-Gm-Message-State: AOAM531tONnpjkZxy63QzbAreweLLIIAa0EW/2xAsFw86UOq61EQAbpq
 iKAgln/fSU7+sLHQOVLMoWzTw1mpnM/7Hw==
X-Google-Smtp-Source: ABdhPJyxELtNUW4UASDLaCNtAdFjoJPY2KqcTjQrNYBJJAayL/NSMqHfnOpuA4ry+a9fUgDIHgmsGg==
X-Received: by 2002:a65:6250:: with SMTP id q16mr2981294pgv.149.1597439205604; 
 Fri, 14 Aug 2020 14:06:45 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id y10sm9114362pjv.55.2020.08.14.14.06.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Aug 2020 14:06:44 -0700 (PDT)
Subject: Re: [PATCH v5 13/14] hax: remove hax specific functions from global
 includes
To: Claudio Fontana <cfontana@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>
References: <20200812183250.9221-1-cfontana@suse.de>
 <20200812183250.9221-14-cfontana@suse.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <16e4b3a6-c0f0-9cdc-8e9b-462874ba727a@linaro.org>
Date: Fri, 14 Aug 2020 14:06:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200812183250.9221-14-cfontana@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x441.google.com
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>, Wenchao Wang <wenchao.wang@intel.com>,
 haxm-team@intel.com, Sunil Muthuswamy <sunilmut@microsoft.com>,
 Richard Henderson <rth@twiddle.net>, Colin Xu <colin.xu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/12/20 11:32 AM, Claudio Fontana wrote:
> Signed-off-by: Claudio Fontana <cfontana@suse.de>
> ---
>  accel/stubs/hax-stub.c    | 10 ----------
>  include/sysemu/hax.h      | 17 -----------------
>  target/i386/hax-all.c     |  1 -
>  target/i386/hax-cpus.c    |  1 -
>  target/i386/hax-cpus.h    | 16 ++++++++++++++++
>  target/i386/hax-mem.c     |  2 +-
>  target/i386/hax-posix.c   |  3 +--
>  target/i386/hax-windows.c |  2 +-
>  target/i386/hax-windows.h |  2 ++
>  9 files changed, 21 insertions(+), 33 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

