Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1276C7618F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 21:15:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9F872173E
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 21:15:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9F872173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnUnV-0007eF-P1
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 17:15:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52923)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hnUnK-0007Fd-Ek
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 17:15:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hnUnJ-0002sZ-Ip
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 17:15:30 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42519)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hnUnJ-0002s3-C1
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 17:15:29 -0400
Received: by mail-wr1-f67.google.com with SMTP id x1so7449631wrr.9
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 14:15:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rSc1kKHxIyyw1Y1fyS3ap04fYc8idKNJwTBNE9B+FlY=;
 b=PktPK7HvdJO+N2KMVC+Nc1io35+sP/viJ6X/A2IeUIoaaAuow+7RBOH1IOo1FbBsLQ
 254btn7OfwguQbK+HzemEWS4c9YD4YVuFE47Tfa6yzOHteKfZ1+u/X2rBTEZ9C13Ny9/
 eMJD82fWNYYIYcLVB4GzzVmvkdmiAGCPodyynjJBsvSmjlrH8dJ1mJO3bG+akfLi8Dfe
 gDLiSzyJKlRVF24WKxMNuSav30u8GnzbSFtYc/1Q02npJGFdcOSAykAhgfDYdvExM57+
 LPkQBvEn8N/y3PYxKlbfTqoCVBR0m/U5OT5v+Vh7oa2tESY5weXC5UKg6DA1Xo9IkT7n
 WRoQ==
X-Gm-Message-State: APjAAAVl9ZjDYofeQbuhjll/JuZGbw+XQp9CM/8i8m9jGJiaqam2GqU8
 sMwlxtXSjgQe4LJMqLTvTkiLAA==
X-Google-Smtp-Source: APXvYqwqG3BlbHDEL6O6w5WIyLaoZYSCCQZs2Pf2WjPCkvjyGHMQ4mhkOnOMsMBrZMElSgt4gj9rEg==
X-Received: by 2002:adf:e708:: with SMTP id c8mr27001224wrm.25.1563311728273; 
 Tue, 16 Jul 2019 14:15:28 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:b159:8d52:3041:ae0d?
 ([2001:b07:6468:f312:b159:8d52:3041:ae0d])
 by smtp.gmail.com with ESMTPSA id g19sm38361063wrb.52.2019.07.16.14.15.27
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 16 Jul 2019 14:15:27 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Mark Kanda <mark.kanda@oracle.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, kvm-devel <kvm@vger.kernel.org>,
 qemu-devel <qemu-devel@nongnu.org>
References: <20190603230408.GA7938@amt.cnet>
 <1afdac17-3f86-5e5b-aebc-5311576ddefb@redhat.com>
 <0c40f676-a2f4-bb45-658e-9758fd02ce36@oracle.com>
 <86e64a5c-bb2b-00c8-56c3-722c9b8f9db6@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <48263030-768a-e8ee-302d-6d69c40b219c@redhat.com>
Date: Tue, 16 Jul 2019 23:15:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <86e64a5c-bb2b-00c8-56c3-722c9b8f9db6@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [patch QEMU] kvm: i386: halt poll control MSR
 support
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
Cc: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 16/07/19 23:09, Paolo Bonzini wrote:
>> As such, I think we should only enable halt polling if it is supported
>> on the host - see the attached patch.
>>
>> ...thoughts?
> No, it should not be enabled by default at all, at least not until we
> can require kernel 5.2.  My mistake, sorry.  Can you post a patch?

Doh, nevermind.  This is not included in 4.1 so there's time to fix it.
 Pfew. :)

Paolo

