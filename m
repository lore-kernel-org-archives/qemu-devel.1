Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73EEEC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 09:37:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F3F720874
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 09:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EEg2IDYR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F3F720874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqveh-0008Ls-GF
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 05:37:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54768)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jqvdx-0007bO-CJ
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 05:36:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23091
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jqvdv-0001Pv-KE
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 05:36:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593682590;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WKTSvGhcVwP4Xg9aMvF/8Qq6Qacp6lrwLZFLQKSaNbs=;
 b=EEg2IDYRheSRKhFd6ARREGJPvcWdJe59w3sOs3c0PZTYpThtqScRbt7WkBhx3BAVqzQOn8
 N+hQ2Cno1s2U1kKdr6os5E4HI1I0VyI2mMauSBLggYXUMmMoyq3r/VbmOMb2YsN5kqbLg+
 VXFOxqrxTHjcUx2qjfSKVmnaYONLmTg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-dqrOxWh9NoSc8ZtVBM9buw-1; Thu, 02 Jul 2020 05:36:26 -0400
X-MC-Unique: dqrOxWh9NoSc8ZtVBM9buw-1
Received: by mail-wm1-f71.google.com with SMTP id v24so27680843wmh.3
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2020 02:36:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WKTSvGhcVwP4Xg9aMvF/8Qq6Qacp6lrwLZFLQKSaNbs=;
 b=k3PSbyWycyZelzSR+Pd4hWeLH7H90VjEVtMs0ThRgMrDAh32xAkOIi5LKCrrxbv47F
 yn6zu830212hGY51bEEnJGjqsDCSvPy/nS4cQDaePrpS49Sq0L8xb38SPDOVeAz1Po/U
 0+Aedg7csX8Ri4AmAeYwdU7Sb8IfyyIpwL9+DBiRUqxaObfLzFrw7/8ZvU/AZHC9M5iV
 XVIgeqs6MWEfkYGCCL7VuE/ziEvyGyvulSgrkx+SywfY2x3lO3rPB4655/UtiTzLJxoQ
 TqPjzJkKAJgj28loew2/yuNKFnuZ4KtBvEtm/npFZumjlSYh8H3ltNxdjnK5s4lPZXpk
 8RGw==
X-Gm-Message-State: AOAM530FpUo+Ufum6Krz+rMqN+qKnVvzQA6mQcPWaoAagxrVyWLtyKI3
 1JssnX93+GNVkhaY8mcVPRceWsOPiiBbkdjuQDcw3S4ZiuXPEq+mePO3qe+3fnoDBSn6sWNRjK9
 S3ctD4Hk5EHFAznI=
X-Received: by 2002:adf:e74e:: with SMTP id c14mr32366133wrn.143.1593682585729; 
 Thu, 02 Jul 2020 02:36:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJztVy7X1Fi63PU+Zhn3DrfKcVPMcI5dpSP9dvXbokmdTzHhDNJeFmnmXwefWE5mtR9zzuYLqw==
X-Received: by 2002:adf:e74e:: with SMTP id c14mr32366106wrn.143.1593682585523; 
 Thu, 02 Jul 2020 02:36:25 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:2cad:376b:7d21:868e?
 ([2001:b07:6468:f312:2cad:376b:7d21:868e])
 by smtp.gmail.com with ESMTPSA id 1sm9836900wmf.0.2020.07.02.02.36.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2020 02:36:24 -0700 (PDT)
Subject: Re: [PATCH v3] ati-vga: check address before reading configuration
 bytes (CVE-2020-13791)
To: Michael Tokarev <mjt@tls.msk.ru>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20200604105524.46158-1-ppandit@redhat.com>
 <20200604074539-mutt-send-email-mst@kernel.org>
 <88d6e41e-c486-4a35-af43-84018491071f@redhat.com>
 <20200604075931-mutt-send-email-mst@kernel.org>
 <1157d3ab-9c97-85a8-7700-4faccfa0941e@msgid.tls.msk.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1258aa9c-c536-d6b4-c401-3ce41c1e5da3@redhat.com>
Date: Thu, 2 Jul 2020 11:36:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1157d3ab-9c97-85a8-7700-4faccfa0941e@msgid.tls.msk.ru>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 04:00:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Prasad J Pandit <pjp@fedoraproject.org>, Yi Ren <c4tren@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, P J P <ppandit@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Ren Ding <rding@gatech.edu>,
 Hanqing Zhao <hanqing@gatech.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/07/20 09:54, Michael Tokarev wrote:
> [Please excuse me for top-posting, I want to preserve somewhat old context]
> 
> So, is this CVE-2020-13791 issue fixed by the fix for CVE-2020-13754,
> by this commit:
>  https://git.qemu.org/?p=qemu.git;a=commit;h=5d971f9e672507210e77d020d89e0e89165c8fc9

Yes, it is.

Paolo


