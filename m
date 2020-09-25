Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F9A8C4727E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 21:00:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB8F8206B2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 21:00:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fY2ZkN8c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB8F8206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLupc-0003fG-Nn
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 17:00:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52448)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLuoI-0003Cx-Hv
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 16:59:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28821)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLuoG-0007n1-8b
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 16:59:18 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601067555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ipYIDOgeVmeLzsWlt8kIR4qi3yc8aEEDaW8MVi2qXp8=;
 b=fY2ZkN8cpIRl+E+f3p75eKoN04s6CpZ9H/GqEsYpCIBoGCAbzdfvLF51ogpLx+YYzB7Tr+
 n6Y3k8XiR0nVMtnSFezVRnJTh0i4Pc1nSki7D89/u6uabs9GIvSlM2tOonrn+hfHe5K6om
 gJMVKueaYxkN19dJgl96DUUnfFeoT3g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-oXo4-mBcPWKMsvOyTd2uuQ-1; Fri, 25 Sep 2020 16:59:13 -0400
X-MC-Unique: oXo4-mBcPWKMsvOyTd2uuQ-1
Received: by mail-wr1-f70.google.com with SMTP id v12so1553259wrm.9
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 13:59:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ipYIDOgeVmeLzsWlt8kIR4qi3yc8aEEDaW8MVi2qXp8=;
 b=sZ7znkmzJpNi6EegJLbwF8dIUqiiVD6u868EiQWRtRYQy5BMV38i4rcgCk9w5HufzA
 /cbS/+lmVjAiii/Ff/0H0idweFDrJFlzOlgGSJWtze4XsnL2GaWt03IuLQk8eZkVY32t
 iGwUxLLQdI+bVCm30vbTc6NNJH1Vo2Y6ndRGnfxBbKksH+M0BrNRe5WsR5mhM1hYgdsn
 et9dgcxHuTFmwssmdNtwb8sR0x+7uFxX/RU2vFWpOxIVBpFhUyGLRzuTtdn8aq3GqILD
 2XnugV7IKux+ios+BpLYVZcuw0d4rseKXtMwuvn3kIlkhFI4e2y5+EmYQXceQY5GF/Q8
 B1Eg==
X-Gm-Message-State: AOAM530wGIF/eLDMuy/mG6B37GXz5+E+twY/KlFqOg+2Oj6ccPDHWFWo
 1l6aWvl89p8aj/k7aoC2hKXXL9P1bFafB4PNWHW4xZ6NmhVI05xBzHL9avUvZcB5yP/rs8Pdu27
 d1ld02wahiljhOcc=
X-Received: by 2002:a1c:f407:: with SMTP id z7mr432089wma.110.1601067551815;
 Fri, 25 Sep 2020 13:59:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyu9A7sFbZMBMdAOI3MIhIfCwsLkQYNvYT1f9j7rxrwIhmyPt6649+q4U9Lu3AdtldciwilWA==
X-Received: by 2002:a1c:f407:: with SMTP id z7mr432073wma.110.1601067551614;
 Fri, 25 Sep 2020 13:59:11 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ec9b:111a:97e3:4baf?
 ([2001:b07:6468:f312:ec9b:111a:97e3:4baf])
 by smtp.gmail.com with ESMTPSA id q12sm4046869wrp.17.2020.09.25.13.59.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2020 13:59:10 -0700 (PDT)
Subject: Re: I wanna fixes plugin on windows, any suggestion
To: Richard Henderson <richard.henderson@linaro.org>, luoyonggang@gmail.com
References: <CAE2XoE-PpsaqJOfEq0iUSkH6N8skkqFAY+2QkSbnENiszA0xQg@mail.gmail.com>
 <a50bc12c-7aa1-19a3-c39e-02328aeaca38@redhat.com>
 <CAE2XoE9F5_gGsiFutW99mbPUbUb2rmG+2+9pEDKrhvu9QRwYvw@mail.gmail.com>
 <a808929b-f93c-f68d-da4e-02133b4fcb54@redhat.com>
 <c0eee78e-9336-65e2-bd12-a762aab78c3e@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <56d6a3f9-8740-2274-5489-2d80aecf9387@redhat.com>
Date: Fri, 25 Sep 2020 22:59:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <c0eee78e-9336-65e2-bd12-a762aab78c3e@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 01:07:33
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
Cc: qemu-level <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25/09/20 22:50, Richard Henderson wrote:
> On 9/25/20 12:25 PM, Paolo Bonzini wrote:
>> On 25/09/20 21:23, 罗勇刚(Yonggang Luo) wrote:
>>> That's what I am tring to fixes? what does  one import library per
>>> emulator, can we do this like NodeJS does?
>>>  NodeJS have NAPI support across platform. They create a windows .lib from
>>> node.exe
>>
>> You'd have to create a .lib for qemu-system-aarch64.exe, one for
>> qemu-system-arm.exe, etc.  On Linux the same plugin will work for all
>> emulators.
> 
> Which is clearly silly.
> 
> So what you'd do is create a common .lib that all of the plugins link to, and
> so do all of the qemu-foo.exe.
> 
> This would probably involve creating a set of call-backs that qemu-foo.exe
> would need to pass to the common .lib at startup.  It's harder to do with
> windows than linux, but it's not impossible.

Yes, or you can skip the .lib/.dll completely; you just place pointers
to the callbacks in a struct and pass it to the plugin when it's loaded,
through qemu_info_t.

Paolo


