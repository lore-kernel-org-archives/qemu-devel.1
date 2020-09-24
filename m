Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 118C2C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 14:32:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90CB92220D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 14:32:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HTqV3D8u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90CB92220D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLSIX-0000zi-DW
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 10:32:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59314)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLSEj-00065p-CF
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 10:28:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47599)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLSE4-00043L-PE
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 10:28:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600957679;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Oe/JEIM7SIMmhWgNlDKc/6iMQpM5T15YfblCMayVbBA=;
 b=HTqV3D8uG3AaYTly/ZVeSzC5wyXfWCZQgNoBj08yU1Ga9zwp+BQfXGfLQsOguuupwmqSys
 9WB5g/1d0HtIYMfVkMHe6J+H7k6powDvWqlnuzgilHo+kGAUvzFuT4GpIU9mXtGi6PlAbi
 NevY/ESXox3KLXzra5mJ54HOFotiC+E=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-iF_gHDd7PgCTvQJZsEvYQQ-1; Thu, 24 Sep 2020 10:27:56 -0400
X-MC-Unique: iF_gHDd7PgCTvQJZsEvYQQ-1
Received: by mail-wm1-f71.google.com with SMTP id r10so3625975wmh.0
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2020 07:27:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Oe/JEIM7SIMmhWgNlDKc/6iMQpM5T15YfblCMayVbBA=;
 b=ALPwD+G/fT4l7lrCoOr+qfxa7eO5dIsyBQelFfNsELAV5Q9GMaKcA6PejZ7cYAZ6Et
 qvtM8ATaRFhdgHBCTm1YC5Z3XprjqZJTbM5ba1+fIJXUlmpGxR1Gi/6OWicUMP+Y4eIz
 5MdQ/hAWFZiTC00RMVd1pYuY/RMY3vBp6sxQU9rAe7HzK1Hk9ICPUiddwpJA8Eb+XJAb
 F8ncRSuans+c7WKaJubXYCGZKOxY1ZEeDZb0vPtvrZu5tCQVVJB5dsf15BOYpm91zENc
 dDEztrb4z05t+Kz5B4KYeW/aPIutZF2lj+CkLzl/pNuLa3UhZ8z8mgNKq/bFCatAEWaV
 exHg==
X-Gm-Message-State: AOAM532bwQuXgaKX3QJJkalldYqnDbj1y8H0fPnnk2R85mczR9HUtZha
 bBh+VrKm7vHoFzwWBHTD7sx9/Idv72AP/hTTfSXVh1ySZ4FqHVzOqCLN2ckiMyOfH5MYezIIhNp
 OnCuA5udWuy/Vwrw=
X-Received: by 2002:a1c:bcd6:: with SMTP id m205mr5246391wmf.68.1600957674749; 
 Thu, 24 Sep 2020 07:27:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzrLfbUDfQAbOmix8KW57DwqHYzgOrqMLanbXIFgDJJfbTscX8n84Tch8s3+k4/g3JsVBf/PQ==
X-Received: by 2002:a1c:bcd6:: with SMTP id m205mr5246372wmf.68.1600957674529; 
 Thu, 24 Sep 2020 07:27:54 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d80e:a78:c27b:93ed?
 ([2001:b07:6468:f312:d80e:a78:c27b:93ed])
 by smtp.gmail.com with ESMTPSA id y6sm3961186wrn.41.2020.09.24.07.27.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Sep 2020 07:27:53 -0700 (PDT)
Subject: Re: qtest with multiple driver instances
To: Thomas Huth <thuth@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org
References: <4696583.mNQJtTt8NE@silver>
 <7ae8f0cc-021e-d982-4d1d-a46afc37bf28@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b6dcb4c7-65d7-f97a-09c1-b6526380331d@redhat.com>
Date: Thu, 24 Sep 2020 16:27:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <7ae8f0cc-021e-d982-4d1d-a46afc37bf28@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 01:10:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.214, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
 Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/09/20 15:50, Thomas Huth wrote:
>> Is there any workaround or something that I didn't see? Like letting qtests 
>> reference a driver instance by PCI address or something?

The simplest way around this limitation is to move the -fsdev option
from the .before_cmd_line of the virtio-9p-*'s nodes to the .before
function of the test.  You can see an example in qtest/virtio-net-test.c.

It was done like this in virtio-9p simply because we only needed synth
fsdevs.

Paolo


