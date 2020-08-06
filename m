Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B476AC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 18:46:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB13E22C9F
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 18:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b5QKtck6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB13E22C9F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3kuQ-0004pU-Me
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 14:46:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36742)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3ktp-0004Pu-EK
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 14:45:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32430
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3ktm-00031T-U8
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 14:45:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596739553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CQQrzPDjd/07mEskDMYOoUY76s2jjBykfjYQf48Lamw=;
 b=b5QKtck62QyOtAMBD3xnZY4YNF4+f9CawiNSEeCHTFF0ORN6IeQ9AfZPNXHI1hE1VDQhYf
 +Z/shfaVMfgiZ9dDXpxMHUBEaZVhQXYH8m9UTkWNxz95Qn6boJZl8yKtW0xfDGYRNCUAqG
 s+PZUirXzIP+ylmSNjpuNE0UxnETLkc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-INHHuDBVNz6-s-QxCHVzgA-1; Thu, 06 Aug 2020 14:45:51 -0400
X-MC-Unique: INHHuDBVNz6-s-QxCHVzgA-1
Received: by mail-wm1-f71.google.com with SMTP id d22so4457228wmd.2
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 11:45:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=CQQrzPDjd/07mEskDMYOoUY76s2jjBykfjYQf48Lamw=;
 b=GKjw2UgHZIfujJGkPcsEis3+mC8jfkDXVCGrhqAO62K5NWcuC9/zGZHGBiYCbW5jsd
 oT/n5WT5nBVbz18II6LIlNYzpkQ6vCTLEsg7IxmhAxehOkJ0U5ICOGzS5Ca7/LpR2cgN
 QKXrNYwLMnKl2PxWrtbTeK8JF+kIxe7gn2HxXzadwP20s2ay9DGsJNOkhDGNWfR8TQXR
 aV5VgjgBRQSSUCWyhoUSOYueqjQ7vR/KvQ1Y9cpNsIcxAlHBM4Md2kB68JldnfnezkKE
 gmPQlpUpdtF275LeWYwd23BaCFQ0jkfQAs5n6Mlr4tZXa0ev5bfRhUpxAaxydvHoqut8
 vo4A==
X-Gm-Message-State: AOAM532qFfHnIdHEX3xuzvAb1cqmcN7aXlygxxo+VADbMOaqHjxeOZ6R
 P5YuXP9BFAN/mIzkikecKKx6yztQjVqWc/q3tdOVlg8D+WmGDAlpFClGVq+AuNWRthq5TLj+hxK
 Y3PifZObI72xvwf4=
X-Received: by 2002:adf:b18d:: with SMTP id q13mr8538450wra.256.1596739550244; 
 Thu, 06 Aug 2020 11:45:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzoe8mq9+phxfLVlOY2u/C/rfaR+NqIJchvjGIJmwHgakL7Pza43O4GPwksalX0wV8xGxfiJg==
X-Received: by 2002:adf:b18d:: with SMTP id q13mr8538438wra.256.1596739550022; 
 Thu, 06 Aug 2020 11:45:50 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7841:78cc:18c6:1e20?
 ([2001:b07:6468:f312:7841:78cc:18c6:1e20])
 by smtp.gmail.com with ESMTPSA id u6sm7014004wrn.95.2020.08.06.11.45.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Aug 2020 11:45:49 -0700 (PDT)
Subject: Re: [PATCH v1 01/21] accel/tcg: Change interrupt/exception handling
 to remove implied BQL
To: Robert Foley <robert.foley@linaro.org>
References: <20200805181303.7822-1-robert.foley@linaro.org>
 <20200805181303.7822-2-robert.foley@linaro.org>
 <ca24d2c5-2c5e-eace-4cf2-90011e684485@linaro.org>
 <4e678ed7-fc36-7918-ce9e-7a7e309c56df@redhat.com>
 <CAEyhzFvveC=nhpo4uyJ_89J8Wi4+9NEc2T2Mk9mg6Y9ZMQjNSA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3aff0517-86db-5ea4-8d01-c166dac4aeee@redhat.com>
Date: Thu, 6 Aug 2020 20:45:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAEyhzFvveC=nhpo4uyJ_89J8Wi4+9NEc2T2Mk9mg6Y9ZMQjNSA@mail.gmail.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 03:10:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, "Emilio G. Cota" <cota@braap.org>,
 Peter Puhov <peter.puhov@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/08/20 18:11, Robert Foley wrote:
>> Indeed the series should be structured like this:
>>
>> 1) rename all *_do_interrupt functions to *_do_interrupt_locked
>>
>> 2) add back *_do_interrupt that takes the BQL and calls
>> *_do_interrupt_locked, point ->do_interrupt to it, remove the BQL from
>> cpu-exec.c
>>
>> 3) modify the cpu_mutex and BQL critical sections around
>> ->cpu_exec_interrupt, so that the BQL critical section covers just the
>> call to ->cpu_exec_interrupt.  Document which fields are now covered by
>> cpu_mutex.
>>
>> 4/5) same as 1/2 for ->cpu_exec_interrupt
>>
>> Patches 1/2 would be pretty large, but they're trivial to review just by
>> grepping for "->do_interrupt\s*=", and likewise for 4/5.
>>
> 
> Thanks for the details !
> 
> It seems like we will have 3 separate patches for this series, 1/2, 3, and 4/5.

No, five patches. :)

Paolo


