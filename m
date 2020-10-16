Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F1BC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 11:45:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AAC12084C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 11:45:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cxfkmsQw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AAC12084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTOAt-0004SI-1M
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 07:45:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33068)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kTO86-0000eR-Od
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 07:42:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56748)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kTO84-000286-36
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 07:42:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602848555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EZI49cXu1JRQsfsCENtdL2NSLsRDgXjIwR9RmpJXTS4=;
 b=cxfkmsQwf41gmoXPJek5fEAiEdagO9+05IDigaki9xpW47KavY7gkluf3gL55Rp7MLVy1L
 0r7UYWMZXGADdR9RQYWyMF8yp/hfAra91Szz/9W78GfnHtCFaYyUs3zXuh07dFibbNNfFY
 NkrNVwKWdBNaRueXUfwox+FQwJNHcQQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-j062vEVPMLqMHeBifvS4nw-1; Fri, 16 Oct 2020 07:42:32 -0400
X-MC-Unique: j062vEVPMLqMHeBifvS4nw-1
Received: by mail-wr1-f72.google.com with SMTP id b11so1306426wrm.3
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2020 04:42:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EZI49cXu1JRQsfsCENtdL2NSLsRDgXjIwR9RmpJXTS4=;
 b=KH/WbKvbLDzcxMJG/Ma582RUGi6QM3z+9uGaxhqdL7rSfd9tVeoRe/IbVtOpsLo894
 gTP5Qg6BK5y0sY55at4DfdxIpXtg0hRrS1wAyg/1+U8ATUhCpGgZ/74E4jUZRwobgSFF
 Atfa8PxFJZlbasOI9hEyIYndEn/NDflnxxJkkHpYaUZ2M3dFcoOzeDCSz8MqhzwzUCbK
 sygHRyN/rdOFVNbEiiFL0oLKoiqsqwoS17P//YLytwJpkyPYTFaTL/31twWEXXfy1JCr
 uegMU6BbzYr7XyepHC6I61LqcalK9sxAf6Mwpm4h3MjGIuEiXv+MolOH1rd3phWoI3oY
 8TpA==
X-Gm-Message-State: AOAM53259UI/hmYURaou8xYJ/rJyyXbOu6F91Nm8BbK5aWPolruiVF/a
 akoRoa1mAfYMQaoXSdAP3+t2o5hUIurPHmrO/T0r7U4pPqTIkTBQLT6nsdt14+feo8TOeDUPk0K
 zQzG2qWsVuTGe+5Y=
X-Received: by 2002:a1c:111:: with SMTP id 17mr3360581wmb.126.1602848551373;
 Fri, 16 Oct 2020 04:42:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw3lW36KzxU/Itdwei9u6cikbC6f8CiN4C1XoDXil5cF0mYGAhxhGTVdBPTu+3z2OXVCqhfJQ==
X-Received: by 2002:a1c:111:: with SMTP id 17mr3360549wmb.126.1602848551037;
 Fri, 16 Oct 2020 04:42:31 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:4e8a:ee8e:6ed5:4bc3?
 ([2001:b07:6468:f312:4e8a:ee8e:6ed5:4bc3])
 by smtp.gmail.com with ESMTPSA id z14sm3177545wrl.75.2020.10.16.04.42.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Oct 2020 04:42:30 -0700 (PDT)
Subject: Re: [PATCH 1/1] Skip flatview_simplify() for cpu vendor zhaoxin
To: FelixCuioc <FelixCui-oc@zhaoxin.com>, Richard Henderson
 <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20201016112933.14856-1-FelixCui-oc@zhaoxin.com>
 <20201016112933.14856-2-FelixCui-oc@zhaoxin.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a971c9db-469f-ddc0-1a27-3e21958f6ff7@redhat.com>
Date: Fri, 16 Oct 2020 13:42:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201016112933.14856-2-FelixCui-oc@zhaoxin.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/16 03:57:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.253, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: TonyWWang-oc@zhaoxin.com, Alex Williamson <alex.williamson@redhat.com>,
 RockCui-oc@zhaoxin.com, qemu-devel@nongnu.org, CobeChen-oc@zhaoxin.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 16/10/20 13:29, FelixCuioc wrote:
> The issue here is that an assinged EHCI device accesses
> an adjacent mapping between the delete and add phases
> of the VFIO MemoryListener.
> We want to skip flatview_simplify() is to prevent EHCI
> device IOVA mappings from being unmapped.

Hi,

there is indeed a bug, but I have already explained last month
(https://mail.gnu.org/archive/html/qemu-devel/2020-09/msg01279.html)
that this patch is conceptually wrong:

1) you're adding host_get_vendor conditioned on compiling the x86
emulator, so you are breaking compilation on non-x86 machines.

2) you're adding a check for the host, but the bug applies to all hosts.
 If there is a bug on x86 hardware emulation, it should be fixed even
when emulating x86 from ARM.  It should also apply to all CPU vendors.

Alex, the issue here is that the delete+add passes are racing against an
assigned device's DMA. For KVM we were thinking of changing the whole
memory map with a single ioctl, but that's much easier because KVM
builds its page tables lazily. It would be possible for the IOMMU too
but it would require a relatively complicated comparison of the old and
new memory maps in the kernel.

Paolo


