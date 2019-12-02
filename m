Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91587C432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 18:15:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EC922071E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 18:15:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ashURbnw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EC922071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibqE6-00049z-GP
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 13:15:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59257)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ibqCu-0002Wi-VM
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 13:14:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ibqCt-0003b0-VB
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 13:14:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51312
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ibqCt-0003au-RE
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 13:13:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575310439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9JHJi+4M98ZT6uifCygU1v5X4s78jXMs2B936FHIjzo=;
 b=ashURbnwQI7kiZ8yuGXkcoXBpI6nzCLYrCMm0dgitRLXUEcbDayvfYUXdP7fqB5p3H2CDF
 Jlwjarx+/WKtUYrNTmF/1avZVRTbvwweu6F78tw6lSwIOlE2xGt1VeGTs1ZzTYxVxxdnlc
 h9Jd2u4oKmoa00OZTB6de4PQnx3MCSc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-PlwIPusUNfKtD_jLvtFWQw-1; Mon, 02 Dec 2019 13:13:55 -0500
Received: by mail-wm1-f72.google.com with SMTP id g78so62759wme.8
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 10:13:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9JHJi+4M98ZT6uifCygU1v5X4s78jXMs2B936FHIjzo=;
 b=etadZzndgVbh51yF/Hf6QW8gbfvo+L1XYQTdshhbyCE9y3VWy+iPX/3h9xvxdsIUBp
 r1LbEzLUJL6Ko+7IuB8EqSQkSXclK6VyFjeotNu2bMoTsEt+5NYgv2+O7p3RUaGFahMv
 lfFCFKQaDclWRDNDdFbfyL2qdH74hOKX1Bh2Cxk0YJGP+s0PTQbknwOGxEn+e074MeJh
 TUxs05traUrTCnfk1g3ieYgt8lVB6rFNrGXxr+sTmdn67eD86n+mkgw/C0EpG6qmsnPK
 /lTceOd0mfH0eCK1YN4R/LzxlDS078+p8YzS5W6LbryI4fbV1YzUxrJo5GN5JRhSxDSS
 oI7Q==
X-Gm-Message-State: APjAAAV1m3yS1110icRoA4g96qv2M0OEvJYrXUQVb+bHwOPMQYP7UKwy
 3a5A+4siXTjV0rO4z7bOTK9ZfcOvyalZ9rrQjqwstxrO71dtepylLrZk9hqHoKtFR3mRLzhogaN
 ixBZZd4nMzTl1yow=
X-Received: by 2002:adf:fd87:: with SMTP id d7mr263495wrr.226.1575310433896;
 Mon, 02 Dec 2019 10:13:53 -0800 (PST)
X-Google-Smtp-Source: APXvYqxV/CxkGjFPMHV9Yc4iDMehf5tAZZbh/zRic7iEbBe5n+UObCfFqIS5HmVzXIuL8sioKLaMpQ==
X-Received: by 2002:adf:fd87:: with SMTP id d7mr263466wrr.226.1575310433657;
 Mon, 02 Dec 2019 10:13:53 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:8dc6:5dd5:2c0a:6a9a?
 ([2001:b07:6468:f312:8dc6:5dd5:2c0a:6a9a])
 by smtp.gmail.com with ESMTPSA id c17sm177484wrr.87.2019.12.02.10.13.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2019 10:13:53 -0800 (PST)
Subject: Re: [PATCH for-5.0 0/8] docs: integrate doc comments with Sphinx build
To: Peter Maydell <peter.maydell@linaro.org>
References: <20191129140217.17797-1-pbonzini@redhat.com>
 <CAFEAcA9RsC-5Bxm33hQjNJ-wzEGCFDgUAUooZggRFmo2WdEsyQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a12c1e4f-63c4-4a36-f5a8-718de4498753@redhat.com>
Date: Mon, 2 Dec 2019 19:13:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9RsC-5Bxm33hQjNJ-wzEGCFDgUAUooZggRFmo2WdEsyQ@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: PlwIPusUNfKtD_jLvtFWQw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

On 02/12/19 19:06, Peter Maydell wrote:
> On Fri, 29 Nov 2019 at 14:02, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> This merges my series and Peter's into one.  Both the memory API and bitwise
>> operation APIs are covered.
>>
>> Paolo Bonzini (4):
>>   docs: import Linux kernel-doc script and extension
>>   docs: tweak kernel-doc for QEMU coding standards
>>   memory.h: Silence kernel-doc complaints
>>   docs: add memory API reference
>>
>> Peter Maydell (4):
>>   docs/conf.py: Enable use of kerneldoc sphinx extension
>>   Makefile: disable Sphinx nitpicking
>>   bitops.h: Silence kernel-doc complaints
>>   docs: Create bitops.rst as example of kernel-docs
> 
> Thanks for folding those two series together; I've left
> review comments on the parts I didn't write.
> 
> Do you have a URL of a rendered version of the docs
> somewhere handy to save me applying the series locally ?

No, I don't.

Paolo


