Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45BBBC3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 12:03:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FF7F20848
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 12:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E6xzW+x8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FF7F20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9pE0-0007GA-2x
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 07:03:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33555)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j9pCC-0005eu-Ia
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 07:01:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j9pCB-0004JW-Ge
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 07:01:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32047
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j9pCB-0004IE-A6
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 07:01:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583409703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ar8CYivpVy6FUoJvhUtX6ynC1Z30c2C8GMW/wP3ZGlw=;
 b=E6xzW+x8N7xXAcJh/rQoCJ4vyPy18/LhL9CiYDnXxuCPQNxv8m1mRYxZUwb8gPWQzGX+G/
 h1N3vsvdGYiUVT6PVHC4gG+MpMDWCshMabad5pF6jQTL+ON/1sf8/AdPQ3RCgQ7qDw/13h
 ULHkV/TU/huSW1FiTNHYjmvYt1j3b/8=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-L_BOyUp2Nj6ib4VydS_nrg-1; Thu, 05 Mar 2020 07:01:41 -0500
X-MC-Unique: L_BOyUp2Nj6ib4VydS_nrg-1
Received: by mail-ed1-f69.google.com with SMTP id l5so4157624eds.23
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 04:01:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ar8CYivpVy6FUoJvhUtX6ynC1Z30c2C8GMW/wP3ZGlw=;
 b=h4z+3eW8tK6QO89k2w7Z70V1EBCsLLQNrfttUPwOhpMQcbwOAjpaYwHkGVMU+rZ993
 7ERMJau9XD4+eHcRCTSsTXzGPg8+tpkf++Ji36bXwRBouVcUkScUbFmM2XrCXggSqdCW
 iqP1/M/sfSBpuotcSdWmzCIpgSRWpkNSOs/cTMe/7H8rLmD2i8S9GVIyiifpp0aUy2OK
 LqN50Zbx43LqFdzMVL+g0YdPpGPI7iBNzIG7E0qkUMWOzpKY+dKawQS7MxazexKXWTpe
 xhbAek7mco0aoWjVkWHLA7NPZsy67xnAOGkbN5/fi2fGg4uVQa8xRFFls08APQaRjqjp
 wLbA==
X-Gm-Message-State: ANhLgQ0M0TttP4Cbah3ZbjUzmqDZJJpogv6rbtcsTdaH0O2XyNK30A33
 9CO7qWtms8D0TdP0+TVNlMf51OTSFJr7SVyGiMfRdD1pfbszHV92a8VFlmzMX1X27KtbvH/hI7b
 wh1K6beQmGK0rtWg=
X-Received: by 2002:a17:906:f44:: with SMTP id h4mr7329108ejj.44.1583409699498; 
 Thu, 05 Mar 2020 04:01:39 -0800 (PST)
X-Google-Smtp-Source: ADFU+vs1BTaMHRvNgQVM2YmYdD9IWJ3dgCsKgcJGQNwkPzMjWYO8LSagSRFcOcUuIaP8ONNd2V9FXw==
X-Received: by 2002:a17:906:f44:: with SMTP id h4mr7329071ejj.44.1583409699188; 
 Thu, 05 Mar 2020 04:01:39 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id gf7sm1028813ejb.57.2020.03.05.04.01.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Mar 2020 04:01:38 -0800 (PST)
Subject: Re: [PATCH 3/6] hw/usb/quirks: Use smaller types to reduce .rodata by
 10KiB
To: Gerd Hoffmann <kraxel@redhat.com>
References: <20200304221807.25212-1-philmd@redhat.com>
 <20200304221807.25212-4-philmd@redhat.com>
 <20200305080237.j2a7waokxominirn@sirius.home.kraxel.org>
 <a5b6cddf-5887-be27-db76-2e515daa2c11@redhat.com>
 <CAP+75-XBbTPHbQJWxn5nEYsz4hdGXSTLTqKRRR-sx-APbPN2Sg@mail.gmail.com>
 <20200305115910.zhmaw3xqgoz4fan2@sirius.home.kraxel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8ce21679-20c1-19db-c0df-9c7cb1bff629@redhat.com>
Date: Thu, 5 Mar 2020 13:01:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200305115910.zhmaw3xqgoz4fan2@sirius.home.kraxel.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/5/20 12:59 PM, Gerd Hoffmann wrote:
>>> And went this less intrusive way.
>>>
>>> I'll respin with s/-1/UINT8_MAX/.
>>
>> Problem, now this entry is ignored (interface_class==-1):
> 
> Yep, "-1" is used as "not used" or "end-of-list" indicator, and it is
> outside the valid range to avoid that kind of clashes.  You need some
> other way to express that if you want go with smaller types which don't
> allow values outside the valid range any more.  Add a "flags" field for
> that maybe?

Oh I wasn't expecting 0xffff valid for idVendor /
idProduct, neither 0xff for bInterfaceClass / bInterfaceSubClass /
bInterfaceProtocol. Well maybe it doesn't worth the churn for 10KB of 
.rodata.


