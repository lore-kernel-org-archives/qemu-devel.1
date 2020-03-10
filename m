Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D076C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 11:01:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 448522465A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 11:01:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="grRrHKLK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 448522465A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBcdD-0001qc-Ct
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 07:01:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45526)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jBcao-0007vy-IP
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 06:58:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jBcan-0003kX-Jv
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 06:58:34 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33170
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jBcan-0003jr-FX
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 06:58:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583837913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SZH700B7j00PQlDsDjUOLvroZz4mzS5XKsuvb7LeVsk=;
 b=grRrHKLK808UnmfBOARzlmVyGRUALTnljRTEg2RZLXvDnmnleP4JtaMVQW7BLuO7e4k6Lk
 337jcvd3LqG5ZDiKwofH3GZVGY4Xt46XaNzosLKEVr8q0cZjNXqp5VDFW7jW+aKgUAa+//
 eXXj9OOKF9zj1FdSv/6WAoBWVF6A7rc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-zkKMRHKyPl279M1i2wmTJg-1; Tue, 10 Mar 2020 06:58:30 -0400
X-MC-Unique: zkKMRHKyPl279M1i2wmTJg-1
Received: by mail-wm1-f69.google.com with SMTP id a23so217288wmm.8
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 03:58:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SZH700B7j00PQlDsDjUOLvroZz4mzS5XKsuvb7LeVsk=;
 b=SrKQJSgTrXOF8rfp6495YQk6kD+Uo3JWBYsZ4xWzOCGWqrrf422579aemCAYnSUfmd
 Qi6xX2AdJOF0jr+hk1rNI6o+7DPnUiq05o98CL9EnalMVe8HfiRHbBVH5Ft7MSooCfRT
 aEFCHcPzDRN6CSDbf7KDGQrmCUAmasFATty+oxlRQY4TaeTv4EyM7nqwjrS8lg4iBaRO
 WoDTxx/0UW3Ph2oCQ/WhbhNrlc2dg9JScpXIEQh4qsu+4xND55QCWWS4SHj4MQlQGBj7
 Tk+wQyva3F+xHsZIKpFyBBoxM9jL+S9C0g5bUrnZeYXTJDnRNgqsORcA6KMb+BUM69aT
 T1iQ==
X-Gm-Message-State: ANhLgQ0jnSapXDxTPu7BV8sGFMsn2k/yl/00uKboCrf6AnPHk1Kyl3P6
 sy1Bpo4QI/hgW+PsBZ3dm+Jby6ZEtVXN8HhbYn11hEqiEMO+kX3ft5TDHUKKXp3XXQF8eKmqwop
 pBMNzjKXfno+pSd8=
X-Received: by 2002:a1c:cc06:: with SMTP id h6mr1650708wmb.118.1583837907474; 
 Tue, 10 Mar 2020 03:58:27 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsETdVdYlC2o1JeIlMvTK1GQsehzbpYwvmPmmcObrRqvpv0jG0D7W33siTdtcTrpzcU7wrlxA==
X-Received: by 2002:a1c:cc06:: with SMTP id h6mr1650679wmb.118.1583837907234; 
 Tue, 10 Mar 2020 03:58:27 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:4887:2313:c0bc:e3a8?
 ([2001:b07:6468:f312:4887:2313:c0bc:e3a8])
 by smtp.gmail.com with ESMTPSA id j15sm26480746wrp.85.2020.03.10.03.58.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Mar 2020 03:58:26 -0700 (PDT)
Subject: Re: [PATCH v4 3/4] Introduce the NVMM impl
To: Maxime Villard <max@m00nbsd.net>
References: <20200206115731.13552-1-n54@gmx.com>
 <20200206213232.1918-1-n54@gmx.com> <20200206213232.1918-4-n54@gmx.com>
 <e85f03be-60bc-2852-7856-91790ba5958b@redhat.com>
 <ca1210a3-2ea5-3862-c4fa-bdcd5624fe29@m00nbsd.net>
 <CABgObfZjnFFV3hosrP+sf5d3KmPPGuFJZo-oY5=u340wtxLYGg@mail.gmail.com>
 <a646f01d-fcf5-5984-d7ea-ccbb9a20ce2b@m00nbsd.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <24fe7b93-8a34-e5d7-18b5-0f7607221ad3@redhat.com>
Date: Tue, 10 Mar 2020 11:58:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <a646f01d-fcf5-5984-d7ea-ccbb9a20ce2b@m00nbsd.net>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, slp@redhat.com,
 qemu-devel@nongnu.org, jmcneill@invisible.ca, Kamil Rytarowski <n54@gmx.com>,
 philmd@redhat.com, rth <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/03/20 07:45, Maxime Villard wrote:
> > It reproduces the existing logic found in whpx-all.c, and if there is
> >
> 
> It's buggy there too and it has to be fixed in the hypervisor so it
> can't be done at the same time I'm both. KVM does it right by having
> a flag ("immediate_exit") that is set by the signal handler and
> checked by the hypervisor.

For what it's worth, WHPX's whpx_kick_vcpu invokes a "cancel entry" API
that is probably similar to what KVM does, so there's nothing to do there.

Paolo


