Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E70C2D0C0
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 09:04:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B51EB20692
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 09:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ME5sQzXw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B51EB20692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieEyB-00078v-SI
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 04:04:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42726)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ieEwq-00063b-LJ
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 04:03:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ieEwp-0001Mf-Pi
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 04:03:20 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54870
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ieEwo-0001JG-Ia
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 04:03:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575882198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/asDSglAmIyfbN8hkTgv9Rh4mRXedj8OW4QolP+AcYk=;
 b=ME5sQzXwBuoQD2JgHmaecxZCM2DE/Na0IkirV8l3XpPeYqu/Rotbk9zTelo7t0RN13aNH9
 ZEiGR3OMr6A87LUR7aZ73KEynlPETPAtL68GWat6fLnLBVVwKP6pMyJK5wOJ589dF7O7vg
 xuwRn96nqX3PquFDcF+GcvIfTSNsfRA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-94-SoMYZ7NVNi-vdla1mSWXSQ-1; Mon, 09 Dec 2019 04:03:14 -0500
Received: by mail-wr1-f72.google.com with SMTP id r2so7212792wrp.7
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2019 01:03:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/asDSglAmIyfbN8hkTgv9Rh4mRXedj8OW4QolP+AcYk=;
 b=H5tTGxaTP0zQkEcpo0XZL0HZcw1QO1x72g3bM+4SDJ5ij/72bmAdRANqlq+dB5dKV+
 IN3nC+HWEG7S9ledEYugjMrYtz3+DYohviafFDA0YcdM4dkhFii5R4kWNNYpHlyiOY+0
 SitRdZJTHymY7VCADGNOgpO9eAQcH02sNrH7V3agfiUJG/GKw97xda2vxjaNWDaTwQQx
 6Q9yCrrPEuqgZ9lNoOR1MaKpcopm/2+KQA113WpytymIJDjd79agZa4t9JkPJbHDErfG
 XBRwImDZJrmqULNN+ZT7TYKgyO7Vhj5mTFoPzUP44rGsiQy+I5tJE2PEaxY6h5qcN/Fm
 gWbA==
X-Gm-Message-State: APjAAAV3HTftTLHD5rn/26BRD6Qn4l/a7zsbdUbqQku3vC8iH3qXHftO
 uWwIGsQFAi+je8HUGJAQZxnVyku64RfsqOwtbkpe1RE9dcQHd0AwtgU9d4ScvCvc9wd3wQf6SUJ
 ZgLe7uboU6dANveQ=
X-Received: by 2002:adf:dd51:: with SMTP id u17mr810307wrm.290.1575882192994; 
 Mon, 09 Dec 2019 01:03:12 -0800 (PST)
X-Google-Smtp-Source: APXvYqyHeFlhdXgPugxPKICS54R6c2jpDxCB8t7iFOKRWYE2PEJ9+3F/4jpTf2vj7vHbyui0Ln2Gug==
X-Received: by 2002:adf:dd51:: with SMTP id u17mr810286wrm.290.1575882192748; 
 Mon, 09 Dec 2019 01:03:12 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9?
 ([2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9])
 by smtp.gmail.com with ESMTPSA id x6sm1464669wmi.44.2019.12.09.01.03.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Dec 2019 01:03:12 -0800 (PST)
Subject: Re: [PATCH] Fix some comment spelling errors.
To: Stefan Weil <sw@weilnetz.de>, Cameron Esfahani <dirty@apple.com>,
 qemu-devel@nongnu.org
References: <086c197db928384b8697edfa64755e2cb46c8100.1575685843.git.dirty@apple.com>
 <543d4015-f043-96c5-39b8-2a37bd78d689@weilnetz.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a43d589d-5f44-1b21-b6e0-389449bf3739@redhat.com>
Date: Mon, 9 Dec 2019 10:03:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <543d4015-f043-96c5-39b8-2a37bd78d689@weilnetz.de>
Content-Language: en-US
X-MC-Unique: SoMYZ7NVNi-vdla1mSWXSQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: qemu-trivial@nongnu.org, liran.alon@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/12/19 08:44, Stefan Weil wrote:
> 
> s/compatabile/compatible/
> 
> can perhaps be fixed, too, when merging this commit.

Done, and queued.  Thanks!

Paolo


