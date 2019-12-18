Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9084EC2D0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 17:29:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 615652072B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 17:29:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a5/sAXtC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 615652072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihd8H-0000qE-HW
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 12:29:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39116)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ihd0V-0007x8-IX
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 12:21:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ihd0U-0000tr-7B
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 12:21:07 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35021
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ihd0U-0000q9-11
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 12:21:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576689665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QqA1fKS6f3wheolOQ+gNcZyltnnpR1cQYNAY8VU86qI=;
 b=a5/sAXtChLUb6jsxVk8SDHxcJjXHt9hohCnEMJbGzIz6vFAqUZtUjX9qleRryD5veEx8ag
 wqZZ5DWkg2az8Jpo8CSa/+21CZiGCzCbHhIOYk+BTj5InYdxrpZHZnaK82qw7N+eHxi7va
 JrYquPkEGtFa+DPKkqPAKvS5LBHl/5c=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-ocr8zc0AO-Sk98PGkg4XCw-1; Wed, 18 Dec 2019 12:21:03 -0500
Received: by mail-wm1-f71.google.com with SMTP id g26so720599wmk.6
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 09:21:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QqA1fKS6f3wheolOQ+gNcZyltnnpR1cQYNAY8VU86qI=;
 b=QZ+JRp9uUZHnRD+M9H53jzp+xr6jSnNUPc/0EuIcsm8HDnlw7W1qgTf7ER9Yqs0E6v
 /cga4eB6t44IoDFROT92da/Mh6gH/vflQc436fIacuGbgHt+OZb9gNxrgbhBhKzn7EZH
 D5xqb3zSBuBhWUoOB1LlT01WotCyd24PTrksbVWzfyA+/90zbfQ1r/hxlXuctYAp/mLF
 DyVIeG7fZPZ4EUybV9qNhTsS71/d4e+0UfTyGXkO9RNPQZaFFDQkXgNk9alkWIcuNmlo
 jrxLts4sMxyK2n9U9bj0QXS97+GQY9uBX0/cTerIv3DF8i7ETWfc72sAOaHJNJPBy5F1
 kNSA==
X-Gm-Message-State: APjAAAVeTBiL36nGcj5EFwQB43rJvSJlixU6NHfwHrpZYpDMuEwPgltm
 s2C6D0UUSTHu6EfuOWyJzSAn7LGJOoMZLuWqzfJDOqprL11mhmletDUQCGKZlav/1z693UrLcm7
 gAePcEunQz3nTJpg=
X-Received: by 2002:a5d:514a:: with SMTP id u10mr3955530wrt.169.1576689662703; 
 Wed, 18 Dec 2019 09:21:02 -0800 (PST)
X-Google-Smtp-Source: APXvYqz04nsdoNpKIwsGXaJRqZ5F2gK1hV0ARJeWmVBLpxCchjdeYpmgyn2z1RVdrAZVNHH+rF3lDQ==
X-Received: by 2002:a5d:514a:: with SMTP id u10mr3955513wrt.169.1576689662483; 
 Wed, 18 Dec 2019 09:21:02 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:ac09:bce1:1c26:264c?
 ([2001:b07:6468:f312:ac09:bce1:1c26:264c])
 by smtp.gmail.com with ESMTPSA id b68sm3239858wme.6.2019.12.18.09.21.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2019 09:21:01 -0800 (PST)
Subject: Re: [PATCH 3/3] block/io: take bs->reqs_lock in
 bdrv_mark_request_serialising
To: Kevin Wolf <kwolf@redhat.com>
References: <1576675026-25046-1-git-send-email-pbonzini@redhat.com>
 <1576675026-25046-4-git-send-email-pbonzini@redhat.com>
 <20191218165847.GF4632@linux.fritz.box>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f5f0b92a-2302-34e9-ab97-41f6bbbc691d@redhat.com>
Date: Wed, 18 Dec 2019 18:21:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191218165847.GF4632@linux.fritz.box>
Content-Language: en-US
X-MC-Unique: ocr8zc0AO-Sk98PGkg4XCw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18/12/19 17:59, Kevin Wolf wrote:
> Am 18.12.2019 um 14:17 hat Paolo Bonzini geschrieben:
>> bdrv_mark_request_serialising is writing the overlap_offset and
>> overlap_bytes fields of BdrvTrackedRequest.  Take bs->reqs_lock
>> for the whole direction of it, and not just when waiting for
> 
> Is "direction" really the word you meant?

No, "duration".  I'll send v2 with all the fixes then.

Paolo

> 
>> serialising requests, so that tracked_request_overlaps does not
>> look at a half-updated request.
>>
>> The new code does not unlock/relock around retries.  This is unnecessary
>> because a retry is always preceded by a CoQueue wait, which already
>> releases and reacquired bs->reqs_lock.
>>
>> Reported-by: Peter Lieven <pl@kamp.de>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> Reviewed-by: Kevin Wolf <kwolf@redhat.com>
> 


