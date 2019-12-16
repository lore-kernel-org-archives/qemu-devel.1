Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 142A7C2D0BF
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 13:32:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3693206CB
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 13:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c8/lGY5P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3693206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igqUC-0004oL-UJ
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 08:32:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48225)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1igqTB-0004E6-6J
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 08:31:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1igqT9-0006u5-7P
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 08:31:29 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50830
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1igqT8-0006rj-Ph
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 08:31:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576503086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gFDiBn0XOt5fI7aCLzqPr2AqjG1K9apTY65Tkodt2X4=;
 b=c8/lGY5Pnl6jfYg0OYQ3RbOw+u5kY06vj6Wo7Fb3SJaE2qgzYyMOtxDAQfvKyCSTAV5uUT
 VapVbPAX2FLfBxZiGp7TUkNuU610UK5B0Gs8Fn+2NPI0ym72lYo/GT5trf0edfVNBCAnqu
 8hY1nR0C7Dq8RIu9wDgyYyBOp030TpI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-xmM-vVR2O66hJ66Y30eOeg-1; Mon, 16 Dec 2019 08:31:03 -0500
Received: by mail-wr1-f70.google.com with SMTP id z10so623573wrt.21
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 05:31:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gFDiBn0XOt5fI7aCLzqPr2AqjG1K9apTY65Tkodt2X4=;
 b=NKCaExXJuzQ2FMYrnazfEddOQQ7PJqC+laQB5GUTZpBU3WdJyqFerP1JBrURFGOZ44
 hXWePvTdNB1/mcS0f6b5PCIRSLGb3EaL+eMNw+qsTYRO6oGjyJhxXbIoppovzqzx+7ea
 xBa/cJ91fUt6g4y1X+NTp7QWV8Zo9hgyQMhwpd7gKrbUHHnhMnvSx1gJSWUf+7kmBg/F
 94Ps3nxYLjvjd953Y+yTtWHzjhE0AdXPwzHYyYqQh81CO7ar5WY4j31gztq/2tEA+CPI
 HNxQjf4lX1gMifr2EJel1QYcUckC/LPLKHu2/i23LbgtjNq9ydoBx51COOig3uBNReGP
 8ZMg==
X-Gm-Message-State: APjAAAUeVprU+KWLbzyTAlTRizJdlbbKMU/OPhUIBZRG/GNUEyrZithr
 CudmTpGIubQ64mzsNOrty/8okTR9b0erD0cyTZSRhWGev5pIqbsxln3uYJ2w9jJhxPo4gm2o4UC
 KxtMVF7J2PB9bSys=
X-Received: by 2002:adf:ff84:: with SMTP id j4mr32608419wrr.27.1576503062348; 
 Mon, 16 Dec 2019 05:31:02 -0800 (PST)
X-Google-Smtp-Source: APXvYqwdfOeyBNOCTwTCV1Dt8Po7kHDfCsloy2xZ+VDfxatTTxZQK+7TTWZ2uEe6qmovGqyouL28VA==
X-Received: by 2002:adf:ff84:: with SMTP id j4mr32608407wrr.27.1576503062194; 
 Mon, 16 Dec 2019 05:31:02 -0800 (PST)
Received: from [192.168.10.150] ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id f16sm21956043wrm.65.2019.12.16.05.31.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Dec 2019 05:31:01 -0800 (PST)
Subject: Re: [PATCH 01/10] migration-test: Create cmd_soure and cmd_target
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
References: <20191212222033.1026-1-quintela@redhat.com>
 <20191212222033.1026-2-quintela@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f9961f1e-6898-f49d-203d-558872ee6f8d@redhat.com>
Date: Mon, 16 Dec 2019 14:31:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191212222033.1026-2-quintela@redhat.com>
Content-Language: en-US
X-MC-Unique: xmM-vVR2O66hJ66Y30eOeg-1
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/12/19 23:20, Juan Quintela wrote:
> @@ -584,16 +585,16 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>          cmd_src = g_strdup_printf("-machine accel=%s -m 150M"

There will be conflicts here as this "-machine accel=%s" will change to
"-accel", but nothing major.

Paolo


