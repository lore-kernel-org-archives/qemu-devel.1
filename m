Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 462EFC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 20:50:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A1192074D
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 20:50:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GcYXlnhL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A1192074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6geu-0002bN-Bq
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 16:50:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39898)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6geK-0002BB-19
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 16:50:04 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:40528)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6geI-0005MU-EG
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 16:50:03 -0400
Received: by mail-pl1-x644.google.com with SMTP id u10so4708296plr.7
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 13:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=C2i6HbdJM0BPbAwpVomDjyUjpjsZTrrTqdUU2gAB4vE=;
 b=GcYXlnhL3XDuyrgtXkvYqZModH4YzJ8zQvIA8//slRx5qkofUOBbIQfJdvsX17QN2F
 3jWCjlHNCldYzp+de29BS7ilZ4VdDbL3HMIS7v0ouPJDf8wpAuQ/rlDxgRAPyvfhJMtV
 NDSlb1GjI8NvvFqaxQVY8hdY3+GD+hb4p0RDQfnyZ1jpLGa8iYXtOsleY/u+dew5hwOY
 bt476XXCYo21mq8YdU5dAboJq3AakqCA8ay48ZUWsVjhAZZ5hlUUZlX/fNIKqM4IRG77
 tt4mzcJIoS2yx2Lq1p1+W3/Fxgxs3N/UxDAMOnX4fVBnNc60X9kakIc69P0BK5L3rkm6
 Y30A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=C2i6HbdJM0BPbAwpVomDjyUjpjsZTrrTqdUU2gAB4vE=;
 b=ajn/Xhxysl8VnN/6d8zKDDfm3GN+/l6ZgMcaaBnw2aMFPvmZ3JfDLqQ2Uyxtsg6NiT
 LfIzoFFP3HBlRLWBM2A7PiGQcCqp377rU/UEYQQj2ncyQwt7/usoexrieNo2kwD4nqwL
 o98XOtCdgsSQlacvU6ahGENP8vFMJsFRIKc5IwqvJoGaC5qy/NdG4Hg4LdB6MhcylV1V
 aqx24ThrD3Zpq07+vjnOSn3PiMfdVZ/49Y+omJUyAGcpmZm0Pwy3xpLptM0arRogPJzn
 /DNszSX9a1eJ5r2ZZ4vjj2/tCq/0k56hZabA1ZWYVNtufBIwm0Dmz4Q/7JhHN32r1H33
 6q3Q==
X-Gm-Message-State: AOAM533yr1xnZLiY1dVf1xbJP2MTYJbR7NWQwhuFCOmQd85pVLkiyJuP
 a4Uv0tTfV/C+FLh2bke4IqznIA==
X-Google-Smtp-Source: ABdhPJwVEHgXmCeo2Xbq0LmG+ijEWBE3g2JlmoIYeQ1pcsHS1WcqIQROJWDsxtKk699rzHjlLFCl1g==
X-Received: by 2002:a17:90a:d252:: with SMTP id
 o18mr3577908pjw.146.1597438200613; 
 Fri, 14 Aug 2020 13:50:00 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id z23sm8768349pgv.57.2020.08.14.13.49.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Aug 2020 13:49:59 -0700 (PDT)
Subject: Re: [PATCH v5 07/14] cpus: extract out whpx-specific code to
 target/i386/
To: Claudio Fontana <cfontana@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>
References: <20200812183250.9221-1-cfontana@suse.de>
 <20200812183250.9221-8-cfontana@suse.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <24b9bebb-8ead-d315-e563-58ca9a1187a8@linaro.org>
Date: Fri, 14 Aug 2020 13:49:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200812183250.9221-8-cfontana@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x644.google.com
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
> +CpusAccel whpx_cpus = {
> +    .create_vcpu_thread = whpx_start_vcpu_thread,
> +    .kick_vcpu_thread = whpx_kick_vcpu_thread,
> +
> +    .synchronize_post_reset = whpx_cpu_synchronize_post_reset,
> +    .synchronize_post_init = whpx_cpu_synchronize_post_init,
> +    .synchronize_state = whpx_cpu_synchronize_state,
> +    .synchronize_pre_loadvm = whpx_cpu_synchronize_pre_loadvm,
> +};

const.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

