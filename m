Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93956C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 07:14:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8413522B45
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 07:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ibE3PZKg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8413522B45
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2r9p-0006eY-Kc
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 03:14:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37690)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k2r8X-0005l9-DG
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 03:13:25 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55001
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k2r8V-0007tm-W7
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 03:13:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596525202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=APkxwVOkZJ6ql1cPMEtiAldz3bb/jwUiFORRHQ4YImI=;
 b=ibE3PZKgvWA6KO3q1y5Gb73CsSHWY6Pwhf0CNILK3UTZm4Tznyp8NsdZl05KrFLNhbxru4
 g1Cl1/UcVvGX0TrcqK7kLQx152D4c6d9a3fVB8KptNZt5H+GN/2mu2YVPE1hkoe3JdHSjY
 JdOcef/KVpPQ+tOWBFFJGimpKIEauJ8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-484-8WfmMOOgNq2eDwxzjbzX8Q-1; Tue, 04 Aug 2020 03:13:20 -0400
X-MC-Unique: 8WfmMOOgNq2eDwxzjbzX8Q-1
Received: by mail-wm1-f69.google.com with SMTP id h6so726231wml.8
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2020 00:13:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=APkxwVOkZJ6ql1cPMEtiAldz3bb/jwUiFORRHQ4YImI=;
 b=NJTlGaqS77PiJ9GcQOe9fcaXE3y3zMw8kLRAUPKL3S58fbKpuOI5VMZUYG88VU1Hzz
 7Q9zO6nq+K70WYd4mQM4MzCly4ZqRUq9ldMZ10ZhjE71Bv4nK9IgsHHfBVB5KRU7XwgN
 mqH9R1ibqgdrBKCSut6GFkTyvCNC1Tfy7i6rLHUSovJDTnoaJJ6oe446I3AAjKM60L8l
 iSqKRXHuDAsQJ4If/E7ualUTnpgFyI4hvc70cnTUP6h09lf0NuGlLS3wJI/7GsHyl1ld
 J3VZrY+xSU0Pg1V5u/7xAc57WqPCMEb/fvsqQeCy90fFYEqWmFiEQfprqWM5PEDYGZej
 oJJQ==
X-Gm-Message-State: AOAM532TN39QerxnMht1rjJscnrw1KBrQmNj8nnoScLGBz6acJN5dDTV
 03BDlQBNOtpdHre8Pvb7jpbVeCQO3lhTdulUSUUXhnyJbHeOIDjF19VUhcBliBtFozBrheB2ch9
 mrIiywfJW7AotN7o=
X-Received: by 2002:a1c:a78a:: with SMTP id q132mr2636229wme.27.1596525199425; 
 Tue, 04 Aug 2020 00:13:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwU28a6ttJ2aJC+5mbmvIndrgspI8j9wT6gZaSZisXYawtVA8HjR6WFqfTR82xvklTRrHEovQ==
X-Received: by 2002:a1c:a78a:: with SMTP id q132mr2636210wme.27.1596525199158; 
 Tue, 04 Aug 2020 00:13:19 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7841:78cc:18c6:1e20?
 ([2001:b07:6468:f312:7841:78cc:18c6:1e20])
 by smtp.gmail.com with ESMTPSA id t17sm3088122wmj.34.2020.08.04.00.13.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Aug 2020 00:13:18 -0700 (PDT)
Subject: Re: [PATCH 0/3] aio-posix: keep aio_notify_me disabled during polling
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20200804052804.1165291-1-stefanha@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <31b75005-ff3c-70d0-2ffa-a645f74e5082@redhat.com>
Date: Tue, 4 Aug 2020 09:13:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200804052804.1165291-1-stefanha@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 01:28:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04/08/20 07:28, Stefan Hajnoczi wrote:
> This patch series eliminates ctx->notifier EventNotifier activity when
> aio_poll() is in polling mode. There is no need to use the EventNotifier since
> a polling handler can detect that aio_notify() has been called by monitoring a
> field in memory instead.
> 
> Optimizing out the EventNotifier calls improves null-co random read 4KB
> iodepth=1 IOPS by 18%.
> 
> aio_compute_timeout() is now called twice if aio_poll() needs to block, which
> means an extra qemu_clock_get_ns() call is made when there is an active timer.
> An alternative would be to set timeout = 0 if ctx->notified is true before
> blocking, but going around the event loop again could slow things down more.
> 
> I have not modified docs/spin/aio_notify*.promela because I'm not familiar with
> the SPIN model checker.

I'll take a look.  Looks good apart from more comments, on which I
commented.

Paolo


