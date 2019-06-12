Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E610C31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 15:28:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62DEB2082C
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 15:28:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62DEB2082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33098 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hb5Ak-0008Qu-Nw
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 11:28:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35320)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hb59V-0007qu-Kl
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 11:27:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hb59U-0005KT-Rq
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 11:27:05 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35397)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hb59U-0004n7-LL
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 11:27:04 -0400
Received: by mail-wm1-f66.google.com with SMTP id c6so7015439wml.0
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2019 08:26:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=a6iJZbRvVPKsc8G+vf1IBbLJCfVcQnuQ3UN2huQcDqU=;
 b=VuKso8yJ7Et5tZbHhX+m0uKPLYm5urZdtyZPAcjQcmYs3hpl5zlE0cijGTU+uNuI1G
 vrlu73mss6HsE7nae2I9GCD0DyBvJaxVZ4m+yRlXM8DtXn4TAmvJs2E4CN+aJet7kdL8
 67yJGn2K1/FUbkZl4qO/vvrEh7DJJ6CBhYQr0Nil8UKldjxg6D58wjEzXS2v+pzL8jV6
 ZpZekRJg+HVXohPiKhsVwc1121+qFAqoIw33nYqWKA8xA3SkUKtObWmScsixs+50WmK3
 RbITZSRx8Iw1y0itQ33zm4i7ZCSmHF0vGAdahFvTE4hrbDLnz/39GxmO9AvUuBijO4fz
 dKGQ==
X-Gm-Message-State: APjAAAXKDeM1kLHnR2RQiwEonBnWkYeFlmPNWzFMtPv3FVso05J7VcGb
 dkcfg9RPIO49YDoyXyCpJE4Uhg==
X-Google-Smtp-Source: APXvYqwQcQz8C2lYxo8/qkTq9ZYDExa+dToXKWndd9NOIJ0L2Ky1/Wx3VqDDM5R48hOFZbLR4hYI6A==
X-Received: by 2002:a1c:1fc2:: with SMTP id
 f185mr23644268wmf.154.1560353197499; 
 Wed, 12 Jun 2019 08:26:37 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:49d3:a711:c5a3:8ebf?
 ([2001:b07:6468:f312:49d3:a711:c5a3:8ebf])
 by smtp.gmail.com with ESMTPSA id m21sm59934wmc.1.2019.06.12.08.26.36
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 12 Jun 2019 08:26:36 -0700 (PDT)
To: Liran Alon <liran.alon@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20190416125912.44001-1-liran.alon@oracle.com>
 <20190418094101.GA23876@stefanha-x1.localdomain>
 <17635C1F-A477-4C0F-B052-2948D853E6CD@oracle.com>
 <20190425083819.GE30231@stefanha-x1.localdomain>
 <20190425135319-mutt-send-email-mst@kernel.org>
 <4E3C459B-630A-4636-A660-11756467A011@oracle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5a6bd5f7-6345-efa6-1a29-5fde5d24e5de@redhat.com>
Date: Wed, 12 Jun 2019 17:26:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <4E3C459B-630A-4636-A660-11756467A011@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH v2 0/3] vhost-scsi: Support migration
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
Cc: bijan.mottahedeh@oracle.com, Stefan Hajnoczi <stefanha@gmail.com>,
 rth@twiddle.net, mtosatti@redhat.com, qemu-devel@nongnu.org,
 nir.weiner@oracle.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/06/19 01:40, Liran Alon wrote:
> Any news on when this patch-series is expected to be merged to upstream QEMU?
> It was accepted 2 months ago.

It was merged on June 6th.

Paolo

