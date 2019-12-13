Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D09FC2D0CC
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:27:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2017421655
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:27:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ijsFaTAm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2017421655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iflZQ-00007Z-I5
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 09:05:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54778)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iflYF-00087C-TJ
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 09:04:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iflYD-0003vf-0z
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 09:04:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24731
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iflYC-0003sy-Sr
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 09:04:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576245851;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LnbP/jcQbjdoAULcGoja+4905KAb6Cecgp+1N+DQ5Vg=;
 b=ijsFaTAmjRNJyftosM3BKmFkXQRZUgYX4t0cw7ODh00ANdlzmM4jf0gtLT31YIKrBafgAz
 6bqMbM+d5FM8euAGrppcN1z7zXOFOnutoMF8THdzEgXtvfxS/jaVSze1wgn2M/rfXSDm5c
 enamisoSbZItlfKdALlXHhk6EiKYnBU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-nG1dpW7fNs-Xakh5FAcF3w-1; Fri, 13 Dec 2019 09:04:08 -0500
Received: by mail-wm1-f71.google.com with SMTP id b131so2369516wmd.9
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2019 06:04:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LnbP/jcQbjdoAULcGoja+4905KAb6Cecgp+1N+DQ5Vg=;
 b=asrLJxHLYRluPWFLs+CA7ioob5ri244QtaGq/clOnsDDZr5PMsOi3zZ+43GlaU4s00
 FxWPhq5efFQaKPc5xoV/INcVKDCqQ1eJxrllD7+Skfa8X4gRwBMS/yCLQ/a+s7xImq9q
 g85p+wFqRLT0cwayI7i9Qh1UQ3EIRZ4cdWvwepNUTa6M7lBALnMvY1RSn5yIEdw4eOBb
 iifaQpdW1HlAGdt8AZqCcdzkKFGIo2qNd8UevLPswG3PQLtJZa1Ayc6srw7TM6sLTHmn
 O2J3OczONX70a2+IzoaV6AyFj69cnDEd5Y9O5Tg+5/J92CLajQvmwpEV09l+93ku8QJh
 tjXw==
X-Gm-Message-State: APjAAAVOFGqUHaWF6uW/wwjRUGOLW8vuuDQa4hP2YdYUaE80XIXHJDF9
 YKxT9uVJUgFZusOAYBJY48FQ3biZL9b6QrK39bULHRzvl2aIMZgSt/QYR2et58h2ZC6/1yoggoH
 Rg7kMPB9fxHODZ78=
X-Received: by 2002:a1c:640a:: with SMTP id y10mr5403900wmb.14.1576245846830; 
 Fri, 13 Dec 2019 06:04:06 -0800 (PST)
X-Google-Smtp-Source: APXvYqy8luqq1WdEc14Lc5nK83EdHj3SA9mbhUKaoS9BCZmJG3rplZ8wworApyaVwDLqFWIpa2PU8Q==
X-Received: by 2002:a1c:640a:: with SMTP id y10mr5403860wmb.14.1576245846560; 
 Fri, 13 Dec 2019 06:04:06 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9?
 ([2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9])
 by smtp.gmail.com with ESMTPSA id s82sm11038871wms.28.2019.12.13.06.04.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Dec 2019 06:04:06 -0800 (PST)
Subject: Re: [PATCH 0/2] rcu_read auto macro use
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, cota@braap.org, rkagan@virtuozzo.com
References: <20191213131931.143878-1-dgilbert@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6e3d6d39-31ce-c10e-bcb2-b564e5a1cdae@redhat.com>
Date: Fri, 13 Dec 2019 15:04:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191213131931.143878-1-dgilbert@redhat.com>
Content-Language: en-US
X-MC-Unique: nG1dpW7fNs-Xakh5FAcF3w-1
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

On 13/12/19 14:19, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Hi,
>   A couple more uses of the rcu_read macros; in qsp and
> hyperv (neither of which list maintainers, so I guess
> best through RCU).
> 
> The hyperv case saves a temporary.
> The qsp case uses an rcu_read_lock around the lifetime
> of a snapshot and carefully comments that; but now
> it's automatic.
> 
> [Hyperv not tested]

Queued, thanks.

Paolo

> Dave
> 
> Dr. David Alan Gilbert (2):
>   hyperv: Use auto rcu_read macros
>   qsp: Use WITH_RCU_READ_LOCK_GUARD
> 
>  hw/hyperv/hyperv.c | 22 +++++++++-------------
>  util/qsp.c         | 22 ++++++++++------------
>  2 files changed, 19 insertions(+), 25 deletions(-)
> 


