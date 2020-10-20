Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B900C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 09:05:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EFE6222C8
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 09:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KrOwyS5X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EFE6222C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUnaS-0007L7-C9
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 05:05:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52120)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kUnYm-0006Df-W8
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 05:04:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28447)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kUnYk-0003A8-MY
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 05:04:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603184636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8AWWte0juF6bG8L0cZv3PHTHY7HMoQjpTrwCjJ0jy8s=;
 b=KrOwyS5XBCpUH7I03esTaqK83znlkIbH8PLPcIhcMAz6Y/q4SVfUTz/35EXprw83feXIQY
 9und5Xvvj52ARIa0mtgrLqhyEeUBKxBlrbKYsaoa8ObcAxthJ+dKW/B31+Uo3g9eWANVCT
 XPLeek7tqn6aBjYQrDk/kHcdd/jZqEA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-D5lLpNW6O2ezmUnKC0w1YQ-1; Tue, 20 Oct 2020 05:03:54 -0400
X-MC-Unique: D5lLpNW6O2ezmUnKC0w1YQ-1
Received: by mail-wm1-f71.google.com with SMTP id f191so174667wmf.9
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 02:03:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8AWWte0juF6bG8L0cZv3PHTHY7HMoQjpTrwCjJ0jy8s=;
 b=N2AwrOQzav4h6ro3iiIohw7KAZCOVx0pBK6fX/rgsLrP78AAb9cFn/xhjutr4QaGFz
 v1druN2hcwRQmjuYrAFkFc3/4ZR+IiuOrDY3OWdJw0/5q23zvFL0PolMPkHfG8PGKDO4
 J0VK7kbBDEIoWWwNtyux7P45PoXABxkYDZLE2G8FVVkALac1lC3fwddLXmoIs895ReKz
 JG+x7w5kAMiyP7t4uTnr+d/4+1BApSOviqTGiwuz8lZxPozejc2jW58MlqZi+Np4T0b9
 mrFzymmd6dIAb7XjJ3C8LBESpVpIbNOXM3BQkb5kKkHiMxuzqUkc5ubhiilT5f/VMYmF
 0V2g==
X-Gm-Message-State: AOAM532w441u8R2Yh90Pp7lNL9YkTCtzdTmoBm+QNf09UIJ43J/ewfBv
 p1lmlu0i1sIRR5VG3ueBbo+nMZ6v0mdLSss4UxgJMTU408LdFeCWLVoroIo4/7RYNFPTskB0J/d
 jKmbK2sQjlcAa3fA=
X-Received: by 2002:adf:ee4c:: with SMTP id w12mr2213355wro.22.1603184633224; 
 Tue, 20 Oct 2020 02:03:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxJ5Kq4XpmOcih4vAIW3mYyVUMyrsJOaXrREq5ff77BJBOtimdowrNFKrDQNWOQGUrHVA0BaA==
X-Received: by 2002:adf:ee4c:: with SMTP id w12mr2213334wro.22.1603184633061; 
 Tue, 20 Oct 2020 02:03:53 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id v6sm2018287wrp.69.2020.10.20.02.03.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2020 02:03:52 -0700 (PDT)
Subject: Re: [PATCH v5] sev: add sev-inject-launch-secret
To: tobin@linux.ibm.com, qemu-devel@nongnu.org
References: <20201015143713.14682-1-tobin@linux.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2f1be055-58c8-dcf8-debc-8956636d8ef8@redhat.com>
Date: Tue, 20 Oct 2020 11:03:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201015143713.14682-1-tobin@linux.ibm.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:15:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: thomas.lendacky@amd.com, brijesh.singh@amd.com,
 Eduardo Habkost <ehabkost@redhat.com>, jejb@linux.ibm.com, tobin@ibm.com,
 dgilbert@redhat.com, berrange@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 15/10/20 16:37, tobin@linux.ibm.com wrote:
> -static void *gpa2hva(MemoryRegion **p_mr, hwaddr addr, Error **errp)
> +void *gpa2hva(MemoryRegion **p_mr, hwaddr addr, uint64_t size, Error **errp)
>  {
>      MemoryRegionSection mrs = memory_region_find(get_system_memory(),
> -                                                 addr, 1);
> +                                                 addr, size);

You need to check size against mrs.size and fail if mrs.size is smaller.
 Otherwise, the ioctl can access memory out of range.

Sorry Eduardo for the late review.

Paolo


