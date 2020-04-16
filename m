Return-Path: <SRS0=3HrQ=6A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3093C2BB85
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 11:10:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91077206E9
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 11:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OZ0qHXZ4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91077206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jP2Pq-0003Si-N0
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 07:10:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42647)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jP2PG-0002rp-8k
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 07:10:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jP2PE-0006D6-UK
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 07:10:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43175
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jP2PE-0006CR-QR
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 07:10:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587035403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wIPDI7c8wyLmq4vVtx2jYxwBWb4ssXaSn4gTWG+NqQQ=;
 b=OZ0qHXZ4taR3nM+SI3YabdnoAc93fJwZrknQpNTD5hGjRBOxIf6vHaTGWT/+T84tfFLKJO
 FrOh2Uhg02s2XFQD5FNreDNC2Tmz9dSGcyA1+o3CklA8KSLYx7DF+D4dwXtpc7c+JWeMzn
 pWM7X1OzsgXZq9VeClmTz+c59uUYRkg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-pxvLLwAmPOWkKTwmQxwVhQ-1; Thu, 16 Apr 2020 07:09:58 -0400
X-MC-Unique: pxvLLwAmPOWkKTwmQxwVhQ-1
Received: by mail-wr1-f70.google.com with SMTP id j12so1508988wrr.18
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2020 04:09:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wIPDI7c8wyLmq4vVtx2jYxwBWb4ssXaSn4gTWG+NqQQ=;
 b=P0rzTVxk4NQV9Ixt/KAqT4UtoPSh+0ea8TNjoIKCAzzpvKy+2QBuaRfsXbKcuPSyD8
 FkxnGRMaG26DbTSuPslnUL24oAHOSpdeb8I6LH646WKelbl/sFGsTCDeS7egtfzI767X
 QlnfiUsT+G21w0J6FjC2NfajkPM152GcrCCWOt/X8XwPFZMhpo+LyTsToIjt6kOiipNK
 bPWYLTawqd6mZHtTFNwCYfWVY78q4xTpTQqvQ2E7JlW4WCWzzpuYL40RJPGjYnc2IdyH
 zy8W+Y3k354v3V501xE6kvbSa6CPCNePaHZfmrtPf9dUQ+BoJjhLer14HgGAXDpEAIa7
 RULA==
X-Gm-Message-State: AGi0PuYfHlw48H2e2SVXsNYW2hnemqZjVCBCDi2RdFMCjbG7ZjePTD7N
 wyi4ML++DmcjCYVyx8i0ySkw8mHIxPaKRsPP2/lzDnAf26zhhO/BqBDJ4aPoAMC+OGh59B6Rhb8
 Y7HZrvUSqpRCOhFU=
X-Received: by 2002:a05:600c:2c47:: with SMTP id
 r7mr4289261wmg.50.1587035397232; 
 Thu, 16 Apr 2020 04:09:57 -0700 (PDT)
X-Google-Smtp-Source: APiQypJw27MLRabik1y+BUupZskvZEkYXwa3MT4/1RXztSHCRPn2re2fP69WKHhUMihdSIyGH7SiXw==
X-Received: by 2002:a05:600c:2c47:: with SMTP id
 r7mr4289234wmg.50.1587035397039; 
 Thu, 16 Apr 2020 04:09:57 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id p3sm9144941wrx.82.2020.04.16.04.09.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Apr 2020 04:09:56 -0700 (PDT)
Subject: Re: [PATCH] Cadence: gem: fix wraparound in 64bit descriptors
To: qemu-devel@nongnu.org, rfried.dev@gmail.com
References: <158702996540.15335.16514068999380777664@39012742ff91>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <71dd512d-485c-d395-df90-f6208f91c655@redhat.com>
Date: Thu, 16 Apr 2020 13:09:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <158702996540.15335.16514068999380777664@39012742ff91>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: peter.maydell@linaro.org, Juan Quintela <quintela@redhat.com>,
 jasowang@redhat.com, alistair@alistair23.me,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/16/20 11:39 AM, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20200416090247.353414-1-rfried.dev@gmail.com/
> 
[...]
> ERROR:/tmp/qemu-test/src/tests/qtest/migration-test.c:1229:test_migrate_auto_converge: 'got_stop' should be FALSE
> ERROR - Bail out! ERROR:/tmp/qemu-test/src/tests/qtest/migration-test.c:1229:test_migrate_auto_converge: 'got_stop' should be FALSE
> make: *** [/tmp/qemu-test/src/tests/Makefile.include:636: check-qtest-x86_64] Error 1

Doesn't seem related to the patch content...


