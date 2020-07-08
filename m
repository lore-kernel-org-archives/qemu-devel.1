Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B014C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 21:59:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC47D20775
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 21:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H37SsjdG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC47D20775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtI6e-0007Xg-2P
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 17:59:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36628)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jtHjg-0003Ok-8F
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:36:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37519
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jtHjc-0003En-30
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:36:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594244167;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vKIHmkLWxWtxOPu74WO3ny6sQKOHwdgFcSIJAdthwzg=;
 b=H37SsjdGS01fqyp3usthre5sNI/CPBwj+8U0XGKeBA8sBT5PIwJzoJX5SXPCR6sNNwqqfx
 zH3+cTf2o8W+rnSQ769qnDFNLoxZqJ9Gda7qoe4jd+wbeJKD5LzIsCVxvMxgXWX1OMmmie
 iTJsAxqDioSN6f4les4u0y+HYg74yyk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-f23VrXnyNvegvklAY6bd8w-1; Wed, 08 Jul 2020 10:34:18 -0400
X-MC-Unique: f23VrXnyNvegvklAY6bd8w-1
Received: by mail-wr1-f70.google.com with SMTP id 89so28779237wrr.15
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 07:34:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vKIHmkLWxWtxOPu74WO3ny6sQKOHwdgFcSIJAdthwzg=;
 b=dyXkC9nypBrrD5kNs0fwv0pJucrqGQsNMEFxUVqDNdWH+tSSm97eWVIQoCT1VJRTgE
 HNyE3gxmHex8EHD4rKTEASyzhQRNXK9cqq2dO5Sl17MKxpSXAOa4kKNu26pjhxeBQVMR
 hTgaQ5TiK+mUy/qWWL8lzyAlUpQWUxmYbBil/E7+cUqdM2iuHp7ZKq0FdUQZkntNIyl6
 7q1ew0CK+3StGEyrBpwM9dj/mXmQEh0WLsawBpOtdhChYimtXzQewHJZsvfj/CPl6AVv
 Ne9bjgf0rs1WFcscvrC7wKH5khj3FUVLbpMcSBWWufYD5lls1kIC983X+3g8ix4bEUIN
 nDyw==
X-Gm-Message-State: AOAM532vLz9i+7I3781QlHvAxaI/qYr+QwgZuKencdPCQiOvJ4Vpj6iU
 HYlOv619K3dwlaATr1oXaez40zqiyU4oFhxO6ZtKwlMOWSU9pcfeC8e0YE4OmuYcKKoihU3dL/S
 iscmSzYQiZag2e7c=
X-Received: by 2002:a5d:420e:: with SMTP id n14mr62524057wrq.164.1594218857300; 
 Wed, 08 Jul 2020 07:34:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxdc8+4tyPfKCRe2x5DWDGqDCUsUmlCN+C3k3eHq5TIBFVFa/6YL8idpWTGP4aAhDQ4epikCw==
X-Received: by 2002:a5d:420e:: with SMTP id n14mr62524031wrq.164.1594218857026; 
 Wed, 08 Jul 2020 07:34:17 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9541:9439:cb0f:89c?
 ([2001:b07:6468:f312:9541:9439:cb0f:89c])
 by smtp.gmail.com with ESMTPSA id b62sm6717913wmh.38.2020.07.08.07.34.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2020 07:34:16 -0700 (PDT)
Subject: Re: [PATCH 3/3] cpu-timers, icount: new modules
To: Claudio Fontana <cfontana@suse.de>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20200629093504.3228-1-cfontana@suse.de>
 <20200629093504.3228-4-cfontana@suse.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <aa45a793-35b1-d3bd-18a8-4c52ad888029@redhat.com>
Date: Wed, 8 Jul 2020 16:34:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200629093504.3228-4-cfontana@suse.de>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Colin Xu <colin.xu@intel.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 haxm-team@intel.com, Wenchao Wang <wenchao.wang@intel.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/06/20 11:35, Claudio Fontana wrote:
> refactoring of cpus.c continues with cpu timer state extraction.
> 
> cpu-timers: responsible for the cpu timers state, and for access to
> cpu clocks and ticks.
> 
> icount: counts the TCG instructions executed. As such it is specific to
> the TCG accelerator. Therefore, it is built only under CONFIG_TCG.
> 
> One complication is due to qtest, which misuses icount to warp time
> (qtest_clock_warp). In order to solve this problem, detach instead qtest
> from icount, and use a trivial separate counter for it.
> 
> This requires fixing assumptions scattered in the code that
> qtest_enabled() implies icount_enabled().
> 
> No functionality change.
> 
> Signed-off-by: Claudio Fontana <cfontana@suse.de>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

Claudio,

this weirdly enough causes iotest 267 (i.e. basically vmstate
save/restore) to break on s390:

+Unexpected storage key flag data: 0
+error while loading state for instance 0x0 of device 's390-skeys'
+Error: Error -22 while loading VM state

Bisectable, 100% failure rate, etc. :(  Can you split the patch in
multiple parts, specifically separating any rename or introducing of
includes from the final file move?

Also, the patch breaks --disable-tcg, which is easily fixed by changing
the prototype for icount_enabled() to

	#if defined CONFIG_TCG || !defined NEED_CPU_H
	extern bool icount_enabled(void);
	#else
	#define icount_enabled() 0
	#endif

(This way, more TCG-only code in cpus.c gets elided).  You can integrate
this change in the next version.

Paolo


