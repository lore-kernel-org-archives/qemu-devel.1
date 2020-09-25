Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC4AC4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 13:20:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E56742395C
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 13:20:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CGwlSy9n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E56742395C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLndx-0001T3-RM
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 09:20:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52640)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLnTu-0005Gy-DR
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 09:09:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60152)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLnTs-0003RR-HX
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 09:09:46 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601039383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5Q+U7ZCZ6Ra+egqPlv7ZUU8gm5fjWV7L/ZzljnejQyA=;
 b=CGwlSy9nHzIFYlLwQ3eKIaEW5o79TKNcl4Ywy8Q5pWCNNByygi/PxRijJzBEGXrrMt4nUT
 IOXwjMl/vKmmmLVy4eZ5C2op65V6mfeRytfCWPR2ROVfbuyzcqtLOeE8SOOQeJfK7sOqz6
 rCEkTYYxC0qqmhybyscBaehm/cvPtBs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-f_1j2s53PbezpE5deePhwg-1; Fri, 25 Sep 2020 09:09:39 -0400
X-MC-Unique: f_1j2s53PbezpE5deePhwg-1
Received: by mail-wr1-f70.google.com with SMTP id l17so1049686wrw.11
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 06:09:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5Q+U7ZCZ6Ra+egqPlv7ZUU8gm5fjWV7L/ZzljnejQyA=;
 b=cQ5TQofunbuoJpFBHPmnN48e3n92ui9du5XYVleY4UteWeobseQgW2kpUVls7uKr5U
 Hk4x5fb3xvOnwlT4OUyTJRvPX4fxzrtx5Zu9y7HP1TUmHECUeOd04+mPXT/1HgyutYMb
 rR2m2EjRtTSdZzMwswMnh/D3Rtt0+g/eqAtTpQ3df8/oHeB+fmvZo8CHrY5N/tSCEe1v
 x9Bc3T9jdRBPfhXDQ7vDnr0NoQAD/KtIWC3ISwXIeiB9D6uXRWRJ9Ll970C2s+fFlIvS
 ey/nhBcv+E5lmpghNs6gkZ4oe10VbcBUdaGJaK/NwVTjP2D0upUAUTD3ZeSUSR3/gXtY
 6DbA==
X-Gm-Message-State: AOAM530umvyGv+0Tt5HBEmW9CgyJqHs47K7s2hEK42t3D52ORR9k+w7P
 KrXGwcec22m/cbLCsL+AMny2YxqRvNo8JiejaXXRK8vIrtUHwYT2K5QjWNwM/M98m7AZa7TWsZG
 XK6130YWehh+jee0=
X-Received: by 2002:adf:eece:: with SMTP id a14mr4333263wrp.330.1601039378626; 
 Fri, 25 Sep 2020 06:09:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxnP1UEX8Q9z7X6isdeRKWpZDDZNvGCJrh4o2sRShxUXseVjGuk7rfeXm93a+31LJzpl2dqfQ==
X-Received: by 2002:adf:eece:: with SMTP id a14mr4333228wrp.330.1601039378385; 
 Fri, 25 Sep 2020 06:09:38 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ec9b:111a:97e3:4baf?
 ([2001:b07:6468:f312:ec9b:111a:97e3:4baf])
 by smtp.gmail.com with ESMTPSA id t124sm2982445wmg.31.2020.09.25.06.09.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2020 06:09:37 -0700 (PDT)
Subject: Re: [PATCH v8 00/17] QEMU cpus.c refactoring part2
To: Richard Henderson <richard.henderson@linaro.org>,
 Claudio Fontana <cfontana@suse.de>, Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>
References: <20200916142004.27429-1-cfontana@suse.de>
 <d0bb4af9-55a1-b332-af6f-7601dfb10db7@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <402c303b-64a4-c2ed-151a-48f2e2cb40ac@redhat.com>
Date: Fri, 25 Sep 2020 15:09:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <d0bb4af9-55a1-b332-af6f-7601dfb10db7@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 02:48:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.238, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
 Alberto Garcia <berto@igalia.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 Colin Xu <colin.xu@intel.com>, haxm-team@intel.com,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Wenchao Wang <wenchao.wang@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18/09/20 21:00, Richard Henderson wrote:
> On 9/16/20 7:19 AM, Claudio Fontana wrote:
>> Motivation and higher level steps:
>>
>> https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg04628.html
>>
>> Current state is mostly all reviewed, but I include here a few resolutions
>> of rebasing conflicts and a new patch to use current_machine instead of
>> qdev_get_machine in softmmu context.
>>
>> It's minor, but if additional reviewing is necessary, here is the whole series again.
>>
>> CI is all green, and also available at https://github.com/hw-claudio/qemu.git "cpus-refactoring"
>>
>> The following changes since commit 5a77bbb53b087f95dbba7ce30b02ac2d7b147a3a:
>>
>>   iotests: Work around failing readlink -f (2020-09-15 18:19:26 +0200)
>>
>> are available in the Git repository at:
>>
>>   https://github.com/hw-claudio/qemu.git 
>>
>> for you to fetch changes up to f9ec667595537400a6bc0aaf094a5ca6bbaacf44:
>>
>>   accel/tcg: use current_machine as it is always set for softmmu (2020-09-15 18:19:27 +0200)
> 
> Queuing this to tcg-next, with Phil's suggested change to current_machine in
> the final patch.

This doesn't apply anymore, but I've fixed it up because I had it as a
prerequisite for my next pull request.  If you want, I can shepherd it too.

Paolo


