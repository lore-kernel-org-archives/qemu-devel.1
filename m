Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C9E3CAB362
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 13:42:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A331206D4
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 13:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PtjvHoI9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A331206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT41a-0002aI-6B
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 09:42:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47272)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jT40h-0001Bn-NB
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 09:41:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jT40g-0000Og-Ih
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 09:41:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23748
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jT40g-0000Kh-5N
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 09:41:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587994881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ow14MiYAm/g/CjsiLA/pEqWJunuyeK093MWYTll2V/Q=;
 b=PtjvHoI9fnftGAvR1F+1hup0HdkkQK7Hpm7IlJs01r1usKkc5pstPFQ2iOPO5KUfKrEwab
 OPkjSTqdndtKKX0lVmAo5WINaNonLKspBb6+V3mqd/zltvYd7my7jYBAfe7tdD2AmHdjXX
 ShSnqX2r5Nnb2gVhSIzYYzTMLynwOR4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-8o2ioXAYPpmoCQrE-NKrpw-1; Mon, 27 Apr 2020 09:41:19 -0400
X-MC-Unique: 8o2ioXAYPpmoCQrE-NKrpw-1
Received: by mail-wm1-f70.google.com with SMTP id v185so8701031wmg.0
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2020 06:41:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ow14MiYAm/g/CjsiLA/pEqWJunuyeK093MWYTll2V/Q=;
 b=A1hUpgccrWwZR9G+Fq6AmRoYy8bfiinXc9t+GVJ9E6CsQY6LNHEdVyI7nHXeGlDgaF
 Qi5F6txh25WdaORn5RHKKLHx7rv9eohB4CzxfP3O/An+09J6XCkPKi/XEFOdOn7+XCr7
 JsUL3X59yZ2O4mNORkxPaT0rX1A+CLoGo5wxkOW76IwI6OWMOPamQyVCb/CFGCyY08jO
 +IH7wPzfWqjv1lFE7tZXd+7EFNMNJ+VH6J5p7LelIsGH4rC1QcKuwRxS7sC/DXGuZjbZ
 yYJTssFAT2jRzKwNH6+if1duhCxrrsxzo4rLpaLjWEKP7JVCycTBkaV3z65wqp2b3XUn
 04MA==
X-Gm-Message-State: AGi0PuajC7uLw4QexiHum8vJ1oKrYPG+A7eiBRj7CZa8DARU799JR8Gh
 Mzv6Zgh0j0Zjo/PMjr0dUPDCxzA2U8JuPY3EJbtZQOQzjSjTRnFPn3yBLJ7/2yeee6NkijBPJq5
 mFxxq04TPZ3WoaBA=
X-Received: by 2002:a7b:cf27:: with SMTP id m7mr27815685wmg.183.1587994878053; 
 Mon, 27 Apr 2020 06:41:18 -0700 (PDT)
X-Google-Smtp-Source: APiQypJgwlmdgikuipH4iv70Qpe7WsHuYkKniYlFD2lRPXqQ5pdfiweFWPPfRkU6QPxHwS5CfN3nCg==
X-Received: by 2002:a7b:cf27:: with SMTP id m7mr27815670wmg.183.1587994877871; 
 Mon, 27 Apr 2020 06:41:17 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
 by smtp.gmail.com with ESMTPSA id y18sm17561114wmc.45.2020.04.27.06.41.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2020 06:41:17 -0700 (PDT)
Subject: Re: [PATCH 5/8] run-coverity-scan: add --no-update-tools option
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200422172351.26583-1-pbonzini@redhat.com>
 <20200422172351.26583-6-pbonzini@redhat.com>
 <CAFEAcA_YZ+OoARe=-q6L1b_+wLcmPHG50Nz5Mzkrdo2PrpMC-g@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <dea1d9a7-c24a-8fe3-34a4-0664ef8b6ce2@redhat.com>
Date: Mon, 27 Apr 2020 15:41:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_YZ+OoARe=-q6L1b_+wLcmPHG50Nz5Mzkrdo2PrpMC-g@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 01:12:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 27/04/20 14:46, Peter Maydell wrote:
>> -if [ "$UPDATE_ONLY" = yes ] && [ "$DOCKER" = yes ]; then
>> +if [ "$UPDATE" = only ] && [ "$DOCKER" = yes ]; then
>>      echo "Combining --docker and --update-only is not supported"
> Pre-existing bug,but this error message should say
> "--update-tools-only".
> 

I noticed, however by the end of the series it was easier to add the
support...

Paolo


