Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A511C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 15:28:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36309251DC
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 15:28:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RNLy17lJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36309251DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpviI-0000Ex-Go
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 11:28:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33712)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jpvhh-0008Et-NQ
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 11:28:17 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40153
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jpvhg-0002Br-6k
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 11:28:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593444495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pKg8ZddvbHzraPHDQ1GNO6Fx+FnKGii3D1djHVBSRHU=;
 b=RNLy17lJiS3IRuvcxZhD7KLaTt3Yhhmk8O9jWHBVv8bPK5Or/KyBbmohFoYBLxz0J7nJMq
 38MdTbzAZPt6UrWY0KA3gIE3vXX5HdYJek+bDRO9GngorDeFz4U+r67CDjp5TSH9856ZAF
 pfhhqqKnLIg0jzrRTSnN7UcMDSLztic=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-JZLVwHlOMdWgnozc-MnqUw-1; Mon, 29 Jun 2020 11:28:14 -0400
X-MC-Unique: JZLVwHlOMdWgnozc-MnqUw-1
Received: by mail-wr1-f72.google.com with SMTP id g14so16675278wrp.8
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 08:28:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pKg8ZddvbHzraPHDQ1GNO6Fx+FnKGii3D1djHVBSRHU=;
 b=lTJF/2hOjD1XatAu6r7ALkFm7HiqGJTW+3C4op3Kzphlau1PjkrkL36mJQXcTGCJud
 ma8NAUKJvBgl4k19bnitisONrqXTvh1HjCT59ojh8OPBS83Qp/RcgT2jsMBrMy9qPeBt
 EcdNsnl1L0t13+rqUy6nAf4EI5bzYuNuRafnW+JZL6bXtB9mrcrvyAHKiI82q/HPRGuE
 omWDlyHNC12asveTSCXdWdHnaA/wkiIjd0M8xNqCa0MdShoSXKq7z731GG0rVpdSJ7th
 L9qvYXqPkOCJYGF5ZBpLAkdNl26bBvXuZhZ75hY8qZpcOXFBoVoCcYY0WgFnP9xrrAAP
 T3tQ==
X-Gm-Message-State: AOAM533mXo+nB/5SeUtgYJr8xMlNv9W7cupKdNDdXjQ7XwUYROGlhu6t
 NJfMmVS0Zfw5swhDuX/E7OrMxj7Lszr4xoc+cPMmD7ppInCcWiPoSpXWYRpBCAaas+B6nGgjOHZ
 vlxfwjmVn0UzwBT8=
X-Received: by 2002:a5d:470b:: with SMTP id y11mr18177247wrq.101.1593444492892; 
 Mon, 29 Jun 2020 08:28:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwOxspwzzS7d5cE0Im8919Tgh6IrsFG/UxYCvKuJbmYjG4/hd1vSKB47vEUNlNQZf7Vt9JhMw==
X-Received: by 2002:a5d:470b:: with SMTP id y11mr18177234wrq.101.1593444492730; 
 Mon, 29 Jun 2020 08:28:12 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:b0e5:c632:a580:8b9a?
 ([2001:b07:6468:f312:b0e5:c632:a580:8b9a])
 by smtp.gmail.com with ESMTPSA id e17sm33713wrr.88.2020.06.29.08.28.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jun 2020 08:28:12 -0700 (PDT)
Subject: Re: [PULL v2 25/31] osdep: Make MIN/MAX evaluate arguments only once
To: Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20200626135608.6920-1-pbonzini@redhat.com>
 <20200626135608.6920-3-pbonzini@redhat.com>
 <CAFEAcA9DOyivMUS1gAE_BPcmO7yf6J8d-_YZ8W=Ox8U_O0QcBg@mail.gmail.com>
 <82b6d089-3270-6bad-1165-33c148b4a375@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f09e9c8c-0f17-16ae-f1eb-e9dae594b208@redhat.com>
Date: Mon, 29 Jun 2020 17:28:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <82b6d089-3270-6bad-1165-33c148b4a375@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 01:06:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/06/20 17:23, Eric Blake wrote:
>>
>>
>> Can we do something (eg providing fallback less-intelligent
>> versions of the macro ifdef __COVERITY__) to help it?
> 
> Absolutely; I see we've done similar in include/qemu/thread.h.  I'll
> post something later today.

Done already, you're in Cc. :)

Paolo


