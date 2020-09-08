Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F117C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 14:21:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C33422527
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 14:21:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bzNRaTas"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C33422527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFeVG-0005pz-AN
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 10:21:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35546)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kFeUd-0004xy-HV
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 10:21:07 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50579
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kFeUb-0005wL-OQ
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 10:21:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599574864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x8qJR821XPh0WeVPk0RkbkbE+s58ONfc9kBDUAfA/xY=;
 b=bzNRaTas3sfAgtvYp6KMULahue8m3jkFu57PdoB/yWP5t3Ao3VQj9acgUlBn/mEfIY9lTV
 tyHKYRVkTQUERLD6E1tMuBfVeuFqCj4ye1q5fk35bbVtYXvkli16FdvccmAgh8a2wo6Vr2
 AUPvQSoOPuovo3dI8dhOTdz5ADuk7i8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-Q4dXL3fNN7yvhLbOY6t2TA-1; Tue, 08 Sep 2020 10:21:02 -0400
X-MC-Unique: Q4dXL3fNN7yvhLbOY6t2TA-1
Received: by mail-ej1-f71.google.com with SMTP id dc22so966130ejb.21
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 07:21:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=x8qJR821XPh0WeVPk0RkbkbE+s58ONfc9kBDUAfA/xY=;
 b=dGqId9s8QT32h9rZspHNNHM4y3d81iPNxj0Sw5jqk/VBCWN8HkpjzGyrmLO+hNyJSZ
 TgYi0bjB5jakZSs2/Hzh+RkDhUqG0a2kmSM5KhsQ/wPjRX9IQt145zMhnwzXkw+eDUQ9
 JB/BW6wuO3argOS0De4+VeBkk4oMhgM7lpNY/KRHUZsPgbgzR7tjUFlMWJMhqYmKc2/d
 TOcTbEDl/P2FCAu6jHsokfEOnS0Ua1sU5NZ2K48Wgc1iLsNjl6BRyBzjz6dcoBL8VwQB
 jiG/D6vl+15fYMUKbbJFXonxCa0zvuMybqt/QNbXDB4V9NdDphswGIZHJ9s6GRigbQx8
 +6vw==
X-Gm-Message-State: AOAM531ompBrufa710AePKdHLLiGmxtql0L4L3xba6u6lBRZi6k8lKHD
 szxOaPl/VYyiEfLwfRSYs1hsAPgs12ffb7efrhBKcD0CKzji8DFEYnz9uATZTxPZ6VKeqOnyka7
 +lQMg2JWbVfEh0Zs=
X-Received: by 2002:a17:906:9941:: with SMTP id
 zm1mr25644356ejb.288.1599574860887; 
 Tue, 08 Sep 2020 07:21:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxKaoYCKdYPFohqPoEI2ZtlP565cg9i3MthkL4q5A+M1cPAzOkNv2IlykLU3oqS74Ge9xYgBw==
X-Received: by 2002:a17:906:9941:: with SMTP id
 zm1mr25644337ejb.288.1599574860709; 
 Tue, 08 Sep 2020 07:21:00 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5f70:b94c:ca5f:28f2?
 ([2001:b07:6468:f312:5f70:b94c:ca5f:28f2])
 by smtp.gmail.com with ESMTPSA id s7sm17610648ejd.103.2020.09.08.07.20.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Sep 2020 07:21:00 -0700 (PDT)
Subject: Re: [PULL v5 00/46] Next round of Meson bugfixes and cleanups
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200908094408.27091-1-pbonzini@redhat.com>
 <CAFEAcA8JZhrxNgayLaCGqQiGLhybvXo7qrXDUpVmkrX5FmjV5A@mail.gmail.com>
 <dbc559bd-8e4c-d4d3-6719-143cd8b7b8d7@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <86ce5e95-dc8a-f830-4939-eef7218303fc@redhat.com>
Date: Tue, 8 Sep 2020 16:21:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <dbc559bd-8e4c-d4d3-6719-143cd8b7b8d7@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 03:00:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.626, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/09/20 16:13, Philippe Mathieu-Daudé wrote:
> 
> Makefile.include:144: warning: overriding recipe for target 'check-block'
> Makefile.mtest:1339: warning: ignoring old recipe for target 'check-block'
> config-host.mak is out-of-date, running configure
> 
> Nothing to worry about as Makefile.mtest is generated.
> I wonder if it is possible to avoid such warnings though...

It's not possible, but it's harmless:

1) it goes away as soon as Makefile.mtest is regenerated (which happens
before any goal specified on the command line is evaluated, so before
any "check-*" rule)

2) it only happens in a very edge case of moving stuff *from* Meson back
to the Makefile, i.e. in case of wrong judgment as for check-block.

Paolo


