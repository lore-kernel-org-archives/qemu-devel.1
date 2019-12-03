Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D07DC432C3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 09:18:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 359C4205ED
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 09:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aIGet+X9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 359C4205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic4KT-0005X8-Lw
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 04:18:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52584)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ic4GB-0003gU-22
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 04:14:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ic4G1-00050T-Ec
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 04:14:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31371
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ic4G1-0004te-5t
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 04:14:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575364447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cCH5YN4kqQKjD8UQMiha3WenekJmO0/BzEyK0ScIhO8=;
 b=aIGet+X9YGyhdS6GUDHy4tfnhL8G9wYU07y3P+XocNkFm2Ak7GLoK9PENBm9A66xypmPDW
 30WH+HXWbIRVZ1TfLk9avZZi5/6rMZ51keP+VuvVuP7jS9uJRNKbIjWUri3v3FGfbpYp/h
 lRzX65TOYbPDAodvcxAgrBGQSfCD3OM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-bUki05MEP2mN73wDIr-Qbw-1; Tue, 03 Dec 2019 04:14:05 -0500
Received: by mail-wm1-f71.google.com with SMTP id y125so1136616wmg.1
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2019 01:14:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cCH5YN4kqQKjD8UQMiha3WenekJmO0/BzEyK0ScIhO8=;
 b=o2fvDTqSwg2Ki1YKGmEvDOHzTjwUPFlNIobr2in1420HX3HYQOicwrGMf+kDkL4Nx/
 T9B1rx1LU+AmZ6CKbS84q/jVJIBxQa9hTumMmZ6ZLZyKOUisAU3c4EMiToULmKnNcHe4
 5LypuVbTn8gwRYfVSPzV70jKkUKqXxOIyU07QG9aamA2wa3KqXMA85jXXptOa+8ZSt0O
 Mlb3qV7XYkh4UoRMCdWIm+gohnaozcyvDKXFcy+jQZxzjmsdzwmGhaDzA8gVMxMz5hZU
 wNIH6DTvnWEE37y3mfEeYkT7HizR5PpKCLqjyHUhCfEbBnWc+OoY1yXHqA73a7fA48/J
 xAxQ==
X-Gm-Message-State: APjAAAXY+Ua/3nxhGdovRB7D4L2Pee2KoBMqKWQxYgAvaCrO1e5fnF69
 9Ctqf0B+0uQpCysvi8Hq8ihzcWNBtZk4PW+sBBcX9nQXCb3eNlE1AQKfSZCz232H1xkigxO+C8N
 pWZJhmzrL7vtM1wg=
X-Received: by 2002:a05:600c:224d:: with SMTP id
 a13mr1096063wmm.57.1575364444572; 
 Tue, 03 Dec 2019 01:14:04 -0800 (PST)
X-Google-Smtp-Source: APXvYqwMq0y4lj80Oq2fXLjCGxKSBG08dJN+I13LMlX5mLc+bQuf/lNMMdlHMZE4fQ56ykxo8b5fjw==
X-Received: by 2002:a05:600c:224d:: with SMTP id
 a13mr1096040wmm.57.1575364444232; 
 Tue, 03 Dec 2019 01:14:04 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:8dc6:5dd5:2c0a:6a9a?
 ([2001:b07:6468:f312:8dc6:5dd5:2c0a:6a9a])
 by smtp.gmail.com with ESMTPSA id c1sm2726382wrs.24.2019.12.03.01.14.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Dec 2019 01:14:03 -0800 (PST)
Subject: Re: [PATCH v3 0/5] hvf: stability fixes for HVF
To: Cameron Esfahani <dirty@apple.com>, qemu-devel@nongnu.org
References: <cover.1575330463.git.dirty@apple.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <11c1ae6a-b8bd-bee0-621c-7b487bf48aa6@redhat.com>
Date: Tue, 3 Dec 2019 10:14:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <cover.1575330463.git.dirty@apple.com>
Content-Language: en-US
X-MC-Unique: bUki05MEP2mN73wDIr-Qbw-1
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/12/19 00:55, Cameron Esfahani wrote:
> Changes in v3:
> - Change previous code which saved interrupt/exception type in
>   hvf_store_events() to inject later in hvf_inject_interrupts().
>   Now, hvf_inject_interrupts() will correctly determine when it's appropriate
>   to inject VMCS_INTR_T_HWINTR versus VMCS_INTR_T_SWINTR.  From feedback by
>   Paolo Bonzini to make code more similar to KVM model.

Queued, thanks.

Paolo


