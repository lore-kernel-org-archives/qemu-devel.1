Return-Path: <SRS0=be0Y=DK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA6CC4363D
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 09:16:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF64B206CA
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 09:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MMjF4IRQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF64B206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOdec-0006ll-QY
	for qemu-devel@archiver.kernel.org; Sat, 03 Oct 2020 05:16:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35212)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kOddY-0006Kh-NR
 for qemu-devel@nongnu.org; Sat, 03 Oct 2020 05:15:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33710)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kOddR-0006u7-Q8
 for qemu-devel@nongnu.org; Sat, 03 Oct 2020 05:15:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601716520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aqKUOGkrbnr63pzYqTB3ZzHYKIeURmurnEarIe7Rvvs=;
 b=MMjF4IRQzRG46yFAg3mnwN5Lbl7yuZ6ZzQedpre4OIDviCXuaQz9Pfuazcv9Z3GO/4AUs4
 9rj+v2sMEETHM3USamLQXOzF3gLYoKdpp22Kxv6Xh94qHXofFbGHmGAoaN5K1bnIEz8TaL
 gNOXpV2iixEky6byTAYLIjoFBZwizYU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-542-N65oRKJJNluGIbaRqC8nfg-1; Sat, 03 Oct 2020 05:15:18 -0400
X-MC-Unique: N65oRKJJNluGIbaRqC8nfg-1
Received: by mail-wr1-f71.google.com with SMTP id i10so1611031wrq.5
 for <qemu-devel@nongnu.org>; Sat, 03 Oct 2020 02:15:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=aqKUOGkrbnr63pzYqTB3ZzHYKIeURmurnEarIe7Rvvs=;
 b=TO5QPlj6LFcTkeu7TzE0M9/1jNs1V5WSGF0G+TRsIuZ9ybfZVMhx0AfCzfeK3kptEv
 /GhmY8bTxtGjT8YNXsLDwE4wSRqBy5qT/7cNzq0ZAF6ZqJ1HExYTaMQYFZviCfiUPr1s
 f7Cq6lsCDYt0gJvzS73jgk4voyJ/cxXbTn1fW7Or9dyfqML4+fxv5jXytm53qTPvz3sn
 mv7cGC84Kah7+JJXHABLlT37pWsLhpOj6IvUaEDlkg+VLvMXcwXZeKnI7DldqB0bSj0q
 OX+hhzpqG3JE2/YFlKJdYH2h1amXJRaD11/1u26S1oKYpg0SlrK8DZw+iKjX6n258Ol/
 9tOA==
X-Gm-Message-State: AOAM5306rk6vI1tj3k3CusYdsaOF60Xoz7mglMML90kHLPdw5FFeMpLd
 gTkJFwUedA14/VkWt9F9n8C+jt7TiH7rONKd2l0OW9AtMwzkQvVtIvyJGJuWyeX8Tu50ZGMWLgy
 sH8yEQTCgbOhFlig=
X-Received: by 2002:a05:600c:2283:: with SMTP id
 3mr6672798wmf.37.1601716517515; 
 Sat, 03 Oct 2020 02:15:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwuZsAFYWY9R1UvmHiZnykHjHdsZDTkQDQNxn0/9jGcI0CxopfrV7re4bXbSYQ1Toe2oTw9CQ==
X-Received: by 2002:a05:600c:2283:: with SMTP id
 3mr6672777wmf.37.1601716517335; 
 Sat, 03 Oct 2020 02:15:17 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
 by smtp.gmail.com with ESMTPSA id n10sm4714605wmk.7.2020.10.03.02.15.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Oct 2020 02:15:16 -0700 (PDT)
Subject: Re: [PATCH v4 02/12] meson: Allow optional target/${ARCH}/Kconfig
To: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200929224355.1224017-1-philmd@redhat.com>
 <20200929224355.1224017-3-philmd@redhat.com>
 <31a173bf-6aa3-1ce8-7d14-5e8f11e2a279@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0303fe78-5ae1-2115-247c-71807ce74e12@redhat.com>
Date: Sat, 3 Oct 2020 11:15:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <31a173bf-6aa3-1ce8-7d14-5e8f11e2a279@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/03 02:43:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.256, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Claudio Fontana <cfontana@suse.de>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/10/20 11:13, Richard Henderson wrote:
>> +    target_kconfig = 'target' / config_target['TARGET_BASE_ARCH'] / 'Kconfig'
>> +    minikconf_input = ['default-configs' / target + '.mak', 'Kconfig']
>> +    if fs.is_file(target_kconfig)
> Missing a meson.current_source_dir()?
> Leastwise that was a comment that Paolo had for me.

Not sure, but it was the only way I thought the BSD build could fail;
unless the capstone submodule really was not present in Peter's checkout
and submodule update was disabled.

Paolo


