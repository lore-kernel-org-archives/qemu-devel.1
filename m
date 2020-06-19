Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 064E6C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 11:18:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C57AC2080C
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 11:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VjhQe9Vh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C57AC2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmF22-0006MF-1c
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 07:18:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38852)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jmF0z-0005um-OC
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 07:16:57 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39038
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jmF0x-0007C1-SZ
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 07:16:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592565414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=osd5pFx+U2eevLVAgSmSrOZdWTvcs74sNafhhajY6f4=;
 b=VjhQe9VhdXDOg+HtckLoOfwuq/woZgYN1f3G1tW/j39FC5gmy+PtNnaniVl10mAkEWiv5t
 ieIrnefGj0k/ONBhl5LP2O2cSy/1uQi3FkUjur3DGPfyTVAVwbD1nMTj9cs+2uT++6YL+Y
 nJzx6DMe0DKM2WBxwznncksOP0gEO9g=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-wos40eidMhmWFApgMiK4AQ-1; Fri, 19 Jun 2020 07:16:52 -0400
X-MC-Unique: wos40eidMhmWFApgMiK4AQ-1
Received: by mail-wm1-f71.google.com with SMTP id a18so2568918wmm.3
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2020 04:16:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=osd5pFx+U2eevLVAgSmSrOZdWTvcs74sNafhhajY6f4=;
 b=BlzuHKVzQqbr1U9T/5AboMG/U81CaXU+gupo4ztcx0+xjxHl/aiAlbgiCKIKRUmUSD
 XYU90v0IRNhxqg0izBksrG55qT7LZjnMLaNNRH7BTq6ZnsiUu8ln5KhYIyurUKdWMIQ1
 uOmi4MDXCkPmK0EkMDppdIOdceEDaRTk5v5MdUyNWcIMJ7MgdSK06aSHIFo1cTHC6nrw
 4HXsQWQ+D8FJA+ZmwNrB1CP6K63qDeMd1q77PfZXlmILH5LEtq7PHMJ9+2PKO9fW15XY
 rBuhSa54GLHElCbND6GG5p83r3tqmE3W+sL7P1HnJ9Xf/RH7UBJRxnf19OG+WDK92Ia5
 aaxg==
X-Gm-Message-State: AOAM532sjbWeLp1WbnYp9ZzpVQpgByfax4n4R0+mdLiv+H6UZM1mAhnI
 8VgYJEEJcummr33y9+mcmuFtQ/qdBlUN2aBVveGGs7yOvB/pwG8q23/W8L/Ba/W1CAXb/I1yRYH
 t9tuiMU460zx7fks=
X-Received: by 2002:a5d:6a90:: with SMTP id s16mr3488322wru.8.1592565411855;
 Fri, 19 Jun 2020 04:16:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxbu5sD72jPCS6qn0fRW8Pu/lix+Kp7hS+0RIs0rvYoQzAHg9djB0dOAnV0XD5hb2z6W6UZCA==
X-Received: by 2002:a5d:6a90:: with SMTP id s16mr3488309wru.8.1592565411658;
 Fri, 19 Jun 2020 04:16:51 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e1d2:138e:4eff:42cb?
 ([2001:b07:6468:f312:e1d2:138e:4eff:42cb])
 by smtp.gmail.com with ESMTPSA id 5sm8402155wrr.5.2020.06.19.04.16.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jun 2020 04:16:51 -0700 (PDT)
Subject: Re: what are the requirements on target/ code for -icount to work
 correctly?
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
References: <CAFEAcA_HOxdK5rgKVnww6Bum3vGb=TrhDEp7oqDwsd=UbHmC_g@mail.gmail.com>
 <c47e9e4e-49eb-88c5-fdc7-8ebec121c165@ispras.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f4fc4a1b-4054-cffd-0272-22c28d656aba@redhat.com>
Date: Fri, 19 Jun 2020 13:16:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <c47e9e4e-49eb-88c5-fdc7-8ebec121c165@ispras.ru>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 01:50:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/06/20 07:46, Pavel Dovgalyuk wrote:
> I think, that we need some efforts from target maintainers to remove all such calls. 

I'll take care of target/i386 (which does need one of the three
gen_io_end calls that are left).

>> Q2: is it a requirement that after an insn which is a "known
>> to be an I/O insn" one (like x86 in/out) and which is marked
>> up with gen_io_start()/gen_io_end() that we also end the TB?
> 
> It is a requirement for instructions that access virtual clock/icount
> value (directly or not).
> 
> There is also an assertion that can_do_io is enabled while generating an
> interrupt. I believe, that it doesn't affect RR, but is useful for
> deterministic icount mode.

As I understand it, the definition of "I/O insn" is anything that can
either:

- affect the icount deadline (e.g. by setting or removing a
QEMU_CLOCK_VIRTUAL timer)

- interrupt the current translation block with cpu_loop_exit,
cpu_restore_state or similar.

Paolo


