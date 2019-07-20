Return-Path: <SRS0=lwXe=VR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04522C7618F
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2019 01:52:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEDCE20880
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2019 01:52:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ScLhFB6N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEDCE20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoeYO-0004oi-3X
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 21:52:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47035)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.weiyang@gmail.com>) id 1hoeYE-0004Q1-Hz
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 21:52:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.weiyang@gmail.com>) id 1hoeYD-0000Oa-LI
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 21:52:42 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:45464)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.weiyang@gmail.com>)
 id 1hoeYD-0000OH-EZ
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 21:52:41 -0400
Received: by mail-ed1-x543.google.com with SMTP id x19so30022678eda.12
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 18:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=kKDVYzlr0otQBxtIFN0tTdw2COmr0FDfk5g1AJpDz+k=;
 b=ScLhFB6NaW+4WSqaiYXuDDjaQLgb0V4LNqAg9MFFIDMFCUoq2+4od9oS4EWKWeQCth
 ZZtXq4Ya+uZ3/sVI5eATZfCeVpt5QW5ryxc9UaUUh2NYDFJd6y5OeStbFgDBeYeorHcJ
 5aCesG4DPxqTYXyWi/pLSad7Hq/8Q/hcQJv45wL+nCrTbiwzPD9FWSe+K1RF1VYwJPup
 0T9qk40MLhPCXXNcCePki3IIvwcNUgImMcpcyR02iR54iS4du19IoNTTW+EVCDJRKEgS
 IHBFOqdkEnwNP9jvPO0aQ8uqoOTiCv29l+jpaG/kh8mc13f/6e8lKnMjToXzkhJ/ChsC
 DIiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=kKDVYzlr0otQBxtIFN0tTdw2COmr0FDfk5g1AJpDz+k=;
 b=EDD8ZJkMY432/42V27qJbKp5ANDzr/QQDqFe5vm+iDod5jyo5st6QZVaRM5vCPEI4A
 1n6PYTvP6Xo7GZhmXL2YXgOiIYsDlcHOY558n0m6x0MymwwyWVbEq5/qJP3NqedsEcN/
 MIZC//QEGupOQFTh4MB0WMRCPV0i6CmSDKhQtpHzKzfG00Nj7IJmSJxXVbT4jhUx9CZT
 H1xYnq97sU/pgiU2Y5LjEheCg3IKPm5h9amZJvJJogsRB3LhiBwyE7Qy9Hy/G8aTPB6F
 0xFHsTuQIsUoO9XJVIJeoxKr8TeSvn1iaCprPkCIUJf3xBhcJIDaG/qe5m8LwvLaR13X
 XNmQ==
X-Gm-Message-State: APjAAAX+4LoNX23mRtWLyb2ulC2Ynn7W8NVQxPPC81PSTvQ6mq9KTSBF
 YKTLePxUhEcHImuZ4OJ1q0A=
X-Google-Smtp-Source: APXvYqy717jBUWIZQ9sIoRKN8i8E5ASQqoLCBhHc93YJs3/UO+oDnFtolZD45YOX3H5vRg4gkSTzuQ==
X-Received: by 2002:a17:906:9256:: with SMTP id
 c22mr43170879ejx.172.1563587560593; 
 Fri, 19 Jul 2019 18:52:40 -0700 (PDT)
Received: from localhost ([185.92.221.13])
 by smtp.gmail.com with ESMTPSA id v8sm8814046edy.14.2019.07.19.18.52.39
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 19 Jul 2019 18:52:39 -0700 (PDT)
Date: Sat, 20 Jul 2019 01:52:39 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190720015239.ngofis5b56yzh3tm@master>
References: <20190718064257.29218-1-richardw.yang@linux.intel.com>
 <20190719184128.GO3000@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190719184128.GO3000@work-vm>
User-Agent: NeoMutt/20170113 (1.7.2)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::543
Subject: Re: [Qemu-devel] [PATCH] migration: equation is more proper than
 and to check LOADVM_QUIT
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
Reply-To: Wei Yang <richard.weiyang@gmail.com>
Cc: quintela@redhat.com, Wei Yang <richardw.yang@linux.intel.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 19, 2019 at 07:41:28PM +0100, Dr. David Alan Gilbert wrote:
>* Wei Yang (richardw.yang@linux.intel.com) wrote:
>> LOADVM_QUIT allows a command to quit all layers of nested loadvm loops,
>> while current return value check is not that proper even it works now.
>> 
>> Current return value check "ret & LOADVM_QUIT" would return true if
>> bit[0] is 1. This would be true when ret is -1 which is used to indicate
>> an error of handling a command.
>> 
>> Since there is only one place return LOADVM_QUIT and no other
>> combination of return value, use "ret == LOADVM_QUIT" would be more
>> proper.
>
>Yes, when I first wrote this it was more complex with a few flags, and
>they all got removed.
>

Ah, life is much easier now :-)

>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>
>Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>
>> ---
>>  migration/savevm.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/migration/savevm.c b/migration/savevm.c
>> index 1a9b1f411e..25fe7ea05a 100644
>> --- a/migration/savevm.c
>> +++ b/migration/savevm.c
>> @@ -2429,7 +2429,7 @@ retry:
>>          case QEMU_VM_COMMAND:
>>              ret = loadvm_process_command(f);
>>              trace_qemu_loadvm_state_section_command(ret);
>> -            if ((ret < 0) || (ret & LOADVM_QUIT)) {
>> +            if ((ret < 0) || (ret == LOADVM_QUIT)) {
>>                  goto out;
>>              }
>>              break;
>> -- 
>> 2.17.1
>> 
>--
>Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

-- 
Wei Yang
Help you, Help me

