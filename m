Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0871C4741F
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 13:48:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AE2B206B2
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 13:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VaVhpq08"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AE2B206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc7XV-0006Iy-V1
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 08:48:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59408)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kc7Pt-0006mj-G2
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 08:41:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34001)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kc7Pm-0001Jw-AA
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 08:41:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604929257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G5izyeu101xIk+XNFEq/eyGOincwbXQ08PY2kGGcq80=;
 b=VaVhpq08YyPxGLxgIJBCbWcuR7tCS5rhUBh8PCpUjRH7VKXkgfbR5YXsS3jxQPDZ5RfRo8
 eTj7b8z3aZEndSoAPxRjnoIM58o6Wga1gG8SW6v56+JQGxnNE33m8laEk00tD1O7JP22QN
 jvJjXNj/PfS9E0LcvOg1O1wSyz4DPtw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-oT1ujnYLOtu2xWXrbaJMoA-1; Mon, 09 Nov 2020 08:40:56 -0500
X-MC-Unique: oT1ujnYLOtu2xWXrbaJMoA-1
Received: by mail-wm1-f71.google.com with SMTP id o81so2045649wma.0
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2020 05:40:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=G5izyeu101xIk+XNFEq/eyGOincwbXQ08PY2kGGcq80=;
 b=l7fq3xpFnFBYK5UUw0wohxbq4Pp0GVICeyGvylVa2QiFVx6kTTS6vo+v9OfGqk2ThT
 qf2q9Le4L7oJAT8UK59W3dvWRqFwjVlAxNS668dPMVm5jfPv5hodxXxUxEDiPhluSxl3
 ltH1sMJoODIBRJz34ekWpS6nJlrr7JyuoqzWvZOrFackGrLJQrqRJVeFvwSZt8miieLy
 DD1h6/5Vn8T/crU6ZHui5Bk1jNsOwCf+RJz/AnsIF6UXP+C8Q2ilyzAEFNBh/8s++uCz
 8/u1Odqv6Dq38dD6JTWJvhjK4mv1pI2Yu+3r0Y25iUG9uzAKzge41T4L3m7H6zHSnpBq
 3YQQ==
X-Gm-Message-State: AOAM532x/3FSg2YQtR9vBa08KkGhn5m2WxLriN/XLg5YMlLVjic0rsis
 nVcwXzSsxWYXon4VOyUv2onC/1ghJqeHIi7+O1YqPyCxkj/JJAKMAl/LzLQDocO9h0fPaS924Yj
 hxLpIks0DCJLPggI=
X-Received: by 2002:adf:f546:: with SMTP id j6mr4644702wrp.219.1604929254956; 
 Mon, 09 Nov 2020 05:40:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwoWFQn/IuEoM+PfyANFXICpObbunyIvbgUK+BEcDq/pcD2yNYysFg7e7OgDmlYUemgVkgwqQ==
X-Received: by 2002:adf:f546:: with SMTP id j6mr4644682wrp.219.1604929254804; 
 Mon, 09 Nov 2020 05:40:54 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id y187sm12946051wmg.33.2020.11.09.05.40.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2020 05:40:54 -0800 (PST)
Subject: Re: [PATCH-for-5.2 1/5] hw/usb/hcd-xhci: Make xhci base model abstract
To: Gerd Hoffmann <kraxel@redhat.com>
References: <20201107111307.262263-1-philmd@redhat.com>
 <20201107111307.262263-2-philmd@redhat.com>
 <20201109095127.dt7rzwqcrtx6k7n5@sirius.home.kraxel.org>
 <a241f626-9798-933e-d5b4-1190b3da6746@redhat.com>
 <20201109113046.fnv52ad22btvu4jr@sirius.home.kraxel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3b24fd8a-c036-55b4-c741-28f31d1f82fa@redhat.com>
Date: Mon, 9 Nov 2020 14:40:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201109113046.fnv52ad22btvu4jr@sirius.home.kraxel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 00:04:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 Thomas Huth <thuth@redhat.com>, Miroslav Rezanina <mrezanin@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/9/20 12:30 PM, Gerd Hoffmann wrote:
>>  static void test_xhci_hotplug(void)
>>  {
>> -    usb_test_hotplug(global_qtest, "xhci", "1", NULL);
>> +    usb_test_hotplug(global_qtest, "nec-usb-xhci", "1", NULL);
>>  }
> 
> Better use qemu-xhci.
> I'm wondering how that worked before ...

Per commit b3937683147 ("tests: usb: Generic usb device hotplug")
this is the name of the bus, so "xhci" is correct, my patch isn't.

> 
> take care,
>   Gerd
> 


