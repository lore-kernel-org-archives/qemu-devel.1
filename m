Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38294C4727C
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 15:54:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 768DD206D4
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 15:54:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cV1Usv1r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 768DD206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNeQe-0004sn-6b
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 11:54:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48844)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kNePF-0003og-W0
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 11:52:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47264)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kNeP7-0001Ff-9F
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 11:52:37 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601481147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aiFPY6DgDW25pbzHrBw3/r3jRS93ts9OuVONtZOkT5M=;
 b=cV1Usv1rAE0OV/916L4tur6LLvkgw3k4V+Nlezreu/V1fKGKrpR/tFbU2q8HBr4wgQ75fj
 cNO6BPzINNlx2ozXH8lUHxt57vvn7l+buAR6R0C64n3IiFKCfK2SmCmHKe3zMBLYnXfXi7
 SItySSYoY2KchsbYp7wcgIAd/A1MzNA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-X0fqqBZFNsGjc6fHzEECDw-1; Wed, 30 Sep 2020 11:52:25 -0400
X-MC-Unique: X0fqqBZFNsGjc6fHzEECDw-1
Received: by mail-wm1-f72.google.com with SMTP id y6so782638wmi.7
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 08:52:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=aiFPY6DgDW25pbzHrBw3/r3jRS93ts9OuVONtZOkT5M=;
 b=nzvgKjUdo8hsRCc61yTU7fsJOst6Hjso4dZdp2COHUV9zIEWys2UQbd19KyMeXWEfW
 mCj7IMP2j+XgG/p9Qtt5YV7exyQwUrUcE6wQ8uHE+q4WbwOfiD7Sk5q5Y2bSc9PIZ0/a
 Fv+Bch3e9Vo+ZXGBU53552XMkyBdgY7aalMhFOwbIGR3329inhCajRW2KKVoWVhnxGEQ
 GIAlVzAo+4JqOZUuzIUbRu0yF9Sq+hIy81qbH1KN5dP3LAfhjX7il3PZXwSiSSJ64hDX
 ZAfq5r5uHP4R3nogtD+dNddBUaE3ZAvxNvPAznCZuFcmtAEMjuKQ2jv/VKKsG4hNLKGe
 V0Kg==
X-Gm-Message-State: AOAM532l4aO/rHx/7BGZ9DzJGFXe+N7ZUUellPb4JYJ+U8yYE4o8B422
 zCNq/pGmoGSeWWVx5+k9YDRCBvaGfXRfVX38L6RtSvIA9T6O5zWlqeZ/Y08B8/7IESXEfzoVqIg
 JO4bLyUIdGIolDHQ=
X-Received: by 2002:a1c:2cc2:: with SMTP id s185mr3882059wms.77.1601481144390; 
 Wed, 30 Sep 2020 08:52:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwHiatQiZ17QhNTIpJSgIEgoYRy5DSa4lBTT45g+oZeWVMejhHN8fekQu89mMqbO74ZNo8rsA==
X-Received: by 2002:a1c:2cc2:: with SMTP id s185mr3881982wms.77.1601481143485; 
 Wed, 30 Sep 2020 08:52:23 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:75e3:aaa7:77d6:f4e4?
 ([2001:b07:6468:f312:75e3:aaa7:77d6:f4e4])
 by smtp.gmail.com with ESMTPSA id c16sm4107511wrx.31.2020.09.30.08.52.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2020 08:52:22 -0700 (PDT)
Subject: Re: [PULL 13/13] qemu/atomic.h: rename atomic_ to qatomic_
To: Andrew Jones <drjones@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
References: <20200923161031.69474-1-stefanha@redhat.com>
 <20200923161031.69474-14-stefanha@redhat.com>
 <20200930152805.tycn6lcm4qx74phi@kamzik.brq.redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <63f0fefc-1429-d454-cc65-012bed584b2f@redhat.com>
Date: Wed, 30 Sep 2020 17:52:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200930152805.tycn6lcm4qx74phi@kamzik.brq.redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:31:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 30/09/20 17:28, Andrew Jones wrote:
> pvrdma_ring.h is an update-linux-headers.sh file. When running the
> script again we lose the atomic_ to qatomic_ renaming. I've hacked
> the script by adding
> 
>  -e 's/\batomic_read/qatomic_read/g;s/\batomic_set/qatomic_set/g'
> 
> to the cp_portable() sed command, but only considering the two
> qatomic_ functions currently used is obviously not a complete
> solution.
> 
> Any ideas?

My first thought was that it's strange that there are atomics in a uapi/
file, and in fact the file is not uapi/ but rather part of the driver.
I think we should just copy the file into QEMU sources, and remove it
from update-linux-headers.sh.  The "s/atomic_t/int/" can go as well.

Paolo


