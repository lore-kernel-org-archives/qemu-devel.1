Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C39C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 16:32:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42DBB21D56
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 16:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fj0XHHKC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42DBB21D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBLKD-0003MA-A9
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 12:32:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50037)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jBLJB-0002aW-Dj
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 12:31:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jBLJ9-0005ep-J9
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 12:31:12 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53397
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jBLJ9-0005dm-Ct
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 12:31:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583771470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=23w+mVzoSvMwUoe3UZNGBxBVhIGiteJSVAn3xu6wbws=;
 b=Fj0XHHKC4rsyzmBDjdH2qnlj4xSnbPFWTpaZ1UCxs0SZgfGJrYgZ5LaEYrW0J3dg70RWo0
 qoxVgnUH6Z9WsgAvi0D61/pTHLUoBo8qfgFDVYIdWpsc5HC0TkYZWDKKR2UAm7uCkFCtO2
 P1O3b6KaE3LfGlQbsEVa38yfSh8Y+nI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-116-NW6Pzk9wMpykwRBL4mTHvw-1; Mon, 09 Mar 2020 12:31:08 -0400
X-MC-Unique: NW6Pzk9wMpykwRBL4mTHvw-1
Received: by mail-wr1-f69.google.com with SMTP id y5so4785253wrq.8
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 09:31:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=23w+mVzoSvMwUoe3UZNGBxBVhIGiteJSVAn3xu6wbws=;
 b=gKrQ8i8F/ECGQoXkaBHewN0mgsQjfYS/76gVaW2NSyvB0jsHKQOogQRcuUbwo7FMlb
 ynTcuvaaONMpkleKzpwUU2rGpuxzoFP+JT6HO/USuHgnlOmOetJbmHlEfEz1quy/IJrn
 JiREFVcX0MazQDzURWqfv8RX/i2VqjbvtAIIcvt1MHGVAkEtQZEbWaAqzUKnt7JIK4Lq
 ekzZ5k4N4QruByCSEssjwsgIGLjU6Vt6vPmSeU/957reXbYk9qczC8ln91t1TXGEasyH
 2oowQ+TYd4CprtU1QjlbccBoMRxHCgRwlXDPFKl8G8AjcdQdixLIvYoudtdVEA2LvkSp
 PEzg==
X-Gm-Message-State: ANhLgQ1wBbIVuS7Tiui4CtnS6jyuuNRqZBwIIZRlyR3qP/Jx5KNK4bA1
 jjR176nm+uFErKLeqPJLvpm0zkL4fkkUZDtnhfImdj9rb3rOPnckKg5Uufkmi5RCz7u22QtENMe
 bmupgcUcICd+s/iE=
X-Received: by 2002:a1c:e918:: with SMTP id q24mr109798wmc.25.1583771467489;
 Mon, 09 Mar 2020 09:31:07 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuuup2Z4KIAizt8UefYpT6AeO1h+NYa0Y57Zb4onaVDB3TH1dXA4HCEmnBA1xu68XBD5Zlbdg==
X-Received: by 2002:a1c:e918:: with SMTP id q24mr109778wmc.25.1583771467249;
 Mon, 09 Mar 2020 09:31:07 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:f1b5:9f9:3125:2a5a?
 ([2001:b07:6468:f312:f1b5:9f9:3125:2a5a])
 by smtp.gmail.com with ESMTPSA id y3sm24525657wrm.46.2020.03.09.09.31.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2020 09:31:06 -0700 (PDT)
Subject: Re: vmx=on with -accel hax
To: Markus Armbruster <armbru@redhat.com>, Rui Prior <rprior@dcc.fc.up.pt>
References: <19980599-1cbf-9179-070d-59aa68847968@dcc.fc.up.pt>
 <87tv331i5k.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <af2f04c9-f4eb-19d0-ef8b-788516297fce@redhat.com>
Date: Mon, 9 Mar 2020 17:31:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87tv331i5k.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/03/20 06:32, Markus Armbruster wrote:
> Cc'ing people listed by "scripts/get_maintainer.pl -f target/i386/hax*".
> 
> Rui Prior <rprior@dcc.fc.up.pt> writes:
> 
>> Dear qemu developers,
>>
>> I found a bug/limitation of qemu on windows (qemu-w64-setup-20200201.exe
>> from https://qemu.weilnetz.de/w64/ ) that makes qemu terminate
>> immediately with "VCPU shutdown request" (twice) if I try to use the
>> "vmx=on" CPU option while simultaneously using "-accel hax".  Without
>> "vmx=on", it works fine (but it prevents me from using nested
>> virtualization).
>>
>> I am using HAXM v7.5.6.

Hello, as far as I know HAXM does not support nested virtualization.

Paolo


